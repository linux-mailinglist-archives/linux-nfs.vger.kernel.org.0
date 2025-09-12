Return-Path: <linux-nfs+bounces-14375-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F68B552F6
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 17:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97A46BA2F46
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 15:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9AC20E6;
	Fri, 12 Sep 2025 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7iH7Kjq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8841521CA04
	for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689901; cv=none; b=TL6sCnPoeMXI8PBHiD/DPu2HoSxKoovV/hZYx8pqrEHuP6Ki3OE3i4sWg45Q3hLRiMWIFXW/ZLERXurGnKnhbd8MekgpoTzQUyOWjFI81EmH9bxCTyetRmj7ydQv6PwCMtH1bzopTmUULHnn6ORFWcrvIpRxWnf04do6FJ0+VVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689901; c=relaxed/simple;
	bh=7aR28UMywv1eBk/ebnTzIam77yzNl8i6aUrhgJgt7QY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NkMTDhgmkjpiBLDT8kHBAJ2F46/sci7o79JB+7QvXs/blkYLAh23g6LxfH6CFzif1X3ez4aC/rcVPBamhUF54cdEwABwvF+X12/T1lMvugN5NgAc6lpAQhv1g7+6qBeq8KzuAlk2TbpJ8rkCgfr3soJGsOUStbgD/LWtDPHjALA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7iH7Kjq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B461FC4CEF1;
	Fri, 12 Sep 2025 15:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757689901;
	bh=7aR28UMywv1eBk/ebnTzIam77yzNl8i6aUrhgJgt7QY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=I7iH7Kjq1+U7MWTCxeCF7bciU8MiSXmSXh90zWjZUmuhZccDkESJl8c0zQTGWEFvR
	 UCnmJY32wyLErLpVWEc07NmznG5/3vN3tAGBGVnDrIWpvIm075Vr4LOp1TOoeuChde
	 SlHcRsPoe3by6lxUpukf19jdztc3x116NXU5hMsFKr48BhacyOGNo/ROV1ngFqfG+s
	 6w9uLMxOP2jTKKAqjJOupnaY6/j4E+1imPfqbimEfWZHkpUrdmJPU1KwNG4KD4fDn0
	 eJp+fgjK4hOQvDSUcw9YQfZ3uYkMnb8/h5oxpsx7CKiHLkoOygYaWV/jFSRtOA2VpW
	 +vxEwLbgk9B1g==
Message-ID: <831f2ac457624092dcfadcf8b290fc65dc10e563.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSv4: handle ERR_GRACE on delegation recalls
From: Trond Myklebust <trondmy@kernel.org>
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: Olga Kornievskaia <aglo@umich.edu>, anna.schumaker@oracle.com, 
	linux-nfs@vger.kernel.org
Date: Fri, 12 Sep 2025 11:11:39 -0400
In-Reply-To: <CACSpFtC3FbdGS6W6yKKwn+JcFmkSKE8yZRkQzuEWwRjAsZYkWQ@mail.gmail.com>
References: <20250811181848.99275-1-okorniev@redhat.com>
	 <CAN-5tyEmf9HHMuXHDU86Y5FWYZz+ZYFKctmoLaCAB+DZ1zcXSQ@mail.gmail.com>
	 <2b87402379d4c88545dabce30d2877722940f483.camel@kernel.org>
	 <CACSpFtC3FbdGS6W6yKKwn+JcFmkSKE8yZRkQzuEWwRjAsZYkWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-12 at 10:41 -0400, Olga Kornievskaia wrote:
> On Fri, Sep 12, 2025 at 10:29=E2=80=AFAM Trond Myklebust <trondmy@kernel.=
org>
> wrote:
> >=20
> > On Fri, 2025-09-12 at 10:21 -0400, Olga Kornievskaia wrote:
> > > Any comments on or objections to this patch? It does lead to
> > > possible
> > > data corruption.
> > >=20
> >=20
> > Sorry, I think was travelling when you originally sent this patch.
> >=20
> > > On Mon, Aug 11, 2025 at 2:25=E2=80=AFPM Olga Kornievskaia
> > > <okorniev@redhat.com> wrote:
> > > >=20
> > > > RFC7530 states that clients should be prepared for the return
> > > > of
> > > > NFS4ERR_GRACE errors for non-reclaim lock and I/O requests.
> > > >=20
> > > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > > ---
> > > > =C2=A0fs/nfs/nfs4proc.c | 4 ++--
> > > > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > > > index 341740fa293d..fa9b81300604 100644
> > > > --- a/fs/nfs/nfs4proc.c
> > > > +++ b/fs/nfs/nfs4proc.c
> > > > @@ -7867,10 +7867,10 @@ int nfs4_lock_delegation_recall(struct
> > > > file_lock *fl, struct nfs4_state *state,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return err;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 err =3D _nfs4_do_setlk(state, F_SETLK, fl,
> > > > NFS_LOCK_NEW);
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (err !=3D -NFS4ERR_DELAY)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (err !=3D -NFS4ERR_DELAY && err !=3D -
> > > > NFS4ERR_GRACE)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ssleep(1);
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } while (err =3D=3D -NFS4ERR_=
DELAY);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } while (err =3D=3D -NFS4ERR_=
DELAY || err =3D=3D -
> > > > NFSERR_GRACE);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nfs4_handle_deleg=
ation_recall_error(server,
> > > > state,
> > > > stateid, fl, err);
> > > > =C2=A0}
> > > >=20
> > > > --
> > > > 2.47.1
> > > >=20
> > > >=20
> >=20
> > Should the server be sending NFS4ERR_GRACE in this case, though?
> > The
> > client already holds a delegation, so it is clear that other
> > clients
> > cannot reclaim any locks that would conflict.
> >=20
> > ..or is the issue that this could happen before the client has a
> > chance
> > to reclaim the delegation after a reboot?
>=20
To answer my own question here: in that case the server would return
NFS4ERR_BAD_STATEID, and not NFS4ERR_GRACE.

> The scenario was, v4 client had an open file and a lock and upon
> server reboot (during grace) sends the reclaim open, to which the
> server replies with a delegation. How a v3 client comes in and
> requests the same lock. The linux server at this point sends a
> delegation recall to v4 client, the client sends its local lock
> request and gets ERR_GRACE.
>=20
> And the spec explicitly notes as I mention in the commit comment that
> the client is supposed to handle ERR_GRACE for non-reclaim locks.
> Thus
> this patch.
>=20

Sure, however the same spec also says (Section 9.6.2.):

   If the server can reliably determine that granting a non-reclaim
   request will not conflict with reclamation of locks by other clients,
   the NFS4ERR_GRACE error does not have to be returned and the
   non-reclaim client request can be serviced.

The server can definitely reliably determine that is the case here,
since it already granted the delegation to the client.

I'm not saying that the client shouldn't also handle NFS4ERR_GRACE, but
I am stating that the server shouldn't really be putting us in this
situation in the first place.
I'm also saying that if we're going to handle NFS4ERR_GRACE, then we
also need to handle all the other possible errors under a reboot
scenario.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

