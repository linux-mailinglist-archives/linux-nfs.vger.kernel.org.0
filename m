Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D633FB982
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Aug 2021 17:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbhH3P6G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Aug 2021 11:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237691AbhH3P6A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Aug 2021 11:58:00 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0C7C0617A8
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 08:57:03 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id c10so16120582qko.11
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 08:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nn0vCR8th2Ujh0diRLRkmzEOc/OiB5yqXqEnV1zuwXk=;
        b=aofICgMPQWnGwrioK9GaQkdCccbfs6Flt0dnoj46BJ074xyh+3bvs0fq9FU/KW3hFm
         hSeMuGi0GTVCfBfjWh5idwKul21c/q01/ptnHcUz8TjqFtaruLbqZ4PMYDI47uUuVBYI
         Zx28BfcsaM47fimlKiqOPPxOrICKnqWQ2FHNSp4/N2Afy6P2wdJvtC3ucCZqK04DpdIy
         qMyqgTmU5V2nwAWFJDfN6Uk3yrg3t+JQrd+alUcejsQnMP3rnEmwUg9dtAhnwaxfKxmX
         XtMQSRogYsGGXUlFC+Biv7Hpp4Wvt+mT8WZ6836VgDh21KXVesp/LmCv4imbEdjaV6pd
         tU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=nn0vCR8th2Ujh0diRLRkmzEOc/OiB5yqXqEnV1zuwXk=;
        b=nObRvIDXZ+atoCnqgJ6nID55/ylJE4Mp38YhIGh0NuYvxee7naHsQtErC3ohzIO3jJ
         Sy8xIRu/4Sy3O0gcB98OTfWsfHxUpqiwXrb4Cq3TLU3S0eSLWw7JSmdrn99fH/P0OXmL
         YkuRLudMgMF0iQqyqRXuD85BrLd0oS8Nb2eHG/jljBgTsd3F2Bbs9OyDpYTF3PFBU3wh
         ASlHb0++B4N5S1eoAhBYseHkl2e2elmxr723BpAI4bi/dLEEDccgO2MRU+4h7BaF4tm8
         z8Hk8YRSStxMUVHPscWEraEROQsICTWU73YC4Sj4RUJNHcXBdMNRIfZjCN2rCvdMNd4/
         JuAQ==
X-Gm-Message-State: AOAM5311vmlz1kMSyLzg/ARdO/xKbj8FFSZMyBP/pq7jcLey1Q+1hnF/
        zXpMYyO3NiTsfGVhJj2RVcuM/QMINgWexA==
X-Google-Smtp-Source: ABdhPJwWSvX2iFR6/huuk//RioehfKwWwFu6Dh0do4Qw7RVD2nPpAo+l7gPxxpH3RIJDqZgzbVPLsQ==
X-Received: by 2002:a05:620a:799:: with SMTP id 25mr22807928qka.119.1630339022912;
        Mon, 30 Aug 2021 08:57:02 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id 12sm8585217qtt.16.2021.08.30.08.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 08:57:02 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 7/9] nfssysfs.py: Add a command for changing xprt state
Date:   Mon, 30 Aug 2021 11:56:51 -0400
Message-Id: <20210830155653.1386161-8-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830155653.1386161-1-Anna.Schumaker@Netapp.com>
References: <20210830155653.1386161-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

We can set it offline or online, or we can remove an xprt. The kernel
only supports removing offlined transports, so we make sure to set the
state to "offline" before sending the remove command.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
v3: Don't compare booleans against True / False
---
 tools/nfssysfs/xprt.py | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/nfssysfs/xprt.py b/tools/nfssysfs/xprt.py
index 2160cb0a9575..9426c99dae2b 100644
--- a/tools/nfssysfs/xprt.py
+++ b/tools/nfssysfs/xprt.py
@@ -8,15 +8,18 @@ class Xprt:
         self.type = str(path).rsplit("-", 2)[2]
         self.dstaddr = open(path / "dstaddr", 'r').readline().strip()
         self.srcaddr = open(path / "srcaddr", 'r').readline().strip()
+        self.exists = True
 
-        with open(path / "xprt_state") as f:
-            self.state = ','.join(f.readline().split()[1:])
+        self.read_state()
         self.__dict__.update(sysfs.read_info_file(path / "xprt_info"))
 
     def __lt__(self, rhs):
         return self.id < rhs.id
 
     def __str__(self):
+        if not self.exists:
+            return "xprt %s: has been removed" % self.id
+
         state = self.state
         if self.main_xprt:
             state = "MAIN," + self.state
@@ -31,6 +34,13 @@ class Xprt:
                 (self.binding_q_len, self.sending_q_len, self.pending_q_len, self.backlog_q_len, self.tasks_queuelen)
         return line
 
+    def read_state(self):
+        if not self.path.exists():
+            self.exists = False
+            return
+        with open(self.path / "xprt_state") as f:
+            self.state = ','.join(f.readline().split()[1:])
+
     def small_str(self):
         return "xprt %s: %s, %s%s" % (self.id, self.type, self.dstaddr,
                                      f" [main]" if self.main_xprt else "" )
@@ -41,6 +51,11 @@ class Xprt:
             f.write(resolved)
         self.dstaddr = open(self.path / "dstaddr", 'r').readline().strip()
 
+    def set_state(self, state):
+        with open(self.path / "xprt_state", 'w') as f:
+            f.write(state)
+        self.read_state()
+
 
 def list_xprts(args):
     xprts = [ Xprt(f) for f in (sysfs.SUNRPC / "xprt-switches").glob("**/xprt-*") ]
@@ -60,6 +75,13 @@ def set_xprt_property(args):
     try:
         if args.dstaddr != None:
             xprt.set_dstaddr(args.dstaddr[0])
+        if args.offline:
+            xprt.set_state("offline")
+        elif args.online:
+            xprt.set_state("online")
+        elif args.remove:
+            xprt.set_state("offline")
+            xprt.set_state("remove")
         print(xprt)
     except Exception as e:
         print(e)
@@ -73,4 +95,7 @@ def add_command(subparser):
     parser = subparser.add_parser("set", help="Set an xprt property")
     parser.add_argument("--id", metavar="ID", nargs=1, type=int, required=True, help="Id of a specific xprt to modify")
     parser.add_argument("--dstaddr", metavar="dstaddr", nargs=1, type=str, help="New dstaddr to set")
+    parser.add_argument("--offline", action="store_true", help="Set an xprt offline")
+    parser.add_argument("--online", action="store_true", help="Set an offline xprt back online")
+    parser.add_argument("--remove", action="store_true", help="Remove an xprt")
     parser.set_defaults(func=set_xprt_property)
-- 
2.33.0

