Return-Path: <linux-nfs+bounces-14089-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FF6B463C3
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 21:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8E05C3E5B
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 19:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CEC280330;
	Fri,  5 Sep 2025 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwiSl4Pp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A3F221577
	for <linux-nfs@vger.kernel.org>; Fri,  5 Sep 2025 19:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757101096; cv=none; b=L/r1FtokFUtrqFce3a3s8nfQDIfTsjSq+GU9uFNDScsAOhnBCt/qqkaPFOkz/QAk0vsGrGLTFP3qWm6e9CxxMHtYU871jdYPdVDXckQ+WLcDn4+F8C/XIzQakL5hPpfVQNbtETfSBuZPdM3aOYJsN7XFiXWgbZoP5guCjzEOL7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757101096; c=relaxed/simple;
	bh=M9jN6tRR0JiYb9F0JyMZHobW/5Rh1Pxb7EN7yG19tnQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=McZ58HtuKaTfEtsUTYk/ql+ISPJ3AgzdG+CX0LtJdxgN8KRT8eg39wcTR8E0ry9R0BX4n+xzAR9OHoAcgDfX5ZaD2KG26Pun813leREgNm3IssSBykWFqZCA6aDZTTbggdud/UCwxpsOBDD6mBjHpCC2shf0H19OKbXIQTwQc94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwiSl4Pp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFA2C4CEF1;
	Fri,  5 Sep 2025 19:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757101095;
	bh=M9jN6tRR0JiYb9F0JyMZHobW/5Rh1Pxb7EN7yG19tnQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VwiSl4Pphc/SexMSyghW+8bVMO42NoA6U+53EkW3VQXAHCgizYSGm5zUNuKwyNgSx
	 rDemT0PHt6y3jhJK9ZY3k0z2gJcaTz03DOixIVuQMK50QPDGFo6jCr1EnMezGjTG9M
	 Zh4f+bxosfmtuR00wlRHaS3FPFnc7/XP57bFnvLFqVDjikyhDVxFMxXY2Imq8+8oAk
	 fbTo4vxMkoewVErVVFeroNqO8dEX/lzMedt1oDMrj3mH01RiWEAdz06dSsi14i0T3e
	 h+yWWt7UQwUDfX8dyOEmmJ3Kpfwh9X3O0ni8J2d+34tDRKssicyoCOrX4jMvD3Q6EF
	 m2FGxH0MblEHw==
Message-ID: <3e558c7f675b1f2e87098e58ef06c6f45ecf0a58.camel@kernel.org>
Subject: Re: [PATCH] sunrpc: don't fail immediately in
 rpc_wait_bit_killable()
From: Trond Myklebust <trondmy@kernel.org>
To: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>, NeilBrown
	 <neil@brown.name>, Anna Schumaker <anna@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-nfs@vger.kernel.org
Date: Fri, 05 Sep 2025 15:38:14 -0400
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
> > https://urldefense.com/v3/__https://lore.kernel.org/linux-nfs/7d4d57b0-=
39a3-49f1-8ada-60364743e3b4@sirena.org.uk/__;!!ACWV5N9M2RV99hQ!LaRJdjZulcG7=
1nHFWdEAszB9mJEhezxPsDxHO8xeQJ7P8a9UfYNRIm1ziuuHU5wxgEXW14vAqC1dlpSQraWaxA$
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
> LTP tests pass.

After much thought, I think I'd rather just revert the commit that
caused the issue. I'll work on an alternative for the 6.18 timeframe
instead.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

