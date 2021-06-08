Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2076239FE18
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 19:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhFHRs6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 13:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbhFHRs4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 13:48:56 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3BAC061574
        for <linux-nfs@vger.kernel.org>; Tue,  8 Jun 2021 10:47:02 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id u20so7682172qtx.1
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jun 2021 10:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z6FZgD22GFRX+KNepHUoNKIvyYh3M6iGZgZLu1+bisQ=;
        b=G7J/a9HzfPh8GmRG24DmjIadU54IYP4T1yjoC80GqhH3nbPPrgo8G1Qsl64QtfII/A
         nhe2diAmZujWcPEi0QyxuVrXqSpyZ9vHR5SDgpP6T2kFlkIYE9edVZIooWVRIAGSzAUd
         gHfxdsHcSLZD2XQxFGU/td00MkwTeOtEY89nEgP22APJbkBZjD2e2g1o8Ki7RJSwKFoM
         B+aURHSmb/8UBuiUa8f8PPRDSt/dJblWYe7EVDNfcseEVoIZ+l6t1JX5oyV4hAv2csV9
         CO4qZyjDodpa6Tz2FGVO825ANgDXxUBAQdwUmrmSD5B5jbkUlN4xcp8Car2TqVsBmFCi
         aSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=z6FZgD22GFRX+KNepHUoNKIvyYh3M6iGZgZLu1+bisQ=;
        b=aocFBus165vitwvjLy7Xfi4KxtJyp4wtgTX3jVjOTp5Irms8KnvWQPw3Lq4Gr09BZk
         5E5E2ZNDf1/jGOtHtrrrRupwHcu/MxyDweVDA0XckMeDsWMGy35Mw6DBamxWnZYUqcR0
         gTo2825y5xIlTDKw6AQUlg02+ZH59UEmvr3ukGnemS5h7tnt517qtoj2egmVE1SGu8Ew
         55u7XWVQB1Pnr5y4QXCeHSNgezhE+TaOLu1HrsWNhLAlXdvM9CQ7n4FrKELbZqDjMLT4
         fTjq6fWsIprKolEX81FqEpa4YQY5sNulfPGNyAGRGJH9sIqRBSU9QEZ2nv7ZWS5nQ1Ex
         OWEg==
X-Gm-Message-State: AOAM532uKeJrEHpGZFxklk+L9H9x//CjHU0jPZwLd3up11Ry6IoSuuzx
        MuEm5XJvxNp5QYmD2VKm1xtPJ4G1d90=
X-Google-Smtp-Source: ABdhPJwm3Ce+6Q5xZ27vkKO48t1JQcMkhua2BFg/dKCaMslNsqjtLbGLsqKtkwU8Lno/ycjWj7uWYA==
X-Received: by 2002:a05:622a:100e:: with SMTP id d14mr1874630qte.254.1623174421494;
        Tue, 08 Jun 2021 10:47:01 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id h2sm12963080qkf.106.2021.06.08.10.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:47:01 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [RFC PATCH 3/6] nfs-sysfs.py: Add a command for printing individual xprts
Date:   Tue,  8 Jun 2021 13:46:54 -0400
Message-Id: <20210608174657.603256-4-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608174657.603256-1-Anna.Schumaker@Netapp.com>
References: <20210608174657.603256-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This shows more detailed information than what is presented with xprt
switches.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 tools/nfs-sysfs/nfs-sysfs.py |  2 ++
 tools/nfs-sysfs/xprt.py      | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

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
index d37537771c1d..b95fb2d48829 100644
--- a/tools/nfs-sysfs/xprt.py
+++ b/tools/nfs-sysfs/xprt.py
@@ -1,3 +1,5 @@
+import sysfs
+
 class Xprt:
     def __init__(self, path):
         self.path = path
@@ -5,8 +7,34 @@ class Xprt:
         self.type = str(path).rsplit("-", 2)[2]
         self.dstaddr = open(path / "dstaddr", 'r').readline().strip()
 
+        with open(path / "xprt_state") as f:
+            self.state = ','.join(f.readline().split()[1:])
+        self.__dict__.update(sysfs.read_info_file(path / "xprt_info"))
+
     def __lt__(self, rhs):
         return self.id < rhs.id
 
+    def __str__(self):
+        line = "xprt %s: %s, %s, state <%s>, num_reqs %s" % \
+                (self.id, self.type, self.dstaddr, self.state, self.num_reqs)
+        line += "\n	cur_cong %s, cong_win %s, min_num_slots %s, max_num_slots %s" % \
+                (self.cur_cong, self.cong_win, self.min_num_slots, self.max_num_slots)
+        line += "\n	binding_q_len %s, sending_q_len %s, pending_q_len %s, backlog_q_len %s" % \
+                (self.binding_q_len, self.sending_q_len, self.pending_q_len, self.backlog_q_len)
+        return line
+
     def small_str(self):
         return "xprt %s: %s, %s" % (self.id, self.type, self.dstaddr)
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

