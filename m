Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FDA437FAF
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 22:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbhJVU6a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 16:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbhJVU6a (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 16:58:30 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A280C061764
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 13:56:12 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id d15so5743389qkj.10
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 13:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M6Bz2yh540ccVCkW2g9qTFRjAM0OD1xmVMddS3dX4po=;
        b=cLn/X3j5hFahZZZo9yC/O8AP/HQSjwcSItBCeakgVfqyU7Ev0LXPtjpg1ee8mx8Yzd
         VuCWNA/SMSq1t4mfHWCuL2h1JlPPcoOeicqMYZyfIh+nzgQ2UviBDV5Q5t1HfLF1LaEa
         PTcqXGFRFi86tl5BmgI/f93tiO1N9ObYG9k5OF4IELjLQj6KlVToxppu34VX59WAL00D
         dC24g/13Py2XC7n3+nHwUwvl5NSoAEKQN4EbyAjCj9QhXmU/i/ybYCPyISoJFXMj4Krr
         UQFhz0lyXLv36FPremCY6DQVFFZkbGe6cWJ+p+N/MF/INqbwmT3otETIs6VG2JVF0kAp
         J6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=M6Bz2yh540ccVCkW2g9qTFRjAM0OD1xmVMddS3dX4po=;
        b=oqRHZMSmLRI8vjd8FDnUYLDBMo0ck28Cdcf2JC3joXZpL8AYTo6wVtcrDwDDTIDihx
         fhbp1ezewiZyz8JPJaF4rGWS+kmOq7CBILaSid0IsAE+RrjLlhWhn8s0ZfXjfUfbdhdc
         4NrY7s4EHe8Z8hAeu140KpAyTRl9DCvU8/At6UcM2VweeLyYX5UJgxWtgDqS/ZRdzmFR
         tosP5q5Oay2nmPEGYAQe2v6zDkTLjzFtvRE1bLZl8WhOrt5sx/1EIPw36vX73Uc0CGUw
         AbAkjJf5jfRREfql3RDMLmOXFWyYiY8YUVFOBBZg/cQBy0exOrbPEJpdSNY8/WaamazM
         Ik9A==
X-Gm-Message-State: AOAM530aWUQuZMCudr9LW3g0x0zLTzLaHf9IdkEYTU6LtPotAUXr+Odm
        0MNW8WHdgMn48O24oruOkqM=
X-Google-Smtp-Source: ABdhPJy5guhYj1RPkkJ0lmFgb07XRDbcDD1RYWQCmaDLSP0MGDP6j5txrAiV4Y+W/X56T8Yoq2PEOg==
X-Received: by 2002:a37:6215:: with SMTP id w21mr2028254qkb.42.1634936171205;
        Fri, 22 Oct 2021 13:56:11 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id p9sm4576279qki.51.2021.10.22.13.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 13:56:10 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v4 5/9] rpcsys: Add a command for changing xprt dstaddr
Date:   Fri, 22 Oct 2021 16:56:02 -0400
Message-Id: <20211022205606.66392-6-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022205606.66392-1-Anna.Schumaker@Netapp.com>
References: <20211022205606.66392-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Using the socket module for dns resolution

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 tools/rpcsys/xprt.py | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/rpcsys/xprt.py b/tools/rpcsys/xprt.py
index fbdd9bfc9375..2160cb0a9575 100644
--- a/tools/rpcsys/xprt.py
+++ b/tools/rpcsys/xprt.py
@@ -1,3 +1,4 @@
+import socket
 import sysfs
 
 class Xprt:
@@ -34,6 +35,12 @@ class Xprt:
         return "xprt %s: %s, %s%s" % (self.id, self.type, self.dstaddr,
                                      f" [main]" if self.main_xprt else "" )
 
+    def set_dstaddr(self, newaddr):
+        resolved = socket.gethostbyname(newaddr)
+        with open(self.path / "dstaddr", 'w') as f:
+            f.write(resolved)
+        self.dstaddr = open(self.path / "dstaddr", 'r').readline().strip()
+
 
 def list_xprts(args):
     xprts = [ Xprt(f) for f in (sysfs.SUNRPC / "xprt-switches").glob("**/xprt-*") ]
@@ -42,7 +49,28 @@ def list_xprts(args):
         if args.id == None or xprt.id == args.id[0]:
             print(xprt)
 
+def get_xprt(id):
+    xprts = [ Xprt(f) for f in (sysfs.SUNRPC / "xprt-switches").glob("**/xprt-*") ]
+    for xprt in xprts:
+        if xprt.id == id:
+            return xprt
+
+def set_xprt_property(args):
+    xprt = get_xprt(args.id[0])
+    try:
+        if args.dstaddr != None:
+            xprt.set_dstaddr(args.dstaddr[0])
+        print(xprt)
+    except Exception as e:
+        print(e)
+
 def add_command(subparser):
     parser = subparser.add_parser("xprt", help="Commands for individual xprts")
     parser.add_argument("--id", metavar="ID", nargs=1, type=int, help="Id of a specific xprt to show")
     parser.set_defaults(func=list_xprts)
+
+    subparser = parser.add_subparsers()
+    parser = subparser.add_parser("set", help="Set an xprt property")
+    parser.add_argument("--id", metavar="ID", nargs=1, type=int, required=True, help="Id of a specific xprt to modify")
+    parser.add_argument("--dstaddr", metavar="dstaddr", nargs=1, type=str, help="New dstaddr to set")
+    parser.set_defaults(func=set_xprt_property)
-- 
2.33.1

