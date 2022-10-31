Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDBC613C39
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 18:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiJaRgo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 13:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJaRgo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 13:36:44 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF53210B6B
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 10:36:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2C305CE170E
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 17:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2969AC433C1;
        Mon, 31 Oct 2022 17:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667237799;
        bh=+XGkv864cFp/bpjz84fZub/WQmemIW8aaYMWvEQq2DQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MbwNdUmaCm6YsATodW013H4PA3c2q2BR7VKplTVF7cen0ZmHd7VMZgB65cr6oR1C9
         NcaErN15hDkoiE5dnTiD7OuUPALfzYv3sttcpGDVSpesPu9impw7hCA80lq4vLeZ5y
         X9Q1rs3NmG4awi/IaejgjhJA/OG4Sxqm28Lcg0R8N9Cf9AISpfj/Ery+ioX/RTAKtr
         GFcY+IAZ1XYNdtT39GYX76yTEbQo3zyPty9TFfx5K6p9WqoN6KelT8jxBxFKrfKEds
         FYw7QY3L+fTN38r8uijSpm261MU1mHi5sZd74ZRQzlMnECG8+sOqVQUA9Mw1H1I1YG
         XdoareUge7NWg==
Message-ID: <fa08f6f6f33a9a18d85af63373f4d1381e3a1872.camel@kernel.org>
Subject: Re: [PATCH v7 11/14] NFSD: Clean up find_or_add_file()
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Date:   Mon, 31 Oct 2022 13:36:37 -0400
In-Reply-To: <D051BD59-3962-4A0D-B099-F50F50616BAD@oracle.com>
References: <166696812922.106044.679812521105874329.stgit@klimt.1015granger.net>
         <166696846122.106044.14636201700548704756.stgit@klimt.1015granger.net>
         <d9bd2d0f17c53ce864e093324ad6ccc9de1871c5.camel@kernel.org>
         <D051BD59-3962-4A0D-B099-F50F50616BAD@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-10-31 at 17:28 +0000, Chuck Lever III wrote:
>=20
> > On Oct 31, 2022, at 12:43 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Fri, 2022-10-28 at 10:47 -0400, Chuck Lever wrote:
> > > Remove the call to find_file_locked() in insert_nfs4_file(). Tracing
> > > shows that over 99% of these calls return NULL. Thus it is not worth
> > > the expense of the extra bucket list traversal. insert_file() already
> > > deals correctly with the case where the item is already in the hash
> > > bucket.
> > >=20
> > > Since nfsd4_file_hash_insert() is now just a wrapper around
> > > insert_file(), move the meat of insert_file() into
> > > nfsd4_file_hash_insert() and get rid of it.
> > >=20
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > Reviewed-by: NeilBrown <neilb@suse.de>
> > > ---
> > > fs/nfsd/nfs4state.c |   64 ++++++++++++++++++++++--------------------=
---------
> > > 1 file changed, 28 insertions(+), 36 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index 504455cb80e9..b1988a46fb9b 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -4683,24 +4683,42 @@ find_file_locked(const struct svc_fh *fh, uns=
igned int hashval)
> > > 	return NULL;
> > > }
> > >=20
> > > -static struct nfs4_file *insert_file(struct nfs4_file *new, struct s=
vc_fh *fh,
> > > -				     unsigned int hashval)
> > > +static struct nfs4_file * find_file(struct svc_fh *fh)
> > > {
> > > 	struct nfs4_file *fp;
> > > +	unsigned int hashval =3D file_hashval(fh);
> > > +
> > > +	rcu_read_lock();
> > > +	fp =3D find_file_locked(fh, hashval);
> > > +	rcu_read_unlock();
> > > +	return fp;
> > > +}
> > > +
> > > +/*
> > > + * On hash insertion, identify entries with the same inode but
> > > + * distinct filehandles. They will all be in the same hash bucket
> > > + * because nfs4_file's are hashed by the address in the fi_inode
> > > + * field.
> > > + */
> > > +static noinline_for_stack struct nfs4_file *
> > > +nfsd4_file_hash_insert(struct nfs4_file *new, const struct svc_fh *f=
hp)
> > > +{
> > > +	unsigned int hashval =3D file_hashval(fhp);
> > > 	struct nfs4_file *ret =3D NULL;
> > > 	bool alias_found =3D false;
> > > +	struct nfs4_file *fi;
> > >=20
> > > 	spin_lock(&state_lock);
> > > -	hlist_for_each_entry_rcu(fp, &file_hashtbl[hashval], fi_hash,
> > > +	hlist_for_each_entry_rcu(fi, &file_hashtbl[hashval], fi_hash,
> > > 				 lockdep_is_held(&state_lock)) {
> > > -		if (fh_match(&fp->fi_fhandle, &fh->fh_handle)) {
> > > -			if (refcount_inc_not_zero(&fp->fi_ref))
> > > -				ret =3D fp;
> > > -		} else if (d_inode(fh->fh_dentry) =3D=3D fp->fi_inode)
> > > -			fp->fi_aliased =3D alias_found =3D true;
> > > +		if (fh_match(&fi->fi_fhandle, &fhp->fh_handle)) {
> > > +			if (refcount_inc_not_zero(&fi->fi_ref))
> > > +				ret =3D fi;
> > > +		} else if (d_inode(fhp->fh_dentry) =3D=3D fi->fi_inode)
> > > +			fi->fi_aliased =3D alias_found =3D true;
> >=20
> > Would it not be better to do the inode comparison first? That's just a
> > pointer check vs. a full memcmp. That would allow you to quickly rule
> > out any entries that match different inodes but that are on the same
> > hash chain.
>=20
> Marginally better: The usual case after the rhltable changes are
> applied is that the returned list contains only entries that match
> d_inode(fhp->fh_dentry), and usually that list has just one entry
> in it that matches the FH.
>=20

That depends entirely on workload. Given that you start with 512
buckets, you'd need to be working with at least that many inodes
concurrently to make that happen, but it could easily happen with a
large enough working set.

> Since 11/14 is billed as a clean-up, I'd prefer to put that kind
> of optimization in a separate patch that can be mechanically
> reverted if need be. I'll post something that goes on top of this
> series.
>=20

Fair enough. You can add my Reviewed-by: and we can address it later.

>=20
> > > 	}
> > > 	if (likely(ret =3D=3D NULL)) {
> > > -		nfsd4_file_init(fh, new);
> > > +		nfsd4_file_init(fhp, new);
> > > 		hlist_add_head_rcu(&new->fi_hash, &file_hashtbl[hashval]);
> > > 		new->fi_aliased =3D alias_found;
> > > 		ret =3D new;
> > > @@ -4709,32 +4727,6 @@ static struct nfs4_file *insert_file(struct nf=
s4_file *new, struct svc_fh *fh,
> > > 	return ret;
> > > }
> > >=20
> > > -static struct nfs4_file * find_file(struct svc_fh *fh)
> > > -{
> > > -	struct nfs4_file *fp;
> > > -	unsigned int hashval =3D file_hashval(fh);
> > > -
> > > -	rcu_read_lock();
> > > -	fp =3D find_file_locked(fh, hashval);
> > > -	rcu_read_unlock();
> > > -	return fp;
> > > -}
> > > -
> > > -static struct nfs4_file *
> > > -find_or_add_file(struct nfs4_file *new, struct svc_fh *fh)
> > > -{
> > > -	struct nfs4_file *fp;
> > > -	unsigned int hashval =3D file_hashval(fh);
> > > -
> > > -	rcu_read_lock();
> > > -	fp =3D find_file_locked(fh, hashval);
> > > -	rcu_read_unlock();
> > > -	if (fp)
> > > -		return fp;
> > > -
> > > -	return insert_file(new, fh, hashval);
> > > -}
> > > -
> > > static noinline_for_stack void nfsd4_file_hash_remove(struct nfs4_fil=
e *fi)
> > > {
> > > 	hlist_del_rcu(&fi->fi_hash);
> > > @@ -5625,7 +5617,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, str=
uct svc_fh *current_fh, struct nf
> > > 	 * and check for delegations in the process of being recalled.
> > > 	 * If not found, create the nfs4_file struct
> > > 	 */
> > > -	fp =3D find_or_add_file(open->op_file, current_fh);
> > > +	fp =3D nfsd4_file_hash_insert(open->op_file, current_fh);
> > > 	if (fp !=3D open->op_file) {
> > > 		status =3D nfs4_check_deleg(cl, open, &dp);
> > > 		if (status)
> > >=20
> > >=20
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
