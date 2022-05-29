Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CBD5371DE
	for <lists+linux-nfs@lfdr.de>; Sun, 29 May 2022 19:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiE2RHf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 29 May 2022 13:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiE2RHf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 29 May 2022 13:07:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC0E11154
        for <linux-nfs@vger.kernel.org>; Sun, 29 May 2022 10:07:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C653060F70
        for <linux-nfs@vger.kernel.org>; Sun, 29 May 2022 17:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06574C385A9;
        Sun, 29 May 2022 17:07:32 +0000 (UTC)
Subject: [PATCH] nfsv4.0/release-lockowner: Check for proper LOCKS_HELD
 response
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Sun, 29 May 2022 13:07:31 -0400
Message-ID: <165384405174.3290283.7508180988614656582.stgit@morisot.1015granger.net>
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

Ensure that RELEASE_LOCKOWNER returns LOCKS_HELD if the lockowner
is still in use.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 nfs4.0/servertests/st_releaselockowner.py |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/nfs4.0/servertests/st_releaselockowner.py b/nfs4.0/servertests/st_releaselockowner.py
index 2c83f99b207f..b296e6c2752a 100644
--- a/nfs4.0/servertests/st_releaselockowner.py
+++ b/nfs4.0/servertests/st_releaselockowner.py
@@ -49,3 +49,24 @@ def testFile2(t, env):
     owner = lock_owner4(c.clientid, b"lockowner_RLOWN2")
     res = c.compound([op.release_lockowner(owner)])
     check(res)
+
+def testLocksHeld(t, env):
+    """RELEASE_LOCKOWNER - Locks held test
+
+    FLAGS: releaselockowner all
+    DEPEND:
+    CODE: RLOWN3
+    """
+    c = env.c1
+    c.init_connection()
+    fh, stateid = c.create_confirm(t.word())
+    res = c.lock_file(t.word(), fh, stateid, lockowner=b"lockowner_RLOWN3")
+    check(res)
+    owner = lock_owner4(c.clientid, b"lockowner_RLOWN3")
+    res2 = c.compound([op.release_lockowner(owner)])
+    check(res2, NFS4ERR_LOCKS_HELD)
+    res = c.unlock_file(1, fh, res.lockid)
+    check(res)
+    owner = lock_owner4(c.clientid, b"lockowner_RLOWN3")
+    res = c.compound([op.release_lockowner(owner)])
+    check(res)


