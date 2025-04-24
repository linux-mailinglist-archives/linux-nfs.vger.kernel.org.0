Return-Path: <linux-nfs+bounces-11266-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E95EA9A6B9
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Apr 2025 10:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C28B1B613FA
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Apr 2025 08:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480671FA178;
	Thu, 24 Apr 2025 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duno0Ocu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663E820102B
	for <linux-nfs@vger.kernel.org>; Thu, 24 Apr 2025 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745484333; cv=none; b=gSSynF5FTE6+c6ZBqGaK4XRq0U4fQw77Ez9sZjqDGltu8E+mWLxMC//IG88GopZKkBChPP8k8f3ehoMz+p34XgwQYANMI2mJLKjKFG0iq7DEF1P9s0dx0vIRAzvVIGt2iVCXaALzOC6EP+vorSGuMJloZDHI/eUW/8R7Hc+J1hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745484333; c=relaxed/simple;
	bh=1D0gcFhcTz+R+c/oZaToJTc0uXK9wegse24TORZ7X68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sT5HVc+TZGZTPNN2sS/s3OZlChvfYHAr0+rFcuo/3qUNlYx0/A4VoaSEI0rYaL9fr2U+m0EfOeH1u9i9Q7p5CLM5CSlF/QvgE01in7JaNGpudsCACWaydo8juLhBAWyjL8TT46HqXFV1kkYWmKSGtk1h6J1D9Mv2ANRCzmmV6B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=duno0Ocu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745484328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GmfudU2+DoK0pIJ/x9YJl9MQHciDQNIRSDIICWzbVIc=;
	b=duno0OcuacALmRCti20RnbM+dKOjPF48+ZZXFBqUlcw6Ia/MJwmcxGtI6LWpjIeIjLAZ3T
	+YJr1onTe655y3Jfr/0epK/Cy3m9HNconiAD3EuqT8yJtQRdmSPh2kCZTLsJGF56qseVV/
	7W0O7mlrOaJM1NTX2TUOY2xnAbkVZ30=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-2G6kZ2EbO6ef5VUpV43HAg-1; Thu, 24 Apr 2025 04:45:27 -0400
X-MC-Unique: 2G6kZ2EbO6ef5VUpV43HAg-1
X-Mimecast-MFC-AGG-ID: 2G6kZ2EbO6ef5VUpV43HAg_1745484326
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-30364fc706fso686710a91.3
        for <linux-nfs@vger.kernel.org>; Thu, 24 Apr 2025 01:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745484325; x=1746089125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmfudU2+DoK0pIJ/x9YJl9MQHciDQNIRSDIICWzbVIc=;
        b=vXhyKcnggdue80zxowrYiXj6L8Y2rxK0yth08b/vFe1+368ZeJViiHEiCTUg0tyS0G
         xEMdUP86WlFM1lzKEEzIVNkwFHqJxrO/JPMvcOXAoGR69ljIt5NlGzzF02haiqQ+DijR
         WY5LOwWZG1a4Lp7TzPG+R4Ntp0IMeYYPBTdW02LV9sU7Dm4dqKwIhd5AHlrOwT9FbhOl
         QzWGQmi46kIhuTk2o67HN2WngiztYVQSUg2d70JlwCRs2PlWJUHMGY3fUg7A8tAVcxzj
         /fT0ElTpo+9Gljl6Lc8Jf8cCE7YTwy0lfpT8j1GxNulz/vvgl7AUSTMLf/ouFG01cdJE
         3SHw==
X-Forwarded-Encrypted: i=1; AJvYcCX/1CKZQjffWWAG+TXzQZQQbuLvozO7tCF2R9ch5wBCevDwmZ0KLQTv8L04zDGyIn/WPnPVD+695xc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxzd5LRM2+S6zY9NW1fcD6Myaov3bp8L7k0TkiZ6HKZuuWZlnP
	DjcCAk9ogfkniymeczArZqws+8tuxRCiDuioRAkzbNd5nA8Ec51IG2c3PGm9kOJGeI8N1KoqQrT
	qQ7tz7HQWXQYYQ0JsBGX4UA9ytE99hl0y/nSRnGwkEfvPgiUVhDynvPf2gU9srlhkDGiGz4QLBn
	JIjUviQARfXSMlbEvOqdvS3uU316AIGKZKFkh3Siczois=
X-Gm-Gg: ASbGncu4yfU6vdSS64s/4nVmxuXr7TghwRiqtHg9JvGcdsqZTkPqsTdl69N6W752HGw
	J7hYPXeb+HMIcH/TxtC91zQY/MzvMoSW5WYFTTFb5IHebIW1/Zrr7AnrtYVpAE6NRkvI=
X-Received: by 2002:a17:90b:514c:b0:305:5f25:fcf8 with SMTP id 98e67ed59e1d1-309ed26d0c0mr2811310a91.5.1745484325262;
        Thu, 24 Apr 2025 01:45:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8qE1a9YJALnhvfCAjhCgX+1Cj02zt8jg/X3plOzAsRT1XwxMk+z6/FcBXilIihEZGe8znydPvPXUU9O669HQ=
X-Received: by 2002:a17:90b:514c:b0:305:5f25:fcf8 with SMTP id
 98e67ed59e1d1-309ed26d0c0mr2811289a91.5.1745484324925; Thu, 24 Apr 2025
 01:45:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNtqPBMGUL8kvYoW2VzdrmcY1cx1+NL+LmOs0oxjfG5csA@mail.gmail.com>
 <5ea1bdf0-677f-4187-a626-a08ccd2ae7e5@huawei.com> <CAFqZXNtN_yv-KPfyrnaezX6QturnSbKGqgiY7ZBJmCg533u-+A@mail.gmail.com>
 <CAHC9VhTMc0kJo3Fh-CPPMz9WghANRGB6NpZARgvN-srDJeeXFQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTMc0kJo3Fh-CPPMz9WghANRGB6NpZARgvN-srDJeeXFQ@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 24 Apr 2025 10:45:13 +0200
X-Gm-Features: ATxdqUErmJ4l_wmskHtKDmVt3MK7rQGChN1VwoIXtcxZt1m219alXaKpdrJekYs
Message-ID: <CAFqZXNtZLPpspu4PcXsSU5Q7H07wgKGS6CmtOaQVXu9OujDiZQ@mail.gmail.com>
Subject: Re: NFS/SELinux regression caused by commit fc2a169c56de ("sunrpc:
 clean cache_detail immediately when flush is written frequently")
To: Paul Moore <paul@paul-moore.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>, SElinux list <selinux@vger.kernel.org>, 
	linux-nfs <linux-nfs@vger.kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	yangerkun <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 12:37=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Tue, Apr 15, 2025 at 5:22=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> > On Tue, Apr 15, 2025 at 10:06=E2=80=AFAM Li Lingfeng <lilingfeng3@huawe=
i.com> wrote:
> > >
> > > Hi,
> > > Thank you for reporting this issue and sharing the detailed reproduce=
r.
> > > Apologies for the gap in my knowledge regarding security_label.
> > > Would need some time to study its implementation in the security subs=
ystem.
> > >
> > > To begin validating the problem, I attempted to run the reproducer on
> > > Fedora 26(with kernel -- master 8ffd015db85f). However, I didn't obse=
rve
> > > the reported mislabeling of the root directory.
> >
> > Hm... Fedora 26 is *very* outdated and not maintained any more - I'd
> > recommend using 41, which is the current latest stable release. Hard
> > to say if it affects the reproducibility of this bug, but it's always
> > possible that userspace is also somehow involved.
> >
> > >
> > > The modifications introduced by commit fc2a169c56de specifically affe=
ct
> > > scenarios where the /proc/net/rpc/xxx/flush interface is frequently
> > > invoked within a 1-second window. During the reproducer execution, I
> > > indeed observed repeated calls to this flush interface, though I'm
> > > currently uncertain about its precise impact on the security_label
> > > mechanism.
> > > [  124.108016][ T2754] call write_flush
> > > [  124.108878][ T2754] call write_flush
> > > [  124.147886][ T2757] call write_flush
> > > [  124.148604][ T2757] call write_flush
> > > [  124.149258][ T2757] call write_flush
> > > [  124.149911][ T2757] call write_flush
> > >
> > > Once I have a solid understanding of the security_label mechanism, I =
will
> > > conduct a more thorough analysis.
> >
> > I'm not sure how the two affect each other either... It almost looks
> > like the last mount command somehow ends up mounting the "old" export
> > without security_label in some cases, even though the exportfs
> > commands that re-export the dir without security_label had completed
> > successfully by that time.
> >
> > Thank you for looking into it!
>
> I just wanted to check and see how things were progressing?  I haven't
> noticed any failures lately on my Fedora Rawhide + patches kernel
> builds, but I wasn't sure if the problem had been fixed or if I've
> just been really lucky :)

I can still reproduce the bug on the latest Fedora Rawhide kernel
(6.15.0-0.rc3.20250422gita33b5a08cbbd.29.fc43.x86_64), which is based
on commit a33b5a08cbbdd7aadff95f40cbb45ab86841679e in Linus' tree.

Can we perhaps have the commit reverted for now while the bug is being
investigated? The change doesn't look essential and should be easy to
reintroduce once the bug is addressed.

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


