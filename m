Return-Path: <linux-nfs+bounces-10661-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9544A67E73
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Mar 2025 22:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E961B17B2F0
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Mar 2025 21:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18607E1;
	Tue, 18 Mar 2025 21:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCppHSGQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEB31DF744
	for <linux-nfs@vger.kernel.org>; Tue, 18 Mar 2025 21:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742331845; cv=none; b=nnlIjPLQIFUHJR92V+6sWZzKr873LY6ZLvdfDHQKkPGi1G8P3uTgxB1jKq8fUCbi/Z0ZdiCkdsRai0HJ2Qm/UraaQMg1CauGCwM33U4jgSa3z5u4kkLLWBRs5M2iw2yZzRUqCVouIqzqrS62QDf10GsazrzDUSW8pqHrv9eOk0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742331845; c=relaxed/simple;
	bh=EkW4sRm3zW/1thd9IfvoepqVTv0sdyKmOS789EDVxTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HxXj0uHrwZsb95QhdAffY+AKMBNVK/eJN0bPLrplSEc2/m+L9zpgHCJ1cs/XmV495Yl6Bj0x0twLlRJ62gox/PNXI77fJAFdtxolVGwofM9PkxMPniu+AUHpIwuQ07DSTHX0qp7T84+m7i3wvqIz/hGijotinOz/MBO02PsGg7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCppHSGQ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5b56fc863so8611561a12.3
        for <linux-nfs@vger.kernel.org>; Tue, 18 Mar 2025 14:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742331842; x=1742936642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkW4sRm3zW/1thd9IfvoepqVTv0sdyKmOS789EDVxTg=;
        b=lCppHSGQ72rjhRMt/hn9G16bRv157W1ohB5UBZVoadDdz+nHE1TP9PlsBOA943am19
         Uu0QJ3DlQAP6UlpFRivcvio4Ko7927eP+Wya8T7nedZvLXEnkea4npC2xNO1ikVC0ci3
         xqcc31ktfW831lBhFabrhSOyYOzYTkE+CB3ParC0flCo39N+OgEHtih4vpPXX1USp8BQ
         5D4cAI7gdf+zklS2RqtUkdB3ar/gJgpO8x6wp4DUsQL9zG5x1V1yYpVqJ0m5at21do17
         /GIcmRqgn47N6074FynXKMTUkQKvNz53Dq/I2kqzJ6pzzOOPrbF8IJ9j53bUHPs73z5C
         4uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742331842; x=1742936642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkW4sRm3zW/1thd9IfvoepqVTv0sdyKmOS789EDVxTg=;
        b=op8oXofiTHymVyTUIlPikIH1NtvoVivCbVSsmXPu9H9OUDcxDWb/W+YE+dq9CXQtU3
         qcIjqvSVUjE92U6b/y5bHYNYyeG5SRua8fNdAkrw6gTSISAADpkMPznZeUf4dwPl5/hK
         owR+/zoSFHkEMmdKQhtJlav1pbso7d54TSyM2yESRt4f1DqrH6aLWDb8ntlnWR+j/FHn
         oZCdqrOotlEWw4Pj/cS7hKh/of/ccT/PspNNbUHYQXYaIDqdWI+GXfXAwIPHFlHXEkcp
         y0yyjfGR49isu7LRrziBdxQt5oZ+j1BTauYb6EOgNspaOvC0HwrZnKLGajGm22+zkH9D
         +uYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI4enH1utCbKkajPtOw9wpBWCaDiz9aX7w12GXbBj6yDEYGCMDcFYFn/nUbWtNWQdMkb7WIe5R7Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZHDJlyYfF+JA5Oz7hbgM7n3v5/YuR9LrSHaLFdsc/dKKAfebA
	UHgIzseCCRCYm7k3wYytAoVmq7iedLyA7qoWcQysaihXyAvbfsAtjnf6EJC2htw5UXUSMyP68TR
	4i2t50VUin9ZwPJkBC48S+wIk5A==
X-Gm-Gg: ASbGncsiM+Uh3HGe02q/aYGvqu27c9oB0jtPHcNZsup/akdNq9tZ6KIM536VDDOHj23
	/oe/n16Ygsux2b639yBchvAlKFmYunWjjLB1dv3j9ZF0oazPyAFJkb+Ts/4Qa1pIAFn4//EUXEh
	0iVa/ZkAhlfV2O9IxM/mPF7Yime7k58bJdxmNSLpW0Ib2kWP3ah7PF13uU9qI=
X-Google-Smtp-Source: AGHT+IGqFpVJ+WDUAeSzUCgzZFCmpDYeL8Wnrj7JhLUFmfUfHyM74NGcKTLHHpljO6v+zSqlS0A68NjdAK2Dkal2ERs=
X-Received: by 2002:a05:6402:5211:b0:5e6:4ee9:f043 with SMTP id
 4fb4d7f45d1cf-5eb80f97a1amr130621a12.26.1742331841963; Tue, 18 Mar 2025
 14:04:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALWcw=EeJ7rePwqv48mf8Se0B5tLE+Qu56pkS-fo0-X0R3DQ=Q@mail.gmail.com>
 <0ea71027-c0cb-436a-8dc7-6f261f0d9e0e@oracle.com> <89535c4a-7080-41cc-a0a3-1f66daa9287a@oracle.com>
In-Reply-To: <89535c4a-7080-41cc-a0a3-1f66daa9287a@oracle.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 18 Mar 2025 14:03:47 -0700
X-Gm-Features: AQ5f1JrD0DMvDus0c4NBWIkIz2eaj37HAA9KOI_rZe0HT4l-sXL1DT8SCuuuMCQ
Message-ID: <CAM5tNy7FdNRC6i62jqyMs=A=03omztTk3YdgS=P3qJVersSFbg@mail.gmail.com>
Subject: Re: Supporting FALLOC_FL_WRITE_ZEROES in NFS4.2 with WRITE_SAME?
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>, 
	Anna Schumaker <anna.schumaker@oracle.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 9:01=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 3/18/25 11:09 AM, Anna Schumaker wrote:
> > Hi Takeshi,
> >
> > On 3/18/25 11:00 AM, Takeshi Nishimura wrote:
> >> Zhang Yi <yi.zhang@huawei.com> wrote in linux-fsdevel@vger.kernel.org:
> >>> Add support for FALLOC_FL_WRITE_ZEROES. This first allocates blocks a=
s
> >>> unwritten, then issues a zero command outside of the running journal
> >>> handle, and finally converts them to a written state.
> >>
> >> Picking up where the NFS4.2 WRITE_SAME discussion stalled:
> >> FALLOC_FL_WRITE_ZEROES is coming, and IMO the only way to implement
> >> that for NFS is via WRITE_SAME.
> >>
> >> How to proceed?
> >
> > I've been working on patches for implementing FALLOC_FL_ZERO_RANGE supp=
ort
> > in the NFS client using WRITE_SAME. I've also been experimenting with a=
dding
> > an ioctl for the generic pattern writing part. I'm expecting to talk ab=
out
> > what I have for ioctl API at LSF next week, and I'll post an initial ro=
und
> > of patches shortly after.
> >
> > I do still need to think through any edge cases and write tests for
> > pynfs and fstests before anything can be merged.
>
> Takeshi, it would be immensely helpful to us if you could provide some
> detail about how exactly you intend to make use of WRITE_SAME so we can
> focus the development, review, and testing efforts.
>
> So far we don't have any specific use cases, but there is some
> skepticism (as voiced in the previous thread) about whether this
> facility will actually be useful.
Just fyi, there has been a similar discussion in FreeBSD land.
The main use case in FreeBSD land sounded like writing zeros for NVME,
if I followed it.

My impression is that the other patten stuff isn't very useful, since only =
some
(a few?) SCSI devices know how to do it.

The problem I see is that WRITE_SAME isn't defined in a way where the
NFSv4 server can only implement zero'ng and fail the rest.
As such. I am thinking that a new operation for NFSv4.2 that does writing
of zeros might be preferable to trying to (mis)use WROTE_SAME.

rick

>
> For example, do you expect to have SCSI devices that accelerate
> WRITE_SAME? How will your applications use this? What kind (and size)
> of patterns do you expect to need?
>
>
> --
> Chuck Lever
>

