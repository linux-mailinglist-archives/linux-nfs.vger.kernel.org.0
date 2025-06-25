Return-Path: <linux-nfs+bounces-12791-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0894FAE8EDA
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 21:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5297317CEF7
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 19:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49211263889;
	Wed, 25 Jun 2025 19:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwN27D/o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246C63FD1
	for <linux-nfs@vger.kernel.org>; Wed, 25 Jun 2025 19:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750880358; cv=none; b=FBzPBrbSy3gk+mq3ak+C0EOzWxyC0tY5UcgzGySBwp4gMc5bgJWo6qaXPZofRAw9c6cgvGhFzvUNBTEKDXGP5cXdtVpF5fCxG7iCPJTgVxPdHMLFA/kg5Szd1U6mRg/bFgHMtjzRg2FB338EftQLDY4feyn+0RL54iXqhODMCa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750880358; c=relaxed/simple;
	bh=aytk14BvTjJH9AU5LzS5WT5rk2oe2aBwVPUuM7XfLUY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GvH1MulloKDH9tKDWrKJH50No1OoZkdiHm3NDGxTdqOA4HSOsvA//kk4jEVswPwq3XfbFvQT9K0f8hfJuscohpOYvGhF9Y4OaJBwaOfIeKvOD1h2f3QfZokgrAINZhAS42m6V5aqkyzc6Q7LUQvzzoDo/Y7TYj+5xRZr1Y21qA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwN27D/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB53C4CEEA;
	Wed, 25 Jun 2025 19:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750880357;
	bh=aytk14BvTjJH9AU5LzS5WT5rk2oe2aBwVPUuM7XfLUY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=mwN27D/oJoL23dzCqaYANrth80N8W0tgQYuUKR5qzQNf4x+xFuitRyhqiRQHLHkD4
	 rPcMb2fAbxs3Jq12IU0SvULHDAkjbeG+8twFF5SLFYmeuXZ0a837B2MJ4BBS5RxD4t
	 Y1TVW92wz/jM5ehfbAlBb2UxcwoLDJL2GzSFZGcWqD4vOKWIzOl2C22cbcvD2N8c6n
	 24hoiPjV6SZCwrf3yXEBMHibYFRsgtr+jN9zvxm62nYgiNcsKhvDBhhQFNpJD60QHm
	 ES4FYFhrF/DIGT96GR8MHp0vA3PkvzrmF9FGxG0Kj1i9Dyb/ZQOZVnmTF5oXI97RBU
	 LYXUtwbClVJJg==
Message-ID: <e2a8b1e647e9d5f74e0ab5dd0924495625a02d3f.camel@kernel.org>
Subject: Re: [PATCH 1/1] pNFS/flexfiles: mark device unavailable on fatal
 connection error
From: Trond Myklebust <trondmy@kernel.org>
To: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>, linux-nfs
	 <linux-nfs@vger.kernel.org>
Cc: Anna Schumaker <anna@kernel.org>
Date: Wed, 25 Jun 2025 15:39:15 -0400
In-Reply-To: <1758012324.14467514.1750879171477.JavaMail.zimbra@desy.de>
References: <20250609214303.816241-1-tigran.mkrtchyan@desy.de>
	 <20250609214303.816241-2-tigran.mkrtchyan@desy.de>
	 <1758012324.14467514.1750879171477.JavaMail.zimbra@desy.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-25 at 21:19 +0200, Mkrtchyan, Tigran wrote:
>=20
> Hi Folks,
>=20
> Do you have any opinion on this one? Would you like me to address it
> differently?
>=20

I don't think we should mark the device as being unavailable just
because someone signalled the RPC task.

It would be better to have nfs4_ff_layout_prepare_ds() return any fatal
errors that it encounters using ERR_PTR(), so that the callers can
handle them. Then maybe return ERR_PTR(-EAGAIN) for the case where we
currently return NULL so that those callers don't have to use the hated
IS_ERR_OR_NULL() test.

> Tigran.=20
>=20
> ----- Original Message -----
> > From: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> > To: "linux-nfs" <linux-nfs@vger.kernel.org>
> > Cc: "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker"
> > <anna@kernel.org>, "Tigran Mkrtchyan"
> > <tigran.mkrtchyan@desy.de>
> > Sent: Monday, 9 June, 2025 23:43:03
> > Subject: [PATCH 1/1] pNFS/flexfiles: mark device unavailable on
> > fatal connection error
>=20
> > Fixes: 260f32adb88 ("pNFS/flexfiles: Check the result of
> > nfs4_pnfs_ds_connect")
> >=20
> > When an applications get killed (SIGTERM/SIGINT) while pNFS client
> > performs a
> > connection
> > to DS, client ends in an infinite loop of connect-disconnect. This
> > source of the issue, it that
> > flexfilelayoutdev#nfs4_ff_layout_prepare_ds gets an
> > error
> > on nfs4_pnfs_ds_connect with status ERESTARTSYS, which is set by
> > rpc_signal_task, but
> > the error is treated as transient, thus retried.
> >=20
> > The issue is reproducible with script as (there should be ~1000
> > files in
> > a directory, client should must not have any connections to DSes):
> >=20
> > ```
> > echo 3 > /proc/sys/vm/drop_caches
> >=20
> > for i in *
> > do
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 head -1 $i &
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PP=3D$!
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sleep 10e-03
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kill -TERM $PP
> > done
> > ```
> >=20
> > Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
> > ---
> > fs/nfs/flexfilelayout/flexfilelayoutdev.c | 4 ++++
> > 1 file changed, 4 insertions(+)
> >=20
> > diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> > b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> > index 4a304cf17c4b..0008a8180c9b 100644
> > --- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> > +++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> > @@ -410,6 +410,10 @@ nfs4_ff_layout_prepare_ds(struct
> > pnfs_layout_segment *lseg,
> > 			mirror->mirror_ds->ds_versions[0].wsize =3D
> > max_payload;
> > 		goto out;
> > 	}
> > +	/* There is a fatal error to connect to DS. Mark it
> > unavailable to avoid
> > infinite retry loop. */
> > +	if (nfs_error_is_fatal(status))
> > +		nfs4_mark_deviceid_unavailable(&mirror->mirror_ds-
> > >id_node);
> > +
> > noconnect:
> > 	ff_layout_track_ds_error(FF_LAYOUT_FROM_HDR(lseg-
> > >pls_layout),
> > 				 mirror, lseg->pls_range.offset,
> > --
> > 2.49.0

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

