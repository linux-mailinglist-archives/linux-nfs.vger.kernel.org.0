Return-Path: <linux-nfs+bounces-11261-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F39A99B96
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Apr 2025 00:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE9E448487
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 22:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BFC201264;
	Wed, 23 Apr 2025 22:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WYCim+GQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190C51FECBD
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 22:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745447841; cv=none; b=RcLCwMm7owUBFvslTQ88py+2zIdsTy1+lF4aUZV7CH26PjS/dT9tYn41nV2Cl1MO6CSeREZ4W0svkTjQXC7ao9+Ftj4vzNGhztJKxEhToMMcOJRBTbTHC9o56glQVv5uu88YXBic1jS442WLw/oyTfFl2CQz2NuoPwqRCk4YcCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745447841; c=relaxed/simple;
	bh=avtUqeBmY5B3skqwdkmCu6mdcQHoN1VWs8TnxC010nI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aH/3OE4Jki8EOpP9KkfK7b2jmrsoQZHFIBdMlTCi1AyZIsfYlHQ0ufyVzJVVKf4E187UcimH7vLN0IH6J6JfO07cEQU20TAwEC3k0yMn4jmy8pw4g8FneFnev1Ds1w2c31EXP/zTOY/+aFE9NYYKgzBcaakYO7m9FFNWnQhfMQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WYCim+GQ; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e72a786b1b8so415173276.1
        for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 15:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745447839; x=1746052639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uQGDRvOs7kS2meHW1UGgn4K/w+HgRMl9V4mIgw6iMA=;
        b=WYCim+GQ48VqwDYCxIBcd+Zmnu2w+Yn8KE2YgmHpvQJBLY9f3rsBZImk6RPGIDKxs9
         xhjC5j7kG9FVj8REHQ1oADuD7HFF0jw/QwZ7Ahz8jlhBE8IlUd9xrx7eUYbTqngDfgAI
         XEP5RWPHid6FU/UoptvIUP+Nac2RUW0VsEdb3O+DigNgYYC3KvZoQ8BPplr/oMoSrI3W
         kpDdXBx6E+1ZO9Cxnuw+8gLNhfTZTVZl99Keog59ZPrhPYDv1g8lt/EPCqo9LOHf90yF
         iQCBbzp6lxvKoYy0dkhokYypXosC/FYBRzkmXRWVlB8GX3vRqUE4BTAxQeEd2j/eBlUM
         TzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745447839; x=1746052639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uQGDRvOs7kS2meHW1UGgn4K/w+HgRMl9V4mIgw6iMA=;
        b=sXKHDTpwof9h68ZW+64LCnq3iV8TXYQ0LUDIGK/KKvRk9oovNdJGoYJ9x6cq2JN4SZ
         5GdtWbgwCokYYIQ4E4LkKa9GU7kRjKO19pBuWsA8b54c33/CmRGoiaZmV7H9rEzCG64e
         5roMxJuUZ1gmU481rqIqd1PFCSWOiN9rA4nsS5laJcYSOeRNDik/yMgREy1FlzYLHz0y
         fGNc2CBiWNxbbk+NyyksVxUoYEg4OPLOYCL3npqPWfPSOH6xZgQi6lrIAwiaHKv7PwVs
         s0Yl2mlMZVlTX/vIeCvPBmuxjnlSdkBNq1wpnPzF+r3keZcWhQnIC7LnncU1Xzn1rOb/
         qO/w==
X-Forwarded-Encrypted: i=1; AJvYcCXZ0AYPSa0W6bOCvcw1qU6NzUUvY+zgoOW6LGVuCXY10ZVv7rCN0UjT+UJ9L0yQQIU+FX6AkPA9j/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymbiiy6V924PY6yDtXtIi7WUuh+Ed6eX5lchrb1pK08PhhNc8b
	vOH9nlBeW8ZsgQr4KiIeM7196JgwvUNcpH63YsG1eHszbYndQ/x+GbSwhgG0iDgjXxvfaqbBstX
	RaOGeilU+3GbckNvVQ0bSRGl92HvvrYhht1kP
X-Gm-Gg: ASbGnctm/U6rgjoLgc/OEEqEWcfTLwfJ4A9JXg6eyVFBcBEJe8pVWbBxt0TqyHuKxWL
	j7t2BzbiARNTXBXcoIDA/vrzNDQWmXyBM0ZkXoOh0bvcJl71O5BCI7OvfTTqt5d0qaMpoLIZ88X
	Or1aBpIz7H5buKhtr1ej3V7w==
X-Google-Smtp-Source: AGHT+IEYPphP/GjGtUQdGVsgnpITGNVwg9SNmBgcEQxsTr53pRzJWzJ7q2ivYR6poOsXyj9RWdYjfkIpYuRFjJCdf/0=
X-Received: by 2002:a05:6902:1a45:b0:e60:9cf6:ad89 with SMTP id
 3f1490d57ef6-e73052240famr124195276.20.1745447839018; Wed, 23 Apr 2025
 15:37:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNtqPBMGUL8kvYoW2VzdrmcY1cx1+NL+LmOs0oxjfG5csA@mail.gmail.com>
 <5ea1bdf0-677f-4187-a626-a08ccd2ae7e5@huawei.com> <CAFqZXNtN_yv-KPfyrnaezX6QturnSbKGqgiY7ZBJmCg533u-+A@mail.gmail.com>
In-Reply-To: <CAFqZXNtN_yv-KPfyrnaezX6QturnSbKGqgiY7ZBJmCg533u-+A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 23 Apr 2025 18:37:08 -0400
X-Gm-Features: ATxdqUGKbiLeWnXDTEO_j0C8Cq43E25eLHb3LpReaRyeWUtSGVz5buJp9FHUbSw
Message-ID: <CAHC9VhTMc0kJo3Fh-CPPMz9WghANRGB6NpZARgvN-srDJeeXFQ@mail.gmail.com>
Subject: Re: NFS/SELinux regression caused by commit fc2a169c56de ("sunrpc:
 clean cache_detail immediately when flush is written frequently")
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>, SElinux list <selinux@vger.kernel.org>, 
	linux-nfs <linux-nfs@vger.kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	yangerkun <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 5:22=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
> On Tue, Apr 15, 2025 at 10:06=E2=80=AFAM Li Lingfeng <lilingfeng3@huawei.=
com> wrote:
> >
> > Hi,
> > Thank you for reporting this issue and sharing the detailed reproducer.
> > Apologies for the gap in my knowledge regarding security_label.
> > Would need some time to study its implementation in the security subsys=
tem.
> >
> > To begin validating the problem, I attempted to run the reproducer on
> > Fedora 26(with kernel -- master 8ffd015db85f). However, I didn't observ=
e
> > the reported mislabeling of the root directory.
>
> Hm... Fedora 26 is *very* outdated and not maintained any more - I'd
> recommend using 41, which is the current latest stable release. Hard
> to say if it affects the reproducibility of this bug, but it's always
> possible that userspace is also somehow involved.
>
> >
> > The modifications introduced by commit fc2a169c56de specifically affect
> > scenarios where the /proc/net/rpc/xxx/flush interface is frequently
> > invoked within a 1-second window. During the reproducer execution, I
> > indeed observed repeated calls to this flush interface, though I'm
> > currently uncertain about its precise impact on the security_label
> > mechanism.
> > [  124.108016][ T2754] call write_flush
> > [  124.108878][ T2754] call write_flush
> > [  124.147886][ T2757] call write_flush
> > [  124.148604][ T2757] call write_flush
> > [  124.149258][ T2757] call write_flush
> > [  124.149911][ T2757] call write_flush
> >
> > Once I have a solid understanding of the security_label mechanism, I wi=
ll
> > conduct a more thorough analysis.
>
> I'm not sure how the two affect each other either... It almost looks
> like the last mount command somehow ends up mounting the "old" export
> without security_label in some cases, even though the exportfs
> commands that re-export the dir without security_label had completed
> successfully by that time.
>
> Thank you for looking into it!

I just wanted to check and see how things were progressing?  I haven't
noticed any failures lately on my Fedora Rawhide + patches kernel
builds, but I wasn't sure if the problem had been fixed or if I've
just been really lucky :)

--=20
paul-moore.com

