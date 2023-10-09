Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B299C7BEF3F
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Oct 2023 01:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbjJIXfw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Oct 2023 19:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbjJIXfv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Oct 2023 19:35:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98589D
        for <linux-nfs@vger.kernel.org>; Mon,  9 Oct 2023 16:35:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 64EFC21883;
        Mon,  9 Oct 2023 23:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1696894548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=M8ctveJWNGn+Wbc/BQFgOI+zmmIPnmg7OwmWYfxr39Y=;
        b=uMeFGAjVMU8NUtg9VWB1xFmGKrt3vQgboRu6EuBWO4S+53jelc/8ozkomAVizU9fWeDfA5
        F1CoOt3vzA5UNUpOwpwxZJom7RKfy+eknVJm8oPUgSnQn1dZoATNkrO1aBdhRjIMwyulcE
        f7AbY4+WGt5nvGUBHyI2h0AAnB4PmWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1696894548;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=M8ctveJWNGn+Wbc/BQFgOI+zmmIPnmg7OwmWYfxr39Y=;
        b=a50DhDFmGaCRPvW1WaQ4eYP6RuhKtm37KEaMaUv2eW5cDzBJhUzX/lFSpL7QpdyKAErj0o
        FM4I1TZGEZbd9bCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57DAC13905;
        Mon,  9 Oct 2023 23:35:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RY3dA1KOJGWiBwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 09 Oct 2023 23:35:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: [PATCH] lockd: hold a reference to nlmsvc_serv while stopping thread.
Date:   Tue, 10 Oct 2023 10:35:43 +1100
Message-id: <169689454310.26263.15848180396022999880@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


We are required to hold a reference to the svc_serv struct while
stopping the last thread, as doing that could otherwise drop the last
reference itself and the svc_serv would be freed while still in use.

lockd doesn't do this.  After startup, the only reference is held by the
running thread.

So change locked to hold a reference on nlmsvc_serv while-ever the
service is active, and only drop it after the last thread has been
stopped.

Note: it doesn't really make sense for threads to hold references to the
svc_serv any more.  The fact threads are included in serv->sv_nrthreads
is sufficient.  Maybe a future patch could address this.

Reported-by: Jeff Layton <jlayton@kernel.org>
Fixes: 68cc388c3238 ("SUNRPC: change how svc threads are asked to exit.")
Signed-off-by: NeilBrown <neilb@suse.de>
---

Thanks for the report Jeff !!!

 fs/lockd/svc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index b441c706c2b8..7a5c90a00522 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -345,10 +345,10 @@ static int lockd_get(void)
 
 	serv->sv_maxconn = nlm_max_connections;
 	error = svc_set_num_threads(serv, NULL, 1);
-	/* The thread now holds the only reference */
-	svc_put(serv);
-	if (error < 0)
+	if (error < 0) {
+		svc_put(serv);
 		return error;
+	}
 
 	nlmsvc_serv = serv;
 	register_inetaddr_notifier(&lockd_inetaddr_notifier);
@@ -374,6 +374,7 @@ static void lockd_put(void)
 
 	svc_set_num_threads(nlmsvc_serv, NULL, 0);
 	timer_delete_sync(&nlmsvc_retry);
+	svc_put(nlmsvc_serv);
 	nlmsvc_serv = NULL;
 	dprintk("lockd_down: service destroyed\n");
 }
-- 
2.42.0

