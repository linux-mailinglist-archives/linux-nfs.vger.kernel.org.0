Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14792DC9F9
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Dec 2020 01:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgLQAgZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Dec 2020 19:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgLQAgZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Dec 2020 19:36:25 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F51C06179C
        for <linux-nfs@vger.kernel.org>; Wed, 16 Dec 2020 16:35:45 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id v2so284199pfm.9
        for <linux-nfs@vger.kernel.org>; Wed, 16 Dec 2020 16:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6gl/ZxmudKiOInkEX2YpRjeY8LLZyAFpvcd5s9PBVm8=;
        b=Z3ft5EdgKgvd1icRjwrqGWXSsp1CFapSInqH8geMsnG0YYrvXniOL4NcvZt7n/8Z3A
         agc1aCIbfDQRD9+I2X8WFiTu9TD8Fcx1/FL+4TBmJCui0aGqpeVSDEcQhHl3aVfGYmxq
         F4uaTt/pHlZVGj8jnYmSL11YhuVn9nRtCD4cVJCbyTbwCST8wogXMJwUdcvP3QVWAhDd
         JDTfeFc7/8XjXp25/RXXEkV6+ekKiRNdIDzpWv2eSZ5UEtyhBb72ZxABdPOBJqgujBgf
         PDvyh+6Umu8Y5hBg3G1kuSdGH/+n4Taedg3UEkgs/nGDh/xsctIQLaShNrW3VyrbaaFP
         iUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6gl/ZxmudKiOInkEX2YpRjeY8LLZyAFpvcd5s9PBVm8=;
        b=Q3Xztwl+O6J2ef7QPFHRFSFBw9A8X3zWmFqSeiHsiy7AiXSt8wAt4tWAV6rv9eKe+e
         KEKdqWUJtQP5/5aLNip5H3sesHGwW+p4UcHDy2cGQq19orIlP1AGCf7j5wAr6tG4LQ5s
         NXMYguhcFog9Jt22fP0i8guZKM2nkmMyvJj8EMhDqcAaGeacFz4oXRe+pSs2x+s/ytV9
         e/HdU8736eTIoi9RZNkVbpFi7CdbFHJPqE8vU6cdwc+C4c6bw4HDRjXF4AFFRVcY6eVH
         4KsekR+eIVyIkrjU/N9RNMbk28NYYKBR27dMfa1UBwWn6K/fTbPWHEZodCPsyRRV6697
         R7yA==
X-Gm-Message-State: AOAM5318sO8jZERz2KAI3FGNmQq7rLBDQ1kdSw1XRm901dnhh7lnYrMQ
        /U4fTGXXua9n+LSgxTcXmqGULs1shrXzIw==
X-Google-Smtp-Source: ABdhPJzUp1Tb66bMDBs9SroMT0Y2PID/1t0rgG+YrK0lHKVKC+ufuyhxtv4XVgmAvKcoQw/SA8HvvA==
X-Received: by 2002:a63:cd12:: with SMTP id i18mr35009164pgg.173.1608165344670;
        Wed, 16 Dec 2020 16:35:44 -0800 (PST)
Received: from garbo.localdomain (c-69-181-67-218.hsd1.ca.comcast.net. [69.181.67.218])
        by smtp.gmail.com with ESMTPSA id v24sm4011243pgi.61.2020.12.16.16.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 16:35:44 -0800 (PST)
From:   Tom Haynes <loghyr@gmail.com>
X-Google-Original-From: Tom Haynes <loghyr@hammerspace.com>
To:     Bruce Fields <bfields@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [pynfs 01/10] st_flex.py - Added tests for LAYOUTRETURN with errors
Date:   Wed, 16 Dec 2020 16:35:07 -0800
Message-Id: <20201217003516.75438-2-loghyr@hammerspace.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201217003516.75438-1-loghyr@hammerspace.com>
References: <20201217003516.75438-1-loghyr@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Jean Spector <jean@primarydata.com>

---
 nfs4.1/server41tests/st_flex.py | 417 ++++++++++++++++++++++++++++++++
 1 file changed, 417 insertions(+)

diff --git a/nfs4.1/server41tests/st_flex.py b/nfs4.1/server41tests/st_flex.py
index f4ac739..a1d1f8c 100644
--- a/nfs4.1/server41tests/st_flex.py
+++ b/nfs4.1/server41tests/st_flex.py
@@ -592,3 +592,420 @@ def testFlexLayoutStatsOverflow(t, env):
           [15, 392027464946, 0, 0, 0, 0, 0, 0, 0, 10852364288, 0, 10853937152, 90820, 90564, 391147321463, 1129113173731145],
           [15, 407034683097, 0, 0, 0, 0, 0, 0, 0, 10864914432, 0, 10866487296, 93884, 93628, 406154554429, 1131023767183211]]
     _LayoutStats(t, env, ls)
+
+def layoutget_return(sess, fh, open_stateid, layout_iomode=LAYOUTIOMODE4_RW,
+                     layout_error=None, layout_error_op=OP_WRITE):
+    """
+    Perform LAYOUTGET and LAYOUTRETURN
+    """
+
+    # Get layout
+    ops = [op.putfh(fh),
+           op.layoutget(False, LAYOUT4_FLEX_FILES, layout_iomode,
+                        0, NFS4_UINT64_MAX, 4196, open_stateid, 0xffff)]
+    res = sess.compound(ops)
+    check(res)
+    layout_stateid = res.resarray[-1].logr_stateid
+
+    # Return layout
+    if not layout_error:  # Return regular layout
+        ops = [op.putfh(fh),
+               op.layoutreturn(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_ANY,
+                               layoutreturn4(LAYOUTRETURN4_FILE,
+                                             layoutreturn_file4(0, NFS4_UINT64_MAX,
+                                                                layout_stateid, "")))]
+    else:  # Return layout with error
+        # Get device id
+        locb = res.resarray[-1].logr_layout[0].lo_content.loc_body
+        p = FlexUnpacker(locb)
+        layout = p.unpack_ff_layout4()
+        p.done()
+
+        deviceid = layout.ffl_mirrors[0].ffm_data_servers[0].ffds_deviceid
+        deverr = device_error4(deviceid, layout_error, layout_error_op)
+        ffioerr = ff_ioerr4(0, NFS4_UINT64_MAX, layout_stateid, [deverr])
+        fflr = ff_layoutreturn4([ffioerr], [])
+
+        p = FlexPacker()
+        p.pack_ff_layoutreturn4(fflr)
+
+        ops = [op.putfh(fh),
+               op.layoutreturn(False, LAYOUT4_FLEX_FILES, LAYOUTIOMODE4_ANY,
+                               layoutreturn4(LAYOUTRETURN4_FILE,
+                                             layoutreturn_file4(0, NFS4_UINT64_MAX,
+                                                                layout_stateid,
+                                                                p.get_buffer())))]
+
+    res2 = sess.compound(ops)
+    check(res2)
+    return [res, res2]
+
+def get_layout_cred(logr):
+    """
+    :summary: Returns credentials contained in LAYOUTGET reply
+    :param logr: LAYOUTGET reply result
+    :return: List with uid and gid
+    """
+    locb = logr.logr_layout[0].lo_content.loc_body
+    p = FlexUnpacker(locb)
+    layout = p.unpack_ff_layout4()
+    p.done()
+    uid = layout.ffl_mirrors[0].ffm_data_servers[0].ffds_user
+    gid = layout.ffl_mirrors[0].ffm_data_servers[0].ffds_group
+    return [uid, gid]
+
+def testFlexLayoutReturnNxioRead(t, env):
+    """
+    Send LAYOUTRETURN with NFS4ERR_NXIO for READ
+
+    FLAGS: flex layoutreturn
+    CODE: FFLORNXIOREAD
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
+    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_READ, NFS4ERR_NXIO, OP_READ)
+
+    # Obtain another layout
+    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_READ)
+
+    # Close file
+    res = close_file(sess, fh, stateid=open_stateid)
+    check(res)
+
+def testFlexLayoutReturnNxioWrite(t, env):
+    """
+    Send LAYOUTRETURN with NFS4ERR_NXIO for WRITE
+
+    FLAGS: flex layoutreturn
+    CODE: FFLORNXIOWRITE
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
+    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_RW, NFS4ERR_NXIO, OP_WRITE)
+
+    # Obtain another layout
+    layoutget_return(sess, fh, open_stateid)
+
+    # Close file
+    res = close_file(sess, fh, stateid=open_stateid)
+    check(res)
+
+def testFlexLayoutReturnStaleRead(t, env):
+    """
+    Send LAYOUTRETURN with NFS4ERR_STALE for READ
+
+    FLAGS: flex layoutreturn
+    CODE: FFLORSTALEREAD
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
+    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_READ, NFS4ERR_STALE, OP_READ)
+
+    # Close file
+    res = close_file(sess, fh, stateid=open_stateid)
+    check(res)
+
+def testFlexLayoutReturnStaleWrite(t, env):
+    """
+    Send LAYOUTRETURN with NFS4ERR_STALE for WRITE
+
+    FLAGS: flex layoutreturn
+    CODE: FFLORSTALEWRITE
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
+    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_RW, NFS4ERR_STALE, OP_WRITE)
+
+    # Close file
+    res = close_file(sess, fh, stateid=open_stateid)
+    check(res)
+
+def testFlexLayoutReturnIoRead(t, env):
+    """
+    Send LAYOUTRETURN with NFS4ERR_IO for READ
+
+    FLAGS: flex layoutreturn
+    CODE: FFLORIOREAD
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
+    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_READ, NFS4ERR_IO, OP_READ)
+
+    # Close file
+    res = close_file(sess, fh, stateid=open_stateid)
+    check(res)
+
+def testFlexLayoutReturnIoWrite(t, env):
+    """
+    Send LAYOUTRETURN with NFS4ERR_IO for WRITE
+
+    FLAGS: flex layoutreturn
+    CODE: FFLORIOWRITE
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
+    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_RW, NFS4ERR_IO, OP_WRITE)
+
+    # Close file
+    res = close_file(sess, fh, stateid=open_stateid)
+    check(res)
+
+def testFlexLayoutReturnServerFaultRead(t, env):
+    """
+    Send LAYOUTRETURN with NFS4ERR_SERVERFAULT on READ
+
+    FLAGS: flex layoutreturn
+    CODE: FFLORSERVERFAULTREAD
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
+    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_READ, NFS4ERR_SERVERFAULT, OP_READ)
+
+    # Close file
+    res = close_file(sess, fh, stateid=open_stateid)
+    check(res)
+
+def testFlexLayoutReturnServerFaultWrite(t, env):
+    """
+    Send LAYOUTRETURN with NFS4ERR_SERVERFAULT on WRITE
+
+    FLAGS: flex layoutreturn
+    CODE: FFLORSERVERFAULTWRITE
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
+    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_RW, NFS4ERR_SERVERFAULT, OP_WRITE)
+
+    # Close file
+    res = close_file(sess, fh, stateid=open_stateid)
+    check(res)
+
+def testFlexLayoutReturnNospc(t, env):
+    """
+    Send LAYOUTRETURN with NFS4ERR_NOSPC
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
+    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_RW, NFS4ERR_NOSPC, OP_WRITE)
+
+    # Close file
+    res = close_file(sess, fh, stateid=open_stateid)
+    check(res)
+
+def testFlexLayoutReturnFbig(t, env):
+    """
+    Send LAYOUTRETURN with NFS4ERR_FBIG
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
+    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_RW, NFS4ERR_FBIG, OP_WRITE)
+
+    # Close file
+    res = close_file(sess, fh, stateid=open_stateid)
+    check(res)
+
+def testFlexLayoutReturnAccessRead(t, env):
+    """
+    Send LAYOUTRETURN with NFS4ERR_ACCESS on READ
+
+    FLAGS: flex layoutreturn
+    CODE: FFLORACCESSREAD
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
+    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_READ,
+                     NFS4ERR_ACCESS, OP_READ)
+
+    # Close file
+    res = close_file(sess, fh, stateid=open_stateid)
+    check(res)
+
+def testFlexLayoutReturnAccessWrite(t, env):
+    """
+    Send LAYOUTRETURN with NFS4ERR_ACCESS on WRITE
+
+    FLAGS: flex layoutreturn
+    CODE: FFLORACCESSWRITE
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
+    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_RW,
+                     NFS4ERR_ACCESS, OP_WRITE)
+
+    # Close file
+    res = close_file(sess, fh, stateid=open_stateid)
+    check(res)
+
+def testFlexLayoutReturnDelayRead(t, env):
+    """
+    Send LAYOUTRETURN with NFS4ERR_DELAY on READ
+
+    FLAGS: flex layoutreturn
+    CODE: FFLORDELAYREAD
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
+    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_READ, NFS4ERR_DELAY, OP_READ)
+
+    # Close file
+    res = close_file(sess, fh, stateid=open_stateid)
+    check(res)
+
+def testFlexLayoutReturnDelayWrite(t, env):
+    """
+    Send LAYOUTRETURN with NFS4ERR_DELAY on WRITE
+
+    FLAGS: flex layoutreturn
+    CODE: FFLORDELAYWRITE
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
+    layoutget_return(sess, fh, open_stateid, LAYOUTIOMODE4_RW, NFS4ERR_DELAY, OP_WRITE)
+
+    # Close file
+    res = close_file(sess, fh, stateid=open_stateid)
+    check(res)
+
+def testFlexLayoutReturn1K(t, env):
+    """
+    Perform LAYOUTGET and LAYOUTRETURN 1K times with error being returned periodically
+
+    FLAGS: flex layoutreturn
+    CODE: FFLOR1K
+    """
+    name = env.testname(t)
+    sess = env.c1.new_pnfs_client_session(env.testname(t))
+    count = 1000  # Repeat LAYOUTGET/LAYOUTRETURN count times
+    layout_error_ratio = 10  # Send an error every layout_error_ratio layout returns
+
+    # Create the file
+    res = create_file(sess, name)
+    check(res)
+    fh = res.resarray[-1].object
+    open_stateid = res.resarray[-2].stateid
+
+    for i in xrange(count):
+        layout_error = None if i % layout_error_ratio else NFS4ERR_ACCESS
+        layoutget_return(sess, fh, open_stateid, layout_error=layout_error)
+
+    # Close file
+    res = close_file(sess, fh, stateid=open_stateid)
+    check(res)
-- 
2.26.2

