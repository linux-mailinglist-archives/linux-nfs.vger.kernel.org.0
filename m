Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435EA2DF10C
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Dec 2020 19:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgLSSa7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Dec 2020 13:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgLSSa6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Dec 2020 13:30:58 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1650C061282
        for <linux-nfs@vger.kernel.org>; Sat, 19 Dec 2020 10:30:18 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id i7so3465569pgc.8
        for <linux-nfs@vger.kernel.org>; Sat, 19 Dec 2020 10:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3LQht4yEOChBiDnMUvNyM2aEUpD3mDtN6ze6YqfxNVk=;
        b=CIOXdb8YQaE6XlXA2h1o3ZWqZFb7KmCLCnJ7y/2U8zxuhJEQkPJfqtCz1J0ZrKYRn3
         v52SbXXeyUnQo3F3+fNYhLGJi+xqINnXQ57LADSGg0T/aTcUg2Wo5LPm4XD9G6SNTCS3
         tly5RTR4KEpxLqFMVJ5r5svhIe+szkwCe2gA2rnykd2Qe6GvE5E6vmsnRjuq0lrGqd8d
         VJvfVcJ4ZKsLBPPOKbx9eeMJOQmIFx6pKMgxXaDyYLcp8dRFHHMzRkYfFTQzKDsdWcN+
         pyK3nKRYeRmINSq3lf599990Rw7l5zlbxM2Yx217wrs3jU1S0QVwQEx8mNOHBxnwcR2u
         +pBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3LQht4yEOChBiDnMUvNyM2aEUpD3mDtN6ze6YqfxNVk=;
        b=a8CEUzl+ol/40lD3X5SvL3XrXCSm+wCB3FzsHCGdQoq9qPJbEZJvf1WhCvyaJOArjv
         9y5Fy1RxwjBHScKPbt+xRiu+r+FU7zseTEuCVxhab5I1sWcjquo7HhFokl44E5OBVY2B
         kyJnVa/sMhYBl0F1hyc7f5JJguqh/jR3BlM8RPYaySVgQF+AZY4OVgn6H+7dkiKdBmrQ
         t7ZMZ/czyr/hoG9MgcO9MN1/Gyu9IxIyBulBT5N9TgkX9PMW+Pk/IC4f5pPsU/FXkvep
         eyepZSXWCP8owRhPZJKCkwlaB1fqBlmIYxOVP0cSq05H4WFVqBGMZVwDxya5K8OGWl1t
         JQFg==
X-Gm-Message-State: AOAM533ZloNTtZuNl0842vEKnxEHE9QyTZTRFbkOoNkK5fM3+uh2gzkk
        utX+fHq5mku026eG0RGP6VkWZsw6lYbldw==
X-Google-Smtp-Source: ABdhPJzaC9zvZsUiPfajOIIEvwV9kk1iYAB3OuOzundzEKKaWzVYz3nii5ATPzm9EqQkOPaqWp4oYg==
X-Received: by 2002:a62:97:0:b029:1ab:93bf:43a1 with SMTP id 145-20020a6200970000b02901ab93bf43a1mr7025323pfa.75.1608402618236;
        Sat, 19 Dec 2020 10:30:18 -0800 (PST)
Received: from garbo.localdomain (c-69-181-67-218.hsd1.ca.comcast.net. [69.181.67.218])
        by smtp.gmail.com with ESMTPSA id l197sm12318471pfd.97.2020.12.19.10.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 10:30:17 -0800 (PST)
From:   Tom Haynes <loghyr@gmail.com>
X-Google-Original-From: Tom Haynes <loghyr@hammerspace.com>
To:     Bruce Fields <bfields@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [pynfs python3 2/7] st_flex: Use NFS4_MAXFILELEN in layout calls
Date:   Sat, 19 Dec 2020 10:29:43 -0800
Message-Id: <20201219182948.83000-3-loghyr@hammerspace.com>
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
 nfs4.1/server41tests/st_flex.py | 50 ++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/nfs4.1/server41tests/st_flex.py b/nfs4.1/server41tests/st_flex.py
index d70b216..8150054 100644
--- a/nfs4.1/server41tests/st_flex.py
+++ b/nfs4.1/server41tests/st_flex.py
@@ -5,7 +5,7 @@ import nfs_ops
 op = nfs_ops.NFS4ops()
 from .environment import check, fail, create_file, close_file, open_create_file_op
 from xdrdef.nfs4_pack import NFS4Packer as FlexPacker, \
-	NFS4Unpacker as FlexUnpacker
+    NFS4Unpacker as FlexUnpacker
 from nfs4lib import FancyNFS4Packer, get_nfstime
 
 current_stateid = stateid4(1, '\0' * 12)
@@ -69,11 +69,11 @@ def testFlexGetLayout(t, env):
     open_stateid = res.resarray[-2].stateid
     ops = [op.putfh(fh),
            op.layoutget(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_READ,
-                        0, 0xffffffffffffffff, 4196, open_stateid, 0xffff)]
+                        0, NFS4_MAXFILELEN, 4196, open_stateid, 0xffff)]
     res = sess.compound(ops)
     check(res)
     # Parse opaque
-    for layout in  res.resarray[-1].logr_layout:
+    for layout in res.resarray[-1].logr_layout:
         if layout.loc_type == LAYOUT4_FLEX_FILES:
             p = FlexUnpacker(layout.loc_body)
             opaque = p.unpack_ff_layout4()
@@ -98,7 +98,7 @@ def testFlexLayoutReturnFile(t, env):
     open_stateid = res.resarray[-2].stateid
     ops = [op.putfh(fh),
            op.layoutget(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_READ,
-                        0, 0xffffffffffffffff, 4196, open_stateid, 0xffff)]
+                        0, NFS4_MAXFILELEN, 4196, open_stateid, 0xffff)]
     res = sess.compound(ops)
     check(res)
     # Return layout
@@ -106,7 +106,7 @@ def testFlexLayoutReturnFile(t, env):
     ops = [op.putfh(fh),
            op.layoutreturn(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_ANY,
                            layoutreturn4(LAYOUTRETURN4_FILE,
-                                         layoutreturn_file4(0, 0xffffffffffffffff, layout_stateid, "")))]
+                                         layoutreturn_file4(0, NFS4_MAXFILELEN, layout_stateid, "")))]
     res = sess.compound(ops)
     check(res)
     res = close_file(sess, fh, stateid=open_stateid)
@@ -132,7 +132,7 @@ def testFlexLayoutOldSeqid(t, env):
     ops = [op.putfh(fh),
            op.layoutget(False, LAYOUT4_FLEX_FILES,
                         LAYOUTIOMODE4_RW,
-                        0, 0xffffffffffffffff, 8192, open_stateid, 0xffff)]
+                        0, NFS4_MAXFILELEN, 8192, open_stateid, 0xffff)]
     res = sess.compound(ops)
     check(res)
     lo_stateid = res.resarray[-1].logr_stateid
@@ -144,7 +144,7 @@ def testFlexLayoutOldSeqid(t, env):
     ops = [op.putfh(fh),
            op.layoutget(False, LAYOUT4_FLEX_FILES,
                         LAYOUTIOMODE4_RW,
-                        0, 0xffffffffffffffff, 8192, lo_stateid, 0xffff)]
+                        0, NFS4_MAXFILELEN, 8192, lo_stateid, 0xffff)]
     res = sess.compound(ops)
     check(res)
     lo_stateid2 = res.resarray[-1].logr_stateid
@@ -156,7 +156,7 @@ def testFlexLayoutOldSeqid(t, env):
     ops = [op.putfh(fh),
            op.layoutget(False, LAYOUT4_FLEX_FILES,
                         LAYOUTIOMODE4_RW,
-                        0, 0xffffffffffffffff, 8192, lo_stateid, 0xffff)]
+                        0, NFS4_MAXFILELEN, 8192, lo_stateid, 0xffff)]
     res = sess.compound(ops)
     check(res)
     lo_stateid3 = res.resarray[-1].logr_stateid
@@ -167,7 +167,7 @@ def testFlexLayoutOldSeqid(t, env):
     ops = [op.putfh(fh),
            op.layoutreturn(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_ANY,
                            layoutreturn4(LAYOUTRETURN4_FILE,
-                                         layoutreturn_file4(0, 0xffffffffffffffff, lo_stateid, "")))]
+                                         layoutreturn_file4(0, NFS4_MAXFILELEN, lo_stateid, "")))]
     res = sess.compound(ops)
     check(res, NFS4ERR_OLD_STATEID, "LAYOUTRETURN with an old stateid")
     res = close_file(sess, fh, stateid=open_stateid)
@@ -192,8 +192,8 @@ def testFlexLayoutStress(t, env):
     for i in range(1000):
         ops = [op.putfh(fh),
                op.layoutget(False, LAYOUT4_FLEX_FILES,
-                            LAYOUTIOMODE4_READ if i%2  else LAYOUTIOMODE4_RW,
-                            0, 0xffffffffffffffff, 8192, lo_stateid, 0xffff)]
+                            LAYOUTIOMODE4_READ if i%2 else LAYOUTIOMODE4_RW,
+                            0, NFS4_MAXFILELEN, 8192, lo_stateid, 0xffff)]
         res = sess.compound(ops)
         check(res)
         lo_stateid = res.resarray[-1].logr_stateid
@@ -203,7 +203,7 @@ def testFlexLayoutStress(t, env):
     ops = [op.putfh(fh),
            op.layoutreturn(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_ANY,
                            layoutreturn4(LAYOUTRETURN4_FILE,
-                                         layoutreturn_file4(0, 0xffffffffffffffff, lo_stateid, "")))]
+                                         layoutreturn_file4(0, NFS4_MAXFILELEN, lo_stateid, "")))]
     res = sess.compound(ops)
     check(res)
     res = close_file(sess, fh, stateid=open_stateid)
@@ -227,7 +227,7 @@ def testFlexGetDevInfo(t, env):
     ops = [op.putfh(fh),
            op.layoutget(False, LAYOUT4_FLEX_FILES,
                         LAYOUTIOMODE4_RW,
-                        0, 0xffffffffffffffff, 8192, lo_stateid, 0xffff)]
+                        0, NFS4_MAXFILELEN, 8192, lo_stateid, 0xffff)]
     res = sess.compound(ops)
     check(res)
     lo_stateid = res.resarray[-1].logr_stateid
@@ -251,7 +251,7 @@ def testFlexGetDevInfo(t, env):
     ops = [op.putfh(fh),
            op.layoutreturn(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_ANY,
                            layoutreturn4(LAYOUTRETURN4_FILE,
-                                         layoutreturn_file4(0, 0xffffffffffffffff, lo_stateid, "")))]
+                                         layoutreturn_file4(0, NFS4_MAXFILELEN, lo_stateid, "")))]
     res = sess.compound(ops)
     check(res)
     res = close_file(sess, fh, stateid=open_stateid)
@@ -275,7 +275,7 @@ def testFlexLayoutTestAccess(t, env):
     ops = [op.putfh(fh),
            op.layoutget(False, LAYOUT4_FLEX_FILES,
                         LAYOUTIOMODE4_RW,
-                        0, 0xffffffffffffffff, 8192, open_stateid, 0xffff)]
+                        0, NFS4_MAXFILELEN, 8192, open_stateid, 0xffff)]
     res = sess.compound(ops)
     check(res)
     lo_stateid = res.resarray[-1].logr_stateid
@@ -295,7 +295,7 @@ def testFlexLayoutTestAccess(t, env):
     ops = [op.putfh(fh),
            op.layoutget(False, LAYOUT4_FLEX_FILES,
                         LAYOUTIOMODE4_READ,
-                        0, 0xffffffffffffffff, 8192, lo_stateid, 0xffff)]
+                        0, NFS4_MAXFILELEN, 8192, lo_stateid, 0xffff)]
     res = sess.compound(ops)
     check(res)
     lo_stateid = res.resarray[-1].logr_stateid
@@ -342,7 +342,7 @@ def testFlexLayoutStatsSmall(t, env):
         open_op = open_create_file_op(sess, env.testname(t) + str(i), open_create=OPEN4_CREATE)
         res = sess.compound( open_op +
                [op.layoutget(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_RW,
-                            0, 0xffffffffffffffff, 4196, current_stateid, 0xffff)])
+                            0, NFS4_MAXFILELEN, 4196, current_stateid, 0xffff)])
         check(res, NFS4_OK)
         lo_stateid = res.resarray[-1].logr_stateid
         fh = res.resarray[-2].object
@@ -395,7 +395,7 @@ def testFlexLayoutStatsSmall(t, env):
         ops = [op.putfh(fh),
                op.layoutreturn(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_ANY,
                                layoutreturn4(LAYOUTRETURN4_FILE,
-                                             layoutreturn_file4(0, 0xffffffffffffffff, lo_stateid, p.get_buffer()))),
+                                             layoutreturn_file4(0, NFS4_MAXFILELEN, lo_stateid, p.get_buffer()))),
                op.close(0, open_stateid)]
         res = sess.compound(ops)
         check(res)
@@ -415,7 +415,7 @@ def _LayoutStats(t, env, stats):
     ops = [op.putfh(fh),
            op.layoutget(False, LAYOUT4_FLEX_FILES,
                         LAYOUTIOMODE4_RW,
-                        0, 0xffffffffffffffff, 8192, lo_stateid, 0xffff)]
+                        0, NFS4_MAXFILELEN, 8192, lo_stateid, 0xffff)]
     res = sess.compound(ops)
     check(res)
     lo_stateid = res.resarray[-1].logr_stateid
@@ -455,7 +455,7 @@ def _LayoutStats(t, env, stats):
 
         # Did not capture these in the gathered traces
         offset = 0
-        file_length = 0xffffffffffffffff
+        file_length = NFS4_MAXFILELEN
         rd_io.ii_count = 0
         rd_io.ii_bytes = 0
         wr_io.ii_count = 0
@@ -492,7 +492,7 @@ def _LayoutStats(t, env, stats):
     ops = [op.putfh(fh),
            op.layoutreturn(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_ANY,
                            layoutreturn4(LAYOUTRETURN4_FILE,
-                                         layoutreturn_file4(0, 0xffffffffffffffff, lo_stateid, "")))]
+                                         layoutreturn_file4(0, NFS4_MAXFILELEN, lo_stateid, "")))]
     res = sess.compound(ops)
     check(res)
     res = close_file(sess, fh, stateid=open_stateid)
@@ -602,7 +602,7 @@ def layoutget_return(sess, fh, open_stateid, allowed_errors=NFS4_OK,
     # Get layout
     ops = [op.putfh(fh),
            op.layoutget(False, LAYOUT4_FLEX_FILES, layout_iomode,
-                        0, NFS4_UINT64_MAX, 4196, open_stateid, 0xffff)]
+                        0, NFS4_MAXFILELEN, 4196, open_stateid, 0xffff)]
     res = sess.compound(ops)
     check(res, allowed_errors)
     if nfsstat4[res.status] is not 'NFS4_OK':
@@ -614,7 +614,7 @@ def layoutget_return(sess, fh, open_stateid, allowed_errors=NFS4_OK,
         ops = [op.putfh(fh),
                op.layoutreturn(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_ANY,
                                layoutreturn4(LAYOUTRETURN4_FILE,
-                                             layoutreturn_file4(0, NFS4_UINT64_MAX,
+                                             layoutreturn_file4(0, NFS4_MAXFILELEN,
                                                                 layout_stateid, "")))]
     else:  # Return layout with error
         # Get device id
@@ -625,7 +625,7 @@ def layoutget_return(sess, fh, open_stateid, allowed_errors=NFS4_OK,
 
         deviceid = layout.ffl_mirrors[0].ffm_data_servers[0].ffds_deviceid
         deverr = device_error4(deviceid, layout_error, layout_error_op)
-        ffioerr = ff_ioerr4(0, NFS4_UINT64_MAX, layout_stateid, [deverr])
+        ffioerr = ff_ioerr4(0, NFS4_MAXFILELEN, layout_stateid, [deverr])
         fflr = ff_layoutreturn4([ffioerr], [])
 
         p = FlexPacker()
@@ -634,7 +634,7 @@ def layoutget_return(sess, fh, open_stateid, allowed_errors=NFS4_OK,
         ops = [op.putfh(fh),
                op.layoutreturn(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_ANY,
                                layoutreturn4(LAYOUTRETURN4_FILE,
-                                             layoutreturn_file4(0, NFS4_UINT64_MAX,
+                                             layoutreturn_file4(0, NFS4_MAXFILELEN,
                                                                 layout_stateid,
                                                                 p.get_buffer())))]
 
-- 
2.26.2

