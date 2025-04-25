Return-Path: <linux-nfs+bounces-11281-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1097A9C7B6
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Apr 2025 13:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE573B094B
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Apr 2025 11:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1CD7E9;
	Fri, 25 Apr 2025 11:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqBArHn4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71931A8F8A
	for <linux-nfs@vger.kernel.org>; Fri, 25 Apr 2025 11:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745580904; cv=none; b=W5m/VXLU1nYb2EcVTN1eOShi40bMJqcCm1NlzS86TYIDqddp9yOrw+YJGD4rJ5zN1d13XSjZF0/zdKyoB5m9ICvFnG+lzRg5Fo8HN29vSQiwyYgWucIcWVCg8yiohjOOMx8yxzHj6vB3tIs/kKrnd5K/0ytfZvvAgiOqh9boyGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745580904; c=relaxed/simple;
	bh=Fwziz23al86klMSTNS8NCYDkke85c/AxN527h2yeshc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJOYJ5FUbgbp7vbtlkDXFqBxH/cw1D/2yD3srJ3nZXQvckmhIuqeN7Aj+3F2U4DNKZEi7UtNoAZZMwRACwZ1Gt2QzDJyZ1CF9GxKVXBBDp0rt5Sv1Zun+pnySZ6P2LGTeQqs1mRgil6grhdchx9tu5Iu8yXhFRiI0OL//ZhZPRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OqBArHn4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745580901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6tAIdmmTJk/iQ6F5Z1do66dnxSKaku6TN9cr331Al2s=;
	b=OqBArHn4rLkDMh3sDoRUwva9gNo7SpXrp+THH3HLOgm/J+HP7ZapzjYYO1O5eJjpGwsCGE
	rEIiiATK6jJ5HIjT/R+AZKwkj22qQQncmIPp6gzrncsm9eXj4a8W7Pq0w27wkk+5HBdEKu
	z6SNL+Avqby9mxuWNipjfQf6cupl/+Q=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-r11VEQiJNryBjJ62PTYSgQ-1; Fri, 25 Apr 2025 07:34:35 -0400
X-MC-Unique: r11VEQiJNryBjJ62PTYSgQ-1
X-Mimecast-MFC-AGG-ID: r11VEQiJNryBjJ62PTYSgQ_1745580874
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3032f4eca83so2098962a91.3
        for <linux-nfs@vger.kernel.org>; Fri, 25 Apr 2025 04:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745580874; x=1746185674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tAIdmmTJk/iQ6F5Z1do66dnxSKaku6TN9cr331Al2s=;
        b=JiXZKh7ps3d1W+UEac34Zwe+NtQx55n5RRh4/BYLinb5HWHwtPTAASYzBp5hurHKAp
         OE5chbybL8ZecwU2O99bDk4m8sAP6jbaUsMPcDOFchO1UXPczfk3Hv4ZssdI87kvMFvB
         B7vleGe99FB5ZekVVLRZdKf5aJ/kctAm8ZRPR1rGRHoxwIV8WTlmBdztTds+u8DntoaY
         XZUgA531ymZlbjHP4QZUwbn5Y0Fn7CBu8oL8c4ZmKdRjxTpbHOpZR3YKa0fuBXzkLJpv
         WVmS4OFyIZPbORv7wyZpgTthqz9juZeZiUoN/jgqGvVk/IwrnvY/oI3H6iwy5qFfyspT
         Shlw==
X-Forwarded-Encrypted: i=1; AJvYcCUion14OVwb/sI+HLw/xMX8bssdYjUmhl2C39EVVU2rGaJtU2vrZkpkZOhCmXAsIWmf6ju/swEzDK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSkGM7RKQfaQ0XU472teykctMEvKZB9rl9s848GJC98984miN6
	JS1UAE9ps5x4DeNKOXcKVNM7/AuEde9sc1XDkjDuvxGg6Vijkhg8TPW0L/3RcLwppDvSmso7TDu
	2J1UMWvNEZSqTqgZE6LcDh8cogLfoMZD8Iy9BbUUlfweVc8Vu0+noPA6jvqSmKOcM7QHg/xV5Dm
	SmlpM2ewDtmM+jcHE4ZXL75QVi8oUPP6a/
X-Gm-Gg: ASbGncsw6dziGnOBt5k4gaBB3CFDxdhEMt2PxqrBhr39eosTbUc12VELsjZZkd/MhOn
	lJfT7LhYDZ9WZWnk7LO4SOfkoi+FQDMJHA7dsouS0w91EbyzrvuEvrgwIaUfZULu3NpgeN/7yGH
	Nvj5ffiOU6tSt+CkxjhjJYtQRJew==
X-Received: by 2002:a17:902:fc87:b0:223:64bb:f657 with SMTP id d9443c01a7336-22dbf73ba01mr33702805ad.46.1745580874320;
        Fri, 25 Apr 2025 04:34:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDtRjmo2YbrMRAhqN25kqMB8l0TbqgI3Zi8XAI2eGYwE8e8qkfvb2sJw9/JgIaJJwtTWOFR103dnZGv1JnuVo=
X-Received: by 2002:a17:902:fc87:b0:223:64bb:f657 with SMTP id
 d9443c01a7336-22dbf73ba01mr33702585ad.46.1745580874024; Fri, 25 Apr 2025
 04:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNtqPBMGUL8kvYoW2VzdrmcY1cx1+NL+LmOs0oxjfG5csA@mail.gmail.com>
 <5ea1bdf0-677f-4187-a626-a08ccd2ae7e5@huawei.com> <CAFqZXNtN_yv-KPfyrnaezX6QturnSbKGqgiY7ZBJmCg533u-+A@mail.gmail.com>
 <CAHC9VhTMc0kJo3Fh-CPPMz9WghANRGB6NpZARgvN-srDJeeXFQ@mail.gmail.com>
 <CAFqZXNtZLPpspu4PcXsSU5Q7H07wgKGS6CmtOaQVXu9OujDiZQ@mail.gmail.com> <9cb6e931-799b-46d4-b773-9b6fb4fd13ec@oracle.com>
In-Reply-To: <9cb6e931-799b-46d4-b773-9b6fb4fd13ec@oracle.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Fri, 25 Apr 2025 13:34:22 +0200
X-Gm-Features: ATxdqUFsp-pz53G3HZaZG_x9MlyMD8aG6ozlup192uibwCSfa7PCzF2pOWCnjds
Message-ID: <CAFqZXNsMXhmZncF_u+vNqG_=ho-rns85maw5fYGux9zQG6J=dg@mail.gmail.com>
Subject: Re: NFS/SELinux regression caused by commit fc2a169c56de ("sunrpc:
 clean cache_detail immediately when flush is written frequently")
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Paul Moore <paul@paul-moore.com>, Li Lingfeng <lilingfeng3@huawei.com>, 
	SElinux list <selinux@vger.kernel.org>, linux-nfs <linux-nfs@vger.kernel.org>, 
	yangerkun <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 3:34=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 4/24/25 4:45 AM, Ondrej Mosnacek wrote:
> > On Thu, Apr 24, 2025 at 12:37=E2=80=AFAM Paul Moore <paul@paul-moore.co=
m> wrote:
> >>
> >> On Tue, Apr 15, 2025 at 5:22=E2=80=AFAM Ondrej Mosnacek <omosnace@redh=
at.com> wrote:
> >>> On Tue, Apr 15, 2025 at 10:06=E2=80=AFAM Li Lingfeng <lilingfeng3@hua=
wei.com> wrote:
> >>>>
> >>>> Hi,
> >>>> Thank you for reporting this issue and sharing the detailed reproduc=
er.
> >>>> Apologies for the gap in my knowledge regarding security_label.
> >>>> Would need some time to study its implementation in the security sub=
system.
> >>>>
> >>>> To begin validating the problem, I attempted to run the reproducer o=
n
> >>>> Fedora 26(with kernel -- master 8ffd015db85f). However, I didn't obs=
erve
> >>>> the reported mislabeling of the root directory.
> >>>
> >>> Hm... Fedora 26 is *very* outdated and not maintained any more - I'd
> >>> recommend using 41, which is the current latest stable release. Hard
> >>> to say if it affects the reproducibility of this bug, but it's always
> >>> possible that userspace is also somehow involved.
> >>>
> >>>>
> >>>> The modifications introduced by commit fc2a169c56de specifically aff=
ect
> >>>> scenarios where the /proc/net/rpc/xxx/flush interface is frequently
> >>>> invoked within a 1-second window. During the reproducer execution, I
> >>>> indeed observed repeated calls to this flush interface, though I'm
> >>>> currently uncertain about its precise impact on the security_label
> >>>> mechanism.
> >>>> [  124.108016][ T2754] call write_flush
> >>>> [  124.108878][ T2754] call write_flush
> >>>> [  124.147886][ T2757] call write_flush
> >>>> [  124.148604][ T2757] call write_flush
> >>>> [  124.149258][ T2757] call write_flush
> >>>> [  124.149911][ T2757] call write_flush
> >>>>
> >>>> Once I have a solid understanding of the security_label mechanism, I=
 will
> >>>> conduct a more thorough analysis.
> >>>
> >>> I'm not sure how the two affect each other either... It almost looks
> >>> like the last mount command somehow ends up mounting the "old" export
> >>> without security_label in some cases, even though the exportfs
> >>> commands that re-export the dir without security_label had completed
> >>> successfully by that time.
> >>>
> >>> Thank you for looking into it!
> >>
> >> I just wanted to check and see how things were progressing?  I haven't
> >> noticed any failures lately on my Fedora Rawhide + patches kernel
> >> builds, but I wasn't sure if the problem had been fixed or if I've
> >> just been really lucky :)
> >
> > I can still reproduce the bug on the latest Fedora Rawhide kernel
> > (6.15.0-0.rc3.20250422gita33b5a08cbbd.29.fc43.x86_64), which is based
> > on commit a33b5a08cbbdd7aadff95f40cbb45ab86841679e in Linus' tree.
> >
> > Can we perhaps have the commit reverted for now while the bug is being
> > investigated? The change doesn't look essential and should be easy to
> > reintroduce once the bug is addressed.
>
> I've queued up a patch to revert fc2a169c56de in the nfsd-fixes tree
> for v6.15-rc.

Thanks!

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


