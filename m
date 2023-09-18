Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EE37A3F35
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 03:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjIRBZ6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 17 Sep 2023 21:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbjIRBZn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 17 Sep 2023 21:25:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53485126
        for <linux-nfs@vger.kernel.org>; Sun, 17 Sep 2023 18:25:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 088D6219AC;
        Mon, 18 Sep 2023 01:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695000336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qfgOvH6F1bGgM28P4j4jyAe6y6+C8NQa7GFGMCN9JVU=;
        b=J48lbATGefO9o8s36i7RbaGPoJ1EN9Y+K4IKCVxMktwwALYzuYoOfgrQ9xGSDV7z9upwHe
        YigiAKQdVh7AWSomh4LkIzIFG0QKwP4mDEfZhDOW7ptr1j7D0WqowNOm4BR6Wue9s9zuWv
        Rr0YLFjJVhk9IlQ2/3Q1ZRUUvLGpLe8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695000336;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qfgOvH6F1bGgM28P4j4jyAe6y6+C8NQa7GFGMCN9JVU=;
        b=W+lKDRVq4hjddCGLGxr85lTCm2aKUA7l7NFbhwQ7pvrI7/dhDVLCv9hDfn8eIRp+4+eLGw
        4APNOgRP7bJHlCBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B52CD13A49;
        Mon, 18 Sep 2023 01:25:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eBWsGQ6nB2VfTAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 18 Sep 2023 01:25:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     trondmy@kernel.org
Cc:     "Anna Schumaker" <Anna.Schumaker@netapp.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFSv4: Fix a state manager thread deadlock regression
In-reply-to: <20230917230551.30483-2-trondmy@kernel.org>
References: <20230917230551.30483-1-trondmy@kernel.org>,
 <20230917230551.30483-2-trondmy@kernel.org>
Date:   Mon, 18 Sep 2023 11:25:31 +1000
Message-id: <169500033147.8274.17464264746177119631@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 18 Sep 2023, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> Commit 4dc73c679114 reintroduces the deadlock that was fixed by commit
> aeabb3c96186 ("NFSv4: Fix a NFSv4 state manager deadlock") because it
> prevents the setup of new threads to handle reboot recovery, while the
> older recovery thread is stuck returning delegations.

I hadn't realised that the state manager thread did these two distinct
tasks and might need to be doing both at once - requiring two threads.
Thanks for highlighting that.

It seems to me that even with the new code, we can still get a deadlock
when swap is enabled, as we only ever run one thread in that case.
Is that correct, or did I miss something?

Maybe we need two threads - a state manager and a delegation recall
handler.  And when swap is enabled, both need to be running permanently
??

Thanks,
NeilBrown


>=20
> Fixes: 4dc73c679114 ("NFSv4: keep state manager thread active if swap is en=
abled")
> Cc: stable@vger.kernel.org
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/nfs4proc.c  |  4 +++-
>  fs/nfs/nfs4state.c | 38 ++++++++++++++++++++++++++------------
>  2 files changed, 29 insertions(+), 13 deletions(-)
>=20
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 5deeaea8026e..a19e809cad16 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -10652,7 +10652,9 @@ static void nfs4_disable_swap(struct inode *inode)
>  	 */
>  	struct nfs_client *clp =3D NFS_SERVER(inode)->nfs_client;
> =20
> -	nfs4_schedule_state_manager(clp);
> +	set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
> +	clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
> +	wake_up_var(&clp->cl_state);
>  }
> =20
>  static const struct inode_operations nfs4_dir_inode_operations =3D {
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index 0bc160fbabec..5751a6886da4 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -1209,16 +1209,26 @@ void nfs4_schedule_state_manager(struct nfs_client =
*clp)
>  {
>  	struct task_struct *task;
>  	char buf[INET6_ADDRSTRLEN + sizeof("-manager") + 1];
> +	struct rpc_clnt *clnt =3D clp->cl_rpcclient;
> +	bool swapon =3D false;
> =20
> -	if (clp->cl_rpcclient->cl_shutdown)
> +	if (clnt->cl_shutdown)
>  		return;
> =20
>  	set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
> -	if (test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state) !=3D 0) {
> -		wake_up_var(&clp->cl_state);
> -		return;
> +
> +	if (atomic_read(&clnt->cl_swapper)) {
> +		swapon =3D !test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE,
> +					   &clp->cl_state);
> +		if (!swapon) {
> +			wake_up_var(&clp->cl_state);
> +			return;
> +		}
>  	}
> -	set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state);
> +
> +	if (test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state) !=3D 0)
> +		return;
> +
>  	__module_get(THIS_MODULE);
>  	refcount_inc(&clp->cl_count);
> =20
> @@ -1235,8 +1245,9 @@ void nfs4_schedule_state_manager(struct nfs_client *c=
lp)
>  			__func__, PTR_ERR(task));
>  		if (!nfs_client_init_is_complete(clp))
>  			nfs_mark_client_ready(clp, PTR_ERR(task));
> +		if (swapon)
> +			clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
>  		nfs4_clear_state_manager_bit(clp);
> -		clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
>  		nfs_put_client(clp);
>  		module_put(THIS_MODULE);
>  	}
> @@ -2748,22 +2759,25 @@ static int nfs4_run_state_manager(void *ptr)
> =20
>  	allow_signal(SIGKILL);
>  again:
> -	set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state);
>  	nfs4_state_manager(clp);
> -	if (atomic_read(&cl->cl_swapper)) {
> +
> +	if (test_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state) &&
> +	    !test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state)) {
>  		wait_var_event_interruptible(&clp->cl_state,
>  					     test_bit(NFS4CLNT_RUN_MANAGER,
>  						      &clp->cl_state));
> -		if (atomic_read(&cl->cl_swapper) &&
> -		    test_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state))
> +		if (!atomic_read(&cl->cl_swapper))
> +			clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
> +		if (refcount_read(&clp->cl_count) > 1 && !signalled())
>  			goto again;
>  		/* Either no longer a swapper, or were signalled */
> +		clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
> +		nfs4_clear_state_manager_bit(clp);
>  	}
> -	clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
> =20
>  	if (refcount_read(&clp->cl_count) > 1 && !signalled() &&
>  	    test_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state) &&
> -	    !test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state))
> +	    !test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state))
>  		goto again;
> =20
>  	nfs_put_client(clp);
> --=20
> 2.41.0
>=20
>=20

