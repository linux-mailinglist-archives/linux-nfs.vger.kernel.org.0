Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714905911E7
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Aug 2022 16:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239096AbiHLOIZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Aug 2022 10:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237287AbiHLOIY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Aug 2022 10:08:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F98AB06A
        for <linux-nfs@vger.kernel.org>; Fri, 12 Aug 2022 07:08:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CAB46181B
        for <linux-nfs@vger.kernel.org>; Fri, 12 Aug 2022 14:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683F8C433C1;
        Fri, 12 Aug 2022 14:08:22 +0000 (UTC)
Subject: [PATCH] DELEG5: Create test file with mode o666
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 12 Aug 2022 10:08:21 -0400
Message-ID: <166031330113.3080139.1273532571655274363.stgit@morisot.1015granger.net>
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

DELEG5   st_delegation.testManyReaddeleg                          : FAILURE
           Open which causes recall should return NFS4_OK or
           NFS4ERR_DELAY, instead got NFS4ERR_ACCESS
******* CB_Recall (id=14)********
**************************************************
Command line asked for 1 of 678 tests
Of those: 0 Skipped, 1 Failed, 0 Warned, 0 Passed

WARNING: could not clean testdir due to:
Making sure b'DELEG5-1' is writable: operation OP_SETATTR should return NFS4_OK, instead got NFS4ERR_DELAY

DELEG5 attempts an OPEN with ACCESS_WRITE to force the recall of
a bunch of delegations. The OPEN that requests ACCESS_WRITE fails,
however, because the test file was created as 0,0 with mode o644.

A perhaps more preferable long-term fix would be to follow the
advice of the nearby comment and convert DELEG5 to use _get_deleg(),
but I'm not expert enough to tackle that yet.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 nfs4.0/servertests/st_delegation.py |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/nfs4.0/servertests/st_delegation.py b/nfs4.0/servertests/st_delegation.py
index 9c98ec0e0fb3..ba49cf9f09db 100644
--- a/nfs4.0/servertests/st_delegation.py
+++ b/nfs4.0/servertests/st_delegation.py
@@ -244,7 +244,8 @@ def testManyReaddeleg(t, env, funct=_recall, response=NFS4_OK):
     c.init_connection(b'pynfs%i_%s' % (os.getpid(), t.word()), cb_ident=0)
     cbids = []
     fh, stateid = c.create_confirm(t.word(), access=OPEN4_SHARE_ACCESS_READ,
-                                   deny=OPEN4_SHARE_DENY_NONE)
+                                   deny=OPEN4_SHARE_DENY_NONE,
+                                   attrs={FATTR4_MODE: 0o666})
     for i in range(count):
         c.init_connection(b'pynfs%i_%s_%i' % (os.getpid(), t.word(), i), cb_ident=0)
         fh, stateid = c.open_confirm(t.word(), access=OPEN4_SHARE_ACCESS_READ,


