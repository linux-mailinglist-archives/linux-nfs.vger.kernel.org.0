Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A8E613BD6
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 18:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiJaRAy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 13:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiJaRAx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 13:00:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507CE12D15
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 10:00:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB1BAB81978
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 17:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C69EC433D6;
        Mon, 31 Oct 2022 17:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667235649;
        bh=1S72wGqPBjyDLiv1fPYVRtAFCJ+WbE+TyJ6Q/EWDK4k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pFmbeNu0F13pbWpE1XNFXxN1e3e01dlCmOeSEWjfxV9XwraTkQPLQliU5MJHqnMww
         Pz1jHL7DpBnV/dNNgOiFx8iFChibfTsiDoPsJPDig2R3EbL9E3Qt/gN0oHL4KVgy/X
         1yjKcTy089fFn1GBRJiMW3h/M5fjpxynSiHzKJeYVooN7sNHSQNpoHIxBJB65bTlIo
         ocB2Cy65mn9g5xmcAIkBaUG6QiKB0v7f9KowrtD7zQBZDcgrL5XbXs4kfz0SMinvEk
         BLyV5LR9ns3eAmHsLieRkogaOr8aiHxHkyofE2lCeFQyrs70tzp5QSthGEs3S4trmR
         9MJh1P6y1/YUQ==
Message-ID: <2c777fa8ae5f3486813454bb07ef9dc7888bc0db.camel@kernel.org>
Subject: Re: [PATCH v7 14/14] NFSD: Use rhashtable for managing nfs4_file
 objects
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Date:   Mon, 31 Oct 2022 13:00:47 -0400
In-Reply-To: <6a23885c7fd868c4d5561c96fcb9b81052298b80.camel@redhat.com>
References: <166696812922.106044.679812521105874329.stgit@klimt.1015granger.net>
         <166696848023.106044.12150149492678240864.stgit@klimt.1015granger.net>
         <6a23885c7fd868c4d5561c96fcb9b81052298b80.camel@redhat.com>
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

On Mon, 2022-10-31 at 12:54 -0400, Jeff Layton wrote:
> On Fri, 2022-10-28 at 10:48 -0400, Chuck Lever wrote:
> > fh_match() is costly, especially when filehandles are large (as is
> > the case for NFSv4). It needs to be used sparingly when searching
> > data structures. Unfortunately, with common workloads, I see
> > multiple thousands of objects stored in file_hashtbl[], which has
> > just 256 buckets, making its bucket hash chains quite lengthy.
> >=20
> > Walking long hash chains with the state_lock held blocks other
> > activity that needs that lock. Sizable hash chains are a common
> > occurrance once the server has handed out some delegations, for
> > example -- IIUC, each delegated file is held open on the server by
> > an nfs4_file object.
> >=20
> > To help mitigate the cost of searching with fh_match(), replace the
> > nfs4_file hash table with an rhashtable, which can dynamically
> > resize its bucket array to minimize hash chain length.
> >=20
> > The result of this modification is an improvement in the latency of
> > NFSv4 operations, and the reduction of nfsd CPU utilization due to
> > eliminating the cost of multiple calls to fh_match() and reducing
> > the CPU cache misses incurred while walking long hash chains in the
> > nfs4_file hash table.
> >=20
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > Reviewed-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/nfs4state.c |   77 ++++++++++++++++++++++++++-----------------=
--------
> >  fs/nfsd/state.h     |    4 ---
> >  2 files changed, 40 insertions(+), 41 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index c2ef2db9c84c..c78b66e678dd 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -591,11 +591,8 @@ static void nfsd4_free_file_rcu(struct rcu_head *r=
cu)
> >  void
> >  put_nfs4_file(struct nfs4_file *fi)
> >  {
> > -	might_lock(&state_lock);
> > -
> > -	if (refcount_dec_and_lock(&fi->fi_ref, &state_lock)) {
> > +	if (refcount_dec_and_test(&fi->fi_ref)) {
> >  		nfsd4_file_hash_remove(fi);
> > -		spin_unlock(&state_lock);
> >  		WARN_ON_ONCE(!list_empty(&fi->fi_clnt_odstate));
> >  		WARN_ON_ONCE(!list_empty(&fi->fi_delegations));
> >  		call_rcu(&fi->fi_rcu, nfsd4_free_file_rcu);
> > @@ -709,20 +706,6 @@ static unsigned int ownerstr_hashval(struct xdr_ne=
tobj *ownername)
> >  	return ret & OWNER_HASH_MASK;
> >  }
> > =20
> > -/* hash table for nfs4_file */
> > -#define FILE_HASH_BITS                   8
> > -#define FILE_HASH_SIZE                  (1 << FILE_HASH_BITS)
> > -
> > -static unsigned int file_hashval(const struct svc_fh *fh)
> > -{
> > -	struct inode *inode =3D d_inode(fh->fh_dentry);
> > -
> > -	/* XXX: why not (here & in file cache) use inode? */
> > -	return (unsigned int)hash_long(inode->i_ino, FILE_HASH_BITS);
> > -}
> > -
> > -static struct hlist_head file_hashtbl[FILE_HASH_SIZE];
> > -
> >  static struct rhltable nfs4_file_rhltable ____cacheline_aligned_in_smp=
;
> > =20
> >  static const struct rhashtable_params nfs4_file_rhash_params =3D {
> > @@ -4687,12 +4670,14 @@ move_to_close_lru(struct nfs4_ol_stateid *s, st=
ruct net *net)
> >  static noinline_for_stack struct nfs4_file *
> >  nfsd4_file_hash_lookup(const struct svc_fh *fhp)
> >  {
> > -	unsigned int hashval =3D file_hashval(fhp);
> > +	struct inode *inode =3D d_inode(fhp->fh_dentry);
> > +	struct rhlist_head *tmp, *list;
> >  	struct nfs4_file *fi;
> > =20
> >  	rcu_read_lock();
> > -	hlist_for_each_entry_rcu(fi, &file_hashtbl[hashval], fi_hash,
> > -				 lockdep_is_held(&state_lock)) {
> > +	list =3D rhltable_lookup(&nfs4_file_rhltable, &inode,
> > +			       nfs4_file_rhash_params);
> > +	rhl_for_each_entry_rcu(fi, tmp, list, fi_rlist) {
> >  		if (fh_match(&fi->fi_fhandle, &fhp->fh_handle)) {
> >  			if (refcount_inc_not_zero(&fi->fi_ref)) {
> >  				rcu_read_unlock();
> > @@ -4706,40 +4691,56 @@ nfsd4_file_hash_lookup(const struct svc_fh *fhp=
)
> > =20
> >  /*
> >   * On hash insertion, identify entries with the same inode but
> > - * distinct filehandles. They will all be in the same hash bucket
> > - * because nfs4_file's are hashed by the address in the fi_inode
> > - * field.
> > + * distinct filehandles. They will all be on the list returned
> > + * by rhltable_lookup().
> > + *
> > + * inode->i_lock prevents racing insertions from adding an entry
> > + * for the same inode/fhp pair twice.
> >   */
> >  static noinline_for_stack struct nfs4_file *
> >  nfsd4_file_hash_insert(struct nfs4_file *new, const struct svc_fh *fhp=
)
> >  {
> > -	unsigned int hashval =3D file_hashval(fhp);
> > +	struct inode *inode =3D d_inode(fhp->fh_dentry);
> > +	struct rhlist_head *tmp, *list;
> >  	struct nfs4_file *ret =3D NULL;
> >  	bool alias_found =3D false;
> >  	struct nfs4_file *fi;
> > +	int err;
> > =20
> > -	spin_lock(&state_lock);
> > -	hlist_for_each_entry_rcu(fi, &file_hashtbl[hashval], fi_hash,
> > -				 lockdep_is_held(&state_lock)) {
> > +	rcu_read_lock();
> > +	spin_lock(&inode->i_lock);
> > +
> > +	list =3D rhltable_lookup(&nfs4_file_rhltable, &inode,
> > +			       nfs4_file_rhash_params);
> > +	rhl_for_each_entry_rcu(fi, tmp, list, fi_rlist) {
> >  		if (fh_match(&fi->fi_fhandle, &fhp->fh_handle)) {
> >  			if (refcount_inc_not_zero(&fi->fi_ref))
> >  				ret =3D fi;
> > -		} else if (d_inode(fhp->fh_dentry) =3D=3D fi->fi_inode)
> > +		} else
> >  			fi->fi_aliased =3D alias_found =3D true;
> >  	}
> > -	if (likely(ret =3D=3D NULL)) {
> > -		nfsd4_file_init(fhp, new);
> > -		hlist_add_head_rcu(&new->fi_hash, &file_hashtbl[hashval]);
> > -		new->fi_aliased =3D alias_found;
> > -		ret =3D new;
> > -	}
> > -	spin_unlock(&state_lock);
> > +	if (ret)
> > +		goto out_unlock;
> > +
> > +	nfsd4_file_init(fhp, new);
> > +	err =3D rhltable_insert(&nfs4_file_rhltable, &new->fi_rlist,
> > +			      nfs4_file_rhash_params);
> > +	if (err)
> > +		goto out_unlock;
> > +
> > +	new->fi_aliased =3D alias_found;
> > +	ret =3D new;
> > +
> > +out_unlock:
> > +	spin_unlock(&inode->i_lock);
> > +	rcu_read_unlock();
> >  	return ret;
> >  }
> > =20
> >  static noinline_for_stack void nfsd4_file_hash_remove(struct nfs4_file=
 *fi)
> >  {
> > -	hlist_del_rcu(&fi->fi_hash);
> > +	rhltable_remove(&nfs4_file_rhltable, &fi->fi_rlist,
> > +			nfs4_file_rhash_params);
> >  }
> > =20
> >  /*
> > @@ -5629,6 +5630,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struc=
t svc_fh *current_fh, struct nf
> >  	 * If not found, create the nfs4_file struct
> >  	 */
> >  	fp =3D nfsd4_file_hash_insert(open->op_file, current_fh);
> > +	if (unlikely(!fp))
> > +		return nfserr_jukebox;
> >  	if (fp !=3D open->op_file) {
> >  		status =3D nfs4_check_deleg(cl, open, &dp);
> >  		if (status)
> > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > index 190fc7e418a4..eadd7f465bf5 100644
> > --- a/fs/nfsd/state.h
> > +++ b/fs/nfsd/state.h
> > @@ -536,16 +536,12 @@ struct nfs4_clnt_odstate {
> >   * inode can have multiple filehandles associated with it, so there is
> >   * (potentially) a many to one relationship between this struct and st=
ruct
> >   * inode.
> > - *
> > - * These are hashed by filehandle in the file_hashtbl, which is protec=
ted by
> > - * the global state_lock spinlock.
> >   */
> >  struct nfs4_file {
> >  	refcount_t		fi_ref;
> >  	struct inode *		fi_inode;
> >  	bool			fi_aliased;
> >  	spinlock_t		fi_lock;
> > -	struct hlist_node       fi_hash;	/* hash on fi_fhandle */
> >  	struct rhlist_head	fi_rlist;
> >  	struct list_head        fi_stateids;
> >  	union {
> >=20
> >=20
>=20
> You can add this to 13 and 14:
>=20
> Reviewed-by: Jeff Layton <jlayton@redhat.com>
>=20
> That said, I'd probably prefer to see the two squashed together, since
> you're adding unused infrastructure in 13.
>=20

Erm, maybe make that my kernel.org address instead? I try to use that
for upstream work.

--=20
Jeff Layton <jlayton@kernel.org>
