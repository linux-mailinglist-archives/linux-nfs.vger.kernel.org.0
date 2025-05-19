Return-Path: <linux-nfs+bounces-11793-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCAFABB328
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 04:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59AA17A724A
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 02:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518212AE72;
	Mon, 19 May 2025 02:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUgeFd2+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8189F9C0
	for <linux-nfs@vger.kernel.org>; Mon, 19 May 2025 02:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747620915; cv=none; b=lBKQ1G5of5KvbP0r6hJW0P6cqSl5mM6PuauQk774881ac0rhLG2bXWZMWfMBgGg+kBfF33nqWb/WHaKR27MQgtDf47iU2/WmR/FeNJFOyXlnbLvuURQd8MYa9kdrS3t2QC9gyQUEWGJC0NyPyUGatBAnrQJEGM6jUn3SieCMIq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747620915; c=relaxed/simple;
	bh=6nGTk4kfcWdAUfrliE7fdln2E4IXCOQrPGtWu5qmXww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=hgsvcO63Iv44cn1JhKaTMEJIYhlDmXbQEbaE12sFgKOp/BThi5IznlxC7H0M7s4quhsLWzk60qiqSEogcPEiIE/R54PpAa7P5DugxNc/GY3mCl8GtUUjxP1iaH4R0vKLYKsjt7JK67QGNQd0iy4TLO9AKasuIOC2Ii3z0Q08qiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUgeFd2+; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2cc36b39545so1393188fac.1
        for <linux-nfs@vger.kernel.org>; Sun, 18 May 2025 19:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747620912; x=1748225712; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tsGzHeyxFjXseZwC645ofkZqQAuapa1Y9mXA1adVWzA=;
        b=NUgeFd2++h4tJsD962wM8trf0v2Mbg0i+N8Sn1hMrJrt8L1K48LA7eljJyaMny1w4n
         2t7MKbtJTSUAP5eVBRfI9R2VQedJ04Yv1to8gxXRFenDv7/QB9geNY+VZHjyGtPNAqzG
         IuUfo7zIyFxmu+W2PqtRVbGEHWaxtfD/FcVzSvJgkWywqSOD/uyul7NYSrYCpOiliOLY
         XA33+PLPb4pp/69ntIARW8zRrlY5RscaO1ZqKl8QbCHGUnGUG8WhgRUXxyCnVACmOsf6
         fvDDyNl+y/K62in/2Z4pSEeWHfYShGs7rK4NkrkqWKXQqGLAVcsyetLjfxNdfuWPnJD2
         MlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747620912; x=1748225712;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tsGzHeyxFjXseZwC645ofkZqQAuapa1Y9mXA1adVWzA=;
        b=Kgy3NjYJ4t1tWHe7JgjnDX4kvmqhMohpykQVR3E++jY6mRTOnTRqi50IEeGBJYmLxi
         LCqdYdoHSOPVQBo+0P1syP5LGgupMnmd7g0b09CMO9elUXd5m8Qw4a1QBAAQ/WDhAcUV
         /GqxBz8Kw0hc2gVnOEDJ4KplMpoTGZgDYcYf1c+M/C0u+mgZJ0kdQicBecalauZ7ylWe
         64YJx9wi1xhOVrhkZMYQb4/PKt3vHew9aXIt9j/oucgUcowcNqr/cyudvI1zU2uPnT18
         NFC9qgnLgkGAk+BwgNS/Y0uBKQ+XjRH/X+3j35lCqTv7Opehnta7R8IKoA4xGL1C2FYW
         nCZQ==
X-Gm-Message-State: AOJu0YyNqHe2aCkGbL08lIlA/Qu23xDNBpkuSXLgfM7jM4pAd84220/y
	5en3d5d5YzUTKxSPb0wg0dvAANwRk6rw+2t1WQIfSanW6kVV3ygbU9uHmQSUgBQI6kw4fUujGIN
	aXc96cyqt77CFFrc0dIzdiHwSzvYHimbSmpSy
X-Gm-Gg: ASbGncuFwYQqxD7MKfb/f8ZjFKRYyKpxxbJ+NIqEo2n3SL1ahzNOqTVQkT6JEAUk6Gv
	Tx2KkIcw2jfBJ+mgB0MwkbkzKgVfDDTvOzyUE3Qkjw2g+4GbZlXEwh90nmrQeLYE65ZbjInIsuC
	0ubISMPjjuEbXiG8eWy4K6Cyr367U1hYA=
X-Google-Smtp-Source: AGHT+IF5W1EsMs0b3qNTjCHj/uNlx8nE+/rIsIvYvNRn43ZbipVW0SKefs6O/+GjNt5v74ptk/AUlpV093HYZ1JEO/s=
X-Received: by 2002:a05:6870:e391:b0:2d5:cae:5426 with SMTP id
 586e51a60fabf-2e3c2744a03mr6571333fac.3.1747620912336; Sun, 18 May 2025
 19:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANH4o6Pvc7wuB0Yh8sEQDRg59_=rUNtnpgJizZ5mmmGNgY5Qrg@mail.gmail.com>
In-Reply-To: <CANH4o6Pvc7wuB0Yh8sEQDRg59_=rUNtnpgJizZ5mmmGNgY5Qrg@mail.gmail.com>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Mon, 19 May 2025 04:14:00 +0200
X-Gm-Features: AX0GCFvvWtGPRg7j8S3mctdnX5HaH8um4PhzMchLlVN3O7ut--Cpyj6VkHp7i2M
Message-ID: <CAAvCNcBPac+uDC6x_V_jW1q_JCG3yEeCMjvpc869AmBAhti3Xw@mail.gmail.com>
Subject: Re: Why TLS and Kerberos are not useful for NFS security Re: [PATCH
 nfs-utils] exportfs: make "insecure" the default for all exports
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, libtirpc-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 May 2025 at 23:51, Martin Wege <martin.l.wege@gmail.com> wrote:
> Interoperability is also a big problem (nay, it's ZERO
> interoperability), as this is basically a Linux kernel client/kernel server only
> solution.
> libtirpc doesn't support TLS, Ganesha doesn't support TLS, so yeah,
> this is an issue, and not a solution.
>
> Fazit: Supporting your argumentation with Kerberos5 or TLS is not gonna fly.

I tried to add TLS support to libtirpc, but I think it's simply not
possible. The APIs are just not compatible.
Ganesha folks also tried the same, and failed - their ntirpc would
require a major redesign to support TLS.

So, why do the NFS folks even bother with NFS over TLS, if it is this
kind of mismatch?

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

