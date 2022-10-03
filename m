Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDA65F3893
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Oct 2022 00:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiJCWEk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Oct 2022 18:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJCWEj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Oct 2022 18:04:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD3DB3C
        for <linux-nfs@vger.kernel.org>; Mon,  3 Oct 2022 15:04:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B04611F8C4;
        Mon,  3 Oct 2022 22:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664834673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4j3SetwtitYmBuezU6/T/fgdnsCBy2E+trEgWsn946w=;
        b=qQetWeAi/17gMxrU8NNuTkawtQwCeM0l2bNyfzyNRi42xc5Zsg6/kr7iKNuyr3GbVDSoBi
        ZwhMR4p/VqxLo/eA4UXN7gbCoY1QibLsIqXlKfewwP1bJhulC2iOL67lJ73Q8iolZuA4hD
        Lo3KFqZRJ3Mq6USupcJHJdAMEmS7x/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664834673;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4j3SetwtitYmBuezU6/T/fgdnsCBy2E+trEgWsn946w=;
        b=YXcZy0IbONlI9YxiBtXGWXDj/rJHB3fShmKC2zKdDSFYllFMTkhzxgY0ew+vvNAGPxhigF
        6r2brY4/J2Ll3HDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 98DAC13522;
        Mon,  3 Oct 2022 22:04:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YOVrFXBcO2NffgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 03 Oct 2022 22:04:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3] nfsd: rework hashtable handling in nfsd_do_file_acquire
In-reply-to: <20221003113436.24161-1-jlayton@kernel.org>
References: <20221003113436.24161-1-jlayton@kernel.org>
Date:   Tue, 04 Oct 2022 09:04:29 +1100
Message-id: <166483466933.14457.15808409477112074300@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 03 Oct 2022, Jeff Layton wrote:
> nfsd_file is RCU-freed, so we need to hold the rcu_read_lock long enough
> to get a reference after finding it in the hash. Take the
> rcu_read_lock() and call rhashtable_lookup directly.
>=20
> Switch to using rhashtable_lookup_insert_key as well, and use the usual
> retry mechanism if we hit an -EEXIST. Eliminiate the insert_err goto
> target as well.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/filecache.c | 46 ++++++++++++++++++++-------------------------
>  1 file changed, 20 insertions(+), 26 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index be152e3e3a80..63955f3353ed 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -1043,9 +1043,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
>  		.need	=3D may_flags & NFSD_FILE_MAY_MASK,
>  		.net	=3D SVC_NET(rqstp),
>  	};
> -	struct nfsd_file *nf, *new;
> +	struct nfsd_file *nf;
>  	bool retry =3D true;
>  	__be32 status;
> +	int ret;
> =20
>  	status =3D fh_verify(rqstp, fhp, S_IFREG,
>  				may_flags|NFSD_MAY_OWNER_OVERRIDE);
> @@ -1055,35 +1056,35 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
>  	key.cred =3D get_current_cred();
> =20
>  retry:
> -	/* Avoid allocation if the item is already in cache */
> -	nf =3D rhashtable_lookup_fast(&nfsd_file_rhash_tbl, &key,
> -				    nfsd_file_rhash_params);
> +	rcu_read_lock();
> +	nf =3D rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
> +			       nfsd_file_rhash_params);
>  	if (nf)
>  		nf =3D nfsd_file_get(nf);
> +	rcu_read_unlock();
>  	if (nf)
>  		goto wait_for_construction;
> =20
> -	new =3D nfsd_file_alloc(&key, may_flags);
> -	if (!new) {
> +	nf =3D nfsd_file_alloc(&key, may_flags);
> +	if (!nf) {
>  		status =3D nfserr_jukebox;
>  		goto out_status;
>  	}
> =20
> -	nf =3D rhashtable_lookup_get_insert_key(&nfsd_file_rhash_tbl,
> -					      &key, &new->nf_rhash,
> -					      nfsd_file_rhash_params);
> -	if (!nf) {
> -		nf =3D new;
> -		goto open_file;
> -	}
> -	if (IS_ERR(nf))
> -		goto insert_err;
> -	nf =3D nfsd_file_get(nf);
> -	if (nf =3D=3D NULL) {
> -		nf =3D new;
> +	ret =3D rhashtable_lookup_insert_key(&nfsd_file_rhash_tbl,
> +					   &key, &nf->nf_rhash,
> +					   nfsd_file_rhash_params);
> +	if (ret =3D=3D 0)
>  		goto open_file;
> +
> +	nfsd_file_slab_free(&nf->nf_rcu);
> +	if (retry && ret =3D=3D EEXIST) {

You need a "-" sign in there.

> +		retry =3D false;

I can see no justification for either testing or setting "retry" here.
In the original code, limiting retries is about the "open_file" branch
hitting an error.  That is totally different from a race that might
delete the file immediately after a lookup_insert failed.  At most it
should be a different retry counter.  If you are really concerned about
retries here, then we should stay with
rhashtable_lookup_get_insert_key().

Thanks,
NeilBrown


> +		goto retry;
>  	}
> -	nfsd_file_slab_free(&new->nf_rcu);
> +	trace_nfsd_file_insert_err(rqstp, key.inode, may_flags, ret);
> +	status =3D nfserr_jukebox;
> +	goto out_status;
> =20
>  wait_for_construction:
>  	wait_on_bit(&nf->nf_flags, NFSD_FILE_PENDING, TASK_UNINTERRUPTIBLE);
> @@ -1143,13 +1144,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
>  	smp_mb__after_atomic();
>  	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
>  	goto out;
> -
> -insert_err:
> -	nfsd_file_slab_free(&new->nf_rcu);
> -	trace_nfsd_file_insert_err(rqstp, key.inode, may_flags, PTR_ERR(nf));
> -	nf =3D NULL;
> -	status =3D nfserr_jukebox;
> -	goto out_status;
>  }
> =20
>  /**
> --=20
> 2.37.3
>=20
>=20
