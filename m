Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52FD557271
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jun 2022 07:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiFWFEw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Jun 2022 01:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiFWFEf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Jun 2022 01:04:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F9C4BFCE
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 21:47:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C28B721B99;
        Thu, 23 Jun 2022 04:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655959658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=g0OVDl6RRnwAonWjBgsU4+NvONbHQclUUrv8a2IZHos=;
        b=YlOlVqx2TF8QNiiqeEn2+Cu4KaKXKwv5WHdcKwoZSL/yupD6SYZo80eRpNPBmgkFX6ULh/
        9gYvJ8ozWjUtmuExbQ7w6wOGXbJmq4B5G2/q19VaWf9CuHpvRTIAyUnjl8knEL0Fj7tFw6
        NZYtX2DLPMuRxvCbLUy4Q/ailZHLuQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655959658;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=g0OVDl6RRnwAonWjBgsU4+NvONbHQclUUrv8a2IZHos=;
        b=IlF1GtaKwHJpbKPp+TRZFaR8Z55K04tcKIU5nVchlcIH6qE9ZqiE32tkW0Kj+Qgcol188u
        9miDMqddd1pOFaDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6355C13461;
        Thu, 23 Jun 2022 04:47:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5OEECGnws2L/GAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 23 Jun 2022 04:47:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: [PATCH] NFS: restore module put when manager exits.
Date:   Thu, 23 Jun 2022 14:47:34 +1000
Message-id: <165595965412.4786.12578338276708392878@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Commit f49169c97fce ("NFSD: Remove svc_serv_ops::svo_module") removed
calls to module_put_and_kthread_exit() from threads that acted as SUNRPC
servers and had a related svc_serv_ops structure.  This was correct.

It ALSO removed the module_put_and_kthread_exit() call from
nfs4_run_state_manager() which is NOT a SUNRPC service.

Consequently every time the NFSv4 state manager runs the module count
increments and won't be decremented.  So the nfsv4 module cannot be
unloaded.

So restore the module_put_and_kthread_exit() call.

Fixes: f49169c97fce ("NFSD: Remove svc_serv_ops::svo_module")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/nfs4state.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 2540b35ec187..9bab3e9c702a 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2753,5 +2753,6 @@ static int nfs4_run_state_manager(void *ptr)
 		goto again;
 
 	nfs_put_client(clp);
+	module_put_and_kthread_exit(0);
 	return 0;
 }
-- 
2.36.1

