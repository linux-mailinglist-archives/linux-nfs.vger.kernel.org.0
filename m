Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889F33256C8
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Feb 2021 20:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbhBYTd5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Feb 2021 14:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbhBYTbM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Feb 2021 14:31:12 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD7BC061574
        for <linux-nfs@vger.kernel.org>; Thu, 25 Feb 2021 11:30:31 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id d13so3332942edp.4
        for <linux-nfs@vger.kernel.org>; Thu, 25 Feb 2021 11:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kn5f8U6gSB42zuc8l2XTzx8r5LXOFJ5xpaqkPUZWChs=;
        b=vw6iwDGNm9M3VzhgkAG09uKHBa3lEvlsot54U4vao2XzrVWVmeYl4VFVF8gJQjiz7u
         wJ5cANwNPA+syuGoleryxwhWZmYeXrRIbT7wsljR0gRaMP/bZBBFWj7HwSTRcIufl5e8
         +2ycmUmin5q+8ei7RLLmEJQFiWUw2epjqdpbG9KZeI99UZH5YkycxoEf6PiL8sgKdQ+a
         Bk5dsbmtYgjXOsz/RtjtBLv5e2If18fCYS0KtANo7cSpe5egW5O3sykVXkYGYpW3yMSm
         fiunNNHP87T260v60adQOhwpYmOSoEIYVcS2lqwIZSvUEgUZ8aL88LvGzJ5sJ70sHA+H
         BdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kn5f8U6gSB42zuc8l2XTzx8r5LXOFJ5xpaqkPUZWChs=;
        b=YuwWaVY0c3KtFoEZfQl5F8+LFYbcv21IKEeJe+XuHlEWW7MqBeOwbBZ4NnZg1QJXs4
         swC27wchX6psE/+rLOHsSwrZc09WJq/OOYdSEeYKCdPoMrfm6WqhSDdmqDoyaAubOcjX
         UE/DZMKZHm2+/g5Q/EHQs+xPk3IoT1dW8T1lEUV8rRE3TAHWdQSTsMkTJTLqTD8Bzy8F
         1B1Fmk8+QZypHCLnE7yJQ81pUcQHwfxv1nC+kvv3l0c4t6J5oiSYGcSKWlu9QOxaHahK
         hrAPzZTPBZua1SxGOgc7evWpyWFz2Yr5okEASSpZ7sxsI/0BAsbIPE7SYbC8KmP7pgTe
         lwtg==
X-Gm-Message-State: AOAM531z5zqjoLGf1O3u99Pg8n+ncMD98Iev4Ju8WqcpfjGmTgQddKmz
        YXoidPfCmnuIoUd3st/1LkOtx8U6EosDn/lNBEyoSuEOu372
X-Google-Smtp-Source: ABdhPJwIyysgftrLtDHqbMxD4VspG5ZWJEq9O0sxPLPoY79EYzqPXYKymC4wAKJF/ks3ayGXmxIJA54Pp2Rx1F5ecoQ=
X-Received: by 2002:aa7:df0a:: with SMTP id c10mr4694506edy.12.1614281430111;
 Thu, 25 Feb 2021 11:30:30 -0800 (PST)
MIME-Version: 1.0
References: <20210219222233.20748-1-olga.kornievskaia@gmail.com>
 <CAHC9VhRKLBNNfUE0FMgGJBR5eBQ+Et=oK1rcErUU_i62AGhfsQ@mail.gmail.com> <CAN-5tyGuV-gs0KzVbKSj42ZMx553zy9wOfVb1SoHoE-WCoN1_w@mail.gmail.com>
In-Reply-To: <CAN-5tyGuV-gs0KzVbKSj42ZMx553zy9wOfVb1SoHoE-WCoN1_w@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 25 Feb 2021 14:30:18 -0500
Message-ID: <CAHC9VhR8hxnpYf7=5PzughBhvx=rvndoZEy9kwzdcHDienAVUA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] [security] Add new hook to compare new mount to an
 existing mount
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Feb 25, 2021 at 1:03 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
> On Thu, Feb 25, 2021 at 12:53 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Feb 19, 2021 at 5:25 PM Olga Kornievskaia
> > <olga.kornievskaia@gmail.com> wrote:
> > >
> > > From: Olga Kornievskaia <kolga@netapp.com>
> > >
> > > Add a new hook that takes an existing super block and a new mount
> > > with new options and determines if new options confict with an
> > > existing mount or not.
> > >
> > > A filesystem can use this new hook to determine if it can share
> > > the an existing superblock with a new superblock for the new mount.
> > >
> > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > ---
> > >  include/linux/lsm_hook_defs.h |  1 +
> > >  include/linux/lsm_hooks.h     |  6 ++++
> > >  include/linux/security.h      |  8 +++++
> > >  security/security.c           |  7 +++++
> > >  security/selinux/hooks.c      | 56 +++++++++++++++++++++++++++++++++++
> > >  5 files changed, 78 insertions(+)
> >
> > ...
> >
> > > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > > index a19adef1f088..d76aaecfdf0f 100644
> > > --- a/include/linux/lsm_hooks.h
> > > +++ b/include/linux/lsm_hooks.h
> > > @@ -142,6 +142,12 @@
> > >   *     @orig the original mount data copied from userspace.
> > >   *     @copy copied data which will be passed to the security module.
> > >   *     Returns 0 if the copy was successful.
> > > + * @sb_mnt_opts_compat:
> > > + *     Determine if the existing mount options are compatible with the new
> > > + *     mount options being used.
> >
> > Full disclosure: I'm a big fan of good documentation, regardless of if
> > it lives in comments or a separate dedicated resource.  Looking at the
> > comment above, and the SELinux implementation of this hook below, it
> > appears that the comment is a bit vague; specifically the use of
> > "compatible".  Based on the SELinux implementation, "compatible" would
> > seem to equal, do you envision that to be the case for every
> > LSM/security-model?  If the answer is yes, then let's say that (and
> > possibly rename the hook to "sb_mnt_opts_equal").  If the answer is
> > no, then I think we need to do a better job explaining what
> > compatibility really means; put yourself in the shoes of someone
> > writing a LSM, what would they need to know to write an implementation
> > for this hook?
>
> That's is tough to do as it is vague. All I was doing was fixing a
> bug. Selinux didn't allow a new mount because it had a different
> security context. What that translates to for the new hook, is up to
> the LSM module whether it would need the options to be exactly the
> same or if they can be slightly different but yet compatible this is
> really up to the LSM.
>
> Do you care to suggest wording to use? It is hard to find words that
> somebody else is looking for but one is unable to provide them.

I didn't have anything particular in mind, I just *really* don't like
the ambiguity around "compatible".  Perhaps we can take away some of
the ambiguity by providing some more explanation, how about something
like this:

"Determine if the new mount options in @mnt_opts are allowed given the
existing mounted filesystem at @sb."

... it's a pretty minor change, I'll readily admit that, but it
exchanges "compatible" for "allowed" which I *think* makes it a bit
more concrete.

-- 
paul moore
www.paul-moore.com
