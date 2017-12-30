#+nil
(push (lambda (&rest args)
        (apply #'swank:ed-in-emacs args)
        t)
      sb-ext:*ed-functions*)
