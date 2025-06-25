Return-Path: <linux-nfs+bounces-12787-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A13AE8CE5
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 20:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6971699EB
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 18:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F8F2DAFDB;
	Wed, 25 Jun 2025 18:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jO3XWUQT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3432D660E
	for <linux-nfs@vger.kernel.org>; Wed, 25 Jun 2025 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750876988; cv=none; b=t13Rob9LBCLHofOv60TknzXDu5hUV4NvSNpKnUpDD8CXi+3GX+7yId2oPgV+kbtx+TW9BBQDLRdTU4y6U8tIEZxHA97OzEcfFTENaFMddgFqbalPxtTHBkSFqUJks3n61bedH94u2qplGGJm3pVlZt7xMc28LB+oWZkXSy0V3Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750876988; c=relaxed/simple;
	bh=OKg4f3QPxqhu8qcwsEmBZchrZuuj+HTZlurHy8TPl1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=esZLUMVyXDkrMsesgw4R1Mj5qF79FOiM7EcFprVj9V9yW4o/4EF4alXS5du+46f6K9D23lPfpSTDd1sreyoadeuU3IFkf44YP47ayfPEjv/NQz07lpQBxGGIm1qSxh6QYPt8L85hRzut8YczDk6uS04yJ5NQn0TYF6ky09xuQ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jO3XWUQT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750876986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1nraprCACvcueTQ8NqOhkYap3/qQUPJst2d+eF7q87Q=;
	b=jO3XWUQTjnfMS6lOYxCLoaSulbQwCglUKI6L5AVPreg4EuUpU2ZCoI6ZLqPezurZ0A8QZ/
	BASMIw+7VhWCrSeUDHp78vIJ6HcOjTynTCVC9h7m+YV6kHUko+Xp4DAm9GOvc27xfmjZXU
	PIUMm0KjCle5HwkMwmGui98dbpt2EiA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-xrkyci6POoOCpQKYwiwU1g-1; Wed,
 25 Jun 2025 14:43:00 -0400
X-MC-Unique: xrkyci6POoOCpQKYwiwU1g-1
X-Mimecast-MFC-AGG-ID: xrkyci6POoOCpQKYwiwU1g_1750876978
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74445195608B;
	Wed, 25 Jun 2025 18:42:58 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.7])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0E9030001A1;
	Wed, 25 Jun 2025 18:42:56 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: zhangjian <zhangjian496@huawei.com>
Cc: steved@redhat.com, joannelkoong@gmail.com, chuck.lever@oracle.com,
 djwong@kernel.org, jlayton@kernel.org, okorniev@redhat.com,
 kernel-team@meta.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfs:check for user input filehandle size
Date: Wed, 25 Jun 2025 14:42:54 -0400
Message-ID: <B3095C28-5EDB-496A-823C-9AFFE38D3F0B@redhat.com>
In-Reply-To: <20250626002026.110999-1-zhangjian496@huawei.com>
References: <20250626002026.110999-1-zhangjian496@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 25 Jun 2025, at 20:20, zhangjian wrote:

> Syzkaller found an slab-out-of-bounds in nfs_fh_to_dentry when the memo=
ry
> of server_fh is not passed from user space. So I add a check for input =
size.
> ---
>  fs/nfs/export.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> index e9c233b6f..e0e77f8ca 100644
> --- a/fs/nfs/export.c
> +++ b/fs/nfs/export.c
> @@ -65,8 +65,8 @@ nfs_fh_to_dentry(struct super_block *sb, struct fid *=
fid,
>  		 int fh_len, int fh_type)
>  {
>  	struct nfs_fattr *fattr =3D NULL;
> -	struct nfs_fh *server_fh =3D nfs_exp_embedfh(fid->raw);
> -	size_t fh_size =3D offsetof(struct nfs_fh, data) + server_fh->size;
> +	struct nfs_fh *server_fh;
> +	size_t fh_size;
>  	const struct nfs_rpc_ops *rpc_ops;
>  	struct dentry *dentry;
>  	struct inode *inode;
> @@ -74,6 +74,14 @@ nfs_fh_to_dentry(struct super_block *sb, struct fid =
*fid,
>  	u32 *p =3D fid->raw;
>  	int ret;
>
> +	/* check for user input size */
> +	if ((char*)server_fh <=3D (char*)p
> +	    || (int)((u32*)server_fh - (u32*)p + 1) < fh_len)
> +		return ERR_PTR(-EINVAL);	=


^^ Doesn't this patch change server_fh so that it is not initialized yet?=


 - I'm not following how this works..

> +
> +	fh_size =3D offsetof(struct nfs_fh, data) + server_fh->size;
> +	len =3D EMBED_FH_OFF + XDR_QUADLEN(fh_size);

^^ isn't "len" already set to this value?  This looks like a duplicated l=
ine.

Maybe missing a pre-req patch, I'm looking at 6.16-rc2,
Ben


