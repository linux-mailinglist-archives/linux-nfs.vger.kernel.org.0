Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D18B43E861
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Oct 2021 20:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhJ1Sh4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Oct 2021 14:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhJ1Shx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Oct 2021 14:37:53 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F40C061745
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 11:35:26 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id h14so5880933qtb.3
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 11:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sh2Ri79lVNQOJYQb4TPc6Y1GVYSVmFvfd7BVg9tSaF8=;
        b=hGyeDI2hNNBvb6iRedc/Y8s0oLFqL2I7xJ9/cqf17iIdfyqs3/kRIWOTUiKy/PcZVy
         6TcHKO8lx8gu02p+3mhLO5+ufnXjrf27HyKWOkR+Ozeqt2Btt5i3vE1FvEtWgyaABpX4
         iMYeK1vXAvIDadcz3W8daf0Tz2PHZQdPDUHqRZa3JEIw6jpMRjPurirZ1W1fqkl2IdG2
         BnKYV9UedjQ+BnJMJ1OmB9uJ12qFLFRJqPj/ocaGyCbuPSLjSZbzujyBwTIICKl1iqlu
         SEf/mTkmOvvz/SdKdtrz+9Ke8UQiQnwqKcdWyfHMf7J925r793jiEtchpx1y/P8rzHGG
         e/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Sh2Ri79lVNQOJYQb4TPc6Y1GVYSVmFvfd7BVg9tSaF8=;
        b=lXRxFYe/mm42b4WjaAHcF+OhIdFh4yKCHu+KKjixGQQxfk1P/PzFQ6OeEwiJDdsyIB
         K1q249LmuUrFRbWoMu+oYtzPbzSp83VUaN0biqGlEa4mveXOM82H7eeL3uHhjfCwfN4W
         rqLxRl/lmDW+jfab2p01IemfTweka17Uqn23wJT2pLiwodIYYxFbnLmNfTkCf3zzqyXv
         o/l9fFym43DL0R0TIINomaxFCpxvcaBBAoe4mSMVqoiyHU4oNmki3z3vgEgR4gsfi8Wn
         n7V6M2qvL1KP5xsPLxPH3A7Wsbk4D4iZn1qDquFA8m1yE9EoEmPx4k5E2pu4QmNciigP
         PfPA==
X-Gm-Message-State: AOAM5331Ro/CVLCm/bebzYa4bZgP1U5mR/nZyZ2oYq7oSB6xGz9h1EE/
        YglHfZf0PmhOgplRU+wEwUNXdOIRikk=
X-Google-Smtp-Source: ABdhPJziKYdA0/IL0LASn96ht1I0az/IXtea9XGpBuWgjF0gzse10coueiO3YzYlQECfDdB3LmDUUA==
X-Received: by 2002:ac8:1ca:: with SMTP id b10mr6403008qtg.327.1635446125076;
        Thu, 28 Oct 2021 11:35:25 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id q13sm2556476qkl.7.2021.10.28.11.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 11:35:24 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v5 4/9] rpcctl: Add a command for printing rpc client information
Date:   Thu, 28 Oct 2021 14:35:14 -0400
Message-Id: <20211028183519.160772-5-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211028183519.160772-1-Anna.Schumaker@Netapp.com>
References: <20211028183519.160772-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

It's mostly the same information as with xprt-switches, except with
rpc-client id prepended to the first line.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
v5: Clean up how the RpcClient __str__() function works
    Rename the subcommand to simply "client"
---
 tools/rpcctl/client.py | 27 +++++++++++++++++++++++++++
 tools/rpcctl/rpcctl.py |  2 ++
 tools/rpcctl/switch.py |  5 +++--
 3 files changed, 32 insertions(+), 2 deletions(-)
 create mode 100644 tools/rpcctl/client.py

diff --git a/tools/rpcctl/client.py b/tools/rpcctl/client.py
new file mode 100644
index 000000000000..42c9bee0d2d8
--- /dev/null
+++ b/tools/rpcctl/client.py
@@ -0,0 +1,27 @@
+import sysfs
+import switch
+
+class RpcClient:
+    def __init__(self, path):
+        self.path = path
+        self.id = int(path.stem.split("-")[1])
+        self.switch = switch.XprtSwitch(path / (path / "switch").readlink(), sep=",")
+
+    def __lt__(self, rhs):
+        return self.id < rhs.id
+
+    def __str__(self):
+        return f"client {self.id}: {self.switch}"
+
+
+def list_rpc_clients(args):
+    clients = [ RpcClient(f) for f in (sysfs.SUNRPC / "rpc-clients").iterdir() ]
+    clients.sort()
+    for client in clients:
+        if args.id == None or client.id == args.id[0]:
+            print(client)
+
+def add_command(subparser):
+    parser = subparser.add_parser("client", help="Commands for rpc clients")
+    parser.add_argument("--id", metavar="ID", nargs=1, type=int, help="Id of a specific client to show")
+    parser.set_defaults(func=list_rpc_clients)
diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index dfad6ac08fa0..e2172cdfa4c1 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -10,9 +10,11 @@ def show_small_help(args):
 parser.set_defaults(func=show_small_help)
 
 
+import client
 import switch
 import xprt
 subparser = parser.add_subparsers(title="commands")
+client.add_command(subparser)
 switch.add_command(subparser)
 xprt.add_command(subparser)
 
diff --git a/tools/rpcctl/switch.py b/tools/rpcctl/switch.py
index c96e70b7710f..497ee8b1923c 100644
--- a/tools/rpcctl/switch.py
+++ b/tools/rpcctl/switch.py
@@ -2,10 +2,11 @@ import sysfs
 import xprt
 
 class XprtSwitch:
-    def __init__(self, path):
+    def __init__(self, path, sep=":"):
         self.path = path
         self.id = int(path.stem.split("-")[1])
         self.info = sysfs.read_info_file(path / "xprt_switch_info")
+        self.sep = sep
 
         self.xprts = [ xprt.Xprt(p) for p in self.path.iterdir() if p.is_dir() ]
         self.xprts.sort()
@@ -14,7 +15,7 @@ class XprtSwitch:
         return self.path < rhs.path
 
     def __str__(self):
-        switch =  f"switch {self.id}: " \
+        switch =  f"switch {self.id}{self.sep} " \
                   f"xprts {self.info['num_xprts']}, " \
                   f"active {self.info['num_active']}, " \
                   f"queue {self.info['queue_len']}"
-- 
2.33.1

