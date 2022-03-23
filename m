Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1814E5B97
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Mar 2022 23:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbiCWW6w (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Mar 2022 18:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiCWW6w (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Mar 2022 18:58:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07F38F98C
        for <linux-nfs@vger.kernel.org>; Wed, 23 Mar 2022 15:57:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6B9471F387;
        Wed, 23 Mar 2022 22:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648076240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=70uNct/+IzRMBwgKBAf/rUmTtjboZJuYaDbKXqcNmRM=;
        b=uQLrEBjuZTmnVLyVJRrO7HYP5phJugVxSOdUSK8UFJvgoAfTNSBMbn6fzH4NYIDwuiBE3J
        ebBPE1CedrGBQG/S+CdJMfMf6XPISznSe37zBsqMXgdujgVLV7YUdnBVjWjyAbGuZ0BmSU
        6tLQM/5clo7W0xW8lm8j6Y0kiwF2Vzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648076240;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=70uNct/+IzRMBwgKBAf/rUmTtjboZJuYaDbKXqcNmRM=;
        b=K2az4mzXfVdiLdVCGX62y8dB4hsnwzP6HxSNWlylQQrC0td9WE+QqhJoNG1GmzNiYRLsX4
        gjpXuurpUtqnFXCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9BC5F12FC5;
        Wed, 23 Mar 2022 22:57:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5SyaFs+lO2ItFQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 23 Mar 2022 22:57:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 0/9] Crossing our fingers is not a strategy
In-reply-to: <20220322011618.1052288-1-trondmy@kernel.org>
References: <20220322011618.1052288-1-trondmy@kernel.org>
Date:   Thu, 24 Mar 2022 09:57:16 +1100
Message-id: <164807623644.6096.16226567748741917177@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 22 Mar 2022, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> We'd like to avoid GFP_NOWAIT whenever possible, because it has no fall-
> back reclaim strategy for dealing with a failure of the initial
> allocation.

I'm not sure I entirely agree with that.  GFP_NOWAIT will ensure kswapd
runs on failure, so waiting briefly and retrying (which sunrpc does on
-ENOMEM (at least ni call_refreshresult) is a valid fallback.

However, I do like the new rpc_task_gfp_mask() and that fact that you
have used it quite widely.

So: looks good to me.  I haven't carefully reviewed each patch enough to
say Reviewed-by, but I did see an easy problems.

Thanks,
NeilBrown

