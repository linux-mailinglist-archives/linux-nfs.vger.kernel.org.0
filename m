Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE10E3E2FBD
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 21:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243819AbhHFTP3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Aug 2021 15:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243805AbhHFTP3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Aug 2021 15:15:29 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9D1C0613CF
        for <linux-nfs@vger.kernel.org>; Fri,  6 Aug 2021 12:15:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g21so14514421edb.4
        for <linux-nfs@vger.kernel.org>; Fri, 06 Aug 2021 12:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M8TPBrLeahG3PU+HlKP+EzZ3APv60mD018i2Qe5LF3A=;
        b=UfndfxCSDP/pKTtT4FSlU9HhUsx8rj6Iv0RpBpifOJhKLpABhyrSNMFwiSp3OcQtxD
         1v/SN6zf+u4cp0LH8HUcj7hd1AAh9z8QudEmHVcYRuX1pbI58uTatpLaQO4XYgRgBYB/
         Nzy84TYnmX9WhoW+VglVMjMg0PL1BrksYHNAqEq6zzoH71FpM5dT72EK4Rm/0pgk+kLw
         smZY2E6KI5gRRwp+zZOa789dQsifboNzTap2+u1wsC8eW53joeWYKK75a+GyvKN1S2QD
         rkSTEkFUrtSPRTaRLtaNmNJcVxpps57ghqx6PNUsufS6U8TrPaqYfnMkD1riyjFAuH3Z
         GlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M8TPBrLeahG3PU+HlKP+EzZ3APv60mD018i2Qe5LF3A=;
        b=NzwJexRPucElCnp8S9zLVhgwNBDW2ihQJCuoUMg0Kz58r10DIJRtWRrzh7evJUuYRx
         CI4CENHJJdQTFzxpvd/KICM6Sz1ixKgCg6As0eKyZkz/NbD84xuX4xZqrpPwYAFcfwKr
         bisFYC2cN/9VHtLCswP/rVpfw5HBZNSI0/uitgT+wxyI44LYCCNB2NuhZtQRvOpmU7AH
         RguTUsWaXzX0kZOIO7KxgJ8IkxZOxuFXEbAHDrW0/hQopDzWfgsUZHIPxXuHu8YOTXCG
         BI1PrLmLEgpb8e3N4pUKSaZNVeiHIL0eoGBB4zFTiIe1grBQo7YQthN/n1ePyAzhLuJE
         cWdQ==
X-Gm-Message-State: AOAM532O36vqFNgCd2FQLSxiyn9wcPM2qbWC9n51L0GgLizxfKyx4M+g
        OND8+gcI0QKebP6ABGxCZtJF9dvAmwR49Kde5N0=
X-Google-Smtp-Source: ABdhPJxE16tXhsH/EMeG/5iVRtY85u3S2vwrnFj/QR0oM52Qv+E89lXIQiFg6EgURDwfliZyzpQ1oQ96f1TlYw+Ea/Q=
X-Received: by 2002:a05:6402:3128:: with SMTP id dd8mr15405265edb.367.1628277310533;
 Fri, 06 Aug 2021 12:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <ee45aa412acaf7a2c035ad98e966394a7293dd9f.camel@redhat.com> <e0e036cb4e438fdeb5ed1b8a988dcb170907f012.camel@redhat.com>
In-Reply-To: <e0e036cb4e438fdeb5ed1b8a988dcb170907f012.camel@redhat.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 6 Aug 2021 15:14:59 -0400
Message-ID: <CAN-5tyFv58duZSrFW9-DtCnA5DQ8j6FayFKvWqM9LvqL0Njj7Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] nfs-utils: Fix potential memory leaks in idmap
To:     Alice Mitchell <ajmitchell@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 6, 2021 at 12:21 PM Alice Mitchell <ajmitchell@redhat.com> wrote:
>
>
> Signed-off-by: Alice Mitchell <ajmitchell@redhat.com>
> ---
>  support/nfsidmap/nss.c   | 4 ++--
>  support/nfsidmap/regex.c | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/support/nfsidmap/nss.c b/support/nfsidmap/nss.c
> index 669760b..f00bd9b 100644
> --- a/support/nfsidmap/nss.c
> +++ b/support/nfsidmap/nss.c
> @@ -365,9 +365,9 @@ static int _nss_name_to_gid(char *name, gid_t *gid,
> int dostrip)
>  out_buf:
>         free(buf);
>  out_name:
> -       if (dostrip)
> +       if (localname)
>                 free(localname);
> -       if (get_reformat_group())
> +       if (ref_name)
>                 free(ref_name);

Do we even need to check for null before freeing these days? man page
says if null is passed then it's a no-op.

If we are not allowed to free a null then there is another patch in
the series in the mountd code that does intentionally do a free of
null pointers.

>  out:
>         return err;
> diff --git a/support/nfsidmap/regex.c b/support/nfsidmap/regex.c
> index fdbb2e2..958b4ac 100644
> --- a/support/nfsidmap/regex.c
> +++ b/support/nfsidmap/regex.c
> @@ -157,6 +157,7 @@ again:
>         IDMAP_LOG(4, ("regexp_getpwnam: name '%s' mapped to '%s'",
>                   name, localname));
>
> +       free(localname);
>         *err_p = 0;
>         return pw;
>
> --
> 2.27.0
>
>
