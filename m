Return-Path: <linux-nfs+bounces-14319-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDD5B54688
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 11:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10AC5610BF
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 09:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF4627602A;
	Fri, 12 Sep 2025 09:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aploMs7w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B512DC79E
	for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668344; cv=none; b=bEirELRPdqE77D81lbUONJO3bwzzkyMbguZOIv7KRjvbvjZXh1irXM9q85H2OslZzc4KAdwhju0Sw9qCbZCL0Tx3ApRSwq+g7p2aHag1Le9g01oUIFX4czL5MlICFtdSfykIAA54fy03o59tCPfUu212edYkcFbuLGlwBRdS+Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668344; c=relaxed/simple;
	bh=ioIOH2p5Blrv6vNOqNmSCymoSvN1zmkkAsnVeBc1SMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FO3PUiGAIFdfPzxEx3TyIpJVDAP9BjgDwnav4G7Uu5qQxzKK+Fa07gZHJ67hbAb7Y89T2VzhYy4OMeRtmLGDqPxYQKPTCtU25FupqjC9xJOSs9GUosydG04pf0Q3JfPXIA7p7WBq8nOGwm2SajaXrIswHvJAf2r3C1C5UC5PqQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aploMs7w; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b0785be64f5so460913466b.1
        for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 02:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757668341; x=1758273141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioIOH2p5Blrv6vNOqNmSCymoSvN1zmkkAsnVeBc1SMY=;
        b=aploMs7whY/LgaXCAuOUQbkHlH9PozV3z9HFoHHh4tp/dJFhM6pt21fAvHgYgjlN8M
         rmpVcHSueNagemUBdQowpA6BdoN7gqqaLplS1v3ScHX+yKhTwev5VBs4Bed/9bkH4dLN
         4rfLLpcIvHJONxgYVXSLM7qEor3rn+MmXCTKDCzXypEm5HHBP38sGD0OFUOjAm326bQ+
         1r2w7gh4g7621FkXF6rJzjHEIMZg4g13DDPyWgPK4mWuR3T6PMXO71Jvdha7GKG/r6lh
         avbJhFNvPx4G+gPZm0XJKYAQwKp/BQENGe5DK6uHxVZst/QOlcM6CwamdS6qIfXycNC8
         TKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757668341; x=1758273141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioIOH2p5Blrv6vNOqNmSCymoSvN1zmkkAsnVeBc1SMY=;
        b=LDPEfHyc7B8/w8jvDlfeykZ9kd0mDMQcqu1ToiDN+J1zkMZyzbPRkWN+AMuDo4iNS1
         62QAtRaXj0DtJmHJ/RoO8YVVnzpbT39UL1UIgWaO/6FFTCD1bw+//FKgdaI2oIXqkXP7
         kHIoqOkBBzSFW84PbQCo1pg3X/KMUe9U+NzNjkBoTnEH1HIXXWFObUj2Pu7+JWDf29Su
         zXsVf7Hb5ikln+xUP7bz40oNJWRijFgbgM6WZox2V4MVRraOtN6v3rW0DwK0cLQz5bZJ
         RWcqy9+YXdIyg464l+2EXdymiIrW0tM8a0P9IWMEihGb3Ilo8ih2ObaHQznuk07pxpvU
         Ho4w==
X-Forwarded-Encrypted: i=1; AJvYcCXi7Pf3ASPlTBTPdY1C53U102g1u9lc2vqo8632doKK+R8vmro+eXjLwN/bpckNCEWgyPvSjdX1nCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YywXweYdVumqOz47n5kCJEH7m0UDpyT3q8XpAlyQMTDo1FeEk2J
	NsQVprWO42ihH8RqRaddzI40MjLx+cqggPSVOQ34PPFQ8RxxVm3flyj6ZHwaUcBQ7jrDQOoQlS6
	hoKaWVLM2yeHqSWXmbdT/5PyJUdcwJks=
X-Gm-Gg: ASbGncsV6t7MGCj3+lYT8nABH652BC11D9ZsH6c9ulh7YvyIudlDX+/r4wtQ+JyL0Rl
	fcVfhBtFRNkYnVXCey03Et1gQcIWWBF2rre63SwbakPh9m0JfwfYnMGMj2pafVroN6ZekUk45WE
	NJFyGtv5ajd8nLHREMoookbpZdlhs5h88rZzQl2zodVjR7sU5YUOq2nwIVWVCDsrDRn2bZtJnMb
	V8rCcw=
X-Google-Smtp-Source: AGHT+IECQ2FSxCpELdyt8w8+Ta17OX81olY1L21qGnLXRiiNiAsbzwmD/JJZPTQJsBBXBb5BWfCf5Q2bF6gDjvOJbJk=
X-Received: by 2002:a17:907:3e9f:b0:b04:3402:391c with SMTP id
 a640c23a62f3a-b07a68bddd8mr590036766b.24.1757668340932; Fri, 12 Sep 2025
 02:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-27-4dd56e7359d8@kernel.org> <CAOQ4uxgtQQa-jzsnTBxgUTPzgtCiAaH8X6ffMqd+1Y5Jjy0dmQ@mail.gmail.com>
 <20250911-werken-raubzug-64735473739c@brauner> <CAOQ4uxgMgzOjz4E-4kJFJAz3Dpd=Q6vXoGrhz9F0=mb=4XKZqA@mail.gmail.com>
 <20250912-wirsing-karibus-7f6a98621dd1@brauner>
In-Reply-To: <20250912-wirsing-karibus-7f6a98621dd1@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 12 Sep 2025 11:12:09 +0200
X-Gm-Features: Ac12FXzXlVrWyNxThzcVLm8bWdnJouio3PTW50wsmgaWY6Ne9FaEF2yc3iNy4og
Message-ID: <CAOQ4uxgGpdQ42d-QRuHbvdrvZWrS9qz9=A2GRa2Bq-sMcK6w4w@mail.gmail.com>
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

On Fri, Sep 12, 2025 at 10:20=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Thu, Sep 11, 2025 at 01:36:28PM +0200, Amir Goldstein wrote:
> > On Thu, Sep 11, 2025 at 11:31=E2=80=AFAM Christian Brauner <brauner@ker=
nel.org> wrote:
> > >
> > > On Wed, Sep 10, 2025 at 07:21:22PM +0200, Amir Goldstein wrote:
> > > > On Wed, Sep 10, 2025 at 4:39=E2=80=AFPM Christian Brauner <brauner@=
kernel.org> wrote:
> > > > >
> > > > > A while ago we added support for file handles to pidfs so pidfds =
can be
> > > > > encoded and decoded as file handles. Userspace has adopted this q=
uickly
> > > > > and it's proven very useful.
> > > >
> > > > > Pidfd file handles are exhaustive meaning
> > > > > they don't require a handle on another pidfd to pass to
> > > > > open_by_handle_at() so it can derive the filesystem to decode in.
> > > > >
> > > > > Implement the exhaustive file handles for namespaces as well.
> > > >
> > > > I think you decide to split the "exhaustive" part to another patch,
> > > > so better drop this paragraph?
> > >
> > > Yes, good point. I've dont that.
> > >
> > > > I am missing an explanation about the permissions for
> > > > opening these file handles.
> > > >
> > > > My understanding of the code is that the opener needs to meet one o=
f
> > > > the conditions:
> > > > 1. user has CAP_SYS_ADMIN in the userns owning the opened namespace
> > > > 2. current task is in the opened namespace
> > >
> > > Yes.
> > >
> > > >
> > > > But I do not fully understand the rationale behind the 2nd conditio=
n,
> > > > that is, when is it useful?
> > >
> > > A caller is always able to open a file descriptor to it's own set of
> > > namespaces. File handles will behave the same way.
> > >
> >
> > I understand why it's safe, and I do not object to it at all,
> > I just feel that I do not fully understand the use case of how ns file =
handles
> > are expected to be used.
> > A process can always open /proc/self/ns/mnt
> > What's the use case where a process may need to open its own ns by hand=
le?
> >
> > I will explain. For CAP_SYS_ADMIN I can see why keeping handles that
> > do not keep an elevated refcount of ns object could be useful in the sa=
me
> > way that an NFS client keeps file handles without keeping the file obje=
ct alive.
> >
> > But if you do not have CAP_SYS_ADMIN and can only open your own ns
> > by handle, what is the application that could make use of this?
> > and what's the benefit of such application keeping a file handle instea=
d of
> > ns fd?
>
> A process is not always able to open /proc/self/ns/. That requires
> procfs to be mounted and for /proc/self/ or /proc/self/ns/ to not be
> overmounted. However, they can derive a namespace fd from their own
> pidfd. And that also always works if it's their own namespace.
>
> There's no need to introduce unnecessary behavioral differences between
> /proc/self/ns/, pidfd-derived namespace fs, and file-handle-derived
> namespace fds. That's just going to be confusing.
>
> The other thing is that there are legitimate use-case for encoding your
> own namespace. For example, you might store file handles to your set of
> namespaces in a file on-disk so you can verify when you get rexeced that
> they're still valid and so on. This is akin to the pidfd use-case.
>
> Or just plainly for namespace comparison reasons where you keep a file
> handle to your own namespaces and can then easily check against others.

OK. As I said no objections I was just curious about this use case.

FWIW, comparing current ns to a stored file handle does not really require
permission to open_by_handle_at(). name_to_handle_at() the current ns
and binary compare to the stored file handle should be a viable option.

This was exactly the reason for introducing AT_HANDLE_FID, so that fanotify
unprivileged watcher with no permission to open_by_handle_at() could compar=
e
an fid reported in an event with another fid they obtained earlier with
name_to_handle_at() and kept in a map.

Thanks for the explanation!
Amir.

