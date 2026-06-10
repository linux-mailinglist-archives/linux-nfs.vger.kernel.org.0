Return-Path: <linux-nfs+bounces-22444-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mi4XGRquKWqsbwMAu9opvQ
	(envelope-from <linux-nfs+bounces-22444-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 20:34:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC7966C494
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 20:34:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=G1XTJpw9;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22444-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22444-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96138316DDCF
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 18:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD4334CFDD;
	Wed, 10 Jun 2026 18:33:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C291230BDB;
	Wed, 10 Jun 2026 18:33:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781116387; cv=none; b=U09gYcM/v1N5yERhP9nGuH8ZcWedmLalVqPPFP11eMPSG5O4wc4kX8ZiR0odBYGrXZVO2FVDr9GdR0zw8RpXRuzs24ZaHMwBqzb7IMgrb1Zw+ZSrHX2mprwBJtsqPUtKE+UGgT+3seM4NDAlb450pNas6+JftukFDB8pA+4KNoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781116387; c=relaxed/simple;
	bh=WGtDYobVJVceOlW6rMyUtd+aWP25xlDjpFGnn2Y/9Lg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AYUxI2d0nOY3soIvKU0SDG8Y7N/8xH+Q94SNkKHmMjdTHpyPeExuly2o21lzaW2MzB59OwVu/0hl4cJqJQs+IBx8E3GPNnbt5I3/bU1wd54AXzkAjCvn7iDku912DkrBvpfm/9OukHmZ1i5v3x8Y3qkGAPH9PLXVAOK/8IOZ8UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1XTJpw9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609AE1F00893;
	Wed, 10 Jun 2026 18:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781116386;
	bh=LYepIqdbm0RJxsVFc8ijsTol97ngpqStCbbcR9V8DBg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=G1XTJpw9b8LYv1GMhcF1SkkN5Dn5eJbcA5Pd5LcXTcLd/e//GMAfIqBbnUh0Y146I
	 YuT52fJxC291whPQL8SCETFT6XiqtdhPy0viX1WEWlVukz/KYpUW2t03pTkzzBvhZY
	 6QwqWxJUG3MJEWZxFbS5GiPhpIbFy8u2y+izOyGTR8Fj4+aFN9OfMzXbMj4s+rl3nP
	 RPw7at+e4JX3TGiGXtycji8qRZc4a/wEGH0C+F/5vE8K22nUTp6YEOln87GU4iwr4r
	 qCLdsI+mSj7m4anjUlOHjqYizNRupEvgFRr1+jIFUVO/B9mLmh/dr+25X44s0T0s+n
	 KlkpIQ0dbqx5g==
Message-ID: <943d41eb654e6b56906b956cea59efd0d0f39717.camel@kernel.org>
Subject: Re: [PATCH v5 10/21] nfsd: add notification handlers for dir events
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo <Dai.Ngo@oracle.com>,  Tom Talpey <tom@talpey.com>, Trond Myklebust
 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,  Jonathan Corbet	
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Alexander Aring
 <alex.aring@gmail.com>,  Amir Goldstein <amir73il@gmail.com>, Jan Kara
 <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,  Christian
 Brauner	 <brauner@kernel.org>, Calum Mackay <calum.mackay@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Date: Wed, 10 Jun 2026 14:33:02 -0400
In-Reply-To: <344ed039-86ce-4125-8476-2e5d22e40fdc@app.fastmail.com>
References: <20260522-dir-deleg-v5-0-542cddfad576@kernel.org>
	 <20260522-dir-deleg-v5-10-542cddfad576@kernel.org>
	 <344ed039-86ce-4125-8476-2e5d22e40fdc@app.fastmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22444-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,cna_fh.data:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ADC7966C494

On Mon, 2026-06-08 at 16:40 -0400, Chuck Lever wrote:
>=20
> On Fri, May 22, 2026, at 3:42 PM, Jeff Layton wrote:
> > Add the necessary parts to accept a fsnotify callback for directory
> > change event and create a CB_NOTIFY request for it. When a dir nfsd_fil=
e
> > is created set a handle_event callback to handle the notification.
> >=20
> > Use that to allocate a nfsd_notify_event object and then hand off a
> > reference to each delegation's CB_NOTIFY. If anything fails along the
> > way, recall any affected delegations.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> There are some significant-looking sashiko review findings which I did
> not follow up on.
>=20

I plan to go over Sashiko's findings after I go through your responses.

>=20
> > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > index ea3e7deb06fa..1964a213f80e 100644
> > --- a/fs/nfsd/nfs4callback.c
> > +++ b/fs/nfsd/nfs4callback.c
> > @@ -870,21 +870,30 @@ static void nfs4_xdr_enc_cb_notify(struct=20
> > rpc_rqst *req,
> >  				   const void *data)
> >  {
> >  	const struct nfsd4_callback *cb =3D data;
> > +	struct nfsd4_cb_notify *ncn =3D container_of(cb, struct=20
> > nfsd4_cb_notify, ncn_cb);
> > +	struct nfs4_delegation *dp =3D container_of(ncn, struct=20
> > nfs4_delegation, dl_cb_notify);
> >  	struct nfs4_cb_compound_hdr hdr =3D {
> >  		.ident =3D 0,
> >  		.minorversion =3D cb->cb_clp->cl_minorversion,
> >  	};
> > -	struct CB_NOTIFY4args args =3D { };
> > +	struct CB_NOTIFY4args args;
> > +	__be32 *p;
> >=20
> >  	WARN_ON_ONCE(hdr.minorversion =3D=3D 0);
> >=20
> >  	encode_cb_compound4args(xdr, &hdr);
> >  	encode_cb_sequence4args(xdr, cb, &hdr);
> >=20
> > -	/*
> > -	 * FIXME: get stateid and fh from delegation. Inline the cna_changes
> > -	 * buffer, and zero it.
> > -	 */
> > +	p =3D xdr_reserve_space(xdr, 4);
> > +	*p =3D cpu_to_be32(OP_CB_NOTIFY);
> > +
> > +	args.cna_stateid.seqid =3D dp->dl_stid.sc_stateid.si_generation;
> > +	memcpy(&args.cna_stateid.other, &dp->dl_stid.sc_stateid.si_opaque,
> > +	       ARRAY_SIZE(args.cna_stateid.other));
> > +	args.cna_fh.len =3D dp->dl_stid.sc_file->fi_fhandle.fh_size;
> > +	args.cna_fh.data =3D dp->dl_stid.sc_file->fi_fhandle.fh_raw;
> > +	args.cna_changes.count =3D ncn->ncn_nf_cnt;
> > +	args.cna_changes.element =3D ncn->ncn_nf;
> >  	WARN_ON_ONCE(!xdrgen_encode_CB_NOTIFY4args(xdr, &args));
> >=20
> >  	hdr.nops++;
>=20
> I want to avoid the need to use xdrgen to encode the CB_NOTIFY arguments.
> How about this:
>=20
> +       struct nfsd4_cb_notify *ncn =3D container_of(cb, struct nfsd4_cb_=
notify, ncn_cb);
> +       struct nfs4_delegation *dp =3D container_of(ncn, struct nfs4_dele=
gation, dl_cb_notify);
>=20
>    ...
>=20
> +       encode_stateid4(xdr, &dp->dl_stid.sc_stateid);
> +       encode_nfs_fh4(xdr, &dp->dl_stid.sc_file->fi_fhandle);
> +       xdr_stream_encode_u32(xdr, ncn->ncn_nf_cnt);
> +       for (u32 i =3D 0; i < ncn->ncn_nf_cnt; i++)
> +               (void)xdrgen_encode_notify4(xdr, &ncn->ncn_nf[i]);
>=20
> And then add a "pragma public notify4;" in nfs4_1.x .
>=20

For those following along, Chuck and I had a private discussion and I
think we're going to keep this calling xdrgen_encode_CB_NOTIFY4args()
for now. I am dropping the WARN_ON_ONCE though.

>=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index b0652c755b3b..20477144475b 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
>=20
> > @@ -3461,19 +3462,131 @@ nfsd4_cb_getattr_release(struct nfsd4_callback=
 *cb)
> >  	nfs4_put_stid(&dp->dl_stid);
> >  }
> >=20
> > +static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
> > +{
> > +	bool queued;
> > +
> > +	if (test_and_set_bit(NFSD4_CALLBACK_RUNNING, &dp->dl_recall.cb_flags)=
)
> > +		return;
> > +
> > +	/*
> > +	 * We're assuming the state code never drops its reference
> > +	 * without first removing the lease.  Since we're in this lease
> > +	 * callback (and since the lease code is serialized by the
> > +	 * flc_lock) we know the server hasn't removed the lease yet, and
> > +	 * we know it's safe to take a reference.
> > +	 */
> > +	refcount_inc(&dp->dl_stid.sc_count);
> > +	queued =3D nfsd4_run_cb(&dp->dl_recall);
> > +	WARN_ON_ONCE(!queued);
> > +	if (!queued)
> > +		refcount_dec(&dp->dl_stid.sc_count);
> > +}
> > +
> > +static bool
> > +nfsd4_cb_notify_prepare(struct nfsd4_callback *cb)
> > +{
> > +	struct nfsd4_cb_notify *ncn =3D container_of(cb, struct=20
> > nfsd4_cb_notify, ncn_cb);
> > +	struct nfs4_delegation *dp =3D container_of(ncn, struct=20
> > nfs4_delegation, dl_cb_notify);
> > +	struct nfsd_notify_event *events[NOTIFY4_EVENT_QUEUE_SIZE];
> > +	struct xdr_buf xdr =3D { .buflen =3D PAGE_SIZE * NOTIFY4_PAGE_ARRAY_S=
IZE,
> > +			       .pages  =3D ncn->ncn_pages };
> > +	struct xdr_stream stream;
> > +	struct nfsd_file *nf;
> > +	int count, i;
> > +	bool error =3D false;
> > +
> > +	xdr_init_encode_pages(&stream, &xdr);
> > +
> > +	spin_lock(&ncn->ncn_lock);
> > +	count =3D ncn->ncn_evt_cnt;
> > +
> > +	/* spurious queueing? */
> > +	if (count =3D=3D 0) {
> > +		spin_unlock(&ncn->ncn_lock);
> > +		return false;
> > +	}
> > +
> > +	/* we can't keep up! */
> > +	if (count > NOTIFY4_EVENT_QUEUE_SIZE) {
> > +		spin_unlock(&ncn->ncn_lock);
> > +		goto out_recall;
> > +	}
> > +
> > +	memcpy(events, ncn->ncn_evt, sizeof(*events) * count);
> > +	ncn->ncn_evt_cnt =3D 0;
> > +	spin_unlock(&ncn->ncn_lock);
> > +
> > +	rcu_read_lock();
> > +	nf =3D=20
> > nfsd_file_get(rcu_dereference(dp->dl_stid.sc_file->fi_deleg_file));
> > +	rcu_read_unlock();
> > +	if (!nf) {
> > +		for (i =3D 0; i < count; ++i)
> > +			nfsd_notify_event_put(events[i]);
> > +		goto out_recall;
> > +	}
> > +
> > +	for (i =3D 0; i < count; ++i) {
> > +		struct nfsd_notify_event *nne =3D events[i];
> > +
> > +		if (!error) {
> > +			u32 *maskp =3D (u32 *)xdr_reserve_space(&stream, sizeof(*maskp));
> > +			u8 *p;
> > +
> > +			if (!maskp) {
> > +				error =3D true;
> > +				goto put_event;
> > +			}
> > +
> > +			p =3D nfsd4_encode_notify_event(&stream, nne, dp, nf, maskp);
> > +			if (!p) {
> > +				pr_notice("Could not generate CB_NOTIFY from fsnotify mask 0x%x\n"=
,
> > +					  nne->ne_mask);
> > +				error =3D true;
> > +				goto put_event;
> > +			}
> > +
> > +			ncn->ncn_nf[i].notify_mask.count =3D 1;
> > +			ncn->ncn_nf[i].notify_mask.element =3D maskp;
> > +			ncn->ncn_nf[i].notify_vals.data =3D p;
> > +			ncn->ncn_nf[i].notify_vals.len =3D (u8 *)stream.p - p;
> > +		}
> > +put_event:
> > +		nfsd_notify_event_put(nne);
> > +	}
> > +	if (!error) {
> > +		ncn->ncn_nf_cnt =3D count;
> > +		nfsd_file_put(nf);
> > +		return true;
> > +	}
> > +	nfsd_file_put(nf);
> > +out_recall:
> > +	nfsd_break_one_deleg(dp);
> > +	return false;
> > +}
> > +
> >  static int
> >  nfsd4_cb_notify_done(struct nfsd4_callback *cb,
> >  				struct rpc_task *task)
> >  {
> > +	struct nfsd4_cb_notify *ncn =3D container_of(cb, struct=20
> > nfsd4_cb_notify, ncn_cb);
> > +	struct nfs4_delegation *dp =3D container_of(ncn, struct=20
> > nfs4_delegation, dl_cb_notify);
> > +
> >  	switch (task->tk_status) {
> >  	case -NFS4ERR_DELAY:
> >  		rpc_delay(task, 2 * HZ);
> >  		return 0;
> >  	default:
> > +		/* For any other hard error, recall the deleg */
> > +		nfsd_break_one_deleg(dp);
> > +		fallthrough;
> > +	case 0:
> >  		return 1;
> >  	}
> >  }
> >=20
> > +static void nfsd4_run_cb_notify(struct nfsd4_cb_notify *ncn);
> > +
> >  static void
> >  nfsd4_cb_notify_release(struct nfsd4_callback *cb)
> >  {
> > @@ -3482,6 +3595,9 @@ nfsd4_cb_notify_release(struct nfsd4_callback *cb=
)
> >  	struct nfs4_delegation *dp =3D
> >  			container_of(ncn, struct nfs4_delegation, dl_cb_notify);
> >=20
> > +	/* Drain events that arrived while this callback was in flight */
> > +	if (ncn->ncn_evt_cnt > 0)
> > +		nfsd4_run_cb_notify(ncn);
>=20
> The above check needs to be serialized with modification of
> ncn_evt_cnt:
>
> +       bool pending;
> =20
> +       /* Drain events that arrived while this callback was in flight */
> +       spin_lock(&ncn->ncn_lock);
> +       pending =3D ncn->ncn_evt_cnt > 0;
> +       spin_unlock(&ncn->ncn_lock);
> +       if (pending)
> +               nfsd4_run_cb_notify(ncn);
>=20

I need to ponder this. Does this matter?

NFSD4_CALLBACK_RUNNING is now clear, which should be observed by
another task queueing a new event. READ_ONCE() seems like it should be
sufficient here. I'll run it by Claude.


>=20
> >  	nfs4_put_stid(&dp->dl_stid);
> >  }
> >=20
>=20
> > @@ -9858,3 +9954,133 @@ void nfsd_update_cmtime_attr(struct file *f,=
=20
> > unsigned int flags)
> >  				      MINOR(inode->i_sb->s_dev),
> >  				      inode->i_ino, ret);
> >  }
> > +
> > +static void
> > +nfsd4_run_cb_notify(struct nfsd4_cb_notify *ncn)
> > +{
> > +	struct nfs4_delegation *dp =3D container_of(ncn, struct=20
> > nfs4_delegation, dl_cb_notify);
> > +
> > +	if (test_and_set_bit(NFSD4_CALLBACK_RUNNING, &ncn->ncn_cb.cb_flags))
> > +		return;
> > +
> > +	if (!refcount_inc_not_zero(&dp->dl_stid.sc_count))
> > +		clear_bit(NFSD4_CALLBACK_RUNNING, &ncn->ncn_cb.cb_flags);
> > +	else
> > +		nfsd4_run_cb(&ncn->ncn_cb);
> > +}
> > +
> > +static struct nfsd_notify_event *
> > +alloc_nfsd_notify_event(u32 mask, const struct qstr *q, struct dentry=
=20
> > *dentry,
> > +			struct inode *target)
> > +{
> > +	struct nfsd_notify_event *ne;
> > +
> > +	ne =3D kmalloc(sizeof(*ne) + q->len + 1, GFP_NOFS);
> > +	if (!ne)
> > +		return NULL;
> > +
> > +	memcpy(&ne->ne_name, q->name, q->len);
> > +	refcount_set(&ne->ne_ref, 1);
> > +	ne->ne_mask =3D mask;
> > +	ne->ne_name[q->len] =3D '\0';
> > +	ne->ne_namelen =3D q->len;
> > +	ne->ne_dentry =3D dget(dentry);
> > +	ne->ne_target =3D target;
> > +	if (ne->ne_target)
> > +		ihold(ne->ne_target);
> > +	return ne;
> > +}
> > +
> > +static bool
> > +should_notify_deleg(u32 mask, struct file_lease *fl)
> > +{
> > +	/* Don't notify the client generating the event */
> > +	if (nfsd_breaker_owns_lease(fl))
> > +		return false;
> > +
> > +	/* Skip if this event wasn't ignored by the lease */
> > +	if ((mask & FS_DELETE) && !(fl->c.flc_flags & FL_IGN_DIR_DELETE))
> > +		return false;
> > +	if ((mask & FS_CREATE) && !(fl->c.flc_flags & FL_IGN_DIR_CREATE))
> > +		return false;
> > +	if ((mask & FS_RENAME) && !(fl->c.flc_flags & FL_IGN_DIR_RENAME))
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> > +static void
> > +nfsd_recall_all_dir_delegs(const struct inode *dir)
> > +{
> > +	struct file_lock_context *ctx =3D locks_inode_context(dir);
> > +	struct file_lock_core *flc;
> > +
> > +	spin_lock(&ctx->flc_lock);
> > +	list_for_each_entry(flc, &ctx->flc_lease, flc_list) {
> > +		struct file_lease *fl =3D container_of(flc, struct file_lease, c);
> > +
> > +		if (fl->fl_lmops =3D=3D &nfsd_lease_mng_ops)
> > +			nfsd_break_deleg_cb(fl);
> > +	}
> > +	spin_unlock(&ctx->flc_lock);
> > +}
> > +
> > +int
> > +nfsd_handle_dir_event(u32 mask, const struct inode *dir, const void=
=20
> > *data,
> > +		      int data_type, const struct qstr *name)
> > +{
> > +	struct dentry *dentry =3D fsnotify_data_dentry(data, data_type);
> > +	struct inode *target =3D fsnotify_data_rename_target(data, data_type)=
;
> > +	struct file_lock_context *ctx;
> > +	struct file_lock_core *flc;
> > +	struct nfsd_notify_event *evt;
> > +
> > +	/* Normalize cross-dir rename events to create/delete */
> > +	if (mask & FS_MOVED_FROM) {
> > +		mask &=3D ~FS_MOVED_FROM;
> > +		mask |=3D FS_DELETE;
> > +	}
> > +	if (mask & FS_MOVED_TO) {
> > +		mask &=3D ~FS_MOVED_TO;
> > +		mask |=3D FS_CREATE;
> > +	}
> > +
>=20
> I inserted an extra check here for rename notifications:
>=20
> +       /*
> +        * FS_RENAME fires on the source directory even for a cross-dir
> +        * rename, where the moved entry now lives under a different
> +        * parent. NOTIFY4_RENAME_ENTRY describes an in-place rename, so
> +        * reporting it here would advertise a name absent from this
> +        * directory.
> +        */
> +       if ((mask & FS_RENAME) && dentry && d_inode(dentry->d_parent) !=
=3D dir)
> +               mask &=3D ~FS_RENAME;
>=20

Thanks. I'll add that in.

>=20
> > +	/* Don't do anything if this is not an expected event */
> > +	if (!(mask & (FS_CREATE|FS_DELETE|FS_RENAME)))
> > +		return 0;
> > +
> > +	ctx =3D locks_inode_context(dir);
> > +	if (!ctx || list_empty(&ctx->flc_lease))
> > +		return 0;
> > +
> > +	evt =3D alloc_nfsd_notify_event(mask, name, dentry, target);
> > +	if (!evt) {
> > +		nfsd_recall_all_dir_delegs(dir);
> > +		return 0;
> > +	}
> > +
> > +	spin_lock(&ctx->flc_lock);
> > +	list_for_each_entry(flc, &ctx->flc_lease, flc_list) {
> > +		struct file_lease *fl =3D container_of(flc, struct file_lease, c);
> > +		struct nfs4_delegation *dp =3D flc->flc_owner;
> > +		struct nfsd4_cb_notify *ncn =3D &dp->dl_cb_notify;
> > +
>=20
> I added:
>=20
> +               if (fl->fl_lmops !=3D &nfsd_lease_mng_ops)
> +                       continue;
>=20
> Otherwise the loop treats every lease on the inode as an nfsd delegation
> unconditionally.
>=20

This is not necessary. should_notify_deleg() calls
nfsd_breaker_owns_lease(), which already checks this before doing
anything else.

>=20
> > +		if (!should_notify_deleg(mask, fl))
> > +			continue;
> > +
> > +		spin_lock(&ncn->ncn_lock);
> > +		if (ncn->ncn_evt_cnt >=3D NOTIFY4_EVENT_QUEUE_SIZE) {
> > +			/* We're generating notifications too fast. Recall. */
> > +			spin_unlock(&ncn->ncn_lock);
> > +			nfsd_break_deleg_cb(fl);
> > +			continue;
> > +		}
> > +		ncn->ncn_evt[ncn->ncn_evt_cnt++] =3D nfsd_notify_event_get(evt);
> > +		spin_unlock(&ncn->ncn_lock);
> > +
> > +		nfsd4_run_cb_notify(ncn);
> > +	}
> > +	spin_unlock(&ctx->flc_lock);
> > +	nfsd_notify_event_put(evt);
> > +	return 0;
> > +}
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index e17488a911f7..31df04675713 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -4172,6 +4172,127 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp,=20
> > struct xdr_stream *xdr,
> >  	goto out;
> >  }
> >=20
> > +static bool
> > +nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream=
=20
> > *xdr,
> > +			  struct dentry *dentry, struct nfs4_delegation *dp,
> > +			  struct nfsd_file *nf, char *name, u32 namelen)
> > +{
> > +	uint32_t *attrmask;
> > +
> > +	/* Reserve space for attrmask */
> > +	attrmask =3D xdr_reserve_space(xdr, 3 * sizeof(uint32_t));
> > +	if (!attrmask)
> > +		return false;
> > +
> > +	ne->ne_file.data =3D name;
> > +	ne->ne_file.len =3D namelen;
> > +	ne->ne_attrs.attrmask.element =3D attrmask;
> > +
> > +	attrmask[0] =3D 0;
> > +	attrmask[1] =3D 0;
> > +	attrmask[2] =3D 0;
> > +	ne->ne_attrs.attr_vals.data =3D NULL;
> > +	ne->ne_attrs.attr_vals.len =3D 0;
> > +	ne->ne_attrs.attrmask.count =3D 1;
> > +	return true;
> > +}
> > +
> > +/**
> > + * nfsd4_encode_notify_event - encode a notify
> > + * @xdr: stream to which to encode the fattr4
> > + * @nne: nfsd_notify_event to encode
> > + * @dp: delegation where the event occurred
> > + * @nf: nfsd_file on which event occurred
> > + * @notify_mask: pointer to word where notification mask should be set
> > + *
> > + * Encode @nne into @xdr. Returns a pointer to the start of the event,=
=20
> > or NULL if
> > + * the event couldn't be encoded. The appropriate bit in the=20
> > notify_mask will also
> > + * be set on success.
> > + */
>=20
> Nit: Let's use the usual kdoc style to describe the return value.
>=20

Ok, will fix.

> + * Encode @nne into @xdr. The matching bit in @notify_mask is set on
> + * success.
> + *
> + * Return: pointer to the start of the encoded event, or NULL if the
> + * event could not be encoded.
> + */
>=20
>=20
> > +u8 *nfsd4_encode_notify_event(struct xdr_stream *xdr, struct=20
> > nfsd_notify_event *nne,
> > +			      struct nfs4_delegation *dp, struct nfsd_file *nf,
> > +			      u32 *notify_mask)
> > +{
> > +	u8 *p =3D NULL;
> > +
> > +	*notify_mask =3D 0;
> > +
> > +	if (nne->ne_mask & FS_DELETE) {
> > +		struct notify_remove4 nr =3D { };
> > +
> > +		if (!nfsd4_setup_notify_entry4(&nr.nrm_old_entry, xdr,=20
> > nne->ne_dentry, dp,
> > +					       nf, nne->ne_name, nne->ne_namelen))
> > +			goto out_err;
> > +		p =3D (u8 *)xdr->p;
> > +		if (!xdrgen_encode_notify_remove4(xdr, &nr))
> > +			goto out_err;
> > +		*notify_mask |=3D BIT(NOTIFY4_REMOVE_ENTRY);
> > +	} else if (nne->ne_mask & FS_CREATE) {
> > +		struct notify_add4 na =3D { };
> > +		struct notify_remove4 old =3D { };
> > +
> > +		if (!nfsd4_setup_notify_entry4(&na.nad_new_entry, xdr,=20
> > nne->ne_dentry, dp,
> > +					       nf, nne->ne_name, nne->ne_namelen))
> > +			goto out_err;
> > +
> > +		/* If a file was overwritten, report it in nad_old_entry */
> > +		if (nne->ne_target) {
> > +			if (!nfsd4_setup_notify_entry4(&old.nrm_old_entry, xdr,
> > +						       NULL, dp, nf,
> > +						       nne->ne_name, nne->ne_namelen))
> > +				goto out_err;
> > +			na.nad_old_entry.count =3D 1;
> > +			na.nad_old_entry.element =3D &old;
> > +		}
> > +
> > +		p =3D (u8 *)xdr->p;
> > +		if (!xdrgen_encode_notify_add4(xdr, &na))
> > +			goto out_err;
> > +
> > +		*notify_mask |=3D BIT(NOTIFY4_ADD_ENTRY);
> > +	} else if (nne->ne_mask & FS_RENAME) {
> > +		struct notify_rename4 nr =3D { };
> > +		struct notify_remove4 old =3D { };
> > +		struct name_snapshot n;
> > +		bool ret;
> > +
> > +		/* Don't send any attributes in the old_entry since they're the same=
=20
> > in new */
> > +		if (!nfsd4_setup_notify_entry4(&nr.nrn_old_entry.nrm_old_entry, xdr,
> > +					       NULL, dp, nf, nne->ne_name,
> > +					       nne->ne_namelen))
> > +			goto out_err;
> > +
> > +		take_dentry_name_snapshot(&n, nne->ne_dentry);
> > +		ret =3D nfsd4_setup_notify_entry4(&nr.nrn_new_entry.nad_new_entry, x=
dr,
> > +					       nne->ne_dentry, dp, nf, (char *)n.name.name,
> > +					       n.name.len);
> > +
> > +		/* If a file was overwritten, report it in nad_old_entry */
> > +		if (ret && nne->ne_target) {
> > +			ret =3D nfsd4_setup_notify_entry4(&old.nrm_old_entry, xdr,
> > +							NULL, dp, nf,
> > +							(char *)n.name.name, n.name.len);
> > +			if (ret) {
> > +				nr.nrn_new_entry.nad_old_entry.count =3D 1;
> > +				nr.nrn_new_entry.nad_old_entry.element =3D &old;
> > +			}
> > +		}
> > +
> > +		if (ret) {
> > +			p =3D (u8 *)xdr->p;
> > +			ret =3D xdrgen_encode_notify_rename4(xdr, &nr);
> > +		}
> > +		release_dentry_name_snapshot(&n);
> > +		if (!ret)
> > +			goto out_err;
> > +		*notify_mask |=3D BIT(NOTIFY4_RENAME_ENTRY);
> > +	}
> > +	return p;
> > +out_err:
> > +	pr_warn("nfsd: unable to marshal notify_rename4 to xdr stream\n");
>=20
> Nit: The warning needs to match the semantics of nfsd4_encode_notify_even=
t().
> How about:
>=20
> +       pr_warn("nfsd: unable to marshal notify event to xdr stream\n");
>=20

Sounds good.

>=20
> > +	return NULL;
> > +}
> > +
>=20

--=20
Jeff Layton <jlayton@kernel.org>

