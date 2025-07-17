Return-Path: <linux-nfs+bounces-13122-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337D4B08164
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 02:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677E64A7D70
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 00:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D984C2CCC8;
	Thu, 17 Jul 2025 00:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDzlUWKL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4681799F;
	Thu, 17 Jul 2025 00:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752712076; cv=none; b=ZqMM95C/SaSNJSwrD8RPI5xyHhjUv9ftndkLc1YY9r6ORuLlrfgL1SN/yRVxHF5Rf8aC9YlgEbRntZGBVGaU5V179HD2scRQ1vMh76BLZkZnqBb7UvYxXZmqZJISsAE74j9rI9F6gWxITUhGDJjvIlPa5aD5AV4WJ865RD2nyGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752712076; c=relaxed/simple;
	bh=B1VrwBO8GfeRLwe0QIm4yIzRse6Q7xt/6UjTMPlmCuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUBjwyIeFbWnkG2CiutYZ0QO0Q8RLAHfcw7Cec09OXERw8Jcs5Cq55SapzCgCzyxQl+HAKjVutPX3P5MN4Xil935etbr659qUE0ItYmGQEbiEPrG85c6p/g0lPjqZhIprS2ldEGv8cd6vNK+JzcrqJl5+vmBM1aU7jAz0ba32o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDzlUWKL; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32b8134ef6aso4209551fa.0;
        Wed, 16 Jul 2025 17:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752712073; x=1753316873; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NI1Ghd98wnZnXdj9LhDIQuSGHuKyUbZcQleXiLmcq1Y=;
        b=CDzlUWKL4kuC96p3/QXVkn9NTJke82GjIoZx6lB7MKPVKqZ2oXpo4Un8H2xQjTzeIi
         Z/IqoM1lSigtWPHmA9cD87DsEg1PFyEX+jnz7Lmt9ne6pDMsqks+tHLRKyDIFIDdnAyy
         DQX/x6t+1LavOrTgxPhWLHUY/XBRx2AtvFS73djHXrGdZIwY4gkzeoxAzZLAW7rp2bqt
         sz70724ll7qw/KaC8BFnUOtDg17VDoew1Wk6MAf8ecFFRFBtrny7zQOF4+gcdtdpX71W
         8P4YprDhkOJp4LPxJ7Scp+t0q01csc7ImbswPKBqibQ2peQeco7mI47lUbdqK2i8BgAw
         U/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752712073; x=1753316873;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NI1Ghd98wnZnXdj9LhDIQuSGHuKyUbZcQleXiLmcq1Y=;
        b=cFqtIe0WZ7JUkVwhjJBjNhGPvtIw/62FoazZVu2bbApVHRSqF0RGrFpG4pG6Zi9xoS
         WBV/Ylq9OnsvwCuwWBIhZZp4cqxJhGZZZbAdX8iNm7EMQ06NTYv8rNNV0BWQsfIptwLu
         URLZulus3WsCW/Kg3ZINooDsm4mbqv6K4ZAO+DZfX8By/cjbmjR/9Eg6zZitnj1/qnyl
         9KpiUjvHrQHTeBZEEOFlAg3hqbdfEZeZEgccCFdqPC4Vq+Swpm2b+D0+vnH2BkVQrseE
         iiTy2nxActYDkXoDkiBhmsAAAIwKnGzlAFJIedo3tBH2X+lDMnr0KUOiFJlNjS98KXp9
         D94Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIM/TCSml0iLDaWqf+KzhEymjTe2osTqAcdFnLKYLyM0HL2jyim3OAlJ+fGv5UnIDramDhBHwKF0kv@vger.kernel.org, AJvYcCWnTVs/4Md/S9WR0QyyBb0a8kDnXEaPHyU/MnPGmH+WRKw2MAKQg5WOWJs7Kh/BWRgd7oxR3N0GZ0aDyHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdGqtx/YsNo6eTCU9Ml6WpFVslI7QdBSNHilDmK6eTj/+ihx2i
	mvGf7CX7dM+RC6ommr9COhIlWsVs6A4GTIPy5lMNvwkNhRxaEkQeX4Lg
X-Gm-Gg: ASbGncvYow6KhJCve0TIsDPuTnveTLujCDi3QadEYHqodUJFRO30ueaVOHKvus+gu4Z
	wim0Kp1fxXae1UfdT363Zd5tHXK/Wuw8p2Qp+YyyC/xkx/Bkipn0O40F873uWYUdyM0ZaauO4wg
	JMvocD5gDSAVM8j4JNYIp4OPCI7U1OMKYJ/tRlvim0ID92ZxC7BJkr6WAhXteRcKF/1HnmDrwwt
	RdfOxdaZBW/BPwQbBHCSotAQ2O34GoY9pORT997WkbERpKEiMZAAfbwZIWvyvYGXqkj/mdaQ8AI
	Qegsby4UI1L0IUWSnFWCmvBxoU7MZgrTVXJ/UppOF1+MwPVV9eZDl/ZP7un0sh+JRXkJ7EuzHPQ
	KSgOPbKwT9UJS9zK39BHbGB6VsBDdMwLTDymxnr/fUT89j4EMGhs=
X-Google-Smtp-Source: AGHT+IEtnpCQntmpq2730cwK3D2dKN35j2w4G9/hV8f0woAbrYcmCW/k6Pk/MtGuOpl2V9gC93akGA==
X-Received: by 2002:ac2:4c46:0:b0:553:2f33:ac04 with SMTP id 2adb3069b0e04-55a296fcefbmr262480e87.26.1752712072668;
        Wed, 16 Jul 2025 17:27:52 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([85.174.192.104])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7ee97asm2793177e87.78.2025.07.16.17.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 17:27:52 -0700 (PDT)
Date: Thu, 17 Jul 2025 03:27:50 +0300
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Antonio Quartulli <antonio@mandelbit.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-nfs@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Sergey Bashirov <sergeybashirov@gmail.com>, Konstantin Evtushenko <koevtushenko@yandex.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pNFS: fix uninitialized pointer access
Message-ID: <h4ydkt7c23ha46j33i42wh2ecdwtcrgxnvfb6c7mo3dqc7l2kz@ng7fev5rbqmi>
References: <20250716143848.14713-1-antonio@mandelbit.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716143848.14713-1-antonio@mandelbit.com>
User-Agent: NeoMutt/20231103

On Wed, Jul 16, 2025 at 04:38:48PM +0200, Antonio Quartulli wrote:
> In ext_tree_encode_commit() if no block extent is encoded due to lack
> of buffer space, ret is set to -ENOSPC and we end up accessing be_prev
> despite it being uninitialized.

This static check warning appears to be a false positive. This is an
internal static function that is not exported outside the module via
an interface or API. Inside the module we always use a buffer size
that is a multiple of PAGE_SIZE, so at least one page is provided.
The block extent size does not exceed 44 bytes, so we can always
encode at least one extent. Thus, we never fail on the first iteration.
Either ret is zero, or ret is nonzero and at least one extent is encoded.

> Fix this behaviour by bailing out right away when no extent is encoded.
>
> Fixes: d84c4754f874 ("pNFS: Fix extent encoding in block/scsi layout")
> Addresses-Coverity-ID: 1647611 ("Memory - illegal accesses  (UNINIT)")
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> ---
>  fs/nfs/blocklayout/extent_tree.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fs/nfs/blocklayout/extent_tree.c b/fs/nfs/blocklayout/extent_tree.c
> index 315949a7e92d..82e19205f425 100644
> --- a/fs/nfs/blocklayout/extent_tree.c
> +++ b/fs/nfs/blocklayout/extent_tree.c
> @@ -598,6 +598,11 @@ ext_tree_encode_commit(struct pnfs_block_layout *bl, __be32 *p,
>  		if (ext_tree_layoutupdate_size(bl, *count) > buffer_size) {
>  			(*count)--;
>  			ret = -ENOSPC;
> +			/* bail out right away if no extent was encoded */
> +			if (!*count) {

We can't exit here without setting the value of lastbyte, which is one
of the function outputs. Please set it to U64_MAX to let upper layer
logic handle it properly. Or, see the alternative solution at the end.
  +				*lastbyte = U64_MAX;

> +				spin_unlock(&bl->bl_ext_lock);
> +				return ret;
> +			}
>  			break;
>  		}
>

If we need to fix this, I'd rather add an early check whether the buffer
size is large enough to encode at least one extent at the beginning of
the function. Before spinlock is acquired and ext_tree traversed. This
looks more natural to me. But I'm not sure if this will satisfy the
static checker.

diff --git a/fs/nfs/blocklayout/extent_tree.c b/fs/nfs/blocklayout/extent_tree.c
index 315949a7e92d..e80f2f82378f 100644
--- a/fs/nfs/blocklayout/extent_tree.c
+++ b/fs/nfs/blocklayout/extent_tree.c
@@ -588,6 +588,12 @@ ext_tree_encode_commit(struct pnfs_block_layout *bl, __be32 *p,
        struct pnfs_block_extent *be, *be_prev;
        int ret = 0;

+       if (ext_tree_layoutupdate_size(bl, 1) > buffer_size) {
+               *count = 0;
+               *lastbyte = U64_MAX;
+               return -ENOSPC;
+       }
+
        spin_lock(&bl->bl_ext_lock);
        for (be = ext_tree_first(&bl->bl_ext_rw); be; be = ext_tree_next(be)) {
                if (be->be_state != PNFS_BLOCK_INVALID_DATA ||


--
Sergey Bashirov

