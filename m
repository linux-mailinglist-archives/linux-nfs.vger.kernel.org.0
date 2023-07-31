Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D32768C51
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jul 2023 08:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjGaGwD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jul 2023 02:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjGaGvv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jul 2023 02:51:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39ED10DC
        for <linux-nfs@vger.kernel.org>; Sun, 30 Jul 2023 23:51:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 050DA1F896;
        Mon, 31 Jul 2023 06:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690786294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HraQ6MjvjhUmT7LuRxeUd46fkdToslAlUq9lsYCyuAE=;
        b=CqMC5rfWz7tHL1xg7NNaq1J8twZGPxAHQkDB0c7E6rsA+Vndumfo42/1ovb2bcp3M0IFYd
        QOjoQ61FnrbHBC5Ai1yxYbL1h3GPjCcI+qp4K7wXaC3AmpYIo5GjIvmqOknhoeXVvYDWt+
        hzrYL/lRwQyutEFndN0JyyxNes9++TU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690786294;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HraQ6MjvjhUmT7LuRxeUd46fkdToslAlUq9lsYCyuAE=;
        b=SgWU0tBKn5DZqwjlLd/gTth9gdiOI4s87f03LWiuJM3dqcZG/dGPeaM0U+Mon+y6bOx/tC
        4CmHNlvJjCEB+LBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA5E01322C;
        Mon, 31 Jul 2023 06:51:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PwQ+G/RZx2SrbwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 31 Jul 2023 06:51:32 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 03/12] FIXUP: SUNRPC: call svc_process() from svc_recv()
Date:   Mon, 31 Jul 2023 16:48:30 +1000
Message-Id: <20230731064839.7729-4-neilb@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731064839.7729-1-neilb@suse.de>
References: <20230731064839.7729-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Now that svc_process() is called only by svc_recv(), it doesn't need to
be exported.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/svc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index cbfd4ac02a4d..f2971d94b4aa 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1546,7 +1546,6 @@ void svc_process(struct svc_rqst *rqstp)
 out_drop:
 	svc_drop(rqstp);
 }
-EXPORT_SYMBOL_GPL(svc_process);
 
 #if defined(CONFIG_SUNRPC_BACKCHANNEL)
 /*
-- 
2.40.1

