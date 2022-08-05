Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC2358ADED
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Aug 2022 18:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbiHEQM3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Aug 2022 12:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238240AbiHEQM3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 Aug 2022 12:12:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3D674CEB
        for <linux-nfs@vger.kernel.org>; Fri,  5 Aug 2022 09:12:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09A4661777
        for <linux-nfs@vger.kernel.org>; Fri,  5 Aug 2022 16:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F56C433C1;
        Fri,  5 Aug 2022 16:12:27 +0000 (UTC)
Subject: [PATCH 2/2] DELEG21: Return delegations so clean_diff() works
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 05 Aug 2022 12:12:26 -0400
Message-ID: <165971594611.1762917.16737275128372470606.stgit@morisot.1015granger.net>
In-Reply-To: <165971593943.1762917.4388644054248311900.stgit@morisot.1015granger.net>
References: <165971593943.1762917.4388644054248311900.stgit@morisot.1015granger.net>
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

WARNING: could not clean testdir due to:
Making sure b'DELEG21-1' is writable: operation OP_SETATTR should return NFS4_OK, instead got NFS4ERR_DELAY

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 nfs4.0/servertests/st_delegation.py |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/nfs4.0/servertests/st_delegation.py b/nfs4.0/servertests/st_delegation.py
index ff042cdb69a8..9c98ec0e0fb3 100644
--- a/nfs4.0/servertests/st_delegation.py
+++ b/nfs4.0/servertests/st_delegation.py
@@ -731,7 +731,7 @@ def testServerSelfConflict(t, env):
     c = env.c1
     count = c.cb_server.opcounts[OP_CB_RECALL]
     c.init_connection(b'pynfs%i_%s' % (os.getpid(), t.word()), cb_ident=0)
-    _get_deleg(t, c, c.homedir + [t.word()], None, NFS4_OK)
+    deleg_info, fh, stateid = _get_deleg(t, c, c.homedir + [t.word()], None, NFS4_OK)
 
     sleeptime = 1
     while 1:
@@ -746,6 +746,10 @@ def testServerSelfConflict(t, env):
         check(res, [NFS4_OK, NFS4ERR_DELAY], "Open which causes recall")
         env.sleep(sleeptime, 'Got NFS4ERR_DELAY on open')
     c.confirm(b'newowner', res)
+    res = c.compound([op.putfh(fh), op.delegreturn(deleg_info.read.stateid)])
+    check(res)
+    res = c.close_file(t.word(), fh, stateid)
+    check(res)
     newcount = c.cb_server.opcounts[OP_CB_RECALL]
     if newcount > count:
         t.fail("Unnecessary delegation recall")


