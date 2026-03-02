Return-Path: <linux-nfs+bounces-19491-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLbzKjdbpWlc+QUAu9opvQ
	(envelope-from <linux-nfs+bounces-19491-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Mar 2026 10:41:11 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8A81D5AD5
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Mar 2026 10:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91FE7300B451
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Mar 2026 09:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAD732938D;
	Mon,  2 Mar 2026 09:41:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789E728000B
	for <linux-nfs@vger.kernel.org>; Mon,  2 Mar 2026 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444468; cv=none; b=jMRiukfjsX5vOzI2Q7gIBhRB9S6yFSeNv2RUmgGf5r3edYSMK5WE2MADgOReh0YSuOzvtFI1rHPTGzvwuBuivFhwZsjnBDfoXEP4Jl4xG0ej5voQO+KS0tAlj0vIiowdy2AZvDVFI3tvRUN9mzzxN88jE68GKwI8EYnsCwot8+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444468; c=relaxed/simple;
	bh=Ez64KVPyUYsQ2awF9e6vDqNmteH/+x0+y1/m+pgXlFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X8niQagne0UAP0FYLgp7C72XQNKcdRMKRzZarKp++3fqVALivp0ZP+xhanAnBaC0LiYUuqHKmwhvY3FkHIv5h/xVlUf2l9XQNNJhcz6OmVSTgiAswVkDZ82ZQrogxVHe7K528ErBik3zlivnBEraIBKrE6JSdNvB3xz1GVRFZsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56a976305b3so2899094e0c.1
        for <linux-nfs@vger.kernel.org>; Mon, 02 Mar 2026 01:41:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772444466; x=1773049266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVUkTgXHkbBKhiDnIN0oTaONlF7U4tUeTKHJdKgOm5w=;
        b=SYcsSJ5E/7MlUyBTq/v/A+9B8GgZIjBuQuF4GuCh00ClrT0JtPh6RdSR7MjJA8gT8c
         1MUam7QKvGrKiVmPoY43Mm6pr5vGJsF+Tj3pkhOGtIqAFoUx04kdwEw+a000g6WWj8LZ
         grd1TvUw1OrmtnOxovnbeTcZVyWOR0wdWy9zq1U0/5joEOLjguHDyZmbWga3Jmi7kAbs
         yLqWcwoo1/AvegmXUNvF784X6/PLTtc6cKWI2JLrdej+ACQv6AC6tioT5V8+EBT4+58j
         LXG6BClicKaFDNHnwABnrz0sGiJR6bkkPkjo+p4rCs2+bY3Jc9q1XFHQfMB4g68p+CMH
         zLWw==
X-Forwarded-Encrypted: i=1; AJvYcCU/38Pu3ay8Iv2XVf/Gjhmi/uGjV0dx8/6IIiZKYr+jctmcSlIlpLH8ertZzZ04g+MP9JqhLT/A88k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSvxpn+U25ZszdT6o6S6B9z/fGMSeetFMLWoA0SQT8j5F7QP4N
	7BUFzd9Ioljzw9O6C8GraTpBjxgzd3jEqKt8nFCELutHtJ/wsH/0wednFtDrkH8B
X-Gm-Gg: ATEYQzyr7e5SD/pb664hv3/crHZbdW5unPNSccRz/qeOgx2+WQkZi4xpkKUAu239cMD
	6lslYKlnJSuN5Poa7nez6Cd4GzBsO99V+V5harOlsXHeJguElNHEhkBv5kbLZlmRZn8GaepR0bG
	hV7KBsHM4jHBzf5S1aCqGeeyaU2z77RrowUKlhiekBYUr72BxWqGBDTePeDJn1iHhui/l9W1uZv
	HdOgBRO6bbITdmHvuIroSjgjS1pICLWh2Yd6DF/0DvZU9Ja0yZPI1K10cTlN/exQDqOKG2lZnpa
	MtKbK7k6ai5h98v4ZWLdKCgZ5H9iu9oP4SL3RS3pu62UYLLsE5r+0dP4w7T3mog5JmaOowQc+La
	r+rvcOdNrJ04go2Cyc5ejJfb9mykyUMYecW0Wl7YWy2zDxka+tnkEWwV5bsHda2Tc2EUbQadXdP
	0S8AL21p1XFKR8ksUts+G0zRn8NyYhzr/PtFxZ8oQLH3/Cp4lxGoCh2Yxs2GF6
X-Received: by 2002:a05:6122:1c0f:b0:566:22e6:35df with SMTP id 71dfb90a1353d-56aa09f82acmr5737724e0c.5.1772444466591;
        Mon, 02 Mar 2026 01:41:06 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a9229a4d4sm14709465e0c.19.2026.03.02.01.41.05
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 01:41:05 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-944168e8c5fso2435042241.2
        for <linux-nfs@vger.kernel.org>; Mon, 02 Mar 2026 01:41:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6tWxRgMq5im4duIWBFpcjEfaxW3T/jh/u5IVMdj0OpvbCPlVo2zr/bjA5BLswpp4BgrsI6IhE4SQ=@vger.kernel.org
X-Received: by 2002:a05:6102:3747:b0:5f5:3619:8bd1 with SMTP id
 ada2fe7eead31-5ff32494193mr5490525137.25.1772444465487; Mon, 02 Mar 2026
 01:41:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228180821.811683-1-seanwascoding@gmail.com> <20260228180821.811683-2-seanwascoding@gmail.com>
In-Reply-To: <20260228180821.811683-2-seanwascoding@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 2 Mar 2026 10:40:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUvynCH_eqNWr6EWusCWc7z6s-0b6gwQ1B_=mDkkxMd4w@mail.gmail.com>
X-Gm-Features: AaiRm50IkzgTnKIsbY1hU9x7p3C6C39FPDtFYhWApldWfRRArQZieFo-6dS1RfY
Message-ID: <CAMuHMdUvynCH_eqNWr6EWusCWc7z6s-0b6gwQ1B_=mDkkxMd4w@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] sunrpc: simplify dfprintk macros and fix nfsd
 build error
To: Sean Chang <seanwascoding@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Chuck Lever <chuck.lever@oracle.com>, 
	David Laight <david.laight.linux@gmail.com>, nicolas.ferre@microchip.com, 
	claudiu.beznea@tuxon.dev, trond.myklebust@hammerspace.com, anna@kernel.org, 
	netdev@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,oracle.com,gmail.com,microchip.com,tuxon.dev,hammerspace.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-19491-lists,linux-nfs=lfdr.de];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	NEURAL_SPAM(0.00)[0.194];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linux-m68k.org:email,lunn.ch:email]
X-Rspamd-Queue-Id: 0D8A81D5AD5
X-Rspamd-Action: no action

Hi Sean,

On Sat, 28 Feb 2026 at 22:29, Sean Chang <seanwascoding@gmail.com> wrote:
> When CONFIG_SUNRPC_DEBUG is disabled, the dfprintk() macros currently
> expand to empty do-while loops. This causes variables used solely
> within these calls to appear unused, triggering -Wunused-variable
> warnings.
>
> Following David Laight's suggestion, simplify the macro definitions by
> removing the unnecessary 'fmt' argument and using no_printk(__VA_ARGS__)
> directly. This ensures the compiler performs type checking and "sees"
> the variables, silencing the warnings without emitting any code.
>
> Additionally, fix a build error in fs/nfsd/nfsfh.c reported by syzbot.
> In nfsd_setuser_and_check_port(), the variable 'buf' is conditionally
> defined via RPC_IFDEBUG. Since no_printk() now performs type checking,
> it triggers an 'undeclared identifier' error when debug is disabled.
> Wrap the dprintk call in an #if block to synchronize its lifecycle
> with 'buf', following the pattern in svc_rdma_transport.c.
>
> Link: https://lore.kernel.org/all/69a2e269.050a0220.3a55be.003e.GAE@google.com/
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Suggested-by: David Laight <david.laight.linux@gmail.com>
> Signed-off-by: Sean Chang <seanwascoding@gmail.com>

This should have been fixed alteady, cfr.
"Re: [PATCH v3 0/3] sunrpc: Fix `make W=1` build issues"?
https://lore.kernel.org/177024270291.126397.9981743455921781902.b4-ty@oracle.com

> ---
>  fs/nfsd/nfsfh.c              | 2 ++
>  include/linux/sunrpc/debug.h | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index ed85dd43da18..f7386fd483a6 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -106,8 +106,10 @@ static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
>         /* Check if the request originated from a secure port. */
>         if (rqstp && !nfsd_originating_port_ok(rqstp, cred, exp)) {
>                 RPC_IFDEBUG(char buf[RPC_MAX_ADDRBUFLEN]);
> +#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>                 dprintk("nfsd: request from insecure port %s!\n",
>                         svc_print_addr(rqstp, buf, sizeof(buf)));
> +#endif
>                 return nfserr_perm;
>         }
>
> diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
> index eb4bd62df319..cb33c7e1f370 100644
> --- a/include/linux/sunrpc/debug.h
> +++ b/include/linux/sunrpc/debug.h
> @@ -52,8 +52,8 @@ do {                                                                  \
>  # define RPC_IFDEBUG(x)                x
>  #else
>  # define ifdebug(fac)          if (0)
> -# define dfprintk(fac, fmt, ...)       do {} while (0)
> -# define dfprintk_rcu(fac, fmt, ...)   do {} while (0)
> +# define dfprintk(fac, ...)            no_printk(__VA_ARGS__)
> +# define dfprintk_rcu(fac, ...)        no_printk(__VA_ARGS__)
>  # define RPC_IFDEBUG(x)
>  #endif

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

