Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76635FA8BB
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Oct 2022 01:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiJJXue (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Oct 2022 19:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJJXue (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Oct 2022 19:50:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD54279EE6
        for <linux-nfs@vger.kernel.org>; Mon, 10 Oct 2022 16:50:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 522B91FA61;
        Mon, 10 Oct 2022 23:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1665445831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DwEx1QLZmfU8bG2PnQ5HNc1VZPLD2fr3xA21XYo3kGA=;
        b=o0JjbT8cYLcE004bGFjcnxyggibs+aoURCVkjI699BVR3ovJPy4PytuseZeAsYo7N7fGgQ
        b3QNU5TY+XCyqnBfgU0M8L1HTa5J4n0ZXeeRJN14LnXh3Rubg2dWnEHUrGjF4ORd9in0hb
        oSJPZtAl3xbcnPSixq7XG3onDFD13rw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1665445831;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DwEx1QLZmfU8bG2PnQ5HNc1VZPLD2fr3xA21XYo3kGA=;
        b=lnpzIMt9lZiFcbJ4QeLAEXEIIxM7vJypgM1Xax07h+cjyCYuZ3zEaLK0q9HUGciwroD+FM
        kba7Lz/btvSWqQBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 778C113479;
        Mon, 10 Oct 2022 23:50:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 41XHDMavRGM1agAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 10 Oct 2022 23:50:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 5/9] NFSD: Add an NFSD_FILE_GC flag to enable nfsd_file
 garbage collection
In-reply-to: <166507323630.1802.8998394314935628609.stgit@manet.1015granger.net>
References: <166507275951.1802.13184584115155050247.stgit@manet.1015granger.net>,
 <166507323630.1802.8998394314935628609.stgit@manet.1015granger.net>
Date:   Tue, 11 Oct 2022 10:50:23 +1100
Message-id: <166544582340.14457.4208476936769397056@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 07 Oct 2022, Chuck Lever wrote:
> NFSv4 operations manage the lifetime of nfsd_file items they use by
> means of NFSv4 OPEN and CLOSE. Hence there's no need for them to be
> garbage collected.
>=20
> Introduce a mechanism to enable garbage collection for nfsd_file
> items used only by NFSv2/3 callers.
>=20
> Note that the change in nfsd_file_put() ensures that both CLOSE and
> DELEGRETURN will actually close out and free an nfsd_file on last
> reference of a non-garbage-collected file.
>=20
> Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D394
> Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/filecache.c |   61 +++++++++++++++++++++++++++++++++++++++++++++--=
----
>  fs/nfsd/filecache.h |    3 +++
>  fs/nfsd/nfs3proc.c  |    4 ++-
>  fs/nfsd/trace.h     |    3 ++-
>  fs/nfsd/vfs.c       |    4 ++-
>  5 files changed, 63 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index b7aa523c2010..01c27deabf83 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -63,6 +63,7 @@ struct nfsd_file_lookup_key {
>  	struct net			*net;
>  	const struct cred		*cred;
>  	unsigned char			need;
> +	unsigned char			gc:1;
>  	enum nfsd_file_lookup_type	type;
>  };
> =20
> @@ -162,6 +163,8 @@ static int nfsd_file_obj_cmpfn(struct rhashtable_compar=
e_arg *arg,
>  			return 1;
>  		if (!nfsd_match_cred(nf->nf_cred, key->cred))
>  			return 1;
> +		if (test_bit(NFSD_FILE_GC, &nf->nf_flags) !=3D key->gc)
> +			return 1;
>  		if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0)
>  			return 1;
>  		break;
> @@ -297,6 +300,8 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, unsig=
ned int may)
>  		nf->nf_flags =3D 0;
>  		__set_bit(NFSD_FILE_HASHED, &nf->nf_flags);
>  		__set_bit(NFSD_FILE_PENDING, &nf->nf_flags);
> +		if (key->gc)
> +			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
>  		nf->nf_inode =3D key->inode;
>  		/* nf_ref is pre-incremented for hash table */
>  		refcount_set(&nf->nf_ref, 2);
> @@ -428,16 +433,27 @@ nfsd_file_put_noref(struct nfsd_file *nf)
>  	}
>  }
> =20
> +static void
> +nfsd_file_unhash_and_put(struct nfsd_file *nf)
> +{
> +	if (nfsd_file_unhash(nf))
> +		nfsd_file_put_noref(nf);
> +}
> +
>  void
>  nfsd_file_put(struct nfsd_file *nf)
>  {
>  	might_sleep();
> =20
> -	nfsd_file_lru_add(nf);
> +	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) =3D=3D 1)
> +		nfsd_file_lru_add(nf);
> +	else if (refcount_read(&nf->nf_ref) =3D=3D 2)
> +		nfsd_file_unhash_and_put(nf);
> +
>  	if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0) {
>  		nfsd_file_flush(nf);
>  		nfsd_file_put_noref(nf);
> -	} else if (nf->nf_file) {
> +	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags) =3D=3D 1)=
 {
>  		nfsd_file_put_noref(nf);
>  		nfsd_file_schedule_laundrette();
>  	} else
> @@ -1017,12 +1033,14 @@ nfsd_file_is_cached(struct inode *inode)
> =20
>  static __be32
>  nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		     unsigned int may_flags, struct nfsd_file **pnf, bool open)
> +		     unsigned int may_flags, struct nfsd_file **pnf,
> +		     bool open, int want_gc)
>  {
>  	struct nfsd_file_lookup_key key =3D {
>  		.type	=3D NFSD_FILE_KEY_FULL,
>  		.need	=3D may_flags & NFSD_FILE_MAY_MASK,
>  		.net	=3D SVC_NET(rqstp),
> +		.gc	=3D want_gc,
>  	};
>  	bool open_retry =3D true;
>  	struct nfsd_file *nf;
> @@ -1117,14 +1135,35 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
>  	 * then unhash.
>  	 */
>  	if (status !=3D nfs_ok || key.inode->i_nlink =3D=3D 0)
> -		if (nfsd_file_unhash(nf))
> -			nfsd_file_put_noref(nf);
> +		nfsd_file_unhash_and_put(nf);
>  	clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
>  	smp_mb__after_atomic();
>  	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
>  	goto out;
>  }
> =20
> +/**
> + * nfsd_file_acquire_gc - Get a struct nfsd_file with an open file
> + * @rqstp: the RPC transaction being executed
> + * @fhp: the NFS filehandle of the file to be opened
> + * @may_flags: NFSD_MAY_ settings for the file
> + * @pnf: OUT: new or found "struct nfsd_file" object
> + *
> + * The nfsd_file object returned by this API is reference-counted
> + * and garbage-collected. The object is retained for a few
> + * seconds after the final nfsd_file_put() in case the caller
> + * wants to re-use it.
> + *
> + * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
> + * network byte order is returned.
> + */
> +__be32
> +nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +		     unsigned int may_flags, struct nfsd_file **pnf)
> +{
> +	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, 1);
> +}
> +
>  /**
>   * nfsd_file_acquire - Get a struct nfsd_file with an open file
>   * @rqstp: the RPC transaction being executed
> @@ -1132,6 +1171,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
>   * @may_flags: NFSD_MAY_ settings for the file
>   * @pnf: OUT: new or found "struct nfsd_file" object
>   *
> + * The nfsd_file_object returned by this API is reference-counted
> + * but not garbage-collected. The object is released one RCU grace
> + * period after the final nfsd_file_put().
> + *
>   * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
>   * network byte order is returned.
>   */
> @@ -1139,7 +1182,7 @@ __be32
>  nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		  unsigned int may_flags, struct nfsd_file **pnf)
>  {
> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true);
> +	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, 0);
>  }
> =20
>  /**
> @@ -1149,6 +1192,10 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
>   * @may_flags: NFSD_MAY_ settings for the file
>   * @pnf: OUT: new or found "struct nfsd_file" object
>   *
> + * The nfsd_file_object returned by this API is reference-counted
> + * but not garbage-collected. The object is released immediately
> + * one RCU grace period after the final nfsd_file_put().

While that last sentence is correct, I think it is missing the point.
The reference to grace periods is really an internal implementation
details.

The important point is that on final nfsd_file_put(), the object is
removed from the hash table.  This contrasts with the other version
where on final nfsd_file_put(), the object is added to the lru.

The code all seems good, just the comment seemed odd.

Thanks,
NeilBrown


> + *
>   * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
>   * network byte order is returned.
>   */
> @@ -1156,7 +1203,7 @@ __be32
>  nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		 unsigned int may_flags, struct nfsd_file **pnf)
>  {
> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, false);
> +	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, false, 0);
>  }
> =20
>  /*
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index f81c198f4ed6..0f6546bcd3e0 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -38,6 +38,7 @@ struct nfsd_file {
>  #define NFSD_FILE_HASHED	(0)
>  #define NFSD_FILE_PENDING	(1)
>  #define NFSD_FILE_REFERENCED	(2)
> +#define NFSD_FILE_GC		(3)
>  	unsigned long		nf_flags;
>  	struct inode		*nf_inode;	/* don't deref */
>  	refcount_t		nf_ref;
> @@ -55,6 +56,8 @@ void nfsd_file_put(struct nfsd_file *nf);
>  struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
>  void nfsd_file_close_inode_sync(struct inode *inode);
>  bool nfsd_file_is_cached(struct inode *inode);
> +__be32 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +		  unsigned int may_flags, struct nfsd_file **nfp);
>  __be32 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		  unsigned int may_flags, struct nfsd_file **nfp);
>  __be32 nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index d12823371857..6a5ad6c91d8e 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -779,8 +779,8 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
>  				(unsigned long long) argp->offset);
> =20
>  	fh_copy(&resp->fh, &argp->fh);
> -	resp->status =3D nfsd_file_acquire(rqstp, &resp->fh, NFSD_MAY_WRITE |
> -					 NFSD_MAY_NOT_BREAK_LEASE, &nf);
> +	resp->status =3D nfsd_file_acquire_gc(rqstp, &resp->fh, NFSD_MAY_WRITE |
> +					    NFSD_MAY_NOT_BREAK_LEASE, &nf);
>  	if (resp->status)
>  		goto out;
>  	resp->status =3D nfsd_commit(rqstp, &resp->fh, nf, argp->offset,
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 9ebd67d461f9..4921144880d3 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -742,7 +742,8 @@ DEFINE_CLID_EVENT(confirmed_r);
>  	__print_flags(val, "|",						\
>  		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\
>  		{ 1 << NFSD_FILE_PENDING,	"PENDING" },		\
> -		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED"})
> +		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED"},		\
> +		{ 1 << NFSD_FILE_GC,		"GC"})
> =20
>  DECLARE_EVENT_CLASS(nfsd_file_class,
>  	TP_PROTO(struct nfsd_file *nf),
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 44f210ba17cc..89d682a56fc4 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1060,7 +1060,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_f=
h *fhp,
>  	__be32 err;
> =20
>  	trace_nfsd_read_start(rqstp, fhp, offset, *count);
> -	err =3D nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
> +	err =3D nfsd_file_acquire_gc(rqstp, fhp, NFSD_MAY_READ, &nf);
>  	if (err)
>  		return err;
> =20
> @@ -1092,7 +1092,7 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp=
, loff_t offset,
> =20
>  	trace_nfsd_write_start(rqstp, fhp, offset, *cnt);
> =20
> -	err =3D nfsd_file_acquire(rqstp, fhp, NFSD_MAY_WRITE, &nf);
> +	err =3D nfsd_file_acquire_gc(rqstp, fhp, NFSD_MAY_WRITE, &nf);
>  	if (err)
>  		goto out;
> =20
>=20
>=20
>=20
