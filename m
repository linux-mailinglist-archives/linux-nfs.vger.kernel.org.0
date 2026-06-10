Return-Path: <linux-nfs+bounces-22445-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I5x5E1KvKWrgbwMAu9opvQ
	(envelope-from <linux-nfs+bounces-22445-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 20:39:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2EB66C506
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 20:39:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EpKeMTrZ;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22445-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22445-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 861F5319A3E8
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 18:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B82834DCE3;
	Wed, 10 Jun 2026 18:38:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA22A3451A9;
	Wed, 10 Jun 2026 18:38:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781116698; cv=none; b=oIUNZlHhIolEL59ehBRfvISFrzF2rQ0LYWezZZsdNYCDR+Qw7gPcE/5ZlEx1Yb8//S217pGJ2OBDhTZmdoHfJMtLqcM54IZiwK2au6r9FmBLRi/MFLFLTm0W2Rpqvwqf/9SF2Sj1E4zrjlcWRLZ0je7BPHgFmQ6/nu1hvkTwaLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781116698; c=relaxed/simple;
	bh=36GEsLr22JWzy6UItHetE4r0XT7zIwiYyi4cprpi4kQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mihPiEmstyyrtc73Jqxql3JnKpaNv7ESK396ZniaUiAsTrGnAJQKUTGmTNXZjTAKtdA89t8V6Uq6IbJuoMaS0vmmEiScwA+jF1nVNwyFze0bEC57FJh9JAHxMD5BJbZJWZi7A8wrDvRmyeVoks4fGWKES6BH3FYv+5f/RtSXx1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpKeMTrZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56531F00893;
	Wed, 10 Jun 2026 18:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781116696;
	bh=cYAzGg0Iw+m2rFge1U3Ha8RubnhRgwWjsdXSSLFLy6o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EpKeMTrZ9ivkbCSRArkwZ7FXoKvLtLOtCUrZZmSw+OxCrVbrd0zL6NL3bC3ldm6qe
	 MGhQ+y4dRwDQUe806Y/qNVGmwxnFQ/O8vkmt3txbF3FpIoh5SSIP5qL22oq6900A5i
	 C+BDWqguDk3vaFCsy61W1xC7s11NN9AIiYt/U+rwdlGKktrzFj1ZktqPuzDWojIe2c
	 sQj43XoWuhwgxBVAzAezAKk4LmfYEhs0yB2K9h0lEekqQOPBmNDG1wYaoCJIzYOWwT
	 RhiaSkt9ntb9v5t8edPDbHJYHXqKrGjRznLJljFT1waELKjrTF4kUlRBGgAKnDitvj
	 Pz7JPihh6e9Ig==
Message-ID: <3f347e690dce92781fee0ea4787d8feb19517cc8.camel@kernel.org>
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
Date: Wed, 10 Jun 2026 14:38:13 -0400
In-Reply-To: <efdade0b-38f2-4e5e-b6dc-567d9eea97a9@app.fastmail.com>
References: <20260522-dir-deleg-v5-0-542cddfad576@kernel.org>
	 <20260522-dir-deleg-v5-10-542cddfad576@kernel.org>
	 <efdade0b-38f2-4e5e-b6dc-567d9eea97a9@app.fastmail.com>
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
	TAGGED_FROM(0.00)[bounces-22445-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D2EB66C506

On Mon, 2026-06-08 at 16:52 -0400, Chuck Lever wrote:
>=20
> On Fri, May 22, 2026, at 3:42 PM, Jeff Layton wrote:
> > Add the necessary parts to accept a fsnotify callback for directory
> > change event and create a CB_NOTIFY request for it. When a dir nfsd_fil=
e
> > is created set a handle_event callback to handle the notification.
>=20
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
>=20
> Now once I got all of the previous edits in place, all three LLM
> reviewers identified an issue here that might require a significant
> rewrite. This is why I stopped the minor editing here and decided
> it was time for you to consider restructuring (or not). I haven't
> looked at patches 11-21.
>=20
>   I think the new name here has a time-of-use problem.
>  =20
>   nrn_old_entry uses nne->ne_name, which alloc_nfsd_notify_event() copied
>   when fsnotify delivered the rename.  nrn_new_entry instead reads the
>   live dentry via take_dentry_name_snapshot() at callback-prepare time,
>   which can run long after the event was queued.
>=20
>   CB_NOTIFY is asynchronous: nfsd_handle_dir_event() queues the event on
>   ncn_evt[] and nothing holds ne_dentry stable until the work runs.
>   d_move() reuses the same dentry and rewrites d_name in place, so a
>   second rename of the entry before the queued callback encodes leaves
>   the dget'd ne_dentry carrying the later name.  An A->B event then
>   encodes as A->C, and a client holding the directory delegation applies
>   the wrong old->new mapping to its cache.  The old name is immune
>   because it was snapshotted up front; only the new name is read late.
>=20
>   The new name is available at notification time -- fsnotify_move() passe=
s
>   &moved->d_name as new_name, and ne_dentry is that moved dentry -- so
>   alloc_nfsd_notify_event() can snapshot it alongside the old name.
>=20
> What I haven't assessed is whether the suggested restructuring is
> now vulnerable to misbehavior during memory exhaustion.
>=20

That sounds legit. We probably need to snapshot the name sooner, when
we create the event. I'll spin something up. As far as memory
exhaustion goes: if that happens we'll just recall the delegation.
That's always the remedy when there are problems here.

>=20
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
> > +	return NULL;
> > +}
> > +
> >  static void svcxdr_init_encode_from_buffer(struct xdr_stream *xdr,
> >  				struct xdr_buf *buf, __be32 *p, int bytes)
> >  {
>=20

--=20
Jeff Layton <jlayton@kernel.org>

