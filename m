Return-Path: <linux-nfs+bounces-14281-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F8FB530D7
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 13:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693121BC59EA
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 11:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1751A31DD92;
	Thu, 11 Sep 2025 11:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbgcjOFd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFA031C59F
	for <linux-nfs@vger.kernel.org>; Thu, 11 Sep 2025 11:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757590605; cv=none; b=YLBpzLaJHDcy7SUXwsGba2oScr3c1aNz5Zipi3GD8GVBnvh6lNEuLNEiJYEVWynWY7uldh9SfTOiUibVpgFl37hjjl+vU6QF/qP3BS3hDb0Y9sVCnySoercksCaE3yqZRFfEULjV9qJkOSmCn+aHQxeuOHoBsOAF3dhSUZG71HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757590605; c=relaxed/simple;
	bh=l3WS5mh3b7m+0CGnd7HwPGEX6fOXJSXSic0gzbaETOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jC1QXjYO3YI0ocoN41PCc7GPOMnrPhmFaXpnH6pu7phL8ow8J2ZZ6am5cWNSaWhb+wLdFDWoZl4T5z2NrThcQeiBtd86AFWUflvOEzP+mE8WjVTZ6NzW9iAuhDb8ensTDDpPArliLD4tZjexks6sM3ivx2l725iVYv5Tg14ItlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbgcjOFd; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-624fdf51b44so759703a12.1
        for <linux-nfs@vger.kernel.org>; Thu, 11 Sep 2025 04:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757590601; x=1758195401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3WS5mh3b7m+0CGnd7HwPGEX6fOXJSXSic0gzbaETOY=;
        b=QbgcjOFdQCEX77z/FdlRwnzEmGsALvq3U9SOMI0CS5/Coz9cwTG3pr8H10coBpZ0ZT
         ALfxzqhBFvmTlunvaBg5eojquIU2M0Jaj6+Hd0e8iXqgKuOZqpt4Pv6GARREjVuH73n6
         hdS/4L12c0LlPui/1Ra+uKktXYpezhtgeFeBAindj/qegG++n014aPkSXSpYqw+JJt2x
         5d9AacMrKkjsMmKaZ0myeESD6BMVT92frcJGeyabQR1LDI54v2GGB/cQhRWnOlA2P3pb
         1nosawlRTBFeGlzHK360D6IZGmPAf3T+Q0SiPG4HX3udF0VqG3qAdTsBxdNsQnMuetky
         AnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757590601; x=1758195401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3WS5mh3b7m+0CGnd7HwPGEX6fOXJSXSic0gzbaETOY=;
        b=P2B2/jcxOZ6ki74q7cnKJcuTR14R/wfaRu+s5ZcXBQUxwvhEb6xtowdyqL49NqCVWB
         vzbHrSlTHrDtU8eN+fXifpescJ2wdu1zDiiughyPmBuaEdZZD2WcUoTqL9t9gusXAFoE
         ePV+YxTN2h9GbcWOvRs5ea0TUk0CvzEDEE8NaT1Ibfn3Ihzx2GxTv/zokBECTpjFefLS
         3Z2MHg16SCtY9LXHQMTWg+33jdaFEikXMHrx3DYMquqNRfOqLXxxsIpIZYkY7mDg/N9m
         2Ixh5whbXwC4mrxkuRAUmOhqS36O280FC7Ba9go2z7g+QV/ZjctsZUGrr7ZbdoASTGmB
         SoEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ48AgWD8AKC4gBw6dfnvuXDr+PR3f0NVsQX5n1Abznzf8clQwRszPJszUJDAcecWv31TukFR4OoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMUOUdreozert8aux7xWkz2sWKw51q+EU19t6eM1e7vjFJD5Va
	RmgIwgGcOoBZ4+I2AXKi5FIg4j+7YCjWS7s+MjiLFpkP0HA5eLh1+D6Y7aKY9nHtlhKi8YUviPy
	EHA4Q8ncyewFlTxrdafndt78naX/nLt8=
X-Gm-Gg: ASbGncufEAq/CyrpxUyRnw/Iw8M7buwyTg1276wBk7JPgWYZqEzNKgdrj1emq5YlWhf
	eJbxoS/EWpt2s5JO3uVrb9/MRurHKWENc6n31+DpbQMY0eXWolvInq5MHR/7RmFV62IryeB0PjQ
	edA/79QPzh2Y3rZUcNGWhKntx2QX3xTBJ7uK2HrHQZk7srkqeePlCPIxlmJ9IQ83ZAlOWArbshd
	UPDZfaaWNtzUOoj0g==
X-Google-Smtp-Source: AGHT+IFTNKY6jjRUaK+95vjWoIXWhr+sTjejTLV8OOCQsfjrobYVHw8JMmZi1nhLUH2mOW0HugLlXyiAfLiI1n/62Pg=
X-Received: by 2002:a05:6402:2685:b0:61d:dd9:20db with SMTP id
 4fb4d7f45d1cf-6237c048793mr16217741a12.31.1757590600743; Thu, 11 Sep 2025
 04:36:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-27-4dd56e7359d8@kernel.org> <CAOQ4uxgtQQa-jzsnTBxgUTPzgtCiAaH8X6ffMqd+1Y5Jjy0dmQ@mail.gmail.com>
 <20250911-werken-raubzug-64735473739c@brauner>
In-Reply-To: <20250911-werken-raubzug-64735473739c@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 11 Sep 2025 13:36:28 +0200
X-Gm-Features: Ac12FXxRFt9Ctd5Cl_pR-FdI4tarLWVQlbT7aCbaq2ftodBoMLqTaIDo5wMZnik
Message-ID: <CAOQ4uxgMgzOjz4E-4kJFJAz3Dpd=Q6vXoGrhz9F0=mb=4XKZqA@mail.gmail.com>
Subject: Re: [PATCH 27/32] nsfs: support file handles
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	Lennart Poettering <mzxreary@0pointer.de>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 11:31=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Wed, Sep 10, 2025 at 07:21:22PM +0200, Amir Goldstein wrote:
> > On Wed, Sep 10, 2025 at 4:39=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > A while ago we added support for file handles to pidfs so pidfds can =
be
> > > encoded and decoded as file handles. Userspace has adopted this quick=
ly
> > > and it's proven very useful.
> >
> > > Pidfd file handles are exhaustive meaning
> > > they don't require a handle on another pidfd to pass to
> > > open_by_handle_at() so it can derive the filesystem to decode in.
> > >
> > > Implement the exhaustive file handles for namespaces as well.
> >
> > I think you decide to split the "exhaustive" part to another patch,
> > so better drop this paragraph?
>
> Yes, good point. I've dont that.
>
> > I am missing an explanation about the permissions for
> > opening these file handles.
> >
> > My understanding of the code is that the opener needs to meet one of
> > the conditions:
> > 1. user has CAP_SYS_ADMIN in the userns owning the opened namespace
> > 2. current task is in the opened namespace
>
> Yes.
>
> >
> > But I do not fully understand the rationale behind the 2nd condition,
> > that is, when is it useful?
>
> A caller is always able to open a file descriptor to it's own set of
> namespaces. File handles will behave the same way.
>

I understand why it's safe, and I do not object to it at all,
I just feel that I do not fully understand the use case of how ns file hand=
les
are expected to be used.
A process can always open /proc/self/ns/mnt
What's the use case where a process may need to open its own ns by handle?

I will explain. For CAP_SYS_ADMIN I can see why keeping handles that
do not keep an elevated refcount of ns object could be useful in the same
way that an NFS client keeps file handles without keeping the file object a=
live.

But if you do not have CAP_SYS_ADMIN and can only open your own ns
by handle, what is the application that could make use of this?
and what's the benefit of such application keeping a file handle instead of
ns fd?

Sorry. I feel that I may be missing something in the big picture.

Thanks,
Amir.

