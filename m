Return-Path: <linux-nfs+bounces-13539-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5FDB1FA6E
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Aug 2025 16:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C3618948C6
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Aug 2025 14:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AB2185E4A;
	Sun, 10 Aug 2025 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/syACmr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F05F27462
	for <linux-nfs@vger.kernel.org>; Sun, 10 Aug 2025 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754836352; cv=none; b=kAaJdfKBM+zKijj/o838gFTqB0kYGWVWhlLd+Olh5TmG2Z+5gSBzMISHI8t/LZXJSYc4aNbCFo8L4mama6sU3xIWXH/LrAJyxFkcJwew+8wYWuFOA7w08GbQtKa9O6PbeCzf5TIsVz78TPvU+nz1M3d3PDEOt+ATUMab2tyEVLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754836352; c=relaxed/simple;
	bh=a590KERpwWHksZQWGEElTz/0scPdjiT/DUBza8W095o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mc890osklI3xwhVX3i3DyiDgq/IUlMhmE+NVwYzK7z5TdkoHJl+ItIah/yn0d6fr/v2ieYInX4YW7l90kY4mzTJ7agGCkdwQYyYkU//wCotcbYkolxC2lgCLMQehwLsmTsXsxwmhiKxE6/NzkvBMIcfd0U/weALjxcnYX6y6VvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/syACmr; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6157c81ff9eso5556667a12.3
        for <linux-nfs@vger.kernel.org>; Sun, 10 Aug 2025 07:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754836349; x=1755441149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGMcg9vwg8Ly31kHzOkC50du481ce8biWwiEskuTq24=;
        b=e/syACmrjXi0PyQt5puFWH8yFaTD2lBExiKzjn7s+b/WF8+NGp443qV6Uqme0A9+zf
         inRHmhbIfjbAFlzA/7cDZZmwqmN/VzjVVQra+CN5DqDgGFFqEISpKCZHr1BsvjchcIsV
         VaUp65SzxZjm5HAB51d7wUqr887gXiXZCC/qoDBOJjaRCWbqYEqXZA4pDq0YqzNr7udd
         ST+jv17HUu0ly1Fp66EZHq+fqfoBGLlkjNW5hkpLB3sbAPsDBcY/0X8P1uPWgAa0ZL/1
         sgZ0eVeUVXfP00V3llp5W0a+DLC8m/3VT0l4Qz9Rr4cKXb8wS5FRdan9DoFitZwc/hyN
         5bGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754836349; x=1755441149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGMcg9vwg8Ly31kHzOkC50du481ce8biWwiEskuTq24=;
        b=N9KwduacmjwAGp0DpXvafo7OvgEDM3D7erYREhkrm961FLpO9dAsLORyQew0ACSTlw
         dL4RDK21tklVK2uX8awTVK7h4D/Au01MrIhBTHXUJ7gPs3avacWLMk8QlmHDgZgrd+Tv
         gVlzr7Sc4cmCFlrysXsQuseW88mPVhY9hu2QV/00SlJ+9DLeqIwGc77+dnwdc4zItnCh
         jAU61C9Ajdx0RkMHizy6irpJ1uZFhrrEE2P1ZTfLbjLVNNvHTyHaeapIU9uGERb2Qdlo
         BfJXGbkCmq2DRjGKDDVdzrZs22yEYqg0l4EigRtWD8wOsEBC3x7uOnhRQWCB0WfuRtjV
         NGxg==
X-Forwarded-Encrypted: i=1; AJvYcCWFfXiBGnbF8rihHf949xCWVfuryxHSlr5yw5Sk2w7XmYGGdHHTkNHAk1LKLCYTKcoLagt7zgjxlzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWD0WkEKUANx6LB3trVy64dQgl6J5VO34+xCZ3lpZhv5NOHIkm
	I5WSPXLDst0rSACKaovMo4xDAYwhUi7iF+A63+YSnkbV94bPn0SBib6jPd4OSPqsOBXmGRRWz/b
	4zyiELPNZwQnVsW2yMRp5UuQfKCAi+nnN
X-Gm-Gg: ASbGncv+JKKaj+2DqHRpV/9ADeO33x39ffXFEsG9RpmduBIfUVxcSEtgBAWyn3jbMyh
	tlJqXXDV1dPoLs0En2MWRUbje4g6t3zevqoYg7ORT2u2IvvXsazUhUX7egKwHzmslCpXxA9vao0
	sG1CEV1BPrbZycZte9etGJ3yD7nzQ0dhedd1G8nQ6QhDZxxxmRnQyS129CVbRKKAevKQK4fh5UG
	0WrpzmeBM/mjdJVJONuYO/05w2lKzFtEKg9K8Q=
X-Google-Smtp-Source: AGHT+IE6Mmu6OaD8hOYi3i1mHOBkjChorFSX+sVDLN+N8/0QNSy9DbcSaSSfnFihjlEXiS4ztDgSCumxz6p0Dmse1wQ=
X-Received: by 2002:a17:907:3d42:b0:ae0:66e8:9ddb with SMTP id
 a640c23a62f3a-af9c63aa040mr967025266b.19.1754836349106; Sun, 10 Aug 2025
 07:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy4L1Smwc-H01AuKjNbtu9WMzWxJVRtuOjr0Fp_yLiZX7Q@mail.gmail.com>
 <CAABAsM5nzVzPDB3Ubeqg35F7Qd8pBveiYPi1M+KFnMPjb2dxXw@mail.gmail.com>
 <CAM5tNy7Aab8fQ58BghMBsWvs6Xc5U90q9gXWaKeEaZaqcs2Ltw@mail.gmail.com>
 <CADaq8jeAhdOLrD9Y6o1xJsMuGYZLoJdMAonfB5RuX63xV_i0UA@mail.gmail.com>
 <CAM5tNy4kPWfPHHRVr712AG=g5wJ+fThG9KFX_9JoT85seTSE=g@mail.gmail.com> <CADaq8jdfV0EjVehzGNFw2MxKZvc_Dj-t6Af0NqNKe3oZ66xDMQ@mail.gmail.com>
In-Reply-To: <CADaq8jdfV0EjVehzGNFw2MxKZvc_Dj-t6Af0NqNKe3oZ66xDMQ@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sun, 10 Aug 2025 07:32:16 -0700
X-Gm-Features: Ac12FXyogCovr_yeSIB4K0KFLCoFLN5QOzkphlhoKdrZZsJKGettf3ouHaLHymw
Message-ID: <CAM5tNy4jx3ML_XhWaAo=Ffde3ZzqR5mGd-kcVvpAtxXjesChJA@mail.gmail.com>
Subject: Re: [nfsv4] Is NFSv4.2's clone_blksize per-file or per-file-system?
To: David Noveck <davenoveck@gmail.com>
Cc: Trond Myklebust <trondmy@gmail.com>, NFSv4 <nfsv4@ietf.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 10, 2025 at 6:58=E2=80=AFAM David Noveck <davenoveck@gmail.com>=
 wrote:
>
>
>
> On Sat, Aug 9, 2025 at 5:02=E2=80=AFPM Rick Macklem <rick.macklem@gmail.c=
om> wrote:
>>
>> On Sat, Aug 9, 2025 at 1:12=E2=80=AFPM David Noveck <davenoveck@gmail.co=
m> wrote:
>> >
>> >
>> >
>> > On Friday, August 8, 2025, Rick Macklem <rick.macklem@gmail.com> wrote=
:
>> >>
>> >> On Fri, Aug 8, 2025 at 8:38=E2=80=AFPM Trond Myklebust <trondmy@gmail=
.com> wrote:
>> >> >
>> >> >
>> >> >
>> >> > On Fri, Aug 8, 2025 at 9:47=E2=80=AFPM Rick Macklem <rick.macklem@g=
mail.com> wrote:
>> >> >>
>> >> >> Hi,
>> >> >>
>> >> >> I'm looking at RFC7862 and I cannot find where it
>> >> >> states if the clone_blksize attribute is per-file or
>> >> >> per-file-system.
>> >> >>
>> >> >> If it is not in the RFC, which do others think it is?
>> >
>> >
>> >  Before you told us about ZFS,  I would have assumed per-fs.
>> >
>> > Given the uncertainty in the spec, you may wind up dealing clients tha=
t assume it is per-fs.
>> >
>> > Although this is not a  catastrophe, you might want to file an errata =
report explaining the negative consequences of assuming this is per-fs. It =
won't get into a spec for a long while but it does provide as much warning =
as you can right now .
>> >
>> >
>> >
>> >>
>> >> >> (Or maybe, if you have implemented CLONE,
>> >> >> which does your implementation assume?)
>> >> >>
>> >> >> In case you are wondering why I am asking,
>> >> >> it turns out that files in a ZFS volume can have
>> >> >> different block sizes. (It can be changed after the
>> >> >> file system is created.)
>> >
>> >
>> > The guy who allowed that probably thinks it's a helpful feature.  Sigh=
!
>> It's not just a feature change after creation, it turns out to be based
>> on file size as well.  A small file gets 512 and a larger one gets a ful=
l record
>> (128K on my test system).
>>
>> And, yes, block cloning requires alignment with 512bytes or 128Kbytes
>> depending on the file.
>>
>> I can return 128K for clone_blksize and that will (sub-optimally) handle
>> the 512byte case, but I think it is also possible to increase the record
>> size from 128K-> after the file system has files in it.
>>
>> I'll take a look at the Linux client to try and see if/how it uses
>> clone_blksize.  I need to decide if I should always return 128K
>> (or whatever the full recordsize is) or 512 for the small files.
>
>
> I don't see the point of returning anything but 128K given what you said =
above.
> If a file has to be smaller than 512 to merit the 512 block size, it coul=
d still be cloned with a 128k clone_block_size.  The spec makes an exceptio=
n for the last block of a file being shorter than the block size so returni=
ng a 512-byte clone_block_size.
I'll be experimenting with it soon.
What I do not know (you could write what I know about ZFS on a
postage stamp;-) is whether the blksize for a file changes as it
grows.
--> So the problem is a file might get 512 because it is small when
     first created and then grow large. Again, I do not currently know
     what determines the blksize. Whether it is the first write being less
     than a record size when created or maybe it does switch to recordsize
     (128K in my case) when it grows beyond 128K or ???
     - I do know that ZFS allocates new blocks whenever data is written
       to a file, even if the file is not growing. (Which is why it cannot
       support ALLOCATE at this time and probably never will.)

I'll be poking at it. For now, I just do not know, rick


>>
>>
>> Thanks for the comments, rick
>>
>> >
>> >> >>
>> >
>> >
>> >>
>> >> >> Thanks, rick
>> >> >>
>> >> >
>> >> > Yes, but since ZFS only supports filesystem level snapshots, and no=
t actual file cloning, does that matter to anything?
>> >> ZFS now has a feature it calls block cloning, which does clone file r=
anges.
>> >> (It was only added recently. I do not know if the Linux port uses it =
yet?)
>> >>
>> >> rick
>> >>
>> >> >
>> >> > Cheers
>> >> >   Trond
>> >>
>> >> _______________________________________________
>> >> nfsv4 mailing list -- nfsv4@ietf.org
>> >> To unsubscribe send an email to nfsv4-leave@ietf.org

