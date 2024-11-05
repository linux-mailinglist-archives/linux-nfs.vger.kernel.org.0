Return-Path: <linux-nfs+bounces-7673-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E221F9BD485
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 19:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC0E1F23446
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 18:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ADF1E766D;
	Tue,  5 Nov 2024 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="JCgUmPFk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AC31E2851
	for <linux-nfs@vger.kernel.org>; Tue,  5 Nov 2024 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831238; cv=none; b=Vrjsn94BCHZ0JbYK3oDHye/UF3FtMzTozI/ADSwY/UQ0fOMmjw7AGizsTiWM/r3tTDFPKZS7Nijdn8HB0LKceNkl1ws6v6sVF24kmv+zriZ+Z77yELUGWTx4a4DNDlvmZGnQfdM6k194ExEUPDcYDT1VqFCFZ4eXpu44y0MNBqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831238; c=relaxed/simple;
	bh=d4PFAp6dk1Bc2mj3lYeAr5rI4ULK52tylTJ0ejb8oCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sfd7Qy9X3yi4txpgLk+jxtXy740h9fIvbdfl60bmEgzBm5ZQ5im+bPX0zsQQAturYLhpJuqe9U6uJX9qn50qi5DUeFqCTBKi+zW+QQ7pZT8zyqwTAXcnWkV9dxnJnOT7Kz2t23f2J6UCOwWyPcAxIjL+E3hiNWo90AgrIvrh1Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=JCgUmPFk; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb57f97d75so59686311fa.2
        for <linux-nfs@vger.kernel.org>; Tue, 05 Nov 2024 10:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1730831234; x=1731436034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4PFAp6dk1Bc2mj3lYeAr5rI4ULK52tylTJ0ejb8oCc=;
        b=JCgUmPFkewwnzhmv6nFbe5IXqQwyKDvdbRtjchLxLaRO3Dk9O7MEiYmaAqEgJPPl0y
         C98oO4+DYdhUfFmXeUN62Ad3oM8JKSnkoGm9xCQvsld5YtEz2TMYtIvfEudxNkr1ByEe
         xGLMzcU5OKtt4txJ65xlqeXRG8erWoqnQLKPcjRsHY5S8X98H7J1yT5mHyJcUVZpAI2n
         DLHh5aveJ8yTTlHAxKnSTYsey2QhuQz19rKsHTjud8e+MARXIJbBAs7mErqTjp/scJnM
         0Y7R/Q08g9fOs85edqB214ifOUphg4P7+PXC36y9CYEsnGpQj5E6nhwOb0f+wUZQBuOx
         7zsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730831234; x=1731436034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4PFAp6dk1Bc2mj3lYeAr5rI4ULK52tylTJ0ejb8oCc=;
        b=tWhlHypMCLc29p3XJVuDJVJxMw2g0H/C/EOp6CTN12psPZ9ijEiyJetr0l5QbCdJn9
         xGp1AW1elN3aCwi+rZIeYRI3F4bTpLRUi5yQKwLHajeXn+3Ul9Nl/2qb4otbVSDo65ep
         fPRObwSVhTorPhOBpuHb5AofMnts5W1VKrC7+GUcpn0YV9LZYhN8/bR+BZmniNPYS+T4
         aMQyphOThBmndKcIBBtgAV+0+70pOVBGSsXU39JQltTPhPIfy034IZ7B90TeSum+qnz0
         sANHZgchOXSP3SREP9TUAChjUo+QggV/rNeZ8/YUxAcEjxsDO4+heH9dRP4W/GoPHtKP
         Mf3w==
X-Gm-Message-State: AOJu0YyXyAzDk/Mjzc+INyByYiVex1RMFn8gvdRPNt2XuE6j2H09SihI
	eBJPcHkTqlbtQT+xYZ11m0ZgFTJz7jLxYembR8jDxY8vfg+Z4mTmoAEzq/aj7grsLH6LDTEQLAI
	kY4mJLMZfKo0gITQ1CkEJpB1KY2YUag==
X-Google-Smtp-Source: AGHT+IEKAEBwL3EXWikCMT01DMajgChiAjzrrNDaUfkTxb91Mn4tFcwiz4pD+luHXnPTpbFfNXKR68MbYA9Y9FpP6e4=
X-Received: by 2002:a05:651c:1990:b0:2fb:3a78:190a with SMTP id
 38308e7fff4ca-2fcbe04f08emr191472861fa.29.1730831233876; Tue, 05 Nov 2024
 10:27:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHnbEGJf0F1WaqDf-f8CKi0WGchG_3_sP4+6Xt1MCqcCF9fjaQ@mail.gmail.com>
In-Reply-To: <CAHnbEGJf0F1WaqDf-f8CKi0WGchG_3_sP4+6Xt1MCqcCF9fjaQ@mail.gmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 5 Nov 2024 13:27:02 -0500
Message-ID: <CAN-5tyF355YiHv8Ufwk9pVQdQYqWyFiLJcQfhdwT+E1vkfmrkA@mail.gmail.com>
Subject: Re: Any NFSv4+TLS support outside Linux?
To: Sebastian Feld <sebastian.n.feld@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

FreeBSD client and server has NFS with TLS support. ONTAP server has
NFS with TLS support.

On Tue, Nov 5, 2024 at 12:23=E2=80=AFPM Sebastian Feld
<sebastian.n.feld@gmail.com> wrote:
>
> Does any other NFSv4 client or server implementation support TLS at the m=
oment?
>
> Sebi
> --
> Sebastian Feld - IT secruity expert
>

