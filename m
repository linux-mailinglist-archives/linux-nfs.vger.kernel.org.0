Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E467D284B
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Oct 2023 04:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjJWCLp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 Oct 2023 22:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjJWCLo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 22 Oct 2023 22:11:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6032490
        for <linux-nfs@vger.kernel.org>; Sun, 22 Oct 2023 19:11:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0DD7E1FE03;
        Mon, 23 Oct 2023 02:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698027101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wp0WlWrHsij9v1ELwAOMtktOa0wyT2s2v9GtDArTVP8=;
        b=tRzQYpmkqRky2iLdpRQRafeL0vw6T7w4MZ0BrNA41vsptrowCs2PwrE0/lXSARc8p4mtax
        86hI09OpWhtre2UwDq3tl2Q4a0o1NVJbbCBdvVinFkaPDG45ncEVnooo/eiw58hZzyY0R8
        93APs1kjT0OUemI0P4+GuGqYymnBLe4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698027101;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wp0WlWrHsij9v1ELwAOMtktOa0wyT2s2v9GtDArTVP8=;
        b=yyiBD8YPpZBz6SUWp1FV1Y3THe+YmuMrENDjgA9BUk5d56HMo/5OKs1RDPMM9h8SX4/4w6
        IoqCBfHAvLXk9zBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5638132FD;
        Mon, 23 Oct 2023 02:11:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5UARI1vWNWVlbwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 23 Oct 2023 02:11:39 +0000
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 1/6] export: fix handling of error from match_fsid()
Date:   Mon, 23 Oct 2023 12:58:31 +1100
Message-ID: <20231023021052.5258-2-neilb@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023021052.5258-1-neilb@suse.de>
References: <20231023021052.5258-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.79
X-Spamd-Result: default: False [0.79 / 50.00];
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
         BAYES_HAM(-0.11)[66.16%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If match_fsid() returns -1 we shouldn't assume that the path definitely
doesn't match the fsid, though it might not.
This is a similar situation to where an export is expected to be a mount
point, but is found not to be one.  So it can be handled the same way,
by setting 'dev_missing'.
This will only have an effect if no other path matched the fsid, which
is what we want.

The current code results in nothing being exported if any export point,
or any mount point beneath a crossmnt export point, fails a 'stat'
request, which is too harsh.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 support/export/cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index 19bbba556060..e4595020f43f 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -858,7 +858,8 @@ static void nfsd_fh(int f)
 			case 0:
 				continue;
 			case -1:
-				goto out;
+				dev_missing ++;
+				continue;
 			}
 			if (is_ipaddr_client(dom)
 					&& !ipaddr_client_matches(exp, ai))
-- 
2.42.0

