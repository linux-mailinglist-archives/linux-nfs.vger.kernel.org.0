Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DD92DC9FC
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Dec 2020 01:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgLQAg3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Dec 2020 19:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgLQAg3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Dec 2020 19:36:29 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACF7C0617B0
        for <linux-nfs@vger.kernel.org>; Wed, 16 Dec 2020 16:35:48 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id c12so17784088pfo.10
        for <linux-nfs@vger.kernel.org>; Wed, 16 Dec 2020 16:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S0L6TBHA63pE3eJy5qrtoD1MwTLuMiQthDlfl0U0o90=;
        b=CpVQ6rF/O8Y5s0zXiHU8cRvGhh/4yupdSqDGXCkNFbbjkOOpJ/qgIa/NWRb+hasA6M
         mregbRwSZiHzI9a8W6lcpQJ3W8B7qt0m0l/IEDTxjOAGvcus3MdCU2IuZwNWAO0MLdG7
         rgsPnu7n1Oa9lop1MHUwotJAgACewIGVTCclx5TgR6kd2Fl0A4GpwiVosNwKGV+atxRC
         IctMxufZ3xvZFgkA1XAf5N7x+T7ffuJrlIzo1t46MFpky75G8WVtSa7JFit3SAf0hV9s
         7OYd+FgahPzxaD7tXUl+i5fmuUeNOiCi/Gkolb8HMxD9PpiKIPgk2BLnUisww8myC4II
         9eHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S0L6TBHA63pE3eJy5qrtoD1MwTLuMiQthDlfl0U0o90=;
        b=Ogj/4y0EZm+LOc69u2y4wwn4kPYfP2UELR253Epu6o80XJe3ewPdezXnk8xjI0Fri8
         X1Yp0VlEwthUhinFwg07JkZPKhSw9dMByLI1aU+S9HTKlH+CSO2qSFmWwLm4kHDj4LVf
         yxp5YBOpUptg7GsNIPVOlLyN4s1sNChuTqGlj9ttBF3en4i6cOHeu/ksDoNeJTL19ea6
         +McYuv7Jfye0GAugRZfyqR0lyxA3VzEFcRq39OTMtxoFWPBBXsoTP17nSfA3nta3X0Tz
         W/Nh0ZU0QgWWCLIPPtzyxt3T+671WlqMMSS2XISvKGfrAKeNXGmq+9kt0neYLaBZ1lHN
         oiIg==
X-Gm-Message-State: AOAM5320/Sxyc2EYAaHMNRnl+Sv25absQOTvA62qv1Gh65b26HC31hn5
        x5KX+rvwFgsWNi7AiadxF4YpydZaglYsaQ==
X-Google-Smtp-Source: ABdhPJwECamb5Yks8eExNEAP+sNCIjVv/yVRjXrOEUQMPm3jKVdLa7g47nyzIZdjZkHY3/B0t+uLvQ==
X-Received: by 2002:a63:f02:: with SMTP id e2mr35114651pgl.148.1608165348386;
        Wed, 16 Dec 2020 16:35:48 -0800 (PST)
Received: from garbo.localdomain (c-69-181-67-218.hsd1.ca.comcast.net. [69.181.67.218])
        by smtp.gmail.com with ESMTPSA id v24sm4011243pgi.61.2020.12.16.16.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 16:35:47 -0800 (PST)
From:   Tom Haynes <loghyr@gmail.com>
X-Google-Original-From: Tom Haynes <loghyr@hammerspace.com>
To:     Bruce Fields <bfields@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [pynfs 04/10] flexfiles: Fix up the layout error handling to reflect the previous error
Date:   Wed, 16 Dec 2020 16:35:10 -0800
Message-Id: <20201217003516.75438-5-loghyr@hammerspace.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201217003516.75438-1-loghyr@hammerspace.com>
References: <20201217003516.75438-1-loghyr@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When a client reports a layout error, the server has the choice on the next
LAYOUTGET to:

1) Return NFS4_OK
2) Return NFS4ERR_DELAY as it tries to resolve the issue
3) Return the supplied error and let the client/application handle the issue

Signed-off-by: Tom Haynes <loghyr@hammerspace.com>
---
 nfs4.1/server41tests/st_flex.py | 147 ++++++++++++++++++++++++++------
 1 file changed, 122 insertions(+), 25 deletions(-)

diff --git a/nfs4.1/server41tests/st_flex.py b/nfs4.1/server41tests/st_flex.py
index cbc1166..4defa81 100644
--- a/nfs4.1/server41tests/st_flex.py
+++ b/nfs4.1/server41tests/st_flex.py
@@ -593,8 +593,9 @@ def testFlexLayoutStatsOverflow(t, env):
           [15, 407034683097, 0, 0, 0, 0, 0, 0, 0, 10864914432, 0, 10866487296, 93884, 93628, 406154554429, 1131023767183211]]
     _LayoutStats(t, env, ls)
 
-def layoutget_return(sess, fh, open_stateid, layout_iomode=LAYOUTIOMODE4_RW,
-                     layout_error=None, layout_error_op=OP_WRITE):
+def layoutget_return(sess, fh, open_stateid, allowed_errors=NFS4_OK,
+                     layout_iomode=LAYOUTIOMODE4_RW, layout_error=None,
+                     layout_error_op=OP_WRITE):
     """
     Perform LAYOUTGET and LAYOUTRETURN
     """
@@ -604,7 +605,7 @@ def layoutget_return(sess, fh, open_stateid, layout_iomode=LAYOUTIOMODE4_RW,
            op.layoutget(False, LAYOUT4_FLEX_FILES, layout_iomode,
                         0, NFS4_UINT64_MAX, 4196, open_stateid, 0xffff)]
     res = sess.compound(ops)
-    check(res)
+    check(res, allowed_errors)
     layout_stateid = res.resarray[-1].logr_stateid
 
     # Return layout
@@ -671,10 +672,10 @@ def testFlexLayoutReturnNxioRead(t, env):
     open_stateid = res.resarray[-2].stateid
 
     # Return layout with error
-    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_READ, NFS4ERR_NXIO, OP_READ)
+    layoutget_return(sess, fh, open_stateid, NFS4_OK, LAYOUTIOMODE4_READ, NFS4ERR_NXIO, OP_READ)
 
-    # Obtain another layout
-    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_READ)
+    # Verify error code propagation
+    layoutget_return(sess, fh, open_stateid, [NFS4_OK, NFS4ERR_DELAY, NFS4ERR_NXIO], LAYOUTIOMODE4_READ)
 
     # Close file
     res = close_file(sess, fh, stateid=open_stateid)
@@ -697,10 +698,10 @@ def testFlexLayoutReturnNxioWrite(t, env):
     open_stateid = res.resarray[-2].stateid
 
     # Return layout with error
-    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_RW, NFS4ERR_NXIO, OP_WRITE)
+    layoutget_return(sess, fh, open_stateid, NFS4_OK, LAYOUTIOMODE4_RW, NFS4ERR_NXIO, OP_WRITE)
 
-    # Obtain another layout
-    layoutget_return(sess, fh, open_stateid)
+    # Verify error code propagation
+    layoutget_return(sess, fh, open_stateid, [NFS4_OK, NFS4ERR_DELAY, NFS4ERR_NXIO])
 
     # Close file
     res = close_file(sess, fh, stateid=open_stateid)
@@ -723,7 +724,10 @@ def testFlexLayoutReturnStaleRead(t, env):
     open_stateid = res.resarray[-2].stateid
 
     # Return layout with error
-    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_READ, NFS4ERR_STALE, OP_READ)
+    layoutget_return(sess, fh, open_stateid, NFS4_OK, LAYOUTIOMODE4_READ, NFS4ERR_STALE, OP_READ)
+
+    # Verify error code propagation
+    layoutget_return(sess, fh, open_stateid, [NFS4_OK, NFS4ERR_DELAY, NFS4ERR_STALE])
 
     # Close file
     res = close_file(sess, fh, stateid=open_stateid)
@@ -746,7 +750,10 @@ def testFlexLayoutReturnStaleWrite(t, env):
     open_stateid = res.resarray[-2].stateid
 
     # Return layout with error
-    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_RW, NFS4ERR_STALE, OP_WRITE)
+    layoutget_return(sess, fh, open_stateid, NFS4_OK, LAYOUTIOMODE4_RW, NFS4ERR_STALE, OP_WRITE)
+
+    # Verify error code propagation
+    layoutget_return(sess, fh, open_stateid, [NFS4_OK, NFS4ERR_DELAY, NFS4ERR_STALE])
 
     # Close file
     res = close_file(sess, fh, stateid=open_stateid)
@@ -769,7 +776,10 @@ def testFlexLayoutReturnIoRead(t, env):
     open_stateid = res.resarray[-2].stateid
 
     # Return layout with error
-    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_READ, NFS4ERR_IO, OP_READ)
+    layoutget_return(sess, fh, open_stateid, NFS4_OK, LAYOUTIOMODE4_READ, NFS4ERR_IO, OP_READ)
+
+    # Verify error code propagation
+    layoutget_return(sess, fh, open_stateid, [NFS4_OK, NFS4ERR_DELAY, NFS4ERR_IO])
 
     # Close file
     res = close_file(sess, fh, stateid=open_stateid)
@@ -792,7 +802,10 @@ def testFlexLayoutReturnIoWrite(t, env):
     open_stateid = res.resarray[-2].stateid
 
     # Return layout with error
-    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_RW, NFS4ERR_IO, OP_WRITE)
+    layoutget_return(sess, fh, open_stateid, NFS4_OK, LAYOUTIOMODE4_RW, NFS4ERR_IO, OP_WRITE)
+
+    # Verify error code propagation
+    layoutget_return(sess, fh, open_stateid, [NFS4_OK, NFS4ERR_DELAY, NFS4ERR_IO])
 
     # Close file
     res = close_file(sess, fh, stateid=open_stateid)
@@ -815,7 +828,10 @@ def testFlexLayoutReturnServerFaultRead(t, env):
     open_stateid = res.resarray[-2].stateid
 
     # Return layout with error
-    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_READ, NFS4ERR_SERVERFAULT, OP_READ)
+    layoutget_return(sess, fh, open_stateid, NFS4_OK, LAYOUTIOMODE4_READ, NFS4ERR_SERVERFAULT, OP_READ)
+
+    # Verify error code propagation
+    layoutget_return(sess, fh, open_stateid, [NFS4_OK, NFS4ERR_DELAY, NFS4ERR_SERVERFAULT])
 
     # Close file
     res = close_file(sess, fh, stateid=open_stateid)
@@ -838,15 +854,45 @@ def testFlexLayoutReturnServerFaultWrite(t, env):
     open_stateid = res.resarray[-2].stateid
 
     # Return layout with error
-    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_RW, NFS4ERR_SERVERFAULT, OP_WRITE)
+    layoutget_return(sess, fh, open_stateid, NFS4_OK, LAYOUTIOMODE4_RW, NFS4ERR_SERVERFAULT, OP_WRITE)
+
+    # Verify error code propagation
+    layoutget_return(sess, fh, open_stateid, [NFS4_OK, NFS4ERR_DELAY, NFS4ERR_SERVERFAULT])
+
+    # Close file
+    res = close_file(sess, fh, stateid=open_stateid)
+    check(res)
+
+def testFlexLayoutReturnNospcRead(t, env):
+    """
+    Send LAYOUTRETURN with NFS4ERR_NOSPC on READ
+
+    FLAGS: flex layoutreturn
+    CODE: FFLORNOSPC
+    """
+    name = env.testname(t)
+    sess = env.c1.new_pnfs_client_session(env.testname(t))
+
+    # Create the file
+    res = create_file(sess, name)
+    check(res)
+    fh = res.resarray[-1].object
+    open_stateid = res.resarray[-2].stateid
+
+    # Return layout with error
+    layoutget_return(sess, fh, open_stateid, NFS4_OK, LAYOUTIOMODE4_RW, NFS4ERR_NOSPC, OP_WRITE)
+
+    # Verify error code propagation
+    # Unlike with a WRITE, we should see no error
+    layoutget_return(sess, fh, open_stateid, NFS4_OK, LAYOUTIOMODE4_READ)
 
     # Close file
     res = close_file(sess, fh, stateid=open_stateid)
     check(res)
 
-def testFlexLayoutReturnNospc(t, env):
+def testFlexLayoutReturnNospcWrite(t, env):
     """
-    Send LAYOUTRETURN with NFS4ERR_NOSPC
+    Send LAYOUTRETURN with NFS4ERR_NOSPC on WRITE
 
     FLAGS: flex layoutreturn
     CODE: FFLORNOSPC
@@ -861,15 +907,45 @@ def testFlexLayoutReturnNospc(t, env):
     open_stateid = res.resarray[-2].stateid
 
     # Return layout with error
-    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_RW, NFS4ERR_NOSPC, OP_WRITE)
+    layoutget_return(sess, fh, open_stateid, NFS4_OK, LAYOUTIOMODE4_RW, NFS4ERR_NOSPC, OP_WRITE)
+
+    # Verify error code propagation
+    layoutget_return(sess, fh, open_stateid, [NFS4_OK, NFS4ERR_DELAY, NFS4ERR_NOSPC], LAYOUTIOMODE4_RW)
+
+    # Close file
+    res = close_file(sess, fh, stateid=open_stateid)
+    check(res)
+
+def testFlexLayoutReturnFbigRead(t, env):
+    """
+    Send LAYOUTRETURN with NFS4ERR_FBIG on READ
+
+    FLAGS: flex layoutreturn
+    CODE: FFLORFBIG
+    """
+    name = env.testname(t)
+    sess = env.c1.new_pnfs_client_session(env.testname(t))
+
+    # Create the file
+    res = create_file(sess, name)
+    check(res)
+    fh = res.resarray[-1].object
+    open_stateid = res.resarray[-2].stateid
+
+    # Return layout with error
+    layoutget_return(sess, fh, open_stateid, NFS4_OK, LAYOUTIOMODE4_RW, NFS4ERR_FBIG, OP_WRITE)
+
+    # Verify error code propagation
+    # Unlike with a WRITE, we should see no error
+    layoutget_return(sess, fh, open_stateid, NFS4_OK)
 
     # Close file
     res = close_file(sess, fh, stateid=open_stateid)
     check(res)
 
-def testFlexLayoutReturnFbig(t, env):
+def testFlexLayoutReturnFbigWrite(t, env):
     """
-    Send LAYOUTRETURN with NFS4ERR_FBIG
+    Send LAYOUTRETURN with NFS4ERR_FBIG on WRITE
 
     FLAGS: flex layoutreturn
     CODE: FFLORFBIG
@@ -884,7 +960,10 @@ def testFlexLayoutReturnFbig(t, env):
     open_stateid = res.resarray[-2].stateid
 
     # Return layout with error
-    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_RW, NFS4ERR_FBIG, OP_WRITE)
+    layoutget_return(sess, fh, open_stateid, NFS4_OK, LAYOUTIOMODE4_RW, NFS4ERR_FBIG, OP_WRITE)
+
+    # Verify error code propagation
+    layoutget_return(sess, fh, open_stateid, [NFS4_OK, NFS4ERR_DELAY, NFS4ERR_FBIG])
 
     # Close file
     res = close_file(sess, fh, stateid=open_stateid)
@@ -907,9 +986,12 @@ def testFlexLayoutReturnAccessRead(t, env):
     open_stateid = res.resarray[-2].stateid
 
     # Return layout with error
-    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_READ,
+    layoutget_return(sess, fh, open_stateid, NFS4_OK, LAYOUTIOMODE4_READ,
                      NFS4ERR_ACCESS, OP_READ)
 
+    # Verify error code propagation
+    layoutget_return(sess, fh, open_stateid, [NFS4_OK, NFS4ERR_DELAY, NFS4ERR_ACCESS])
+
     # Close file
     res = close_file(sess, fh, stateid=open_stateid)
     check(res)
@@ -931,9 +1013,12 @@ def testFlexLayoutReturnAccessWrite(t, env):
     open_stateid = res.resarray[-2].stateid
 
     # Return layout with error
-    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_RW,
+    layoutget_return(sess, fh, open_stateid, NFS4_OK, LAYOUTIOMODE4_RW,
                      NFS4ERR_ACCESS, OP_WRITE)
 
+    # Verify error code propagation
+    layoutget_return(sess, fh, open_stateid, [NFS4_OK, NFS4ERR_DELAY, NFS4ERR_ACCESS])
+
     # Close file
     res = close_file(sess, fh, stateid=open_stateid)
     check(res)
@@ -955,7 +1040,10 @@ def testFlexLayoutReturnDelayRead(t, env):
     open_stateid = res.resarray[-2].stateid
 
     # Return layout with error
-    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_READ, NFS4ERR_DELAY, OP_READ)
+    layoutget_return(sess, fh, open_stateid, NFS4_OK, LAYOUTIOMODE4_READ, NFS4ERR_DELAY, OP_READ)
+
+    # Verify error code propagation
+    layoutget_return(sess, fh, open_stateid, [NFS4_OK, NFS4ERR_DELAY])
 
     # Close file
     res = close_file(sess, fh, stateid=open_stateid)
@@ -978,7 +1066,10 @@ def testFlexLayoutReturnDelayWrite(t, env):
     open_stateid = res.resarray[-2].stateid
 
     # Return layout with error
-    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_RW, NFS4ERR_DELAY, OP_WRITE)
+    layoutget_return(sess, fh, open_stateid, NFS4_OK, LAYOUTIOMODE4_RW, NFS4ERR_DELAY, OP_WRITE)
+
+    # Verify error code propagation
+    layoutget_return(sess, fh, open_stateid, [NFS4_OK, NFS4ERR_DELAY])
 
     # Close file
     res = close_file(sess, fh, stateid=open_stateid)
@@ -1006,6 +1097,12 @@ def testFlexLayoutReturn1K(t, env):
         layout_error = None if i % layout_error_ratio else NFS4ERR_ACCESS
         layoutget_return(sess, fh, open_stateid, layout_error=layout_error)
 
+        # Verify error code propagation
+        if layout_error:
+            layoutget_return(sess, fh, open_stateid, [NFS4_OK, NFS4ERR_DELAY, layout_error])
+        else:
+            layoutget_return(sess, fh, open_stateid, NFS4_OK)
+
     # Close file
     res = close_file(sess, fh, stateid=open_stateid)
     check(res)
-- 
2.26.2

