Return-Path: <linux-nfs+bounces-6551-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC3697C982
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2024 14:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4506B228F6
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2024 12:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE10219D8BB;
	Thu, 19 Sep 2024 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRahBlhY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBA119EEBD
	for <linux-nfs@vger.kernel.org>; Thu, 19 Sep 2024 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726750247; cv=none; b=KVKZQOOZs9ePSS/hi6zmG9mu8FEf2pFQSt+vwz62vtu68f2+RRV6wplk2dz/xzoGDJOsFdETzB0k2Uy5qNuxe9MJ039ciPSbSRGo2xK7C7zFCnpJn0cZua4vI1J9F2kRKD5SYm9L96bTDectlA6OfNkPCmJh375MBs0A9rBo8wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726750247; c=relaxed/simple;
	bh=rn1b1N+sqmeh50lmxKgle8XRZU8t5NmfGALSQ1zoWI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WRmXN0mYZE6QItsnvis4VN6K0tLJZinAc5SXSusWOfqJ8IlkJjVJ58ay9VAuS98h+PqAFT6lE9kG7IX2DDghf2KDVzFKXOXU4avStpiyqKs6x0d645Qt5OHznVHH6W7Ah19FiXpcaA6X+gLOsnDZPkeEYyvzAnjMnnQa+mQTxkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRahBlhY; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c3ed267a7bso1039448a12.3
        for <linux-nfs@vger.kernel.org>; Thu, 19 Sep 2024 05:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726750245; x=1727355045; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IUszBk09m+acU4PcYnDvcpY3szYDX1CxA6maKBwrVas=;
        b=GRahBlhYxw5R3rotR1TWa1M0iPG5EZkv+Fkx6Aonoc5b7mrRfmgzJSa9sH57oEGG3e
         i3vV3KcA+FSoCWQ/dDzVf7Rs9Y848c4F6K/Ijh9ACU1SG+J15jQFfcX2I8Sp+nx5ck1h
         15RjBENAjRyUCy2jV/tjSTqm9T7tywz5lr3QwboUG9YcWhOzraKB7zEspBlLR733qFZM
         +IYzPenimGfTuOmYXu3udpseztjyJKo56HkRIc2t3BVf7fvZzfagC0bklxfe760POANb
         WWGPW39bbFI+Ag6Wg8ZYWjBMM+Rir0gdYvlwqqr9wAZb6x1/G/fRrDLrW+Okas5HGxu5
         T2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726750245; x=1727355045;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IUszBk09m+acU4PcYnDvcpY3szYDX1CxA6maKBwrVas=;
        b=v7aVhhh7BH3I5Yvt3zlPOt07BsIMnkTghD0Djy+y+HNWRLQan9nin4Jioxxu6MkNkv
         Td62hf6EMjGI7qc+7zerQzFcZXWCWS3YVNf4W3jxe9Wg+Siw08ABYLYYledtA7CwDakj
         UzOSFO4HkX+3OOQLMyQJHDZsgdO1ET9EdvbMBPH2I0rGhzJ2vHdlq97YRfw1UhjvaFWz
         aWg+5aC82/NR667p78yYcb2GIRgWTELKFQEFq8s1Yu+hU2XHiRdrRjIE98Ylkm3P+nvK
         bZspW6csygpgqp/a1Yd1kRHs27MwBMXi6PQd+woS1zTozc4v3MDvcQHMRY5FVYL3S8yP
         HHFg==
X-Gm-Message-State: AOJu0YzAZ98uZnv6656YRMRxCOZeEXH2OuAVN+J7HLv1h73C9yr04iOs
	kiqBqgoDcsC4O/G6apcuaEEJdEJRf4Xx5M34OX50AqtGsk6HVrHdY77xC7+Yh3sL15gfiIpP6cW
	8/+unLcWb78nqqQ/E37BL+CDyYj8=
X-Google-Smtp-Source: AGHT+IFyUclM+jMvBeAYvftC3+Xe6bYBlUD7bCP9gnZAzr8Ixoh7eA8KLPIUosWLXM0Pk2IUUDYM9tI/cDUGaulXiS4=
X-Received: by 2002:a05:6402:2746:b0:5c4:9e2:a21d with SMTP id
 4fb4d7f45d1cf-5c413e14171mr23077131a12.12.1726750244486; Thu, 19 Sep 2024
 05:50:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811172607.7804-1-cel@kernel.org>
In-Reply-To: <20240811172607.7804-1-cel@kernel.org>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Thu, 19 Sep 2024 14:50:08 +0200
Message-ID: <CALXu0UfkjJWrzQo0Ovb-RNBJ08xBDZbKUBPmx8J8FXMVpLCAmQ@mail.gmail.com>
Subject: Re: [PATCH] NFSD: Fix NFSv4's PUTPUBFH operation
To: cel@kernel.org
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
	Dan Shelton <dan.f.shelton@gmail.com>, Roland Mainz <roland.mainz@nrubsig.org>
Content-Type: text/plain; charset="UTF-8"

Could this bugfix please be added to the Linux 6.6 LTS branch too?

Ced

On Sun, 11 Aug 2024 at 19:26, <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> According to RFC 8881, all minor versions of NFSv4 support PUTPUBFH.
>
> Replace the XDR decoder for PUTPUBFH with a "noop" since we no
> longer want the minorversion check, and PUTPUBFH has no arguments to
> decode. (Ideally nfsd4_decode_noop should really be called
> nfsd4_decode_void).
>
> PUTPUBFH should now behave just like PUTROOTFH.
>
> Reported-by: Cedric Blancher <cedric.blancher@gmail.com>
> Fixes: e1a90ebd8b23 ("NFSD: Combine decode operations for v4 and v4.1")
> Cc: Dan Shelton <dan.f.shelton@gmail.com>
> Cc: Roland Mainz <roland.mainz@nrubsig.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4xdr.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 42b41d55d4ed..adfafe48b947 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -1245,14 +1245,6 @@ nfsd4_decode_putfh(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
>         return nfs_ok;
>  }
>
> -static __be32
> -nfsd4_decode_putpubfh(struct nfsd4_compoundargs *argp, union nfsd4_op_u *p)
> -{
> -       if (argp->minorversion == 0)
> -               return nfs_ok;
> -       return nfserr_notsupp;
> -}
> -
>  static __be32
>  nfsd4_decode_read(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
>  {
> @@ -2374,7 +2366,7 @@ static const nfsd4_dec nfsd4_dec_ops[] = {
>         [OP_OPEN_CONFIRM]       = nfsd4_decode_open_confirm,
>         [OP_OPEN_DOWNGRADE]     = nfsd4_decode_open_downgrade,
>         [OP_PUTFH]              = nfsd4_decode_putfh,
> -       [OP_PUTPUBFH]           = nfsd4_decode_putpubfh,
> +       [OP_PUTPUBFH]           = nfsd4_decode_noop,
>         [OP_PUTROOTFH]          = nfsd4_decode_noop,
>         [OP_READ]               = nfsd4_decode_read,
>         [OP_READDIR]            = nfsd4_decode_readdir,
> --
> 2.45.2
>


-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

