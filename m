Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6DD52931E
	for <lists+linux-nfs@lfdr.de>; Mon, 16 May 2022 23:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238894AbiEPVqy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 May 2022 17:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbiEPVqy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 May 2022 17:46:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BFD27FF0
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 14:46:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7AA86157F
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 21:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3B3C385B8;
        Mon, 16 May 2022 21:46:51 +0000 (UTC)
Subject: [PATCH] Test renaming onto an open file
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, andreas-nagy@outlook.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 16 May 2022 17:46:49 -0400
Message-ID: <165273748327.3738762.17733184143201491880.stgit@morisot.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There has been a recent report of RENAME onto an open file resulting
in a bogus ESTALE when that open (and now deleted) file is closed.
Build in some testing with and without SEQUENCE to ensure a server
is handling this case as expected.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 nfs4.0/servertests/st_rename.py   |   16 ++++++++++++++++
 nfs4.1/server41tests/st_rename.py |   19 ++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)


I've tried this test against ext4, xfs, and tmpfs on v5.10, v5.13,
and v5.18-rc6, and have not been able to reproduce the ESTALE
error. It could be that I'm getting something wrong.


diff --git a/nfs4.0/servertests/st_rename.py b/nfs4.0/servertests/st_rename.py
index afe9a7fe0a58..3302608719e3 100644
--- a/nfs4.0/servertests/st_rename.py
+++ b/nfs4.0/servertests/st_rename.py
@@ -524,6 +524,22 @@ def testLinkRename(t, env):
         t.fail("RENAME of file into its hard link should do nothing, "
                "but cinfo was changed")
 
+def testStaleRename(t, env):
+    """RENAME file over an open file should allow CLOSE
+
+    FLAGS: rename all
+    CODE: RNM21
+    """
+    c = env.c1
+    c.init_connection()
+    basedir = c.homedir + [t.word()]
+    c.maketree([t.word(), b'file'])
+    fh, stateid = c.create_confirm(t.word(), path=basedir + [b'file2'])
+    res = c.rename_obj(basedir + [b'file'], basedir + [b'file2'])
+    check(res)
+    res = c.close_file(t.word(), fh, stateid)
+    check(res, msg="CLOSE after RENAME deletes target returns ESTALE")
+
 ###########################################
 
     def testNamingPolicy(t, env):
diff --git a/nfs4.1/server41tests/st_rename.py b/nfs4.1/server41tests/st_rename.py
index 066df749379f..26ed4d275067 100644
--- a/nfs4.1/server41tests/st_rename.py
+++ b/nfs4.1/server41tests/st_rename.py
@@ -1,5 +1,5 @@
 from xdrdef.nfs4_const import *
-from .environment import check, fail, maketree, rename_obj, get_invalid_utf8strings, create_obj, create_confirm, link, use_obj, create_file
+from .environment import check, fail, maketree, rename_obj, get_invalid_utf8strings, create_obj, create_confirm, link, use_obj, create_file, close_file
 import nfs_ops
 op = nfs_ops.NFS4ops()
 from xdrdef.nfs4_type import *
@@ -529,3 +529,20 @@ def testLinkRename(t, env):
     if scinfo.before != scinfo.after or tcinfo.before != tcinfo.after:
         t.fail("RENAME of file into its hard link should do nothing, "
                "but cinfo was changed")
+
+def testStaleRename(t, env):
+    """RENAME file over an open file should allow CLOSE
+
+    FLAGS: rename all
+    CODE: RNM21
+    """
+    name = env.testname(t)
+    owner = b"owner_%s" % name
+    sess = env.c1.new_client_session(name)
+    maketree(sess, [name, b'file'])
+    basedir = env.c1.homedir + [name]
+    fh, stateid = create_confirm(sess, owner, path=basedir + [b'file2'])
+    res = rename_obj(sess, basedir + [b'file'], basedir + [b'file2'])
+    check(res)
+    res = close_file(sess, fh, stateid)
+    check(res, msg="CLOSE after RENAME deletes target returns ESTALE")


