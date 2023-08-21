Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EF37820EF
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Aug 2023 02:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjHUA1l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 20 Aug 2023 20:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjHUA1k (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 20 Aug 2023 20:27:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C836A6;
        Sun, 20 Aug 2023 17:27:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 24A6121A81;
        Mon, 21 Aug 2023 00:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692577657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AY/1rkFsff3ua8LyvK9x7k/GK7tr57jHaYZvKmjWRhU=;
        b=0Sm5IAmtq7eH6sUQQXZd/oxwVs+4eZ6LvV+LuGrLE+2QfImPpowfwnywH8fm8+ojIEbX48
        2cByreO//79B5oJHSg0v/1jJA+xfaSKftCqwt7GKwfCWgZ1SIM8uMTOHpi0zpNDfnTD9+g
        d1vQdQs7vS1ZKZ6Vc6U4/zHV+RfjnRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692577657;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AY/1rkFsff3ua8LyvK9x7k/GK7tr57jHaYZvKmjWRhU=;
        b=tmnT77nKXVFHiTfZo8W6sHQ22pddg/qFMIYSBVz3mg8nQMGcaCbsPbFN9kWwkdiEEq5MoF
        HspuenZ2QTDRgLBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A45B813458;
        Mon, 21 Aug 2023 00:27:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GnnqFXWv4mQgfQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 21 Aug 2023 00:27:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Haodong Wong" <haydenw.kernel@gmail.com>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org, haodong.wong@nio.com,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: fix race condition in nfsd_file_acquire
In-reply-to: <20230818065507.1280625-1-haydenw.kernel@gmail.com>
References: <20230818065507.1280625-1-haydenw.kernel@gmail.com>
Date:   Mon, 21 Aug 2023 10:27:23 +1000
Message-id: <169257764320.11865.9867985815081936092@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 18 Aug 2023, Haodong Wong wrote:
> Before Kernel 6.1, we observed the following OOPS in the stress test
> caused by reorder on set bit NFSD_FILE_HASHED and NFSD_FILE_PENDING,
> and smp_mb__after_atomic() should be a paire.

If you saw this "before kernel 6.1" does that mean you don't see it
after kernel 6.1?  So has it already been fixed?

What kernel are you targeting with your patch?  It doesn't apply to
mainline, but looks like it might to 6.0.  The oops message is from
5.10.104.  Maybe that is where you want a fix?

I assume you want this fix to go to a -stable kernel?  It would be good
to identify which upstream patch fixed the problem, then either backport
that, or explain why something simpler is needed.

>=20
> Task A:                         Task B:
>=20
> nfsd_file_acquire:
>=20
>                           new =3D nfsd_file_alloc()
>                           open_file:
>                           refcount_inc(&nf->nf_ref);

The key step in Task A is=20
	hlist_add_head_rcu(&nf->nf_node,
		 &nfsd_file_hashtbl[hashval].nfb_head);

Until that completes, nfsd_file_find_locked() cannot find the new file.
hlist_add_head_rcu() uses "rcu_assign_pointer()" which should include
all the barriers needed.

>                                  nf =3D nfsd_file_find_locked();
>                                  wait_for_construction:
>=20
>                                  since nf_flags is zero it will not wait
>=20
>                                  wait_on_bit(&nf->nf_flags,
>                                                     NFSD_FILE_PENDING);
>=20
>                                 if (status =3D=3D nfs_ok) {
>                                      *pnf =3D nf;      //OOPS happen!

The oops message suggests that after nfsd_read() calls
nfsd_file_acquire() there is no error, but nf is NULL.
So the  nf->nf_file access causes the oops.  nf_file is at offset
0x28, which is the virtual address mentioned in the oops.

So do you think 'nf' is NULL at this point where you write "OOPS
happen!" ??=20
I cannot see how that might happen even if wait_on_bit() didn't
actually wait.

Maybe if you could explain if a bit more detail what you think is
happening.  What exactly is NULL which causes the OOPS, and how exactly
does it end up being NULL.
I cannot see what might be the cause, but the oops makes it clear that
it did happen.

Also is this a pure 5.10.104 kernel, or are there other patches on it?

Thanks,
NeilBrown



>=20
> Unable to handle kernel NULL pointer at virtual address 0000000000000028
> Mem abort info:
>   ESR =3D 0x96000004
>   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>   SET =3D 0, FnV =3D 0
>   EA =3D 0, S1PTW =3D 0
> Data abort info:
>   ISV =3D 0, ISS =3D 0x00000004
>   CM =3D 0, WnR =3D 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000152546000
> [0000000000000028] pgd=3D0000000000000000, p4d=3D0000000000000000
> Internal error: Oops: 96000004 [#1] PREEMPT_RT SMP
> CPU: 7 PID: 1767 Comm: nfsd Not tainted 5.10.104 #1
> pstate: 40c00005 (nZcv daif +PAN +UAO -TCO BTYPE=3D--)
> pc : nfsd_read+0x78/0x280 [nfsd]
> lr : nfsd_read+0x68/0x280 [nfsd]
> sp : ffff80001c0b3c70
> x29: ffff80001c0b3c70 x28: 0000000000000000
> x27: 0000000000000002 x26: ffff0000c8a3ca70
> x25: ffff0000c8a45180 x24: 0000000000002000
> x23: ffff0000c8a45178 x22: ffff0000c8a45008
> x21: ffff0000c31aac40 x20: ffff0000c8a3c000
> x19: 0000000000000000 x18: 0000000000000001
> x17: 0000000000000007 x16: 00000000b35db681
> x15: 0000000000000156 x14: ffff0000c3f91300
> x13: 0000000000000000 x12: 0000000000000000
> x11: 0000000000000000 x10: 0000000000000000
> x9 : 0000000000000000 x8 : ffff000118014a80
> x7 : 0000000000000002 x6 : ffff0002559142dc
> x5 : ffff0000c31aac40 x4 : 0000000000000004
> x3 : 0000000000000001 x2 : 0000000000000000
> x1 : 0000000000000001 x0 : ffff000255914280
> Call trace:
>  nfsd_read+0x78/0x280 [nfsd]
>  nfsd3_proc_read+0x98/0xc0 [nfsd]
>  nfsd_dispatch+0xc8/0x160 [nfsd]
>  svc_process_common+0x440/0x790
>  svc_process+0xb0/0xd0
>  nfsd+0xfc/0x160 [nfsd]
>  kthread+0x17c/0x1a0
>  ret_from_fork+0x10/0x18
>=20
> Signed-off-by: Haodong Wong <haydenw.kernel@gmail.com>
> ---
>  fs/nfsd/filecache.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index e30e1ddc1ace..ba980369e6b4 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -974,8 +974,12 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_f=
h *fhp,
>  	nfsd_file_slab_free(&new->nf_rcu);
> =20
>  wait_for_construction:
> +	/* In case of set bit NFSD_FILE_PENDING and NFSD_FILE_HASHED reorder */
> +	smp_rmb();
>  	wait_on_bit(&nf->nf_flags, NFSD_FILE_PENDING, TASK_UNINTERRUPTIBLE);
> =20
> +	/* Be a paire of smp_mb after clear bit NFSD_FILE_PENDING */
> +	smp_mb__after_atomic();
>  	/* Did construction of this file fail? */
>  	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
>  		if (!retry) {
> @@ -1018,8 +1022,11 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
>  	nf =3D new;
>  	/* Take reference for the hashtable */
>  	refcount_inc(&nf->nf_ref);
> -	__set_bit(NFSD_FILE_HASHED, &nf->nf_flags);
>  	__set_bit(NFSD_FILE_PENDING, &nf->nf_flags);
> +	/* Ensure set bit order set NFSD_FILE_HASHED after set NFSD_FILE_PENDING =
*/
> +	smp_wmb();
> +	__set_bit(NFSD_FILE_HASHED, &nf->nf_flags);
> +
>  	list_lru_add(&nfsd_file_lru, &nf->nf_lru);
>  	hlist_add_head_rcu(&nf->nf_node, &nfsd_file_hashtbl[hashval].nfb_head);
>  	++nfsd_file_hashtbl[hashval].nfb_count;
> --=20
> 2.25.1
>=20
>=20

