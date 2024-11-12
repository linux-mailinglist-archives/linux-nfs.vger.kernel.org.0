Return-Path: <linux-nfs+bounces-7898-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A209C59E9
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 15:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99642280FFC
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 14:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABD61BD9EC;
	Tue, 12 Nov 2024 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAx7zGUi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1BB1C9DD8
	for <linux-nfs@vger.kernel.org>; Tue, 12 Nov 2024 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731420424; cv=none; b=pmSpcghrey/xsnC/V9ynFFS0KXTsVjxhrp2ZK9sWaDeQRQJCiOexWf3vPsrFLRbUVDWgxBj2jRuZXJsvz3Kre/PcOXkZBLUpGoZgpvW413oAqcnmy2NTLH/rZS7j+2JVg2FFxvL8jqnI2BMLfhrzYOHO1AyXyYtBhn1G3gs4Tqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731420424; c=relaxed/simple;
	bh=513wM/h6sjFkJ2FBZpLnK0AHYESeihoRAeMqQIwKpuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=M94cC3G0vk/utNNbx67XJ1imEs6vzhmQQ5QDe6BL9JDuNIeJ8IB4C4MEvqIL9DAycgTo2J1LZJI4Hznj6X5GQIsFKrBZNRDb50NWeVQOOyxCkrOw/l3F1k8X9Jp97uZEdPSWg8FAnpGq1LKnGGer0i4ADwlRXDxF6VPWSYxdWkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAx7zGUi; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa15ede48e0so157462966b.0
        for <linux-nfs@vger.kernel.org>; Tue, 12 Nov 2024 06:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731420420; x=1732025220; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrMO38+0FbPx1Gr/fLRxp4UhzyO4jODGxDVGnUuhm8k=;
        b=iAx7zGUiv4t1frWPWdLUBtY89SDXbM6ZDxVuKA4cMQ2DXS7LgUAgy97s7Iql2U63Iv
         aJybjjaRv/UkTJql0Yw5AWbAcB87OE4e6WWg9u7U88KKI0BWRtUuCk1TIvyesxR8b2o+
         Ieg4/egmMiWrqCC/48YV67aZ7F8N7jWL+uYE8FSvrEKxCKtfYkakgi6p5gmPYuyf0shR
         9cz7XQwctHWyBZRNQUz/++HpOH9MaoFhyUpNV0pWak2NMV75JdPEg9ly0Jhi/TZrHTml
         OGxdNAOqACCELt+lz9oLnFQHfWv/QcCvwYaLuivIXFb+REASUo/+FZ3QD9ZLNvr55Rz8
         wRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731420420; x=1732025220;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FrMO38+0FbPx1Gr/fLRxp4UhzyO4jODGxDVGnUuhm8k=;
        b=BTuc+u9uCJC2y4MeWMw50cFXvMJ1KoMiN824B+3Mk7zpSOfsKtAzHAxoZVVqGE7XjR
         eDbY7PU4XFfPQCcwwE2nvIrUbiWNbhwNpDW0MV85blLZRWHy7YOuuTQNBO6LTu//E658
         /4EPDUlIcysslzpo/TKaURC1lA6rzSDcuc9JwdCEoRwVBlQFeabnuL7V84N9I1XOgbqh
         KjdGjvJymK16R0jpPQU0plx7TXRDUDX/e6NMn422SviTGchRKG6Yib1wmY53nPkJTBMt
         WVwty/azUkOu4YHPvnaEekz59IYVn/nxrS8JF7jajWEcjaQEqKrXC9s2HzPh1XftRzIi
         h51A==
X-Gm-Message-State: AOJu0Ywuyj8LwYxRSwKSPRAB7x8Qgw8PRJYnUbnlvMGlgtrp9WZF6PCg
	Yaq1aSTBir1gIb+XVjoyHmO/+ZCMPJd40aQV3hzu2Aw6V3niAg5ArF7LIbExZbWJnQKUW9uearv
	dLpJm0cvpYJpzzz6c8QS5BqWNyw3Bgg==
X-Google-Smtp-Source: AGHT+IH6OvF7SxxQGPQAVYcEBLNVxSMZZ/wBczu0FZ9WX538Goxmk2vCGvXsgbe1UNJXbTTAMR1c2MpeD90V4nYkmwI=
X-Received: by 2002:a17:907:3fa2:b0:a99:5f16:3539 with SMTP id
 a640c23a62f3a-a9eefcebbd5mr1763351966b.0.1731420420300; Tue, 12 Nov 2024
 06:07:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <OSZPR01MB7772841F20140ACC90AA433B88582@OSZPR01MB7772.jpnprd01.prod.outlook.com>
 <CAHnbEGKJ+=gn4F5tuy+2dY58VS7wOyhyxEqsBQ5xdzXMs-C7cw@mail.gmail.com> <B74B2995-94D8-4E45-B2D7-3F7361D1A386@redhat.com>
In-Reply-To: <B74B2995-94D8-4E45-B2D7-3F7361D1A386@redhat.com>
From: Sebastian Feld <sebastian.n.feld@gmail.com>
Date: Tue, 12 Nov 2024 15:06:23 +0100
Message-ID: <CAHnbEGL_WD1M2FSQbNkCuZyUSMo8ktUsWRLYFjZ-NKKe1aoLAw@mail.gmail.com>
Subject: Re: rsize/wsize chaos in heterogeneous environments Re: [PATCH]
 nfs(5): Update rsize/wsize options
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 2:56=E2=80=AFPM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> On 12 Nov 2024, at 6:27, Sebastian Feld wrote:
>
> > On Mon, Nov 11, 2024 at 8:25=E2=80=AFAM Seiichi Ikarashi (Fujitsu)
> > <s.ikarashi@fujitsu.com> wrote:
> >>
> >> The rsize/wsize values are not multiples of 1024 but multiples of PAGE=
_SIZE
> >> or powers of 2 if < PAGE_SIZE as defined in fs/nfs/internal.h:nfs_io_s=
ize().
> >
> > *facepalm*
> >
> > How should this work at all in a heterogeneous environment where
> > pagesizes can be 4k or 64k (ARM)?
> >
> > IMHO this is a BIG, rsize and wsize should count in 1024 bytes, and
> > warn if there is no exact match to a page size. Otherwise non-portable
> > chaos rules.
>
>
> I'm not following you - is "BIG" an acronym?

I hit the wrong key. I wanted to write "BUG"

>
> Can you explain what you mean by non-portable chaos?  I'm having trouble
> seeing the problem.

x86-only-world-view: There are other platforms like PowerPC or ARM
which can have other page sizes, and even the default page size for a
platform can vary. ARM can do 4k, 64k defaults, servers default to
64k, IOT machines to 4k.
So this is NOT a documentation bug, it's a bug in the code which
should do what the doc says. Not the other way around.

This is a common design problem if engineers only think about
x86-only, and then surprises admins if things go haywire because their
assumption about page size is wrong.

Sebi
--=20
Sebastian Feld - IT secruity expert

