class ModuleA(object):
    def __init__(self, alpha):
        self.alpha = alpha

    def __repr__(self):
        return f"ModuleA, alpha = {self.alpha}"


class ModuleB(object):
    def __init__(self, beta):
        self.beta = beta

    def __repr__(self):
        return f"ModuleB, beta = {self.beta}"
