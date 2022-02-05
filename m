Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797E84AAA63
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Feb 2022 18:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380519AbiBERFc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Feb 2022 12:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348753AbiBERFb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 5 Feb 2022 12:05:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA05C061348
        for <linux-nfs@vger.kernel.org>; Sat,  5 Feb 2022 09:05:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE40461113
        for <linux-nfs@vger.kernel.org>; Sat,  5 Feb 2022 17:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14935C340E8;
        Sat,  5 Feb 2022 17:05:30 +0000 (UTC)
Subject: [PATCH] nfsv4.0/read: Test the behavior of reading near OFFSET_MAX
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Sat, 05 Feb 2022 12:05:29 -0500
Message-ID: <164408072927.1028772.2263116854233914910.stgit@morisot.1015granger.net>
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

On many systems, the internal representation of a file offset or
file size is a signed 64-bit value. NFS, however, uses an unsigned
value for these quantities. The server must convert incoming offsets
and file sizes properly or risk an underflow.

Add a test which exercises this corner case.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 nfs4.0/servertests/st_read.py |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/nfs4.0/servertests/st_read.py b/nfs4.0/servertests/st_read.py
index 1b27f5d06f2f..f75b753d61c7 100644
--- a/nfs4.0/servertests/st_read.py
+++ b/nfs4.0/servertests/st_read.py
@@ -91,6 +91,18 @@ def testLargeOffset(t, env):
     check(res, msg="Reading file /%s" % b'/'.join(env.opts.usefile))
     _compare(t, res, b'', True)
 
+def testVeryLargeOffset(t, env):
+    """READ with offset far outside file
+
+    FLAGS: read all
+    DEPEND: LOOKFILE
+    CODE: RD5a
+    """
+    c = env.c1
+    res = c.read_file(env.opts.usefile, 0x7ffffffffffffffc, 10)
+    check(res, msg="Reading file /%s" % b'/'.join(env.opts.usefile))
+    _compare(t, res, b'', True)
+
 def testZeroCount(t, env):
     """READ with count=0
 


