Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA67449BE91
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 23:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbiAYWdH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 17:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbiAYWdH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 17:33:07 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1619C061744
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 14:33:06 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id o12so34047115eju.13
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 14:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oeeJHO8TMWJMimBDwT2b+COdmax7x8vmymErPKX3jxc=;
        b=DzijtXi0FpfwwMBwStqu3UmmHy6WLI6KJjaJCTw5TVkmEqNdXft9MrLSeXBntoO7Mw
         fWSvmO7h/R5mQ/yU+34k8tfHIU5T7UxRE0tWGCE66lLTfaILezBkt/1UkJvP9pVH0Yzb
         HHNrjbdaOKT86FyOQ4Jf88N4t5t/R3zJhuJwDslag8fbYnvwj1+kSYMm+Az5xDFrSoYc
         knCjS+ili0zFQfE5Tfu8zpiesGviybOMiD+yOzaswnbUAmmPC8T35oz+wE4i8da9xo9A
         Cxn3uNaT3ALpZ+5PyJS8v8W9GaSLLCJqkiGKhzgIDTWBp7Qme5nzQ2I/BzjbPf8Vhkt1
         p03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oeeJHO8TMWJMimBDwT2b+COdmax7x8vmymErPKX3jxc=;
        b=Aua3nCvkcV4YufoL4VOJYVPcS/WMagMe6PFvjssuFrjZe9eLV9+ZQrUZutWY0qnLJA
         +AcRbTKZAc/zuiSGIiHTs7HdN25SU8uk2Us0HsLbThixoz35VUpyEPe7+rtLWVvKQf7h
         Qs1s/U/E8qDtQjbOE/DF2O09HDbgx07NnV062ijpPK8oGh/vvbDc34Ojk0ywNWYrfAWV
         Qezs48YMVNy1/E2ufwfdGNWizpE9qYJumcBywZst1oWNoIvfPBI2cKHHmP/RWAGrpA8O
         Yfjjbf0/2cGkfMnSOt47R+lzsMyoxoD4GsvwVI/v7QuJWKMnTN8+Ycy1D0eDHIcFjtlX
         qEbA==
X-Gm-Message-State: AOAM532ZoG8yBmB/WkqsJw/5c3Iee76006NkcKLWxSqmanbsQboHnPQ1
        4ZhP9YWxHS2sfvXmrX4aKLQucz5WMFHCmFfHQZlb
X-Google-Smtp-Source: ABdhPJwzCS4uLiZK6VG/8/+4YA+LVnkgPcisQkj57oqNq+GSah4sXm1jFpQGtsy59McG8IOvdIVYqDfpF+TVv9/mvao=
X-Received: by 2002:a17:907:6d03:: with SMTP id sa3mr4722991ejc.517.1643149985174;
 Tue, 25 Jan 2022 14:33:05 -0800 (PST)
MIME-Version: 1.0
References: <20220120214948.3637895-1-smayhew@redhat.com> <20220120214948.3637895-2-smayhew@redhat.com>
 <CAHC9VhT2RhnXtK3aQuDCFUr5qayH25G8HHjRTJzhWM3H41YNog@mail.gmail.com>
 <YfAz0EAim7Q9ifGI@aion.usersys.redhat.com> <CAHC9VhTwXUE9dYBHrkA3Xkr=AgXvcnfSzLLBJ4QqYd4R+kFbbA@mail.gmail.com>
 <YfBGx+M9jQZa80rZ@aion.usersys.redhat.com>
In-Reply-To: <YfBGx+M9jQZa80rZ@aion.usersys.redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 25 Jan 2022 17:32:54 -0500
Message-ID: <CAHC9VhRoWbnV-cs2HzmiTEd7_kP914stdVpN9Tm2-6uua2-ELA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/2] selinux: Fix selinux_sb_mnt_opts_compat()
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     selinux@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 25, 2022 at 1:51 PM Scott Mayhew <smayhew@redhat.com> wrote:
> On Tue, 25 Jan 2022, Paul Moore wrote:
> > On Tue, Jan 25, 2022 at 12:31 PM Scott Mayhew <smayhew@redhat.com> wrote:
> > > On Mon, 24 Jan 2022, Paul Moore wrote:
> > > > On Thu, Jan 20, 2022 at 4:50 PM Scott Mayhew <smayhew@redhat.com> wrote:
> > > > >
> > > > > selinux_sb_mnt_opts_compat() is called under the sb_lock spinlock and
> > > > > shouldn't be performing any memory allocations.  Fix this by parsing the
> > > > > sids at the same time we're chopping up the security mount options
> > > > > string and then using the pre-parsed sids when doing the comparison.
> > > > >
> > > > > Fixes: cc274ae7763d ("selinux: fix sleeping function called from invalid context")
> > > > > Fixes: 69c4a42d72eb ("lsm,selinux: add new hook to compare new mount to an existing mount")
> > > > > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > > > > ---
> > > > >  security/selinux/hooks.c | 112 ++++++++++++++++++++++++++-------------
> > > > >  1 file changed, 76 insertions(+), 36 deletions(-)
> >
> > ...
> >
> > > > >         switch (token) {
> > > > >         case Opt_context:
> > > > >                 if (opts->context || opts->defcontext)
> > > > >                         goto err;
> > > > >                 opts->context = s;
> > > > > +               if (preparse_sid) {
> > > > > +                       rc = parse_sid(NULL, s, &sid);
> > > > > +                       if (rc == 0) {
> > > > > +                               opts->context_sid = sid;
> > > > > +                               opts->preparsed |= CONTEXT_MNT;
> > > > > +                       }
> > > > > +               }
> > > >
> > > > Is there a reason why we need a dedicated sid variable as opposed to
> > > > passing opt->context_sid as the parameter?  For example:
> > > >
> > > >   rc = parse_sid(NULL, s, &opts->context_sid);
> > >
> > > We don't need a dedicated sid variable.  Should I make similar changes
> > > in the second patch (get rid of the local sid variable in
> > > selinux_sb_remount() and the *context_sid variables in
> > > selinux_set_mnt_opts())?
> >
> > Yes please, I should have explicitly mentioned that.
>
> Actually, delayed_superblock_init() calls selinux_set_mnt_opts() with
> mnt_opts == NULL, so there would have to be a lot of checks like
>
>         if (opts && opts->fscontext_sid) {
>
> in the later parts of that function, which is kind of clunky.  I can
> still do it if you want though.

I might be misunderstanding your concern, but in
selinux_set_mnt_opts() all of the "opts->XXX" if-conditionals are
protected by being inside an if-statement that checks to ensure "opts"
is not NULL.  Am I missing something?

-- 
paul-moore.com
