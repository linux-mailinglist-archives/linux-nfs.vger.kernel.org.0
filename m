Return-Path: <linux-nfs+bounces-8940-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 934E5A03892
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 08:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F273A7A23E6
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 07:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785231DEFE6;
	Tue,  7 Jan 2025 07:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvTWlgXX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB6D1DE3C3
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jan 2025 07:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736233819; cv=none; b=ZMVE8I/G5AeWLjphEuVnKOMB/eEUyfQGr5cq5aUeG3qXK2wc4rcre5GdI2iNEQBypoBAuweypeOODWZvNjkpkQa2Z5Nk+dRzJzuYzbNIW7bIaNAH1jQ17YIslf8pwWGhPZ/9bFKUQD2BvwOD57APhifarRRETpICymQ7c5oiz8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736233819; c=relaxed/simple;
	bh=CwQRvuG0jAmyf91GKjEWhbsKbEcl+MZzj/dpWyMHfbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=qOXMtRQqG1ljItUZi7DZGlwMcR+TSt6kyfaRQW2eKLC4QbS2AtDrvpmtNuqip4l2MFtjyWMmWi+ztvftWO//8aC275AKDxM9gLt5129QtdJVKy+5Kw3tvE5NxKIJI/TNqr6kfCNmSMkT6qQX/duzG+czEpo44LcBf6paYFYrDJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvTWlgXX; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso19139558a12.0
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2025 23:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736233815; x=1736838615; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SWarSVYD3s4eyuy/KEsTfCyhgx8GBN1DN+N6rYps7Hc=;
        b=OvTWlgXXYxWrndpCqGWtJVOiUXio4v40G6K3FyzbjgEBwvs9mzdNDKBW3t9OXAa+Ii
         oeglUYNGX/XSPgIc4giHcwbSr3ew9KKYKNI8vNzMB74ubO64F1cKlQmar0C4F22PReUD
         VcyVW6OVy3P14TuhKJAET8rAQFCKaE5uI0QUEhoIfoLmzv2UOn5YtQxbAGoCeOfC5k4K
         4EVn7vzLvQUjN86olOuwrBeMetr+ZDj/Q0RZprbeV04VcMAY9dhhei36MpHZGImQl/Uc
         e8qF8jVlo3pe4wVhmSqQLLWQ7pOOTjx4Ye4Jo8y1CSSFvuC1utC9rcDEpmCm/hgMNn8l
         ejzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736233815; x=1736838615;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SWarSVYD3s4eyuy/KEsTfCyhgx8GBN1DN+N6rYps7Hc=;
        b=KilxPr1oWRtu1+IMNF2zw1naUF4y4bHC1xO36wHyBQrKvBN/Nj5oi8mw/omtEeUpw3
         Tl0sznqkpCnVBDD64iuxbOLhoieJhii2xRIfXB2MAzjb7QdZK7/O7tWWIfGu1VGMRsW7
         Jv6N0Ng2yLTaXTNHRJJTEsPTBbUpQheQD8Fcz929P7sf6Xl/FaoGWPMZqn0WHiteqPDr
         lEbhfkBgm1d8I/8UoBq6RRpKEjfmvMaID05QsRfY12QE6FqNGMwbJ39PJtZTVNno4bB3
         iuVFYrwtKgXLKXCZmTAfTV+wAYcLmCx8d5HI1BADrd9XRedhjgSnE9JudDMxntjADi0n
         SwRw==
X-Gm-Message-State: AOJu0Yw7bXcVDD7+ADV3sG9ab8MjOoHSnJg0pXu+kIY7h8C+fz621ggL
	uRqnRO/r/qipoyq+pkFjMel6BZlfPiwW+3WGBBXX8FpqdEyAC9tbJIjLKpe1Cs8Rz2yOaURRnsz
	L9GC4drRE8O97Aixm8DeAWXJMbocUhQ==
X-Gm-Gg: ASbGncsHqIDJxwHPsxJKStgH2nDJ5fRbYoe86EeUUEojaKCcq/PklRD5Op6kSQIVcRw
	+iClLqseBCRxiajsEe0f6ckZcD/NEKHjYIjpYf2w=
X-Google-Smtp-Source: AGHT+IHsWwHJXhKfW90AToQS849INXzRptT+I/BfghiLWSWIq6LpTqArs4i+fAPQlEYEz+jvwqqO1S9N4Nzrq92ysnQ=
X-Received: by 2002:a05:6402:40d1:b0:5d0:e63e:21c3 with SMTP id
 4fb4d7f45d1cf-5d81dd8af3bmr52820587a12.14.1736233815345; Mon, 06 Jan 2025
 23:10:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UcAfYN4z9Wmr0SA6DRUt7RmasN2qq9wSZTt50yBs4hP9A@mail.gmail.com>
 <948ffb91-caa5-4244-b0fd-19f460ebd7a6@oracle.com>
In-Reply-To: <948ffb91-caa5-4244-b0fd-19f460ebd7a6@oracle.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Tue, 7 Jan 2025 08:10:00 +0100
Message-ID: <CALXu0UeMT019gHRW0GpiQBn1vh0TTRqEg50CFUyKLHUoL8BJSQ@mail.gmail.com>
Subject: Re: cp(1) using NFS4.2 CLONE?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Jan 2025 at 18:30, Dai Ngo <dai.ngo@oracle.com> wrote:
>
>
> On 1/4/25 10:44 PM, Cedric Blancher wrote:
> > Good morning!
> >
> > Can standard Linux cp(1) use NFS4.2 CLONE?
>
> yes, use option '--reflink=auto'
>

Why is this not on by default?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

