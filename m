Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7113143E85F
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Oct 2021 20:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhJ1Shz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Oct 2021 14:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhJ1Shx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Oct 2021 14:37:53 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD2CC061570
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 11:35:25 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id s1so5291249qta.13
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 11:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fx8Eu7TST74xkhEXu4GKTc1eYjHji/4D1Q6XRZtrAp8=;
        b=GhbIkWYKXzrtLqoeqz9YET/bUgCw2ZxhSDj8/ExuHGF8fe1hleOTM5kfJOhON6eapl
         V+Q5WMs3VWdMom1zY/cKwVTnbtlfqou0h8d4vN1gtuxpPv9Xp2TUSYTLANphtKMyWglx
         rMMFCn+sU7RdHyETGtyLw6qAn7TR5sxrlfWgGKtKbxmPAk45XHSL220rlEdGHRtpST5z
         ChZOdRU90pX4bI7mx+rWT3NnJ5tguS3bH4E3PYLPyjnFsxtJ82q1BaxMSSdvTmrYR/fc
         9MBKrHNSXwwQi5DnrXNQIb6ycsZ4JgbtGTidboHcRul8EpnXW8EvTqA81VhmrwXvgSyc
         1UYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Fx8Eu7TST74xkhEXu4GKTc1eYjHji/4D1Q6XRZtrAp8=;
        b=bY8aHCzKwKWRkCX45sbjvm5Pl/GD8ICwgmz39zOscdzwEaOt8bkSqx9bGPErhlXjgR
         C1GmLNbPBqkftQukSIskJWo+I01OTQ+92laBqiPFT4g9Nl6UU5ies0r5vhs4jB0Dyxee
         nBm4eg0h09kxxvuf7pBwRk6m/aZTYvlxMNu4lxTEoUDxnV1sgbeu/mg3b7lHoAkxzsf4
         llS2QN6EAPdG9p9XRLjkifZ/FX7pNTvJTFE/Qn/toweyydrVWpwi9faEXk7TCzVS2Fjv
         44ZYM/G5E8gUw9ZoGKRXPg0azKJV2voilddoVtk+GzPsFzM5r7MZXM8tByqv5umG6h8z
         ooYA==
X-Gm-Message-State: AOAM530W8x2GMIG12LTHN/CdZ7L61dK0nq13u/yyj35n8vW9wJWZzQuD
        sBrFKU5ftaNeCYqMADjC1dCM8w/zy+s=
X-Google-Smtp-Source: ABdhPJx7P1JlIXdaf8OZrElTZcucoz8H9s6Ixk0jeqRb3Vof9JdWQQD09XIDtfjfmbH4EnfJ4pFmRA==
X-Received: by 2002:a05:622a:186:: with SMTP id s6mr6436056qtw.323.1635446124155;
        Thu, 28 Oct 2021 11:35:24 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id q13sm2556476qkl.7.2021.10.28.11.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 11:35:23 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v5 3/9] rpcctl: Add a command for printing individual xprts
Date:   Thu, 28 Oct 2021 14:35:13 -0400
Message-Id: <20211028183519.160772-4-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211028183519.160772-1-Anna.Schumaker@Netapp.com>
References: <20211028183519.160772-1-Anna.Schumaker@Netapp.com>
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
v5: Clean up how the Xprt __str__() function works
---
 tools/rpcctl/rpcctl.py |  2 ++
 tools/rpcctl/xprt.py   | 43 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index 90efcbed7ac8..dfad6ac08fa0 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -11,8 +11,10 @@ parser.set_defaults(func=show_small_help)
 
 
 import switch
+import xprt
 subparser = parser.add_subparsers(title="commands")
 switch.add_command(subparser)
+xprt.add_command(subparser)
 
 
 args = parser.parse_args()
diff --git a/tools/rpcctl/xprt.py b/tools/rpcctl/xprt.py
index 62859a23ea4d..f8c8110eeed6 100644
--- a/tools/rpcctl/xprt.py
+++ b/tools/rpcctl/xprt.py
@@ -5,10 +5,51 @@ class Xprt:
         self.path = path
         self.id = int(path.stem.split("-")[1])
         self.type = path.stem.split("-")[2]
+        self.info = sysfs.read_info_file(path / "xprt_info")
         self.dstaddr = sysfs.read_addr_file(path / "dstaddr")
+        self.srcaddr = sysfs.read_addr_file(path / "srcaddr")
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
+
+def list_xprts(args):
+    xprts = [ Xprt(f) for f in (sysfs.SUNRPC / "xprt-switches").glob("**/xprt-*") ]
+    xprts.sort()
+    for xprt in xprts:
+        if args.id == None or xprt.id == args.id[0]:
+            print(xprt)
+
+def add_command(subparser):
+    parser = subparser.add_parser("xprt", help="Commands for individual xprts")
+    parser.add_argument("--id", metavar="ID", nargs=1, type=int, help="Id of a specific xprt to show")
+    parser.set_defaults(func=list_xprts)
-- 
2.33.1

