Return-Path: <linux-nfs+bounces-22533-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xOnuOZ1RLGpUPQQAu9opvQ
	(envelope-from <linux-nfs+bounces-22533-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 20:36:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7876B67BC6F
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 20:36:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nYfMkxqn;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22533-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22533-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5DEC3001321
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 18:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9401C374A04;
	Fri, 12 Jun 2026 18:36:11 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC6D369D43;
	Fri, 12 Jun 2026 18:36:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289371; cv=none; b=Ur6zhmkctqHM5MULEZsJr5pKertBMU/1R7pwdJ7GnrlBsVvKkK6juWjRBH8e8okM4Iy0Uqul1o8fa1U5mjxheYRxOIUIVsZqIxU0hFKR89d1PFdp7Dy3geG/jgqNMyCWdhKyQa4DaCgUZyDmxgnCugiS9e/UUxFYP75MAqmEuh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289371; c=relaxed/simple;
	bh=FsKCZjNbYaHzjYp5mZSgPaQ3xRkP8w4McKrXM0ieuJ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aMyBJ3L+8HgMjJyNBE32F47UdTgC7SLjIAFJwfza/Mpu0/lmXVxO9chHKTcL51XAwkrBp/rx/z/NqN2kggOtdgnpvGDnUGXNnT+TJSsVOccGZEVvy6F4hHiHlWBEzAp3cAvKt343Z1mG9YzWMAb+dJKZNHTFcL4VZ7+yTysYeC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYfMkxqn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323081F000E9;
	Fri, 12 Jun 2026 18:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781289370;
	bh=6JRIp+0ZnHXaXJITWv4qytluPS2XYOyFtxmiaDvmY9Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nYfMkxqncfS1V/SVPfxgd6qeCZgbmZXJt+JTxpHFMqVdWzi2WGqDyy/PCsDNsqakc
	 fmPwP2lT/wwuWpKcysUSW60X2Ug+hzm9fdccLUpWL14tYGhl5keiupZbJacHGjp7fd
	 vdsnGn5K1jZE47BqaW2sWYifEcmlnwJDYu1OyrKxpiCgq2dZydLAz5SDQ5rCSgARUS
	 21hCC/NnTyNpn6mi3BOX/98mmgnZqbabNNuMwgVM56KxNot7Du7QI46UCtrIkd+pKB
	 0qM6fjj8kT1lsBbofNyLxmnyl5ujvP3xqqVDAQ3M7cCUK2lEqluT4NUSYR+IMdT7Xr
	 w6bh/r68qfqbw==
Message-ID: <d2a53fc34760fc986315df31ca6887bb3a54f47d.camel@kernel.org>
Subject: Re: [PATCH v6 10/20] nfsd: add notification handlers for dir events
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>, Jonathan Corbet <corbet@lwn.net>,  Shuah Khan
 <skhan@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Alexander Aring
 <alex.aring@gmail.com>,  Amir Goldstein <amir73il@gmail.com>, Jan Kara
 <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,  Christian
 Brauner	 <brauner@kernel.org>, Calum Mackay <calum.mackay@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Date: Fri, 12 Jun 2026 14:36:06 -0400
In-Reply-To: <b94c3e40-0520-4e83-9b4f-53a9325cecfe@app.fastmail.com>
References: <20260611-dir-deleg-v6-0-4c45080e5f3f@kernel.org>
	 <20260611-dir-deleg-v6-10-4c45080e5f3f@kernel.org>
	 <b94c3e40-0520-4e83-9b4f-53a9325cecfe@app.fastmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22533-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,cna_fh.data:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7876B67BC6F

On Fri, 2026-06-12 at 13:51 -0400, Chuck Lever wrote:
> On Thu, Jun 11, 2026, at 1:50 PM, Jeff Layton wrote:
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
> > ---
>=20
> > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > index ca4dd2f969eb..59378751d596 100644
> > --- a/fs/nfsd/nfs4callback.c
> > +++ b/fs/nfsd/nfs4callback.c
>=20
> > @@ -904,13 +908,45 @@ static void nfs4_xdr_enc_cb_notify(struct rpc_rqs=
t *req,
> >  	encode_cb_sequence4args(xdr, cb, &hdr);
> >=20
> >  	/*
> > -	 * FIXME: get stateid and fh from delegation. Inline the cna_changes
> > -	 * buffer, and zero it.
> > +	 * nfsd4_cb_notify_prepare() sized the payload against a single page,
> > +	 * but did not account for the compound, sequence, stateid, and
> > +	 * filehandle encoded here. If the variable-length encode overflows t=
he
> > +	 * backchannel send buffer, roll back to before the operation so that=
 a
> > +	 * truncated CB_NOTIFY is never placed on the wire.
> >  	 */
> > -	xdrgen_encode_CB_NOTIFY4args(xdr, &args);
> > +	start =3D xdr_stream_pos(xdr);
> > +
> > +	p =3D xdr_reserve_space(xdr, 4);
> > +	if (!p)
> > +		goto out_err;
> > +	*p =3D cpu_to_be32(OP_CB_NOTIFY);
>=20
> Please use xdr_stream_encode_u32 for this purpose.
>=20

Ok

>=20
> > +
> > +	args.cna_stateid.seqid =3D dp->dl_stid.sc_stateid.si_generation;
> > +	memcpy(&args.cna_stateid.other, &dp->dl_stid.sc_stateid.si_opaque,
> > +	       ARRAY_SIZE(args.cna_stateid.other));
> > +	args.cna_fh.len =3D dp->dl_stid.sc_file->fi_fhandle.fh_size;
> > +	args.cna_fh.data =3D dp->dl_stid.sc_file->fi_fhandle.fh_raw;
> > +	args.cna_changes.count =3D ncn->ncn_nf_cnt;
> > +	args.cna_changes.element =3D ncn->ncn_nf;
> > +	if (!xdrgen_encode_CB_NOTIFY4args(xdr, &args))
> > +		goto out_err;
> >=20
> >  	hdr.nops++;
> >  	encode_cb_nops(&hdr);
> > +	return;
> > +
> > +out_err:
> > +	/*
> > +	 * Drop the CB_NOTIFY op and emit a valid CB_SEQUENCE-only compound s=
o
> > +	 * the client still advances its slot. Flag the failure so the done
> > +	 * handler recalls the delegation and the missed notification is not
> > +	 * silently lost. The flag is written here in the transmit path and r=
ead
> > +	 * in the done handler; the two are serialized phases of the same
> > +	 * rpc_task, so no additional barrier is needed.
> > +	 */
> > +	ncn->ncn_encode_err =3D true;
>=20
> This flag is zeroed only once, at allocation time in alloc_init_dir_deleg=
().
> It is never cleared in nfsd4_cb_notify_prepare().
>=20
> Since nfsd4_cb_notify_release() can requeue the callback (via
> nfsd4_run_cb_notify) when events arrive while a callback is in flight,
> ->prepare may encode cleanly and return true, but nfsd4_cb_notify_done()
> still observes the stale ncn_encode_err =3D=3D true and calls
> nfsd_break_one_deleg() -- discarding a good notification and recalling
> the delegation unnecessarily.
>=20

Ok, so we need to reset this in ->prepare.

>=20
> > +	xdr_truncate_encode(xdr, start);
> > +	encode_cb_nops(&hdr);
> >  }
> >=20
> >  static int nfs4_xdr_dec_cb_notify(struct rpc_rqst *rqstp,
>=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 0a15d7f3b543..513cbc1a583f 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
>=20
> > @@ -3471,19 +3472,146 @@ nfsd4_cb_getattr_release(struct nfsd4_callback=
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
> > +	if (!queued) {
> > +		refcount_dec(&dp->dl_stid.sc_count);
> > +		clear_bit(NFSD4_CALLBACK_RUNNING, &dp->dl_recall.cb_flags);
> > +	}
> > +}
>=20
> nfsd_break_one_deleg() does an unconditional
> refcount_inc(&dp->dl_stid.sc_count), and its comment justifies this
> with "the lease code is serialized by the flc_lock." That invariant
> holds when called from nfsd_break_deleg_cb() under flc_lock, but
> nfsd4_cb_notify_prepare() runs on a workqueue WITHOUT flc_lock. Its
> out_recall: path calls nfsd_break_one_deleg(dp)
> directly. The delegation can be concurrently destroyed with sc_count
> already at zero, making this an inc-from-zero.
>=20
> The dispatch path nfsd4_run_cb_notify already does this correctly with
> refcount_inc_not_zero. The out_recall path needs the same guard (skip
> the recall / bail if the refcount is already zero).
>=20
> I notice that the last unapplied patch ("nfsd: add
> support to CB_NOTIFY for dir attribute changes") rewrites the guard
> "if (count > NOTIFY4_EVENT_QUEUE_SIZE)" into "if (count > limit)" with
> limit =3D NOTIFY4_EVENT_QUEUE_SIZE - 1 when NOTIFY4_CHANGE_DIR_ATTRS is
> requested. That turns the previously-dead overflow branch into a live,
> routine path to out_recall, which adds another normal-operation route
> into this unlocked recall.
>=20

This wart has been there a long time, and we just papered over it with
the lock.

I think we need to do a refcount_inc_not_zero() in
nfsd_break_one_deleg() and just return without queuing the callback if
it's already at 0. That means that the recall is racing with the lease
teardown, so I think the right thing to do is to not send the recall in
that case.
--=20
Jeff Layton <jlayton@kernel.org>

