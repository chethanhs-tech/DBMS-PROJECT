import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

serve(async (req) => {
  // Handle CORS preflight requests
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  try {
    const { productName, category, query } = await req.json();

    const geminiApiKey = Deno.env.get('GEMINI_API_KEY');
    
    // Generate an optimized prompt
    const prompt = `A high quality, ultra-realistic studio macro photography of a single ${productName || query} grocery item. Strictly a single product isolated on a pure clean white studio background. E-commerce catalog style, bright professional lighting, 8k resolution. NO shelves, NO store background, NO extra items, NO text.`;

    let imageUrl = '';

    if (geminiApiKey) {
      // Note: Gemini text-to-image might be restricted to specific models. 
      // If we don't have access to imagen-3.0-generate-001, we will fallback to Pollinations.ai or Unsplash.
      // But we attempt a robust approach. Since Gemini image API is currently only widely available via Vertex AI or specific endpoints,
      // we use an intelligent fallback pipeline.
      
      // Attempting Gemini (if it fails, we fall back)
      // For demonstration in Edge Functions, we will use Pollinations.ai which accepts our AI prompt directly 
      // without needing complex key setup, but we use the Gemini API to ENHANCE the prompt first.
      
      const textResponse = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=${geminiApiKey}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          contents: [{ parts: [{ text: `
You are an AI Image Validation & Prompt Generation Expert for an e-commerce grocery store.
Product Details:
- Name: ${productName || query}
- Category: ${category}

Task 1: Generate a highly descriptive image generation prompt for a single unit of this specific product. It MUST be an ultra-realistic macro studio photo isolated on a pure white background. Strictly avoid shelves, aisles, or multiple unrelated items. The focus must be entirely on the ${productName || query}.
Task 2: Perform semantic validation. Evaluate if the product name strongly matches its category. Provide a semantic similarity score (1-100).
Task 3: Category Matching. Does the product make sense in the given category? (true/false)

Return a strictly valid JSON object with the following keys:
{
  "optimizedPrompt": "string",
  "semanticScore": number,
  "categoryMatch": boolean,
  "qualityFilterPassed": boolean
}
` }] }]
        })
      });
      
      if (textResponse.ok) {
        const data = await textResponse.json();
        let jsonText = data.candidates?.[0]?.content?.parts?.[0]?.text?.trim() || "";
        // Clean up markdown code blocks if present
        if (jsonText.startsWith('\`\`\`json')) {
          jsonText = jsonText.replace(/^\`\`\`json/, '').replace(/\`\`\`$/, '').trim();
        } else if (jsonText.startsWith('\`\`\`')) {
          jsonText = jsonText.replace(/^\`\`\`/, '').replace(/\`\`\`$/, '').trim();
        }
        
        let optimizedPrompt = prompt;
        try {
          const parsed = JSON.parse(jsonText);
          optimizedPrompt = parsed.optimizedPrompt || optimizedPrompt;
          
          if (parsed.semanticScore < 50 || !parsed.categoryMatch || !parsed.qualityFilterPassed) {
             console.warn(`[Gemini Validation Failed] Score: ${parsed.semanticScore}, CategoryMatch: ${parsed.categoryMatch}. Falling back to default prompt.`);
             optimizedPrompt = `A single ${productName || query}, ultra-realistic studio photography, isolated on pure white background, e-commerce style, bright lighting, no shelves, no background objects, 8k`;
          }
        } catch (e) {
          console.error("Failed to parse Gemini JSON:", jsonText);
        }
        
        // Use pollinations with the Gemini optimized prompt
        imageUrl = `https://image.pollinations.ai/prompt/${encodeURIComponent(optimizedPrompt)}?width=800&height=800&nologo=true&seed=${Math.floor(Math.random() * 1000000)}`;
      } else {
        // Fallback if Gemini fails
        imageUrl = `https://image.pollinations.ai/prompt/${encodeURIComponent(prompt)}?width=800&height=800&nologo=true&seed=${Math.floor(Math.random() * 1000000)}`;
      }
    } else {
      // Fallback without Gemini API
      imageUrl = `https://image.pollinations.ai/prompt/${encodeURIComponent(prompt)}?width=800&height=800&nologo=true&seed=${Math.floor(Math.random() * 1000000)}`;
    }

    return new Response(
      JSON.stringify({ imageUrl }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    );
  } catch (error) {
    return new Response(
      JSON.stringify({ error: error.message }),
      { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    );
  }
});
