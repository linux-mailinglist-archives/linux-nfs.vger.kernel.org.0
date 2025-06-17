Return-Path: <linux-nfs+bounces-12541-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36266ADDB9E
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Jun 2025 20:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA54189930D
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Jun 2025 18:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF9327FB1B;
	Tue, 17 Jun 2025 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sz2VEuJ1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D646627817A;
	Tue, 17 Jun 2025 18:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750185948; cv=none; b=MlCgDC8Uzx9+s8PRAi7nK+szr/bsPuNX0Nm3pZzppE23bzRGaRRpn6S1g6BkkxXaNZWcJNm5/S0DpErIB4pQ4t4ehc4I/buG600MivUCfaQ2+r5fGjZ3IHPLj7sKCOC8xsWbJ2RsCoZHyDOyGxevGGc+eIYUCpXF85QdiNiVgDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750185948; c=relaxed/simple;
	bh=H6RblS2J+vqUPof4s/zsYpMfRSX75gdTkoOssu9sOV4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZPBpuXm+6VQKUuoEuj9GozMM33c5mLXjW+uH4Em9YPtaqZ8rrchQF3wT0CFviFyozP0zxJEh1qOW3rJ1ZQegeUBIcAQQ0KsinpTsL32NZ9ZIM3v7sC8B9rgX5eK87vgrXbfgqVa7rquYIvYqdzFymGrCAxcJg9UWNcdqYm1db/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sz2VEuJ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14CAC4CEF1;
	Tue, 17 Jun 2025 18:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750185948;
	bh=H6RblS2J+vqUPof4s/zsYpMfRSX75gdTkoOssu9sOV4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=sz2VEuJ1I8R4gH+wbhoc5jJY/X6YkFIEqxyY38hfhRJvZdKl60O2LX4qlNV5c294P
	 4Wr9I+nOrTtaYJUr67ZRq3QUd2iwJfTDNAY1iukWKSNJ3waNdDleKCCY86EpTdAEZo
	 n1xvxDk/epR95l1mc6zFJyaNb9nRgZ9AEVZvLmnabZ1xC6KgW/yYog7Lev1GpDG1om
	 UfHtGQIRgGWpuuvpYi127KwRcK1frRk6m5YPfPajDgC4fSdMVCpRJhn+RzdDBAa8fS
	 wQN61zDjGPWVJZrVNzVxKjjQwKqvHC5FaBsKHqSUe1DxiNhyVD+rOfXAXZma5DYrCr
	 3rPLyTV0vM5Mw==
Message-ID: <f2a643c9d9148916fe816958e98ac346f0c14946.camel@kernel.org>
Subject: Re: [PATCH 4/4] nfs: new tracepoint in match_stateid operation
From: Trond Myklebust <trondmy@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Benjamin Coddington
 <bcodding@redhat.com>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 17 Jun 2025 14:45:46 -0400
In-Reply-To: <d19d4a507361dad7d0cde2b94f01faf0fb866676.camel@kernel.org>
References: <20250603-nfs-tracepoints-v1-0-d2615f3bbe6c@kernel.org>
		 <20250603-nfs-tracepoints-v1-4-d2615f3bbe6c@kernel.org>
		 <9BD9513B-972A-4C83-9100-A11F289191E5@redhat.com>
	 <d19d4a507361dad7d0cde2b94f01faf0fb866676.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-06-10 at 09:09 -0400, Jeff Layton wrote:
> On Tue, 2025-06-10 at 09:04 -0400, Benjamin Coddington wrote:
> > On 3 Jun 2025, at 7:42, Jeff Layton wrote:
> >=20
> > > Add new tracepoints in the NFSv4 match_stateid minorversion op
> > > that show
> > > the info in both stateids.
> > >=20
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > > =C2=A0fs/nfs/nfs4proc.c=C2=A0 |=C2=A0 4 ++++
> > > =C2=A0fs/nfs/nfs4trace.h | 56
> > > ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > =C2=A02 files changed, 60 insertions(+)
> > >=20
> > > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > > index
> > > 341740fa293d8fb1cfabe0813c7fcadf04df4f62..80126290589aaccd801c896
> > > 5252523894e37c44a 100644
> > > --- a/fs/nfs/nfs4proc.c
> > > +++ b/fs/nfs/nfs4proc.c
> > > @@ -10680,6 +10680,8 @@ nfs41_free_lock_state(struct nfs_server
> > > *server, struct nfs4_lock_state *lsp)
> > > =C2=A0static bool nfs41_match_stateid(const nfs4_stateid *s1,
> > > =C2=A0		const nfs4_stateid *s2)
> > > =C2=A0{
> > > +	trace_nfs41_match_stateid(s1, s2);
> > > +
> > > =C2=A0	if (s1->type !=3D s2->type)
> > > =C2=A0		return false;
> > >=20
> > > @@ -10697,6 +10699,8 @@ static bool nfs41_match_stateid(const
> > > nfs4_stateid *s1,
> > > =C2=A0static bool nfs4_match_stateid(const nfs4_stateid *s1,
> > > =C2=A0		const nfs4_stateid *s2)
> > > =C2=A0{
> > > +	trace_nfs4_match_stateid(s1, s2);
> > > +
> > > =C2=A0	return nfs4_stateid_match(s1, s2);
> > > =C2=A0}
> > >=20
> > > diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
> > > index
> > > 73a6b60a848066546c2ae98b4982b0ab36bb0f73..9b56ce9f2f3dcb31a3e21d5
> > > 740bcf62aca814214 100644
> > > --- a/fs/nfs/nfs4trace.h
> > > +++ b/fs/nfs/nfs4trace.h
> > > @@ -1497,6 +1497,62 @@
> > > DECLARE_EVENT_CLASS(nfs4_inode_stateid_callback_event,
> > > =C2=A0DEFINE_NFS4_INODE_STATEID_CALLBACK_EVENT(nfs4_cb_recall);
> > > =C2=A0DEFINE_NFS4_INODE_STATEID_CALLBACK_EVENT(nfs4_cb_layoutrecall_f=
i
> > > le);
> > >=20
> > > +#define show_stateid_type(type) \
> > > +	__print_symbolic(type, \
> > > +		{ NFS4_INVALID_STATEID_TYPE, "INVALID" }, \
> > > +		{ NFS4_SPECIAL_STATEID_TYPE, "SPECIAL" }, \
> > > +		{ NFS4_OPEN_STATEID_TYPE, "OPEN" }, \
> > > +		{ NFS4_LOCK_STATEID_TYPE, "LOCK" }, \
> > > +		{ NFS4_DELEGATION_STATEID_TYPE, "DELEGATION" },
> > > \
> > > +		{ NFS4_LAYOUT_STATEID_TYPE, "LAYOUT"
> > > },	\
> > > +		{ NFS4_PNFS_DS_STATEID_TYPE, "PNFS_DS" }, \
> > > +		{ NFS4_REVOKED_STATEID_TYPE, "REVOKED" })
> >=20
> > Let's add NFS4_FREED_STATEID_TYPE at the end here, for after
> > 77be29b7a3f89.
> >=20
> > Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
> >=20
> > Ben
>=20
> Thanks, good catch. I did these patches a while ago and may have
> missed
> some of the more recent changes. Anna, can you fix that up or would
> you
> rather I resend the set?

Can you please just resend?

Thanks!

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

