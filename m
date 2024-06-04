Return-Path: <linux-nfs+bounces-3544-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF8E8FBBEA
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 20:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2721F267EE
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 18:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300E0136994;
	Tue,  4 Jun 2024 18:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtyWj4Y9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A63227735
	for <linux-nfs@vger.kernel.org>; Tue,  4 Jun 2024 18:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717527172; cv=none; b=AaPtqtHIgR6Ig7chziNGso+0fDb+VA3SnD4GAGpTTt8p7BHAZ61FOneG0sal7TzVkrp64lFbI61f+SyqR+kjnpSPz7wUXSZ3Rewe2+F7kp9NzMn2WesDeJN4jd4BAeCX20B7+CffATH+eloY1Qd9JFs+uS9l0LbQ8L9AwKF9Y+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717527172; c=relaxed/simple;
	bh=4Xs0J3ZgAt9twKoj6l7mFRxoNXu4Gfg0PzrQEBgQYgI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=utZFP2PkYZe1t1Z9kVY8yd3DCuQnUmTyfnQAaibJQMnt9fk8ymR8ZzGrFvmRiN0HZigmc0vod9sPuJOYA+jAzBN2Qhreo6ImYf1InSAeUIjnh2soArU6VKv5z1brNtUNSs9KxSRCFj3VCX/AL1ZIrNjVPdfLiuiW5yUj4kfql5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtyWj4Y9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148BDC2BBFC;
	Tue,  4 Jun 2024 18:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717527171;
	bh=4Xs0J3ZgAt9twKoj6l7mFRxoNXu4Gfg0PzrQEBgQYgI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XtyWj4Y9OxkMdMcY0fvX0HmmdkYQJUD3MgIK8QHOUEp9J2FpzCWTxRmFYXOVtAGzn
	 itBs+YjKWiVcTICIHJh7dkiE2wO8aK22M/+9/zND0Po3AGEk5z3lceqUCp0mOZnxRA
	 JWS9ZhuRdxME4KPPM/W9Xp/qaYXd6xWn24rka+db+CQSLqs62tnR8qCBKse+f+3k1J
	 3dRomYza52NKr4mnD1UpB67KKn2HoU3kuL7U0edV7GdSvAVDZA0/2Y8EYwLat+Rbo1
	 MxLYOW28F9VacK0e5q49FhB3YCqhZ5Q2OdWhEOEHvu3GFo5e5kLYJ82Du57uaFjOjD
	 IGGGauEGt54sw==
Message-ID: <7df1d99d4497379c22d584bc66772bcc25173cda.camel@kernel.org>
Subject: Re: [RFC PATCH] NFSD: Fix nfsdcld warning
From: Jeff Layton <jlayton@kernel.org>
To: cel@kernel.org, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 04 Jun 2024 14:52:49 -0400
In-Reply-To: <20240604152359.8662-2-cel@kernel.org>
References: <20240604152359.8662-2-cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-04 at 11:24 -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Since CONFIG_NFSD_LEGACY_CLIENT_TRACKING is a new config option, its
> initial default setting should have been Y (if we are to follow the
> common practice of "default Y, wait, default N, wait, remove code").
>=20
> Paul also suggested adding a clearer remedy action to the warning
> message.
>=20
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Message-Id: <d2ab4ee7-ba0f-44ac-b921-90c8fa5a04d2@molgen.mpg.de>
> Fixes: 74fd48739d04 ("nfsd: new Kconfig option for legacy client
> tracking")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> =C2=A0fs/nfsd/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0fs/nfsd/nfs4recover.c | 4 ++--
> =C2=A02 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index 272ab8d5c4d7..ec2ab6429e00 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -162,7 +162,7 @@ config NFSD_V4_SECURITY_LABEL
> =C2=A0config NFSD_LEGACY_CLIENT_TRACKING
> =C2=A0	bool "Support legacy NFSv4 client tracking methods
> (DEPRECATED)"
> =C2=A0	depends on NFSD_V4
> -	default n
> +	default y
> =C2=A0	help
> =C2=A0	=C2=A0 The NFSv4 server needs to store a small amount of
> information on
> =C2=A0	=C2=A0 stable storage in order to handle state recovery after
> reboot. Most
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index 2c060e0b1604..67d8673a9391 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -2086,8 +2086,8 @@ nfsd4_client_tracking_init(struct net *net)
> =C2=A0	status =3D nn->client_tracking_ops->init(net);
> =C2=A0out:
> =C2=A0	if (status) {
> -		printk(KERN_WARNING "NFSD: Unable to initialize
> client "
> -				=C2=A0=C2=A0=C2=A0 "recovery tracking! (%d)\n",
> status);
> +		pr_warn("NFSD: Unable to initialize client recovery
> tracking! (%d)\n", status);
> +		pr_warn("NFSD: Is nfsdcld running? If not, enable
> CONFIG_NFSD_LEGACY_CLIENT_TRACKING.\n");
> =C2=A0		nn->client_tracking_ops =3D NULL;
> =C2=A0	}
> =C2=A0	return status;

Reviewed-by: Jeff Layton <jlayton@kernel.org>

