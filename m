Return-Path: <linux-nfs+bounces-9589-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD0DA1B962
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 16:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29791633E3
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 15:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91893155759;
	Fri, 24 Jan 2025 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+KyVJFc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645BA130A73;
	Fri, 24 Jan 2025 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737732688; cv=none; b=duEusmN+L8VJ/SdYFtv9Q3VC34fExRSMQjKlNsJ9Qv1zdjqMPTTEnxas0qqB2qruqthAqQTd9h+M/1Yh7iuxSoTpAs//M+g6fg+qnck4d4uIUKbqWuFjZ3sVLb4Ck/kjhd7XkPPqSZcld9pItUxmQbgvxOtdj2F++yeD+WCMKZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737732688; c=relaxed/simple;
	bh=vRsaEGdvkciLVRLRkt4MCf69aBeLvA7Pj7RCbgHp9hY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UGM1Gu1qZfT6DirYYeG6LLank0xJOlVB5Q5JCrHpbFbCWKiynkryUWysdpx7FuLqXrb3zVxavSvuLKBdnygSqXM3y9PjwUOVlEWwvCRodiBxEhnbYsP6YLwauxBr/Cdah73rahdKh+4K+ZSVDs6UjypT39vk3ANqGJSfRQEqkls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+KyVJFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A52BC4CED2;
	Fri, 24 Jan 2025 15:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737732687;
	bh=vRsaEGdvkciLVRLRkt4MCf69aBeLvA7Pj7RCbgHp9hY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=a+KyVJFcfcd4VUir9MGc6qdsOkLyk4dwrssAfs1D/6qD+58OK+aWb1k+VON6QLnnf
	 2UCxDOB+0tuURT2XujX6+PCGsntMwHLhed1HYY4WFW+BHb22dT3vW3f6GyXfhc7V28
	 0BaM5/mDTpoiEGZotC1UofruHLCGuW3AcyZWJLVpoHIyEXIpT4hVdvWmYxDOlpn9Zy
	 bqp/R47+WNSn/tFw12LlbVHcEynTWK3NugD0bH/4BA32uOWnQDKN8yE3w1IIb0DhsQ
	 EviDbRx3/lnsyuMVbIjLaAHPVqL0PEGjnBWmlboafawrMQ5dv9YfnYJnnIGe+IAZN6
	 s/stR17LsdL9A==
Message-ID: <39a9a8e714b0cdf728080862a5fe69bbc617361e.camel@kernel.org>
Subject: Re: [PATCH 7/8] nfsd: clean up and amend comments around
 nfsd4_cb_sequence_done()
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, Kinglong
 Mee <kinglongmee@gmail.com>, Trond Myklebust	 <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>, "David S. Miller"	 <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski	 <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman	 <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Date: Fri, 24 Jan 2025 10:31:25 -0500
In-Reply-To: <1f967fd7-17b6-402e-ac55-aba956ba0d65@oracle.com>
References: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
	 <20250123-nfsd-6-14-v1-7-c1137a4fa2ae@kernel.org>
	 <8a6e1930-feee-47f8-8260-874b9c47f20e@oracle.com>
	 <42ef9ff65c27fb7347f72e85b583ff74b2200bd6.camel@kernel.org>
	 <1f967fd7-17b6-402e-ac55-aba956ba0d65@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-24 at 10:05 -0500, Chuck Lever wrote:
> On 1/24/25 9:50 AM, Jeff Layton wrote:
> > On Fri, 2025-01-24 at 09:43 -0500, Chuck Lever wrote:
> > > On 1/23/25 3:25 PM, Jeff Layton wrote:
> > > > Add a new kerneldoc header, and clean up the comments a bit.
> > >=20
> > > Usually I'm in favor of kdoc headers, but here, it's a static functio=
n
> > > whose address is not shared outside of this source file. The only
> > > documentation need is the meaning of the return code, IMO.
> > >=20
> >=20
> > If you like. I figured it wouldn't hurt to do a full kdoc comment.
>=20
> Kdoc comments are pretty noisy. This one doesn't seem to me to add
> much real value -- its callers are all right here in the same file.
>=20
>=20
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >    fs/nfsd/nfs4callback.c | 26 ++++++++++++++++++++------
> > > >    1 file changed, 20 insertions(+), 6 deletions(-)
> > > >=20
> > > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > > > index 6e0561f3b21bd850b0387b5af7084eb05e818231..415fc8aae0f47c36f00=
b2384805c7a996fb1feb0 100644
> > > > --- a/fs/nfsd/nfs4callback.c
> > > > +++ b/fs/nfsd/nfs4callback.c
> > > > @@ -1325,6 +1325,17 @@ static void nfsd4_cb_prepare(struct rpc_task=
 *task, void *calldata)
> > > >    	rpc_call_start(task);
> > > >    }
> > > >   =20
> > > > +/**
> > > > + * nfsd4_cb_sequence_done - process the result of a CB_SEQUENCE
> > > > + * @task: rpc_task
> > > > + * @cb: nfsd4_callback for this call
> > > > + *
> > > > + * For minorversion 0, there is no CB_SEQUENCE. Only restart the c=
all
> > > > + * if the callback RPC client was killed. For v4.1+ the error hand=
ling
> > > > + * is more sophisticated.
> > >=20
> > > It would be much clearer to pull the 4.0 error handling out of this
> > > function, which is named "cb_/sequence/_done".
> > >=20
> > > Perhaps the need_restart label can be hoisted into nfsd4_cb_done() ?
> > >=20
> >=20
> > If we do that then we'll need to change this function to return
> > something other than a bool, and that's a larger change than I wanted
> > to make here. I really wanted to keep these as small, targeted patches
> > that can be backported easily.
> >=20
> > I wouldn't object to further cleanup here on top of that though.
>=20
> There's no reason to document the 4.0 logic if it's about to be moved
> out. I strongly prefer making the code more self-documenting. Adding
> a comment here about 4.0 then adding a patch on top moving the code
> somewhere else seems silly to me.
>=20

Ok.

>=20
> > > > + *
> > > > + * Returns true if reply processing should continue.
> > > > + */
> > > >    static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct=
 nfsd4_callback *cb)
> > > >    {
> > > >    	struct nfs4_client *clp =3D cb->cb_clp;
> > > > @@ -1334,11 +1345,11 @@ static bool nfsd4_cb_sequence_done(struct r=
pc_task *task, struct nfsd4_callback
> > > >    	if (!clp->cl_minorversion) {
> > > >    		/*
> > > >    		 * If the backchannel connection was shut down while this
> > > > -		 * task was queued, we need to resubmit it after setting up
> > > > -		 * a new backchannel connection.
> > > > +		 * task was queued, resubmit it after setting up a new
> > > > +		 * backchannel connection.
> > > >    		 *
> > > > -		 * Note that if we lost our callback connection permanently
> > > > -		 * the submission code will error out, so we don't need to
> > > > +		 * Note that if the callback connection is permanently lost,
> > > > +		 * the submission code will error out. There is no need to
> > > >    		 * handle that case here.
> > > >    		 */
> > > >    		if (RPC_SIGNALLED(task))
> > > > @@ -1355,8 +1366,6 @@ static bool nfsd4_cb_sequence_done(struct rpc=
_task *task, struct nfsd4_callback
> > > >    	switch (cb->cb_seq_status) {
> > > >    	case 0:
> > > >    		/*
> > > > -		 * No need for lock, access serialized in nfsd4_cb_prepare
> > > > -		 *
> > > >    		 * RFC5661 20.9.3
> > > >    		 * If CB_SEQUENCE returns an error, then the state of the slot
> > > >    		 * (sequence ID, cached reply) MUST NOT change.
> > > > @@ -1365,6 +1374,11 @@ static bool nfsd4_cb_sequence_done(struct rp=
c_task *task, struct nfsd4_callback
> > > >    		ret =3D true;
> > > >    		break;
> > > >    	case -ESERVERFAULT:
> > > > +		/*
> > > > +		 * Client returned NFS4_OK, but decoding failed. Mark the
> > > > +		 * backchannel as faulty, but don't retransmit since the
> > > > +		 * call was successful.
> > > > +		 */
> > > >    		++session->se_cb_seq_nr[cb->cb_held_slot];
> > > >    		nfsd4_mark_cb_fault(cb->cb_clp);
> > > >    		break;
> > >=20
> > > This old code abuses the meaning of ESERVERFAULT IMO. NFS4ERR_BADXDR =
is
> > > a better choice. But why call mark_cb_fault in this case?
> > >=20

I can fix that up. BADXDR is more descriptive.

> > > Maybe split this clean-up into a separate patch.
> > >=20
> > >=20
> >=20
> > I'm only altering comments in this patch. Do you really want separate
> > patches for the different comments?
>=20
> Why call mark_cb_fault here? If NFSD retransmits this operation on a
> fresh session/transport it will just fail to decode the reply again.
>=20
> Do we believe that the decoding failure means there was a transport
> problem of some kind?
>=20
> It's clear we do not understand this code well enough to update the
> existing comment, so my review comment above suggests a broader code
> change is necessary.
>=20
>=20

It won't be retransmitted in the ESERVERFAULT case. It just fails.

I can't speak definitively, but my guess is that this is an
extraordinary situation and the author (Kinglong Mee?) figured "might
as well mark the cb faulty too". I don't think that's necessarily
unreasonable, but I agree that it's unlikely to help.

Unfortunately as the server in this situation, our options for alerting
about callback problems are limited. Marking the CB channel as faulty
isn't a great response, but it is at least something. The problem here
is that these are callbacks, and if they fail, there is zero indication
that there is a problem.

Stepping back, when we do find failing callbacks, should we be doing
more to alert the admin? What would be an appropriate response?
Ratelimited pr_notice()? Conditional tracepoints? Something else?
--=20
Jeff Layton <jlayton@kernel.org>

