Return-Path: <linux-nfs+bounces-15851-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CE7C258FC
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 15:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 045AF4F2C52
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 14:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E97224B1B;
	Fri, 31 Oct 2025 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEAKfBTN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E522222A9
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761920659; cv=none; b=foPleNq2oZG0+SX6yUhm1LCqKtH4PYVfTYFOEs6ju5arh/puoS6A4rzltBr3wGflnlKa6SPfxHLun9XY5DARWn8vWoYDemsd+Vti72kyoyvSIbPa/KociYGHaLq4HiT+O2e6KANO5LoSJpSn0xzSpX4zbSxfFUX3OuD+TaebK6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761920659; c=relaxed/simple;
	bh=fwtiNB9WhVWkQmnu1QrNkyxgAlNTJ9vYtH2x6chQAcY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u6xHeRjZxlDURWySuiGGzfYueLAGwpcrhmxcKG5pZ9FPl4RPbRUAmu5dMoFgIMQof79ibi1O6YNA4ahIQ1lYnbtYhRbgn4MV/xEKVFJT9buTtlubiIqOqNg2oCeqnf+MksIXOlnE8Pq+GNcn6yu+uYHBJOBuW7YEAt3n6fRQefs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEAKfBTN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FE1C4CEE7;
	Fri, 31 Oct 2025 14:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761920659;
	bh=fwtiNB9WhVWkQmnu1QrNkyxgAlNTJ9vYtH2x6chQAcY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tEAKfBTNOGmH0171KqCqCXHilEqjOForim+/t/cr8UV3Y1xpwzzfUnr3BUqdR7mq1
	 hVpap1+E/AoAkQP7Ecfaf805OA1q9tBKgIr01MyGZs80+2FItiKgfoHCRiJAQDVCJ+
	 B7zBlez+u7cYZlNMydeAud3bDDSNPH+LHktpkSNQJhUjlbdzTmtHNlXCogjZJpB+lH
	 a94HZ75qNsQzket5h/cpen/x3Mt6Srp/vnPfrAtSGu39bH5gRdDFqV1kpO/tpMHTsy
	 O3P9fZZMif/T7z4OSmABqWmmhqbL+Kx067vnezJKiVx6AvLCJwyuiXAamAjLy92ByS
	 qr7gTyL16v6hA==
Message-ID: <632304c109d69cf846239331d882deb9cae5f302.camel@kernel.org>
Subject: Re: [bug report] NFSv4: Observe the NFS_MOUNT_SOFTREVAL flag in
 _nfs4_proc_lookupp
From: Trond Myklebust <trondmy@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>, Harshit Mogalapalli
	 <harshit.m.mogalapalli@oracle.com>
Cc: linux-nfs@vger.kernel.org
Date: Fri, 31 Oct 2025 10:24:17 -0400
In-Reply-To: <aQS4Ju3132AqZeqB@stanley.mountain>
References: <aQS4Ju3132AqZeqB@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-31 at 16:22 +0300, Dan Carpenter wrote:
> Hello Trond Myklebust,
>=20
> This is a new checker rule Harshit and I wrote.
>=20
> Commit 76998ebb9158 ("NFSv4: Observe the NFS_MOUNT_SOFTREVAL flag in
> _nfs4_proc_lookupp") from Oct 20, 2020 (linux-next), leads to the
> following Smatch static checker warning:
>=20
> 	fs/nfs/nfs4proc.c:783 nfs4_init_sequence()
> 	warn: potentially more than 1 'args->sa_cache_this =3D 0x1001'
> type=3D'uchar'
>=20
> fs/nfs/nfs4proc.c
> =C2=A0=C2=A0=C2=A0 778 void nfs4_init_sequence(struct nfs4_sequence_args =
*args,
> =C2=A0=C2=A0=C2=A0 779=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct nfs4_sequence_res *res, int
> cache_reply,
> =C2=A0=C2=A0=C2=A0 780=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 int privileged)
> =C2=A0=C2=A0=C2=A0 781 {
> =C2=A0=C2=A0=C2=A0 782=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ar=
gs->sa_slot =3D NULL;
> --> 783=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 args->sa_cache_th=
is =3D cache_reply;
>=20
> args->sa_cache_this is a 1 bit bitfield in a u8, but the commit
> mentioned
> is passing RPC_TASK_TIMEOUT (0x1000).=C2=A0 Should this code be changed
> to:
>=20
> 	args->sa_cache_this =3D cache_reply & RPC_TASK_ASYNC;
>=20
> Probably not...=C2=A0 _nfs4_proc_lookupp() is the only caller which passe=
s
> anything other than zero.
>=20
> =C2=A0=C2=A0=C2=A0 784=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ar=
gs->sa_privileged =3D privileged;
> =C2=A0=C2=A0=C2=A0 785=20
> =C2=A0=C2=A0=C2=A0 786=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
s->sr_slot =3D NULL;
> =C2=A0=C2=A0=C2=A0 787 }
>=20
> regards,
> dan carpenter

Oops... That's definitely a bug in the lookupp code. Thanks for finding
it!

That function should probably be calling nfs4_init_sequence() directly,
and then using nfs4_do_call_sync() to pass the RPC_TASK_TIMEOUT flag
down to the RPC layer.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

