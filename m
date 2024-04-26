Return-Path: <linux-nfs+bounces-3033-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28CB8B36DD
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Apr 2024 14:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BCCD284238
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Apr 2024 12:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC62F14534D;
	Fri, 26 Apr 2024 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBNujVud"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EC814534B
	for <linux-nfs@vger.kernel.org>; Fri, 26 Apr 2024 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714133110; cv=none; b=P58vWEZKP2CFIcr3NVRhyUfo1VNa3j7saq6jmG5EF9DbkGbHX5nT+gnjHO0jmZeAIRz1j4G1DrDbxS70uBKa6d+DxCsKEteQBGNZFKBXksCpZiQwjw7H2D4wHBsU/37YetDmdy6STQeMPO0W5Yw3+rrP5FwFyXx4vwiMm1SiG00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714133110; c=relaxed/simple;
	bh=0Ek+fj7rmY/qxLHBKIqR/JFu2ia/m6CInV6a2GcZOX0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sQuhkr1aMrrog3tms2slm1yoh40ri/Vx4TcDRMjMsjS2/TAlvvOHyj+faFf67GadsNkNDscFh2z3+GjssKv1CseyjL+gKav2ag5VwLmnMpNIHuoirpAeDsFnsFJ0qe8Wc/I7Ln/pqh7eMR67ezl49Mo8CWfMDcZ1BbLVQiWyYUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBNujVud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61A4C113CD;
	Fri, 26 Apr 2024 12:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714133110;
	bh=0Ek+fj7rmY/qxLHBKIqR/JFu2ia/m6CInV6a2GcZOX0=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=iBNujVudZb3ZVKClBs6POqBqmeNKkHyWIRKM5ahCfiHcTF7BJ3KnnpgBfCvMUEy48
	 KmKEX015GXEGC3Ss0q4pET3nHQTJso4ubtxvCfXZGcDzdh51lyL+pUdcIfVacim9o3
	 o1x9B1rjwQ49ZgRGAVX0eEr9VKNHBN0vq78nOEF59RSKNJLmqRRK8XhjutsfMy2iZ5
	 mM8EEoxUtD7ZPE/VSR5MudC3wQZpH4pRFECcTJTrPlHAJQ7rSkALBoE5rM1lasj3vn
	 m1IlJ3ssrWJNbvosih6uH7ABRH1ByFSGxp6U5ew+cyL4K420MfKiqdijHWDajQxqBB
	 jcefKEt4BsVwQ==
Message-ID: <7da9588d3381763c388c10567704a3abed93a578.camel@kernel.org>
Subject: Re: [PATCH] NFS: Don't enable NFS v2 by default
From: Jeffrey Layton <jlayton@kernel.org>
To: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	trond.myklebust@hammerspace.com
Date: Fri, 26 Apr 2024 08:05:08 -0400
In-Reply-To: <20240425203440.440780-1-anna@kernel.org>
References: <20240425203440.440780-1-anna@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 (3.52.0-1.fc40app1) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-25 at 16:34 -0400, Anna Schumaker wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> This came up during one of the Bake-a-thon discussions. NFS v2 support
> was dropped from nfs-utils/mount.nfs in December 2021. Let's turn it
> off by default in the kernel too, since this means there isn't a way
> to mount and test it.
>=20
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
>  fs/nfs/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
> index f7e32d76e34d..57249f040dfc 100644
> --- a/fs/nfs/Kconfig
> +++ b/fs/nfs/Kconfig
> @@ -33,12 +33,12 @@ config NFS_FS
>  config NFS_V2
>  	tristate "NFS client support for NFS version 2"
>  	depends on NFS_FS
> -	default y
> +	default n
>  	help
>  	  This option enables support for version 2 of the NFS protocol
>  	  (RFC 1094) in the kernel's NFS client.
> =20
> -	  If unsure, say Y.
> +	  If unsure, say N.
> =20
>  config NFS_V3
>  	tristate "NFS client support for NFS version 3"

Reviewed-by: Jeffrey Layton <jlayton@kernel.org>

