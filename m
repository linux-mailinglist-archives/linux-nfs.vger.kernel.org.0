Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30517DB1CB
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Oct 2023 02:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjJ3BNf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 29 Oct 2023 21:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjJ3BNe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 29 Oct 2023 21:13:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7434CBD
        for <linux-nfs@vger.kernel.org>; Sun, 29 Oct 2023 18:13:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 216D5218B5;
        Mon, 30 Oct 2023 01:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698628411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c5JA7fnfIT/HDjDNo3Wkz2nCn14zIt7XZyYBhCTUg9Q=;
        b=DUUvgzbai5jmIuADRYp4ZDcGF7S1IfS1pHzTcGi8QQE+NrymlEike5diLCF0K2LnfSERs6
        JvUBGFgYMpcYFXy/xaKuDyn4qK94PxuMivxq37+28DUY8T9KSAmL+9Aj4orVgn9yGUx8M+
        /kjIPGya0MYBamE7lXwhdjUx6wE6oLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698628411;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c5JA7fnfIT/HDjDNo3Wkz2nCn14zIt7XZyYBhCTUg9Q=;
        b=3rQhWsektXxUY0bRd5rno7UsJa/Cw87dJFLOWm710adhIlmQMUQjvig63UOa5cxplES83+
        l6iul8EPnXYZ1OAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF05013460;
        Mon, 30 Oct 2023 01:13:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id soSmJzgDP2V+RwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 30 Oct 2023 01:13:28 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: [PATCH 3/5] nfsd: hold nfsd_mutex across entire netlink operation
Date:   Mon, 30 Oct 2023 12:08:36 +1100
Message-ID: <20231030011247.9794-4-neilb@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030011247.9794-1-neilb@suse.de>
References: <20231030011247.9794-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -1.52
X-Spamd-Result: default: False [-1.52 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_FIVE(0.00)[6];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-2.42)[97.37%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Rather than using svc_get() and svc_put() to hold a stable reference to
the nfsd_svc for netlink lookups, simply hold the mutex for the entire
time.

The "entire" time isn't very long, and the mutex is not often contented.

This makes way for use to remove the refcounts of svc, which is more
confusing than useful.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfsctl.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index d78ae4452946..8f644f1d157c 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1515,11 +1515,10 @@ int nfsd_nl_rpc_status_get_start(struct netlink_callback *cb)
 	int ret = -ENODEV;
 
 	mutex_lock(&nfsd_mutex);
-	if (nn->nfsd_serv) {
-		svc_get(nn->nfsd_serv);
+	if (nn->nfsd_serv)
 		ret = 0;
-	}
-	mutex_unlock(&nfsd_mutex);
+	else
+		mutex_unlock(&nfsd_mutex);
 
 	return ret;
 }
@@ -1691,8 +1690,6 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
  */
 int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb)
 {
-	mutex_lock(&nfsd_mutex);
-	nfsd_put(sock_net(cb->skb->sk));
 	mutex_unlock(&nfsd_mutex);
 
 	return 0;
-- 
2.42.0

