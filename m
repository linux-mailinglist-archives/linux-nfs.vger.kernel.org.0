Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDAE6AF8BA
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Mar 2023 23:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjCGWb5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Mar 2023 17:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCGWbg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Mar 2023 17:31:36 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198008F73C;
        Tue,  7 Mar 2023 14:31:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A9C3821A40;
        Tue,  7 Mar 2023 22:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678228265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ESmXSz9yy8NQE1Zdwj05I8PsReeIvbUxMuWzbKRHyo=;
        b=JHn7IUaDYQ9uEJHQBIN3vr9Ew3dkYuJLs2rzcReEqI94IwxqeRBnTFmW2Uq74GMKy0rl+D
        kk9rk/2E2OTzdACo/+JZ8LRBCT2PFrcxiU74IgVrGOYlVaGpVpI4V5knBYlvvJKT2hK3kN
        /FDIsl9gJZKCWqK8aaO9iVzn/BEbg3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678228265;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ESmXSz9yy8NQE1Zdwj05I8PsReeIvbUxMuWzbKRHyo=;
        b=7QPid6JmP3fKPwlnQjLwyMO7bPK7nKZGxTZWmQIudpBoM9rJzOuCxaNkwCU4w/+W6OzzlQ
        KVMoHGLtZ95egEAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D0A613440;
        Tue,  7 Mar 2023 22:31:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1HTeACa7B2SqAgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 07 Mar 2023 22:31:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jerry Zhang" <jerry@skydio.com>
Cc:     embedded@skydio.com, "Jerry Zhang" <Jerry@skydio.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna@kernel.org>,
        "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sunrpc: Fix incorrect parsing of expiry time
In-reply-to: <20230307220525.54895-1-Jerry@skydio.com>
References: <20230307220525.54895-1-Jerry@skydio.com>
Date:   Wed, 08 Mar 2023 09:30:59 +1100
Message-id: <167822825917.8008.11050193827453206272@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 08 Mar 2023, Jerry Zhang wrote:
> The expiry time field is mean to be expressed in seconds since boot.

Correct.

> The get_expiry() function parses a relative time value in seconds.

Incorrect.  It parses and absoulte wall-clock time.

NeilBrown

> In order to get the absolute time of seconds since boot that the given
> message will expire, the right thing is to add seconds_since_boot()
> to the given relative value.
> 
> Previously this logic was subtracting boot.tv_sec from the relative
> value, which was causing some confusing behavior. The return type of
> time64_t could possibly underflow if time since boot is greater than
> the passed in relative argument. Also several checks in nfs code compare
> the return value to 0 to indicate failure, and this could spuriously
> be tripped if seconds since boot happened to match the argument.
> 
> Fixes: c5b29f885afe ("sunrpc: use seconds since boot in expiry cache")
> Signed-off-by: Jerry Zhang <Jerry@skydio.com>
> ---
>  include/linux/sunrpc/cache.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
> index ec5a555df96f..b96b1319c93d 100644
> --- a/include/linux/sunrpc/cache.h
> +++ b/include/linux/sunrpc/cache.h
> @@ -301,16 +301,14 @@ static inline int get_time(char **bpp, time64_t *time)
>  }
>  
>  static inline time64_t get_expiry(char **bpp)
>  {
>  	time64_t rv;
> -	struct timespec64 boot;
>  
>  	if (get_time(bpp, &rv))
>  		return 0;
>  	if (rv < 0)
>  		return 0;
> -	getboottime64(&boot);
> -	return rv - boot.tv_sec;
> +	return rv + seconds_since_boot();
>  }
>  
>  #endif /*  _LINUX_SUNRPC_CACHE_H_ */
> -- 
> 2.37.3
> 
> 

