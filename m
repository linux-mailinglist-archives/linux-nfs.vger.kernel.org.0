Return-Path: <linux-nfs+bounces-13932-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 313F3B39E3B
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 15:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898D83B6C55
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 13:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640FD31158E;
	Thu, 28 Aug 2025 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUzCfSzY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F30331158A
	for <linux-nfs@vger.kernel.org>; Thu, 28 Aug 2025 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386624; cv=none; b=mG9YIwvugb1iSxViD8Nbc4vO/4ui5LJ8fTzmyYvyHpBrW/FHKD8PwPgQRF8kS8Pp6HDbZ/nXCtKOCkeYV62ojkinoyBI70pv7PS2CnDdJLRl0DHxnP1UlHwE4ITMtO6jG/llRWcWth1fPcSQ2QnvWBgZyZ7yVU9UyoCyFNGSyLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386624; c=relaxed/simple;
	bh=j/QKxJLO3HO0kTrORVGRbVEUUqat0Y64Be2dYZLSmfY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ugn3PPOuJMTQ8q76ZgQCn3wfRBsr5XCPwzSvdgWygXdZHEAbT8hvsNZ1eqgRpAg4ODJAw+75+Y3GytpbuGvHgQ4aG703Av9LScIw6ZGUGa7H8Z8fCu7yzPxudcfGGAPzPgyX+12cP2lQvGQDXKs2SAg6qBigC5sndXmy5Ol+Muk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUzCfSzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7C9C4CEF5;
	Thu, 28 Aug 2025 13:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756386622;
	bh=j/QKxJLO3HO0kTrORVGRbVEUUqat0Y64Be2dYZLSmfY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=gUzCfSzYYsSuDLX6gIyadJaqxrbh3uosHpJ4tbtC85j5SyJ/eg+tSs1wbcZTQ33GQ
	 qixWrtZYeT2OIustjBVrm3DwB4G097VumqM7gnLgGmlGQAoYQpY5MfMUHYDdP394n2
	 Sx2kt4N7SrbOnoQ0FNIZ3nDxuVckFKy+Umhi9VtcRsgYcaVAsT5rWT/bnjp1FWH4YG
	 rAGzWgVQGICQDohqmDVoFdtlE5JngsyD6jeGAt3L9cuT0M3p61zzRxlB6RuDI9bX77
	 SAWq0qo8MYb876cKeMAZX7kMZmRu/6uVdITAut/j3aP5Lrhzdl7mxvbj5H5Cgtg7D5
	 Bqry0n8xJc+iw==
Message-ID: <e954bac8c996015ce93e54731c30d20a4b9c56c7.camel@kernel.org>
Subject: Re: [PATCH] sunrpc: don't fail immediately in
 rpc_wait_bit_killable()
From: Trond Myklebust <trondmy@kernel.org>
To: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>, NeilBrown
	 <neil@brown.name>, Anna Schumaker <anna@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-nfs@vger.kernel.org
Date: Thu, 28 Aug 2025 06:10:21 -0700
In-Reply-To: <b409c469-260e-4bd5-9cf8-49f524f3fd5a@oracle.com>
References: <175563952741.2234665.2783395172093985961@noble.neil.brown.name>
	 <b409c469-260e-4bd5-9cf8-49f524f3fd5a@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-08-28 at 18:12 +0530, Harshvardhan Jha wrote:
> Hi there,
>=20
> On 20/08/25 3:08 AM, NeilBrown wrote:
> > rpc_wait_bit_killable() is called when it is appropriate for a
> > fatal
> > signal to abort the wait.
> >=20
> > If it is called late during process exit after exit_signals() is
> > called
> > (and when PF_EXITING is set), it cannot receive a fatal signal so
> > waiting indefinitely is not safe.
> >=20
> > However aborting immediately, as it currently does, is not ideal as
> > it
> > mean that the related NFS request cannot succeed, even if the
> > network
> > and server are working properly.
> >=20
> > One of the causes of filesystem IO when PF_EXITING is set is
> > acct_process() which may access the process accounting file.=C2=A0 For =
a
> > NFS-root configuration, this can be accessed over NFS.
> >=20
> > In this configuration LTP test "acct02" fails.
> >=20
> > Though waiting indefinitely is not appropriate, aborting
> > immediately is
> > also not desirable.=C2=A0 This patch aims for a middle ground of waitin=
g
> > at
> > most 5 seconds.=C2=A0 This should be enough when NFS service is working=
,
> > but
> > not so much as to delay process exit excessively when NFS service
> > is not
> > functioning.
> >=20
> > Reported-by: Mark Brown <broonie@kernel.org>
> > Reported-and-tested-by: Harshvardhan Jha
> > <harshvardhan.j.jha@oracle.com>
> > Link:
> > https://nam10.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Furl=
defense.com%2Fv3%2F__https%3A%2F%2Flore.kernel.org%2Flinux-nfs%2F7d4d57b0-3=
9a3-49f1-8ada-60364743e3b4%40sirena.org.uk%2F__%3B!!ACWV5N9M2RV99hQ!LaRJdjZ=
ulcG71nHFWdEAszB9mJEhezxPsDxHO8xeQJ7P8a9UfYNRIm1ziuuHU5wxgEXW14vAqC1dlpSQra=
WaxA%24&data=3D05%7C02%7Ctrondmy%40hammerspace.com%7C5463825a86c248e5766c08=
dde6306312%7C0d4fed5c3a7046fe9430ece41741f59e%7C0%7C0%7C638919817692991630%=
7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJ=
XaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DGBRM89CFMk2v=
KyeN4yKBvjiV9IrODC4tbwMfRSk4Cfc%3D&reserved=3D0
> > =C2=A0
> > Fixes: 14e41b16e8cb ("SUNRPC: Don't allow waiting for exiting
> > tasks")
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> > =C2=A0net/sunrpc/sched.c | 14 +++++++++-----
> > =C2=A01 file changed, 9 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
> > index 73bc39281ef5..92f39e828fbe 100644
> > --- a/net/sunrpc/sched.c
> > +++ b/net/sunrpc/sched.c
> > @@ -276,11 +276,15 @@ EXPORT_SYMBOL_GPL(rpc_destroy_wait_queue);
> > =C2=A0
> > =C2=A0static int rpc_wait_bit_killable(struct wait_bit_key *key, int
> > mode)
> > =C2=A0{
> > -	if (unlikely(current->flags & PF_EXITING))
> > -		return -EINTR;
> > -	schedule();
> > -	if (signal_pending_state(mode, current))
> > -		return -ERESTARTSYS;
> > +	if (unlikely(current->flags & PF_EXITING)) {
> > +		/* Cannot be killed by a signal, so don't wait
> > indefinitely */
> > +		if (schedule_timeout(5 * HZ) =3D=3D 0)
> > +			return -EINTR;
> > +	} else {
> > +		schedule();
> > +		if (signal_pending_state(mode, current))
> > +			return -ERESTARTSYS;
> > +	}
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> Is it possible to get this merged in 6.17? I have tested this and the
> LTP tests pass

If we are in this situation, it is because some signal has already
killed the parent task. That throws any data integrity guarantees right
out of the window.

So what problem is this patch trying to fix?

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

