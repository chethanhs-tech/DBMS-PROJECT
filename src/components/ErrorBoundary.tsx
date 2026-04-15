import React, { Component, ErrorInfo, ReactNode } from 'react';
import { AlertTriangle, RotateCcw } from 'lucide-react';

interface Props {
  children: ReactNode;
  fallbackMessage?: string;
}

interface State {
  hasError: boolean;
  error: Error | null;
}

export default class ErrorBoundary extends Component<Props, State> {
  public state: State = {
    hasError: false,
    error: null,
  };

  public static getDerivedStateFromError(error: Error): State {
    return { hasError: true, error };
  }

  public componentDidCatch(error: Error, errorInfo: ErrorInfo) {
    console.error('ErrorBoundary caught:', error, errorInfo);
  }

  private handleRetry = () => {
    this.setState({ hasError: false, error: null });
  };

  public render() {
    if (this.state.hasError) {
      return (
        <div className="flex flex-col items-center justify-center min-h-[400px] p-8 text-center space-y-6">
          <div className="h-20 w-20 rounded-full bg-orange-500/10 flex items-center justify-center">
            <AlertTriangle className="h-10 w-10 text-orange-500" />
          </div>
          <div className="space-y-2">
            <h2 className="text-2xl font-black tracking-tight">Something went wrong</h2>
            <p className="text-muted-foreground font-medium max-w-md">
              {this.props.fallbackMessage || 'This section encountered an error. Try refreshing or contact support.'}
            </p>
            {this.state.error && (
              <p className="text-xs text-muted-foreground/60 font-mono mt-2 max-w-lg break-all">
                {this.state.error.message}
              </p>
            )}
          </div>
          <button
            onClick={this.handleRetry}
            className="flex items-center gap-2 px-6 py-3 bg-primary text-primary-foreground rounded-2xl font-black shadow-lg shadow-primary/20 hover:scale-105 transition-transform"
          >
            <RotateCcw className="h-4 w-4" />
            Try Again
          </button>
        </div>
      );
    }

    return this.props.children;
  }
}
