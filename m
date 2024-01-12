Return-Path: <linux-nfs+bounces-1054-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5607782BB0B
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jan 2024 06:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF691289F2B
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jan 2024 05:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6639C5C8F4;
	Fri, 12 Jan 2024 05:49:48 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27555C8F3
	for <linux-nfs@vger.kernel.org>; Fri, 12 Jan 2024 05:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7ba903342c2so346236839f.3
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jan 2024 21:49:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705038586; x=1705643386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJRHKRh9M4h9G4PX0oJMrMWLBjVI2Qh1cugvbSflOUc=;
        b=KMswwG0h73hnli3q4SeZBjchEmBVvm76jKGGbVSFD7XrBj1zk95mdor+adqT1ag8gx
         jQSYEatlSqnSwr1l9cLGy3u670c1gp3qc7fckKeGcy355C/r3gF/6oOcxkcxpI9Tpo0Z
         PY9VSVhoeU2rsVC31IvmQghYrqv+hjwO5txne3DnXnnv3e4CsX3FAZuBTS3648iJZ+0r
         cwFx9ujs7MKf7jpR0nvOw1XuO6oHPbHIvG3nCWENEIt4iDlL6OwD+G/N2Vktxa/sBUzX
         3B0d8Yqv8+RxDz96kgnXfPsYrWrfPCeijn7tw6lVPOBBRyy6tiswz1jmPuxD/UU+Vwc0
         cpYA==
X-Gm-Message-State: AOJu0YxScRSSYBifukOio3DYSQ+CZlIoCz8EIxotUtQko7OY7qA3KQHT
	pRxs9NfCTWzE4ffMKVz1b9qB1/PQmlbEpsARNasLzI6d
X-Google-Smtp-Source: AGHT+IHeSx8oYKWSi2n/j6JSjrxh11ekKuqzKIrhQm4DpRxTGsfTkE6H5BM+M51MuNJR0vytqE47SkpSgQYLo6J8cok=
X-Received: by 2002:a6b:6c07:0:b0:7be:e783:850e with SMTP id
 a7-20020a6b6c07000000b007bee783850emr816118ioh.39.1705038585681; Thu, 11 Jan
 2024 21:49:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQniGNGuPm5CTTs3oJRuCH40HTt6K91nCAPRnt0tECxkBA@mail.gmail.com>
 <bce828afb68c973d684b3e179cf8d6ce39c8b9c3.camel@kernel.org>
 <39adc7fc114c6f8ea38fe7c846c322dab5fac907.camel@kernel.org>
 <CAKAoaQkdY-NOgWoVKN+oitTSFbmfC7fixoxDfXR0SF-6EJrEOw@mail.gmail.com>
 <5057fdb94f4d61661f9d13ccadb775a3a5bcdc92.camel@kernel.org>
 <CAAvCNcCC7xB1oWoSxaL269T62TuOYx64A+49fRoJTFJZ6xD+EA@mail.gmail.com> <6065a76f32face0fa5cf84a238bcb1f2eebec7b5.camel@kernel.org>
In-Reply-To: <6065a76f32face0fa5cf84a238bcb1f2eebec7b5.camel@kernel.org>
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Fri, 12 Jan 2024 06:49:00 +0100
Message-ID: <CAKAoaQnEm2yO2P2gxe5-F4RzFyGBs5gsuaV1A76DsnwAz0gszw@mail.gmail.com>
Subject: Re: NFSv4.1 mandatory locks working in Linux nfsd ?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 2:24=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
> On Fri, 2024-01-12 at 01:44 +0100, Dan Shelton wrote:
> > On Thu, 11 Jan 2024 at 23:53, Jeff Layton <jlayton@kernel.org> wrote:
> > > On Thu, 2024-01-11 at 22:27 +0100, Roland Mainz wrote:
> > > > On Thu, Jan 11, 2024 at 4:55=E2=80=AFPM Jeff Layton <jlayton@kernel=
.org> wrote:
> > > > > On Thu, 2024-01-11 at 10:54 -0500, Jeff Layton wrote:
> > > > > > On Sun, 2023-12-24 at 18:29 +0100, Roland Mainz wrote:
[snip]
> > 2. No one is going to implement a giant set of code just so that SAMBA
> > and NFSv4 can work. SAMBA has a builtin emulation so mandatory locking
> > works between Windows clients, ignoring the Linux side and Linux
> > advisory locking completely.
> >
>
> Also, pretty much. With a general purpose OS like Linux, we try to avoid
> this sort of emulation. We do have that for the share/deny locking that
> happens during OPEN, but there was really no choice there since we
> couldn't reasonably implement that in the VFS, and it was a required
> part of the NFSv4 protocol.
>
> Mandatory locking is optional so we can just opt-out.

How can I test for that in a NFSv4.1 client implementation ?

----

Bye,
Roland
--=20
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /=3D=3D\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)

