Return-Path: <linux-nfs+bounces-7177-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4AD99DA26
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2024 01:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 275C4B21A9F
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 23:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DD31D9A5B;
	Mon, 14 Oct 2024 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="F2FY5YMt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972B61CBE8B
	for <linux-nfs@vger.kernel.org>; Mon, 14 Oct 2024 23:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728949007; cv=none; b=LcuMfngTdif/7SNNjrYiW/UPS7/2ete86Q79d00NPuS7xFik3fmK5XH++OBwztSceQpcxXDpY8jtt6Q+b3FkkrNyAY8WnMQzw3sg9DaRUDnIbBtFLusJyPxYmYoEerV5rAAsmSx1c71lwYyyIn39EcDIha0wHbjZ6c8LD33+wks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728949007; c=relaxed/simple;
	bh=YYiSmCPN3TvqJgCL4LqcmX67TPAVLvdjqxfU7qETvaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ErghVI66vhYNJKMcELsprp2k5z+cS6y0hyddV3irLrJkC9B7Rq0c18flDZZjNoxbktSpvIzsdjv6hz947uaE7o36Vb/sVGPjwRyMWqmJFKnSHnaYsPKMV1je2mcroD5gGMPs1nak4rUPLDxUAFzG2N/jajxkm7jgRyE7rnmgbfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=F2FY5YMt; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e29687f4cc6so199108276.2
        for <linux-nfs@vger.kernel.org>; Mon, 14 Oct 2024 16:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728949003; x=1729553803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7EptkXWnpaL/k/9PWhawROS2K5xJQhwh/HCtCSp7fE=;
        b=F2FY5YMtfY8LTdR83BaogIdDfZw31DZW2IZuq3TkE4TYsBnDPWJP65FDDflBgD850P
         hgn9nMVY2Xu3rEPNYqeiP77QalKBXAsY880pdIILjDRKp9vJtErmvtWP6JKLPI6i+B0o
         tIm+VkQHbCK5Q1DREz60HKIsnVkbd4dlZzMqGxAvqU65dDeDsYgPfrUNfTNxSuLrIQpJ
         3KMIzxR9dZJnQkPK1JF2BKaR7DuTKTTiABr7+I8ywUBd+aaNEpogAQwn8uXBzDT5tWux
         XKhSFMWHuE/r+EBXvwKbD0h4JRl8G7HKCanIOOGveG74AyQJ5ShNjwYCg9G+NhFvfUQW
         QDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728949003; x=1729553803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7EptkXWnpaL/k/9PWhawROS2K5xJQhwh/HCtCSp7fE=;
        b=G0IqXZ7nd9PuDjM8nire5WG3sgdyzBRuEV0vAMh6aOik0Lqfr4XY2so4gnhZN+1/1K
         G8bEbprVw4AGu7L3GVcw1mq1WJbFEbxgCJ8r0zV1Gb/F+tDeRv/xkCHaonbhxbtBobH9
         zt9IcINd9d7Wbkj82zNe3j/snWPsRLh/en3lTPHIIftMDbgZeSXxFyJ44OzbZn2N5YUK
         qr1Kzcv7HON77Io3mCc41oizg2u56oofwCZdwaknNPGlb7cpmWNhF4M7KyEsD2N3m6tr
         Ve/mfbHzzuqyQymmuTIyyv+r7Gn2rUr2oOwza5IntkySWxmIYGI9muPzch4XfOBRL9Va
         NJOA==
X-Forwarded-Encrypted: i=1; AJvYcCWa1mLLwG5oAS/NkOuzpyrKuXr1pfrTumYRUCDps+QXzQCpxFpoYHeNZ2rMAQr2XAfdwRKtuFtgWco=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCwNFqrTp9kyfMAzNnj8O2q6w0LmJVg3s7vFzHE3MoSSuAG2Sb
	52tfFlsZ8Sjg5LZR3FBZAHYfmDzU22x7ES7Lw9BW9daiDExAa8oyalZIVo2U1MN/idLx6UhiRfR
	/74Ux5BoF+O4Ldfr3hz7Ef+TVx5OIVBn9elMR
X-Google-Smtp-Source: AGHT+IFt8evXayClmB6u6crNOqWAGK/LqQS6YoxjB76sqksYLFIC+tuagD9Z6iZG7/Bs3SVNOb5KLHTYwWn1DWcVZV4=
X-Received: by 2002:a05:6902:e07:b0:e29:23f7:ccf8 with SMTP id
 3f1490d57ef6-e2931b38df4mr6839532276.14.1728949003636; Mon, 14 Oct 2024
 16:36:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010152649.849254-1-mic@digikod.net> <20241010152649.849254-2-mic@digikod.net>
 <CAHC9VhR8AFZN4tU1oAkaHb+CQDCe2_4T4X0oq7xekxCYkFYv6A@mail.gmail.com> <20241014.Ahhahz2ux0ga@digikod.net>
In-Reply-To: <20241014.Ahhahz2ux0ga@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 Oct 2024 19:36:32 -0400
Message-ID: <CAHC9VhTn=hb7DmB7Py3okcow89OGR31abHrcniSPt+K7ecW_ow@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/7] audit: Fix inode numbers
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	audit@vger.kernel.org, Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 9:30=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Fri, Oct 11, 2024 at 05:34:21PM -0400, Paul Moore wrote:
> > On Thu, Oct 10, 2024 at 11:26=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@=
digikod.net> wrote:
> > >
> > > Use the new inode_get_ino() helper to log the user space's view of
> > > inode's numbers instead of the private kernel values.
> > >
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Cc: Eric Paris <eparis@redhat.com>
> > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > ---
> > >  security/lsm_audit.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > While answering some off-list questions regarding audit, I realized
> > we've got similar issues with audit_name->ino and audit_watch->ino.
> > It would be nice if you could also fix that in this patchset.
>
> I can do that with the next version, but I'm wondering how it would fit
> with the UAPI's struct audit_rule_data which has only 32-bit
> fields/values.

Don't worry about audit_rule_data for the moment, that's obviously
going to require a userspace update as well to supply 64-bit inode
numbers.  My guess is we'll probably want to introduce a new field
type, e.g. AUDIT_INODE64 or similar, that either carries the high
32-bits and is used in conjunction with AUDIT_INODE, or we create the
new AUDIT_INODE64 field as a "special" filter field which takes up two
of the u32 value spots.  Regardless, let's not worry about that for
this patchset and focus on ensuring the underlying kernel filtering
and reporting mechanisms work as expected so that when we do sort out
the UAPI issues everything *should* work.

> Does 64-bit inode filtering currently work?

Likely not :/

--=20
paul-moore.com

