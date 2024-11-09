Return-Path: <linux-nfs+bounces-7818-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 576509C2C19
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 12:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732531C2101B
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 11:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236C914EC6E;
	Sat,  9 Nov 2024 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mclR8RRz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C762233B;
	Sat,  9 Nov 2024 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731150703; cv=none; b=akBVYuHEtJuuGSWwmB7VRBLAP6bw0ReZB6rWu1a8iIbSDLso8HhK69DpuL10cINqA9lLOEEDSnMIxlHcjncsvssDoMQlDpv0l+L8TSS2t9IaLXCmNEA2R9V9OzDnBkzt2PDbRsD1lqdEa9wkA4b6W4uzigZYcbxKzmcK3wiC0Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731150703; c=relaxed/simple;
	bh=qJR4BkgTYUMICzBgXIHWsAfujVON0TcOp/cy+PBEgkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=VJVV338HBwF8L33Jr3GbBurlZCHIGgbQKF3QNbnLTiCYPD/LMecxdjqFjOtehNRw9bzBKH1GWLAIv8jFErZC/y1PWXnPESrXYksQm6t/ruYHKydDmdcFd6DR+b3BFnF1/vKWyXanExvYeRmn2oayAkgDQX/dP8fYM/JFTczN3VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mclR8RRz; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cece886771so94706a12.0;
        Sat, 09 Nov 2024 03:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731150699; x=1731755499; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vls6mdQsvCeYnodfLpSaptYMkef0HyrpngwDxywbaBE=;
        b=mclR8RRzRM7V/xABe5jV+HcJEItFNUml0KQ2W+4QAtYrDeAMeONAiiRBZQiyavK2JJ
         mhQTVdZuVVO9QarhFumxdQ4cFnydlAaGVCtI3MUJqc6IGI981zRIgFHdJgYhCWvvF1KV
         34smesz5xl5lMQ9qQ8NpmBBWjBjEj+6EjDp9j5W9eVTXzI/TwkfzgkMpBRFpnMUhFp0N
         rUhCx2kajFbColybmAbEgTSoBqxAKqIkPEyBxjwTONVdPnP28TMQW5tbC0Sl1Tm+odTY
         Blk9FKzZYc3a12ZqxCsyAXbGgWG5LU0BSkSQuZKDsn+UZYTWc2wMXwDrKZZBSP5YdrH8
         cvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731150699; x=1731755499;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vls6mdQsvCeYnodfLpSaptYMkef0HyrpngwDxywbaBE=;
        b=AyugzQruznzVNIYCVH5me+mjg4jj5eKAJhj8dvNE8sMJmGr8Zd0FGEKFxnf8K43Qlp
         Ks8h5U+wchE3NAZKUue4ZgsPSpt3b81HTTTzmq3XEfQYsxtvp+fKLhZZcfcNd3rXHsfZ
         5TY7rx4WPNMuvhSSvbameg6Lfk5VPHePvCykFz8pnpcJQzo3E62YwqvnvhdEwOZnCo0h
         zTx1nBfmVdgjgOIcOoYfHt6YAXBc4NHjpQK8gG7mV1QFnnAu8TaXZXNPwqxHnDvzL+F8
         peZGAfxD1mY9qkSblDP1l1Y/5dnaX05MEhLYdpZViiOHHAdAsDwD0AvzX+YRMzWiYrFr
         v4MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIPkXYXWb46R6IHV3pOHx3S50YlfUlVig5sRLXTC/YtzEDSJfx63Gylitr/phCVrkKdiu0kg0yIsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlKL1PJta/vmdhTd9BGBplti6ksFrly9p58HvoRjyhevuhQd79
	QAc1iNe6J36NDdH0OoIhTiJOpDbcdNGmBNll1jk/+w4QluHwztDDrOOL3O3QYwHefMr3qkM0NTe
	N6wWcnkyQkMkbIm2HAyzpNYZI64NNqw==
X-Google-Smtp-Source: AGHT+IHGCOOY29aXJRz4apnKoXsBqZRx+QXHcL4IGOMX5scHX5gwwNe3oxAjMbTxXP+6SKzKpqkaBaglJkobwJ75Cas=
X-Received: by 2002:a05:6402:510a:b0:5cb:77d1:fd7f with SMTP id
 4fb4d7f45d1cf-5cf096f5b40mr6173316a12.7.1731150698494; Sat, 09 Nov 2024
 03:11:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106024952.494718-1-danielyangkang@gmail.com>
 <CAKAoaQnOfAU2LgLRwNNHion=-iHB1fSfPnfSFUQMmUyyEzu6LQ@mail.gmail.com> <283409A8-6FD1-461C-8490-0E81B266EF9D@redhat.com>
In-Reply-To: <283409A8-6FD1-461C-8490-0E81B266EF9D@redhat.com>
From: Sebastian Feld <sebastian.n.feld@gmail.com>
Date: Sat, 9 Nov 2024 12:11:02 +0100
Message-ID: <CAHnbEGKRKrw-9_wnrASVHniZ1RggP+b-YzvwPYM7ScsMvmpCGA@mail.gmail.com>
Subject: Kernel strscpy() should be renamed to kstrscpy() Re: [PATCH]
 nfs_sysfs_link_rpc_client(): Replace strcpy with strscpy
To: open list <linux-kernel@vger.kernel.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 9:40=E2=80=AFPM Benjamin Coddington <bcodding@redhat=
.com> wrote:
>
> On 6 Nov 2024, at 15:20, Roland Mainz wrote:
>
> > On Wed, Nov 6, 2024 at 3:49=E2=80=AFAM Daniel Yang <danielyangkang@gmai=
l.com> wrote:
> >>
> >> The function strcpy is deprecated due to lack of bounds checking. The
> >> recommended replacement is strscpy.
> >>
> >> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> >> ---
> >>  fs/nfs/sysfs.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
> >> index bf378ecd5..f3d0b2ef9 100644
> >> --- a/fs/nfs/sysfs.c
> >> +++ b/fs/nfs/sysfs.c
> >> @@ -280,7 +280,7 @@ void nfs_sysfs_link_rpc_client(struct nfs_server *=
server,
> >>         char name[RPC_CLIENT_NAME_SIZE];
> >>         int ret;
> >>
> >> -       strcpy(name, clnt->cl_program->name);
> >> +       strscpy(name, clnt->cl_program->name);
> >
> > How should the "bounds checking" work in this case if you only pass
> > two arguments ?
>
> The linux kernel strscpy() checks the sizeof the destination.

Then the kernel strscpy() should be renamed accordingly, and not
confuse people. Suggested name would be kstrscpy().
Otherwise this would disqualify strscpy() ever from being adopted as a
POSIX standard, as there are two - kernel and glibc - conflicting
implementations

Sebi
--=20
Sebastian Feld - IT secruity expert

