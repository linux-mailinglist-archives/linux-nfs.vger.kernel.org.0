Return-Path: <linux-nfs+bounces-11665-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D5EAB3DFE
	for <lists+linux-nfs@lfdr.de>; Mon, 12 May 2025 18:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC66189E525
	for <lists+linux-nfs@lfdr.de>; Mon, 12 May 2025 16:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3591186352;
	Mon, 12 May 2025 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZfJhgL6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA5424466F;
	Mon, 12 May 2025 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747068338; cv=none; b=h0VWay3xD+EJKaQ+C4EGHARWjxEpS0PsmbMO5B96fE3aSobtFmcBJj84K2wuMRaYjyFX9D70Jy/MJ6PiSuBubwT2alCSy506cjX9HsZItnd5Ha2nE/MXZdu3LZpSSFeMAVdGYjxYSVexOhh4t7JtnU0nkC6M6UWQimj8sW460Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747068338; c=relaxed/simple;
	bh=3cNsJ5XKANhnFlHHP5V67Kqig8yQRfmu9Hzht88q7Zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcikzUvopM5ROAKXdzkrNVVrovTA88UpcA8UDGr6m2Ln7qw7XC6kaUXkk8iSuEvBMJnPRsctHcShRNyvgjFK94XKOa+E46xeAHOBYDOH2Vuzgqsvnz9FMJCnAYRAdOS0Kc9OtvZ/VxQZ/eB0dWKxFBDN5vabbSIAdfVF5aCFZ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZfJhgL6; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3f8ae3ed8f4so3148332b6e.3;
        Mon, 12 May 2025 09:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747068334; x=1747673134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28bHjoM3NI7d+it6gZVKWxpCF7REs/xtIqftgGgcLuo=;
        b=nZfJhgL6tHGd2YQ1DxLKIVmh7n6IHq4oMWGnYf3yAGPFTb1r8egSQuztf2UwHEFAnt
         hZsRdrclzndWOxZfKT5igSYJeVSlXFRaFsVhRhjgkoJbyVyN9xVKNJ/3SodxQzRpkNgT
         TI3FE48v9UMCCj1zit2cP87ciu2zmOdBjtpFuCJSm9kAOF+pHq2fNhHYm/jzok3x6Mky
         pU0oNyLE6NJOHhZpnpghpgFBC/tbdGlwQXhDOxzS/y80TnZpaPA3BUFRRMjgn4Ffuiuy
         Mr7oUANL+xNyGxIQlWj3OHjxvLE+PTJL5hLsNMzcVd/8ZsH3ffpXZqbBlvlfP4RwFUqk
         Th3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747068334; x=1747673134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28bHjoM3NI7d+it6gZVKWxpCF7REs/xtIqftgGgcLuo=;
        b=AhXbOwskCtOZQa0eTEMmrg4aoyHHXg079o4mbAMHHrs8o8x9uoKbC/QIEN4tg4s+e6
         rEhx5V5cJpST+lJe3c3wCSYh+LlShHAOQIbWwqZpJTJKZFg9Tm5XHL1mi676dSfZDGc8
         pt71ADqxFt42ocF1/qymHW+kzqY6kRwJUTYvqgJpzid+ijCBP11EZJEFf9XBZyx4y60Y
         KjsmeO6+OE05Ku2226wOlBBvV//t6KQyd2ZTug0T7wfiEjCTnPJA10dRCmyNFpyKFZeF
         +bHkQOh+nM0SdrlDSZTtjWzDYbJJ3rooroAhziUZ8LdLe+6K3hkGzlLMX8fwm2SUnDw2
         dhcg==
X-Forwarded-Encrypted: i=1; AJvYcCUlfQNUu4AXUa85WNkI2W+EJTkoxbmZkDPluZUW9+lk9bnJB21bkeCms7t9ITIQ4chZmsrKzZOFJtbglQ==@vger.kernel.org, AJvYcCXS6/8JuSp5yGCwJt1FUyqVmeUOGtT/MI5h4wFRniHKSOwhqM25DsB/fD6CL8GJoOXu2c3oaLilFsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyhqHY6F41CxKT97UJeFKYuOuZcUg6w7IUXT4WPSh6UEvnozak
	vfmGq12VUjJJNPoR9L3gT4ZuzpEd5ZHX/C1VStg2yY0MrqAwYnaiuN15A6JTCFZKJu8fvHilukE
	cIUYUV8Co9u5BszyVq8ft1DoS1/RvU2TzTO4=
X-Gm-Gg: ASbGncvhvbDJ/Bb9EtpbGyr+GJYuFnLhj44bGqbyqJDg+zrrcFh+qzGYsrZGV02z5zv
	svsRf9JH3MyHS+uK0B4rGUeO11i/5IFkcAsQ5rgHDfsP1Wk8J8wo0de4W3am88wn/FtKnH1HnZq
	V/Cju2yshzwxlMmZUSy8qZQpy0YPAeOqyO
X-Google-Smtp-Source: AGHT+IEE4sInHMDd0rZO8jgtSEVYGoDezP7Z4quZYMviDLTbJH1x4M08hk8N78mkLzDbu80Qwc5NeDjiDDliGniPwZw=
X-Received: by 2002:a05:6808:2014:b0:3fb:174f:821d with SMTP id
 5614622812f47-4037fe8b96dmr9052208b6e.35.1747068334326; Mon, 12 May 2025
 09:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509190354.5393-1-cel@kernel.org> <20250509190354.5393-20-cel@kernel.org>
In-Reply-To: <20250509190354.5393-20-cel@kernel.org>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Mon, 12 May 2025 18:44:58 +0200
X-Gm-Features: AX0GCFuDlN5zQ4LtvrT7SJm8-QGSakTG5Am_h88-kPV0x3gX8V4Uab2m9T57BBY
Message-ID: <CA+1jF5pLds8XYfsBqVsJOmr4b+YaXPdHzUNWmtx8aQLec6UKZQ@mail.gmail.com>
Subject: Re: [PATCH v5 19/19] SUNRPC: Bump the maximum payload size for the server
To: cel@kernel.org
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Could this patch series - minus the change to the default of 1MB - be
promoted to Linux 6.6 LongTermSupport, please?

Aur=C3=A9lien

On Fri, May 9, 2025 at 9:06=E2=80=AFPM <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Increase the maximum server-side RPC payload to 4MB. The default
> remains at 1MB.
>
> An API to adjust the operational maximum was added in 2006 by commit
> 596bbe53eb3a ("[PATCH] knfsd: Allow max size of NFSd payload to be
> configured"). To adjust the operational maximum using this API, shut
> down the NFS server. Then echo a new value into:
>
>   /proc/fs/nfsd/max_block_size
>
> And restart the NFS server.
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Reviewed-by: NeilBrown <neil@brown.name>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/sunrpc/svc.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index d57df042e24a..48666b83fe68 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -119,14 +119,14 @@ void svc_destroy(struct svc_serv **svcp);
>   * Linux limit; someone who cares more about NFS/UDP performance
>   * can test a larger number.
>   *
> - * For TCP transports we have more freedom.  A size of 1MB is
> - * chosen to match the client limit.  Other OSes are known to
> - * have larger limits, but those numbers are probably beyond
> - * the point of diminishing returns.
> + * For non-UDP transports we have more freedom.  A size of 4MB is
> + * chosen to accommodate clients that support larger I/O sizes.
>   */
> -#define RPCSVC_MAXPAYLOAD      (1*1024*1024u)
> -#define RPCSVC_MAXPAYLOAD_TCP  RPCSVC_MAXPAYLOAD
> -#define RPCSVC_MAXPAYLOAD_UDP  (32*1024u)
> +enum {
> +       RPCSVC_MAXPAYLOAD       =3D 4 * 1024 * 1024,
> +       RPCSVC_MAXPAYLOAD_TCP   =3D RPCSVC_MAXPAYLOAD,
> +       RPCSVC_MAXPAYLOAD_UDP   =3D 32 * 1024,
> +};
>
>  extern u32 svc_max_payload(const struct svc_rqst *rqstp);
>
> --
> 2.49.0
>
>


--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

