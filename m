Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B245325522
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Feb 2021 19:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhBYSGD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Feb 2021 13:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbhBYSD6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Feb 2021 13:03:58 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8F3C061574;
        Thu, 25 Feb 2021 10:03:18 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g3so8028489edb.11;
        Thu, 25 Feb 2021 10:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pA/LDAVmSyo/M2z0Ab6U1eFLC9Pa8ew081+3mLjJXhg=;
        b=NmtjAsDlT5kvpzKR6hvseAIlWwcPz7x4k6mlzG7ctVMiZoIdebGYIRXsYwcqwG1NsJ
         EkdkJF3I+xOwDLK5aDXcsUcfE4hPuor5Dg0NvKHaFRD+X51Xp9aGlgJ040HOXZcnJoZW
         ZzRpnCwCWPXrDxfxJzuQA9BWWq+/aE8Vm1PM9Nud0FrO48lG7B7BzyiCqP7ZCE6YRDb6
         6+YQIupL4FuK9c0S0O9Fm5MmgVFx9ri4oZpYhjExRy7glnjtOlZxBowH8G5WUWmKXZ/5
         JAYfGKDA/7VVzECE7Z1oSrkmX88NZlfbxRIBtRm5dMtTYIsE4tjmf71+CySoAcYFcszf
         KlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pA/LDAVmSyo/M2z0Ab6U1eFLC9Pa8ew081+3mLjJXhg=;
        b=fqC8Uhk03vIcOcMoFry3wc+6mfe1z5QP6SA7KZ8k2i9JEPEq1J1sn+cxkk9crqNVfV
         ZjCk9JBHqYG69jb8OMZB+HkDbU0GgTnES1qqmyHJmFl55jhvGRHGbWy30qKKphfN5BdW
         oGABY/+ET3274tAHBIBEoURPEMQjXXrBvDeko4e1iNkdYK9woVigwzsuJsdSXfREdj5L
         gfBzQ6VxSlpQNU0VnWj+YFZ0aidyhFfryJHAbBsFnIjm2uOWyG7uZsUxAS7R7Oa7RSRM
         A02YXby0dxbawmrswdIeRtlegHeGKJ+6iWsc2pUlLuvilyq6QLashS83GzS0ePuw4FTS
         7oXg==
X-Gm-Message-State: AOAM532q+XORLDvzPcTU6TmlRP/FEridHhrkjA/Hp4hZkY1zi3LkTgNj
        SnKupVzIRCtKInS1ifOiGGej2U9HWE8plO2SUsdqPgit
X-Google-Smtp-Source: ABdhPJyUe0CoTxxBit3VO+F4cTyoXFB26XpZLOr3yA6PJu8QF10JevHdxLypLOjiD7Jr434vZmC55X/Z2KOGDpFpdYo=
X-Received: by 2002:a05:6402:5194:: with SMTP id q20mr4242766edd.267.1614276197084;
 Thu, 25 Feb 2021 10:03:17 -0800 (PST)
MIME-Version: 1.0
References: <20210219222233.20748-1-olga.kornievskaia@gmail.com> <CAHC9VhRKLBNNfUE0FMgGJBR5eBQ+Et=oK1rcErUU_i62AGhfsQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRKLBNNfUE0FMgGJBR5eBQ+Et=oK1rcErUU_i62AGhfsQ@mail.gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 25 Feb 2021 13:03:06 -0500
Message-ID: <CAN-5tyGuV-gs0KzVbKSj42ZMx553zy9wOfVb1SoHoE-WCoN1_w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] [security] Add new hook to compare new mount to an
 existing mount
To:     Paul Moore <paul@paul-moore.com>
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

On Thu, Feb 25, 2021 at 12:53 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Fri, Feb 19, 2021 at 5:25 PM Olga Kornievskaia
> <olga.kornievskaia@gmail.com> wrote:
> >
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Add a new hook that takes an existing super block and a new mount
> > with new options and determines if new options confict with an
> > existing mount or not.
> >
> > A filesystem can use this new hook to determine if it can share
> > the an existing superblock with a new superblock for the new mount.
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  include/linux/lsm_hook_defs.h |  1 +
> >  include/linux/lsm_hooks.h     |  6 ++++
> >  include/linux/security.h      |  8 +++++
> >  security/security.c           |  7 +++++
> >  security/selinux/hooks.c      | 56 +++++++++++++++++++++++++++++++++++
> >  5 files changed, 78 insertions(+)
>
> ...
>
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index a19adef1f088..d76aaecfdf0f 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -142,6 +142,12 @@
> >   *     @orig the original mount data copied from userspace.
> >   *     @copy copied data which will be passed to the security module.
> >   *     Returns 0 if the copy was successful.
> > + * @sb_mnt_opts_compat:
> > + *     Determine if the existing mount options are compatible with the new
> > + *     mount options being used.
>
> Full disclosure: I'm a big fan of good documentation, regardless of if
> it lives in comments or a separate dedicated resource.  Looking at the
> comment above, and the SELinux implementation of this hook below, it
> appears that the comment is a bit vague; specifically the use of
> "compatible".  Based on the SELinux implementation, "compatible" would
> seem to equal, do you envision that to be the case for every
> LSM/security-model?  If the answer is yes, then let's say that (and
> possibly rename the hook to "sb_mnt_opts_equal").  If the answer is
> no, then I think we need to do a better job explaining what
> compatibility really means; put yourself in the shoes of someone
> writing a LSM, what would they need to know to write an implementation
> for this hook?

That's is tough to do as it is vague. All I was doing was fixing a
bug. Selinux didn't allow a new mount because it had a different
security context. What that translates to for the new hook, is up to
the LSM module whether it would need the options to be exactly the
same or if they can be slightly different but yet compatible this is
really up to the LSM.

Do you care to suggest wording to use? It is hard to find words that
somebody else is looking for but one is unable to provide them.

>
> > + *     @sb superblock being compared
> > + *     @mnt_opts new mount options
> > + *     Return 0 if options are compatible.
>
> --
> paul moore
> www.paul-moore.com
