Return-Path: <linux-nfs+bounces-8896-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5C2A00F35
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 21:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32803A3319
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 20:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2D11474D3;
	Fri,  3 Jan 2025 20:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYbSHgNy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C76384A5B
	for <linux-nfs@vger.kernel.org>; Fri,  3 Jan 2025 20:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735937917; cv=none; b=Livuz2qBC5zFx9ovY5gSGyX1f7i1zBU7xAQhUnZhpZCFDVFbeUmHTQEAP0dSYQGIUJvOcATeW7Lww56yeyq8Q9PLxWLXkz0PMwIhQ2JetOGZ+/lp4HAceI63xESjiYQEa+SLniRu0UEpE72Gs4Z5bRDHbm9GsmIpdCDHgSPXJkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735937917; c=relaxed/simple;
	bh=i15j7pYAEtUIDMImGWpSxOAttKXxLcPleQ7ADKUZN5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=MrYzqL27qRChHi5bzixSQ/PxRsKYYiuPU1Bv51aUuvsSih2tq1PRDyFJAmT/lI5bwXdAKuBBZc2T7LSG6AWBIij6Hz4yBDhLQYFyt0RLRFnlZCesHGtH5G+kmR8R9inykmvvoE/Nk4XiOP6yLBtmIIHA3ULtL1V3U/cjAPEcl7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYbSHgNy; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaecf50578eso1701791466b.2
        for <linux-nfs@vger.kernel.org>; Fri, 03 Jan 2025 12:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735937913; x=1736542713; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i15j7pYAEtUIDMImGWpSxOAttKXxLcPleQ7ADKUZN5w=;
        b=EYbSHgNy0JCzyV6YiWNE7LJuP4fUENMB3vXAWZWEYcmt2ug/VXmR3B0MjmCiSpYc3p
         ZG2/SaOKpHk638XrFHe2G3M1BSIW+VWx162JNWu1lqU/KCuw6WASdCRdh7ps4nx7qecf
         jE2sTv3RZvrf80Rljrdo8+zJYF1Kci1jCdCO46CF/1ok7Hqc5GvP/n0/gkNbMih9bQR2
         yf9U2p+QCUZJHSc7vy43B6NKJblZ6TpQBHGNHtutfCsR+BJMsc17mw1NtVY6rDt0bzlB
         sqqVe80wOYKX/lb9ke+KR7wprhuwEcuhYDzALPuyIDkEMzH2IEbHmx/80ntGTZSUpCu/
         L2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735937913; x=1736542713;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i15j7pYAEtUIDMImGWpSxOAttKXxLcPleQ7ADKUZN5w=;
        b=jpqVqjr7Q4o61jtRj8Af5ZGhEi0DYwnxeDISWetgP1pTuxNSD9pHSwJ4RmWAtqb7QN
         YCT6NKehWytAZ0ENPQOWOtHQWZqrwyBof7Cm1m3pDSNbz77zRWpMyA6F1VxmGGRQAdCt
         51bOlFkL7AGsgGvXDQE2ZAgaQsL75dD8sCftcKVvY/QDrqZBbhbYvsQAPO5KjsftgScV
         FItFbgIQ2/VJOu89FMWNpanE+VoykO+t2Snv7oI0MlYW0W5FihD3FYNDjTdkdzhttNGr
         LChjsRuWBP8MPHcP6Qv7YJNAWZaR5JUz8T/LCzhQqHBFr4BlP2zXL1azfSKnHmTsBm0B
         RChw==
X-Gm-Message-State: AOJu0Yx1HN/T5Ydsu2G7l+dnktuzwaMxHzzShrcvQmAGhzpBYrXTRNM3
	OwI6uYKAWtFPE1KvtMxLOhSiavPPOhiNGVhSYjgPg7p1hRoGZ04sciWZ4KVm+iVt2XBBG0Y3MDD
	qmxFks2W389HgIBs+FXvOd5dUf6tVWjoDLIk=
X-Gm-Gg: ASbGncsnDyLSoZwsJ08/aRHTWbHyjd3y9By0qnhNLWN9mU19X31YONXPt28kmVSr0PY
	6Sj++pl8+KfZ6zidLBBq4Pb1TTQtq1ykTtKFPcA==
X-Google-Smtp-Source: AGHT+IF9WV1iIiZbtGVCGT126B90OJ8nBXmwFe4zqu969CHEaHWVu8ii8bBe+6Tss9ep1m93mpLcq5gVHBFxnFbvORE=
X-Received: by 2002:a17:906:c14d:b0:aa6:800a:1291 with SMTP id
 a640c23a62f3a-aac2702af66mr4231946966b.7.1735937913020; Fri, 03 Jan 2025
 12:58:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFEWm5DTvUucAps=SamE5OVs0uYX5n4trFf5PBasBOFbEFWAfA@mail.gmail.com>
 <e52500f98a7153822a6165d26dcf66c3d352129b.camel@kernel.org>
In-Reply-To: <e52500f98a7153822a6165d26dcf66c3d352129b.camel@kernel.org>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Fri, 3 Jan 2025 21:58:00 +0100
Message-ID: <CANH4o6PRUw-jWOySGPWXPULdH5P7p97JnMC-cY1jHvLLXPJdYQ@mail.gmail.com>
Subject: Re: Write delegation stateid permission checks
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 2:41=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Thu, 2025-01-02 at 11:08 +0200, Shaul Tamari wrote:
> > Hi,
> >
> > I have a question regarding NFS4.1 write delegation stateid permission =
checks.
> >
> > Is there a difference in how a server should check permissions for a
> > write delegation stateid that was given when the file was opened with:
> > 1. OPEN4_SHARE_ACCESS_BOTH
> > 2. OPEN4_SHARE_ACCESS_WRITE
> >
>
> (cc'ing Sagi since he was looking at this recently)
>
> A write delegation really should have been called a read-write
> delegation, because the server has to allow the client to do reads as
> well, if you hold one.
>
> The Linux kernel nfs server doesn't currently give out delegations to
> OPEN4_SHARE_ACCESS_WRITE-only opens for this reason. You have to
> request BOTH in order to get one, because a permission check for write
> is not sufficient to allow you to read as well.

So a NFS4.1 client must replace OPEN4_SHARE_ACCESS_WRITE with
OPEN4_SHARE_ACCESS_BOTH to get write delegations?

Thanks,
Martin

