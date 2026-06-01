Return-Path: <linux-nfs+bounces-22167-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RQ88CRuMHWrFbwkAu9opvQ
	(envelope-from <linux-nfs+bounces-22167-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 15:41:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A05D62032A
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 15:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3895B3014870
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 13:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFF13A48D5;
	Mon,  1 Jun 2026 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnYJqgyq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B00C342C8B;
	Mon,  1 Jun 2026 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321285; cv=none; b=JGraZdTKFSW6/ppKrZCpGlnOpFEXz8GyO+EAc2dqO7vg5vYFE6PD/vw4U8DZNfOTlENF4Rk8QIt1by6n0ogRYDVuAIFusa9dTP0+yW9W6hPoxIQGhdpmWoNDNO9lxDDwMS85VKbFq4IWn7gvj5P7GvSW8FesrflLvfDueTh9srE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321285; c=relaxed/simple;
	bh=CQo5mVLvY8Yv4cXjaHawRjRBimy/WX6Gja9MA0W5is0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mkr/Ja0CooWUVpFxaPBFVtrk4iSOoWkEo3l4GlfeTV9w3gPtFc/qDV5eHCaDEvXqB6pSK5g5HUJTNDIrkRRDOC7RAfXfMZst24+rC0LIJGhNFmx5ezifLOPtuFBiYC5nUNG128YBaF0GhtIJ567GsXQL7lJcdz/HMWuS+BRLTgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnYJqgyq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A50B1F00893;
	Mon,  1 Jun 2026 13:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780321284;
	bh=2IuCz7H1jrGhIML/EnhPcIu47qAJup/0DKDMWU7npUw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GnYJqgyqJQqU9BFPW0msiE+CBjmtUpc+xM6udo0yHy/45XdDCeNXBNTjV1DkwsQY6
	 l8gqWMm73uqtqkiREEWQyXKHlON1Ahnoz9AkP8JxlAjAELzwhg9KgUKJHl2F06mRz3
	 qCd4ow17zQJ0QkAjzew757a2MDZY3nwzd/VEpcVnSSRJvjSU/vOMZqeoq3SeTrcTY5
	 yzPfO19ZuJV10+XM14lSjFX/EqTiopN/rki3ZPpeFGARv6+ru5lfrIIWLIzOmjliHz
	 I7LEPtoOq+K88JsQb5o6ORVrr6ObOvi14PnnHtaxDZLrZrvJJUus3aK8cIgdeWQFrU
	 5DhkiVCPKgrIQ==
Message-ID: <6924de18c6fd50d61e39b426bcfdce7617ce2976.camel@kernel.org>
Subject: Re: [PATCH v2] nfsd: release OPEN-decoded posix ACLs via op_release
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>, Olga Kornievskaia	
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>,  Rick Macklem <rmacklem@uoguelph.ca>, Chris Mason
 <clm@meta.com>, linux-nfs@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 01 Jun 2026 09:41:21 -0400
In-Reply-To: <178027597098.2923901.17316619429004997151@noble.neil.brown.name>
References: <20260531-nfsd-testing-v2-1-e13e6355fc07@kernel.org>
	 <178027597098.2923901.17316619429004997151@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22167-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1A05D62032A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-06-01 at 11:06 +1000, NeilBrown wrote:
> On Mon, 01 Jun 2026, Jeff Layton wrote:
> > nfsd4_decode_createhow4() calls nfsd4_decode_fattr4(), which allocates
> > refcounted struct posix_acl objects via posix_acl_alloc() and stores
> > them in open->op_pacl and open->op_dpacl. These pointers must be
> > released once the OPEN compound finishes.
> >=20
> > When nfsd4_decode_open_claim4() returns a non-seqid-mutating error,
> > the dispatcher short-circuits before op_func runs:
> >=20
> >     nfsd4_proc_compound()
> >       opdesc->op_func =3D=3D nfsd4_open_omfg
> >         if (!seqid_mutating_err(ntohl(op->status)))
> >             return op->status;   /* nfsd4_open() never runs */
> >       opdesc->op_release(&op->u)  /* must still release op_pacl/op_dpac=
l */
> >=20
> > Before this change OP_OPEN had no .op_release in nfsd4_ops[], and the
> > release pair lived inside nfsd4_open() at its out_err: label. On the
> > short-circuit path nfsd4_open() is never invoked, so both posix_acl
> > refs leak on every malformed OPEN compound that carries valid POSIX
> > ACL createhow4 attributes.
> >=20
> > Add nfsd4_open_release() and wire it as .op_release for OP_OPEN.
> > posix_acl_release() is NULL-safe, so the single release site covers
> > both the normal path and the nfsd4_open_omfg short-circuit. Remove
> > the matching posix_acl_release() pair from nfsd4_open()'s out_err:
> > label to avoid double-releasing.
> >=20
> > The compound loop has two encoding branches: nfsd4_encode_operation()
> > for normal ops, and nfsd4_encode_replay() for v4.0 replayed ops.
> > op_release was only called from nfsd4_encode_operation(), so resources
> > attached to op->u leak on the replay path. Add an op_release call to
> > the replay branch as well to ensure cleanup on every path.
> >=20
> > Fixes: 5fc51dfc2eb1 ("NFSD: Add support for XDR decoding POSIX draft AC=
Ls")
> > Signed-off-by: Chris Mason <clm@meta.com>
> > Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > Changes in v2:
> > - Ensure that op_release is called in the v4.0 replay case as well
> > - Link to v1: https://lore.kernel.org/r/20260531-nfsd-testing-v1-0-7bfa=
481b0540@kernel.org
> > ---
> >  fs/nfsd/nfs4proc.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 017474cd63b5..51998d7885ae 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -681,8 +681,6 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> >  	nfsd4_cleanup_open_state(cstate, open);
> >  	nfsd4_bump_seqid(cstate, status);
> >  out_err:
> > -	posix_acl_release(open->op_dpacl);
> > -	posix_acl_release(open->op_pacl);
> >  	return status;
> >  }
> > =20
> > @@ -704,6 +702,13 @@ static __be32 nfsd4_open_omfg(struct svc_rqst *rqs=
tp, struct nfsd4_compound_stat
> >  	return nfsd4_open(rqstp, cstate, &op->u);
> >  }
> > =20
> > +static void
> > +nfsd4_open_release(union nfsd4_op_u *u)
> > +{
> > +	posix_acl_release(u->open.op_dpacl);
> > +	posix_acl_release(u->open.op_pacl);
> > +}
> > +
> >  /*
> >   * filehandle-manipulating ops.
> >   */
> > @@ -3214,6 +3219,8 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
> >  			op->replay =3D &cstate->replay_owner->so_replay;
> >  			nfsd4_encode_replay(resp->xdr, op);
> >  			status =3D op->status =3D op->replay->rp_status;
> > +			if (op->opdesc->op_release)
> > +				op->opdesc->op_release(&op->u);
> >  		} else {
> >  			nfsd4_encode_operation(resp, op);
> >  			status =3D op->status;
>=20
> I think this patch is good, but I think it would be even better if the
> ->op_release() call were moved out of nfsd4_encode_operation() and
> places after this if-else.  Then there would be only one call-site in a
> fairly obviously-correct place.
> But:
>   Reviewed-by: NeilBrown <neil@brown.name>
> for if you just want to stick with this version.
>=20
> Thanks,
> NeilBrown
>=20

I like that idea.

I'll be testing a pile of other patches today anyway, so I'll make this
change and test it alongside the rest.

Chuck, you can either take this one and I'll do a cleanup patch along
the lines of what Neil suggests, or I can send a v3.

>=20
> > @@ -3718,6 +3725,7 @@ static const struct nfsd4_operation nfsd4_ops[] =
=3D {
> >  	},
> >  	[OP_OPEN] =3D {
> >  		.op_func =3D nfsd4_open,
> > +		.op_release =3D nfsd4_open_release,
> >  		.op_flags =3D OP_HANDLES_WRONGSEC | OP_MODIFIES_SOMETHING,
> >  		.op_name =3D "OP_OPEN",
> >  		.op_rsize_bop =3D nfsd4_open_rsize,
> >=20
> > ---
> > base-commit: 6c0004650ba248a12937ada16f9ba961b35ce2b5
> > change-id: 20260531-nfsd-testing-9122bf51ce95
> >=20
> > Best regards,
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20
> >=20

--=20
Jeff Layton <jlayton@kernel.org>

