Return-Path: <linux-nfs+bounces-2046-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEB585EFA8
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Feb 2024 04:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7767C287067
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Feb 2024 03:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42C21946F;
	Thu, 22 Feb 2024 03:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="tI4er3YQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFFE179A8
	for <linux-nfs@vger.kernel.org>; Thu, 22 Feb 2024 03:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708571171; cv=none; b=RGGEukqAwNDdGozqXenQX7wEBbbBo0CTojdj+dyW7shqKMnS/iSGHGEeZgGkVOROaS3Ys2MVwgsGA8cskyY9gWe9ZIfAiEMrr/J1OkKjhmVN19/qXqYZA8XMXTIBRMZ0zMejS5mbi36MsOspet5ZjlNELKoLxpKZlS3mkXbSi5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708571171; c=relaxed/simple;
	bh=HEszjr9riqrF8sIkIpSH4NuJEBM42ahASmQDnRDEUcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWsrA6GcNCPrNzDWwKz4y9jzoY1K9A4S3p3M37TTCTNpUJdO+AHn+boPvB4243fd/koGZJoPmYcMhb36ZU0i6KmISY4/59KD1di3mpRPYSOHAX13ag69JUMxdeHfTx0LRcKWiVIxwg5OgmenWj+7yot8N7CZ4UrQCr0HR1vlVo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=tI4er3YQ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512b42b6697so5077520e87.1
        for <linux-nfs@vger.kernel.org>; Wed, 21 Feb 2024 19:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1708571168; x=1709175968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GL2/sftRMsFbU6bQC3gRHQ7BmHWi2vLJ5w2sAuGFyA=;
        b=tI4er3YQz2sSdpElO6NDHOez0LSsiB6aPssKxhpboqvaX4iXRQpo3JZmpxgpITJKcX
         akk54uB28ovOQUtKYVgfmb3Oc9AGBXbGGlmAl9sikutP53Zo7/FQdCDjEKZucd2mQqeo
         1p7dfzPW11/eN4x6gjqXMeCjv/0SJ+zSD7D8cwEmHJjf7smFJdvNCV81iR65KqEqlzqQ
         znV2kZmu+hHtkB7GPeBMtVKh1ZO2/b9D8c16vTsEQLUyzg2TnkVOC1y524BAlMLhwfhk
         TTVAmtrJbXvsuO1vc+GPvT1seSJAMWwpZEsA/KHod+e+TOhsJlqD/o7TazWbWwzhyMTv
         aNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708571168; x=1709175968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GL2/sftRMsFbU6bQC3gRHQ7BmHWi2vLJ5w2sAuGFyA=;
        b=MeOcWb5xzoXvm59irG2eV8kQT1JIXDLVSCSJfH0ZHmZVVeQm1610yIgtCV8c+XnhC0
         aJTLsq63Y83KmjQVEibpWxQc5EBrNIv7kqWQrKvuE46itedDQ8L/v1oPTKlvqf4UaX2B
         JLj82/mtjFy6hPk7X1ThByQNiVB+RQaVCK1zxNDl1K+7GiZWilgTpPLu9twED/sF2Bnt
         4X80Fk14Gfh9kSxdLQSPpwGl5zme0O8NMdBT3VfXh+QOxIjiBxHB+7wuLZIyt46K+q43
         bEBzliX6HtTbw7Zb3+4Q5GCk2ZM4LSfbZxcHrZR8cqReqiLAf3i7tU8/XmWAl1qHgxiq
         LsJA==
X-Forwarded-Encrypted: i=1; AJvYcCVDuEpXUj+p0aqJH4ZZEBlwnu4x6C94AqW5fYG0v4y47oWSkZr3mAqCWMtY5LsbincuJLBpnJb7hmMkBpsswpJobxFWsE7gQO2w
X-Gm-Message-State: AOJu0YxJH6ROOW9gN/VgqTvYYPU9RxpviAmXoagc4vS6r7DwJt4d+3fl
	xNgwgFE7cS8XpE4mLkmmijBa60E7favis4GSJUCsCEqie8wcXyDwIrUTw5E8tO1xdF5mvWw6HWc
	QVBbRFEqTBxPRAz8kgzpR28gSLaHSrzNz1edRuw==
X-Google-Smtp-Source: AGHT+IHz0DfQ7WdFHoTKTh9/wLbZNCERaKaIUmP7DD8KvxAVOcVA9iSxnJxQBzg99vO8r8oNniJubxT+p4NBkkZFDZg=
X-Received: by 2002:a05:6512:ba1:b0:512:bda4:bf47 with SMTP id
 b33-20020a0565120ba100b00512bda4bf47mr7020110lfv.4.1708571166733; Wed, 21 Feb
 2024 19:06:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPKjjnrYvzH8hEk9boaBt-fETX3VD2cjjN-Z6iNgwZpHqYUjWw@mail.gmail.com>
 <77a58302766cb6c8fac45682ede63569df80cd5d.camel@hammerspace.com>
In-Reply-To: <77a58302766cb6c8fac45682ede63569df80cd5d.camel@hammerspace.com>
From: Zhitao Li <zhitao.li@smartx.com>
Date: Thu, 22 Feb 2024 11:05:53 +0800
Message-ID: <CAPKjjnpvO_VUwgxEKu1JP8xNnt0hct6koTtOSxZ0bN1D_55JGg@mail.gmail.com>
Subject: Re: PROBLEM: NFS client IO fails with ERESTARTSYS when another mount
 point with the same export is unmounted with force [NFS] [SUNRPC]
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "chuck.lever@oracle.com" <chuck.lever@oracle.com>, "tom@talpey.com" <tom@talpey.com>, 
	"anna@kernel.org" <anna@kernel.org>, "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, "neilb@suse.de" <neilb@suse.de>, 
	"kolga@netapp.com" <kolga@netapp.com>, "huangping@smartx.com" <huangping@smartx.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Forced unmount is used in a casual way to some degree by our team. We
will adjust the usage of forced unmount and multiple mount points for
the same export.

As you said, all of the above is well known. Actually, this phenomenon
is unexpected for us. Could you give some more information?  Are they
issues? And if they are issues, is there any plan to fix them?

Best regards,
Zhitao Li, in SmartX.

On Wed, Feb 21, 2024 at 9:48=E2=80=AFPM Trond Myklebust <trondmy@hammerspac=
e.com> wrote:
>
> On Wed, 2024-02-21 at 16:20 +0800, Zhitao Li wrote:
> > [You don't often get email from zhitao.li@smartx.com. Learn why this
> > is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Hi, everyone,
> >
> > - Facts:
> > I have a remote NFS export and I mount the same export on two
> > different directories in my OS with the same options. There is an
> > inflight IO under one mounted directory. And then I unmount another
> > mounted directory with force. The inflight IO ends up with "Unknown
> > error 512", which is ERESTARTSYS.
> >
>
> All of the above is well known. That's because forced umount affects
> the entire filesystem. Why are you using it here in the first place? It
> is not intended for casual use.
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

