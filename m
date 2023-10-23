Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B86A7D284C
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Oct 2023 04:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjJWCLu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 Oct 2023 22:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjJWCLs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 22 Oct 2023 22:11:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2029790
        for <linux-nfs@vger.kernel.org>; Sun, 22 Oct 2023 19:11:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A72F121847;
        Mon, 23 Oct 2023 02:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698027105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LL7tWXUl7A3RdvdqOHiqksj0Bp6yAXgIslcHvnRez98=;
        b=zbTPTsMvqZ64y/mjngFdKmMibTMsmvfu0oNgNTwRAChoeRR/XOSAGt96wnvV7tn0I6TClc
        yBSo4K7cXDqP7cImBx1Q7l3h1DPD4Py+UpqOViWNgZYpYo8cbTXADwosZGWzSx5MR9OgKH
        sa6aG/0irgKivwC4FsNMh7tqF0cTn80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698027105;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LL7tWXUl7A3RdvdqOHiqksj0Bp6yAXgIslcHvnRez98=;
        b=vGZcSFLUG0rJgPxUYvMipkma+9wlRa+YlA04HPGbi7y9kKof+6P7NaBk0IiMQ12Ji6+ebE
        2IRIyV66rVIcjQAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 75BB4132FD;
        Mon, 23 Oct 2023 02:11:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KXZGC2DWNWVpbwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 23 Oct 2023 02:11:44 +0000
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 2/6] export: add EACCES to the list of known path_lookup_error() errors.
Date:   Mon, 23 Oct 2023 12:58:32 +1100
Message-ID: <20231023021052.5258-3-neilb@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023021052.5258-1-neilb@suse.de>
References: <20231023021052.5258-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.52
X-Spamd-Result: default: False [0.52 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[3];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.38)[77.21%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If a 'stat' results in EACCES (for root), then it is likely a permanent
problem.  One possible cause is a 'fuser' filesystem which only gives
any access to the user which mounted it.

So it is reasonable for EACCES to be a "path lookup error"

Signed-off-by: NeilBrown <neilb@suse.de>
---
 support/export/cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/support/export/cache.c b/support/export/cache.c
index e4595020f43f..5307f6c8d872 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -77,6 +77,7 @@ static bool path_lookup_error(int err)
 	case ENAMETOOLONG:
 	case ENOENT:
 	case ENOTDIR:
+	case EACCES:
 		return 1;
 	}
 	return 0;
-- 
2.42.0

