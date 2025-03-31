Return-Path: <linux-nfs+bounces-10960-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95BCA76667
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Mar 2025 14:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A014D16A7E2
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Mar 2025 12:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025A118A93C;
	Mon, 31 Mar 2025 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZs88gTE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4EF1ADC69
	for <linux-nfs@vger.kernel.org>; Mon, 31 Mar 2025 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743425799; cv=none; b=cbP4ZhNh8u7mGgNwNd2/cZ6a3DT+rI1Ura+N5EcFz2tXy4XmKqOEyilurSNCndGDWVPr7SCRqKdnJHQp5G/CxLg40ejyFb4lIq3LAV8T1Qs3Jd6VtlHZzvCAy6IVg58sCgNjE6d74DCTGZ1mBbZdbK7Vq4/zII+pFEW0uCWn4Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743425799; c=relaxed/simple;
	bh=vUajgc+pNphW0hu7Bj5gPJlPridCo1aBqJiV1Q+tod8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=lL1+4KvIta/DJ67CwiXAychZ9abFehlcG1gIaZF55DMp+kpgft1FbIW1e3dtv+B3EWrYbGPDHThdu7UTgeKbtndsge/useINuMwD9m/zaIB3tQQTU6saBAzVw8pTypxX2RAta1YTE54UcuKmI5wO3EOqReG4OJ+AQzM20aSmwTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZs88gTE; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac3b12e8518so854502566b.0
        for <linux-nfs@vger.kernel.org>; Mon, 31 Mar 2025 05:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743425796; x=1744030596; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vUajgc+pNphW0hu7Bj5gPJlPridCo1aBqJiV1Q+tod8=;
        b=JZs88gTEcAzj1BeWPnH7PWYuPvKoAmYD+lMKMz1atFeGsjLX6Y94LBnAkXwxw6950q
         RV87mygix+gyp64kCgcqeM331G0XntAFjHGyTsxTPuhBYHC7/QqCmi7Q5qxksu3+hSNh
         JWN1zk8objMeJXXHLrF3MWCGUu2z71t37nSrorjD9VoB4qQdrw+1YtNtLKbRTGZoFFEE
         HuKlrm12m/TsUwgGkzO7JfN501BZc2PCRnQJe3+gZmIbpf8KMojzyU+LTsYzpPYdRcMr
         gYBv9NJeH3DFhtVhQxltJLBz+dwceAgl1f5QfX+3kZalbxTjQV0D7h2WdffYoETMpjVl
         MDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743425796; x=1744030596;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vUajgc+pNphW0hu7Bj5gPJlPridCo1aBqJiV1Q+tod8=;
        b=SdYXGEKNq6UIe89SEeA1wupUOfHHlM4cP994qON6wiMUTN7yKFHU4xoH4/P745juOG
         OONUZGTdwhoSVRMU/k9JI8oOruv7v2fEF8X35kbTIpEjSnyKUpjEu5AYZD6NxPJN/1+f
         1Gg+bdYfp0y+XU8x0vJbSaCG/t7Jr50SybfrsUhAo0jxEV8ag4Qn8vpSrfL+UuZ6S8GJ
         wmJ2CXVjdhHH3QgLlYbww88IQb2bpgOEFF/HVs727R92ibEfMbFWZ1CuVql18gseD8lS
         lSdneeYFB1SK0GW2o40upzLZw5Fw2OjCBKHwP9jD/RNN7rWOGAuaWyOrvwn7raEjxpdq
         gV7w==
X-Gm-Message-State: AOJu0YwaQeAl9KEO0H9KSXwthW9X4MtJCoO39QMkYg1b08xEu8JPIoxh
	ayvrKcJMAWSEQmmW/AfTfaRkAFjyodOK/TRosnbZR5pfBSJ/W4xniOhtC7Wc/YQ+XuD8p3+tBlN
	UG6D1YQfigT35mbPfg8tAFndSbw90a9cS
X-Gm-Gg: ASbGncuuUj81uR7ugFXFcspu3D4GSnQ6LYqznz7zLf4cqwF6vnI6cU52FV7Z9bo3WK3
	3iOzTKNizaXXKY01RnniA/xlYsO3zU50q5UIOHuh9/OZUKc5+k06xd4PfUWf6tf/y8TxPIJay91
	Tbpx/a6rARIn8ZNclGakLCNdMo7ts=
X-Google-Smtp-Source: AGHT+IEjt/y0vApM8/dUzPYrEBm5rRkjYw0ED2/zD0kCMfaphvUWhYXYAPDzdNzfCHSMABSyo/MS8KsJ2flxVXU9KtY=
X-Received: by 2002:a17:907:97c9:b0:ac4:3d0:8bc6 with SMTP id
 a640c23a62f3a-ac7389e1864mr787956466b.13.1743425796027; Mon, 31 Mar 2025
 05:56:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPJSo4V8WnCz0rrdHK0SdvrhKO9Ex-BONU3bkao5wziCnXfJ5g@mail.gmail.com>
 <5c458e04-4be1-4b0b-af99-41d258da5d7b@oracle.com> <92a56d9a-b773-46ac-8a72-a20c7dcf41bd@talpey.com>
In-Reply-To: <92a56d9a-b773-46ac-8a72-a20c7dcf41bd@talpey.com>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Mon, 31 Mar 2025 14:55:00 +0200
X-Gm-Features: AQ5f1JqejpQe9Ciau5M2wqws7KOSRAc82lCXYaP9VwIOeYKlFd61VNwRa9xRsvM
Message-ID: <CAPJSo4VHiHGDB7YpqzNVUaKf6bxYh5e2RQesd1hwvCjTax7eqw@mail.gmail.com>
Subject: Re: Using Linux NFSv4.1 RDMA with normal network card?
To: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Mar 2025 at 17:59, Tom Talpey <tom@talpey.com> wrote:
>
> On 3/25/2025 3:12 PM, Chuck Lever wrote:
> > On 3/25/25 2:53 PM, Lionel Cons wrote:
> >> Does Linux have some kind of RDMA emulation for "normal" network cards
> >> (e.. not IB, not 10000baseT) which could be used for Linux
> >> NFSv4.1/RDMA testing?
> >
> > Linux has a software iWARP emulation that works with standard Ethernet
> > devices. I use this with NFS/RDMA in test scenarios all the time. The
> > driver name is "siw".
> >
> > Linux also has a software RoCE emulation, same deal, but I don't use it.
> > The driver name is "rxe".
>
> For the record, both siw and rxe are not emulations, they're the
> real thing and they interoperate with either software and hardware
> implementations across the wire. They actually work well!

1. Do they work in QEMU *and* VMware Workstation?
2. Are there setup instructions?

Lionel

