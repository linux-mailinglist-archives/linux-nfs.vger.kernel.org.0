Return-Path: <linux-nfs+bounces-2729-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D1889DA4E
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 15:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F4D91C21410
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2F31369AF;
	Tue,  9 Apr 2024 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oG6/Bz5B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAB813541A
	for <linux-nfs@vger.kernel.org>; Tue,  9 Apr 2024 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669200; cv=none; b=aEyoOUKldl/wHeeE5Bc7G1ptBHy0r7Y5gipI82OgGyX0fS3fcF7weDDkMCl0PwMpdUSfrjccWdLARNDpafinCPjTTkEtUEHLb1PPHRTGh/logfVho0YxOa/xG3QC5QirTRyal0M4GfqyvXFaJuWCdKcKmeu/Ws+vEaTx9fsOd0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669200; c=relaxed/simple;
	bh=HkVY3LvtwEvEfcBeLdIHKnkk9yL5+a8OWtS1SHO24uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tg5/3JXJNM7tAsu0/cBTp7XdO0Vaj1o5IIU0cXICEdpygiZdHhHbkwNcrjdzPhgNkakH3zxfg05i1c8BchXL4NY+Anr2Uv339N0Btn3WXL5LjUNXWKxj57olwoAEe5S80cpx2LTU+iYODx2EQ8kL4bGqjco810UYhoYB2UyHOMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oG6/Bz5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DC5C433C7
	for <linux-nfs@vger.kernel.org>; Tue,  9 Apr 2024 13:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712669200;
	bh=HkVY3LvtwEvEfcBeLdIHKnkk9yL5+a8OWtS1SHO24uk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oG6/Bz5BTTlDExvSMJzDnIFwavmQEyGS01MBQchlZuxAvVJ+j4rON51ejo2PbMH/d
	 BMPbQ8rCU/h9bgPBlFA8Ps2w8wbGCvq0AtLMpWeig/oyrbEU7XCFJQchArip8Jq1FF
	 GSHk2mOB1A92sZU3vsyRElNNKRDqc6/+cfZj9G8U+hYfsvJ/37QXGBIrgSUSQ0tPMc
	 CkHt5ZCDkfxPua9TKyhjZkikufkQE0VJ9Wn9DAWI3L+Jt7uLf3spDsF8YQqJVE/qoo
	 jR55b5HqKS3Hh+Xvt5sD9DnOMrjZIs9M2fLyLAunvwY/USolKT9nKUP4YKX1LrKkDQ
	 C2TMC715UVJKA==
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-434925427c6so9269961cf.1
        for <linux-nfs@vger.kernel.org>; Tue, 09 Apr 2024 06:26:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWXEuKnRIHzjZqnP9Uz+nXyCDyErfgtxFLXrAyPyRyKq42GETkaRyo/f9LSwzhXF7IxH/twGNax+CMlniwQcYD9J8tK1bGqXwHc
X-Gm-Message-State: AOJu0YyphNxa9dmCcvBLEvG32rLtMTegFgy0BpQ2nhTyaVAih4l9nEp3
	ViTEN15fX8m/t/hGD9YEsB0lR81gb9BYTl4YkaIFkfhRJgkT05rZ0UtqCWGtEduQ7jDcnwaJepc
	ZJeFc0qRSN2O2nKq3asjgpCphc4I=
X-Google-Smtp-Source: AGHT+IEVBoLch89EMWtQCWCHv7nBIMeFuwRE2ZE5TB38oLhm6kZ2HRQazBd1pZu3Ek17MxI9CfwAKyLvpVRTvex0HOU=
X-Received: by 2002:a05:622a:19a1:b0:434:bb25:ed02 with SMTP id
 u33-20020a05622a19a100b00434bb25ed02mr3781914qtc.63.1712669199660; Tue, 09
 Apr 2024 06:26:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408095052.367-1-chenhx.fnst@fujitsu.com>
In-Reply-To: <20240408095052.367-1-chenhx.fnst@fujitsu.com>
From: Anna Schumaker <anna@kernel.org>
Date: Tue, 9 Apr 2024 09:26:23 -0400
X-Gmail-Original-Message-ID: <CAFX2JfkF62GvP_DUpji1SKor6vfLhYqrwiK5ZNWevV_6f-QLfQ@mail.gmail.com>
Message-ID: <CAFX2JfkF62GvP_DUpji1SKor6vfLhYqrwiK5ZNWevV_6f-QLfQ@mail.gmail.com>
Subject: Re: [PATCH] NFSv4: add tracepoint to referral events
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chen,

On Mon, Apr 8, 2024 at 5:52=E2=80=AFAM Chen Hanxiao <chenhx.fnst@fujitsu.co=
m> wrote:
>
> Trace new locations when hitting a referral.
>
> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> ---
>  fs/nfs/nfs4namespace.c |  3 +++
>  fs/nfs/nfs4trace.h     | 25 +++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/fs/nfs/nfs4namespace.c b/fs/nfs/nfs4namespace.c
> index 9a98595bb160..fca9fb801bc2 100644
> --- a/fs/nfs/nfs4namespace.c
> +++ b/fs/nfs/nfs4namespace.c
> @@ -24,6 +24,7 @@
>  #include "nfs4_fs.h"
>  #include "nfs.h"
>  #include "dns_resolve.h"
> +#include "nfs4trace.h"
>
>  #define NFSDBG_FACILITY                NFSDBG_VFS
>
> @@ -351,6 +352,8 @@ static int try_location(struct fs_context *fc,
>                 p +=3D ctx->nfs_server.export_path_len;
>                 *p =3D 0;
>
> +               trace_nfs4_referral_location(ctx->nfs_server.hostname,
> +                       ctx->nfs_server.export_path);
>                 ret =3D nfs4_get_referral_tree(fc);
>                 if (ret =3D=3D 0)
>                         return 0;
> diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
> index 10985a4b8259..165c4dc7b5c7 100644
> --- a/fs/nfs/nfs4trace.h
> +++ b/fs/nfs/nfs4trace.h
> @@ -2604,6 +2604,31 @@ DEFINE_NFS4_XATTR_EVENT(nfs4_setxattr);
>  DEFINE_NFS4_XATTR_EVENT(nfs4_removexattr);
>
>  DEFINE_NFS4_INODE_EVENT(nfs4_listxattr);
> +
> +TRACE_EVENT(nfs4_referral_location,
> +               TP_PROTO(
> +                       const char *hostname,
> +                       const char *path
> +               ),
> +
> +               TP_ARGS(hostname, path),
> +
> +               TP_STRUCT__entry(
> +                       __string(referral_hostname, hostname)
> +                       __string(referral_path, path)
> +               ),
> +
> +               TP_fast_assign(
> +                       __assign_str(referral_hostname, hostname)e

                      ^^^^^^^
I wanted to double check if you've compiled and tested this? I ask
because the 'e' at the end of the line here should be a semicolon,
which my compiler complains about.

Thanks,
Anna

> +                       __assign_str(referral_path, path);
> +               ),
> +
> +               TP_printk(
> +                       "referral_host=3D%s referral_path=3D%s",
> +                       __get_str(referral_hostname),
> +                       __get_str(referral_path)
> +               )
> +);
>  #endif /* CONFIG_NFS_V4_2 */
>
>  #endif /* CONFIG_NFS_V4_1 */
> --
> 2.39.1
>

