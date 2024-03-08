Return-Path: <linux-nfs+bounces-2238-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E96B875BF2
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Mar 2024 02:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EDCC1F2255A
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Mar 2024 01:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D98663C1;
	Fri,  8 Mar 2024 01:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U38faLlf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D1763BF
	for <linux-nfs@vger.kernel.org>; Fri,  8 Mar 2024 01:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709861124; cv=none; b=XuU5h2mUPPM8Y1MYfCdYtL+TbeftjDtNunK99g3YZ5+L0hBgZXXelck2XMr5v2ViqU6Usb57SlwlyX6V2Gelo52eYDi+u2bxon5cPHwDXPP4hb+UUUxW0g7xqh2BXRUhfwwOlMsysESdIbr3A2EwYad1/eQQlhvDe3hTAShw700=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709861124; c=relaxed/simple;
	bh=Smo5Gtu+aou5xBGb2VB9zJ005MI0yz0U9yI7sefHNk4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=V6FloqrNUzzAW56PSCAVxk9T9g3mRVks+76Q7XpTwJ5JdkIlXZ1AZppLwI/7hLf5Xl2ULp9PrF+fCHp8EZb5i2LwVLmfqAh7C4EdRhiJjJPfVKqS75ZDMkHowfp3qXC6fRfAneSlfYZBnSH2su9exs+Nto2o9QJHa1UIn3Lom30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U38faLlf; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5132010e5d1so2156791e87.0
        for <linux-nfs@vger.kernel.org>; Thu, 07 Mar 2024 17:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709861121; x=1710465921; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3G8222Unk4lRDm2PHtaZZPQEcK/r5Ytr5WAOECNBgbY=;
        b=U38faLlfXfzEhMVwXbOObVlq/JcjGLsMm/gFNDnjqPqQLyHMVhrB1uNqA7WX1LjaNj
         lepc0Y5gzIEUPKQbfUDQaV+ySLgca2zu+ewU86xtJCxwLzCrumscaJWR0+3aAkZS9oAq
         3zLet5A/j8iDtII4pFQ25GupMgtLJEWzkc3NNGsCG6aVs08RpMi8PSgoZlJEbfLT3g1o
         j9GW2Tukmfe+H4lETzXiP5x7P3i7pbVPLU5sD0JpVZfsNOA40OTtC5DKG/V9DNoX+cAE
         yZCETnr0/uTcPBIqh8eGOfK6zfKYf3Vi+JovsgtA+LTkWBOuuM9bvovMRAB9EejqHGqz
         ySRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709861121; x=1710465921;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3G8222Unk4lRDm2PHtaZZPQEcK/r5Ytr5WAOECNBgbY=;
        b=mRjWnxiG3pP7IEFG+mO8l+7B7i41wrMj6D/YmvKTDp4wSuZSaCg3MBE1hNMdcKqjqr
         G66j6FkyXp6GpnbhIPY61MKRN+j64B6oet2gj8oDLEYfYJSzcxQDrsUy3OsmfyRQuzIz
         NhSKR76FSdwcVoUJGKPoxje7fS5EOuGaDhhcnWxDwamf2qOHilg+ko8z8JbLWT4PHgAN
         6pkOGms/4lUSpQERy1dRNXqQ0BGpabZ4Nz+EP7gulvLQQGWiud4kDuH7mn9hIXgsUtl7
         4pv1Dr7dOhqu21DdbRcrYf8D2aEnoJXyozx7tLW4ItTsuMjjKmweP0heupEyIUwqirfy
         DOSQ==
X-Gm-Message-State: AOJu0YzB1Sj4tur4+16Nq2rNiEvpvr0jfMLK/kTg0RuoXZlrxeFy5uqD
	/YOZC2qVyZ7V6GwjL3QHnFVpqcTssfXrAndA++z0gRlUaXaTL1HccozdbDJ4W7H++I5+vC8MJ9A
	oxopuN5wxUTjp330ka1+TBQmo4n+ws5Cx
X-Google-Smtp-Source: AGHT+IHvDt1APscfEY+hHoZWQtdU9OsX1PD8jdrV/tyAwNWbQYBBvvE+wgNF7euf34NPE1tABHEUdXlt6INm5SO2iR4=
X-Received: by 2002:ac2:5223:0:b0:513:45ca:5410 with SMTP id
 i3-20020ac25223000000b0051345ca5410mr2225000lfl.68.1709861120574; Thu, 07 Mar
 2024 17:25:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Fri, 8 Mar 2024 02:24:54 +0100
Message-ID: <CAAvCNcCG1bf0d43Ek2e=Gryz=q=rJmeAswG5AJjqoKsCkL1DxA@mail.gmail.com>
Subject: Which kernel version supports NFSv4.1 write delegations?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello!

Which Linux kernel version (NFSv4.1 client, NFSv4.1 server) supports
NFSv4.1 write delegations? What are the caveats?

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

