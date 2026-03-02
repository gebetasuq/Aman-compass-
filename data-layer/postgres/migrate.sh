#!/bin/bash
psql $DATABASE_URL -f init.sql
