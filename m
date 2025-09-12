Return-Path: <linux-nfs+bounces-14373-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD30B551C8
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 16:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A017A1891E97
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 14:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870C130DEA5;
	Fri, 12 Sep 2025 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbrXks6w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C6A3054F4
	for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687351; cv=none; b=qLsgXTqFcat4mGsvIPKpKaMZS40VNlU7LJBOfyJ2AWtGVaO+YBtjkHP0MRrXVcKVDPTJgUThcE23RW+GDqUDkP0IYTtUcw2HxvDnzM5l/vamZNr8LdODJEdgRY4+BggLv/xkB2Rd7FQ5E+lV3k/tpuvcr8VuvYIHAhhU9zh/CCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687351; c=relaxed/simple;
	bh=nWhqrqwAMJh6UcjjkVuBtSzWLVGffFoCfQ30CwnnYpw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fbxu536P4S3TSHL2huhciFzw/sPf0GHMLM5DsgJIwr7224hHfDs2mwm174FQfDdAGpXFMYjIZmWU2CNCBaiWGn2HRK5dgBmqKWP18WMmS9DNE1niqyTPzWOP5tHJNovJ80HpqOeRda7TKYexMf5nDNjcWt9k3s6Q5dCSkQpDc2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbrXks6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D7EC4CEF1;
	Fri, 12 Sep 2025 14:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757687351;
	bh=nWhqrqwAMJh6UcjjkVuBtSzWLVGffFoCfQ30CwnnYpw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=qbrXks6wxuBaoNOyzEIqWjjHNmZEeHpsnX+Q/SfISnHjSMHUJz0/7JHV+CTGhLlcA
	 Ugfeqqa+JZxby8Ccl112hQYvozCMQ7C2MAJuYE3PxBKhuQhGfwmE3Fe2n+yC2VPFoT
	 VasgWhxMH1HF+jEkotO9FJ+0xy0clzNu/36LgobcSYGdjmNrai6w1zFAHq7L35T9SD
	 4UqvEvpkyWolb2ijBJNyy6ozIULpmbHztZKvTCb/yTFD0I9XKv8/cLEqJ3bgP5kuWV
	 zuXQabIa8rV49JgB6MdeeLfhPRZ+LW4v9GrekIJzgujPSGgrSwhKCh+FdFvJL+Emd4
	 AhrIcT4emc10g==
Message-ID: <2b87402379d4c88545dabce30d2877722940f483.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSv4: handle ERR_GRACE on delegation recalls
From: Trond Myklebust <trondmy@kernel.org>
To: Olga Kornievskaia <aglo@umich.edu>, Olga Kornievskaia
 <okorniev@redhat.com>
Cc: anna.schumaker@oracle.com, linux-nfs@vger.kernel.org
Date: Fri, 12 Sep 2025 10:29:09 -0400
In-Reply-To: <CAN-5tyEmf9HHMuXHDU86Y5FWYZz+ZYFKctmoLaCAB+DZ1zcXSQ@mail.gmail.com>
References: <20250811181848.99275-1-okorniev@redhat.com>
	 <CAN-5tyEmf9HHMuXHDU86Y5FWYZz+ZYFKctmoLaCAB+DZ1zcXSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-12 at 10:21 -0400, Olga Kornievskaia wrote:
> Any comments on or objections to this patch? It does lead to possible
> data corruption.
>=20

Sorry, I think was travelling when you originally sent this patch.

> On Mon, Aug 11, 2025 at 2:25=E2=80=AFPM Olga Kornievskaia
> <okorniev@redhat.com> wrote:
> >=20
> > RFC7530 states that clients should be prepared for the return of
> > NFS4ERR_GRACE errors for non-reclaim lock and I/O requests.
> >=20
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> > =C2=A0fs/nfs/nfs4proc.c | 4 ++--
> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 341740fa293d..fa9b81300604 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -7867,10 +7867,10 @@ int nfs4_lock_delegation_recall(struct
> > file_lock *fl, struct nfs4_state *state,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return err;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 err =3D _nfs4_do_setlk(state, F_SETLK, fl,
> > NFS_LOCK_NEW);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (err !=3D -NFS4ERR_DELAY)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (err !=3D -NFS4ERR_DELAY && err !=3D -NFS4ERR_GRACE)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break=
;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ssleep(1);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } while (err =3D=3D -NFS4ERR_DELA=
Y);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } while (err =3D=3D -NFS4ERR_DELA=
Y || err =3D=3D -NFSERR_GRACE);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nfs4_handle_delegatio=
n_recall_error(server, state,
> > stateid, fl, err);
> > =C2=A0}
> >=20
> > --
> > 2.47.1
> >=20
> >=20

Should the server be sending NFS4ERR_GRACE in this case, though? The
client already holds a delegation, so it is clear that other clients
cannot reclaim any locks that would conflict.

..or is the issue that this could happen before the client has a chance
to reclaim the delegation after a reboot?

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

