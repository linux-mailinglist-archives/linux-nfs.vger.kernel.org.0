Return-Path: <linux-nfs+bounces-684-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63AC816831
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 09:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1CB1F22B35
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 08:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E551078B;
	Mon, 18 Dec 2023 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQ73+Hsx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03168107B0
	for <linux-nfs@vger.kernel.org>; Mon, 18 Dec 2023 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1f060e059a3so2429929fac.1
        for <linux-nfs@vger.kernel.org>; Mon, 18 Dec 2023 00:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702888638; x=1703493438; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eszLuNjms6tr4O+Nl3mn+J0D5b9pCOuMSNU3grI+Y0I=;
        b=RQ73+HsxoYzQZAsyb9wj2IFQdU52tpTjKUdX0pEJQs7aAKQ5yPPv9R4JDpJ3NEpjVP
         H0m/QBD7QUgTSp2CAg1E4e5ynusi21PbCyP5gAG5ecjgbMCl618Wnjk9HqGCeu9DBUxR
         Un31Zc8zsUJEFXT7NOJf5h+3oHi4A4PBhS+Cah65q3iGtH9gnE3gtH9D6k5I38E8UMdE
         0h9iNKJt/CH0ZdU7Pd8jKCT0jY3vxbhndYonVMkg/shpYecacPV0HsG51ruX5QpijBvF
         eZcnRT7TlqSZYcGrlnaQzK01RAWzR+CTFmk+XbvsH/mKJw5Lb6ArC3O6H2urJko/sQD7
         MTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702888638; x=1703493438;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eszLuNjms6tr4O+Nl3mn+J0D5b9pCOuMSNU3grI+Y0I=;
        b=olOeKh4Mz+31OrgZsAZWobq03PYj25kgx+/kw0/vWvW96VGI56ndVQLgEUV58+qE6z
         zvpC7Q2f4YF0lwVp3X11rf5rYLrRa47FWwisQybcxZzB/neDM2DtH8J+LxJBRvQvsN3k
         7sqD1pj2eZ/pttS9/N4oCzszoKmjwq4Iuja6qvjXqJFFRCWcxyxuEDHx1AQRO+RFKxt9
         mg41XAEaeWBZjgHoN5KX041GYQXW1m5Y5SJQMHwqe7l1wnLJg97Pbe6bS0kfj1BBLZfc
         pctZAmpKLkXyI0+m7BgNVX9f39e+Aizj/ZzlvJYsTQwX+gs3tppywE8koYd7i1QF60mq
         n/qw==
X-Gm-Message-State: AOJu0YxZtxTO3zY7fvllDHECyHMrH/sDqDUMEFlOnmCwVnmjmJNmZDdm
	15mJ+y4JaoYuCGiJ764i+vF5KUXR3DbqSDWDU6j5Svlx
X-Google-Smtp-Source: AGHT+IHanBYsO3TCuAf7OEOv/QBNmpS2R8dUYXWO4jEpxHWNrk6WEgpbjKo9FMYuqBL9Xxysfd0Y+gJuo3kQv/ZdwR4=
X-Received: by 2002:a05:6870:e40c:b0:203:d998:2041 with SMTP id
 n12-20020a056870e40c00b00203d9982041mr183137oag.116.1702888637835; Mon, 18
 Dec 2023 00:37:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANH4o6OdF=hjLtZ1_jbqPjexuenYn6cSvxFrJ+BUUDQv86DRzA@mail.gmail.com>
 <CANH4o6Mu8kDvZTrssVc_Tr1CKkWaUFnZxzdjQNw7-2tmYTTOzw@mail.gmail.com> <7849E95F-603B-49B8-B251-73CAB4811E48@redhat.com>
In-Reply-To: <7849E95F-603B-49B8-B251-73CAB4811E48@redhat.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Mon, 18 Dec 2023 09:37:06 +0100
Message-ID: <CANH4o6NcrFz6EKDcfq1daaSpmOuCebYA-A3u3Bk_+kPtJWBLYA@mail.gmail.com>
Subject: Re: umount.nfs: /mnt: block devices not permitted on fs
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 1:26=E2=80=AFPM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> On 29 Nov 2023, at 22:45, Martin Wege wrote:
>
> > ?
> >
> > On Fri, Nov 24, 2023 at 9:57=E2=80=AFAM Martin Wege <martin.l.wege@gmai=
l.com> wrote:
> >>
> >> Hello,
> >>
> >> We get a umount.nfs: /mnt: block devices not permitted on fs in a snap
> >> container on Ubuntu.
> >>
> >> Can anyone explain what is going wrong?
>
> Something in umount is calling umount_error() with -EACCES.  I admit that
> error message makes no sense, it seems to be cruft.

Can this be fixed, please?

>
> Maybe you can run the umount in gdb with a breakpoint on umount_error() a=
nd
> send along the stack.

This is much more difficult than I expected - the target system is a
Ubuntu Core system, which uses SNAPs, and debugging there is a
disaster.

Does umount have an extended debug output?

Thanks,
Martin

