Return-Path: <linux-nfs+bounces-2092-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DE58688CD
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Feb 2024 06:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6D9285C4C
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Feb 2024 05:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D754E52F87;
	Tue, 27 Feb 2024 05:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGrPXfl/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234B0EAD5
	for <linux-nfs@vger.kernel.org>; Tue, 27 Feb 2024 05:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709013493; cv=none; b=d+AlY0eAjVJ8TaM/bnaJYigYpB6cag0Lh8B9d05QzjHVprL/6eqNZ2qwQ3FX8kX21DXK/oxnn1FF8ekB2YrpcHJ0lIzVjXzT7O+OBmpxp+CkWbRhqzO52io4PPs9YXSGcYODBj+RwUv3YFop/oK6K0bzK0ocenWpWI8FZ3debjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709013493; c=relaxed/simple;
	bh=lGSaGO/tzZ3mCMWxfi/omSDSYZry2BXlhIPkASWmaKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=LiO8wNGpm3NfPmWOVzoaXb48ew2jYMFrZgWnFFokCepVTtS+utpRU5u0v/lIE6KD6Iiul7WMUdcyjGSEVjXc2w1WKor1m3maJje0f2odCsrdP6S/ZvfX1cYRR9Mvfo1O2Hk6Fni5NJhxCZAuEp00YuN4+tfj1B8y8rb+ZRgNdyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGrPXfl/; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d27184197cso46440371fa.1
        for <linux-nfs@vger.kernel.org>; Mon, 26 Feb 2024 21:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709013490; x=1709618290; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=11EG9719flaGw9n/F1K/QSPPNpFrZJ8E7Z4GaCt59Y0=;
        b=XGrPXfl/NyzHDd0JtORP898pQAH2ucemXQIehWCFBLfZJZYHGAqUSu8kgrqveR2Bfu
         rBbW3+wYmembS9g3algEbzQx5YZMieweT/Ohh6dJ+zJ0bdH31dgEG3/vFPudCyVaBhna
         z6vk8QyysuwxNpNo0YnICuwUOxJ4gf8qVe7/f5aHHPjlPOk/so/VgBQi/lU7J50a9Qlu
         V+Tpi2hmOfhUIMeEzpUaR9Rc4GFmk9L1IX2icHtS+UYtJuvARfrvxSL+qdokFqCD9JKZ
         3Hd8g/YuEsrdMWt4i2SpaSsC+5czSoNvnamVMAYd2TUyIGHFNCb7ofc+LsX8GmhDVbgV
         oitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709013490; x=1709618290;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=11EG9719flaGw9n/F1K/QSPPNpFrZJ8E7Z4GaCt59Y0=;
        b=S/07aPy5lT1UnbCFLzdEopq0S8NkW3W3ULDVxF44CKqMBOKx1CihHq3eU2S4XyJsK8
         uxu7eSasYIedODiejw72PdpAZZODeTDawpqoOOnk94HHkYHM9UkGp4+z/ngJcDuEQ1WH
         ok8CMdxz6pqjYujWIa3zXxGc2hBmz8w0B9bLLlo1mdC0ECm3dPOCE+Fld1UOf/yk6MVC
         wUE+yJK1UCi1Vi4JFTJrTId2kUq4lKSOV6dGAVSa/0IAZVEP7vTS6sdbOC3+vZ1dg6VO
         QYTn340zSjurk04esdfqkRNQwF0fpE+3HhwfPjcAvLtCSr0edkLRMm7R6n22X7D6VLpb
         MJzw==
X-Gm-Message-State: AOJu0Yy4hARvLqvPGAajy7eT1PuMZGTJHyktEr4rJpr6Yc6LVPywpr4E
	ZvzA+L/EaS6tdfflzr4h4y6LQ/LgCQy4imH9xCwuzDnvRs9WMO40qDYRZBY075h41mM5uix42aA
	bQrcSBIDXtZvlyzNnk0K+fb52+YNsJLIYQi0=
X-Google-Smtp-Source: AGHT+IEEVXvRSiIKZotcQfw9ddmSdBBo/z/HuckQglucOf3Y5ZtHKfndJuWq6sA/QXCM8osslLQ3K+mM4EPQR4rizS8=
X-Received: by 2002:ac2:43cc:0:b0:512:f6a0:130f with SMTP id
 u12-20020ac243cc000000b00512f6a0130fmr3388551lfl.60.1709013489754; Mon, 26
 Feb 2024 21:58:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZdyedKSSsIARB4ZC@manet.1015granger.net>
In-Reply-To: <ZdyedKSSsIARB4ZC@manet.1015granger.net>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Tue, 27 Feb 2024 06:57:43 +0100
Message-ID: <CAAvCNcA0KKFF15b9wYTdRcAWTt9udg5K148FoS1MooVANJTKSA@mail.gmail.com>
Subject: Re: long-term stable backports of NFSD patches
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Feb 2024 at 15:21, Chuck Lever <chuck.lever@oracle.com> wrote:
>
> It's apparent that a number of distributions and their customers
> remain on long-term stable kernels. We are aware of the scalability
> problems and other bugs in NFSD in those kernels.
>
> Therefore I've started an effort to backport NFSD-related fixes to
> long-term stable kernels.
>
> I consulted with GregKH and Sasha to ask their preferences about how
> this should be done. They said a full subsystem backport is
> preferred. Here's a status update.
>
> ---
>
> I've pushed the NFSD backports to branches in this repo:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>
> If you are able, I encourage you to pull these, review them or try
> them out, and report any issues or successes.
>
>
> LTS v6.1.y

Where is LTS v6.6.y?

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

