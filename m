Return-Path: <linux-nfs+bounces-17971-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2871ED2DAFB
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 09:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 239C4300E477
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 08:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFAE26ED25;
	Fri, 16 Jan 2026 08:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TekqpQvC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A18A242D6A
	for <linux-nfs@vger.kernel.org>; Fri, 16 Jan 2026 08:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768550799; cv=pass; b=nMAe6kdUq7s2FRYjb9sFt4jmKbVLWYeUdRKCYIUJwR++SOkC2iPfDq5ERn8X4BHpBr9bcFCMNmhuUVHe20PFF7bTCOHrm7lI/EB9+233X0yCil6ZvB6//yxJ2xES7TpS2CtjibDR0N/OFoXxQ0uwJ4BOwZDk7tVKuQqNwmMljWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768550799; c=relaxed/simple;
	bh=FL2jksZYP5okunGzC8HaTlOLqelJv7QroYFocInQdj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=LV3k+JCyUI9OkTID7JVhzamaVsFk1k9wPg+yNkzIWEr/qKjb/xPO7+E51SfWGv5kObngeg0E7MnHwQl1//law/ezs/Xj0Y6yuSzCCMpOOnpLvxvtjDOHU/S3ithw4ktHOJ+uHy9MFhZ+a6U9rNg9s3rRsnk6MfKx52WDMh0wFv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TekqpQvC; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-45c86087949so660218b6e.2
        for <linux-nfs@vger.kernel.org>; Fri, 16 Jan 2026 00:06:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768550797; cv=none;
        d=google.com; s=arc-20240605;
        b=WI113Z1blrFc9yhg21fXxdgqHPgtCWw4UUMDt2ZSUcVhkALmETJUuIDlvL55/mRClG
         ysEuQ8Yms/qpHdEO7jn1B72wj8joMhw9V9KRqeB0OcOvIPIins0j9Q7+CzHApT3/R6ek
         jkLYoJfQk0dHFoT1+ufGGaiyv3wxC2DtV5t07qo99X1TSMYJ9qZrQjxNKkJ3N1h/VMrT
         YNCv94Fz6dHwCdcpFyvrtP3r1aRaBmtKM2ADITkpYd9CDwsMMpx7dEot2wYhmB1Eie+R
         TCackqUWIDkwhsymR55Md7lkWvYThNawGndlGhJoPSFx4MfW5M34JB8N7NQ0O280NCdK
         p7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=w7GKJ3E+Iq5rvPFOFOrG+TUw8BJHG77qeBaNeQVYKoI=;
        fh=A3pMOUK00huGibGCZBFsLekFLVbB5hHGKjUNNKwO+5E=;
        b=cbq2j3xz1cTwgN1f8lR7969vVd7docEwz5wks0wxWNPA5ZvAJykKHjyuFSJwwbFssG
         NXO7hRP+zeFUkKYe1mesy9RzofhDhCYRmzjIoLfLH0ufKQCDdUX34dgo3wy1HjqfRp1N
         xn5cW1j5d4D8/i7DLdkOiXEBnskDL2PqnJ9qJswtUCVVBfTxyx1aUGFegTEmOhIJOBLn
         2mil5tYwNOS4wouBjdP8oOATyc4+64qM8E9YilAmLOmYcjF6vMq2DoGd2gr7VEk6T3xC
         lQF9z0WOnvqIZBzGvHbxUZGQl8cRddoeHVCoySPhrx6PS0dV9KFoZpbTMOZQCCCBf6ZL
         l/iQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768550797; x=1769155597; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w7GKJ3E+Iq5rvPFOFOrG+TUw8BJHG77qeBaNeQVYKoI=;
        b=TekqpQvCN5SBMIoRJfO6Gvq7bGOwGmitgMv9pHbDEJGQu2Q+kGGxn1PdVSozXn8/LV
         YoYqsvPVqg2izLbe4wy9u+s5kgiy034hdmatM2NbdjcQcDrBr/JkIC9CpRHuC9TcFrLB
         zMSOHpzt+138dN6qk3idXhLLc1iguI/bGGC7rlTBXL8gwlSmh0tv++PmLdj+LsBQ3BJd
         l9GbhYoHrhUoNk9N8pF5elCCXOLJjtexeM6o37X4VWQN52zBgKavpHiariNqAxt+1t7h
         snwNwtI9JMYetCXwqbojgJzg0Twd8/EjeqDiUnR5v8Syk9FhPerz2tAjM/q6tZ0MoRAn
         hwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768550797; x=1769155597;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w7GKJ3E+Iq5rvPFOFOrG+TUw8BJHG77qeBaNeQVYKoI=;
        b=TPYsKZDugeesEpaWX1ZTeToTLNn6G7r7hT9262r/iysLtf8hjht9ljMICBWsnhBKPB
         igFmKTyWFv24H9BZUWTgMEgs4rmSr7XhMaIGtkFExIzgld/h1yEidyhnHA3p44lTgXqh
         7xnZR0YqfwCKsNxh2/8CpvCtQzR53wAjGT+8bMOFnbZZNEBqZmR6jQvYCPgurcxGVgk3
         1isnApymMdeHYKhmnWdlY3QkMsjybLalLn++GGTSPWmC2w+xzgrU3sNGzJJWK4GgJdxD
         V9uX9oDP5qrUGzs4DYiFnZ1daVfPK05fSIwrbgywdXebeemTtnYL7p40q9FXVd03fUH1
         NQ4Q==
X-Gm-Message-State: AOJu0YzGU0b/uk0YXZq075fFunekfwEsjsVy8SG9rrBXzUxp05SRI6Zd
	q32NnKTSTfRYjP6jOli9hzC257xu+MMLzNh+9CbzNFxAga+ObVpszimkN1Ry3mMGm0C2bN5f/JA
	+nN7gySU1fgm76AQw/C7VXFL7r8HIXtmPsg==
X-Gm-Gg: AY/fxX5tF8pn/pZO3B5smCDSwKTRmaNB9l1nhFoH4XCc+g1f2+0rxyjMlA2spNGGpbt
	U0UBzs6/Bwj9yOPNSZy+iAnUzVviWi37Ce3DQUQZaf8GsLxodf7fnKJ+P47Y4NK2jtTEtmDi18B
	uQDf5ggtWWV3B+Q6B4+b769PD5E8cmmNVwxjDuz7AOVheHGCk6cQ1NyfHdxLcGi7I1siUCIS+q6
	RLfDNYk+z7hLM+A6XBGG7jgVzwOuUSSVYHCuRdRxXC2Z0UOpjIchstZrMo2/LjpxwJs1XQ=
X-Received: by 2002:a05:6808:318f:b0:45a:6d59:44f5 with SMTP id
 5614622812f47-45c9d77f4b8mr776915b6e.30.1768550796671; Fri, 16 Jan 2026
 00:06:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114142900.3945054-1-cel@kernel.org> <20260114142900.3945054-16-cel@kernel.org>
In-Reply-To: <20260114142900.3945054-16-cel@kernel.org>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Fri, 16 Jan 2026 09:06:00 +0100
X-Gm-Features: AZwV_Qj-6alWoHlqFyLalMpGoc-42fGjwY6T_gMFqCmMwLwRM5ajjEQWWnqNHv4
Message-ID: <CALXu0Uf6B6GPkz5sjpjwqpyojQx7rg3v3UMnLQG4vo1hHiJeoQ@mail.gmail.com>
Subject: Re: [PATCH v4 15/16] nfsd: Implement NFSv4 FATTR4_CASE_INSENSITIVE
 and FATTR4_CASE_PRESERVING
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Which Linux version is this patch series targeting? Linux 6.19?

Ced

On Wed, 14 Jan 2026 at 15:34, Chuck Lever <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> NFSD currently provides NFSv4 clients with hard-coded responses
> indicating all exported filesystems are case-sensitive and
> case-preserving. This is incorrect for case-insensitive filesystems
> and ext4 directories with casefold enabled.
>
> Query the underlying filesystem's actual case sensitivity via
> nfsd_get_case_info() and return accurate values to clients. This
> supports per-directory settings for filesystems that allow mixing
> case-sensitive and case-insensitive directories within an export.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4xdr.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 51ef97c25456..167bede81273 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2933,6 +2933,8 @@ struct nfsd4_fattr_args {
>         u32                     rdattr_err;
>         bool                    contextsupport;
>         bool                    ignore_crossmnt;
> +       bool                    case_insensitive;
> +       bool                    case_preserving;
>  };
>
>  typedef __be32(*nfsd4_enc_attr)(struct xdr_stream *xdr,
> @@ -3131,6 +3133,18 @@ static __be32 nfsd4_encode_fattr4_acl(struct xdr_stream *xdr,
>         return nfs_ok;
>  }
>
> +static __be32 nfsd4_encode_fattr4_case_insensitive(struct xdr_stream *xdr,
> +                                       const struct nfsd4_fattr_args *args)
> +{
> +       return nfsd4_encode_bool(xdr, args->case_insensitive);
> +}
> +
> +static __be32 nfsd4_encode_fattr4_case_preserving(struct xdr_stream *xdr,
> +                                       const struct nfsd4_fattr_args *args)
> +{
> +       return nfsd4_encode_bool(xdr, args->case_preserving);
> +}
> +
>  static __be32 nfsd4_encode_fattr4_filehandle(struct xdr_stream *xdr,
>                                              const struct nfsd4_fattr_args *args)
>  {
> @@ -3487,8 +3501,8 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
>         [FATTR4_ACLSUPPORT]             = nfsd4_encode_fattr4_aclsupport,
>         [FATTR4_ARCHIVE]                = nfsd4_encode_fattr4__noop,
>         [FATTR4_CANSETTIME]             = nfsd4_encode_fattr4__true,
> -       [FATTR4_CASE_INSENSITIVE]       = nfsd4_encode_fattr4__false,
> -       [FATTR4_CASE_PRESERVING]        = nfsd4_encode_fattr4__true,
> +       [FATTR4_CASE_INSENSITIVE]       = nfsd4_encode_fattr4_case_insensitive,
> +       [FATTR4_CASE_PRESERVING]        = nfsd4_encode_fattr4_case_preserving,
>         [FATTR4_CHOWN_RESTRICTED]       = nfsd4_encode_fattr4__true,
>         [FATTR4_FILEHANDLE]             = nfsd4_encode_fattr4_filehandle,
>         [FATTR4_FILEID]                 = nfsd4_encode_fattr4_fileid,
> @@ -3674,8 +3688,9 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>                 if (err)
>                         goto out_nfserr;
>         }
> -       if ((attrmask[0] & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID)) &&
> -           !fhp) {
> +       if ((attrmask[0] & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID |
> +                           FATTR4_WORD0_CASE_INSENSITIVE |
> +                           FATTR4_WORD0_CASE_PRESERVING)) && !fhp) {
>                 tempfh = kmalloc(sizeof(struct svc_fh), GFP_KERNEL);
>                 status = nfserr_jukebox;
>                 if (!tempfh)
> @@ -3687,6 +3702,13 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>                 args.fhp = tempfh;
>         } else
>                 args.fhp = fhp;
> +       if (attrmask[0] & (FATTR4_WORD0_CASE_INSENSITIVE |
> +                          FATTR4_WORD0_CASE_PRESERVING)) {
> +               status = nfsd_get_case_info(args.fhp, &args.case_insensitive,
> +                                           &args.case_preserving);
> +               if (status != nfs_ok)
> +                       goto out;
> +       }
>
>         if (attrmask[0] & FATTR4_WORD0_ACL) {
>                 err = nfsd4_get_nfs4_acl(rqstp, dentry, &args.acl);
> --
> 2.52.0
>
>


-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

