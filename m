Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64132DF111
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Dec 2020 19:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbgLSSbi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Dec 2020 13:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbgLSSbi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Dec 2020 13:31:38 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16C3C0611C5
        for <linux-nfs@vger.kernel.org>; Sat, 19 Dec 2020 10:30:23 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id w6so3600616pfu.1
        for <linux-nfs@vger.kernel.org>; Sat, 19 Dec 2020 10:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s6bMc0aGhzA4oq/xkgQc+hzFOQE775/LkpcBnjPq4e0=;
        b=L0kU7eh3D0EepnHq0Hw8kiF8GSBtjHkoEly7BKQUhnLSZUnBdZEPpyPHYQ+3ppsiNd
         ZwiyfIIJk77GWlHTauT06F+X179yvW8OB8VanB2diUDpv6OJ+UDWcuoVevM8AsXdU8Xk
         uxmfNCl/OkYvcMZwLZJKn1CCs+oPTDv6lW02KNDZfQLpvvI2O38cG34ArwhcnuK9rgec
         xCg2Mq0E5YaFMj5uUHtjBiU1kSGu13IobCi9WkWAF+HPfEG+UFUMWb+wo3eiNKbpYxIH
         nXpDEHZwnWe0U5XxvtYJ8qEcUbDDHAxhS5eUWedGNivr5GIReOx6KplTsGdDl8g5fazF
         FLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s6bMc0aGhzA4oq/xkgQc+hzFOQE775/LkpcBnjPq4e0=;
        b=hN5dI8uYJc9lohO9RYk3igZ5c1jmEgG8arxjekb+e3Dz2xPZJOSiGeCJyzgm0srjgu
         RmTg4IMR0fgRejE/0xl1TQkZBq1K7Ot+MSZDE90OSdm8dyC3NtR4lOAWVHdSed3Bq9xd
         mMXCG536xMItmb3OcFjOk2VqpmrkIrCGl1YilqSi7JnREdnjyFbjD/vcpHK4pQH6JTjI
         2Ij9izpn14hzB+IIGXHfZRG5NK3ewp6HV05xA3i3iLDsfppGXKD+49czk5BlpzjN4bXP
         XkAmX48sdlPMUE41ZQlqx3seyunC4MGNbBI/regbYy0kWsa4WJTUrWWtQdFGXU3kiLpR
         z82w==
X-Gm-Message-State: AOAM533GOHfKfK4x9ibjmKjWbbVUgACoOs2EGat+o7Sk9X5zoXhRh3Hx
        IOSJicMju2zatTYmaFAMh668Fu+hzysxzA==
X-Google-Smtp-Source: ABdhPJyHGJNJdTs+H1TOfWmYM/wWlF/5AENw8sbEmYPoZ/dpGbqGCfxQbH6WXEpqNbmf9CyubZQs2g==
X-Received: by 2002:a63:2045:: with SMTP id r5mr9257428pgm.6.1608402623404;
        Sat, 19 Dec 2020 10:30:23 -0800 (PST)
Received: from garbo.localdomain (c-69-181-67-218.hsd1.ca.comcast.net. [69.181.67.218])
        by smtp.gmail.com with ESMTPSA id l197sm12318471pfd.97.2020.12.19.10.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 10:30:22 -0800 (PST)
From:   Tom Haynes <loghyr@gmail.com>
X-Google-Original-From: Tom Haynes <loghyr@hammerspace.com>
To:     Bruce Fields <bfields@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [pynfs python3 6/7] st_flex: Return the layout before closing the file
Date:   Sat, 19 Dec 2020 10:29:47 -0800
Message-Id: <20201219182948.83000-7-loghyr@hammerspace.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201219182948.83000-1-loghyr@hammerspace.com>
References: <20201219182948.83000-1-loghyr@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Tom Haynes <loghyr@excfb.com>

Signed-off-by: Tom Haynes <loghyr@excfb.com>
---
 nfs4.1/server41tests/st_flex.py | 40 +++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/nfs4.1/server41tests/st_flex.py b/nfs4.1/server41tests/st_flex.py
index 3aae441..2b1820c 100644
--- a/nfs4.1/server41tests/st_flex.py
+++ b/nfs4.1/server41tests/st_flex.py
@@ -56,6 +56,15 @@ def testStateid1(t, env):
         # the server increments by one the value of the "seqid" in each
         # subsequent LAYOUTGET and LAYOUTRETURN response,
         check_seqid(lo_stateid, i + 2)
+
+    ops = [op.putfh(fh),
+           op.layoutreturn(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_ANY,
+                           layoutreturn4(LAYOUTRETURN4_FILE,
+                                         layoutreturn_file4(0, NFS4_MAXFILELEN,
+                                                            lo_stateid, empty_p.get_buffer())))]
+    res = sess.compound(ops)
+    check(res)
+
     res = close_file(sess, fh, stateid=open_stateid)
     check(res)
 
@@ -79,13 +88,13 @@ def testFlexLayoutReturnFile(t, env):
     res = sess.compound(ops)
     check(res)
     # Return layout
-    layout_stateid = res.resarray[-1].logr_stateid
+    lo_stateid = res.resarray[-1].logr_stateid
 
     ops = [op.putfh(fh),
            op.layoutreturn(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_ANY,
                            layoutreturn4(LAYOUTRETURN4_FILE,
                                          layoutreturn_file4(0, NFS4_MAXFILELEN,
-                                                            layout_stateid, empty_p.get_buffer())))]
+                                                            lo_stateid, empty_p.get_buffer())))]
     res = sess.compound(ops)
     check(res)
     res = close_file(sess, fh, stateid=open_stateid)
@@ -150,6 +159,15 @@ def testFlexLayoutOldSeqid(t, env):
                                                             lo_stateid, empty_p.get_buffer())))]
     res = sess.compound(ops)
     check(res, NFS4ERR_OLD_STATEID, "LAYOUTRETURN with an old stateid")
+
+    ops = [op.putfh(fh),
+           op.layoutreturn(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_ANY,
+                           layoutreturn4(LAYOUTRETURN4_FILE,
+                                         layoutreturn_file4(0, NFS4_MAXFILELEN,
+                                                            lo_stateid3, empty_p.get_buffer())))]
+    res = sess.compound(ops)
+    check(res)
+
     res = close_file(sess, fh, stateid=open_stateid)
     check(res)
 
@@ -260,8 +278,8 @@ def testFlexLayoutTestAccess(t, env):
                         0, NFS4_MAXFILELEN, 8192, open_stateid, 0xffff)]
     res = sess.compound(ops)
     check(res)
-    lo_stateid = res.resarray[-1].logr_stateid
-    check_seqid(lo_stateid, 1)
+    lo_stateid1 = res.resarray[-1].logr_stateid
+    check_seqid(lo_stateid1, 1)
 
     layout = res.resarray[-1].logr_layout[-1]
     p = FlexUnpacker(layout.loc_body)
@@ -277,11 +295,11 @@ def testFlexLayoutTestAccess(t, env):
     ops = [op.putfh(fh),
            op.layoutget(False, LAYOUT4_FLEX_FILES,
                         LAYOUTIOMODE4_READ,
-                        0, NFS4_MAXFILELEN, 8192, lo_stateid, 0xffff)]
+                        0, NFS4_MAXFILELEN, 8192, lo_stateid1, 0xffff)]
     res = sess.compound(ops)
     check(res)
-    lo_stateid = res.resarray[-1].logr_stateid
-    check_seqid(lo_stateid, 2)
+    lo_stateid2 = res.resarray[-1].logr_stateid
+    check_seqid(lo_stateid2, 2)
 
     layout = res.resarray[-1].logr_layout[-1]
     p = FlexUnpacker(layout.loc_body)
@@ -300,6 +318,14 @@ def testFlexLayoutTestAccess(t, env):
     if gid_rw != gid_rd:
         fail("Expected gid_rd == %s, got %s" % (gid_rd, gid_rw))
 
+    ops = [op.putfh(fh),
+           op.layoutreturn(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_ANY,
+                           layoutreturn4(LAYOUTRETURN4_FILE,
+                                         layoutreturn_file4(0, NFS4_MAXFILELEN,
+                                                            lo_stateid2, empty_p.get_buffer())))]
+    res = sess.compound(ops)
+    check(res)
+
     res = close_file(sess, fh, stateid=open_stateid)
     check(res)
 
-- 
2.26.2

