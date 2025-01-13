Return-Path: <linux-nfs+bounces-9161-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5029DA0B918
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 15:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512AA16769B
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 14:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD1023ED51;
	Mon, 13 Jan 2025 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="Q4gEECcW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5129E23ED45
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736777467; cv=none; b=lZEO+sUyuSY6neTram0Sa+fgF0qzbZPyuLnT4MwktEOlUGygncD5Wt2wGJs0oxnb86Pl2C5cKH5BSiLSneFAcamauu4srCqLhB0Dpxu/NDeTpM/yUxZ29RMe+4CuMISQ7wIbU81TfH2c/KuKo3hvI3dSryPSfv62KeFhzGpH48s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736777467; c=relaxed/simple;
	bh=GO//HiI4oET7/f+KN4ye0ACAV2rFNdB3wLHJ41mvk5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bnUjicaEVEov0XRYpQ0Cr01M1M+IrLkWEQTj5lcRUmfDmBFTfvvpPsomD2uoZ7ZYQrnxZN8yo+9Ku/uAFmsfgmj315Pf2Nudt6DSCrTyyE//Rmy8nc6WxcOjBjCqS6KIugfnwanXXSlnPW11CIeTYTXElohwYdBQq5Oq9btPNu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=Q4gEECcW; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-304d760f118so31734961fa.0
        for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 06:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1736777462; x=1737382262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vRCqK0peSPIVSVFjQlDmnBp4h3q/k7B+gxHYQ8lTtU=;
        b=Q4gEECcWEWFUhbiFatQHE5n9h9XdJp6fVOSHWAupT7R8vtEiD7eXViT130fEd6K0Aa
         zB2v3LNofZk6J5WEQPwlNenBVL2LdalWwPY+TpJtJ4+F+qiJX/P7TPWtqT/RabKBFeWK
         C8OhyLqDRv8adiB5oQTNRzRP8s/WtAlXb6H+EF1+8YNhMSkbJ8YNo8eKYbh3oD101u+e
         hV/nMrAp83v1EC1MWBc7Dl+S+zC2ka2fdwYEp+CRl+VxVOlfc5gheBhNVmd5BxzePadx
         dPoDHIb6DvLqFqiOoo1fC9LZejxwy/glDNlN7lPMIgipcuSpUZJs58eKEXUFt9/xpVeU
         hW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736777462; x=1737382262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vRCqK0peSPIVSVFjQlDmnBp4h3q/k7B+gxHYQ8lTtU=;
        b=T6fIPkvapXs5fWKT7AS+2OiUsefZBXZvXCn8owtQN0rZ5pLkmbxqckMAErk3pUM0N5
         F/ddJ0DE4Ss/0Nfi59Axf9XGtNEjswME+vFiJ3Mh4AfVg8O1ehfGbxh3wIlHxPo89Y5o
         DYoegoJPamnG90ATKTrYZZZL1aJoHKPgIRR3UvjG2np88rjaQ8EVX8dJp2ym2XcbDBKP
         dXly2+reSynQOsS0gXRLxlvwc1FCLLNMA9SGbqiBxAMb5Xt7Chvo3wrmqaBJu9fkRzay
         1U2pl2209eHDh1YYJ3YL6rXZyeAIEmWY27viUI3FxHxLCXto+Sn4G55C+M8NlEC6GSZT
         wD4Q==
X-Gm-Message-State: AOJu0YxJlno1Sskd3QXiaDg4juj3h1AV48uy874nClAGR0G1eWg6hbkk
	t3bS2RraaBNtvgyVQ6spk2ko5XOFhnIqrZ7WH5hftyAmWd+/jNfD24C8/HLp4Yl1N69i8EOnzeF
	rTLnnIfPm4fZ9shud16eYgrVldNQ=
X-Gm-Gg: ASbGncsWoy0Yj9icr2U4VtPtuZBSlDwAdroZSKHG+5IOf+bwy6oLgWM1pN0V/30aaei
	95OsQYFBOu768RI3tRiV6w6Mlnx77FT1Csa/xBI8NCAK7xrhttWbi1MAGd+2+4UdvEpae0OLv
X-Google-Smtp-Source: AGHT+IFC1ahATxiwTpsRceTZSWDDtEhlKf9Z3QAboNwrZlYDciMd6ZdpLWrOpuh65SwTac3kiyJw3Vtr8Z1zfmjXBhQ=
X-Received: by 2002:a05:651c:1582:b0:306:1302:8c48 with SMTP id
 38308e7fff4ca-30613028d87mr27608811fa.30.1736777462055; Mon, 13 Jan 2025
 06:11:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108213632.260498-1-anna@kernel.org> <20250108213632.260498-4-anna@kernel.org>
In-Reply-To: <20250108213632.260498-4-anna@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Mon, 13 Jan 2025 09:10:50 -0500
X-Gm-Features: AbW1kvbIlo-VNUaNwUGCu9Ihh8ut8R2cg18oZVXJ4rsPciYogMu5QjwLoIX49tQ
Message-ID: <CAN-5tyGk_Nh4u_m=gEEGH8DbdzoU7XU-2PhOWC3xbBdvEi-SDQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] sunrpc: Add a sysfs file for adding a new xprt
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 4:36=E2=80=AFPM Anna Schumaker <anna@kernel.org> wro=
te:
>
> From: Anna Schumaker <anna.schumaker@oracle.com>
>
> Writing to this file will clone the 'main' xprt of an xprt_switch and
> add it to be used as an additional connection.
>
> Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
> ---
>  include/linux/sunrpc/xprtmultipath.h |  1 +
>  net/sunrpc/sysfs.c                   | 54 ++++++++++++++++++++++++++++
>  net/sunrpc/xprtmultipath.c           | 21 +++++++++++
>  3 files changed, 76 insertions(+)
>
> diff --git a/include/linux/sunrpc/xprtmultipath.h b/include/linux/sunrpc/=
xprtmultipath.h
> index c0514c684b2c..c827c6ef0bc5 100644
> --- a/include/linux/sunrpc/xprtmultipath.h
> +++ b/include/linux/sunrpc/xprtmultipath.h
> @@ -56,6 +56,7 @@ extern void rpc_xprt_switch_add_xprt(struct rpc_xprt_sw=
itch *xps,
>                 struct rpc_xprt *xprt);
>  extern void rpc_xprt_switch_remove_xprt(struct rpc_xprt_switch *xps,
>                 struct rpc_xprt *xprt, bool offline);
> +extern struct rpc_xprt *rpc_xprt_switch_get_main_xprt(struct rpc_xprt_sw=
itch *xps);
>
>  extern void xprt_iter_init(struct rpc_xprt_iter *xpi,
>                 struct rpc_xprt_switch *xps);
> diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
> index dc3b7cd70000..ce7dae140770 100644
> --- a/net/sunrpc/sysfs.c
> +++ b/net/sunrpc/sysfs.c
> @@ -250,6 +250,55 @@ static ssize_t rpc_sysfs_xprt_switch_info_show(struc=
t kobject *kobj,
>         return ret;
>  }
>
> +static ssize_t rpc_sysfs_xprt_switch_add_xprt_show(struct kobject *kobj,
> +                                                  struct kobj_attribute =
*attr,
> +                                                  char *buf)
> +{
> +       return sprintf(buf, "# add one xprt to this xprt_switch\n");
> +}
> +
> +static ssize_t rpc_sysfs_xprt_switch_add_xprt_store(struct kobject *kobj=
,
> +                                                   struct kobj_attribute=
 *attr,
> +                                                   const char *buf, size=
_t count)
> +{
> +       struct rpc_xprt_switch *xprt_switch =3D
> +               rpc_sysfs_xprt_switch_kobj_get_xprt(kobj);
> +       struct xprt_create xprt_create_args;
> +       struct rpc_xprt *xprt, *new;
> +
> +       if (!xprt_switch)
> +               return 0;
> +
> +       xprt =3D rpc_xprt_switch_get_main_xprt(xprt_switch);
> +       if (!xprt)
> +               goto out;
> +
> +       xprt_create_args.ident =3D xprt->xprt_class->ident;
> +       xprt_create_args.net =3D xprt->xprt_net;
> +       xprt_create_args.dstaddr =3D (struct sockaddr *)&xprt->addr;
> +       xprt_create_args.addrlen =3D xprt->addrlen;
> +       xprt_create_args.servername =3D xprt->servername;
> +       xprt_create_args.bc_xprt =3D xprt->bc_xprt;
> +       xprt_create_args.xprtsec =3D xprt->xprtsec;
> +       xprt_create_args.connect_timeout =3D xprt->connect_timeout;
> +       xprt_create_args.reconnect_timeout =3D xprt->max_reconnect_timeou=
t;
> +
> +       new =3D xprt_create_transport(&xprt_create_args);
> +       if (IS_ERR_OR_NULL(new)) {
> +               count =3D PTR_ERR(new);
> +               goto out_put_xprt;
> +       }
> +
> +       rpc_xprt_switch_add_xprt(xprt_switch, new);

Before adding a new transport don't we need to check that we are not
at or over the limit of how many connections we currently have (not
over nconnect limit and/or over the session trunking limit)?

> +       xprt_put(new);
> +
> +out_put_xprt:
> +       xprt_put(xprt);
> +out:
> +       xprt_switch_put(xprt_switch);
> +       return count;
> +}
> +
>  static ssize_t rpc_sysfs_xprt_dstaddr_store(struct kobject *kobj,
>                                             struct kobj_attribute *attr,
>                                             const char *buf, size_t count=
)
> @@ -451,8 +500,13 @@ ATTRIBUTE_GROUPS(rpc_sysfs_xprt);
>  static struct kobj_attribute rpc_sysfs_xprt_switch_info =3D
>         __ATTR(xprt_switch_info, 0444, rpc_sysfs_xprt_switch_info_show, N=
ULL);
>
> +static struct kobj_attribute rpc_sysfs_xprt_switch_add_xprt =3D
> +       __ATTR(xprt_switch_add_xprt, 0644, rpc_sysfs_xprt_switch_add_xprt=
_show,
> +               rpc_sysfs_xprt_switch_add_xprt_store);
> +
>  static struct attribute *rpc_sysfs_xprt_switch_attrs[] =3D {
>         &rpc_sysfs_xprt_switch_info.attr,
> +       &rpc_sysfs_xprt_switch_add_xprt.attr,
>         NULL,
>  };
>  ATTRIBUTE_GROUPS(rpc_sysfs_xprt_switch);
> diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
> index 720d3ba742ec..a07b81ce93c3 100644
> --- a/net/sunrpc/xprtmultipath.c
> +++ b/net/sunrpc/xprtmultipath.c
> @@ -92,6 +92,27 @@ void rpc_xprt_switch_remove_xprt(struct rpc_xprt_switc=
h *xps,
>         xprt_put(xprt);
>  }
>
> +/**
> + * rpc_xprt_switch_get_main_xprt - Get the 'main' xprt for an xprt switc=
h.
> + * @xps: pointer to struct rpc_xprt_switch.
> + */
> +struct rpc_xprt *rpc_xprt_switch_get_main_xprt(struct rpc_xprt_switch *x=
ps)
> +{
> +       struct rpc_xprt_iter xpi;
> +       struct rpc_xprt *xprt;
> +
> +       xprt_iter_init_listall(&xpi, xps);
> +
> +       xprt =3D xprt_iter_get_xprt(&xpi);
> +       while (xprt && !xprt->main) {
> +               xprt_put(xprt);
> +               xprt =3D xprt_iter_get_next(&xpi);
> +       }
> +
> +       xprt_iter_destroy(&xpi);
> +       return xprt;
> +}
> +
>  static DEFINE_IDA(rpc_xprtswitch_ids);
>
>  void xprt_multipath_cleanup_ids(void)
> --
> 2.47.1
>
>

