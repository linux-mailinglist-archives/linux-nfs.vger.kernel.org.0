Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583C949BBCC
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 20:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiAYTJy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 14:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiAYTJw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 14:09:52 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88032C06173D
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 11:09:52 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id o3so5201212qtm.12
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 11:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u1lofvTDU5M40tHfHLPNv46v0X/TQnWs7E87egegVa0=;
        b=JN9iVfTTT+qtiVMp8B9NEYCB+nNQRWTImFSdBF6w4Dowo1rcdDZ6+m/jFUB/sjRJwZ
         6PaIRBeTDuzpR4ND6r2tkDwpfzutN/MxTpZq51wQ0uxVLMDDnm471qeDepUNPSodYSgd
         ZiXVjG1CKuIwwn/EpFTt+s6U0rd6I4Ong6EbGnCGY4u4puBa2z2y9Fpo2QQ0XoPC5Xvd
         H9kZ4YFPO/zRpO2pKgMoKjEd/0l2rUW4ml5mQ5V3+s5LhN24UZ5L9v4+P4EfHnWWD9h7
         4fAgH6ZiPB3ErVPM50stUUSJBSjXzdLvxDoXqotLK0BquyUlPclQbIHp5XmSdenmOYY9
         iyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=u1lofvTDU5M40tHfHLPNv46v0X/TQnWs7E87egegVa0=;
        b=wg2mqs0VFjfp+zCXgcFDznht6c2W/tIGCWbdbvNWK1of0/odj7kr4cLz+4WIEnkU/3
         fjBPVOb5WUq9UhLljldNQXstvmkygiH0GY4kF+cM0EakPwxxS/absTMgSJ6hRclcSS+E
         YjmP6aoxhHJ/OBqv7Ee0A/nQs8tfpEI/de8KyktxlYzwhnMhCx35QsYX6Y/70EdZ1EKB
         dT7f62iKjEJGZmbTnloPYtdLJf57+naW1fJ6hb2CAJdu5zkPJVRwbJQVODc4LZ47Gs7o
         w46FNh9jMSGPpnZ8Npr9JG0rvHOYv0+08WFhqQE+vEkGpIqxlmu9mOZnMswb+XEfjCKJ
         Maww==
X-Gm-Message-State: AOAM532kdib6GYs8f7Tl2cHn895/xpAfkvrhm4WuEWMLptJCRV9tlIWE
        +cQ3BJe2i8D/EflPUYEw3P4=
X-Google-Smtp-Source: ABdhPJxUKj4/uSqah3IScJ1cP5jwDSWudBdQh9FSiD0PEE8btycaQUSR9ZZ/Y920S5G2KIMoyD8MSQ==
X-Received: by 2002:a05:622a:182:: with SMTP id s2mr12779133qtw.381.1643137791590;
        Tue, 25 Jan 2022 11:09:51 -0800 (PST)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id n6sm34802qtx.23.2022.01.25.11.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 11:09:51 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v6 4/9] rpcctl: Add a command for printing rpc client information
Date:   Tue, 25 Jan 2022 14:09:41 -0500
Message-Id: <20220125190946.23586-5-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125190946.23586-1-Anna.Schumaker@Netapp.com>
References: <20220125190946.23586-1-Anna.Schumaker@Netapp.com>
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
v6: Squash into a single file
---
 tools/rpcctl/rpcctl.py | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index ae338e06f802..169a2a3c0ef9 100755
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
2.34.1

