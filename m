Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E18B2D482A
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Dec 2020 18:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbgLIRlC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Dec 2020 12:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729575AbgLIRlC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Dec 2020 12:41:02 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC33C0613CF
        for <linux-nfs@vger.kernel.org>; Wed,  9 Dec 2020 09:40:22 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id ga15so3338646ejb.4
        for <linux-nfs@vger.kernel.org>; Wed, 09 Dec 2020 09:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jJR+39++7VFRf9wQgE+N8hkFlnaiD1R7Hur5e4gBXiE=;
        b=YZFCXdVm2jDUakJHRv8IJbrLnVewZpf57LGrhILDE8vyJ07Rxj6ZrJyfQp8NXz4MeD
         /h69LhygKfdy5ZV+AuzpJRQB2bSC+0Oqefje2dBDRg5hw9QaCF390EtLfsX3pPC7Aqv1
         vhNNfNsx9Jk9khB52+WwT1odFYvPDi12hMpIxyPOuUdHDbGn2zcm4Mg6d18JMryVE71A
         /n9gma7IH0/KBjfrw+nFuS48L368OqWHKDyuFWadF8DGoLMOWZ8VZpfo+6i0mq81VXLO
         Y7zGWoHTpLWwyOeMZOtVLdGer+ZkbW+Lrea2ePKIMzrMwspZyX3zgrAGmyApIJskSnVJ
         250w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jJR+39++7VFRf9wQgE+N8hkFlnaiD1R7Hur5e4gBXiE=;
        b=FnC2MMdgCgXnhXX+coH1IyEKhy/TfbQCWseI8ZkhQdNr4OlcRk3MJVVuiVtCSCl9S9
         c8UbGkndaOGYdcGfF423o6qer50ImOrDDdjkM8kBiLEdaYWE0/uqg2Po2t/2MvLn0V+x
         HYppCEbo6wohQNqMbp0CkA+Z6A18RMc39jGALkhXvYbba6AgtipdWudbNMaw3uoi9ZeA
         6bTFky0lChov6erm/p7eJeb3mZB4FtsSZNeLZ4/AIyrQ103wTPfaC2NXeaxbZo0MnJMj
         KsXloUhYkGl5tRehsCzHEKhiLYauvN7wrmhZvMtWFxOiZ78qEoUuVLc7A2eG1sVrOa/Q
         ic5g==
X-Gm-Message-State: AOAM531eCESY2KGfGxG+a/v45AZ5OmSChnTleARNttBztMDbe3/o6uKg
        oIPg8LQWPh/cEEK7pbsJuNxYIFKuPsKqPJwq0wY=
X-Google-Smtp-Source: ABdhPJwqV+IC2wjK6RmQVQQF6mT2XsBxMivqV5PobsmEKm/c872nz5lpw9cz95jeZnBVJciIOEb9NsUwbkkOxdYLnjw=
X-Received: by 2002:a17:906:e093:: with SMTP id gh19mr3027194ejb.510.1607535620989;
 Wed, 09 Dec 2020 09:40:20 -0800 (PST)
MIME-Version: 1.0
References: <20201203201841.103294-1-Anna.Schumaker@Netapp.com>
 <852166252.2305208.1607096860375.JavaMail.zimbra@desy.de> <CAN-5tyFJeLRyDUdtGkheGkmDE=i-FJprLFiav_mEPA35QeKLQA@mail.gmail.com>
 <14eac8ec352c76206c811f75b130957bb75ff590.camel@hammerspace.com>
 <CAN-5tyFwgWTBsCOBJ=7ELS4md4SBgiMQ4EPAS7LCxzCK74X13g@mail.gmail.com>
 <a70034b9506c650aa10480727f9f5e00cc71e25a.camel@hammerspace.com>
 <CAN-5tyFUmQQeQQjHtmetvTN2rcJpf3KwPbhm+6TB_N33auirag@mail.gmail.com> <b61c9e480cd2cc516d64d1f3e0376a748dbb3be9.camel@hammerspace.com>
In-Reply-To: <b61c9e480cd2cc516d64d1f3e0376a748dbb3be9.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 9 Dec 2020 12:40:09 -0500
Message-ID: <CAN-5tyFgtD5iR4NciDg=DHg5aAwAZju89KzEYsUi9X6NwBQacQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] NFS: Disable READ_PLUS by default
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "tigran.mkrtchyan@desy.de" <tigran.mkrtchyan@desy.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Dec 9, 2020 at 12:32 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Wed, 2020-12-09 at 12:22 -0500, Olga Kornievskaia wrote:
> > On Wed, Dec 9, 2020 at 12:12 PM Trond Myklebust <
> > trondmy@hammerspace.com> wrote:
> > >
> > > On Wed, 2020-12-09 at 12:07 -0500, Olga Kornievskaia wrote:
> > > > On Wed, Dec 9, 2020 at 11:59 AM Trond Myklebust
> > > > <trondmy@hammerspace.com> wrote:
> > > > >
> > > > > On Fri, 2020-12-04 at 15:00 -0500, Olga Kornievskaia wrote:
> > > > > > I object to putting the disable patch in, I think we need to
> > > > > > fix
> > > > > > the
> > > > > > problem.
> > > > >
> > > > > I can't see the problem is fixable in 5.10. There are way too
> > > > > many
> > > > > changes required, and we're in the middle of the week of the
> > > > > last -
> > > > > rc
> > > > > for 5.10. Furthermore, there are no regressions introduced by
> > > > > just
> > > > > disabling the functionality, because READ_PLUS has only just
> > > > > been
> > > > > merged in this release cycle.
> > > > >
> > > > > I therefore strongly suggest we just send [PATCH 1/3] NFS:
> > > > > Disable
> > > > > READ_PLUS by default and then fix the rest in 5.11.
> > > >
> > > > Sure, but shouldn't there be more ifdefs inside of the xdr code
> > > > to
> > > > turn it off completely?
> > >
> > > AFAICT, those functions are not called by anything else, so as long
> > > as
> > > the READ_PLUS client functionality is disabled, they should be
> > > harmless.
> >
> > Is it benign that in the normal read path sunrpc will be calling a
> > new
> > function of xdr_realign_pages()? Non readplus code didn't have it.
> > >
>
> Looking at commit 06216ecbd9368 (
> https://git.linux-nfs.org/?p=trondmy/linux-nfs.git;a=commitdiff;h=06216ecbd9368
> ) it is not actually changing the Linux-5.9 code, but is just
> performing a trivial refactoring of that code into a new function. I'm
> OK with that.
>
> The rest of the READ code looks unchanged to me.

Thank you for checking.

> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
