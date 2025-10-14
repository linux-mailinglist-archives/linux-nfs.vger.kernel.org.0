Return-Path: <linux-nfs+bounces-15256-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD49BBDBB48
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Oct 2025 00:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A5B189C43E
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 22:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C925717A2EA;
	Tue, 14 Oct 2025 22:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="UrC1xyvc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iFuaVP/e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0771C5D59
	for <linux-nfs@vger.kernel.org>; Tue, 14 Oct 2025 22:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760482150; cv=none; b=rFIMJlIb9uPpHpy2mGi8CbGOcyGtwfDdaZ81xPJzYHGz5iSVvkmZQWDRA6R0cPdKbD/oRjPhei/T+AHQZuwszKLCVIjBc1QbjDfxPrUmjm8/Zhdl4v7XYqqLspGKdVuTA+WlBiu6w8nIYW/bikw/mQyJF7UqPDHMIWSYEWES/ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760482150; c=relaxed/simple;
	bh=P3mD7kmK+hw6HlxblV63CJgvoNKQCnfpm0Mpz8DEK10=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=oJ3yQkOLYms8lbxidMIqBLJNCxnpkG2+38/f0r4QHJ3Lz9wsm8uBYhDt7fGA0ZSdsarbI3RTSJEfNj1GHAx73qy/ifBQk6oGtgPcXXE8smY1rIY4mktuYXyq7Ry9QSWfe2EGXqfBGJp+j2nUoK0oSdE2MKx1qP0yTh3BieQhSQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=UrC1xyvc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iFuaVP/e; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 58E8B1D00069;
	Tue, 14 Oct 2025 18:49:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 14 Oct 2025 18:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760482145; x=1760568545; bh=MxXlbSMmVP2xUfmt/+wRwGzYg4X7XT7Alby
	mLf5wA9A=; b=UrC1xyvccY0R0HXsgBYLBObguqUrvYbJuIFuyEdwnK/KcvQCe3y
	QMTrh0jKJRm/7SS44Bd8axT9jl4ULjERYMNjwkq03C7nI2TW21ABkPa02MB+mb4H
	5CI48I/tFReVoPoMDpNW+C1z9g0/ljA7hpJQDtVhmx69RpynKKHh1rVD0g0C0/Hp
	u8TZW4s7v1dq0AxbO5G65+4osDRxM4Av/LSmFEUiorZxjzRTUEvROqJBgsQx0lWZ
	LaVRek+rKy8fXPl4v+v0Ndi8z/Fvhpnw/Joen9+y7UZb5Zyb2iaNeJ1ul7bqY+iu
	ipQUUQrX772Llx6j6w+UmMuFNdg2GwX+Afg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760482145; x=
	1760568545; bh=MxXlbSMmVP2xUfmt/+wRwGzYg4X7XT7AlbymLf5wA9A=; b=i
	FuaVP/ep9NJCtwpe0j5sPadlmwv4qsK0kl29Sb3imy7u3jVnYnWvEvPq+VfETH0R
	bJVSBGK3hrUu+JbEbAJXzB846TQdFBvtscFeSNYvgXchB/uBcQyrzN1KOkveuys8
	OoowodXrKe6ILbHOkr2yvtUVnEP3s43Dlj/yWzhAd2nXzp6r/fswJhn+melwEkvp
	W4VgCllF7zSrb8Ce2Anx+tlaHUzXm48rlUsLDEcLEVDr4chvtqYkT6jiNPkfQINI
	tAAU8fTTHKZcH1DMfhYf1CFJhe6hyyT9PeSILVYefTrOGd0i7sQURG7z3qQzxwZe
	e3KcRFQQgwtVfhQs1Qfyw==
X-ME-Sender: <xms:YNPuaKdQJaB7Sd1lNJ2nlx1pGT0SoTbN-TFIwLFzzEcBxWk9203-IQ>
    <xme:YNPuaGdlG-F65KlFl3vhvyABO3ykoqpAU_63cVbu7MN66jWIjEBqnB7WcBOhQz8OJ
    D9dvoGQ1hjX-eydfO12vdLPuoWKsYAkl_qmWp-HlG3sf0NJ>
X-ME-Received: <xmr:YNPuaNyS_C2N7yofTPMRqd4TwWtz2nlgaRilDA7PVFXIKKPQwUd5XqNc7ZXIrc2z7SsDFbrUo2aUEvx_UXFO9-LHsMfi_Jqpt_TUMsBBwub4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddujeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegrghhlohesuhhmihgthhdrvgguuhdprhgtphhtthhopehtohhmseht
    rghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghp
    thhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepjhhlrgihth
    honheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YNPuaN-d-znwNJV7POdJsHG7LbDbXwpATaSwWNm_xQFnPsdL3Dk96w>
    <xmx:YNPuaFhmQfOSL7xNlAbY_0MS8AaCa-2ZTi8GlNrua54PF4g2O1AfsQ>
    <xmx:YNPuaEEDOVAy8v4TA3X0rHuXXVAiQpX_xUUwljI5U_wPaePPdrDCdw>
    <xmx:YNPuaE8k-TL8x4a9J6AB2EaWT9Jrlw-S4NSJ31quF0NIw6dIweEV4g>
    <xmx:YdPuaLE7gbKGZntxNiquSp2v1ftoQMndvcEHrFqA35Z7jWZ4kKrrgZwy>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 18:49:02 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Olga Kornievskaia" <aglo@umich.edu>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] nfsd: ensure SEQUENCE replay sends a valid reply.
In-reply-to:
 <CAN-5tyHB0O-WQdqYDKONQ2unKHV2H1n__SD_qN9XGAYvx6=Apw@mail.gmail.com>
References: <20251014000544.1567520-1-neilb@ownmail.net>,
 <20251014000544.1567520-2-neilb@ownmail.net>,
 <CAN-5tyHB0O-WQdqYDKONQ2unKHV2H1n__SD_qN9XGAYvx6=Apw@mail.gmail.com>
Date: Wed, 15 Oct 2025 09:49:00 +1100
Message-id: <176048214019.1793333.16754785798786583105@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 15 Oct 2025, Olga Kornievskaia wrote:
> On Mon, Oct 13, 2025 at 8:06=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrote:
> >
> > From: NeilBrown <neil@brown.name>
> >
> > nfsd4_enc_sequence_replay() uses nfsd4_encode_operation() to encode a
> > new SEQUENCE reply when replaying a request from the slot cache - only
> > ops after the SEQUENCE are replay from the cache in ->sl_data.
> >
> > However it does this in nfsd4_replay_cache_entry() which is called
> > *before* nfsd4_sequence() has filled in reply fields.
> >
> > This means that in the replayed SEQUENCE reply:
> >  maxslots will be whatever the client sent
> >  target_maxslots will be -1 (assuming init to zero, and
> >       nfsd4_encode_sequence() subtracts 1)
> >  status_flags will be zero
> >
> > which might mislead the client.
>=20
> This also fixes the problem I described in my proposed patch. I would
> have liked to see a bit more detail mentioning that it leads to the
> client shrinking its slot table and then a hung client due to the
> server's SEQ_MISORDERED error. I think having details in the commit
> message might be useful for later connecting the symptoms to this
> patch.

I had seen that patch of yours but hadn't looked at it properly yet.  I
does indeed address the same problem.  I'll add relevant parts of your
commit message to me next posting.

>=20
> Tested-by: Olga Kornievskaia <okorniev@redhat.com>

Thanks!

NeilBrown

>=20
> > This patch moves the setup of the reply to *before*
> > nfsd4_replay_cache_entry() is called.  Only one of the updated fields is
> > used after this point - maxslots.  So that field is copied to
> > client_maxslots so that can be used as needed.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/nfsd/nfs4state.c | 41 +++++++++++++++++++++++------------------
> >  1 file changed, 23 insertions(+), 18 deletions(-)
> >
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index c9053ef4d79f..1c01836e8507 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -4360,6 +4360,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
> >         struct nfs4_client *clp;
> >         struct nfsd4_slot *slot;
> >         struct nfsd4_conn *conn;
> > +       u32 client_maxslots;
> >         __be32 status;
> >         int buflen;
> >         struct net *net =3D SVC_NET(rqstp);
> > @@ -4398,6 +4399,27 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
> >         dprintk("%s: slotid %d\n", __func__, seq->slotid);
> >
> >         trace_nfsd_slot_seqid_sequence(clp, seq, slot);
> > +
> > +       /* prepare reply so that it is ready for nfsd4_replay_cache_entry=
() */
> > +       client_maxslots =3D seq->maxslots;
> > +       seq->maxslots =3D max(session->se_target_maxslots, client_maxslot=
s);
> > +       seq->target_maxslots =3D session->se_target_maxslots;
> > +
> > +       switch (clp->cl_cb_state) {
> > +       case NFSD4_CB_DOWN:
> > +               seq->status_flags =3D SEQ4_STATUS_CB_PATH_DOWN;
> > +               break;
> > +       case NFSD4_CB_FAULT:
> > +               seq->status_flags =3D SEQ4_STATUS_BACKCHANNEL_FAULT;
> > +               break;
> > +       default:
> > +               seq->status_flags =3D 0;
> > +       }
> > +       if (!list_empty(&clp->cl_revoked))
> > +               seq->status_flags |=3D SEQ4_STATUS_RECALLABLE_STATE_REVOK=
ED;
> > +       if (atomic_read(&clp->cl_admin_revoked))
> > +               seq->status_flags |=3D SEQ4_STATUS_ADMIN_STATE_REVOKED;
> > +
> >         status =3D check_slot_seqid(seq->seqid, slot->sl_seqid, slot->sl_=
flags);
> >         if (status =3D=3D nfserr_replay_cache) {
> >                 status =3D nfserr_seq_misordered;
> > @@ -4425,7 +4447,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
> >
> >         if (session->se_target_maxslots < session->se_fchannel.maxreqs &&
> >             slot->sl_generation =3D=3D session->se_slot_gen &&
> > -           seq->maxslots <=3D session->se_target_maxslots)
> > +           client_maxslots <=3D session->se_target_maxslots)
> >                 /* Client acknowledged our reduce maxreqs */
> >                 free_session_slots(session, session->se_target_maxslots);
> >
> > @@ -4495,23 +4517,6 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
> >         }
> >
> >  out:
> > -       seq->maxslots =3D max(session->se_target_maxslots, seq->maxslots);
> > -       seq->target_maxslots =3D session->se_target_maxslots;
> > -
> > -       switch (clp->cl_cb_state) {
> > -       case NFSD4_CB_DOWN:
> > -               seq->status_flags =3D SEQ4_STATUS_CB_PATH_DOWN;
> > -               break;
> > -       case NFSD4_CB_FAULT:
> > -               seq->status_flags =3D SEQ4_STATUS_BACKCHANNEL_FAULT;
> > -               break;
> > -       default:
> > -               seq->status_flags =3D 0;
> > -       }
> > -       if (!list_empty(&clp->cl_revoked))
> > -               seq->status_flags |=3D SEQ4_STATUS_RECALLABLE_STATE_REVOK=
ED;
> > -       if (atomic_read(&clp->cl_admin_revoked))
> > -               seq->status_flags |=3D SEQ4_STATUS_ADMIN_STATE_REVOKED;
> >         trace_nfsd_seq4_status(rqstp, seq);
> >  out_no_session:
> >         if (conn)
> > --
> > 2.50.0.107.gf914562f5916.dirty
> >
> >
>=20


