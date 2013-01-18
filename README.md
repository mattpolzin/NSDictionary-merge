NSDictionary-merge
==================

NSDictionary, NSArray, and NSSet categories that offer a method to recursively merge two objects together such that entries which exist for the same key in two dictionaries are merged as well rather than overwritten.

NSMutableArray-merge caveat
---------------------------

This project was created for the purpose of merging dictionaries created from plists. For this reason, although the NSMutableArray merging code allows duplicate entries during merging (via a BOOL arg), the default behavior that is used during a recursive merge of a dictionary that contains arrays is to only create unique entries in the merged array.