Return-Path: <linux-nfs+bounces-10667-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3983A680D7
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 00:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A3A3A93A9
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Mar 2025 23:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49D82080CD;
	Tue, 18 Mar 2025 23:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y94aRK9/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13C020765F
	for <linux-nfs@vger.kernel.org>; Tue, 18 Mar 2025 23:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742341348; cv=none; b=ILlGvQdVbBR9xb8fdtz0xLKqPJi4jrqI3TYyu/qWvz+BM/449aMQLuxzJmh5dXABR3Bt1PQHi55pqYSExOEmHi21WK58dj1xSI+PPtGm1iqeNNH1T2dwEFveXC5PDFp152/yZtFWzawtwX08goapV5Vl+yRKLBVsKwwFjKuRvMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742341348; c=relaxed/simple;
	bh=RfbWfSDWuJkL92E4Xy0gyzmHWLTVS/PVthtLPo2mRyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHnoc7MCbsg+Bp0dAtoOl/f8z59k9mvwqazSH61Q1rNRvpyG2ApWROZ1tWEHm3jyFp2GI6TrvN6B8B8Ih6QV0k/7RVHCbvb3gDmDZ4pN2KjkU7rnOwzVjMKHGCDn9cPLd2cy9BkJZQ9CLVhMubX3TYEePE8+27+dqrql6/xOTww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y94aRK9/; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so8799350a12.0
        for <linux-nfs@vger.kernel.org>; Tue, 18 Mar 2025 16:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742341345; x=1742946145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfbWfSDWuJkL92E4Xy0gyzmHWLTVS/PVthtLPo2mRyI=;
        b=Y94aRK9/URduBFLDQ3h0mkFsFPkQJEzLYWERsvO8ezN0fmNuWd0r9kZC13WNos3EUC
         7RC4ovV4V1dczd7rKDHBqpvG/Bk/6qQpFzPPo7wQab5HWaQ78ZjG/FdAog6d8cnOTtrI
         HIVIuqjm49H8yi8k0rxviN9QLKOnLgbwclTOVh+8wykntKGt05PTpDedrGt+de29KUBW
         qqS6AACvj7Nf+b9SP3vuajug9FeOIBW0dY0GGa6C8E2QRHJ+6VXovpmLNApA6xnk8LOP
         9I/7S7wpdCESKKZ5QG2RMbnF4UgRw+h5PSfjehh7h6hRyFJ2yafVvHL0Yzb2+c/6wquW
         9nmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742341345; x=1742946145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfbWfSDWuJkL92E4Xy0gyzmHWLTVS/PVthtLPo2mRyI=;
        b=bRtz/77KFUfnBaUQlmBKFvINSVqlAIYRgdKmiWGDodf78huZXhQWj6VaKb5WSqPakI
         0G2T6dY8eRBE4POY8Buh05jxLfJob6tpLH8V4TbnNeAIjDQlyIkbFdg4T81Rpnvr0I4b
         3JzMs9upZfF2xNft+p4SBz41CFNCNHMBzCfAlpvsnVnCdIVmP264rpa9NAVU6s0R/xdM
         mC7Ro9nmfnOjEZJgSPNWSSdgCNS+lPGMIC8M5jV91qSS7wFgQefHU4RsKEMrHrUcNtTd
         aTQ/QGKIbVSWjfl/pXjK8EU88iQ1p622kc1MMqaV0dYRNlV4AlAuE2vz8YKN0cN6zlLb
         o+mg==
X-Forwarded-Encrypted: i=1; AJvYcCUXse7DOxWMD/068aY66YF6rMU/zLhZ9sDvqmdEo1EN+RPf/OCK+tDv2RxkiCYRQX/gHOf6x96k/VI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys3Pinj/obV/ueVUKJe5U+QT4CXK4tflGzD7z8eH6QM26Rbk79
	kh1PV1HubmV6pQN1DvlcAD36ddqMZPzBkSRnaWCgXFuptGAANQxmsu7i2KYSmicgA2Jun/IQYYM
	re9jTdXF1zXski5ylD5PwMjyPSg==
X-Gm-Gg: ASbGncso6Y7AAMHjnHvUVnObGpxHx/dip1EMmDnhSBiDgxi0bDwRveE73atBObTUPcf
	9oAxS1l4jyuttOSPDJKIDItmo7dVw6SGurj6/EMPi65TSvnQVaLKmhIyWowaovWKOv7tC1SxUi7
	nnOmACkPFI22hUZSBCD5+q3QXPmRJ2uBCywGm9lmk6us3QaW5Q3KCg6bx1V7Y=
X-Google-Smtp-Source: AGHT+IGjJWe6K+vp8TRpwlZCIE1igkPxBTGPeq7lNQ7oAvQz+UwKhCblMLRyY1UDOCy0qh1jjfAaorzrIjuM1+lWcmQ=
X-Received: by 2002:a05:6402:42c3:b0:5e7:8503:1a4b with SMTP id
 4fb4d7f45d1cf-5eb80d1870dmr552114a12.18.1742341344740; Tue, 18 Mar 2025
 16:42:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALWcw=EeJ7rePwqv48mf8Se0B5tLE+Qu56pkS-fo0-X0R3DQ=Q@mail.gmail.com>
 <0ea71027-c0cb-436a-8dc7-6f261f0d9e0e@oracle.com> <89535c4a-7080-41cc-a0a3-1f66daa9287a@oracle.com>
 <CAM5tNy7FdNRC6i62jqyMs=A=03omztTk3YdgS=P3qJVersSFbg@mail.gmail.com> <37045667-d093-4dcb-ae63-5a577273e96c@oracle.com>
In-Reply-To: <37045667-d093-4dcb-ae63-5a577273e96c@oracle.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 18 Mar 2025 16:42:10 -0700
X-Gm-Features: AQ5f1Jr6eD4XyKl3EutRAqlNTR3S2yXMwMQNG5AxkPSv7Jg56H-m_qrPZJe8KFM
Message-ID: <CAM5tNy6duANWDWiX=sdm3UjSy56LBC5JZLJmVSv5CHOvVwtc+g@mail.gmail.com>
Subject: Re: Supporting FALLOC_FL_WRITE_ZEROES in NFS4.2 with WRITE_SAME?
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>, 
	Anna Schumaker <anna.schumaker@oracle.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 2:15=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 3/18/25 5:03 PM, Rick Macklem wrote:
> > On Tue, Mar 18, 2025 at 9:01=E2=80=AFAM Chuck Lever <chuck.lever@oracle=
.com> wrote:
> >>
> >> On 3/18/25 11:09 AM, Anna Schumaker wrote:
> >>> Hi Takeshi,
> >>>
> >>> On 3/18/25 11:00 AM, Takeshi Nishimura wrote:
> >>>> Zhang Yi <yi.zhang@huawei.com> wrote in linux-fsdevel@vger.kernel.or=
g:
> >>>>> Add support for FALLOC_FL_WRITE_ZEROES. This first allocates blocks=
 as
> >>>>> unwritten, then issues a zero command outside of the running journa=
l
> >>>>> handle, and finally converts them to a written state.
> >>>>
> >>>> Picking up where the NFS4.2 WRITE_SAME discussion stalled:
> >>>> FALLOC_FL_WRITE_ZEROES is coming, and IMO the only way to implement
> >>>> that for NFS is via WRITE_SAME.
> >>>>
> >>>> How to proceed?
> >>>
> >>> I've been working on patches for implementing FALLOC_FL_ZERO_RANGE su=
pport
> >>> in the NFS client using WRITE_SAME. I've also been experimenting with=
 adding
> >>> an ioctl for the generic pattern writing part. I'm expecting to talk =
about
> >>> what I have for ioctl API at LSF next week, and I'll post an initial =
round
> >>> of patches shortly after.
> >>>
> >>> I do still need to think through any edge cases and write tests for
> >>> pynfs and fstests before anything can be merged.
> >>
> >> Takeshi, it would be immensely helpful to us if you could provide some
> >> detail about how exactly you intend to make use of WRITE_SAME so we ca=
n
> >> focus the development, review, and testing efforts.
> >>
> >> So far we don't have any specific use cases, but there is some
> >> skepticism (as voiced in the previous thread) about whether this
> >> facility will actually be useful.
> > Just fyi, there has been a similar discussion in FreeBSD land.
> > The main use case in FreeBSD land sounded like writing zeros for NVME,
> > if I followed it.
>
> We were informed that NVMe devices do not support write_same at all.
That is my understanding too. As I understand it, write_same is based on th=
e
SCSI command that is only supported by a fairly small number of high end
drives.

NVME does not have write_same, but some (I don't know how common
it is?) have an optional command called Wr_Zero which writes zeros to a blo=
ck.

Hopefully I've gotten the above about correct? rick

>
> But I'm more interested in why applications need to get the OS to write
> patterns. What kind of performance and scalability expectations are
> there? How big will the patterns be, how big will the target files be?
> What is the target improvement needed over an application repeatedly
> calling write(2) ?
>
> After staring at COPY offload for some time, I can imagine that there
> are some DoS footguns in here that NFS servers need to watch for. Can
> WRITE_SAME return "I wrote only 16MB, please call me again to do more"?
>
>
> > My impression is that the other pattern stuff isn't very useful, since =
only some
> > (a few?) SCSI devices know how to do it.
>
> Well that tells us that hardware offload is a ways off, unless
> someone has a specific device they want to support.
>
>
> > The problem I see is that WRITE_SAME isn't defined in a way where the
> > NFSv4 server can only implement zero'ng and fail the rest.
>
> Writing repeating patterns isn't difficult to fake for file systems
> or devices that don't have a native write_same facility. Trond suggested
> a way to do it in the previous thread.
>
>
> > As such. I am thinking that a new operation for NFSv4.2 that does writi=
ng
> > of zeros might be preferable to trying to (mis)use WROTE_SAME.
>
> I don't really understand the difference, from an application's point of
> view, between WRITE_SAME(zeroes) and DEALLOCATE. The storage behaves a
> little differently in these two cases, but what difference does it make
> to the app?
>
>
> > rick
> >
> >>
> >> For example, do you expect to have SCSI devices that accelerate
> >> WRITE_SAME? How will your applications use this? What kind (and size)
> >> of patterns do you expect to need?
> >>
> >>
> >> --
> >> Chuck Lever
> >>
>
>
> --
> Chuck Lever

