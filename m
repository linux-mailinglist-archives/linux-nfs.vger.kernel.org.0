Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022EF5F389D
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Oct 2022 00:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiJCWHi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Oct 2022 18:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJCWHg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Oct 2022 18:07:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7FD20F69
        for <linux-nfs@vger.kernel.org>; Mon,  3 Oct 2022 15:07:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1542C218B5;
        Mon,  3 Oct 2022 22:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664834854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Qoy7OR8yx0bkrI7WtFXmVUXWqj+IXFMQDqmZFglxLg=;
        b=QlFMILyETmAYa+8ecwqbVWkCh9r70nFmNIeZ3M8yw06clv/Kk4bFJC2uQZuouqJvfHh3ZI
        EaMx9kHkCZqcUWv/Se8gt4n/GZKUAkR+xrLvmCzQ1ivwtfNpOKhLjAGhD0vcdcxVDTk437
        5KHGGy8ZfR8huIbj6UjB4xNnENLoA3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664834854;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Qoy7OR8yx0bkrI7WtFXmVUXWqj+IXFMQDqmZFglxLg=;
        b=sjalXxIZaXVcz/saZgTcQHoywcCqI2ZakuKHEyG/l7PTKWV7LHONxrWvNGbZlJtpmK7CJl
        EH4LiewQ8mGFbtDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F038913522;
        Mon,  3 Oct 2022 22:07:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P3/DKiRdO2MdfwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 03 Oct 2022 22:07:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3] nfsd: rework hashtable handling in nfsd_do_file_acquire
In-reply-to: <F4DF35B2-CE11-4BD9-8442-97852F57CE2E@oracle.com>
References: <20221003113436.24161-1-jlayton@kernel.org>,
 <F4DF35B2-CE11-4BD9-8442-97852F57CE2E@oracle.com>
Date:   Tue, 04 Oct 2022 09:07:29 +1100
Message-id: <166483484979.14457.9448463531121052564@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 04 Oct 2022, Chuck Lever III wrote:
>=20
> > On Oct 3, 2022, at 7:34 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > nfsd_file is RCU-freed, so we need to hold the rcu_read_lock long enough
> > to get a reference after finding it in the hash. Take the
> > rcu_read_lock() and call rhashtable_lookup directly.
> >=20
> > Switch to using rhashtable_lookup_insert_key as well, and use the usual
> > retry mechanism if we hit an -EEXIST. Eliminiate the insert_err goto
> > target as well.
>=20
> The insert_err goto is there to remove a very rare case from
> the hot path. I'd kinda like to keep that feature of this code.

????
The fast path in the new code looks quite clean - what concerns you?
Maybe a "likely()" annotation can be used to encourage the compiler to
optimise for the non-error path so the error-handling gets moved
out-of-line (assuming it isn't already), but don't think the new code
needs that goto.

NeilBrown


>=20
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
> > @@ -1043,9 +1043,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
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
> > @@ -1055,35 +1056,35 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
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
> > @@ -1143,13 +1144,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
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
>=20
