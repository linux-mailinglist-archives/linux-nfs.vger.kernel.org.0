Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341FC2C11EA
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 18:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390220AbgKWRZO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 12:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgKWRZO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 12:25:14 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1C8C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 09:25:14 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id cq7so17925378edb.4
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 09:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GwHdc8W8H2pO5l9czXldORVagDqXJgS4zeprzvsjaQg=;
        b=bG+iM1OsIwbLBxx302buZnfy0XBMKuVDwlmZEuJ2jzlS3M0b45DjPyEAuJVZ+6Q/uO
         HqI1lJ1eGaOkYHlvc1dFjtvnSWF1hVXw3OOM0EYffAU2TZrKDg0q0dViui1/ZRW8c5cF
         YS14tPDBZUvspIOo+ZoGTaFyWyPD+y77Nvy7FaWAjiEF6q+dD1vUpNGDerXX/k+01JqU
         QD7Qav28I7jenxBISC9xzZ4Q6a1yxQxRpy2YlG8R3OZGWUH0SIPRY7Gg+CQxkMTCSEO2
         pqrhw7JSnot1vety56a4UdRQqLfvOBFLAy1Ru9N8oUcQ7R32Kb+8dstr3+Erby9RzPO/
         y/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GwHdc8W8H2pO5l9czXldORVagDqXJgS4zeprzvsjaQg=;
        b=nIyg738sjxXzDSeY7XsLyk5Ts2RQ00TbPBCwQgMvKs2R075zcMmRbgZQLq+lKE5jor
         oIanvB2OuQdxWUxFo5exqm8vMJ8gb+pWdWa29t9+b/wqi4ur4oI9htJYuhZmOE6ZhZHZ
         EoLBQhYk74dTaE8y7C+yJa8ADZmMAt3qhlN7DrT8fEzlmBvNM4Loov35tNfy7OJUKasc
         jec81NdOvYqQiqp5WaD2TIGP8R71WUbKBl1ceKFgx+rtlejjxhMXAi3aJQ+eaY+wdNWh
         0rbhW46nF+9bcXQ89TgSmygXeMj4rrtOoyvDaqlfsXSf5TRlobKYFcrXxrhgQzm6H85a
         zF6Q==
X-Gm-Message-State: AOAM531GNb6DZR5mbgVnat5+OYnLNAsQlI+d5I/AwjGiXTEJVD9+3Mv7
        OdCwRfuzQxI6XusSFRfuXO/8fUUdYjWyheVv18rEi3MZnNc=
X-Google-Smtp-Source: ABdhPJy3UNVtlqd72k5y9o+SoOX4Q4d0j4BxrxS3lwjRA4cjQCeopmz8SQ5lU7+HC+HzS4HRWZDmpClbxYDl6+eDI9E=
X-Received: by 2002:a05:6402:1a22:: with SMTP id be2mr264840edb.102.1606152313055;
 Mon, 23 Nov 2020 09:25:13 -0800 (PST)
MIME-Version: 1.0
References: <20201122205229.3826-1-trondmy@kernel.org> <20201122205229.3826-2-trondmy@kernel.org>
 <20201122205229.3826-3-trondmy@kernel.org> <20201122205229.3826-4-trondmy@kernel.org>
 <20201122205229.3826-5-trondmy@kernel.org> <20201122205229.3826-6-trondmy@kernel.org>
In-Reply-To: <20201122205229.3826-6-trondmy@kernel.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Mon, 23 Nov 2020 12:24:57 -0500
Message-ID: <CAFX2JfnwQb1SbK68y14P6-E7WWwPKd3TvOFQ342K0GhDds3gjA@mail.gmail.com>
Subject: Re: [PATCH 5/8] SUNRPC: Don't truncate tail in xdr_inline_pages()
To:     trondmy@kernel.org
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

On Sun, Nov 22, 2020 at 4:07 PM <trondmy@kernel.org> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> True that if the length of the pages[] array is not 4-byte aligned, then
> we will need to store the padding in the tail, but there is no need to
> truncate the total buffer length here.

Just a heads up, after applying this patch there are a *lot* of
xfstests that fail when run on v4.2 against a server that supports
READ_PLUS

Anna

>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  net/sunrpc/xdr.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index 3ce0a5daa9eb..5a450055469f 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -193,9 +193,6 @@ xdr_inline_pages(struct xdr_buf *xdr, unsigned int offset,
>
>         tail->iov_base = buf + offset;
>         tail->iov_len = buflen - offset;
> -       if ((xdr->page_len & 3) == 0)
> -               tail->iov_len -= sizeof(__be32);
> -
>         xdr->buflen += len;
>  }
>  EXPORT_SYMBOL_GPL(xdr_inline_pages);
> --
> 2.28.0
>
