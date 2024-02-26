Return-Path: <linux-nfs+bounces-2085-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 793C2866AA9
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Feb 2024 08:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194691F212EB
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Feb 2024 07:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BC31BF28;
	Mon, 26 Feb 2024 07:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwsyrG/s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9DF1BF20
	for <linux-nfs@vger.kernel.org>; Mon, 26 Feb 2024 07:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708932603; cv=none; b=oj/8WxN/JMHmoePrtFBjCkS26bxXMf/EVkuWuojI6LtnRok1JTCmgWf5iCNo1Y894xDfvHGQYVt/9iygnDV1oAJMEwrr7SBT7hRaMQzYTnwcDu2O89vDT7PSh/m7fWEt2u7OorP6Mr7C3PiBQi4jxEymyhoKahmRhalEPOFb8ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708932603; c=relaxed/simple;
	bh=HsIrv8ezPBDGARg525yyVzXpeh1s8i6oxjE8WSvKIDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=sgIbwXY0QAkRQJ6TJTAgOpIz/0eqmYpTvy+hL90VR+oSXLfj0m9YZXw2JLmlzM9tN9SQBQ6aaYOz6NGs7ZAe/EduSVd5I3IAHzSNMqX6pDaXyqqz5WHvfG6YF0tugoy7kEKSH23dR0809nL6ZOIX3x3tP9HhuDXti1Gu12ry07U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwsyrG/s; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c199237eaeso1232708b6e.0
        for <linux-nfs@vger.kernel.org>; Sun, 25 Feb 2024 23:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708932601; x=1709537401; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsIrv8ezPBDGARg525yyVzXpeh1s8i6oxjE8WSvKIDg=;
        b=iwsyrG/sWa7FD4WlT3q988oQQyRPUhE31KER4IVYQvOA6zKBIBdn0WLfPyjLbZG604
         Se5B62frAQCJC7eshxUSAR9yeCfQH3tszJvzRrkoxliNaiNChQRrneAymVTWKbwK8+IH
         RqX/x2PPpZNmWHBNALadDPMwyMjxbGyZg4VXN56NSGxomhjl0esR5usM83sUrgyrtr23
         wvtMHCVRZCzQO59ZrWLzCfBdhHLhyKhfIT+syvE+YcFKYFjK5r6e4+QosK9RJywKRrZS
         eblkqv89M3PYqINKn2DcaAP4YxM6uLJ9iyvjZuTuugpYFevrzgqApScx4EnqR9jF0JaU
         zs1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708932601; x=1709537401;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HsIrv8ezPBDGARg525yyVzXpeh1s8i6oxjE8WSvKIDg=;
        b=RYDvNYLr6BgEv9jw0gyD9lyoJ4tNHIWVK6TGCn0ZVA2jA213kioLN4Ccs3+U9kKfan
         /XwV7cVDTy3J9TxWmi3ReN5tH7baSbNfbQVm3HuPcHSAbUON92IaTXqVsVgO4UkCaBRL
         sQNMDEvGugxb1ZGla3TlmgndZZrP8PnnOQiDohXpDZ5SE6DNhH3wEQ/YhKNiMU0sXuhg
         i0rA/jmMwCcbIacaTzd5txtxY01hJq4e/WvJKys5hiWB3LOBakq5yaKARrScEnkhFaV6
         d28AVTNjMwpYQhN8jek6KR4ONYHXMYTR8lB4hQkQFvMN1ibJuOP8TRarc9hNiVorow5b
         Lcqw==
X-Gm-Message-State: AOJu0Yw6fq2YijtBJ7yTfJ2sTr2X23q1l0NguCUjNHnB8J7TONkbQiTy
	ZD8hTLb1HhF/Xh+FnFgLohBiwqYjm1pTNwOn+thYxg7v0Zp7rrINk3znXghK15pt90Uv4ZLFkvM
	wFaYOGm5xnHo+iiVYelcSAIE/MnWLwcd1
X-Google-Smtp-Source: AGHT+IFSbf17h9gSTqTilGoR/p3nuhbKzDYoPFsSowzS91xrjxOTYQ/sxAIK3vSmrRb7+6U6wMI5VOPpMTtUsUdKhBg=
X-Received: by 2002:a05:6871:79a2:b0:21e:a8ff:1d2e with SMTP id
 pb34-20020a05687179a200b0021ea8ff1d2emr7818969oac.34.1708932601378; Sun, 25
 Feb 2024 23:30:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANH4o6P-jze6MB8yh3sWxhyHJWdj+JHK3vw58cYwQ0a7eVe_Vg@mail.gmail.com>
 <c397fb11a172be26111e1ad5cb17a92bceb065d3.camel@kernel.org>
 <CANH4o6O-Gcjc3eqiTd-KysZx-bpbzoh=CMTNixJ26cZQuRd=UQ@mail.gmail.com>
 <2e4760a87e1fc6906562442c27933e830635a929.camel@kernel.org>
 <CAENext6Zuv0pLgzp_vcBqdKmrH6Bg5GDV_hnUNOeFK2juoiJnw@mail.gmail.com> <7e499dd1deafcf043229973968920947453d4eba.camel@kernel.org>
In-Reply-To: <7e499dd1deafcf043229973968920947453d4eba.camel@kernel.org>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Mon, 26 Feb 2024 08:30:00 +0100
Message-ID: <CANH4o6OmdiGDUjQd25Mza_bZX6zq5Vw85cD9X4RexWSQqxY4NQ@mail.gmail.com>
Subject: Re: SELinux-Support in Linux NFSv4.1 impl?
To: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 3:35=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Sun, 2024-02-18 at 16:16 +0200, Guy Keren wrote:
> > On Sun, Feb 18, 2024 at 3:55=E2=80=AFPM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >
> > > On Sat, 2024-02-17 at 14:37 +0100, Martin Wege wrote:
> > > > On Wed, Feb 14, 2024 at 12:28=E2=80=AFPM Jeff Layton <jlayton@kerne=
l.org> wrote:
> > > > >
> > > > > On Wed, 2024-02-14 at 10:46 +0100, Martin Wege wrote:
> > > > > > Hello,
> > > > > >
> > > > > > Does the Linux implementation server&client for NFSv4.1 support=
 SELinux?
> > > > > >
> > > > > >
> > > > >
> > > > > Labeled NFS is a NFSv4.2 feature. The Linux client and server do =
support
> > > >
> > > > Is there documentation on how to set this up? Will this work if the
> > > > root fs ('/') is NFSv4.2?
> > > >
> > >
> > > There isn't much to set up. If you mount using NFSv4.2, the client an=
d
> > > server should negotiate using SELinux (assuming both are SELinux
> > > enabled) and the SELinux contexts should (mostly) be projected across
> > > the wire.
> >
> > Jeff - as far as i know, while it is possible for the client to
> > get/set the secure labels of files on the server - there is no way for
> > the client to tell the server which user is performing the specific
> > access operation - so the 'FULL MODE' of nfs4.2 security labels cannot
> > work - only the 'Limited Server Mode' mode (i.e. only the client
> > verifies the security labels - the server does not). please correct me
> > if i'm wrong.
> >
> >
>
> (re-cc'ing the mailing list...)
>
> That is correct. I'm not aware of anyone having implented "Full mode" as
> of yet anywhere.
>
> The Linux server is a "dumb" labeled NFS server that just projects the
> contexts to the clients and doesn't try to do any enforcement.

Is this documented somehere? "NFSv4.2 SELinux HOWTO" maybe?

Thanks,
Martin

