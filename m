Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0047D49EB52
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 20:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245702AbiA0Tt5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 14:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245708AbiA0Tt4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 14:49:56 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57444C061747
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 11:49:56 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id h25so2518872qtm.1
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 11:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pzZX1cVE9H60Q9bqhWS3/JXUmBjeHDoCXI05lUqW7Os=;
        b=gtEpdKZkiE9aOh38bgHLGCWZTjl2pnqq168NLdP6gypnoh2kqCd8aT8cXnh4XQrruT
         Jx+jckcheEduUr2cn910dhaW9MrhQ+Bfv/vpjX07unv/JrXIXauVnvlJyy+NbVtweN3q
         IBu42A1Anga3ANqoiZ8un3ePMhMDErEYbZnB2DmIAY7ndiC+SDAZHuL+ZtJ5PMb9A7Z7
         PMYohxo1Ekki+sMcmSrMO4yBKBtksJI6GaKGXYmeyLZWrY9nQYLwJWdwUxitkA7Ye+IW
         r9DvH+y7fjvkgs6BeYj5dzkeJsavLGd6ibO4cNWa6y6eX+eY4Ha5DtlJs9GZbwqKxeaQ
         0sqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pzZX1cVE9H60Q9bqhWS3/JXUmBjeHDoCXI05lUqW7Os=;
        b=D2vDU82yoOoSwNyk3joGouEWukYAeuCD3zuy+MmNGSYDVcHU/3mJKIQTdDLM2vuIMZ
         h5B+x9K/eQm/BfOnTtJIFNPN4WnokxyCit7Y05DhfiORISOFP32KSS8Xt4fkyFiIK98q
         49EIxwBwpI0dSj50wyebY6DRMKZpHVfVq0sDnbFKOPSf73VLr1bv+qbDXDs8W96PRm8O
         tFsxwxUPSxo9AHqVvUTqrzSRf+qvFRgE3QLeFBl+zH6vVbwAQMBGbgBW+Z7TMsYHhVUG
         n26bcyApSjOKqSjboZh7qjT4ufYWj1WOVhmYCtUgzJt/Rujxy30HU4Muit0OGyBNF+BC
         WBxw==
X-Gm-Message-State: AOAM530131ATTEzdRSN5juBiEwVXNjTE8Ic1TJbOd1xrgKDl57Fo0Ix/
        F6HELiz0R1PRhUtZvWmt5QbPhLxtM1Q=
X-Google-Smtp-Source: ABdhPJytVeVu9kvKVZJXYmmmo5+GYj4FxCNxSfNmEnC0IffTeRcUPg0ASAWgG3MYZ7eS/AG68Js9sA==
X-Received: by 2002:ac8:5f0e:: with SMTP id x14mr4019902qta.234.1643312995438;
        Thu, 27 Jan 2022 11:49:55 -0800 (PST)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id g7sm1836483qkc.104.2022.01.27.11.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 11:49:55 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v7 2/9] rpcctl: Add a command for printing xprt switch information
Date:   Thu, 27 Jan 2022 14:49:45 -0500
Message-Id: <20220127194952.63033-3-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220127194952.63033-1-Anna.Schumaker@Netapp.com>
References: <20220127194952.63033-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This combines the information found in xprt_switch_info with a subset of
the information found in each xprt subdirectory

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 tools/rpcctl/rpcctl.py | 68 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index 9737ac4a9740..0d922f1acf21 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -1,5 +1,6 @@
 #!/usr/bin/python3
 import argparse
+import collections
 import pathlib
 import sys
 
@@ -14,6 +15,70 @@ if not sunrpc.is_dir():
     print("ERROR: sysfs does not have sunrpc directory")
     sys.exit(1)
 
+def read_addr_file(path):
+    try:
+        with open(path, 'r') as f:
+            return f.readline().strip()
+    except:
+        return "(enoent)"
+
+def read_info_file(path):
+    res = collections.defaultdict(int)
+    try:
+        with open(path) as info:
+            lines = [ l.split("=", 1) for l in info if "=" in l ]
+            res.update({ key:int(val.strip()) for (key, val) in lines })
+    finally:
+        return res
+
+
+class Xprt:
+    def __init__(self, path):
+        self.path = path
+        self.id = int(path.stem.split("-")[1])
+        self.type = path.stem.split("-")[2]
+        self.dstaddr = read_addr_file(path / "dstaddr")
+
+    def __lt__(self, rhs):
+        return self.id < rhs.id
+
+    def small_str(self):
+        return f"xprt {self.id}: {self.type}, {self.dstaddr}"
+
+
+class XprtSwitch:
+    def __init__(self, path):
+        self.path = path
+        self.id = int(path.stem.split("-")[1])
+        self.info = read_info_file(path / "xprt_switch_info")
+
+        self.xprts = [ Xprt(p) for p in self.path.iterdir() if p.is_dir() ]
+        self.xprts.sort()
+
+    def __lt__(self, rhs):
+        return self.id < rhs.id
+
+    def __str__(self):
+        switch =  f"switch {self.id}: " \
+                  f"xprts {self.info['num_xprts']}, " \
+                  f"active {self.info['num_active']}, " \
+                  f"queue {self.info['queue_len']}"
+        xprts = [ f"	{x.small_str()}" for x in self.xprts ]
+        return "\n".join([ switch ] + xprts)
+
+    def add_command(subparser):
+        parser = subparser.add_parser("switch", help="Commands for xprt switches")
+        parser.add_argument("--id", metavar="ID", nargs=1, type=int, help="Id of a specific xprt-switch to show")
+        parser.set_defaults(func=XprtSwitch.list_all)
+
+    def list_all(args):
+        switches = [ XprtSwitch(f) for f in (sunrpc / "xprt-switches").iterdir() ]
+        switches.sort()
+        for xs in switches:
+            if args.id == None or xs.id == args.id[0]:
+                print(xs)
+
+
 parser = argparse.ArgumentParser()
 
 def show_small_help(args):
@@ -21,5 +86,8 @@ def show_small_help(args):
     print("sunrpc dir:", sunrpc)
 parser.set_defaults(func=show_small_help)
 
+subparser = parser.add_subparsers(title="commands")
+XprtSwitch.add_command(subparser)
+
 args = parser.parse_args()
 args.func(args)
-- 
2.35.0

