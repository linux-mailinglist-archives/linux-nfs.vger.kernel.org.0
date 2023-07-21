Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1010D75CC48
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 17:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjGUPpK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jul 2023 11:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjGUPpJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jul 2023 11:45:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F304DE6F
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jul 2023 08:45:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77FDE61D07
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jul 2023 15:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31B5C433C7;
        Fri, 21 Jul 2023 15:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689954306;
        bh=9pGlsUT00vvXaY4RDOQRbTD6M65a7Op27IN0gdyFmBs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rQzA7n3JGvqNUCqvaZaMfJy7doW/N9kjPHXdNnoCJ246s84bdWiPagAG4CHy/+bKr
         F/xDJZwXnoay9DgvtPuxLU9pOrcI2izwkL4h8sxtY0gw8cDpgQqUeyNRNfGiH3Ynjw
         Kqc7kqoDu5yyYvUdXMPxaFzJPGZWjyEzvj5wxBpqKsTeLXICeL+5Xy7C8Pzvn+8yhp
         5XhIZwZGwdrRIm1HmufwSNjIf3bWGFMNKNSdGO4XzvIL5DgDEMG8F+nxi3xcMyKwO1
         zcCQfgVBvGhHXFi1oYHExakme5vESkA4oeJscQQDj4elWEQ/dhZ859trr2DuI6e9St
         T006guu+qgXhg==
Message-ID: <af8586c743be551c3f939455368fc288856abe11.camel@kernel.org>
Subject: Re: [RFC v6.5-rc2 2/3] fs: lockd: fix race in async lock request
 handling
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Aring <aahringo@redhat.com>, chuck.lever@oracle.com
Cc:     neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com,
        tom@talpey.com, trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org, teigland@redhat.com,
        cluster-devel@redhat.com, agruenba@redhat.com
Date:   Fri, 21 Jul 2023 11:45:04 -0400
In-Reply-To: <20230720125806.1385279-2-aahringo@redhat.com>
References: <20230720125806.1385279-1-aahringo@redhat.com>
         <20230720125806.1385279-2-aahringo@redhat.com>
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
> This patch fixes a race in async lock request handling between adding
> the relevant struct nlm_block to nlm_blocked list after the request was
> sent by vfs_lock_file() and nlmsvc_grant_deferred() does a lookup of the
> nlm_block in the nlm_blocked list. It could be that the async request is
> completed before the nlm_block was added to the list. This would end
> in a -ENOENT and a kernel log message of "lockd: grant for unknown
> block".
>=20
> To solve this issue we add the nlm_block before the vfs_lock_file() call
> to be sure it has been added when a possible nlmsvc_grant_deferred() is
> called. If the vfs_lock_file() results in an case when it wouldn't be
> added to nlm_blocked list, the nlm_block struct will be removed from
> this list again.
>=20
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/lockd/svclock.c          | 80 +++++++++++++++++++++++++++----------
>  include/linux/lockd/lockd.h |  1 +
>  2 files changed, 60 insertions(+), 21 deletions(-)
>=20
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index 28abec5c451d..62ef27a69a9e 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -297,6 +297,8 @@ static void nlmsvc_free_block(struct kref *kref)
> =20
>  	dprintk("lockd: freeing block %p...\n", block);
> =20
> +	WARN_ON_ONCE(block->b_flags & B_PENDING_CALLBACK);
> +
>  	/* Remove block from file's list of blocks */
>  	list_del_init(&block->b_flist);
>  	mutex_unlock(&file->f_mutex);
> @@ -543,6 +545,12 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file =
*file,
>  		goto out;
>  	}
> =20
> +	if (block->b_flags & B_PENDING_CALLBACK)
> +		goto pending_request;
> +
> +	/* Append to list of blocked */
> +	nlmsvc_insert_block(block, NLM_NEVER);
> +
>  	if (!wait)
>  		lock->fl.fl_flags &=3D ~FL_SLEEP;
>  	mode =3D lock_to_openmode(&lock->fl);
> @@ -552,9 +560,13 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file =
*file,
>  	dprintk("lockd: vfs_lock_file returned %d\n", error);
>  	switch (error) {
>  		case 0:
> +			nlmsvc_remove_block(block);
>  			ret =3D nlm_granted;
>  			goto out;
>  		case -EAGAIN:
> +			if (!wait)
> +				nlmsvc_remove_block(block);
> +pending_request:
>  			/*
>  			 * If this is a blocking request for an
>  			 * already pending lock request then we need
> @@ -565,6 +577,8 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *=
file,
>  			ret =3D async_block ? nlm_lck_blocked : nlm_lck_denied;
>  			goto out;
>  		case FILE_LOCK_DEFERRED:
> +			block->b_flags |=3D B_PENDING_CALLBACK;
> +
>  			if (wait)
>  				break;
>  			/* Filesystem lock operation is in progress
> @@ -572,17 +586,16 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file=
 *file,
>  			ret =3D nlmsvc_defer_lock_rqst(rqstp, block);

When the above function is called, it's going to end up reinserting the
block into the list. I think you probably also need to remove the call
to nlmsvc_insert_block from nlmsvc_defer_lock_rqst since it could have
been granted before that occurs.

>  			goto out;
>  		case -EDEADLK:
> +			nlmsvc_remove_block(block);
>  			ret =3D nlm_deadlock;
>  			goto out;
>  		default:			/* includes ENOLCK */
> +			nlmsvc_remove_block(block);
>  			ret =3D nlm_lck_denied_nolocks;
>  			goto out;
>  	}
> =20
>  	ret =3D nlm_lck_blocked;
> -
> -	/* Append to list of blocked */
> -	nlmsvc_insert_block(block, NLM_NEVER);
>  out:
>  	mutex_unlock(&file->f_mutex);
>  	nlmsvc_release_block(block);
> @@ -739,34 +752,59 @@ nlmsvc_update_deferred_block(struct nlm_block *bloc=
k, int result)
>  		block->b_flags |=3D B_TIMED_OUT;
>  }
> =20
> +static int __nlmsvc_grant_deferred(struct nlm_block *block,
> +				   struct file_lock *fl,
> +				   int result)
> +{
> +	int rc =3D 0;
> +
> +	dprintk("lockd: nlmsvc_notify_blocked block %p flags %d\n",
> +					block, block->b_flags);
> +	if (block->b_flags & B_QUEUED) {
> +		if (block->b_flags & B_TIMED_OUT) {
> +			rc =3D -ENOLCK;
> +			goto out;
> +		}
> +		nlmsvc_update_deferred_block(block, result);
> +	} else if (result =3D=3D 0)
> +		block->b_granted =3D 1;
> +
> +	nlmsvc_insert_block_locked(block, 0);
> +	svc_wake_up(block->b_daemon);
> +out:
> +	return rc;
> +}
> +
>  static int nlmsvc_grant_deferred(struct file_lock *fl, int result)
>  {
> -	struct nlm_block *block;
> -	int rc =3D -ENOENT;
> +	struct nlm_block *block =3D NULL;
> +	int rc;
> =20
>  	spin_lock(&nlm_blocked_lock);
>  	list_for_each_entry(block, &nlm_blocked, b_list) {
>  		if (nlm_compare_locks(&block->b_call->a_args.lock.fl, fl)) {
> -			dprintk("lockd: nlmsvc_notify_blocked block %p flags %d\n",
> -							block, block->b_flags);
> -			if (block->b_flags & B_QUEUED) {
> -				if (block->b_flags & B_TIMED_OUT) {
> -					rc =3D -ENOLCK;
> -					break;
> -				}
> -				nlmsvc_update_deferred_block(block, result);
> -			} else if (result =3D=3D 0)
> -				block->b_granted =3D 1;
> -
> -			nlmsvc_insert_block_locked(block, 0);
> -			svc_wake_up(block->b_daemon);
> -			rc =3D 0;
> +			kref_get(&block->b_count);
>  			break;
>  		}
>  	}
>  	spin_unlock(&nlm_blocked_lock);
> -	if (rc =3D=3D -ENOENT)
> -		printk(KERN_WARNING "lockd: grant for unknown block\n");
> +
> +	if (!block) {
> +		pr_warn("lockd: grant for unknown pending block\n");
> +		return -ENOENT;
> +	}
> +
> +	/* don't interfere with nlmsvc_lock() */
> +	mutex_lock(&block->b_file->f_mutex);


This is called from lm_grant, and Documentation/filesystems/locking.rst
says that lm_grant is not allowed to block. The only caller though is
dlm_plock_callback, and I don't see anything that would prevent
blocking.

Do we need to fix the documentation there?


> +	block->b_flags &=3D ~B_PENDING_CALLBACK;
> +

You're adding this new flag when the lock is deferred and then clearing
it when the lock is granted. What about when the lock request is
cancelled (e.g. by signal)? It seems like you also need to clear it then
too, correct?

> +	spin_lock(&nlm_blocked_lock);
> +	WARN_ON_ONCE(list_empty(&block->b_list));
> +	rc =3D __nlmsvc_grant_deferred(block, fl, result);
> +	spin_unlock(&nlm_blocked_lock);
> +	mutex_unlock(&block->b_file->f_mutex);
> +
> +	nlmsvc_release_block(block);
>  	return rc;
>  }
> =20
> diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
> index f42594a9efe0..a977be8bcc2c 100644
> --- a/include/linux/lockd/lockd.h
> +++ b/include/linux/lockd/lockd.h
> @@ -189,6 +189,7 @@ struct nlm_block {
>  #define B_QUEUED		1	/* lock queued */
>  #define B_GOT_CALLBACK		2	/* got lock or conflicting lock */
>  #define B_TIMED_OUT		4	/* filesystem too slow to respond */
> +#define B_PENDING_CALLBACK	8	/* pending callback for lock request */
>  };
> =20
>  /*

--=20
Jeff Layton <jlayton@kernel.org>
