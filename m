Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A72149EB53
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 20:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245708AbiA0Tt5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 14:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245709AbiA0Tt5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 14:49:57 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B7CC061714
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 11:49:57 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id k4so3815877qvt.6
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 11:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MmwFXixjfwMV9cyT3TGZyFhvQH58zAcM3mqXYroDdY0=;
        b=cWgT7th305LYBOatf0Q/3Om0pvPwhtMQD95QNyIDq2A6TXDeyMtis/Zg3ZOGdMbhLR
         bFgOtyKBWRxiB2JHEszLQWJQFmuv3o151yPwRwgK550XvToZ0+lqrtJUBIBpLLWfckew
         b10xyR4s+01H03FG1RBPHw0/yzNIgxoFClTS7hjmPsE9Q3F7Da1AEJoa0N2Z4UX2QL/T
         yhVQoHoBWrM3KU3U+7FcHEdjMKxbAjdQgwWAM95yH7paqmCagqLx4/DIwOH6RhX/43S5
         iAEN+EqluUW0wsoD9Xl5KVZmMrnpcBmBDr09ZHaxMSSjg2gLgsPMHV8T7C4pNONSBOzM
         sLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=MmwFXixjfwMV9cyT3TGZyFhvQH58zAcM3mqXYroDdY0=;
        b=FZFqQ/bCnHaHFHtI5E9B6Xwoi3ARZKomuPJmu5Xr4OVeq07sfyi3ARwkcrDvck4W0/
         XBvwKLbVEjE2wkgfYeMgZu7nKSehRP0cEaaZkbhZ3fdIEHz7zYi0WxxvIRBVd5B4gZFN
         2XDI2eOCDfSZXiT26ZmnPYb+wIwU3ZHnEL7X6XzJd8kovmBZ11tUjl4lf+Ul/QEh0Jta
         WgsOUSqRqJzDosOb/cmo9DiBoETGDp0TpR1AuUR6no8tl5+e9GzUc6WoV1Ser29g71sW
         xBn+4RDnWqxPyNhjAWU4XygDVjQEdmurTuixGNjp1eCxasu8gGaO5aZZNIIh4eCQk6Ns
         BNcQ==
X-Gm-Message-State: AOAM531TGCLTLOJdmkm+77F0nZuDPGDUb4nPr7T07zyhEUolxCK8op+F
        X2CN6fNxj8/JO3kXv5N0wTUG65tGnoI=
X-Google-Smtp-Source: ABdhPJztV74RGQBfIaxrLBch18OG0UdiHkXdFiYjmmQ7/TaGDqTnM0PAXHZ6/ERjSM2XS0n/iz9Qvw==
X-Received: by 2002:ad4:5c83:: with SMTP id o3mr5017891qvh.15.1643312996094;
        Thu, 27 Jan 2022 11:49:56 -0800 (PST)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id g7sm1836483qkc.104.2022.01.27.11.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 11:49:55 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v7 3/9] rpcctl: Add a command for printing individual xprts
Date:   Thu, 27 Jan 2022 14:49:46 -0500
Message-Id: <20220127194952.63033-4-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220127194952.63033-1-Anna.Schumaker@Netapp.com>
References: <20220127194952.63033-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This shows more detailed information than what is presented with xprt
switches. I take the chance to add a main-export indicator to the
small_str() used when printing out xprt-switches.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 tools/rpcctl/rpcctl.py | 43 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index 0d922f1acf21..b5092e39d336 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -37,13 +37,53 @@ class Xprt:
         self.path = path
         self.id = int(path.stem.split("-")[1])
         self.type = path.stem.split("-")[2]
+        self.info = read_info_file(path / "xprt_info")
         self.dstaddr = read_addr_file(path / "dstaddr")
+        self.srcaddr = read_addr_file(path / "srcaddr")
+
+        with open(path / "xprt_state") as f:
+            self.state = ','.join(f.readline().split()[1:])
 
     def __lt__(self, rhs):
         return self.id < rhs.id
 
+    def _xprt(self):
+        main = ", main" if self.info.get("main_xprt") else ""
+        return f"xprt {self.id}: {self.type}, {self.dstaddr}, " \
+               f"port {self.info['dst_port']}, state <{self.state}>{main}"
+
+    def _src_reqs(self):
+        return f"	Source: {self.srcaddr}, port {self.info['src_port']}, " \
+               f"Requests: {self.info['num_reqs']}"
+
+    def _cong_slots(self):
+        return f"	Congestion: cur {self.info['cur_cong']}, win {self.info['cong_win']}, " \
+               f"Slots: min {self.info['min_num_slots']}, max {self.info['max_num_slots']}"
+
+    def _queues(self):
+        return f"	Queues: binding {self.info['binding_q_len']}, " \
+               f"sending {self.info['sending_q_len']}, pending {self.info['pending_q_len']}, " \
+               f"backlog {self.info['backlog_q_len']}, tasks {self.info['tasks_queuelen']}"
+
+    def __str__(self):
+        return "\n".join([self._xprt(), self._src_reqs(),
+                          self._cong_slots(), self._queues() ])
+
     def small_str(self):
-        return f"xprt {self.id}: {self.type}, {self.dstaddr}"
+        main = " [main]" if self.info.get("main_xprt") else ""
+        return f"xprt {self.id}: {self.type}, {self.dstaddr}{main}"
+
+    def add_command(subparser):
+        parser = subparser.add_parser("xprt", help="Commands for individual xprts")
+        parser.add_argument("--id", metavar="ID", nargs=1, type=int, help="Id of a specific xprt to show")
+        parser.set_defaults(func=Xprt.list_all)
+
+    def list_all(args):
+        xprts = [ Xprt(f) for f in (sunrpc / "xprt-switches").glob("**/xprt-*") ]
+        xprts.sort()
+        for xprt in xprts:
+            if args.id == None or xprt.id == args.id[0]:
+                print(xprt)
 
 
 class XprtSwitch:
@@ -88,6 +128,7 @@ parser.set_defaults(func=show_small_help)
 
 subparser = parser.add_subparsers(title="commands")
 XprtSwitch.add_command(subparser)
+Xprt.add_command(subparser)
 
 args = parser.parse_args()
 args.func(args)
-- 
2.35.0

