Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3893FB97E
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Aug 2021 17:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237799AbhH3P6B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Aug 2021 11:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237732AbhH3P5y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Aug 2021 11:57:54 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCEBC061764
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 08:56:59 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id a5so8627489qvq.0
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 08:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W/8NtlacI5WS71LaySwODmC9q+ANEoOEYf3Bcg7kaCo=;
        b=thy3TORRQJ3CXvMotWkAMxUzAbY59LsVoYVopjI1S7EDeh9hrcQAnR4N5xQ0HdptOc
         PnrjK4AtWkWFaT2zuS7mBwl1lyn6YR+TU4ijuStJhN8Z5YhSOePehOhDUO0byjLxkPtn
         kSqCvtXXADw4XwMz1EPJDrEK8qioXpj+D2BKn1Iom0Md/ZrR0C2sUAzQKSPzNWjfKIIc
         AyRvF1wFnrnhcaOT+WsFV8RLaqwRlHXgqkm0ZXaFAfrM6Hklt6x6R0GChsCVBE7GATVu
         s8R4IvRTs5f6PWwzYmUO7XC4WAorjfPLHu8yITm+FuEinqidxZ3dlWFAuLksQzcoJnV4
         5gEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=W/8NtlacI5WS71LaySwODmC9q+ANEoOEYf3Bcg7kaCo=;
        b=f9o5AtUUgD3ty0fVBhPPcXsxLRqZc83gVarsFGvmHWE0JtebQ7zGyIqVHF3GR+nHW2
         ZXae4oSeuMvQaTgt6ESU6ykk0kOR66uGC51IM5TQigG0DzhmA/K82bIoOzjcjfJJRPR2
         lX0/+/Yjc7a/fZF366RrRZ+LnPKhbKFmo0JEvuBmEDZC64ohhYsJQ0zKwAhEtQ80O/R7
         VW74lyIIGew4UKhbH3DrBve0b37xq8oUBGvz6IaRPx14EbfHaFIvs9qap6+ppCqad1La
         uRSljkbmW9fZCzdtUYVFlDrd34/fYk391gwrjYjRJgUJWpkHd8AwNMTr7MmKoOB/yxJC
         iqRQ==
X-Gm-Message-State: AOAM533pcTem7U+tREUA8JaBbKm78UWTh9yfhpesDsSrBGYR0hoRtyw2
        S1bKJ5zX6Dyy5Hau5Jm+ZLc=
X-Google-Smtp-Source: ABdhPJzBYZJuzBIzblYnnGUpp6xh1Ywi3zx6Tu/wGT6bkXjQdIpcRRDKCrGhxuUS22BdzkEdzdTKwQ==
X-Received: by 2002:ad4:4f86:: with SMTP id em6mr23625697qvb.7.1630339018672;
        Mon, 30 Aug 2021 08:56:58 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id 12sm8585217qtt.16.2021.08.30.08.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 08:56:58 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 3/9] nfssysfs.py: Add a command for printing individual xprts
Date:   Mon, 30 Aug 2021 11:56:47 -0400
Message-Id: <20210830155653.1386161-4-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830155653.1386161-1-Anna.Schumaker@Netapp.com>
References: <20210830155653.1386161-1-Anna.Schumaker@Netapp.com>
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
 tools/nfssysfs/nfssysfs.py |  2 ++
 tools/nfssysfs/xprt.py     | 38 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/tools/nfssysfs/nfssysfs.py b/tools/nfssysfs/nfssysfs.py
index 90efcbed7ac8..dfad6ac08fa0 100755
--- a/tools/nfssysfs/nfssysfs.py
+++ b/tools/nfssysfs/nfssysfs.py
@@ -11,8 +11,10 @@ parser.set_defaults(func=show_small_help)
 
 
 import switch
+import xprt
 subparser = parser.add_subparsers(title="commands")
 switch.add_command(subparser)
+xprt.add_command(subparser)
 
 
 args = parser.parse_args()
diff --git a/tools/nfssysfs/xprt.py b/tools/nfssysfs/xprt.py
index d37537771c1d..fbdd9bfc9375 100644
--- a/tools/nfssysfs/xprt.py
+++ b/tools/nfssysfs/xprt.py
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
2.33.0

