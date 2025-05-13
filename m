Return-Path: <linux-nfs+bounces-11690-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E71AB5880
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 17:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255584C1748
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 15:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A474038FA6;
	Tue, 13 May 2025 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+GV21XU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF311D555
	for <linux-nfs@vger.kernel.org>; Tue, 13 May 2025 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149714; cv=none; b=aZhOEJzcb7xJ5rgj7njWwlYYN2lIkPPKLQovP4Ll9lcNKqKzrvMCFlTw2ukMq1/h9/dVtqakglQ3tL8qhuKnEIF8KHFRp9/ljUTv7FSa2I6AbJdYevJxNEdsdEniAAlKaJzJdK3aOw3JWx35wiq7EMXJM0HRW8YXVpnrRnXtT9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149714; c=relaxed/simple;
	bh=GDWdVxl4XV2OklEpECLTro3P3WHYf9/VzENPJKOAeBM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ta658TAGtNO8RSbdW69CokTwYydtC2vJZAaXS9LxupCtkiAEny7miTd/3yDGiOqBhnbBKXu6UZKGbrpNfNmpiLZOf4LsQ8lV/28kCGUtd1szz8PyuOK1Xzwp7W4cWCrivvTQwkq8qRcGJwyjKGxQBajAKbXJUKNnTJttX5I1pX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+GV21XU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA30C4CEE4;
	Tue, 13 May 2025 15:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747149713;
	bh=GDWdVxl4XV2OklEpECLTro3P3WHYf9/VzENPJKOAeBM=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=n+GV21XUrxBg7oOMh+O4ianaJEAGd4CC9Z05D+1nr6OVI5k/e6h7fTobifYBqcctZ
	 HhNrnUWVTHcw7PagtusKDNYHiEERyyf0jC8lEkJkqSCFGer+ihO8GHaKrvJrT5EqwF
	 keSkLAbSc9Becovu+4ukR3LLq15L6EjPgvM2i33EoAhOxapkThx3k61P9NaURgY7uX
	 QJjoC8OtIztFb+1OBQvi25A8/FJvCxV0aJQV21lK5d7+trSmXOTmF1HP1U0qvfNZ53
	 OhHd6JP8g7NcGcufZSJ7iTJt4qu7Mz+xQTCwLamM3Uaw9ufZz0CZ/PYsOU4IiUX5eZ
	 ZEFj+guQ087cw==
Message-ID: <134f83d61bb0ae4a17d7dc3e5727a66f0722dc78.camel@kernel.org>
Subject: Re: [PATCH] NFSv4/pnfs: Reset the layout state after a layoutreturn
From: Jeff Layton <jlayton@kernel.org>
To: Trond Myklebust <trondmy@hammerspace.com>, "osandov@osandov.com"	
 <osandov@osandov.com>, "linux-nfs@vger.kernel.org"
 <linux-nfs@vger.kernel.org>,  "clm@fb.com"	 <clm@fb.com>
Date: Tue, 13 May 2025 11:21:51 -0400
In-Reply-To: <7dfefee0e85b8e2392c57179946d0dd2a075aae7.camel@hammerspace.com>
References: 
	<956259d72ee10ad81fd49daa8f2daf12644dc50f.1746970063.git.trond.myklebust@hammerspace.com>
			 <67c41c84df54b67c0dbbe01dc1076a4070eb5e82.camel@hammerspace.com>
		 <787cefa341d5f75ab6a0ab137089ca3fd12e2ce7.camel@kernel.org>
	 <7dfefee0e85b8e2392c57179946d0dd2a075aae7.camel@hammerspace.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-05-13 at 00:35 +0000, Trond Myklebust wrote:
> On Mon, 2025-05-12 at 13:59 -0500, Jeff Layton wrote:
> > On Sun, 2025-05-11 at 13:48 +0000, Trond Myklebust wrote:
> > > Hi Jeff and Omar,
> > >=20
> > > On Sun, 2025-05-11 at 09:28 -0400, trondmy@kernel.org=C2=A0wrote:
> > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > >=20
> > > > If there are still layout segments in the layout plh_return_lsegs
> > > > list
> > > > after a layout return, we should be resetting the state to ensure
> > > > they
> > > > eventually get returned as well.
> > > >=20
> > > > Fixes: 68f744797edd ("pNFS: Do not free layout segments that are
> > > > marked for return")
> > > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > ---
> > > > =C2=A0fs/nfs/pnfs.c | 9 +++++++++
> > > > =C2=A01 file changed, 9 insertions(+)
> > > >=20
> > > > diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
> > > > index 10fdd065a61c..fc7c5fb10198 100644
> > > > --- a/fs/nfs/pnfs.c
> > > > +++ b/fs/nfs/pnfs.c
> > > > @@ -745,6 +745,14 @@ pnfs_mark_matching_lsegs_invalid(struct
> > > > pnfs_layout_hdr *lo,
> > > > =C2=A0 return remaining;
> > > > =C2=A0}
> > > > =C2=A0
> > > > +static void pnfs_reset_return_info(struct pnfs_layout_hdr *lo)
> > > > +{
> > > > + struct pnfs_layout_segment *lseg;
> > > > +
> > > > + list_for_each_entry(lseg, &lo->plh_return_segs, pls_list)
> > > > + pnfs_set_plh_return_info(lo, lseg->pls_range.iomode, 0);
> > > > +}
> > > > +
> > > > =C2=A0static void
> > > > =C2=A0pnfs_free_returned_lsegs(struct pnfs_layout_hdr *lo,
> > > > =C2=A0 struct list_head *free_me,
> > > > @@ -1292,6 +1300,7 @@ void pnfs_layoutreturn_free_lsegs(struct
> > > > pnfs_layout_hdr *lo,
> > > > =C2=A0 pnfs_mark_matching_lsegs_invalid(lo, &freeme, range, seq);
> > > > =C2=A0 pnfs_free_returned_lsegs(lo, &freeme, range, seq);
> > > > =C2=A0 pnfs_set_layout_stateid(lo, stateid, NULL, true);
> > > > + pnfs_reset_return_info(lo);
> > > > =C2=A0 } else
> > > > =C2=A0 pnfs_mark_layout_stateid_invalid(lo, &freeme);
> > > > =C2=A0out_unlock:
> > >=20
> > > Could the above bug perhaps explain the issue with leaked layout
> > > segments that you were seeing?
> > > If the client doesn't set NFS_LAYOUT_RETURN_REQUESTED, and the
> > > server
> > > is unable to recall the layout due to the network getting shut
> > > down,
> > > then it seems to me that these layout segments just disappear down
> > > a
> > > black hole.
> > >=20
> > > IOW: the scenario is something like this:
> > > =C2=A0* The client holds a read and a read/write layout.
> > > =C2=A0* The server recalls the read layout.
> > > =C2=A0* The client closes the file while the recall is being processe=
d,
> > > so
> > > =C2=A0=C2=A0 that the read and read/write layout segments are both pu=
t on the
> > > =C2=A0=C2=A0 plh_return_segs list.
> > > =C2=A0* The client returns the read layout, and clears the associated
> > > read
> > > =C2=A0=C2=A0 layout segments. The read/write layout segments are stil=
l on the
> > > =C2=A0=C2=A0 list, but without NFS_LAYOUT_RETURN_REQUESTED being set.
> > >=20
> >=20
> > Maybe?
> >=20
> > The problem I think we hit was that pnfs_put_layout_hdr() got called
> > and its refcount went to zero while there were still entries on
> > plh_return_segs.
> >=20
> > pnfs_put_layout_hdr() calls pnfs_layoutreturn_before_put_layout_hdr()
> > as its "last ditch" effort to clean out the plh_return_segs list. It
> > looks like your patch will ensure NFS_LAYOUT_RETURN_REQUESTED is set
> > on
> > all of those entries, but if that flag gets set during the
> > pnfs_layoutreturn_before_put_layout_hdr() call, then I think it may
> > be
> > too late and they'll just leak anyway.
> >=20
> > So I guess the question is: is every entry on plh_return_segs
> > guaranteed to get a first attempt at a LAYOUTRETURN before
> > pnfs_layoutreturn_before_put_layout_hdr() is called?
> >=20
> > If so, then yes that should fix it. If not, then I think it may not
> > (unless I'm misunderstanding this code).
>=20
> So, the point is that pnfs_layoutreturn_before_put_layout_hdr() will
> take a reference to the layout (in pnfs_prepare_layoutreturn()) before
> it kicks off the layoutreturn RPC call. Upon finishing the
> layoutreturn, the nfs4_layoutreturn_release() callback will then
> trigger another layoutreturn attempt when it calls
> pnfs_put_layout_hdr(), assuming that NFS_LAYOUT_RETURN_REQUESTED was
> set by pnfs_layoutreturn_free_lsegs()->pnfs_reset_return_info().
>=20

Oh lovely. I missed that detail. So the thing that puts a reference to
the layout_hdr will _itself_ take and put an extra reference. I guess
the extra put happens in another context though so you don't need to
worry about recursion.

So yeah, that probably will fix the problem Omar found. I'll see about
spinning up a kernel internally that we can test.

Thanks!
--=20
Jeff Layton <jlayton@kernel.org>

