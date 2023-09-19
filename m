Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96ED77A566D
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Sep 2023 02:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjISACc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 20:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjISAC2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 20:02:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF5697
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 17:02:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A367D222FB;
        Tue, 19 Sep 2023 00:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695081732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pm7C6TK9aETYA6nzW4d44355zbYJdvIqveZaN5LZwjQ=;
        b=mt+ZQySG6YxB+GTwd4Fga/M1ELSplt4H3u9xdV7Wjk/qjCyzDQfWtzn8xAkdEHnypkIsX4
        0pnah9jtn0YAnHNkZQQrWKHC1YhChAqBVq+Zo3zJAkYai1YE3qCNvzbrMGhKORd5SW0RbF
        QMf+cS+SASimWR/uNXFloUqYHOMFS78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695081732;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pm7C6TK9aETYA6nzW4d44355zbYJdvIqveZaN5LZwjQ=;
        b=2FrzxDa3VWnKNDvckikq/7edsGw4EWu2IUMLOETpP8rLgIfwTDVEuHCjHdroDSYOLHc7a9
        U3c0s82a0Y+ySSBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16E3A13A6C;
        Tue, 19 Sep 2023 00:02:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1QXeLgLlCGX1NwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 19 Sep 2023 00:02:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <cel@kernel.org>
Cc:     brauner@kernel.org, "Chuck Lever" <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1] SUNRPC: Remove BUG_ON call sites
In-reply-to: <169504668787.134583.4338728458451666583.stgit@manet.1015granger.net>
References: <169504668787.134583.4338728458451666583.stgit@manet.1015granger.net>
Date:   Tue, 19 Sep 2023 10:02:07 +1000
Message-id: <169508172758.19404.11033097632795181738@noble.neil.brown.name>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 19 Sep 2023, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> There is no need to take down the whole system for these assertions.
> 
> I'd rather not attempt a heroic save here, as some bug has occurred
> that has left the transport data structures in an unknown state.
> Just warn and then leak the left-over resources.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/svc.c |   11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> Let's start here. Comments?
> 
> 
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 587811a002c9..11a1d5e7f5c7 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -575,11 +575,14 @@ svc_destroy(struct kref *ref)
>  	timer_shutdown_sync(&serv->sv_temptimer);
>  
>  	/*
> -	 * The last user is gone and thus all sockets have to be destroyed to
> -	 * the point. Check this.
> +	 * Remaining transports at this point are not expected.
>  	 */
> -	BUG_ON(!list_empty(&serv->sv_permsocks));
> -	BUG_ON(!list_empty(&serv->sv_tempsocks));
> +	if (unlikely(!list_empty(&serv->sv_permsocks)))
> +		pr_warn("SVC: permsocks remain for %s\n",
> +			serv->sv_program->pg_name);

I would go with WARN_ON_ONCE() but I agree with the principle.
Maybe
  WARN_ONCE(!list_empty(&serv->sv_permsocks), 
            "SVC: permsocks remain for %s\n",
	    serv->sv_program->pg_name);
This gives the stack trace which might be helpful.
But 

 Reviewed-by: NeilBrown <neilb@suse.de>

if you prefer it the way it is.

NeilBrown

> +	if (unlikely(!list_empty(&serv->sv_tempsocks)))
> +		pr_warn("SVC: tempsocks remain for %s\n",
> +			serv->sv_program->pg_name);
>  
>  	cache_clean_deferred(serv);
>  
> 
> 
> 

