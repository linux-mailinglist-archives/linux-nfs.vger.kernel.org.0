Return-Path: <linux-nfs+bounces-119-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 379997FAFC8
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 02:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E878428123F
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 01:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8104C7B;
	Tue, 28 Nov 2023 01:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggbYj2Ud"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC2BD4B
	for <linux-nfs@vger.kernel.org>; Mon, 27 Nov 2023 17:51:02 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-53fa455cd94so3243174a12.2
        for <linux-nfs@vger.kernel.org>; Mon, 27 Nov 2023 17:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701136262; x=1701741062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajafkxmmW6wr55kwFcivGc1utxXjBRcCzXuLWDN8OaI=;
        b=ggbYj2UdfOhob1SCEijeHml53jpsc/zZcyaQ9cK2/AdcFa2lIC4dwgWE85r+8qJ/w0
         crgLzlwCo+IIUw3yRcGtfAl6YM54e19SHB3k4T1nR6MKOTM3RzVfNebGX1pTh85hsXjN
         RZIdI3KPJ5aNEBXTqmqrdpXgFWbQ1SnuCrJXgclflN9fk6iBGiDdYrqqX7ULYYwy8GtS
         yApbNdQM61fTX0uBb6OvmoGCkFjfqhe8/+HlN0oZLLPx/h4052qx4Ickh3hExq6kiZDn
         VUFb/uyP6tGNA+htoaFlFFyOp1AhVWa4oMljmSuq8Zuiu6Dk2DWxM/SQLyDCumoleEDo
         gXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701136262; x=1701741062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajafkxmmW6wr55kwFcivGc1utxXjBRcCzXuLWDN8OaI=;
        b=SXMWfY7xDonA63ne8rd4hd8dUqneYKpv3nL7p0RstDZtYNeDOTsH4p0zaI6QWYkQXD
         iDbBFUcNJ5sMW7qnKJYnk3ASx5ixuh6TmArzYsJw8LUJHqK3E1vuiKinFYXubx3pcTGo
         jgdxNkIOY5Org5GYRyRyvIzrG6UStjGQeIMJMuLpyg23nhTrLRivVVvp8qlffMBjav4B
         mIYErtRqF+/h/3MCxJhTQ8+l0VBsFzkOfGrhyZdNMWIYvI12KMWE8DlX7E+04yqS1bDY
         /Yw8b7I/9gQGcYbQto/d7Rl/Q4GWC/okcaRDgOMfdqB/6o4tuPwWLEI2UE+p1gYgU6aJ
         FyBw==
X-Gm-Message-State: AOJu0YxINshtRe39xEN2S2Wb3f8+YcRN1oycGfsdjI8ewcPAmK4rHcqv
	Lav4E5j3d9cULqB/qvMrU98cLwUHdWwyZIq6bg==
X-Google-Smtp-Source: AGHT+IHXmhz/+HaQ+gKkIhaWX4+FyfsAU2U1XaR1pwuMQ/Te5jla38x9HVfoOOPgASVbropsY1NoZClWkCu0SZvQ06s=
X-Received: by 2002:a17:90b:1e4f:b0:285:a65c:64e7 with SMTP id
 pi15-20020a17090b1e4f00b00285a65c64e7mr7818161pjb.18.1701136261888; Mon, 27
 Nov 2023 17:51:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c609e5f9df75438dbfe3810859935d58@epfl.ch> <2d948b43fa625952e50589e4bedf9551df7ee112.camel@hammerspace.com>
 <7d2d17e4d3904d29b75fadcfd916b2a3@epfl.ch> <ZWTFn0/FtJ5WuQGc@infradead.org> <7E2914D2-B9AB-4280-9A44-875DA8B58328@oracle.com>
In-Reply-To: <7E2914D2-B9AB-4280-9A44-875DA8B58328@oracle.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Mon, 27 Nov 2023 17:50:49 -0800
Message-ID: <CAM5tNy4qVXXS3sHqx7Y3Ndt2YNnd1hrj32iJdo9KMi+ByMfEuQ@mail.gmail.com>
Subject: Re: Question about O_APPEND | O_DIRECT
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Tao Lyu <tao.lyu@epfl.ch>, 
	Trond Myklebust <trondmy@hammerspace.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 8:51=E2=80=AFAM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
> > On Nov 27, 2023, at 11:36=E2=80=AFAM, Christoph Hellwig <hch@infradead.=
org> wrote:
> >
> > On Mon, Nov 27, 2023 at 03:28:16PM +0000, Tao Lyu wrote:
> >>
> >> O_APPEND | O_DIRECT can be used to bypass the client cache for multipl=
e threads writing data without caring of the orders (e.g., logs).
> >>
> >> Yes, to support O_APPEND | O_DIRECT, NFS must first support APPEND.
> >> But the key point is that looks like NFS has supported O_APPEND alread=
y.
> >> I can successfully open a file with "O_RDWR|O_APPEND".
> >>
> >> My confusion is why NFS supports O_RDWR and O_APPEND individually but =
does not support this combination.
>
> O_DIRECT is supposed to not depend on any cached information,
> including the file size, which the client needs to know to
> form an NFS WRITE with the correct offset to ensure it is an
> appending write.
>
> File sizes are managed on the server, so the server needs to
> know that the client is requesting an appending write so it
> knows where to put the payload.
>
>
> > Well, it does support O_RDWR|O_APPEND, just not with O_DIRECT?
> >
> > Btw, I think an APPEND operation in NFS would be a very good idea, and
> > I'd love to work with interested parties in the IETF on it.
It is not easy to deal with w.r.t. RPC retries.
I suppose a NFSv4.2 extension that either requires (or strongly
recommends) persistent sessions might work?
(Persistent sessions should pretty well guarantee an RPC is not
redone on the server.)

>
> You can write and submit a personal draft that describes it; it
> wouldn't need to be more than a few pages. The hard part of that
> would be accumulating use case descriptions.
>
> I think you could create a proof of concept by including a VERIFY
> operation in front of the WRITE to ensure the WRITE occurs only
> if the offset argument in the WRITE agrees with the file's size
> on the server. If the VERIFY fails, the client grabs the updated
> file size and tries again.
This is what the FreeBSD NFSv4 client does.
Since compounds are not atomic, it is not guaranteed to work and
you might get a lot of "tries again" if multiple clients were doing the
appends on the same file concurrently. (The compound includes a
GETTTR size before the VERIFY, so trying again is pretty straightforward.)

rick

>
>
> > Not that
> > we (Damien to be specific) plan to add support to Linux to also report
> > the actual offset an O_APPEND write wrote to through io_uring as we
> > have varios use cases for out of place write data stores for that.
> > It would be great to also support that programming model over NFS.
>
> --
> Chuck Lever
>
>

