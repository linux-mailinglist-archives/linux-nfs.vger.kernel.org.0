Return-Path: <linux-nfs+bounces-12555-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CF9ADED01
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 14:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2ED3B9DE7
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 12:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077452E2654;
	Wed, 18 Jun 2025 12:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQ0NfVCD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA032E2640;
	Wed, 18 Jun 2025 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750251022; cv=none; b=TyexsjxpEtHVyd4eOsGfhUMX6nDrvxj/a37Td8fh4k/pWh0OG7F0yQdMhomQf2qbzcTKxNRfbJmsBZGhmJu6GvQ1QE6YgPBfT0S/rjAON0QmtaxZcVdJNyR8Slq4cYTAF6laKdh+d9sKDdYyEcxnG0q+tumafxLZv9T56wG/uww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750251022; c=relaxed/simple;
	bh=RYR/2pZqj5WTEbQ5KPJo0gncf2BgYE0/xusGNgg2BA0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I0fXgC3AUhsrrBiHaYpVjMUFFRhD8hpgjPB7Rtd8wBGAjAISyzGkkCmKl0tTg129cS6Q5wQxzty0aYhTAbtvQa02WPQsIpXPM7+zcYrdndFvWExGAPCzRvkspg0mkwmg4LnECjB9nuu1BDWaf+w88t1i39yyZ/sz2tLKt7xnTHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQ0NfVCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541C8C4CEE7;
	Wed, 18 Jun 2025 12:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750251022;
	bh=RYR/2pZqj5WTEbQ5KPJo0gncf2BgYE0/xusGNgg2BA0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=BQ0NfVCDVnRFQhsGtrFT6kpDonnje10TRf58kL8JxTGk4OYfilvIMyh8ePtVZwznL
	 0VsPBuifWImFMAZhK+thXp8ZKJBUvq6dxjLE8uCcR4fsy/MJgWAoPObm5z0FiGyDeK
	 55wvl6fM9C9ugsoQQC8Fb8N6+Zbez134gL0oh71KzU2mlGMkootkep7cSydmLXLwZO
	 c+nmgbFiWNE+xMQynbcIL23tbZ7x2P1hcEGOt0b8Qnk3xtUR4dbshxM6LhdPtHWsSO
	 TPs5SBJl7QpTXo/XuC+7dsvm38PdrqkkgedmHG8lu0uDFY6CwPTK8y2t8HiQofoH0b
	 5owDWi+p31qmw==
Message-ID: <ad9a5a7dff19f8e45a8808f8f3142ae65f44b4da.camel@kernel.org>
Subject: Re: [PATCH v2] nfsd: Invoke tracking callbacks only after
 initialization is complete
From: Jeff Layton <jlayton@kernel.org>
To: Li Lingfeng <lilingfeng3@huawei.com>, chuck.lever@oracle.com,
 neilb@suse.de, 	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
 linux-nfs@vger.kernel.org, 	linux-kernel@vger.kernel.org
Cc: yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com, 
	yangerkun@huawei.com, lilingfeng@huaweicloud.com
Date: Wed, 18 Jun 2025 08:50:20 -0400
In-Reply-To: <7bf3512276b6d314cbd9d250e16d617d41f3fa61.camel@kernel.org>
References: <20250612035506.3651985-1-lilingfeng3@huawei.com>
	 <7bf3512276b6d314cbd9d250e16d617d41f3fa61.camel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-18 at 08:35 -0400, Jeff Layton wrote:
> On Thu, 2025-06-12 at 11:55 +0800, Li Lingfeng wrote:
> > Checking whether tracking callbacks can be called based on whether
> > nn->client_tracking_ops is NULL may lead to callbacks being invoked
> > before tracking initialization completes, causing resource access
> > violations (UAF, NULL pointer dereference). Examples:
> >=20
> > 1) nfsd4_client_tracking_init
> >    // set nn->client_tracking_ops
> >    nfsd4_cld_tracking_init
> >     nfs4_cld_state_init
> >      nn->reclaim_str_hashtbl =3D kmalloc_array
> >     ... // error path, goto err
> >     nfs4_cld_state_shutdown
> >      kfree(nn->reclaim_str_hashtbl)
> >                                       write_v4_end_grace
> >                                        nfsd4_end_grace
> >                                         nfsd4_record_grace_done
> >                                          nfsd4_cld_grace_done
> >                                           nfs4_release_reclaim
> >                                            nn->reclaim_str_hashtbl[i]
> >                                            // UAF
> >    // clear nn->client_tracking_ops
> >=20
> > 2) nfsd4_client_tracking_init
> >    // set nn->client_tracking_ops
> >    nfsd4_cld_tracking_init
> >                                       write_v4_end_grace
> >                                        nfsd4_end_grace
> >                                         nfsd4_record_grace_done
> >                                          nfsd4_cld_grace_done
> >                                           alloc_cld_upcall
> >                                            cn =3D nn->cld_net
> >                                            spin_lock // cn->cn_lock
> >                                            // NULL deref
> >    // error path, skip init pipe
> >    __nfsd4_init_cld_pipe
> >     cn =3D kzalloc
> >     nn->cld_net =3D cn
> >    // clear nn->client_tracking_ops
> >=20
>=20
>=20
> Have you seen this race in the wild?
>=20
> Looking at this more closely, I don't think this race is possible.
> You'd need to invoke the ->init routine concurrently from two different
> tasks, but nfsd4_client_tracking_init is called during net ns
> initialization, which should ensure that only one task invokes it.
>=20

My bad. It's not called during net namespace initialization, but during
server startup. But, the nfsd_mutex is held during this initialization,
so I still don't think this race can happen.

>=20
>=20
> > After nfsd mounts, users can trigger grace_done callbacks via
> > /proc/fs/nfsd/v4_end_grace. If resources are uninitialized or freed
> > in error paths, this causes access violations.
> >=20
> > Resolve the issue by leveraging nfsd_mutex to prevent concurrency.
> >=20
> > Fixes: 52e19c09a183 ("nfsd: make reclaim_str_hashtbl allocated per net"=
)
> > Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> > ---
> >   Changes in v2:
> >     Use nfsd_mutex instead of adding a new flag to prevent concurrency.
> >  fs/nfsd/nfs4recover.c | 8 ++++++++
> >  fs/nfsd/nfs4state.c   | 4 ++++
> >  fs/nfsd/nfsctl.c      | 2 ++
> >  3 files changed, 14 insertions(+)
> >=20
> > diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> > index 82785db730d9..8ac089f8134c 100644
> > --- a/fs/nfsd/nfs4recover.c
> > +++ b/fs/nfsd/nfs4recover.c
> > @@ -162,7 +162,9 @@ legacy_recdir_name_error(struct nfs4_client *clp, i=
nt error)
> >  	if (error =3D=3D -ENOENT) {
> >  		printk(KERN_ERR "NFSD: disabling legacy clientid tracking. "
> >  			"Reboot recovery will not function correctly!\n");
> > +		mutex_lock(&nfsd_mutex);
> >  		nfsd4_client_tracking_exit(clp->net);
> > +		mutex_unlock(&nfsd_mutex);
> >  	}
> >  }
> > =20
> > @@ -2083,8 +2085,10 @@ nfsd4_client_record_create(struct nfs4_client *c=
lp)
> >  {
> >  	struct nfsd_net *nn =3D net_generic(clp->net, nfsd_net_id);
> > =20
> > +	mutex_lock(&nfsd_mutex);
> >  	if (nn->client_tracking_ops)
> >  		nn->client_tracking_ops->create(clp);
> > +	mutex_unlock(&nfsd_mutex);
> >  }
> > =20
> >  void
> > @@ -2092,8 +2096,10 @@ nfsd4_client_record_remove(struct nfs4_client *c=
lp)
> >  {
> >  	struct nfsd_net *nn =3D net_generic(clp->net, nfsd_net_id);
> > =20
> > +	mutex_lock(&nfsd_mutex);
> >  	if (nn->client_tracking_ops)
> >  		nn->client_tracking_ops->remove(clp);
> > +	mutex_unlock(&nfsd_mutex);
> >  }
> > =20
> >  int
> > @@ -2101,8 +2107,10 @@ nfsd4_client_record_check(struct nfs4_client *cl=
p)
> >  {
> >  	struct nfsd_net *nn =3D net_generic(clp->net, nfsd_net_id);
> > =20
> > +	mutex_lock(&nfsd_mutex);
> >  	if (nn->client_tracking_ops)
> >  		return nn->client_tracking_ops->check(clp);
> > +	mutex_unlock(&nfsd_mutex);
> > =20
> >  	return -EOPNOTSUPP;
> >  }
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index d5694987f86f..2794fdc8b678 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -2529,7 +2529,9 @@ static void inc_reclaim_complete(struct nfs4_clie=
nt *clp)
> >  			nn->reclaim_str_hashtbl_size) {
> >  		printk(KERN_INFO "NFSD: all clients done reclaiming, ending NFSv4 gr=
ace period (net %x)\n",
> >  				clp->net->ns.inum);
> > +		mutex_lock(&nfsd_mutex);
> >  		nfsd4_end_grace(nn);
> > +		mutex_unlock(&nfsd_mutex);
> >  	}
> >  }
> > =20
> > @@ -6773,7 +6775,9 @@ nfs4_laundromat(struct nfsd_net *nn)
> >  		lt.new_timeo =3D 0;
> >  		goto out;
> >  	}
> > +	mutex_lock(&nfsd_mutex);
> >  	nfsd4_end_grace(nn);
> > +	mutex_unlock(&nfsd_mutex);
> > =20
> >  	spin_lock(&nn->s2s_cp_lock);
> >  	idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 3f3e9f6c4250..649850b4bb60 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -1085,7 +1085,9 @@ static ssize_t write_v4_end_grace(struct file *fi=
le, char *buf, size_t size)
> >  			if (!nn->nfsd_serv)
> >  				return -EBUSY;
> >  			trace_nfsd_end_grace(netns(file));
> > +			mutex_lock(&nfsd_mutex);
> >  			nfsd4_end_grace(nn);
> > +			mutex_lock(&nfsd_mutex);
> >  			break;
> >  		default:
> >  			return -EINVAL;

--=20
Jeff Layton <jlayton@kernel.org>

