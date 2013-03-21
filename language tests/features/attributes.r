#! object attributes in R -- R ref manual, page 7

#! NULL object's attributes are NULL
is.null(attributes(NULL))

#! TRUE object's attributes are NULL
is.null(attributes(TRUE))

#! FALSE object's attributes are NULL
is.null(attributes(FALSE))

#! NULL object cannot have attributes
#!e invalid (NULL) left side of assignment
attributes(NULL)$xyz = 67

#! TRUE object cannot have attributes
#!e target of assignment expands to non-language object
attributes(TRUE)$xyz = 67

#! FALSE object cannot have attributes
#!e target of assignment expands to non-language object
attributes(FALSE)$xyz = 67