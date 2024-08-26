Return-Path: <linux-nfs+bounces-5761-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D180895F449
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 16:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88CC0282B80
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 14:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B11A1553A3;
	Mon, 26 Aug 2024 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjGQ4Zg8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228BA3CF5E;
	Mon, 26 Aug 2024 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683669; cv=none; b=M3a614vaKnRYUekqGow7YglVLS7odQcxqwsZgWCJZrhL//D8pBHI95bJkyjXIP9WOChWqzudnBhgJawyaDEM91xtpGWb9dWnakrAvr5CZj+RTp+0dXjzRAkVX7aH9x2z0luw08OCPPSqhQHa+XpCD9rsvA9eRYKGlB/ZFAfP6f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683669; c=relaxed/simple;
	bh=ULOjgHOPkS0IzetTExPjZJ18oyAZmnOeN73ZCYL7UIY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GHowVNvD7CE0eGWRPU06Ev/dWrLYjgG2rP/c2PcnkhG0I3UqwkT3pW8qvD5u3nBhoqexaqJR0h+FOs9uVaPyN+u5hXtS+irjurkqsFwhVxLPdEtYe+zYpKA7mP8CI75jkJnZI+qAUmu6cozRsPf6qTsLldgMe6JwfvQc4DoMJO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjGQ4Zg8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D3AC52FC0;
	Mon, 26 Aug 2024 14:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724683668;
	bh=ULOjgHOPkS0IzetTExPjZJ18oyAZmnOeN73ZCYL7UIY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NjGQ4Zg8c61KVff0irp6Yolkynez2OjGIijXmdvVv4p7my9W4omFgTZI/1vVw6kiS
	 OIrC81m+aDQlqkT+01WF5UMOrC78rn89BlYjdqfrrzipdonwuYiADlkaahD4kY5SpH
	 5FP5Zf6nd66dd38tdmOxv8CZ+vB1FEVDoSJEEXA9D9+K1cxtjcAAkiC8pIEluGa+J6
	 9XmVdqulzZ6qY2+bUitqqqyU5Tu8m0JkPIony/c1P4E0WjlISy4oaChxwCytBtSDWU
	 R5BqUaz7o3jClH3fRaO0PSDz36dbGNiravKoCVWlYtgF1QT4azmv8rJedT7kIbe9t3
	 nEsqz7NwRYfZQ==
Message-ID: <bd1beb5d5d6862827336aa25a09c2ae16597cc47.camel@kernel.org>
Subject: Re: [PATCH 0/2] nfsd: CB_GETATTR fixes
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>, "linux-nfs@vger.kernel.org"
 <linux-nfs@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Mon, 26 Aug 2024 10:47:46 -0400
In-Reply-To: <227e2d809951caa485e8ea03978afea515e89464.camel@kernel.org>
References: <20240823-nfsd-fixes-v1-0-fc99aa16f6a0@kernel.org>
	 , <Zsoe/D24xvLfKClT@tissot.1015granger.net>
	 <172462816214.6062.16988455872478253419@noble.neil.brown.name>
	 <227e2d809951caa485e8ea03978afea515e89464.camel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-08-26 at 10:37 -0400, Jeff Layton wrote:
> On Mon, 2024-08-26 at 09:22 +1000, NeilBrown wrote:
> > On Sun, 25 Aug 2024, Chuck Lever wrote:
> > > On Fri, Aug 23, 2024 at 06:27:37PM -0400, Jeff Layton wrote:
> > > > Fixes for a couple of CB_GETATTR bugs I found while working on the
> > > > delstid set. Mostly this just ensures that we hold references to th=
e
> > > > delegation while working with it.
> > > >=20
> > > >=20
> > >=20
> > > Applied to nfsd-fixes for v6.11-rc, thanks!
> > >=20
> > > [1/2] nfsd: hold reference to delegation when updating it for cb_geta=
ttr
> > >       commit: 8fceb5f6636bbbf803fe29fff59f138206559964
> > > [2/2] nfsd: fix potential UAF in nfsd4_cb_getattr_release
> > >       commit: 8bc97f9b84c8852fcc56be2382f5115c518de785
> > >=20
> > > --=20
> > > Chuck Lever
> > >=20
> >=20
> > Maybe the following can tidy up that code.  I can split this into
> > a few separate patches if you like.
> > Thoughts?
> >=20
> > Note that the patch is easier to review if you apply it then use "git
> > diff -b".
> >=20
> > NeilBrown
> >=20
> >=20
> > From: NeilBrown <neilb@suse.de>
> > Subject: [PATCH] nfsd: untangle code in nfsd4_deleg_getattr_conflict()
> >=20
> > The code in nfsd4_deleg_getattr_conflict() is convoluted and buggy.
> >=20
> > With this patch we:
> >  - properly handle non-nfsd leases.  We must not assume flc_owner is a
> >     delegation unless fl_lmops =3D=3D &nfsd_lease_mng_ops
>=20
> AFAICT, non-nfsd leases are already properly handled (though I do agree
> that the "flow" of this code is awkward). What case do you see that's
> wrong?
>=20

Doh! Nevermind -- I see it now. It looks like the break_lease tag is
just in the wrong place. We should definitely fix that.

In any case, your patch looks reasonable to me, but I couldn't get it
to apply. Care to send a real PATCH instead? It's fine if you want to
drop my patch and just replace it with yours.

> >  - move the main code out of the for loop
> >  - have a single exit which calls nfs4_put_stid()
> >    (and other exits which don't need to call that)
> >=20
> > Fixes: c5967721e106 ("NFSD: handle GETATTR conflict with write delegati=
on")
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/nfs4state.c | 130 ++++++++++++++++++++++----------------------
> >  1 file changed, 65 insertions(+), 65 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 2c4b9a22b2bb..7672fa7a70f3 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -8837,6 +8837,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqs=
tp, struct dentry *dentry,
> >  	struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
> >  	struct inode *inode =3D d_inode(dentry);
> >  	struct file_lock_context *ctx;
> > +	struct nfs4_delegation *dp =3D NULL;
> >  	struct nfs4_cb_fattr *ncf;
> >  	struct file_lease *fl;
> >  	struct iattr attrs;
> > @@ -8845,77 +8846,76 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *r=
qstp, struct dentry *dentry,
> >  	ctx =3D locks_inode_context(inode);
> >  	if (!ctx)
> >  		return 0;
> > +
> > +#define NON_NFSD_LEASE ((void*)1)
> > +
> >  	spin_lock(&ctx->flc_lock);
> >  	for_each_file_lock(fl, &ctx->flc_lease) {
> > -		unsigned char type =3D fl->c.flc_type;
> > -
> >  		if (fl->c.flc_flags =3D=3D FL_LAYOUT)
> >  			continue;
> > -		if (fl->fl_lmops !=3D &nfsd_lease_mng_ops) {
> > -			/*
> > -			 * non-nfs lease, if it's a lease with F_RDLCK then
> > -			 * we are done; there isn't any write delegation
> > -			 * on this inode
> > -			 */
> > -			if (type =3D=3D F_RDLCK)
> > -				break;
> > -			goto break_lease;
> > -		}
> > -		if (type =3D=3D F_WRLCK) {
> > -			struct nfs4_delegation *dp =3D fl->c.flc_owner;
> > -
> > -			if (dp->dl_recall.cb_clp =3D=3D *(rqstp->rq_lease_breaker)) {
> > -				spin_unlock(&ctx->flc_lock);
> > -				return 0;
> > -			}
> > -break_lease:
> > -			nfsd_stats_wdeleg_getattr_inc(nn);
> > -			dp =3D fl->c.flc_owner;
> > -			refcount_inc(&dp->dl_stid.sc_count);
> > -			ncf =3D &dp->dl_cb_fattr;
> > -			nfs4_cb_getattr(&dp->dl_cb_fattr);
> > -			spin_unlock(&ctx->flc_lock);
> > -			wait_on_bit_timeout(&ncf->ncf_cb_flags, CB_GETATTR_BUSY,
> > -					TASK_INTERRUPTIBLE, NFSD_CB_GETATTR_TIMEOUT);
> > -			if (ncf->ncf_cb_status) {
> > -				/* Recall delegation only if client didn't respond */
> > -				status =3D nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
> > -				if (status !=3D nfserr_jukebox ||
> > -						!nfsd_wait_for_delegreturn(rqstp, inode)) {
> > -					nfs4_put_stid(&dp->dl_stid);
> > -					return status;
> > -				}
> > -			}
> > -			if (!ncf->ncf_file_modified &&
> > -					(ncf->ncf_initial_cinfo !=3D ncf->ncf_cb_change ||
> > -					ncf->ncf_cur_fsize !=3D ncf->ncf_cb_fsize))
> > -				ncf->ncf_file_modified =3D true;
> > -			if (ncf->ncf_file_modified) {
> > -				int err;
> > -
> > -				/*
> > -				 * Per section 10.4.3 of RFC 8881, the server would
> > -				 * not update the file's metadata with the client's
> > -				 * modified size
> > -				 */
> > -				attrs.ia_mtime =3D attrs.ia_ctime =3D current_time(inode);
> > -				attrs.ia_valid =3D ATTR_MTIME | ATTR_CTIME | ATTR_DELEG;
> > -				inode_lock(inode);
> > -				err =3D notify_change(&nop_mnt_idmap, dentry, &attrs, NULL);
> > -				inode_unlock(inode);
> > -				if (err) {
> > -					nfs4_put_stid(&dp->dl_stid);
> > -					return nfserrno(err);
> > -				}
> > -				ncf->ncf_cur_fsize =3D ncf->ncf_cb_fsize;
> > -				*size =3D ncf->ncf_cur_fsize;
> > -				*modified =3D true;
> > -			}
> > -			nfs4_put_stid(&dp->dl_stid);
> > -			return 0;
> > +		if (fl->c.flc_type =3D=3D F_WRLCK) {
> > +			if (fl->fl_lmops =3D=3D &nfsd_lease_mng_ops)
> > +				dp =3D fl->c.flc_owner;
> > +			else
> > +				dp =3D NON_NFSD_LEASE;
> >  		}
> >  		break;
> >  	}
> > +	if (dp =3D=3D NULL || dp =3D=3D NON_NFSD_LEASE ||
> > +	    dp->dl_recall.cb_clp =3D=3D *(rqstp->rq_lease_breaker)) {
> > +		spin_unlock(&ctx->flc_lock);
> > +		if (dp =3D=3D NON_NFSD_LEASE) {
> > +			status =3D nfserrno(nfsd_open_break_lease(inode,
> > +								NFSD_MAY_READ));
> > +			if (status !=3D nfserr_jukebox ||
> > +			    !nfsd_wait_for_delegreturn(rqstp, inode))
> > +				return status;
> > +		}
> > +		return 0;
> > +	}
> > +
> > +	nfsd_stats_wdeleg_getattr_inc(nn);
> > +	refcount_inc(&dp->dl_stid.sc_count);
> > +	ncf =3D &dp->dl_cb_fattr;
> > +	nfs4_cb_getattr(&dp->dl_cb_fattr);
> >  	spin_unlock(&ctx->flc_lock);
> > -	return 0;
> > +
> > +	wait_on_bit_timeout(&ncf->ncf_cb_flags, CB_GETATTR_BUSY,
> > +			    TASK_INTERRUPTIBLE, NFSD_CB_GETATTR_TIMEOUT);
> > +	if (ncf->ncf_cb_status) {
> > +		/* Recall delegation only if client didn't respond */
> > +		status =3D nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
> > +		if (status !=3D nfserr_jukebox ||
> > +		    !nfsd_wait_for_delegreturn(rqstp, inode))
> > +			goto out_status;
> > +	}
> > +	if (!ncf->ncf_file_modified &&
> > +	    (ncf->ncf_initial_cinfo !=3D ncf->ncf_cb_change ||
> > +	     ncf->ncf_cur_fsize !=3D ncf->ncf_cb_fsize))
> > +		ncf->ncf_file_modified =3D true;
> > +	if (ncf->ncf_file_modified) {
> > +		int err;
> > +
> > +		/*
> > +		 * Per section 10.4.3 of RFC 8881, the server would
> > +		 * not update the file's metadata with the client's
> > +		 * modified size
> > +		 */
> > +		attrs.ia_mtime =3D attrs.ia_ctime =3D current_time(inode);
> > +		attrs.ia_valid =3D ATTR_MTIME | ATTR_CTIME | ATTR_DELEG;
> > +		inode_lock(inode);
> > +		err =3D notify_change(&nop_mnt_idmap, dentry, &attrs, NULL);
> > +		inode_unlock(inode);
> > +		if (err) {
> > +			status =3D nfserrno(err);
> > +			goto out_status;
> > +		}
> > +		ncf->ncf_cur_fsize =3D ncf->ncf_cb_fsize;
> > +		*size =3D ncf->ncf_cur_fsize;
> > +		*modified =3D true;
> > +	}
> > +	status =3D 0;
> > +out_status:
> > +	nfs4_put_stid(&dp->dl_stid);
> > +	return status;
> >  }
>=20
> Patch looks like a nice cleanup, but I don't think the Fixes tag is
> appropriate here.

--=20
Jeff Layton <jlayton@kernel.org>

