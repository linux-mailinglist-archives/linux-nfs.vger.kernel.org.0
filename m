Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E0749EB54
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 20:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245740AbiA0Tt6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 14:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245709AbiA0Tt6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 14:49:58 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FF4C061714
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 11:49:57 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id b5so3401821qtq.11
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 11:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9KmOazJo3AC+FbfLD+18zxeLwtQZ9YpPY0h/r3NqizE=;
        b=PIqn/DHL99ofB6HCYG2MyFcU/3oOs1yurAfBO9urFxb4B37T5I5IOdqjc7FwrGTRap
         wKwzV/2wKnAvpBkAR3BeijU8igic+Qc4vWTPlr3lO0w9ug7jfEtdZUkFL2w55VIFUJc9
         KGYU/0SLXiIlOlTNS9WWAbDXaqi79gTuwQFEQDhUpwObgw1eB/CbR/MG8ttv3p8Yf2E3
         asxAVrI1bj1dL+tD0Q47mZ/CJ5RP3yW08OHGa7UBFcnBIF0+H/FJb8LENTTkfQZ8xUNt
         voAyc3do0pwWI6XN1pkwMHw0vi+UeMs5sGwuB5d3WDO6TpKlPVixs+q55qtIdnnjC19O
         8zpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9KmOazJo3AC+FbfLD+18zxeLwtQZ9YpPY0h/r3NqizE=;
        b=VUlevK+wX8+S4sfFcquzkMmWMk2ZKWQUsrh/xr5F5qXNFqvyHtgRVxtpds6QBofPdm
         Ygptpq0YtiyfElHcu6qO8aKjEl7Q23GiPr/Ul22pYqjwCRT7GqpDzClvzkuRwk3MSeFn
         p8PQzI5+MPhLxPe7T6JI+BOKvvVKt6ZtxhIfKeHC1i4LK2nRIeOuKtcKEXenoY+iVDr3
         BARRG/pOHfvrCJ2PjKNBrWleEzYoePKwOMN+jFN9T72Z3VAuj4sUX5ZyD+pEeHxgdIwz
         5j3ZLFsPuxq6atBJfvlUpUxQ+zQ98FNty+h3grokh/T8fOg32W+MgPaQJochHje/TRYv
         C1Bg==
X-Gm-Message-State: AOAM533CRIWf8rg9hXM+JfTrqWzRK5jnf4XFfioXm+p7Ol4QPBLPM8l3
        I+XKts/meIAEnWDAcTNP4UU=
X-Google-Smtp-Source: ABdhPJz+Z2Nbplb3qYjjnRX2bV9Jd//2ZZfAi96cq69HKNziiNsU/AcrqXb4zO2cQ1uhqa301/0W2w==
X-Received: by 2002:a05:622a:3cf:: with SMTP id k15mr3860951qtx.339.1643312996891;
        Thu, 27 Jan 2022 11:49:56 -0800 (PST)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id g7sm1836483qkc.104.2022.01.27.11.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 11:49:56 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v7 4/9] rpcctl: Add a command for printing rpc client information
Date:   Thu, 27 Jan 2022 14:49:47 -0500
Message-Id: <20220127194952.63033-5-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220127194952.63033-1-Anna.Schumaker@Netapp.com>
References: <20220127194952.63033-1-Anna.Schumaker@Netapp.com>
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
 tools/rpcctl/rpcctl.py | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index b5092e39d336..bdb56d1f5476 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -87,10 +87,11 @@ class Xprt:
 
 
 class XprtSwitch:
-    def __init__(self, path):
+    def __init__(self, path, sep=":"):
         self.path = path
         self.id = int(path.stem.split("-")[1])
         self.info = read_info_file(path / "xprt_switch_info")
+        self.sep = sep
 
         self.xprts = [ Xprt(p) for p in self.path.iterdir() if p.is_dir() ]
         self.xprts.sort()
@@ -99,7 +100,7 @@ class XprtSwitch:
         return self.id < rhs.id
 
     def __str__(self):
-        switch =  f"switch {self.id}: " \
+        switch =  f"switch {self.id}{self.sep} " \
                   f"xprts {self.info['num_xprts']}, " \
                   f"active {self.info['num_active']}, " \
                   f"queue {self.info['queue_len']}"
@@ -119,6 +120,32 @@ class XprtSwitch:
                 print(xs)
 
 
+class RpcClient:
+    def __init__(self, path):
+        self.path = path
+        self.id = int(path.stem.split("-")[1])
+        self.switch = XprtSwitch(path / (path / "switch").readlink(), sep=",")
+
+    def __lt__(self, rhs):
+        return self.id < rhs.id
+
+    def __str__(self):
+        return f"client {self.id}: {self.switch}"
+
+    def add_command(subparser):
+        parser = subparser.add_parser("client", help="Commands for rpc clients")
+        parser.add_argument("--id", metavar="ID", nargs=1, type=int, help="Id of a specific client to show")
+        parser.set_defaults(func=RpcClient.list_all)
+
+    def list_all(args):
+        clients = [ RpcClient(f) for f in (sunrpc / "rpc-clients").iterdir() ]
+        clients.sort()
+        for client in clients:
+            if args.id == None or client.id == args.id[0]:
+                print(client)
+
+
+
 parser = argparse.ArgumentParser()
 
 def show_small_help(args):
@@ -127,6 +154,7 @@ def show_small_help(args):
 parser.set_defaults(func=show_small_help)
 
 subparser = parser.add_subparsers(title="commands")
+RpcClient.add_command(subparser)
 XprtSwitch.add_command(subparser)
 Xprt.add_command(subparser)
 
-- 
2.35.0

