Return-Path: <linux-nfs+bounces-1164-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22F482FC10
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jan 2024 23:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E493B26655
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jan 2024 22:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9539B5916C;
	Tue, 16 Jan 2024 20:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T09FIXkt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02C95915B
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jan 2024 20:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705436280; cv=none; b=JDBjFqwG6pbmB3EuIA3LY5ToFB7cDmzeuFTcE8u+QzI/O0wJVH8SlHBpxTSiiA4mLwqLhkQtU2zpTu52P+aoJUf0aT+kcLdjnLJ4d//IXeBkluBHlJpX98qubx0WwoJKU1S6Rg/STFt26Xi1m6Bs76plaFyw9gjRkSlKSz2QpIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705436280; c=relaxed/simple;
	bh=/TPSzbYQwbOP5G1pfY/Ydx/rB8asebdn/LzNTN+zEYg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:
	 Content-Type:Content-Transfer-Encoding; b=J2R2y3KO73joEkJMVPrpKJB3VqjZ4o1rig1pwrsxf0z9Y5dXVHFd8LhyiAzA+rJF7dY6Sp+Dt65RoSXoMtZ0DYqBWiGQD6eeiv2D72h+W1oELrZ3IJwI4bHMY1lp6DuPPtX6islb3wVvjBMGxw7WbdPeowAi72UC1ZZy3OXbY50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T09FIXkt; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e67e37661so14204868e87.0
        for <linux-nfs@vger.kernel.org>; Tue, 16 Jan 2024 12:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705436276; x=1706041076; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYlY3/YDOiOjUS/VVKTK1d0Nhpe8EuHayuCzlfCvThA=;
        b=T09FIXktUfElZXWQMm7IXDQpHMRfJy6CNfHaDk6Z7G+T4qGW0kLQllF+BFb/1BILp0
         B+x1glyVgEx8wa3MTeZ+VV2KlV1miXZMZHxKNv2JITU+4z5l6fl358TJk7QHgtkUJ50j
         QAZbJFLaNBSNwEF+H0cDqgowlGcA/u+px73pF4exHSeaqey/PUe7QJuM9wOH2Vao5gYU
         3pT8sGP2yiYe+2RSpwzD5xghSz75gtJQ9WeBu8PEYd4e/IpMR+WBzPE8FbXbrzPTznmc
         7ZNa5USKa1fbq/0aFESH3SD/l3jdCTxMCFlujG2iNC9KeTPDBVjBS066ACaDgm8vuLru
         Y9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705436276; x=1706041076;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYlY3/YDOiOjUS/VVKTK1d0Nhpe8EuHayuCzlfCvThA=;
        b=idlaYqrxxejIoTHJwXh/U7ktsaRZS49Hzyb77M0aVsqM+AVMT8KsDrjvFKmPB3OzIP
         QbjIHiO9fh9vIT033coPb860rhyaSR3tIxsXafmatmLuv+P/RgRGG/CPH+8ei60LNl0d
         sx2AS+S1lGesAYwPmBiFf+96tVn1XInLh+LVJrl2rA8MQ/gW8a5yC92EqTePRrpFOebq
         7FyKPfP/5l1t46PyX3RFoS1jGFKFPeRKTFnHYlJv8jQVdGphgD6DltrSssw9nRHbPZpW
         1JrLcXumqrDRpDhftRvbI8E+hSQlm79PsvD0enUS3BTtg98F9kV+iebFBQeWDvCnnjSU
         DgFA==
X-Gm-Message-State: AOJu0YxTJ7WjAqbVSkZx61PaNMJaDknT/jeW3fZ+/R2LUmjKIZznpSzf
	yUpf5soTWf4OfKZGd/k6czxsEPwkDfjrp/2Rwz29244YYtM=
X-Google-Smtp-Source: AGHT+IFX3HVVm7uN/qcDC15s44ufgD+XKt9DDiKj/E2kZKSpNe3m0YJ1Bu0sznw1hYJQGbyae4QlWlZoIuxVHSzRYCc=
X-Received: by 2002:a05:6512:1599:b0:50e:62b1:f68d with SMTP id
 bp25-20020a056512159900b0050e62b1f68dmr4697342lfb.78.1705436276325; Tue, 16
 Jan 2024 12:17:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115063605.2064-1-chenhx.fnst@fujitsu.com>
 <CAAvCNcDxZF-ftqb1dRnjUW-q-1m2kyqN-MAGNXUd+i1r_b_vSQ@mail.gmail.com> <0CDB9C6D-5BC7-4E99-8B08-825424D0DD4F@oracle.com>
In-Reply-To: <0CDB9C6D-5BC7-4E99-8B08-825424D0DD4F@oracle.com>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Tue, 16 Jan 2024 21:17:29 +0100
Message-ID: <CAAvCNcCZ=uGxUN=9ztF6iOPsxdYUDYc2JeRrZxC4XPYOPW22uw@mail.gmail.com>
Subject: Re: [PATCH] nfsv4: Add support for the birth time attribute
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jan 2024 at 02:43, Chuck Lever III <chuck.lever@oracle.com> wrot=
e:
>
>
>
> > On Jan 15, 2024, at 8:02=E2=80=AFPM, Dan Shelton <dan.f.shelton@gmail.c=
om> wrote:
> >
> > On Mon, 15 Jan 2024 at 07:37, Chen Hanxiao <chenhx.fnst@fujitsu.com> wr=
ote:
> >>
> >> This patch enable nfs to report btime in nfs_getattr.
> >> If underlying filesystem supports "btime" timestamp,
> >> statx will report btime for STATX_BTIME.
> >>
> >> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> >> ---
> >> v1:
> >>    Don't revalidate btime attribute
> >>
> >> RFC v2:
> >>    properly set cache validity
> >>
> >> fs/nfs/inode.c          | 23 ++++++++++++++++++++---
> >> fs/nfs/nfs4proc.c       |  3 +++
> >> fs/nfs/nfs4xdr.c        | 23 +++++++++++++++++++++++
> >> include/linux/nfs_fs.h  |  2 ++
> >> include/linux/nfs_xdr.h |  5 ++++-
> >> 5 files changed, 52 insertions(+), 4 deletions(-)#
> >
> > Hello
> >
> > Where is the patch which adds support for btime to nfsd?
>
> Support for the birth time attribute was added to NFSD two years
> ago by commit e377a3e698fb ("nfsd: Add support for the birth
> time attribute").

Which Linux versions (trunk, LTS, RT) have that commit?

Dan
--=20
Dan Shelton - Cluster Specialist Win/Lin/Bsd

