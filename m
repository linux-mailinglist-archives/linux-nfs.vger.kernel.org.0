Return-Path: <linux-nfs+bounces-15994-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8654FC30538
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 10:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 638A34E81FA
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 09:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C5F313277;
	Tue,  4 Nov 2025 09:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rf3pNu0C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1262D23A4
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 09:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762249551; cv=none; b=U8sH4dXkdETxEQGK40A0NOaW1Kp4V1KnVHCyJHlf3YvNWLnoSWLq1CPzFGxquWOhyPpZui8lJKa1szERmdqAen6I/0vI8G70c7WomFZqRVqpAfHtUtUqTQAuUs29jWfHkiH8zCUhZiYiUoka44QogemSvnuWA9YlOIQMD9o40kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762249551; c=relaxed/simple;
	bh=Y/8kkJtUlvT/f8ywlYeX1B4ZoD/ySaLtnH0dGnqnmAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/tNgKhvFfUmRON/Ex31es2xqncIHBQkieHZRhaWV7hPnQNHSBKfLBBxvMNc8isRgFLzUIusZ/cDSmOn2qaI+UQyCEdGRxY3f1k91T45NdP5MJAs/tykcZ/feSyoW4f7Ilfu59XBW0MjGr3AtJSi/GiMRO46kRVUkZDR4ijqRMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rf3pNu0C; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-640c48b3b90so2682278a12.0
        for <linux-nfs@vger.kernel.org>; Tue, 04 Nov 2025 01:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762249547; x=1762854347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKJdWvkPbuojvyFkWrgOJDggLZVTca+r/oAisy+M4uA=;
        b=Rf3pNu0Cg1d48tOeaZtZaLUkE/PEszLIZCf1p0J0eQREPNueGK+mEQ6TOQwKX0fevP
         DG7Bf49VqBKXjMXfX+cxHFvoOdj0HEyx787WuG/kGgy0ZKASykSskdCNsJbQakDLDfmB
         t87jC0FfJaGK2EkHbJ2skXAhafGEtVnaWmFwNihX/9k+M/WkZkLc1S7n6MArxGDLViHA
         mxPiF89Dk7LQiqHnGfCi3TdkBqKIDuUcIWubluYRrUL9svX3Pgcse/je3swjxwnN1W1E
         gUlOLs/2RRZquqbAd/Rto2820kkWJatdFt7IFS0sjW6lP07/tMpw3G0PdkY6g5ulk8uB
         zzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762249547; x=1762854347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKJdWvkPbuojvyFkWrgOJDggLZVTca+r/oAisy+M4uA=;
        b=wXlWnCb2Ab5o9xOPvnBw7rNImm/fxXiSGxslue113mPsFYmjc/WyV7RbDPniNFxhSe
         oGLH1Sk5oxb+JCn5dY3SAm69m7f02es8J1fMwxIhIuVL3RvMa+M3vywwfWXhnqe2TDy0
         3WaQMzyIUmyX6qamfuORL0DLJnr53uS9qeq2ZdSMQKRWypjgFGJmeoUSv8+g6e2uKOSo
         V58VMqIWwoBxCiMfs/EWqU0bN2WjpbN6FP9rBy34LzQzRs2vu6A9Kp9Xt/kdi6fTIInf
         wB0dga678UtSirrXvksgqwVji69lYFY/4rNodToOLen6uMUiGm6Hhhy18hRUj8P7kMhC
         YFwA==
X-Forwarded-Encrypted: i=1; AJvYcCUPoqO56WHXBY2wunfDnFmFFohSmX3KY+j+QOdWoxGJPxZVr4DBDgPx8noPZOY/pqtYFKuOlTGnUyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRRjydv/u1TLgKR8nd9cmW/vl/StyYiGPOCQm0OERu0K/6DG9O
	UHfD+/Ds2f44dOblRaFfdhaQewfMmARlf5Oi+eDNtxBrwR91AP1XO9qr9cCMRBdjrxj3IltGQ66
	D0sbO+FL1XMxniLrbYuM0R1+VI8sCg8I=
X-Gm-Gg: ASbGncvtKpNsZgzRgPA6HVjLn9G2ySdv/PIo73K2MmMPP/hJb1Eel2192DJwKYerXyd
	B/Zd0e4H+CauEXBOQeed+yrjO7UcOLKMeEQiNAU3KMbZWCJyD/VtZygpP7z6qCKVVTA3u0B7Upu
	XDP1Yejm9hg2UoOy9MNgarEvzo3oUmc67KEcP/KA71eJ5E8ruaEgOPURrL2dCr0i5WcrICv3JDa
	jb2g4l4hoFeeMnP0IXeH5VGoS4rdj0GxZb/ptQm3Mc0do28CkL6sKshHGriltW+v805d6uQfgky
	ctlDqvqKgiQ7nxs1H6Q=
X-Google-Smtp-Source: AGHT+IHXA2qJBi6f10DqUtNaDt/G9hT+Ey8B/WnoFdz3Hmrh6KCUpLdIDtROPfgXbvSfxz+h0BRwI+TkCKOqKrtbbyk=
X-Received: by 2002:a05:6402:1462:b0:640:ea21:8bfd with SMTP id
 4fb4d7f45d1cf-640ea219598mr1427481a12.31.1762249547237; Tue, 04 Nov 2025
 01:45:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
 <20251103-work-creds-guards-simple-v1-14-a3e156839e7f@kernel.org> <CAHk-=wiSmez2LFEpM05VUX=_GKJC8Ag68TJDByVPO=x4QwjyuA@mail.gmail.com>
In-Reply-To: <CAHk-=wiSmez2LFEpM05VUX=_GKJC8Ag68TJDByVPO=x4QwjyuA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 4 Nov 2025 10:45:36 +0100
X-Gm-Features: AWmQ_bn9rw0ha0qFFSykU1xP6jfkkEMSMAVkMSHJG30ZX97XNHwd3yxbJVnihQI
Message-ID: <CAOQ4uxhw2Tc4YXwhkS=5EVC3Tg4F+QyrA7LE3V29pNhQ4WJeyA@mail.gmail.com>
Subject: Re: [PATCH 14/16] act: use credential guards in acct_write_process()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-aio@kvack.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 12:04=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 3 Nov 2025 at 20:27, Christian Brauner <brauner@kernel.org> wrote=
:
> >
> >         /* Perform file operations on behalf of whoever enabled account=
ing */
> > -       cred =3D override_creds(file->f_cred);
> > -
> > +       with_creds(file->f_cred);
>
> I'd almost prefer if we *only* did "scoped_with_creds()" and didn't
> have this version at all.
>
> Most of the cases want that anyway, and the couple of plain
> "with_creds()" cases look like they would only be cleaned up by making
> the cred scoping more explicit.
>
> What do you think?

I had a similar reaction but for another reason.

The 'with' lingo reminds me of python with statement (e.g.
with open_file('example.txt', 'w') as file:), which implies a scope.
So in my head I am reading "with_creds" as with_creds_do.

Add to that the dubious practice (IMO) of scoped statements
without an explicit {} scope and this can become a source of
human brainos, but maybe the only problematic brain is mine..

Thanks,
Amir.

