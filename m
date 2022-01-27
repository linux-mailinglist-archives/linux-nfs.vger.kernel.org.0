Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A51849E8B8
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 18:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiA0RT1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 12:19:27 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44050 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242179AbiA0RT1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 12:19:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DCE9B81366
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 17:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294E1C340E4
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 17:19:25 +0000 (UTC)
Subject: [PATCH] nfsv4.0/setattr: Check behavior of setting a large file size
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Thu, 27 Jan 2022 12:19:24 -0500
Message-ID: <164330361583.2340756.18437536986986631991.stgit@morisot.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Many POSIX systems internally use a signed file size. The NFS
server has to correctly handle the conversion from a u64 size
to the internal size value.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 nfs4.0/servertests/st_setattr.py |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

Just something to consider... "It's my first ray gun" so I'm sure
I got something wrong here.

diff --git a/nfs4.0/servertests/st_setattr.py b/nfs4.0/servertests/st_setattr.py
index c3ecee3fbcfb..5d51054c29b4 100644
--- a/nfs4.0/servertests/st_setattr.py
+++ b/nfs4.0/servertests/st_setattr.py
@@ -562,6 +562,25 @@ def testUnsupportedSocket(t, env):
     check(res)
     _try_unsupported(t, env, path)
 
+def testMaxSizeFile(t, env):
+    """SETATTR(U64_MAX) of a file should return NFS4_OK or NFS4ERR_FBIG
+
+    FLAGS: setattr all
+    DEPEND: INIT
+    CODE: SATT12x
+    """
+    maxsize = 0xffffffffffffffff
+    c = env.c1
+    fh, stateid = c.create_confirm(t.word(), deny=OPEN4_SHARE_DENY_NONE)
+    dict = {FATTR4_SIZE: maxsize}
+    ops = c.use_obj(fh) + [c.setattr(dict, stateid)]
+    res = c.compound(ops)
+    check(res, [NFS4_OK, NFS4ERR_FBIG], "SETATTR(U64_MAX) of a file")
+    newsize = c.do_getattr(FATTR4_SIZE, fh)
+    if newsize != maxsize:
+        check(res, [NFS4ERR_INVAL, NFS4ERR_FBIG],
+                "File size is %i; SETATTR" % newsize)
+
 def testSizeDir(t, env):
     """SETATTR(_SIZE) of a directory should return NFS4ERR_ISDIR or NFS4ERR_BAD_STATEID
 


