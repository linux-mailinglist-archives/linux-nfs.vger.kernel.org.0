Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE85437FAD
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 22:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhJVU63 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 16:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbhJVU62 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 16:58:28 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A31C061764
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 13:56:10 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id y10so5771032qkp.9
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 13:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g/R0jC4P7O+0dIMXzLoTAUYHx0dn5Ru5svPDv4bWJWA=;
        b=GlkHJ6knG+Qc42m/9Mkl1Kj8+XU2JVMfweB1xCENVLAtjg64kaOOUhx0pdeKFc+a0g
         9dlhEaqm166/SnO5xqZqXyrhJ1MMiPUqfSoEF7DjTF7c6oJPcQg7IEcRDCjqjbimnYIB
         tROw2l09bjawBjYuPVDfjie38BRf9d5EJt+hN2BV3HDftpSByxKqzmYQhAN/8v75CNFH
         Tym5mPT4Vfuw5+uV0ljG76oxUl7Q9C98Ut1NC6a3vhrGomy9KsApZsx56YBB1r3HIU9h
         iNtDgTvwFht2UbDGLefWqaSKxXZqSRoFleNfyC8K1jUlgpLcZO8YNnTmug3nhihf8v36
         Sxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=g/R0jC4P7O+0dIMXzLoTAUYHx0dn5Ru5svPDv4bWJWA=;
        b=s6K3VAMSzUR+Yg2pxa66h1CcQHTEm8aKPAmv/Se+XSLK9AWLHYTN7dK0iBtH5mqAVT
         bsglkbA6iLOjutYhhr80XuSdGdEu/tVgfyEhloZAyqEc16pcY/OIw6qa6jBwSF+SQBrn
         yQWfBOV+RfIuO0YVbY5JKNdqaAE6cwKJg8APijU/sSjsxXj4dw5coCTEasMe3WzI3oMD
         XcxIoAJ231JftCwippxar2A+rIOPJnb6bhGF04fUj9XJXSFE0FA8P49AOjZ74hgHZO5Y
         MJfcibDnwa3QzUey8fCDBNFFhT6zziq9rLY/dyrq2HrSZew/e2e3OVyFUDKTxMfPQE0+
         Yecg==
X-Gm-Message-State: AOAM5338rUKXkGty3p2Q3IsJos9fq0eR+nwHmvsqyqBVXVk8TcbSkgbn
        d6yo5w4bRqEoiMAwfcC4cFU=
X-Google-Smtp-Source: ABdhPJxafIsXYEtO3xZttDqU3ZM7BA0gdLaJ/Yx8t3rZ0Qs7J3QLQaeYBwXgOcjjubKnaM/YJzpabw==
X-Received: by 2002:a05:620a:541:: with SMTP id o1mr2043556qko.41.1634936169867;
        Fri, 22 Oct 2021 13:56:09 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id p9sm4576279qki.51.2021.10.22.13.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 13:56:09 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v4 3/9] rpcsys: Add a command for printing individual xprts
Date:   Fri, 22 Oct 2021 16:56:00 -0400
Message-Id: <20211022205606.66392-4-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022205606.66392-1-Anna.Schumaker@Netapp.com>
References: <20211022205606.66392-1-Anna.Schumaker@Netapp.com>
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
 tools/rpcsys/rpcsys.py |  2 ++
 tools/rpcsys/xprt.py   | 38 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/tools/rpcsys/rpcsys.py b/tools/rpcsys/rpcsys.py
index 90efcbed7ac8..dfad6ac08fa0 100755
--- a/tools/rpcsys/rpcsys.py
+++ b/tools/rpcsys/rpcsys.py
@@ -11,8 +11,10 @@ parser.set_defaults(func=show_small_help)
 
 
 import switch
+import xprt
 subparser = parser.add_subparsers(title="commands")
 switch.add_command(subparser)
+xprt.add_command(subparser)
 
 
 args = parser.parse_args()
diff --git a/tools/rpcsys/xprt.py b/tools/rpcsys/xprt.py
index d37537771c1d..fbdd9bfc9375 100644
--- a/tools/rpcsys/xprt.py
+++ b/tools/rpcsys/xprt.py
@@ -1,12 +1,48 @@
+import sysfs
+
 class Xprt:
     def __init__(self, path):
         self.path = path
         self.id = int(str(path).rsplit("-", 2)[1])
         self.type = str(path).rsplit("-", 2)[2]
         self.dstaddr = open(path / "dstaddr", 'r').readline().strip()
+        self.srcaddr = open(path / "srcaddr", 'r').readline().strip()
+
+        with open(path / "xprt_state") as f:
+            self.state = ','.join(f.readline().split()[1:])
+        self.__dict__.update(sysfs.read_info_file(path / "xprt_info"))
 
     def __lt__(self, rhs):
         return self.id < rhs.id
 
+    def __str__(self):
+        state = self.state
+        if self.main_xprt:
+            state = "MAIN," + self.state
+
+        line = "xprt %s: %s, %s, port %s, state <%s>" % \
+                (self.id, self.type, self.dstaddr, self.dst_port, state)
+        line += "\n	Source: %s, port %s, Requests: %s" % \
+                (self.srcaddr, self.src_port, self.num_reqs)
+        line += "\n	Congestion: cur %s, win %s, Slots: min %s, max %s" % \
+                (self.cur_cong, self.cong_win, self.min_num_slots, self.max_num_slots)
+        line += "\n	Queues: binding %s, sending %s, pending %s, backlog %s, tasks %s" % \
+                (self.binding_q_len, self.sending_q_len, self.pending_q_len, self.backlog_q_len, self.tasks_queuelen)
+        return line
+
     def small_str(self):
-        return "xprt %s: %s, %s" % (self.id, self.type, self.dstaddr)
+        return "xprt %s: %s, %s%s" % (self.id, self.type, self.dstaddr,
+                                     f" [main]" if self.main_xprt else "" )
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

