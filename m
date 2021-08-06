Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558013E303A
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 22:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244837AbhHFUSC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Aug 2021 16:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244827AbhHFUSB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Aug 2021 16:18:01 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10410C0613CF
        for <linux-nfs@vger.kernel.org>; Fri,  6 Aug 2021 13:17:45 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id t66so11290664qkb.0
        for <linux-nfs@vger.kernel.org>; Fri, 06 Aug 2021 13:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XvCeS+hULuWGac1mOem+HdA4jO3Dr2104fmkyvlCrB4=;
        b=NbIhaTWgjAKnA1Gfn1jl0CBKbgRAl3EDT/LS8e5qUwQOReTECCepX/5IUu9z5t1Xr+
         XkBis6iiVePKNOO1VOpG29M5vp80oM/2zWKJUsmzT40RliqJB9+u7MBCyVCQuDlydlwS
         yXPBS7PsA2UVt0qQK9o7MY5UbJdQmAxxWtnMbSUTe3oiIVrEcgCeLRvShScpU2ERkW5Y
         3fBzBdUHzs/J5evpRhchB9bLTjvGsuh0y0+KasR3Ju5Eo2AUTKQ7bJVND5aipODx9iHm
         44O1Z4lHnVZhD7Jn4vP136luTaQHlEuUdiPQk8dbQt+cEJsyvLsqalLmzBeY3A6MvIc9
         oIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=XvCeS+hULuWGac1mOem+HdA4jO3Dr2104fmkyvlCrB4=;
        b=sZiwwDIoz8XlIh5K2T4XrhjqosJeQowspaJd3+FZ4kDTwJAexJQMZcTIjSV4LU5YVZ
         8h5R4ezgL1dlmddG2VPUBhBoDNZf/lOBwTWhU+kA/qL94a7A8QiMG73YT7HE3qBkOT/l
         Qm126Wsbd1jsj88Cdb4EmcZXO+33fk5W1OL5cOSol4EbjKjMtEvGtOvvGyz8civqTZ42
         etCEtIiBhkotoggC/Nd64WP/GoeaN2D/WEd/+yT/ZUwxPdSausSQBaUCKUdJ1jLi5HYl
         qAUZyCnroOChwHE8sD3rerhxV3UHXb9YtHSSG1ToKTU7SLSl4aXqU/QhdQXHSl4GB/I0
         UN5A==
X-Gm-Message-State: AOAM533ucSqMY4ySBr8yFoXrbLrWysAutXOAXJ0DTF1Um23RRsA+jhVh
        wb2nKuFBrGH0VOv5QSlv4vpI8epFJlegqw==
X-Google-Smtp-Source: ABdhPJxhvht6LRGSyU8MHjkuR7INwZ7aR5/PYS5hvcg2pmnyKbEergONHk3xNhABn2DSWaRMyZw5kw==
X-Received: by 2002:a05:620a:2297:: with SMTP id o23mr3276009qkh.253.1628281064153;
        Fri, 06 Aug 2021 13:17:44 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id g11sm3705720qtk.91.2021.08.06.13.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 13:17:43 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 3/9] nfs-sysfs.py: Add a command for printing individual xprts
Date:   Fri,  6 Aug 2021 16:17:33 -0400
Message-Id: <20210806201739.472806-4-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806201739.472806-1-Anna.Schumaker@Netapp.com>
References: <20210806201739.472806-1-Anna.Schumaker@Netapp.com>
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
 tools/nfs-sysfs/nfs-sysfs.py |  2 ++
 tools/nfs-sysfs/xprt.py      | 38 +++++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/tools/nfs-sysfs/nfs-sysfs.py b/tools/nfs-sysfs/nfs-sysfs.py
index 90efcbed7ac8..dfad6ac08fa0 100755
--- a/tools/nfs-sysfs/nfs-sysfs.py
+++ b/tools/nfs-sysfs/nfs-sysfs.py
@@ -11,8 +11,10 @@ parser.set_defaults(func=show_small_help)
 
 
 import switch
+import xprt
 subparser = parser.add_subparsers(title="commands")
 switch.add_command(subparser)
+xprt.add_command(subparser)
 
 
 args = parser.parse_args()
diff --git a/tools/nfs-sysfs/xprt.py b/tools/nfs-sysfs/xprt.py
index d37537771c1d..fbdd9bfc9375 100644
--- a/tools/nfs-sysfs/xprt.py
+++ b/tools/nfs-sysfs/xprt.py
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
2.32.0

