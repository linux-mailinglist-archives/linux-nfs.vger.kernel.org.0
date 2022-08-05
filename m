Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947F658ADEC
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Aug 2022 18:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240962AbiHEQMZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Aug 2022 12:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240873AbiHEQMY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 Aug 2022 12:12:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A82774370
        for <linux-nfs@vger.kernel.org>; Fri,  5 Aug 2022 09:12:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C6B6B8295F
        for <linux-nfs@vger.kernel.org>; Fri,  5 Aug 2022 16:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0326C433D7;
        Fri,  5 Aug 2022 16:12:20 +0000 (UTC)
Subject: [PATCH 1/2] DELEG6: Return delegations so clean_diff() works
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 05 Aug 2022 12:12:19 -0400
Message-ID: <165971593943.1762917.4388644054248311900.stgit@morisot.1015granger.net>
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
Making sure b'DELEG6-1' is writable: operation OP_SETATTR should return NFS4_OK, instead got NFS4ERR_DELAY

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 nfs4.0/servertests/st_delegation.py |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/nfs4.0/servertests/st_delegation.py b/nfs4.0/servertests/st_delegation.py
index 875dbc94ded1..ff042cdb69a8 100644
--- a/nfs4.0/servertests/st_delegation.py
+++ b/nfs4.0/servertests/st_delegation.py
@@ -285,7 +285,7 @@ def testRenew(t, env, funct=None, response=NFS4_OK):
     c = env.c1
     c.init_connection(b'pynfs%i_%s' % (os.getpid(), t.word()), cb_ident=0)
     lease = c.getLeaseTime()
-    _get_deleg(t, c, c.homedir + [t.word()], funct, response)
+    deleg_info, fh, stateid = _get_deleg(t, c, c.homedir + [t.word()], funct, response)
     c2 = env.c2
     c2.init_connection()
     try:
@@ -302,6 +302,10 @@ def testRenew(t, env, funct=None, response=NFS4_OK):
                 break
     finally:
         c.cb_command(1) # Turn on callback server
+    res = c.compound([op.putfh(fh), op.delegreturn(deleg_info.read.stateid)])
+    check(res)
+    res = c.close_file(t.word(), fh, stateid)
+    check(res)
     if not noticed:
         t.fail("RENEWs should not have all returned OK")
 


