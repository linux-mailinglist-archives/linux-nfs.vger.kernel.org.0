Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A8D38E8E6
	for <lists+linux-nfs@lfdr.de>; Mon, 24 May 2021 16:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhEXOo1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 May 2021 10:44:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:40622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233022AbhEXOo0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 24 May 2021 10:44:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621867377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oyCraAAtXrZ48Fn8CBGwDhVCjV34QqFZgAv/Uzo73YY=;
        b=rAkeVdqswKxyWqd7oM7OEksPPKu5zirDkANuUfGEO0oHGvpOHr/ASLuDORHM33xnBB9j/+
        j6QfVfrkkUoOndrsxnO/rrRHjFH+cqxNZgaAJVHc6dFhqty2Jl0VC3LeOaOevvh9EcjD7f
        clweAIaGcWn+Zih0708RCYSZ/IZQlus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621867377;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oyCraAAtXrZ48Fn8CBGwDhVCjV34QqFZgAv/Uzo73YY=;
        b=C5fP2dT01D287XZGS3Xkd8MlV7/hbsWxDWhkaTopPGGSnYt8KKTEZsyksmLwS2Ke0w9JLl
        Bk7rIV2m/lPwSqAA==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B625BADE7;
        Mon, 24 May 2021 14:42:57 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-nfs@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>,
        "J . Bruce Fields" <bfields@redhat.com>,
        "Yong Sun (Sero)" <yosun@suse.com>
Subject: [PATCH pynfs 2/3] server: Allow to print JSON format
Date:   Mon, 24 May 2021 16:42:50 +0200
Message-Id: <20210524144251.30196-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524144251.30196-1-pvorel@suse.cz>
References: <20210524144251.30196-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 nfs4.0/testserver.py |  7 ++++++-
 nfs4.1/testmod.py    | 40 +++++++++++++++++++++++++++++++++++++++-
 nfs4.1/testserver.py |  6 +++++-
 3 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/nfs4.0/testserver.py b/nfs4.0/testserver.py
index 0ef010a..f2c4156 100755
--- a/nfs4.0/testserver.py
+++ b/nfs4.0/testserver.py
@@ -85,6 +85,8 @@ def scan_options(p):
                  help="Skip final cleanup of test directory")
     p.add_option("--outfile", "--out", default=None, metavar="FILE",
                  help="Store test results in FILE [%default]")
+    p.add_option("--jsonout", "--json", default=None, metavar="FILE",
+                 help="Store test results in JSON format [%default]")
     p.add_option("--xmlout", "--xml", default=None, metavar="FILE",
                  help="Store test results in xml format [%default]")
     p.add_option("--debug_fail", action="store_true", default=False,
@@ -378,8 +380,11 @@ def main():
     if fail:
         print("\nWARNING: could not clean testdir due to:\n%s\n" % err)
 
-    if opt.xmlout is not None:
+    if opt.jsonout is not None:
+        testmod.json_printresults(tests, opt.jsonout)
+    elif opt.xmlout is not None:
         testmod.xml_printresults(tests, opt.xmlout)
+
     if nfail < 0:
         sys.exit(3)
     if nfail > 0:
diff --git a/nfs4.1/testmod.py b/nfs4.1/testmod.py
index e368853..4b4ed24 100644
--- a/nfs4.1/testmod.py
+++ b/nfs4.1/testmod.py
@@ -13,6 +13,7 @@ import re
 import sys
 import time
 from traceback import format_exception, print_exc
+import json
 import xml.dom.minidom
 import datetime
 
@@ -467,6 +468,43 @@ def printresults(tests, opts, file=None):
           (count[SKIP], count[FAIL], count[WARN], count[PASS]), file=file)
     return count[FAIL]
 
+def json_printresults(tests, file_name, suite='all'):
+    with open(file_name, 'w') as fd:
+        failures = 0
+        skipped = 0
+        total_time = 0
+        data = {}
+        data["tests"] = len(tests)
+        data["errors"] = 0
+        data["timestamp"] = str(datetime.datetime.now())
+        data["name"] = suite
+        data["testcase"] = []
+        for t in tests:
+            test = {
+                "name": t.name,
+                "classname": t.suite,
+                "time": str(t.time_taken),
+            }
+
+            total_time += t.time_taken
+            if t.result == TEST_FAIL:
+                failures += 1
+                test["failure"] = {
+                        "message" : t.result.msg,
+                        "err" : ''.join(t.result.tb)
+                }
+            elif t.result == TEST_OMIT:
+                skipped += 1
+                test["skipped"] = 1
+
+            data["testcase"].append(test)
+
+        data["failures"] = failures
+        data["skipped"] = skipped
+        data["time"] = total_time
+
+        fd.write(json.dumps(data, indent=4, sort_keys=True))
+
 def xml_printresults(tests, file_name, suite='all'):
     with open(file_name, 'w') as fd:
         failures = 0
@@ -484,7 +522,7 @@ def xml_printresults(tests, file_name, suite='all'):
             testsuite.appendChild(testcase)
             testcase.setAttribute("name", t.name)
             testcase.setAttribute("classname", t.suite)
-            testcase.setAttribute("time", str(t.time_taken))
+            testcase.setAttribute("time", t.time_taken)
 
             total_time += t.time_taken
             if t.result == TEST_FAIL:
diff --git a/nfs4.1/testserver.py b/nfs4.1/testserver.py
index d3c44c7..085f007 100755
--- a/nfs4.1/testserver.py
+++ b/nfs4.1/testserver.py
@@ -68,6 +68,8 @@ def scan_options(p):
                  help="Skip final cleanup of test directory")
     p.add_option("--outfile", "--out", default=None, metavar="FILE",
                  help="Store test results in FILE [%default]")
+    p.add_option("--jsonout", "--json", default=None, metavar="FILE",
+                 help="Store test results in JSON format [%default]")
     p.add_option("--xmlout", "--xml", default=None, metavar="FILE",
                  help="Store test results in xml format [%default]")
     p.add_option("--debug_fail", action="store_true", default=False,
@@ -363,7 +365,9 @@ def main():
     if fail:
         print("\nWARNING: could not clean testdir due to:\n%s\n" % err)
 
-    if opt.xmlout is not None:
+    if opt.jsonout is not None:
+        testmod.json_printresults(tests, opt.jsonout)
+    elif opt.xmlout is not None:
         testmod.xml_printresults(tests, opt.xmlout)
 
 if __name__ == "__main__":
-- 
2.31.1

