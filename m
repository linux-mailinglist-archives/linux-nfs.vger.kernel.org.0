Return-Path: <linux-nfs+bounces-4301-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9067C916F4D
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 19:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476881F23E98
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 17:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F53B17A90F;
	Tue, 25 Jun 2024 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="qBNbs3ps"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA8817B41C
	for <linux-nfs@vger.kernel.org>; Tue, 25 Jun 2024 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336701; cv=none; b=EggfgG0LYfl1QsIe1aX2XLIiQPTbXLrbbvbOJ1wSzUhEjpO1lzlQ9ntk4ql1po3uCXoQ3ncxbSXZkbzCb8mDSCYXSEUgmc0nSnfnrhxdbKQ9MuS8ItjTUHApfS6zeR5rj6PMzMNkbEP2YIJ2SEdwcT9bZtSHdC27EddBq5KPI3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336701; c=relaxed/simple;
	bh=kYvX23l1Ry7SYC1HtFZieUhzqaz+AkLyjkY30M96eIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fN6IJ8PPudNaVl9RSVxcnkkGDkqXL7m2pRbT+ny3TWgTLD2x7isiQr06hsfnm1wuRzKQ9t5Q8eFtpT1BL+CuMlmN6PKfrK9Sr8u3QD6uYgUddy5lqqsENzZjE8EvgzygdiS9jW+h+ZSRd53p+xDPL3hqnMNM0YZr7U/n4vScAQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=qBNbs3ps; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec5d86e759so2954101fa.2
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jun 2024 10:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1719336697; x=1719941497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYvX23l1Ry7SYC1HtFZieUhzqaz+AkLyjkY30M96eIQ=;
        b=qBNbs3psUSfakFeP7jox/t0Nfe4MiocbsWGpSlwsdexudCdtmIWamaNAhWKX6vYsRQ
         CmvxDEzvAhZiCTk1C6YHNIDlpqXCl6FogZBwJPxCZ9BVZB96GsfpJ5AEmQHHq8ba0qlv
         ppgzgLHTcSG6li+53xMTxJiM/Sn25tTl6xrusKWWTb134uEVdskj7KnwTNVGTYgMUYN6
         KFxK9XYQUt/cajQrrtED2FY+jq4EqmAiUrvOOjttJsKqdlqd1+x6wq0QBwVJRHGPUzIc
         seCOPPdJ4++LshFtvuR2mA4DvL5ukwR9tNV7M9mci92Dam4lgqfroMYwqmJQcJ9tqnQn
         O+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336697; x=1719941497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYvX23l1Ry7SYC1HtFZieUhzqaz+AkLyjkY30M96eIQ=;
        b=K6SFH+NPdcBxy4tlPMY+Vj8qF72PmrDpRPOlun+NOnXwOHC9jISW9yfXCziVt/vomz
         jVxYV5WfU7e7SQEF0xITniImFhFlGI75RSugOEzNmrvwhfkLagSiCT766t/AJYAARhZq
         h1X23QipQPUmsVo4keYQz3mdoFIMD9rgrsy6au4RbzGsiwGolaQx2DQWZYb138wnsy3L
         Kg+TLmW9qJ9Pdtsw2Re2Z0Ivi1bLPEr93W3mSMUPsjiS5AnbRj+QhnAiCLb47TYYIrAe
         13p1+0buchG6s5SwtFd3ms1crLMolQsKOkaWulX5yjMYKjuLpXGfhNzI03s4Bhbc0jTj
         mKow==
X-Gm-Message-State: AOJu0Yz47x2M4ujAJ47nbw1rSHZRI8FQY0CmQ8cEdE/1so2SKJBmaM6D
	VKVZ0yttHy1nJGxsLZbFQpN/U17W1NSzrE2Ks73CX2sHYYxBJwB+DM7fiLI0/eIpeyt916XiRRW
	hGzjdbJaN5eWEVjGD6BPe6EswA6NzPQ==
X-Google-Smtp-Source: AGHT+IFqmQ+T/LjaJPXQkTNAvzVEOTEtCCFrHoacksQ1Ay2kq9q/cBLMes3ymh3/fRtUOKgbVeeqk2jYNYYSwkiJM5o=
X-Received: by 2002:a05:651c:109:b0:2ec:18c7:169d with SMTP id
 38308e7fff4ca-2ec560bcb32mr56013591fa.1.1719336697390; Tue, 25 Jun 2024
 10:31:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d489e2d7-d4ed-424b-8994-6abf36a01e06@oracle.com>
 <CAN-5tyFQpEdSnco8SZWY_nsZVdYhAg+x_EAMmbWW5uYutyDA9g@mail.gmail.com> <2f5cb9b7-3d8e-4ec6-a357-557c484431c4@oracle.com>
In-Reply-To: <2f5cb9b7-3d8e-4ec6-a357-557c484431c4@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 25 Jun 2024 13:31:25 -0400
Message-ID: <CAN-5tyE5XpM750=9rG0cfp4WHRxOtXAwvViVmc4kQEVnA1dmTw@mail.gmail.com>
Subject: Re: ktls-utils: question about certificate verification
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 1:39=E2=80=AFPM Calum Mackay <calum.mackay@oracle.c=
om> wrote:
>
> On 21/06/2024 4:33 pm, Olga Kornievskaia wrote:
> > Hi Calum,
> >
> > My surprise was to find that having the DNS name in CN was not
> > sufficient when a SAN (with IP) is present. Apparently it's the old
> > way of automatically putting the DNS name in CN and these days it's
> > preferred to have it in the SAN.
> >
> > If the infrastructure doesn't require pnfs (ie mounting by IP) then it
> > doesn't matter where the DNS name is put in the certificate whether it
> > is in CN or the SAN. However, I found out that for pnfs server like
> > ONTAP, the certificate must contain SAN with ipAddress and dnsName
>
> Noted, thanks very much Olga, that's useful.
>
> > extensions regardless of having DNS in CN. I have not tried doing
> > wildcards (in SAN for the DNS name) but I assumed gnuTLS would accept
> > them. I should try it.
>
> Wildcard didn't seem to work for me in CN, but I may not have tried it
> in SAN; I'll do that too.

I have tried to use a wildcard in the SAN and that didn't work for me.
How about you? Specifically, I tried in the SAN
"DS:netapp*.linux.fake" and tried to mount netapp119.linux.fake which
failed with "certificate owner unexpected" (meaning certificate didnt
find anything match to netapp119.linux.fake.

> thanks again,
> calum.
>

