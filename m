Return-Path: <linux-nfs+bounces-3700-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8636C905B05
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 20:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB301C21051
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 18:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165A844C94;
	Wed, 12 Jun 2024 18:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bc+xSlb1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877D92904
	for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718217173; cv=none; b=qTHJkMUp2t42Ts5rNaVJwmW+EmXcTxb0eHYXgTyv5ZBH7vFmJfEvG9bewoI6+9qos+4XkY73czBUXStkh3YOM7CFaOmv7btXzRNTWZ/xy+q+lWD7HfxQfud3HI9jZs0IH0PmQ9Fg9Zlu/a0GSrOZ99JC3Gv53FT4ppHAomxrSDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718217173; c=relaxed/simple;
	bh=a3+p3EAZcB0xSLcU7opoqp0iLsc1TkQYl5xKhhfDEcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJLI0H25PBQXIHjcCFQn41OOfUgjz7aqQLMg1BW5ClRb73jpygL8MzL9siIO0JhzQFPByLkDKmkHxrCSvO47rzCACmjinW1F9/EEKjt916TAQ60DYUIQGvEMPUDgYw5qx1wApeCspMbTgbrJaV7OAeQHT4lmcTK2lm+BtHgnf98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bc+xSlb1; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dff0067a263so85910276.0
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 11:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718217170; x=1718821970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5i/skRD2quMcTyYnwVbUKZlZCHQA4ZuEb9+voXWami0=;
        b=Bc+xSlb1OgMJRRgv8jnYacEkDBGEDE5oTumsNKEa79P5IZ5GOd6BnjH5G3XLiICGWY
         C2icMBiegihikTvIWxeKmhr3i/U58nvgohzL1fm+3HMM7it4dNgYDdHjk+WkFjYSlG2w
         vYoVdCokWvIUcTZV4spEXjp3TEWbte7XoFHyAKNYcpcgAV3TpttNqofPqnp5c0UUT0sq
         rAi6XWXS+ocICIH5+5yxZgYgcdkJ3yGEvZneUuZuEYNV46ijPJ2fjFzamF7RkrSBa6Tr
         34i6RVFV63gpe9N9EjWSz9ytkr/15TiljeFVTbGS/uNeN6DtRJ89IgVFtXY85LYjVAQB
         zBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718217170; x=1718821970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5i/skRD2quMcTyYnwVbUKZlZCHQA4ZuEb9+voXWami0=;
        b=hvSzkyPc3QYXTxEJjAhGfPehAlVLItj5dohXDxDrmupKc5LvKaT3gdn79qjL8KzX30
         1QV2Tv/ivOd3U1HjPvApkXYWa3vxICNx4v7/CHHnHoiyNQRLoX9bmGPIAGiT84ubwsXT
         06KNWEjQlcJ9x5dY/WcjFwa3OUA82jJ7ptzyVhf+FwXTwqLO/vcZHfSS5EX8PJvfyQha
         IJSYQk71P4Af8/1MJGl6l8c+QalJ+16/rmdp99t7fRGcW9j2Zr1yfoxI4XZInJM+glyx
         g+kCrm2FxND5kZ0eYByimS+TDTUfLd25/AZPOQZwr7JTEX5u3lv51/ww8O129zfy9wg9
         eGbg==
X-Gm-Message-State: AOJu0YxugVcCNH1GX/567S/ibShMTvs4RXlwWGhuX4UKYLlXbawDoMKo
	B+Zy9m3A4vgpHYg+onHcleZZH8OXMq7CaHj3W7OHRAWOhx/ucddoMYBhUm+Yqa9eiGkjNhfOsXT
	06VXK8N8XAYO8vbyHZjc+fmT/4ik=
X-Google-Smtp-Source: AGHT+IEsnjUZtUhX5llUu20P8WLuKMxnNpV9Z7vcJv7d9P7vVSXVd9psxH22slbZS78MphwPhP6ba8CTH78GRg2KKY4=
X-Received: by 2002:a25:74c8:0:b0:dfa:727c:d965 with SMTP id
 3f1490d57ef6-dfe68c0de68mr2557356276.45.1718217170384; Wed, 12 Jun 2024
 11:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612030752.31754-1-snitzer@kernel.org> <20240612030752.31754-5-snitzer@kernel.org>
In-Reply-To: <20240612030752.31754-5-snitzer@kernel.org>
From: Anna Schumaker <schumaker.anna@gmail.com>
Date: Wed, 12 Jun 2024 14:32:34 -0400
Message-ID: <CAFX2Jfmn02+Y1tcjNnvLbyKyG36b7KRRnhyZUUsjFYPvkPjL1A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/15] sunrpc: add rpcauth_map_to_svc_cred_local
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Trond Myklebust <trondmy@hammerspace.com>, 
	NeilBrown <neilb@suse.de>, snitzer@hammerspace.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On Tue, Jun 11, 2024 at 11:08=E2=80=AFPM Mike Snitzer <snitzer@kernel.org> =
wrote:
>
> From: Weston Andros Adamson <dros@primarydata.com>
>
> Add new funtion rpcauth_map_to_svc_cred_local which maps a generic
> rpc_cred to an svc_cred suitable for use in nfsd.
>
> This is needed by the localio code to map nfs client creds to nfs
> server credentials.
>
> Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  include/linux/sunrpc/auth.h |  4 ++++
>  net/sunrpc/auth.c           | 17 +++++++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/include/linux/sunrpc/auth.h b/include/linux/sunrpc/auth.h
> index 61e58327b1aa..f8b561cf78ab 100644
> --- a/include/linux/sunrpc/auth.h
> +++ b/include/linux/sunrpc/auth.h
> @@ -11,6 +11,7 @@
>  #define _LINUX_SUNRPC_AUTH_H
>
>  #include <linux/sunrpc/sched.h>
> +#include <linux/sunrpc/svcauth.h>
>  #include <linux/sunrpc/msg_prot.h>
>  #include <linux/sunrpc/xdr.h>
>
> @@ -184,6 +185,9 @@ int                 rpcauth_uptodatecred(struct rpc_t=
ask *);
>  int                    rpcauth_init_credcache(struct rpc_auth *);
>  void                   rpcauth_destroy_credcache(struct rpc_auth *);
>  void                   rpcauth_clear_credcache(struct rpc_cred_cache *);
> +bool                   rpcauth_map_to_svc_cred_local(struct rpc_auth *,
> +                                                     const struct cred *=
,
> +                                                     struct svc_cred *);
>  char *                 rpcauth_stringify_acceptor(struct rpc_cred *);
>
>  static inline
> diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
> index 04534ea537c8..f75728922d57 100644
> --- a/net/sunrpc/auth.c
> +++ b/net/sunrpc/auth.c
> @@ -308,6 +308,23 @@ rpcauth_init_credcache(struct rpc_auth *auth)
>  }
>  EXPORT_SYMBOL_GPL(rpcauth_init_credcache);
>
> +bool
> +rpcauth_map_to_svc_cred_local(struct rpc_auth *auth, const struct cred *=
cred,
> +                             struct svc_cred *svc)
> +{
> +       svc->cr_uid =3D cred->uid;
> +       svc->cr_gid =3D cred->gid;
> +       svc->cr_flavor =3D auth->au_flavor;
> +       if (cred->group_info)
> +               svc->cr_group_info =3D get_group_info(cred->group_info);
> +       /* These aren't relevant for local (network is bypassed) */
> +       svc->cr_principal =3D NULL;
> +       svc->cr_gss_mech =3D NULL;
> +
> +       return true;
> +}

This function doesn't have a way to fail, and only ever returns true.
Could it be a void function instead of bool?

Anna

> +EXPORT_SYMBOL_GPL(rpcauth_map_to_svc_cred_local);
> +
>  char *
>  rpcauth_stringify_acceptor(struct rpc_cred *cred)
>  {
> --
> 2.44.0
>
>

