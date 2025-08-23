Return-Path: <linux-nfs+bounces-13877-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FFDB32C96
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Aug 2025 01:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52E5A012F9
	for <lists+linux-nfs@lfdr.de>; Sat, 23 Aug 2025 23:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905941BC9E2;
	Sat, 23 Aug 2025 23:52:10 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C941552FD
	for <linux-nfs@vger.kernel.org>; Sat, 23 Aug 2025 23:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755993130; cv=none; b=vEOvB6okBvPzIfpRqNQN5hewFxyK2xGqQNofwrSpy9j/QsljnbaLkacpElUtyWZXF+qxcrUqYnNFvLh7kINlR5ptKrFhSY7X9qSwaYAwl9K46XZlWgePaUQy/dFJya4fi0/V/isdd9tmBatc0XyH1Mbm/xfjYIL3py58BMiqCiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755993130; c=relaxed/simple;
	bh=wh5B1bpHd1tmMbjUfyTING41L4bKUZyfmiZgpbDGf4c=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=FaUkJMpnGsr+8IxxbzHx6WMWvKAMNpBl4K9yGSNuu19IDLy3gt2njUhfr+o3zGGMw1XAvQ8FUQiI76YrStQ+5G8mmaKpiqG0Ny2QKajGuwhmozBwUFtdibzGyNPrANJvOss4HAEZojMvKCfoS5uCgTH4tEHhVlelYSscVRRUARs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1upy1k-006z5B-0Y;
	Sat, 23 Aug 2025 23:52:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Olga Kornievskaia" <okorniev@redhat.com>, jlayton@kernel.org,
 linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com, tom@talpey.com
Subject: Re: [RFC PATCH 1/1] nfsd: delay re-registering of listeners after
 listener removal
In-reply-to: <ab55513a-fff0-4907-98f7-716df23a1bb9@oracle.com>
References: <20250821204328.89218-1-okorniev@redhat.com>,
 <ab55513a-fff0-4907-98f7-716df23a1bb9@oracle.com>
Date: Sun, 24 Aug 2025 09:52:05 +1000
Message-id: <175599312545.2234665.14336815607780207352@noble.neil.brown.name>

On Fri, 22 Aug 2025, Chuck Lever wrote:
> On 8/21/25 4:43 PM, Olga Kornievskaia wrote:
> > This patch tries to address the following failure:
> > nfsdctl threads 0
> > nfsdctl listener +rdma::20049
> > nfsdctl listener +tcp::2049
> > nfsdctl listener -tcp::2049
> > nfsdctl: Error: Cannot assign requested address
> >=20
> > The reason for the failure is due to the fact that socket cleanup only
> > happens in __svc_rdma_free() which is a deferred work triggers when an
> > rdma transport is destroyed. To remove a listener nfsdctl is forced to
> > first remove all transports via svc_xprt_destroy_all() and then re-add
> > the ones that are left. Due to the fact that there isn't a way to
> > delete a particular entry from a list where permanent sockets are
> > stored.
>=20
> The issue is specifically with llist, which does not permit the
> deletion of any entry other than the first on the list.

That is true but not really relevant.
We can remove everything, walk the resulting list removing individual
things, an requeue everything we didn't want to remove.
This is exactly what svc_clean_up_xprts() does.
To remove a signle xprt We just need to set XPT_CLOSE, call
svc_delete_xprt() then run svc_clean_up_xprts().

I think svc_clean_up_xprts() should call svc_pool_wake_idle_thread()
after lwq_enqueue_batch() in case one of the xprts that we kept became
ready while it was temporarily not on the queue.

Thanks,
NeilBrown

>=20
>=20
> > Going back to the deferred work done in __svc_rdma_free(), the
> > work might not get to run before nfsd_nl_listener_set_doit() creates
> > the new transports. As a result, it finds that something is still
> > listening of the rdma port and rdma_bind_addr() fails.
> >=20
> > Proposed solution is to add a delay after svc_xprt_destroy_all() to
> > allow for the deferred work to run.
> >=20
> > --- Is the chosen value of 1s enough to ensure socket goes away?
> > I can't guarantee that.
>=20
> Adding a sleep and hoping it works is ... not a proper fix. The
> msleep() in svc_xprt_destroy_all() is part of a polling loop,
> and it is only waiting for the xprt lists to become empty. You're
> not polling here (ie, checking for completion before sleeping).
>=20
>=20
> > --- Alternatives that i can think of:
> > (1) to go back to listener removal approach that added removal of
> > entry to the llist api. That would not require a removal of all
> > transport causing this problem to occur. Earlier it was preferred
> > not to change llist api.
> > (2) some method of checking that all deferred work occuring in
> > svc_xprt_destroy_all() completed.
>=20
> Jeff (and perhaps Lorenzo) need to go back to the original reasons why
> this was done and rework it. I think we were avoiding holding the
> nfsd mutex in here?
>=20
> Complete shutdown of a transport always involve some deferred
> activity, and there's a reference count involved as well. I can't
> see how the current destroy/re-insert mechanism can be made reliable.
>=20
>=20
> > Fixes: d093c90892607 ("nfsd: fix management of listener transports")
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >  fs/nfsd/nfsctl.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index dd3267b4c203..f9f5670abcc3 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -1998,8 +1998,10 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb,=
 struct genl_info *info)
> >  	 * Since we can't delete an arbitrary llist entry, destroy the
> >  	 * remaining listeners and recreate the list.
> >  	 */
> > -	if (delete)
> > +	if (delete) {
> >  		svc_xprt_destroy_all(serv, net, false);
> > +		ssleep(1);
> > +	}
> > =20
> >  	/* walk list of addrs again, open any that still don't exist */
> >  	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
>=20
>=20
> --=20
> Chuck Lever
>=20


