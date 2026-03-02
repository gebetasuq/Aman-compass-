import numpy as np

def add_laplace_noise(value, epsilon, sensitivity=1.0):
    """Add Laplace noise for differential privacy."""
    noise = np.random.laplace(0, sensitivity/epsilon)
    return value + noise

def anonymize_query(query_text, emirate):
    # Remove PII, then return aggregated tuple
    return (emirate, len(query_text))
