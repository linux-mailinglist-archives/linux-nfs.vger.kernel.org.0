Return-Path: <linux-nfs+bounces-10349-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664DEA44F9C
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 23:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4623B098D
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 22:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4415A1FBEAE;
	Tue, 25 Feb 2025 22:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ODGj22Nm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB694198A32
	for <linux-nfs@vger.kernel.org>; Tue, 25 Feb 2025 22:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740521726; cv=none; b=bAVOMKlSq1p09YAsYPW0R2TChvagykR3N9uta7pirFw1Ovkweimw+U/Inq79Z5Mk67iVhL4oLO58wdZuwmZ4g+coNvOMtS3obnTeBi9EZ0nE51iCJlS2gghlBi8SPqWwUcxGPx9C+OEdOv6njpW6yivJ6V4BAnhC71Nba5NwboQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740521726; c=relaxed/simple;
	bh=rWJf0qBzUrPKbFVcsloxatKLUcLlo/ysdcxntmxVCFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuXz4Hsg7uJ9568b8Ha/6bngAIw4WFGs45hTphPDCtdk9+djvsLeCWAR++E2L3K8tAcP5MH4KS6qyMtmEfMJi0kKHHpgxITXg4VEgUmgmi48lGtHQNYyLSb4qXBL+8nGwH/8gwH4Fe1mRzSkiu8KCgINX1ShjrNrsI2HDHzSFVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ODGj22Nm; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6f7031ea11cso55892127b3.2
        for <linux-nfs@vger.kernel.org>; Tue, 25 Feb 2025 14:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740521723; x=1741126523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0kTAYOa1NdNEMf/AGij3GhgoJi2oNeg0pWOqCLfips=;
        b=ODGj22NmClzWdl05qXGq46zVMCV/0kuhLQAy87hsWvVikQEG8cprb+MNIE6KUzr7Tg
         GnRKa8Ce5mF9GxnbX/I/ZooODM70QS/6pLDgPuQibxtdGKe3DKF4dTqQeh2pGkwCTmwg
         QNH/QGQki7NmEc8/SLiA2G/94ecoFgsXGSjEhrb7GEOHbWBEdSamyTXBc36+DSXvieZ4
         53nqJYmi9s1oceiQ/V48oNkRyk803XxLXxBFCOcxHSEevricbemX2sejpfDHa+EjrPao
         PTo/cHGJW+pcUtuTpDitpp5bzZ5k6d87uWA9mQMnHBwFSoj83g2V0L4vK+MDFyoQoL5r
         AazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740521723; x=1741126523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0kTAYOa1NdNEMf/AGij3GhgoJi2oNeg0pWOqCLfips=;
        b=Gu4AD92n4lwhNXL7zyOd/3j7RM7ZyfMwetFFmMkKJQhAiDHEcb9bUMBnwMweQtw8Px
         oruqUk4WRRrAKCCVOaz0vsXq7dROMa+bcTeXYd33MmCDUx7S7DoYqo3qbFfGkR/+b8Hl
         ZHms2n3RXjFHr2//Y+C+rDSFds111oE2XwutlhC1Me/z30opiOtwGWk2/xjhk1WlniHM
         t9Ml/aNXuq7S+NL+2nsvV5bLVCzPEn+5cYMFDH4H3HpcFto9KrarcBS1Btfg5PwmQQ+T
         u+y1qzKo2Q/bkurtqF5CG3S5Q1QKzom0pKA23BORYLU4FTS1tpmuCjOsdBvmy+tzoTV4
         LOlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbPHhQRqxWUlIQ5ig2edUu4ZupPcDmCZMrwO02odl38wOG4EHP8c2uvJ9zT81I6OqWzqcfV6wnREg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym05wWFcutSaybqByPUUJwa5lyogyXv702/WS6/8DxNB9nYC3g
	gZlOhcHXTi5kFHAcOFFgjJ9ffDC94ss9Ep7fDOjHg8IcmP85dR9WvFTkr6Egkn+sQywaMqbS0yH
	4nZHuirwBqCyzZEwKpnh2pDYUH9EUaup6loMP
X-Gm-Gg: ASbGncs+QUT/6YkCeklbzQwriXju8z8Gz8oPaglcH9/OX4fy9uHG+Nbwyxw6d7bh8J8
	Kw1F1W9Py+BsP4Y6p1TGckYOhdkhZLc5qMmN85SkJSDqa0hySApL0XKUux3LWo+GOWZ+8Obyw4f
	23kIo7TBE=
X-Google-Smtp-Source: AGHT+IGr1my12RYkl+Ij00kvlAP4QJ/OySM4/tIFPv7UOgx9QHWob6juqt3iHZGn7N0ucaI3iujxsioqE176s+PKlAA=
X-Received: by 2002:a05:690c:6209:b0:6f9:a402:ff5e with SMTP id
 00721157ae682-6fd21e2daf7mr13573997b3.20.1740521723650; Tue, 25 Feb 2025
 14:15:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220192935.9014-2-stephen.smalley.work@gmail.com>
 <CAHC9VhTXzweNA+h37ZBMjymbuar32tmr4aa9Qphk8JM4ya+y0A@mail.gmail.com>
 <CAHC9VhRp1Q6VsYNPmcQ480j8FLamSkMSj=HzBU0MuikEbgQvRw@mail.gmail.com> <9dd4a808-3f02-4978-8d51-fbfca5676991@oracle.com>
In-Reply-To: <9dd4a808-3f02-4978-8d51-fbfca5676991@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 25 Feb 2025 17:15:12 -0500
X-Gm-Features: AQ5f1JoVZ4avDw0va_dtaMOQxIqfxhBOYP_pjiY-DR3g8eU4d-lEs8cNXk8GpnY
Message-ID: <CAHC9VhRQ+mQTV5z_H1PBVTYzem=VxTE_ZDkQbB8oFTD2AhiJmw@mail.gmail.com>
Subject: Re: [PATCH] lsm,nfs: fix memory leak of lsm_context
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-nfs@vger.kernel.org, casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 3:43=E2=80=AFPM Anna Schumaker
<anna.schumaker@oracle.com> wrote:
> On 2/24/25 9:44 PM, Paul Moore wrote:
> > On Fri, Feb 21, 2025 at 3:10=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> >> On Thu, Feb 20, 2025 at 2:30=E2=80=AFPM Stephen Smalley
> >> <stephen.smalley.work@gmail.com> wrote:
> >>>
> >>> commit b530104f50e8 ("lsm: lsm_context in security_dentry_init_securi=
ty")
> >>> did not preserve the lsm id for subsequent release calls, which resul=
ts
> >>> in a memory leak. Fix it by saving the lsm id in the nfs4_label and
> >>> providing it on the subsequent release call.
> >>>
> >>> Fixes: b530104f50e8 ("lsm: lsm_context in security_dentry_init_securi=
ty")
> >>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >>> ---
> >>>  fs/nfs/nfs4proc.c    | 7 ++++---
> >>>  include/linux/nfs4.h | 1 +
> >>>  2 files changed, 5 insertions(+), 3 deletions(-)
> >>
> >> Now that we've seen Casey's patch, I believe this patch is the better
> >> solution and we should get this up to Linus during the v6.14-rcX
> >> phase.  I've got one minor nitpick (below), but how would you like to
> >> handle this patch NFS folks?  I'm guessing you would prefer to pull
> >> this via the NFS tree, but if not let me know and I can pull it via
> >> the LSM tree (an ACK would be appreciated).
> >>
> >> Acked-by: Paul Moore <paul@paul-moore.com>
> >
> > I realize it's only been a couple of days, but pinging the NFS
> > maintainers directly in case this has fallen off their radar ...
>
> Thanks for the ping on this! For whatever reason, my email client decided
> to (unhelpfully) put the rest of this email thread in my spam folder. I'v=
e
> applied it for v6.14-rc.

Thanks Anna :)

--=20
paul-moore.com

