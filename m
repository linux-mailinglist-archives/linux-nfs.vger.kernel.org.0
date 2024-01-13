Return-Path: <linux-nfs+bounces-1072-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E85E82CA6C
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jan 2024 08:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93C22852EC
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jan 2024 07:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6F814262;
	Sat, 13 Jan 2024 07:20:23 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C6B13FF4
	for <linux-nfs@vger.kernel.org>; Sat, 13 Jan 2024 07:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7bed9f5d35dso182026839f.3
        for <linux-nfs@vger.kernel.org>; Fri, 12 Jan 2024 23:20:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705130421; x=1705735221;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQaO4jwVl8iWt7Eao8ro9E0ghkqiLZF2qv8TyF4R17E=;
        b=jHgmK17PnazvC2p2a4IBDYF3kNdIr3FdSc55eRpbI95pYENWdSoxANHGDoVCxoFf1n
         a5XFzvT6N6xstEP+XyBqvFDwkCpisnC6WfpDTmzxWumhuQlKXq014qBzSidp6vWOJUWN
         Zo4+sUMeEbOBG4D1iEo/po3GPgp/auc+mI1Ni14YvHrukdNx1G48ZzVzn/tNlkutBwEj
         1YlW6XCeyzr4uyyMH7xUV+FRlvrDVkfKg/GyQ8KADoCZCw3HS9/EOoupdBsZlBfe1vYc
         WK5CJ3b2ZA9gVPp/OXeCvtk/lhG7YOBbJyFczhRhwNKWxnIp2p0RdRlwXRkap5anLZ2M
         ZwIA==
X-Gm-Message-State: AOJu0Yy9Fd7MNgnzJj9d5z7AiSgywqfTmZmH+40Zcc2knobFfaYP6+dJ
	CwiFUohMi9JY9ciR6+UJUgAx/lp5ZMugp1HYmfg8ilPbcv4=
X-Google-Smtp-Source: AGHT+IEmNPLP7AXWGy2TKznN+x6lZwBaklE4cmHwvbPN+dC12OPPnvmNZjC0Cy65S4JE7br7IgdaIZn/o1d5/mAkYic=
X-Received: by 2002:a5e:d714:0:b0:7bf:8f4:474c with SMTP id
 v20-20020a5ed714000000b007bf08f4474cmr2818910iom.32.1705130420398; Fri, 12
 Jan 2024 23:20:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCNcDtTNDRvUVjUy4BE7eBCgmkb6hfkq3P0jaGDC=OXg0=6g@mail.gmail.com>
 <89fba598b0b93cf97bf208e106001f74eadd1829.camel@kernel.org>
In-Reply-To: <89fba598b0b93cf97bf208e106001f74eadd1829.camel@kernel.org>
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Sat, 13 Jan 2024 08:20:00 +0100
Message-ID: <CAKAoaQmQzvCxhB_8Lg2JzMvAVA7ZQrsAZeQegHaJDt1NaofR0A@mail.gmail.com>
Subject: Re: Increasing NFSD_MAX_OPS_PER_COMPOUND to 96
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, ms-nfs41-client-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 13, 2024 at 2:32=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
> On Sat, 2024-01-13 at 01:19 +0100, Dan Shelton wrote:
> > We've been experiencing significant nfsd performance problems with a
> > customer who has a deeply nested filesystem hierarchy, lots of
> > subdirs, some of them 60-80 dirs deep (!!), which leads to an
> > exponentially slowdown with nfsd accesses.
> >
> > Some of the issues have been addressed by implementing a better
> > directory walker via multiple dir fds and openat() (instead of just
> > cwd+open()), but the nfsd side still was a pretty dramatic issue,
> > until we bumped #define NFSD_MAX_OPS_PER_COMPOUND in
> > linux-6.7/fs/nfsd/nfsd.h from 50 to 96. After that the nfsd side
> > behaved MUCH more performant.
>
> I guess your clients are trying to do a long pathwalk in a single
> COMPOUND?

Is there a problem with that (assuming NFSv4.1 session limits are honored) =
?

> Is this the windows client?

No, the ms-nfs41-client (see
https://github.com/kofemann/ms-nfs41-client) uses a limit of |16|, but
it is on our ToDo list to bump that to |128| (but honoring the limit
set by the NFSv4.1 server during session negotiation) since it now
supports very long paths ([1]) and this issue is a known performance
bottleneck.

[1]=3DWindows 10 build 1607 allows longer paths than the infamous
|MAXPATH|, see https://learn.microsoft.com/en-us/windows/win32/fileio/maxim=
um-file-path-limitation?tabs=3Dregistry

> At first glance, I don't see any real downside to increasing that value.
> Maybe we can bump it to 100 or so? What would probably be best is to
> propose a patch so we can discuss the change formally.

AFAIK the Solaris 11's and Illumos's (see
https://github.com/racktopsystems/illumos-gate/commit/27e4199512d9d7b1e5409=
904f13cd96d8a05ee6e)
limit is AFAIK |NFS4_COMPOUND_LIMIT| (=3D|2048|), both capped by the
limits negotiated at NFSv4.1 session creation, if I recall it
correctly...

----

Bye,
Roland
--=20
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /=3D=3D\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)

