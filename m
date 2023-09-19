Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F127A6E75
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Sep 2023 00:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjISWNo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Sep 2023 18:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbjISWNm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Sep 2023 18:13:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D475F2
        for <linux-nfs@vger.kernel.org>; Tue, 19 Sep 2023 15:12:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 43BAC2294F;
        Tue, 19 Sep 2023 22:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695161466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9/m8A3mbKNNH8TvVe+YpAdoQ+p+DLTEaMnupopxinzk=;
        b=kfYmKLsemNw3gNBY7APuh8Jk4Ivl4JIDsenkARVdP3gtp7YyCR1z7QIavivV9asi+B1ikl
        GV4oX9S0APLgbRZXcqu717W592jDDaKvJ+41XYy5CJC3Ete3AORRI/vYRKlnObVyjH3Xmu
        VcxeYUnOJ2xAX1chsffP5xrCazTNZ+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695161466;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9/m8A3mbKNNH8TvVe+YpAdoQ+p+DLTEaMnupopxinzk=;
        b=qwcrpvksDWa38j6K2sgvOp1vFS0SW1d7bFqfBcdNLKo0xKpDNSHN1ft9I707vZp56/5eUA
        ZLRzOnxC0a8mkJAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ADAD613458;
        Tue, 19 Sep 2023 22:11:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FLQKGHgcCmUQOAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 19 Sep 2023 22:11:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <cel@kernel.org>
Cc:     brauner@kernel.org, "Chuck Lever" <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1] SUNRPC: Remove BUG_ON call sites
In-reply-to: <169513768769.145733.5037542987990908432.stgit@manet.1015granger.net>
References: <169513768769.145733.5037542987990908432.stgit@manet.1015granger.net>
Date:   Wed, 20 Sep 2023 08:11:01 +1000
Message-id: <169516146143.19404.11284116898963519832@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 20 Sep 2023, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> There is no need to take down the whole system for these assertions.
> 
> I'd rather not attempt a heroic save here, as some bug has occurred
> that has left the transport data structures in an unknown state.
> Just warn and then leak the left-over resources.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Acked-by: Christian Brauner <brauner@kernel.org>
> ---
>  net/sunrpc/svc.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> Changes since v1:
> - Use WARN_ONCE() instead of pr_warn()
> 
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 587811a002c9..3237f7dfde1e 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -575,11 +575,12 @@ svc_destroy(struct kref *ref)
>  	timer_shutdown_sync(&serv->sv_temptimer);
>  
>  	/*
> -	 * The last user is gone and thus all sockets have to be destroyed to
> -	 * the point. Check this.
> +	 * Remaining transports at this point are not expected.
>  	 */
> -	BUG_ON(!list_empty(&serv->sv_permsocks));
> -	BUG_ON(!list_empty(&serv->sv_tempsocks));
> +	WARN_ONCE(!list_empty(&serv->sv_permsocks),
> +		  "SVC: permsocks remain for %s\n", serv->sv_program->pg_name);
> +	WARN_ONCE(!list_empty(&serv->sv_tempsocks),
> +		  "SVC: tempsocks remain for %s\n", serv->sv_program->pg_name);
>  
>  	cache_clean_deferred(serv);
>  
> 

Reviewed-by: NeilBrown <neilb@suse.de>

The stack trace might not be helpful, but this circumstance really
really shouldn't happen so if it ever does, I think we really want as
much context as practicable.

Thanks,
NeilBrown
