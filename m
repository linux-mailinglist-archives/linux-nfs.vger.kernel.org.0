Return-Path: <linux-nfs+bounces-7900-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA3C9C5A4C
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 15:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4BC01F23370
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 14:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B28D1FCF6B;
	Tue, 12 Nov 2024 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akTXZvS5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4321FF5F8
	for <linux-nfs@vger.kernel.org>; Tue, 12 Nov 2024 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421544; cv=none; b=RavcLlfrVjuEmcG3RF55Fcwcy59hMD6w7C1isiOojZzwGF9RsS/1rTw6JsYy5AC3c1AvgfNrw3xIoYvFkSNNZVhkykfXmXogfHOeBUhaQsM8lOBaSIF7TlrkrmYtg3xVOK3uGKFG+WzAps9waGKSxmYlQO/6kCUFlQm5xcNjgtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421544; c=relaxed/simple;
	bh=2hM4NHmeeVjMZl/jyM6OsjEHV72o1YxyNVOjyLm16oE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=KGkKV+MERYg9UUBnA3jf6d2tPzIDbhNdAi+eTmxJhw26LwXl7lQgekjsQwyocNTTMY49qq9PFsxsKgk5epG4qaLq1VxBU5EgfmFPdJTLI9MV0wzFyi7xmqa1e3NeoUfexVJEIqxX04zyfudnflqiFxG/RKQ43wuxdGsEoYuf88k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akTXZvS5; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a628b68a7so1018091366b.2
        for <linux-nfs@vger.kernel.org>; Tue, 12 Nov 2024 06:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731421540; x=1732026340; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANiGOX07gK9MaY28/DZGBitUFlG9ew8AJLUXob3HM3M=;
        b=akTXZvS5JEt2Do4gOLmofJ8JORFQoOaSrveAXx87GXkuvPNfZb9V7zHhvkc8o3Q/cS
         mdT3csp6+ihmoALvbhX1qa7XcHLyDGDuWRH54SkTZQz8vp+fHDM21AycwCapySwPXkSV
         Ky7g06dhT5bgu/jPUxdmYnI8JSf+fgM5FUkDqx1PiBs1hWXIiwKHQhmr+6b9voglcYww
         FiE+w3RTqEJowLnalclR5GcJ9QBD7E7ZOPMFHTmtRDHPX4WuzQXD/tKQQBIizcZ1Cu4S
         zU3Ol/sZzfr/FYdRoQjOe71qp6HxRqwTS37lb/icoXVJB47jQDvpCdxA7sM5JA8/yZ9v
         4T8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731421540; x=1732026340;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANiGOX07gK9MaY28/DZGBitUFlG9ew8AJLUXob3HM3M=;
        b=h7pEf6QmuuRwMESQZe16KlX8X2uT9jXaxsGY7DDeNmogC42toiALSgp3Laj2OneIs9
         MMb1HVFLExbx8G2CO4hiuCRtQhEHYRnusL1NF06dBLjUPnFa4vOtrPDQAu0f0ah9tgix
         O6Qsg0G9BFZsF9QMOeL+GzafmX2IUUHZs9u8XNK2evJXvbGhDHa8T6NmDz346weRGPb+
         WuafK/JvUcNDUS+y+AWOHnQ9WWia3VMdvju2r33o/WVlZkdqViF/HYDcqr8bHnDHnc1t
         vfvXMtjgO0Dw7atAL3DREVEYD1nlb3wcMvCwcUqeinvul7AHQ17yRydvs5kdCCFxc4h4
         f7SA==
X-Gm-Message-State: AOJu0YycOu1nTOZLBhsxz6N+u2iNxZzTSMNdOrle5xZK6MRdDQbUKdvp
	/1G4aomdNyyAu5pGwaRYv5dwMZe5lZrpbRhGWe8kKftYwSxLKPGaSBB07yb3+jz3WJM8UtK9wDw
	afLyCNT0X6RQ8pl0l9Se4IYcR7/3FPQ==
X-Google-Smtp-Source: AGHT+IF2+gWZRK52kf0bpju7UtOVHW9OTGQ8c9GHEXVfSPIcJRWgjP4fzl0m1VXe6bpKucCMFjrZ4AWsGBN9rkTi7vU=
X-Received: by 2002:a17:907:6d0f:b0:a7a:9f0f:ab18 with SMTP id
 a640c23a62f3a-a9eefeec9f4mr1477482766b.20.1731421539943; Tue, 12 Nov 2024
 06:25:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <OSZPR01MB7772841F20140ACC90AA433B88582@OSZPR01MB7772.jpnprd01.prod.outlook.com>
 <CAHnbEGKJ+=gn4F5tuy+2dY58VS7wOyhyxEqsBQ5xdzXMs-C7cw@mail.gmail.com>
 <B74B2995-94D8-4E45-B2D7-3F7361D1A386@redhat.com> <CAHnbEGL_WD1M2FSQbNkCuZyUSMo8ktUsWRLYFjZ-NKKe1aoLAw@mail.gmail.com>
 <8F936203-8576-4309-B089-E8F38B477E7B@redhat.com>
In-Reply-To: <8F936203-8576-4309-B089-E8F38B477E7B@redhat.com>
From: Sebastian Feld <sebastian.n.feld@gmail.com>
Date: Tue, 12 Nov 2024 15:25:03 +0100
Message-ID: <CAHnbEGL1FVT+dfeSK=UUohNzRpvUZFnrM4dD1mwiYHCHeQUHLw@mail.gmail.com>
Subject: Re: rsize/wsize chaos in heterogeneous environments Re: [PATCH]
 nfs(5): Update rsize/wsize options
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 3:21=E2=80=AFPM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> On 12 Nov 2024, at 9:06, Sebastian Feld wrote:
>
> > On Tue, Nov 12, 2024 at 2:56=E2=80=AFPM Benjamin Coddington <bcodding@r=
edhat.com> wrote:
> >>
> >> On 12 Nov 2024, at 6:27, Sebastian Feld wrote:
> >>
> >>> On Mon, Nov 11, 2024 at 8:25=E2=80=AFAM Seiichi Ikarashi (Fujitsu)
> >>> <s.ikarashi@fujitsu.com> wrote:
> >>>>
> >>>> The rsize/wsize values are not multiples of 1024 but multiples of PA=
GE_SIZE
> >>>> or powers of 2 if < PAGE_SIZE as defined in fs/nfs/internal.h:nfs_io=
_size().
> >>>
> >>> *facepalm*
> >>>
> >>> How should this work at all in a heterogeneous environment where
> >>> pagesizes can be 4k or 64k (ARM)?
> >>>
> >>> IMHO this is a BIG, rsize and wsize should count in 1024 bytes, and
> >>> warn if there is no exact match to a page size. Otherwise non-portabl=
e
> >>> chaos rules.
> >>
> >>
> >> I'm not following you - is "BIG" an acronym?
> >
> > I hit the wrong key. I wanted to write "BUG"
> >
> >>
> >> Can you explain what you mean by non-portable chaos?  I'm having troub=
le
> >> seeing the problem.
> >
> > x86-only-world-view: There are other platforms like PowerPC or ARM
> > which can have other page sizes, and even the default page size for a
> > platform can vary. ARM can do 4k, 64k defaults, servers default to
> > 64k, IOT machines to 4k.
> > So this is NOT a documentation bug, it's a bug in the code which
> > should do what the doc says. Not the other way around.
>
> What's the bug in the code again?  I'm still not seeing the bug.
>
> Why should the code set the max io read/write size to a multiple of 1024
> instead of a multiple of the page size?

Because "pagesize" is a non-portable per-platform value?

Sebi
--=20
Sebastian Feld - IT secruity expert

