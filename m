Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4147A77C57B
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Aug 2023 03:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjHOBzK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Aug 2023 21:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbjHOByu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Aug 2023 21:54:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466BFB0
        for <linux-nfs@vger.kernel.org>; Mon, 14 Aug 2023 18:54:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0A83821904;
        Tue, 15 Aug 2023 01:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692064488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Au6Pwr6xrdmPexxyD65jqMcxapSOfNpjRARxvShLyU=;
        b=CWJD8LjMyEq+mrJsLFX1kdsCzkCP3sFrNVdcBCHh9gcksGvAVlqHa2IXUx/KLpI3ALxuuG
        DkdSwbHIwmLuhhQQX38cKRR5/2znQej/qWclKbC8vV3KNF5sVUz1Q6HoWC9X4DnppG5kpN
        rYkJvrDJDbvBidhvkBrS7NukFrc2sss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692064488;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Au6Pwr6xrdmPexxyD65jqMcxapSOfNpjRARxvShLyU=;
        b=wbvaIDENbi2qoMDHXdSZzna16eiL4ls4OTAGR/LqN/jBYa4NP3QP8nzA5NkNBsrJpzu9Uo
        oKBpew1C6eIgQFCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C1F011353E;
        Tue, 15 Aug 2023 01:54:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GPUuHeba2mStCgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 15 Aug 2023 01:54:46 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 01/10] SQUASH: SUNRPC: rename and refactor svc_get_next_xprt()
Date:   Tue, 15 Aug 2023 11:54:17 +1000
Message-Id: <20230815015426.5091-2-neilb@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230815015426.5091-1-neilb@suse.de>
References: <20230815015426.5091-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Previous patch dropped the "!" when moving this test

Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/svc_xprt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index b875b2332069..b8539545fefd 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -867,7 +867,7 @@ void svc_recv(struct svc_rqst *rqstp)
 		/* Normally we will wait up to 5 seconds for any required
 		 * cache information to be provided.
 		 */
-		if (test_bit(SP_CONGESTED, &pool->sp_flags))
+		if (!test_bit(SP_CONGESTED, &pool->sp_flags))
 			rqstp->rq_chandle.thread_wait = 5 * HZ;
 		else
 			rqstp->rq_chandle.thread_wait = 1 * HZ;
-- 
2.40.1

