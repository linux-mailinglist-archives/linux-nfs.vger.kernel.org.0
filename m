Return-Path: <linux-nfs+bounces-21241-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOzgC05s8GkITAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21241-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 10:14:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2994047FB74
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 10:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E230B30148A9
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 08:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7AF1A0728;
	Tue, 28 Apr 2026 08:13:37 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF2035C1B0
	for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2026 08:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364017; cv=none; b=Be4mXf3ksL3uYa0SDlQvHtpJOB1vqba5RtTIWvuJtYAMrh+JQBSQv4MKqHZdaHbXccCy/JYOZg3h5dT3VE5foF/kTNFUUUlv04KKlrnsse20EcJbiNnBIxq8SFS1Ilj8czMBM5jMcw1k55aigLr7Jn2g8uq2fiWwxAch9oDN9q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364017; c=relaxed/simple;
	bh=MuX9R7g0ibYZt/H23695t3Ljwapt0k/HhA3xqv6fYAg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Eu7QQTlv8so57Q84X9MaZsGVoBumFjOpywykmq7Sn0v2NnVBOK995GkTGrH9083RlpxbnLb7B+H4/vKd2DqgtgL5BU9fd5dW4nmk9EA0GENTY2dDBmUrTuKAf4viXbRS4VuxCXyqSDhbI+hq0cp9gjNcgjdRLXHBAxpBtyG3v64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43cf7683a28so7370935f8f.2
        for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2026 01:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777364012; x=1777968812;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :reply-to:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dTyFppfYDKUKixn17xsZIDtt9tbmNW4VBMg2jP/+dGk=;
        b=CNNzjtoJ6qCOYrLRG4hh8YFjlg4alonabo9TRCm7WK5QOWy1OkGdhANjWaKxaeKgJc
         dBvR0XSl8eV+BxgxsOLwQkaUTNSp2iYblTI0AB2xfb3hkv1uyKaGZlZAXnKxguF44Z93
         n5eoKKSzUWzPXpWkaRI/drRFcuoFA/4Syahf5V7Is19PlaC2JlS/NuWqQDocxotTNuhp
         j/pnAkHPKEpoCenHzFmeD3xmiirzWWMD+C8lkMX1mDzRPlMd/Ca/BEQLbf2A97yR1keb
         4DrNIJjT82TKEyvGwKDiOnhj/EFxcSzFhVpCmwf5Umd6jUxWFw9LRcEOjz8mksL6BlWI
         ItzQ==
X-Gm-Message-State: AOJu0Yz8n6gzZtTuh5br/yFbG/2LOKrgXWBz7gvZ1AUJZThMT3gsXJMM
	XuZrP396VZzHu6gfDgJ1+VupSuEoKKHP9fV8vXHWyD6UvLGB2/6P+oZONI93YQ==
X-Gm-Gg: AeBDievDSvHe7wL32EjERZP6XQD4IcQuU0ZAMgpm/kBeIW6Nfsx0x/Qk51+JjZtynOv
	9bVWfw3oO8Tm1JQoeXm6fu/qCvxor7L9CARf4kZGh5EUoaToxYLjRMrLMPrltCuzKXnkQBeZ2xB
	AOYQQLccDJgnfDZCuNXK9aEBKo5PxhYhyd6N1mQgInPDaa8XGfH3drpCZmpxY5blFK1mbRvFd/5
	NWAP54nR/kzCRgiZZEoaMsUQXOnL1mIvomFv/t8VfhWHW3gBr03UchK/0qSqvZxlb8a4oCsox8+
	f69je6+JbBDFyiYDkL+ZKJbH5Ryi/aHY/zmZa437AIy3rA6vZ8IgYbCDnCVHPk0kzmVIm7WnRQg
	yTsXy/xXUthbmHdo/KOFruiqelW80Ciw8eOpy7zwFGSA51UgFR4bfTEOUvciv3ibOCKyn1g4i1w
	7+I3ssmHys0CblI+ORtki5oW/8usB+oDPoUjE5DbF4ve5gvMJ0K3REERV9X5xeHW1s/FseKb0Y3
	g==
X-Received: by 2002:a05:6000:2f84:b0:43e:a70d:763c with SMTP id ffacd0b85a97d-4464a166a76mr3744922f8f.42.1777364012183;
        Tue, 28 Apr 2026 01:13:32 -0700 (PDT)
Received: from [10.50.5.21] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463cb59bacsm4539546f8f.6.2026.04.28.01.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 01:13:31 -0700 (PDT)
Message-ID: <d61888c7-347e-4ddd-a8f8-b0095c5c8700@grimberg.me>
Date: Tue, 28 Apr 2026 11:13:29 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pNFS/filelayout: fix cheking if a layout is striped
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nfs@vger.kernel.org,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>
Reply-To: sagi@grimberg.me
References: <20260427062757.647256-1-sagi@grimberg.me>
Content-Language: en-US
In-Reply-To: <20260427062757.647256-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2994047FB74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21241-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[grimberg.me];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sagi@grimberg.me,linux-nfs@vger.kernel.org];
	HAS_REPLYTO(0.00)[sagi@grimberg.me];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

CC Olga

On 27/04/2026 9:27, Sagi Grimberg wrote:
> A layout can be striped with num_fh = 1. It is perfectly possible that
> both MDS and DSs can handle the same filehandle, which is exactly the
> case in vast pnfs layouts. Hence check according to stripe_count > 1,
> which is the correct check to begin with.
>
> We should not be called with flseg->dsaddr = NULL, but if for some reason
> we do, return our best guess with is flseg->num_fh > 1.
>
> Fixes: a6b9d2fa0024 ("pNFS/filelayout: Fix coalescing test for single DS")
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   fs/nfs/filelayout/filelayout.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
> index 90a11afa5d05..c28b3d5bfa8c 100644
> --- a/fs/nfs/filelayout/filelayout.c
> +++ b/fs/nfs/filelayout/filelayout.c
> @@ -778,6 +778,8 @@ filelayout_alloc_lseg(struct pnfs_layout_hdr *layoutid,
>   static bool
>   filelayout_lseg_is_striped(const struct nfs4_filelayout_segment *flseg)
>   {
> +	if (flseg->dsaddr)
> +		return flseg->dsaddr->stripe_count > 1;
>   	return flseg->num_fh > 1;
>   }
>   


