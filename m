Return-Path: <linux-nfs+bounces-5434-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7553C95692E
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Aug 2024 13:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83FD1C20382
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Aug 2024 11:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789B2160873;
	Mon, 19 Aug 2024 11:18:33 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8933A15535B
	for <linux-nfs@vger.kernel.org>; Mon, 19 Aug 2024 11:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724066313; cv=none; b=FTvO2DsaukvDIRFN28QggcBZa0V/fM/fCmqkx7ieDg7CLBITQKBlOvJY+1twf7+ONR+Z81rrD+DFK6k5sv6/ollH4Leb5XBFm1fF4o5bNVUdRbGjcgtM/d4nrtioHPoUTkfhc3/OvA5+7G7galBdJkNh8/3fS6anFUw+0IWhuiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724066313; c=relaxed/simple;
	bh=kFiLqZn1A4xfVlnB0j2BNnvJ02oLUNnIfSZkzVMMtTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZi/GuisUmq2aQsfvtxEsojyV47XRwyb8v0k3JuMaRphyNUdaDT8OU+9dDyrzNh280F3T7TK9P7BF7v1OuHYDLNKvKfurt9mII+jt+K5prIeV4llDCdiO1KoNZHjTzaUEpysTLt2jmqehX2l259zAd1jQAHA32ubLHfsm9QP7lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4280772333eso5712975e9.0
        for <linux-nfs@vger.kernel.org>; Mon, 19 Aug 2024 04:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724066310; x=1724671110;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZQz5A8/S/FzbXbhp6n6rTt2GR7JQRNNFahadXr08eA=;
        b=TGwtfPBrJxNPRKA+YExUU+mXxgEp+vcNDPzkuzKfLKkTpJjZsCsZMM0QdwlC5RpUWM
         xUuUyYpySRX2T5WzExH6V9CF7UrMfA75ugR/KujykiiJJTK80YkUViPw6dvQN25o2xPu
         34Q1PT7c+M0Bsbjj4LgNq3bJWDG33MiSxptwp2bUBccd3bwjhvJRUFXwiKtyIIIXxEJm
         3OAtiOnKNUl1vVU3VFL3vW+5sxyiGXO73fvoWvWNBpjXdmbnfdN7k56vsakC31nr5x0v
         6FwtCsg4YP0qANJJDYtWR0DQvAQveH9KWyRk+UqdaMvK8kuYDlfa7JpfZ9xvLIBJa/dc
         ztIA==
X-Gm-Message-State: AOJu0YyCCs0yC7ik5tqM5j4In0+u4y9vrXOEqe//j6ZBpDtiwENGX9HI
	yxW/EqYqP3fqudmT/7uEcsBNS95uWydW7TZ/qTmUGNwfY+DOIgAzrH7B5A==
X-Google-Smtp-Source: AGHT+IHFfzav3F8SGK9zpneNP2rkO3g8Jkb1GoETJG8P4FT3WmwNZWVH2T3nrbN9xbCheFPbzV8qDQ==
X-Received: by 2002:a05:600c:1ca9:b0:425:7ac6:96f9 with SMTP id 5b1f17b1804b1-429ed62f483mr43208785e9.0.1724066309398;
        Mon, 19 Aug 2024 04:18:29 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded292f8sm158743165e9.14.2024.08.19.04.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 04:18:29 -0700 (PDT)
Message-ID: <8859671b-2bcf-464b-9a9e-cc777427daba@grimberg.me>
Date: Mon, 19 Aug 2024 14:18:28 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs: add 'noalignwrite' option for lock-less 'lost
 writes' prevention
To: anna@kernel.org, Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
 Dan Aloni <dan.aloni@vastdata.com>
References: <20240724110712.2600130-1-dan.aloni@vastdata.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240724110712.2600130-1-dan.aloni@vastdata.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 24/07/2024 14:07, Dan Aloni wrote:
> There are some applications that write to predefined non-overlapping
> file offsets from multiple clients and therefore don't need to rely on
> file locking. However, if these applications want non-aligned offsets
> and sizes they need to either use locks or risk data corruption, as the
> NFS client defaults to extending writes to whole pages.
>
> This commit adds a new mount option `noalignwrite`, which allows to turn
> that off and avoid the need of locking, as long as these applications
> don't overlap on offsets.
>
> Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   fs/nfs/fs_context.c       | 8 ++++++++
>   fs/nfs/super.c            | 3 +++
>   fs/nfs/write.c            | 3 +++
>   include/linux/nfs_fs_sb.h | 1 +
>   4 files changed, 15 insertions(+)
>
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index 6c9f3f6645dd..7e000d782e28 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -49,6 +49,7 @@ enum nfs_param {
>   	Opt_bsize,
>   	Opt_clientaddr,
>   	Opt_cto,
> +	Opt_alignwrite,
>   	Opt_fg,
>   	Opt_fscache,
>   	Opt_fscache_flag,
> @@ -149,6 +150,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
>   	fsparam_u32   ("bsize",		Opt_bsize),
>   	fsparam_string("clientaddr",	Opt_clientaddr),
>   	fsparam_flag_no("cto",		Opt_cto),
> +	fsparam_flag_no("alignwrite",	Opt_alignwrite),
>   	fsparam_flag  ("fg",		Opt_fg),
>   	fsparam_flag_no("fsc",		Opt_fscache_flag),
>   	fsparam_string("fsc",		Opt_fscache),
> @@ -592,6 +594,12 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
>   		else
>   			ctx->flags |= NFS_MOUNT_TRUNK_DISCOVERY;
>   		break;
> +	case Opt_alignwrite:
> +		if (result.negated)
> +			ctx->flags |= NFS_MOUNT_NO_ALIGNWRITE;
> +		else
> +			ctx->flags &= ~NFS_MOUNT_NO_ALIGNWRITE;
> +		break;
>   	case Opt_ac:
>   		if (result.negated)
>   			ctx->flags |= NFS_MOUNT_NOAC;
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index cbbd4866b0b7..1382ae19bba4 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -549,6 +549,9 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
>   	else
>   		seq_puts(m, ",local_lock=posix");
>   
> +	if (nfss->flags & NFS_MOUNT_NO_ALIGNWRITE)
> +		seq_puts(m, ",noalignwrite");
> +
>   	if (nfss->flags & NFS_MOUNT_WRITE_EAGER) {
>   		if (nfss->flags & NFS_MOUNT_WRITE_WAIT)
>   			seq_puts(m, ",write=wait");
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index 2329cbb0e446..cfe8061bf005 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -1315,7 +1315,10 @@ static int nfs_can_extend_write(struct file *file, struct folio *folio,
>   	struct file_lock_context *flctx = locks_inode_context(inode);
>   	struct file_lock *fl;
>   	int ret;
> +	unsigned int mntflags = NFS_SERVER(inode)->flags;
>   
> +	if (mntflags & NFS_MOUNT_NO_ALIGNWRITE)
> +		return 0;
>   	if (file->f_flags & O_DSYNC)
>   		return 0;
>   	if (!nfs_folio_write_uptodate(folio, pagelen))
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index 92de074e63b9..4d28b4a328a7 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -157,6 +157,7 @@ struct nfs_server {
>   #define NFS_MOUNT_WRITE_WAIT		0x02000000
>   #define NFS_MOUNT_TRUNK_DISCOVERY	0x04000000
>   #define NFS_MOUNT_SHUTDOWN			0x08000000
> +#define NFS_MOUNT_NO_ALIGNWRITE		0x10000000
>   
>   	unsigned int		fattr_valid;	/* Valid attributes */
>   	unsigned int		caps;		/* server capabilities */

Hey Anna, making sure this doesn't fall under your radar...

