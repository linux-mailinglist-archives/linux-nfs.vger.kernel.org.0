Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECBEE151F4F
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Feb 2020 18:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgBDRWq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Feb 2020 12:22:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45306 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgBDRWq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Feb 2020 12:22:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id a6so24072607wrx.12
        for <linux-nfs@vger.kernel.org>; Tue, 04 Feb 2020 09:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V/VK+zP5C8anFqB7Lc7Z+d1HALkRTXK5L40JznzLx9g=;
        b=IpP0VcYQoQb6NhK9r6e9gxMpRm/aeKhrdwzdAi4Wp+nI01iM4DTrQhZ6TpJW4aH9yJ
         EKSC2zRWfIlt86Eqgo81NmUpk7Z3BlDTfwqFD0Qf90F6Rog+mY5k8aiQ9tZRqzXeo4iR
         Y71pE95WTJmLaOXLKK5h1FRbNdz71jVbxl730R90r3mmiTVCHL1iKcEPaVn780vx3nhw
         3OEUg/SXqEbslQ3w05erL1N0yixvJbsKHkT642+z72CKrT3wffVy3G7w6eRA7aJjeD4j
         S1noWL/IkhDRkM7AwoGccOssx84G4lWX7lWjv8wRFqL4Ia0QJgMim1lUmW08/zHpciHp
         3b4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V/VK+zP5C8anFqB7Lc7Z+d1HALkRTXK5L40JznzLx9g=;
        b=bpT8ZRo7ubGM4lOjT3Mg1AIHXFTlHc6WoCckE0sBXjePTEmlcT5367xanaYkVTz6mD
         wa1UqRzJcVQ4dbww0GONm48MTagDPSDjUa7OM+ijGKiXcZAo80nzb42Muti+CtUgj9pm
         N/KCmYb1NraKrl1VJ5S761sI4yR31X+v5CfTvJWcntjC7Ms8O7zTpih7ukgOTWQNf2T4
         R7ZnH391cduhs7tIg475tJw5kLMNR5wtoal3Pv3FWBPCVcDjR4rZjd7dk7Np4xoHnpYX
         PkDM1FcLaigL001kccPKwQ+nOq3X9VqBgP95bbr0zhqNyFfJPGvRWw13Wp5i1WDUIQDy
         fZRg==
X-Gm-Message-State: APjAAAXYtO/J6/NAm9U3eITXYB/tmMvUxu15WAMERteQHdEuFU5C/+DX
        MY609+9s8GNwzt42/M4dUPert/zKoHyK1+c6ryRKbQ==
X-Google-Smtp-Source: APXvYqyQtnCejUCvfKFgvJkS54NArU0eecoRDmFg3/jOZQ6LwBNbd2HLpOrUEQAtfWpQa5ltiWjybJDT0j6R1U/Q6zg=
X-Received: by 2002:adf:806c:: with SMTP id 99mr22025080wrk.328.1580836964192;
 Tue, 04 Feb 2020 09:22:44 -0800 (PST)
MIME-Version: 1.0
References: <20200129154703.6204-1-steved@redhat.com> <CAN-5tyF1NUt2emuPGYF+-3s9cJPwox1uoh0uVzxArRJtzPXMTA@mail.gmail.com>
 <4c48901d-3e37-31fc-a032-0326bda51b25@RedHat.com> <e96d7688a52b4f7d54e492b5f2dc9e4070cf240d.camel@hammerspace.com>
In-Reply-To: <e96d7688a52b4f7d54e492b5f2dc9e4070cf240d.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 4 Feb 2020 12:22:33 -0500
Message-ID: <CAN-5tyFmfDxUjvf2dnUGsVVW7DFt3vvKVYcCzwCjBVY5qxbV6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] manpage: Add a description of the 'nconnect' mount option
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "SteveD@RedHat.com" <SteveD@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Feb 4, 2020 at 12:13 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Tue, 2020-02-04 at 11:46 -0500, Steve Dickson wrote:
> > Trond,
> >
> > On 2/3/20 10:15 AM, Olga Kornievskaia wrote:
> > > Looks good but can we add clarification that nconnect is supported
> > > for
> > > 3.0 and 4.1+?
> > Do you have an opinion on this? Should we document the protocols that
> > are supported?
>
> Unless there is an actual protocol reason for doing so, I'd rather not
> that we be on the record as saying that NFSv4.0 will remain
> unsupported.
> In other words, I'd like us to keep open the possibility that we might
> add NFSv4.0 support in the future, should someone need it.

I see your point and I like the vagueness of the nconnect description
but is the man page written in stone, can't we say that now support is
for v3 and v4.1+ but in the future it might change? It might be
confusing for the users to do a 4.0 mount, specify nconnect and wonder
why it's not working?

>
> Cheers
>   Trond
>
>
> > steved.
> >
> > > On Wed, Jan 29, 2020 at 10:47 AM Steve Dickson <steved@redhat.com>
> > > wrote:
> > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > >
> > > > Add a description of the 'nconnect' mount option on the 'nfs'
> > > > generic
> > > > manpage.
> > > >
> > > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > Signed-off-by: Steve Dickson <steved@redhat.com>
> > > > ---
> > > >  utils/mount/nfs.man | 17 +++++++++++++++++
> > > >  1 file changed, 17 insertions(+)
> > > >
> > > > diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
> > > > index 6ba9cef..84462cd 100644
> > > > --- a/utils/mount/nfs.man
> > > > +++ b/utils/mount/nfs.man
> > > > @@ -369,6 +369,23 @@ using an automounter (refer to
> > > >  .BR automount (8)
> > > >  for details).
> > > >  .TP 1.5i
> > > > +.BR nconnect= n
> > > > +When using a connection oriented protocol such as TCP, it may
> > > > +sometimes be advantageous to set up multiple connections between
> > > > +the client and server. For instance, if your clients and/or
> > > > servers
> > > > +are equipped with multiple network interface cards (NICs), using
> > > > multiple
> > > > +connections to spread the load may improve overall performance.
> > > > +In such cases, the
> > > > +.BR nconnect
> > > > +option allows the user to specify the number of connections
> > > > +that should be established between the client and server up to
> > > > +a limit of 16.
> > > > +.IP
> > > > +Note that the
> > > > +.BR nconnect
> > > > +option may also be used by some pNFS drivers to decide how many
> > > > +connections to set up to the data servers.
> > > > +.TP 1.5i
> > > >  .BR rdirplus " / " nordirplus
> > > >  Selects whether to use NFS v3 or v4 READDIRPLUS requests.
> > > >  If this option is not specified, the NFS client uses READDIRPLUS
> > > > requests
> > > > --
> > > > 2.21.1
> > > >
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
