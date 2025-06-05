Return-Path: <linux-nfs+bounces-12124-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAFBACEBB3
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 10:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2073A836F
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 08:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E931FFC6D;
	Thu,  5 Jun 2025 08:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JX6R8iCA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8000134CB
	for <linux-nfs@vger.kernel.org>; Thu,  5 Jun 2025 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749111680; cv=none; b=k1Lcp9+AhWGWzYsrP647c47HNhTtPJlyXIEiPBmjQGOSuffaJvBKA1flTzY0DjquB8IMyn1Sb+O1mLRn6UwYgAgBSWKWUGHku0tgDqBsBCegP4TizyscqCts9ON0hvU495Pqy1WWIiatdTfie/DTsZrB7e1Jdy1iqP+toyRp8m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749111680; c=relaxed/simple;
	bh=u7rrTJb4LDH2zSzPHvxAKWb62vGbwDz8aqV1/BzVJvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=lK6NbjqbGR3YH8BSl0xi/RmSiFQZDgzs2790IKNJoFmVFgLR+xGS1a+5okoeLLe+GdbAvoPFDRU0h/yON6ZPgoxYmiE0YYYvUlI+Hgh8GQ9O8H2WjRPH8LbDZYN4St2VF5egMnHP9Rpl7sZ7x7B9+DIFVwFMgxfgg3gg90EyA1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JX6R8iCA; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b271f3ae786so489357a12.3
        for <linux-nfs@vger.kernel.org>; Thu, 05 Jun 2025 01:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749111676; x=1749716476; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yZzb7AizSACVgSkN7/8y+iyAFFwlVtkVVYTZP5uB+nk=;
        b=JX6R8iCAs5Uk+MWEtNddlvQM/yDx3K+2jNQR17cKeO296wb2EEEX4duKYszwhgO+Mi
         3t8mxS4TRLcafPOEJ4+Vq94MG7nxtfYPE7ZVN5Mz5ZfId/0ePSOHv24l/zCZA5d+GidQ
         ldM9cQno6khpJpxetl76yZel+7VluutRHICx7Xc8GCcG5ddn6GP/Nplp1mwpFAaviaeh
         IbrzlZ3TQg9c4rhBCjPRiPxSpmx55PTZPm0/TKutWbZbhqLJ8dxGLU8J+AEzsJDNStr1
         rTMEh5nS1TaPHau523ExXMJMtnWLcAox+10KVWm1ahrfTRM5RJlij7LlLPCnAtSRNX2N
         lDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749111676; x=1749716476;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZzb7AizSACVgSkN7/8y+iyAFFwlVtkVVYTZP5uB+nk=;
        b=Qe2aK91dq6aVgMpo1fkWZzGxYX95wGssnunKprdukVDqYVsQyzEUhFgT1AQja6Ukcx
         c/o1GtT2G95LqSUela1eqagTDvzP0lZz+9ZV2jvqcMq/TF6G68UfbBxFCwxZPfXXa0dn
         I9PvLJ5F0PUgv6BDu+l1Xjc1cjk1XZw3LdzfZ/f+3dvTQewj4PKu6HkoLaNNrQsGGDqn
         1h9RJw+nYHvps0rMzoWvBkPqJwhc1bzIR2xE/dSYCczCZVAl6YaSApnY7EjyV1uEuPrQ
         Lhcy59/+M0k8XUi2MmL0xCmL/oEzGqzdT4U+T6x6J6MmIsOi3y2pAqOvyLQSWHTPBHd8
         bfXA==
X-Gm-Message-State: AOJu0YzzAFdzlrzdyQevUzspEQqM97R+Q2bxjtKFAP6Br+/Zko6QTZh9
	MAKBqCB6dsRNIx1GVrfA4Fzpb+H7+A2hMGYG4CKnBrDECtBmd4NBODuB2Bh5fBHQMBaYKFfZyTk
	jUG79upBRaMYRXsZnDm0ubWDmuw6YHCZ6kg==
X-Gm-Gg: ASbGncsfX71y2MR/hd6J7igjJ01qPNpiaONoyRqo7kUFIoLt4JtLYzUPLH4qZjRrXw/
	XaKfupwNGsvdXPEcXmzknp++RLlZ2XF97VkflOrhEHVzekEHq0r654rzIMwJD3ZKzdrnme4pMZi
	bG3ZVpepeYIE2ggQzdzdVDW1fvxezMzmqB
X-Google-Smtp-Source: AGHT+IHTMbyTLsMrWXvo0oIaWcgpz1pHLTsGsseClXYBua36PvP4CzuouxlLGulVGg5635ztb7zHYwcilNMEEa+7WLU=
X-Received: by 2002:a17:90b:17c4:b0:311:c93b:3ca2 with SMTP id
 98e67ed59e1d1-31310fc4faamr7457527a91.6.1749111676395; Thu, 05 Jun 2025
 01:21:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513-master-v1-1-e845fe412715@kernel.org> <7bbb789d-b3ae-4258-bebf-40ed87587576@redhat.com>
 <16285c94bc3498fb7a612f62e718ae8a53c42c3c.camel@kernel.org>
In-Reply-To: <16285c94bc3498fb7a612f62e718ae8a53c42c3c.camel@kernel.org>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Thu, 5 Jun 2025 10:20:00 +0200
X-Gm-Features: AX0GCFuvmgywNMDYMTvkC5FG1YfiBLuJFw4c_TiACVj_JE3824uRqN0bXTtTWak
Message-ID: <CALXu0UcDcsUWKkSfuvE6E6GZ0qiR=-=QaQ5QFz+kgZ6oT2e0Mg@mail.gmail.com>
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all exports
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Jun 2025 at 21:17, Jeff Layton <jlayton@kernel.org> wrote:
>
> On Wed, 2025-06-04 at 14:26 -0400, Steve Dickson wrote:
> > Hello all,
> >
> > On 5/13/25 9:50 AM, Jeff Layton wrote:
> > > Back in the 80's someone thought it was a good idea to carve out a set
> > > of ports that only privileged users could use. When NFS was originally
> > > conceived, Sun made its server require that clients use low ports.
> > > Since Linux was following suit with Sun in those days, exportfs has
> > > always defaulted to requiring connections from low ports.
> > >
> > > These days, anyone can be root on their laptop, so limiting connections
> > > to low source ports is of little value.
> > >
> > > Make the default be "insecure" when creating exports.
> > >
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > > In discussion at the Bake-a-thon, we decided to just go for making
> > > "insecure" the default for all exports.
> > > ---
> > >   support/nfs/exports.c      | 7 +++++--
> > >   utils/exportfs/exports.man | 4 ++--
> > >   2 files changed, 7 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/support/nfs/exports.c b/support/nfs/exports.c
> > > index 21ec6486ba3d3945df0800972ba1dfd03bd65375..69f8ca8b5e2ed50b837ef287ca0685af3e70ed0b 100644
> > > --- a/support/nfs/exports.c
> > > +++ b/support/nfs/exports.c
> > > @@ -34,8 +34,11 @@
> > >   #include "reexport.h"
> > >   #include "nfsd_path.h"
> > >
> > > -#define EXPORT_DEFAULT_FLAGS       \
> > > -  (NFSEXP_READONLY|NFSEXP_ROOTSQUASH|NFSEXP_GATHERED_WRITES|NFSEXP_NOSUBTREECHECK)
> > > +#define EXPORT_DEFAULT_FLAGS       (NFSEXP_READONLY |      \
> > > +                            NFSEXP_ROOTSQUASH |    \
> > > +                            NFSEXP_GATHERED_WRITES |\
> > > +                            NFSEXP_NOSUBTREECHECK | \
> > > +                            NFSEXP_INSECURE_PORT)
> > >
> > >   struct flav_info flav_map[] = {
> > >     { "krb5",       RPC_AUTH_GSS_KRB5,      1},
> > > diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
> > > index 39dc30fb8290213990ca7a14b1b3971140b0d120..0b62bb3a82b0e74bc2a7eb84301c4ec97b14d003 100644
> > > --- a/utils/exportfs/exports.man
> > > +++ b/utils/exportfs/exports.man
> > > @@ -180,8 +180,8 @@ understands the following export options:
> > >   .TP
> > >   .IR secure
> > >   This option requires that requests not using gss originate on an
> > > -Internet port less than IPPORT_RESERVED (1024). This option is on by default.
> > > -To turn it off, specify
> > > +Internet port less than IPPORT_RESERVED (1024). This option is off by default
> > > +but can be explicitly disabled by specifying
> > >   .IR insecure .
> > >   (NOTE: older kernels (before upstream kernel version 4.17) enforced this
> > >   requirement on gss requests as well.)
> > >
> > > ---
> > > base-commit: 2cf015ea4312f37598efe9733fef3232ab67f784
> > > change-id: 20250513-master-89974087bb04
> > >
> > > Best regards,
> > My apologies but I got a bit lost in the fairly large thread
> > What as is consensus on this patch? Thumbs up or down.
> > Will there be a V2?
> >
> > I'm wondering what type documentation impact this would
> > have on all docs out there that say one has to be root
> > to do the mount.
> >
> > I guess I'm not against the patch but as Neil pointed
> > out making things insecure is a different direction
> > that the rest of the world is going.
> >
> > my two cents,
> >
> >
>
> Thumbs down for now. Neil argued for a more measured approach to
> changing this.

What about renaming the option to "resvport" / "noresvport"?

>
> I started work on a manpage patch for exports(5) but it's not quite
> ready yet. I also want to look at converting some manpages to asciidoc
> as we go, to make future updates easier.

Why asciidoc? I think every localisation staff in companies will NOT
be happy with that.
I'd suggest Docbook/XML, as it is more flexible and allows HTML
generation without going to the groff/asciidoc eye of the needle.

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

