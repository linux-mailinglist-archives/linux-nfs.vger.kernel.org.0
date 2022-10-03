Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750B35F31F7
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Oct 2022 16:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJCO36 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Oct 2022 10:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiJCO35 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Oct 2022 10:29:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3C511C0E
        for <linux-nfs@vger.kernel.org>; Mon,  3 Oct 2022 07:29:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C18661018
        for <linux-nfs@vger.kernel.org>; Mon,  3 Oct 2022 14:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E72C433D6;
        Mon,  3 Oct 2022 14:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664807394;
        bh=9tJvs0Apo4MhADhT9CsF6wArgu04Dc858Ix9hFi7TY4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LsMuxRu4mmEqLfdoBCb7x68LZCKE0iqjZAYotGoTLZj1IPaWYQH1+oZUXV90Ryipy
         sIpKpk1ObSpv/vyH23q9RHKHC66mpaNy7qXT5BT4aebWOJjHQFNT9hlQ4aZIEQ0xW5
         +rvT9jLqCnAjmBvqk5ufjxAEu8sYYD1x7h3WZzdH3jTQEHaDqxx4Se9jCPGDIuWgpI
         345DUdL6SyThXAcVmsrfIiRSg3douc2CUWTUqRJCfcwh/JwNA+TeZiAl8WaDn1HTEc
         1B4hgQPPNnSia9+UptZ4eK2phEW9cLz2CEAL41ki7slWkG7mXaV5xVFyH6j2MSx6Fs
         K8DQTBlgYDHAg==
Message-ID: <5fc85ec6a9ae4c0ef5a1f4f9ea378c0b85f4070f.camel@kernel.org>
Subject: Re: [PATCH v3] nfsd: rework hashtable handling in
 nfsd_do_file_acquire
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Date:   Mon, 03 Oct 2022 10:29:52 -0400
In-Reply-To: <F4DF35B2-CE11-4BD9-8442-97852F57CE2E@oracle.com>
References: <20221003113436.24161-1-jlayton@kernel.org>
         <F4DF35B2-CE11-4BD9-8442-97852F57CE2E@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-10-03 at 13:11 +0000, Chuck Lever III wrote:
>=20
> > On Oct 3, 2022, at 7:34 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > nfsd_file is RCU-freed, so we need to hold the rcu_read_lock long enoug=
h
> > to get a reference after finding it in the hash. Take the
> > rcu_read_lock() and call rhashtable_lookup directly.
> >=20
> > Switch to using rhashtable_lookup_insert_key as well, and use the usual
> > retry mechanism if we hit an -EEXIST. Eliminiate the insert_err goto
> > target as well.
>=20
> The insert_err goto is there to remove a very rare case from
> the hot path. I'd kinda like to keep that feature of this code.
>=20

IDK. I'm not sold that this goto spaghetti has any value as an
optimization. I can put it back in if you like, but I think eliminating
one of the goto targets here is a good thing.

> The rest of the patch looks good.
>=20
>=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > fs/nfsd/filecache.c | 46 ++++++++++++++++++++-------------------------
> > 1 file changed, 20 insertions(+), 26 deletions(-)
> >=20
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index be152e3e3a80..63955f3353ed 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -1043,9 +1043,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
> > 		.need	=3D may_flags & NFSD_FILE_MAY_MASK,
> > 		.net	=3D SVC_NET(rqstp),
> > 	};
> > -	struct nfsd_file *nf, *new;
> > +	struct nfsd_file *nf;
> > 	bool retry =3D true;
> > 	__be32 status;
> > +	int ret;
> >=20
> > 	status =3D fh_verify(rqstp, fhp, S_IFREG,
> > 				may_flags|NFSD_MAY_OWNER_OVERRIDE);
> > @@ -1055,35 +1056,35 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, st=
ruct svc_fh *fhp,
> > 	key.cred =3D get_current_cred();
> >=20
> > retry:
> > -	/* Avoid allocation if the item is already in cache */
> > -	nf =3D rhashtable_lookup_fast(&nfsd_file_rhash_tbl, &key,
> > -				    nfsd_file_rhash_params);
> > +	rcu_read_lock();
> > +	nf =3D rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
> > +			       nfsd_file_rhash_params);
> > 	if (nf)
> > 		nf =3D nfsd_file_get(nf);
> > +	rcu_read_unlock();
> > 	if (nf)
> > 		goto wait_for_construction;
> >=20
> > -	new =3D nfsd_file_alloc(&key, may_flags);
> > -	if (!new) {
> > +	nf =3D nfsd_file_alloc(&key, may_flags);
> > +	if (!nf) {
> > 		status =3D nfserr_jukebox;
> > 		goto out_status;
> > 	}
> >=20
> > -	nf =3D rhashtable_lookup_get_insert_key(&nfsd_file_rhash_tbl,
> > -					      &key, &new->nf_rhash,
> > -					      nfsd_file_rhash_params);
> > -	if (!nf) {
> > -		nf =3D new;
> > -		goto open_file;
> > -	}
> > -	if (IS_ERR(nf))
> > -		goto insert_err;
> > -	nf =3D nfsd_file_get(nf);
> > -	if (nf =3D=3D NULL) {
> > -		nf =3D new;
> > +	ret =3D rhashtable_lookup_insert_key(&nfsd_file_rhash_tbl,
> > +					   &key, &nf->nf_rhash,
> > +					   nfsd_file_rhash_params);
> > +	if (ret =3D=3D 0)
> > 		goto open_file;
> > +
> > +	nfsd_file_slab_free(&nf->nf_rcu);
> > +	if (retry && ret =3D=3D EEXIST) {
> > +		retry =3D false;
> > +		goto retry;
> > 	}
> > -	nfsd_file_slab_free(&new->nf_rcu);
> > +	trace_nfsd_file_insert_err(rqstp, key.inode, may_flags, ret);
> > +	status =3D nfserr_jukebox;
> > +	goto out_status;
> >=20
> > wait_for_construction:
> > 	wait_on_bit(&nf->nf_flags, NFSD_FILE_PENDING, TASK_UNINTERRUPTIBLE);
> > @@ -1143,13 +1144,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
> > 	smp_mb__after_atomic();
> > 	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
> > 	goto out;
> > -
> > -insert_err:
> > -	nfsd_file_slab_free(&new->nf_rcu);
> > -	trace_nfsd_file_insert_err(rqstp, key.inode, may_flags, PTR_ERR(nf));
> > -	nf =3D NULL;
> > -	status =3D nfserr_jukebox;
> > -	goto out_status;
> > }
> >=20
> > /**
> > --=20
> > 2.37.3
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
