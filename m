Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FE749BBCA
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 20:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiAYTJx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 14:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiAYTJu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 14:09:50 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE95C06173E
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 11:09:50 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id h4so4118099qtm.2
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 11:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PniGwIjGbetmqx1+oOSRn+cgMMvvnoBMUb+ILYmoyy8=;
        b=CTPXSDOG/NP+lSVs5m0J5tM62ljKJLYbxc2SipmvQn9LF4+pxd1Ee9QfRElM5qK7v9
         +0ZT2aTjAXAWl1tjTs9Txy+Jv5d5vWaMwOzxQ+4WXPNaX9svUWjyjGGn+jbDF4UwHRWE
         XHZxaGKD5TbQhzHB0gCkXsoaPUL1pM2TNcu/CrXOBaxff2oskXONlXczzhDdwK0iz/7Z
         D2sBHY/XZ+ZEOdWYjdJP+ZyNi51nGEXp4L3IEKCmicJ0XwIfvcQgbsX5kyDHmrHPo6Br
         7wQnBmS9GTiiSk79y2EUvoR7HH5TUARdMSJm5OPmqco0Rr4IhAv4zChOHCbYr5T5p1du
         5z6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=PniGwIjGbetmqx1+oOSRn+cgMMvvnoBMUb+ILYmoyy8=;
        b=vBX2fZspT4AXDTYi2Ji7yPYOf2uWY6bCskTs1+fk4wdrtkyAQsg5KC/4s4VTtiAIjn
         dAGP6xcqnAPuwNLCOhTMdpoQh5A5b8kfdWvDVkHaASG5wpkrw2Muqf1/BVz+SJqC38P9
         pyRfupyLrjR/TkCBY8+Xh/1ZYDQ69p80iakpqDiQa/o4b0v2mMwx76Nf4auaRT2whXwb
         Eed766iH3CTwZdIsSSrPE2KSNNvuyLuVN33ZlL7QU94RA1+xHydbZ2K9qtXY6GQbtnl7
         x8KOrUzmL9wioapD3u7aL7NROFNgyLVnBqJfLC7HQT5BbulJWEA7rxKWYc8nXuWwDZMn
         jt8g==
X-Gm-Message-State: AOAM531tG01P8KUjfqZlc2IfBOig95cCZoE4n16e9S2XE8xuOFw/dfXn
        8dclsfgVPGLLJg0+l7jfaxIT1QGAy8s=
X-Google-Smtp-Source: ABdhPJyqITMB6x+k+efecIifAlEuncUVVNY2MHWIBBadXNt9QpeTfMMYyV1FzD0ke/7qIFd+GXoxRg==
X-Received: by 2002:a05:622a:204:: with SMTP id b4mr17842617qtx.680.1643137789342;
        Tue, 25 Jan 2022 11:09:49 -0800 (PST)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id n6sm34802qtx.23.2022.01.25.11.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 11:09:48 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v6 2/9] rpcctl: Add a command for printing xprt switch information
Date:   Tue, 25 Jan 2022 14:09:39 -0500
Message-Id: <20220125190946.23586-3-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125190946.23586-1-Anna.Schumaker@Netapp.com>
References: <20220125190946.23586-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This combines the information found in xprt_switch_info with a subset of
the information found in each xprt subdirectory

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
--
v6: Continue squashing into a single file
    Change XprtSwitch comparison to use id instead of path
---
 tools/rpcctl/rpcctl.py | 68 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index 9851d2f5f9a6..a6bd418f8d4a 100755
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
2.34.1

