Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E143575CB39
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 17:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjGUPPU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jul 2023 11:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGUPPR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jul 2023 11:15:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8049D30D4
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jul 2023 08:14:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CDBA61CE8
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jul 2023 15:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C26C433C8;
        Fri, 21 Jul 2023 15:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689952482;
        bh=Gsqjn6d8WcjJnx321Uqp2mr8rb/FNRmVKwR3oSBay48=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aBjXl1gzgJ304t0ixS4y2AWqgU4ppt2xWnC/+Tnw7++uQw9vdAW2AlxaMKtrGtZbb
         Okz+fkD2hrEcxUW5E3/wRxPAfzXYOIa3OYwm3nv4ijPd2Ss5iBR9UIQkyGtSU2lHL9
         iFJvOOTTCqSPQ9yiQfg3jpFc7PZiOrDOiQk/QL5pzAZWdhweNHjik8kahLouPCgFGt
         du17tgP6HRGrMWiR/PQFfK/rhT3H69kmwBDHHqexPDE2pkZfJnN63qy40ig1bUCOq5
         8yJH56Z9VKlGiM2hNQ7qjYFC09+U+vC8u1yG3q38xKZJzG81xguw3MhbdAEsNSRrti
         NZNVPyxRB3QlA==
Message-ID: <4c9a7948dbc502583b0f09f08f0c2ea5bdfa3431.camel@kernel.org>
Subject: Re: [RFC v6.5-rc2 1/3] fs: lockd: nlm_blocked list race fixes
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Aring <aahringo@redhat.com>, chuck.lever@oracle.com
Cc:     neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com,
        tom@talpey.com, trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org, teigland@redhat.com,
        cluster-devel@redhat.com, agruenba@redhat.com
Date:   Fri, 21 Jul 2023 11:14:40 -0400
In-Reply-To: <20230720125806.1385279-1-aahringo@redhat.com>
References: <20230720125806.1385279-1-aahringo@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-07-20 at 08:58 -0400, Alexander Aring wrote:
> This patch fixes races when lockd accessing the global nlm_blocked list.
> It was mostly safe to access the list because everything was accessed
> from the lockd kernel thread context but there exists cases like
> nlmsvc_grant_deferred() that could manipulate the nlm_blocked list and
> it can be called from any context.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/lockd/svclock.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index c43ccdf28ed9..28abec5c451d 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -131,12 +131,14 @@ static void nlmsvc_insert_block(struct nlm_block *b=
lock, unsigned long when)
>  static inline void
>  nlmsvc_remove_block(struct nlm_block *block)
>  {
> +	spin_lock(&nlm_blocked_lock);
>  	if (!list_empty(&block->b_list)) {
> -		spin_lock(&nlm_blocked_lock);
>  		list_del_init(&block->b_list);
>  		spin_unlock(&nlm_blocked_lock);
>  		nlmsvc_release_block(block);
> +		return;
>  	}
> +	spin_unlock(&nlm_blocked_lock);
>  }
> =20
>  /*
> @@ -152,6 +154,7 @@ nlmsvc_lookup_block(struct nlm_file *file, struct nlm=
_lock *lock)
>  				file, lock->fl.fl_pid,
>  				(long long)lock->fl.fl_start,
>  				(long long)lock->fl.fl_end, lock->fl.fl_type);
> +	spin_lock(&nlm_blocked_lock);
>  	list_for_each_entry(block, &nlm_blocked, b_list) {
>  		fl =3D &block->b_call->a_args.lock.fl;
>  		dprintk("lockd: check f=3D%p pd=3D%d %Ld-%Ld ty=3D%d cookie=3D%s\n",
> @@ -161,9 +164,11 @@ nlmsvc_lookup_block(struct nlm_file *file, struct nl=
m_lock *lock)
>  				nlmdbg_cookie2a(&block->b_call->a_args.cookie));
>  		if (block->b_file =3D=3D file && nlm_compare_locks(fl, &lock->fl)) {
>  			kref_get(&block->b_count);
> +			spin_unlock(&nlm_blocked_lock);
>  			return block;
>  		}
>  	}
> +	spin_unlock(&nlm_blocked_lock);
> =20
>  	return NULL;
>  }
> @@ -185,16 +190,19 @@ nlmsvc_find_block(struct nlm_cookie *cookie)
>  {
>  	struct nlm_block *block;
> =20
> +	spin_lock(&nlm_blocked_lock);
>  	list_for_each_entry(block, &nlm_blocked, b_list) {
>  		if (nlm_cookie_match(&block->b_call->a_args.cookie,cookie))
>  			goto found;
>  	}
> +	spin_unlock(&nlm_blocked_lock);
> =20
>  	return NULL;
> =20
>  found:
>  	dprintk("nlmsvc_find_block(%s): block=3D%p\n", nlmdbg_cookie2a(cookie),=
 block);
>  	kref_get(&block->b_count);
> +	spin_unlock(&nlm_blocked_lock);
>  	return block;
>  }
> =20
> @@ -317,6 +325,7 @@ void nlmsvc_traverse_blocks(struct nlm_host *host,
> =20
>  restart:
>  	mutex_lock(&file->f_mutex);
> +	spin_lock(&nlm_blocked_lock);
>  	list_for_each_entry_safe(block, next, &file->f_blocks, b_flist) {
>  		if (!match(block->b_host, host))
>  			continue;
> @@ -325,11 +334,13 @@ void nlmsvc_traverse_blocks(struct nlm_host *host,
>  		if (list_empty(&block->b_list))
>  			continue;
>  		kref_get(&block->b_count);
> +		spin_unlock(&nlm_blocked_lock);
>  		mutex_unlock(&file->f_mutex);
>  		nlmsvc_unlink_block(block);
>  		nlmsvc_release_block(block);
>  		goto restart;
>  	}
> +	spin_unlock(&nlm_blocked_lock);
>  	mutex_unlock(&file->f_mutex);
>  }
> =20

The patch itself looks correct. Walking these lists without holding the
lock is quite suspicious. Not sure about the stable designation here
though, unless you have a way to easily reproduce this.=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
