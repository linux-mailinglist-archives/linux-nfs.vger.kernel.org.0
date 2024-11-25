Return-Path: <linux-nfs+bounces-8213-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F18FF9D8B3D
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Nov 2024 18:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E87160EDD
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Nov 2024 17:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377E2192D6C;
	Mon, 25 Nov 2024 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DF3QIOfh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCD31B3954
	for <linux-nfs@vger.kernel.org>; Mon, 25 Nov 2024 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732555324; cv=none; b=uVviyWmP06saTBgrmH9/yPAjr615IQBX8Xr4J5tUQwu/MBYRNHoVvh5X3LyKaxFkHKO2MlC/7G5bEVGhVkGypmRzGeaQlymwpHD/BurctEXhmBkMEmM8ZdogX4pTmJ8LACY24tXoHzTDBGNzuK8cLsBYFgqNToobb6NlZh3ibcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732555324; c=relaxed/simple;
	bh=uhmwajgfLJy93FGbaCgPk8b9rd0DCS0mP5rJQeroXwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=m0f5eLgN6ZSaPjXAoKXPLNdLxEDPR/Wi8EE8m0eC1PUsbxdaU76OWbxcX1E6S3Owlk+Ad2MnBV40imC03a83ODwrsFWGNRPaaIB5zMSTLsL2pWqs7483Tzrp2n3z9Y4XkWGQawg5g3d3fCNvnjM2r8ZEQ31eToXJjBSW3vSaZpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DF3QIOfh; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ed91d2a245so2140705a91.3
        for <linux-nfs@vger.kernel.org>; Mon, 25 Nov 2024 09:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732555321; x=1733160121; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XHRsn40oEsp78FRQe6HItfLjbDOuKntV5p5pcwuhqw=;
        b=DF3QIOfhH09yDnS+7nAaivFqjO8iKM50teyhOuKIxKuIzPRmcEj78/LIfBNq/K6aE8
         qbDT1BbRbzqOV+Xd/jW6poPWKY34GqYGcJ90/lbQQof3dG+KayUPwkjXNmMJaMlsZa8i
         fa0OXZI1rqJ2h1oCgImP1jNY/N8wX5BQm35wjlpH8FeveZn9GyYJFaN8EzP9F+jU7Uy0
         JIxxo/66EB51mh98Lp4vGQFBm5UTfa7/LEnNAchmlwUWLEBrLqlTSJ3fe4DC9eVZt/aL
         UJNW6MkcyVfnWbP20hRPm8OLdvAXVwqfdpVe+DMmR/yJwpToZCBsl7S/MYU9hdODWlyp
         oWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732555321; x=1733160121;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XHRsn40oEsp78FRQe6HItfLjbDOuKntV5p5pcwuhqw=;
        b=B0rXAD3hbdSumN2FeEkWSUdjakgqC875xu5hRxSLyGj2tFfnD7UBZrvFr4O6w04o5z
         lNfYnO6cvPj2aIzfSKGrJI/26L3LoC3JMoMLla0HMZwzCEHcSl14AV76/kjNGgksRqiJ
         /j0xKlOm61+wOo6cYTnwhJolzYq+XBJbClFdYLZRagjcv7QfY/5TrVD3JKdOYjAjHNMg
         drYJserPUrP4a7uxyP9wJ69hiWA60/Sj6GSVeipQ/1JF6+m12Q4pFwi4lvuJ+u2UMWRS
         SLgCED/sXMFEBPGPq1KEIm+8qCIflYQvxEWcvGAhw8mY+10944F8F3ZHfqEIln0KyljK
         eL5w==
X-Gm-Message-State: AOJu0YyhLr9ifblFEIcFon9B+Hz8NzcFIsvTdS1m9OtHTdq/e+xNH6VC
	4WngPKmUQF7eySo44a9wKC0oa+Utka3JxSVeNFSm1FchzwiriJVdsJFoGH5FFgiIgBQvzjmU19p
	QeYMn5vl3rrqSFU4q0/yNJsPAAP6vFw==
X-Gm-Gg: ASbGnctr57YNFhVaP/PGK6lFVumdO4Hd7j0LNt4S8sH4YHI1+VznJrVBKUCxLF4wc2G
	3ZjeWU+5MZciavSWTcHQ9K0ppMF5DQi4=
X-Google-Smtp-Source: AGHT+IGjPmEMCiSS0UU3psQ/KaZphZw+J8XOmsQyZYT4DXJ6MMfv4F0sXYbv1QmCnFvZRZ2oR6u0uePMVtZvT8E3MrA=
X-Received: by 2002:a17:90b:17ce:b0:2ea:4633:1a62 with SMTP id
 98e67ed59e1d1-2eb0e867627mr15652953a91.25.1732555321436; Mon, 25 Nov 2024
 09:22:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN0SSYyAf51Vdeg9yVGD7isZfT+PcvbC8RcUGzgkH9MUB1QjgQ@mail.gmail.com>
 <CAN0SSYxVUiiupuu-8DPq1tMRrOBuO49bwaLik0KmoQ3r2pqnxg@mail.gmail.com>
In-Reply-To: <CAN0SSYxVUiiupuu-8DPq1tMRrOBuO49bwaLik0KmoQ3r2pqnxg@mail.gmail.com>
From: Mark Liam Brown <brownmarkliam@gmail.com>
Date: Mon, 25 Nov 2024 18:21:00 +0100
Message-ID: <CAN0SSYw-eDXnG=QMuaJTsx5KXbusZ8SO3ER5Udg=5_ipi4A7Pg@mail.gmail.com>
Subject: Re: IPV6 localhost (::1) in /etc/exports?
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 4:58=E2=80=AFPM Mark Liam Brown <brownmarkliam@gmai=
l.com> wrote:
>
> On Tue, Sep 3, 2024 at 1:16=E2=80=AFPM Mark Liam Brown <brownmarkliam@gma=
il.com> wrote:
> >
> > Greetings!
> >
> > How can I add IPV6 localhost to /etc/export, to access a nfs4 share
> > via ssh? I tried, but in wireshark I get this error:
> >     1 0.000000000          ::1 =E2=86=92 ::1          NFS 278 V4 Call l=
ookup
> > LOOKUP test14
> >    2 0.000076041          ::1 =E2=86=92 ::1          NFS 214 V4 Reply (=
Call In
> > 1) lookup PUTROOTFH | GETATTR Status: NFS4ERR_PERM
> >
> > for this entry in /etc/exports:
> > /test14 ::1/64(rw,async,insecure,no_subtree_check,no_root_squash)
> >
> > The same mount attempt works if I replace the entry in /etc/exports wit=
h this:
> > /test14 *(rw,async,insecure,no_subtree_check,no_root_squash)
>
> So far "::1/128", "::1/64", "::1" do not work, which makes me wonder
> if there is a BUG in nfsd which prevents the use of ::1 at all.
>
> Also, our IT department made it clear that the "total
> underdocumenation" of IPv6 in exports(5) is "literally worth a CVE",
> as many people use IPv6 masks which make exports world-wide
> accessible.

So is this a bug, or not?


Mark
--
IT Infrastructure Consultant
Windows, Linux

