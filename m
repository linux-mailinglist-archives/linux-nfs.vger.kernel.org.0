Return-Path: <linux-nfs+bounces-10592-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA70AA5F8BA
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 15:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79683B42F0
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 14:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7F6267396;
	Thu, 13 Mar 2025 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EA8lNo4L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5413022612
	for <linux-nfs@vger.kernel.org>; Thu, 13 Mar 2025 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876729; cv=none; b=CKxefdLyTwarV9OSvF+UEYpE1QkGFCNMP2pzI/1HjSLkhhAeeeCV9ASnTMGAUBM4CaiTx1VKPbseBMFm00XvG9/7scxyiAHiw78Q+N0tjxCm1o2tHDyzVvFiFrFVC4hO2H9NBGSYtNRjuFJs9DV0p4w+MPfhbC89XB35aCVH0SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876729; c=relaxed/simple;
	bh=ll9p9EYk2+kXJ4iF8OiMdBDgUIGgB99A4UkMP2wToxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHVs72DRdGGthZiuHtvBRRCkY7yL6EiXwnLtjGsKWSi3iKbjT+RYqfv4E/c/2T+YjtnfU2bkU56ce4J7Jj8tfSbRstDXNUtpXNzD34V6UmaUmWnks7DN+eg0wVrVZBpJqb5VT0881vDwstCFgTGwkNvwgqgzCSZyqic1YmDx4HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EA8lNo4L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741876726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8md1j62LX+H6Y1QnzYBx0QGcxz3LTu2HmHdPsZ8nARg=;
	b=EA8lNo4LQ9Kj/HBgC46EcMtdxvl10VcWbwGODCWg0YSmMPwJj1g8f+3K48LRz5rFjP+/wu
	5kzTSRKPJP9i31MvRndDOc4xRgYrOKoY2+UlAGzsPYtSbGnvqQUec+8fHP+l195plgYE+b
	m7rEObuVNdK6xFL4pzcQSRcuT41TjuA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-yFwb_l5iN2--xeEkm96iIw-1; Thu,
 13 Mar 2025 10:38:41 -0400
X-MC-Unique: yFwb_l5iN2--xeEkm96iIw-1
X-Mimecast-MFC-AGG-ID: yFwb_l5iN2--xeEkm96iIw_1741876720
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE51E19560B4;
	Thu, 13 Mar 2025 14:38:39 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.76.7])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5802F1801756;
	Thu, 13 Mar 2025 14:38:39 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/1] NFS: Extend rdirplus mount option with
 "force|none"
Date: Thu, 13 Mar 2025 10:38:37 -0400
Message-ID: <4F51D683-9894-41B6-8B5C-6F838C65D860@redhat.com>
In-Reply-To: <8538c32d6d971674d9d8a249fca8d5880697e32e.1741876108.git.bcodding@redhat.com>
References: <cover.1741876108.git.bcodding@redhat.com>
 <8538c32d6d971674d9d8a249fca8d5880697e32e.1741876108.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 13 Mar 2025, at 10:33, Benjamin Coddington wrote:

> There are certain users that wish to force the NFS client to choose
> READDIRPLUS over READDIR for a particular mount.  Update the "rdirplus"=
 mount
> option to optionally accept values.  For "rdirplus=3Dforce", the NFS cl=
ient
> will always attempt to use READDDIRPLUS.  The setting of "rdirplus=3Dno=
ne" is
> aliased to the existing "nordirplus".
>
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/nfs/dir.c              |  2 ++
>  fs/nfs/fs_context.c       | 32 ++++++++++++++++++++++++++++----
>  fs/nfs/super.c            |  1 +
>  include/linux/nfs_fs_sb.h |  1 +
>  4 files changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 2b04038b0e40..c9de0e474cf5 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -666,6 +666,8 @@ static bool nfs_use_readdirplus(struct inode *dir, =
struct dir_context *ctx,
>  {
>  	if (!nfs_server_capable(dir, NFS_CAP_READDIRPLUS))
>  		return false;
> +	if (NFS_SERVER(dir)->flags && NFS_MOUNT_FORCE_RDIRPLUS)
> +		return true;
>  	if (ctx->pos =3D=3D 0 ||
>  	    cache_hits + cache_misses > NFS_READDIR_CACHE_USAGE_THRESHOLD)
>  		return true;
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index b069385eea17..ad0135fcc563 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -72,6 +72,8 @@ enum nfs_param {
>  	Opt_posix,
>  	Opt_proto,
>  	Opt_rdirplus,
> +	Opt_rdirplus_none,
> +	Opt_rdirplus_force,
>  	Opt_rdma,
>  	Opt_resvport,
>  	Opt_retrans,
> @@ -174,7 +176,8 @@ static const struct fs_parameter_spec nfs_fs_parame=
ters[] =3D {
>  	fsparam_u32   ("port",		Opt_port),
>  	fsparam_flag_no("posix",	Opt_posix),
>  	fsparam_string("proto",		Opt_proto),
> -	fsparam_flag_no("rdirplus",	Opt_rdirplus),
> +	fsparam_flag_no("rdirplus", Opt_rdirplus), // rdirplus|nordirplus
> +	fsparam_string("rdirplus",  Opt_rdirplus), // rdirplus=3D...
>  	fsparam_flag  ("rdma",		Opt_rdma),
>  	fsparam_flag_no("resvport",	Opt_resvport),
>  	fsparam_u32   ("retrans",	Opt_retrans),
> @@ -288,6 +291,12 @@ static const struct constant_table nfs_xprtsec_pol=
icies[] =3D {
>  	{}
>  };
>
> +static const struct constant_table nfs_rdirplus_tokens[] =3D {
> +	{ "none",	Opt_rdirplus_none },
> +	{ "force",	Opt_rdirplus_force },
> +	{}
> +};
> +
>  /*
>   * Sanity-check a server address provided by the mount command.
>   *
> @@ -636,10 +645,25 @@ static int nfs_fs_context_parse_param(struct fs_c=
ontext *fc,
>  			ctx->flags &=3D ~NFS_MOUNT_NOACL;
>  		break;
>  	case Opt_rdirplus:
> -		if (result.negated)
> +		if (result.negated) {
> +			ctx->flags &=3D ~NFS_MOUNT_FORCE_RDIRPLUS;
>  			ctx->flags |=3D NFS_MOUNT_NORDIRPLUS;
> -		else
> -			ctx->flags &=3D ~NFS_MOUNT_NORDIRPLUS;
> +		} else if (!param->string) {
> +			ctx->flags &=3D ~(NFS_MOUNT_NORDIRPLUS || NFS_MOUNT_FORCE_RDIRPLUS)=
;


^^ this is broken.. v3 incoming.

Ben


