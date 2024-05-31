Return-Path: <linux-nfs+bounces-3504-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289F38D5F45
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 12:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2171C20FE5
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 10:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A2814263A;
	Fri, 31 May 2024 10:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIriLKsu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FF981ACB;
	Fri, 31 May 2024 10:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717150169; cv=none; b=FJlj7sh2P0pBcUs6L5HTN7xoqxmaaj1kftrTqP67S/qFSZ8iBW0Q6Rz3K70gxX4TCbMm50fDvQ9ZjRNiW64YmBMXKU4UBwumpJcsA0RlKr5F/C/1rpjMTg1l4TEc7pW1xKhaH3yiRcajqSoZgMiW+zfMkqIwmRb405BQBaISi/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717150169; c=relaxed/simple;
	bh=Sic4nTyYw+kCcDlQNPaN6T+BaZh+LcAE+Y2eGY+gukY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qXr7toifx3pYVegUaFGFRY5kEvRLJx5ArQeLWeAGkUugyYtK7+2gnbjEv+XdQx8GbNhVietJzOc7Rm2YdaATiQRupr0mNOZJfRTPejgcwQbT2GKMicWfnvmCuXcN6hSMnPKVJahy7bcXV0KLqAzPg9nRYZJS4C/VtxZ0hSkbVhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIriLKsu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C436C116B1;
	Fri, 31 May 2024 10:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717150169;
	bh=Sic4nTyYw+kCcDlQNPaN6T+BaZh+LcAE+Y2eGY+gukY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=vIriLKsuUHXGkrsZUN0rQhmXJkOT4PQO7k4YbXKYkM6uuLRjZYbpN3nxFxsfdzIJk
	 e9449mBvDdvgjEv6GGP12Y6bHwVyz8snADTrF6Ffge40pa/X6xAhYpobIkLNQAk/NO
	 YuxCMWH5vpAQEHul1AVXArcH5/ef1OpeS9SyZSjb4Vr77AXNby30wMES8gpYIh+LbY
	 GkbGkG2MgFQKZpQK9xlScXMz6fTMSKR4O4DOlF8fGjSfIAcqZvAS393qTcviQwnOYf
	 Uco2HWf+kMdfJWDusJ1DbObG7n4by4bnGlv2Iwqf5nJ1TCiQJVLvfCXJqAm9zkZNkG
	 06g1keqRLdN+Q==
Message-ID: <1922c6893fd78b5c9af1549ac109d097341c4b0e.camel@kernel.org>
Subject: Re: [PATCH] NFSD: remove unused structs 'nfsd3_voidargs'
From: Jeff Layton <jlayton@kernel.org>
To: linux@treblig.org, chuck.lever@oracle.com, neilb@suse.de
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 31 May 2024 06:09:27 -0400
In-Reply-To: <20240531000838.332082-1-linux@treblig.org>
References: <20240531000838.332082-1-linux@treblig.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-31 at 01:08 +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>=20
> 'nfsd3_voidargs' in nfs[23]acl.c is unused since
> commit 788f7183fba8 ("NFSD: Add common helpers to decode void args
> and
> encode void results").
>=20
> Remove them.
>=20
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
> =C2=A0fs/nfsd/nfs2acl.c | 2 --
> =C2=A0fs/nfsd/nfs3acl.c | 2 --
> =C2=A02 files changed, 4 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
> index 12b2b9bc07bf..4e3be7201b1c 100644
> --- a/fs/nfsd/nfs2acl.c
> +++ b/fs/nfsd/nfs2acl.c
> @@ -308,8 +308,6 @@ static void nfsaclsvc_release_access(struct
> svc_rqst *rqstp)
> =C2=A0	fh_put(&resp->fh);
> =C2=A0}
> =C2=A0
> -struct nfsd3_voidargs { int dummy; };
> -
> =C2=A0#define ST 1		/* status*/
> =C2=A0#define AT 21		/* attributes */
> =C2=A0#define pAT (1+AT)	/* post attributes - conditional */
> diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
> index 73adca47d373..5e34e98db969 100644
> --- a/fs/nfsd/nfs3acl.c
> +++ b/fs/nfsd/nfs3acl.c
> @@ -221,8 +221,6 @@ static void nfs3svc_release_getacl(struct
> svc_rqst *rqstp)
> =C2=A0	posix_acl_release(resp->acl_default);
> =C2=A0}
> =C2=A0
> -struct nfsd3_voidargs { int dummy; };
> -
> =C2=A0#define ST 1		/* status*/
> =C2=A0#define AT 21		/* attributes */
> =C2=A0#define pAT (1+AT)	/* post attributes - conditional */

Reviewed-by: Jeff Layton <jlayton@kernel.org>

