Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BF8380B90
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 16:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbhENOTX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 10:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbhENOTF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 May 2021 10:19:05 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C00DC06137E
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 07:16:52 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id t15so7204285edr.11
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 07:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NR1A8xnde58P/4b4WlZYw0j++XhPI8CavZLwY31txIE=;
        b=tQ22LaaoYK+6VDSouGEz965ZxeVRXJTDzhVSXTdBH5enEdXhDeU3RxLI0ARgd91rbc
         obfbWxnovBZftTFroEKZcF7eu+zIvgqu6xce2QhjoGMuT3dHtgErTWLh9Fn4eRVYXyM9
         oa5hmkIN8+Y0lIuZwBMR/2hFpzeesnbzhRjdTSCRh5u2QwC2LhPEuoyHWTwDS637/wC2
         AOdX5G8zXQ3DmhwRkUibtKW7LUp3W+SlFOiMF93dFrCjEJ5HoQmNI8HfSaGdNSfUCXLo
         P01cYwQa8yhC0RdE3nttzHGmMQ7xn+FFWXMGWKHRJ2gqmndSifVUdFLyaRmeJ0s1KRNj
         d8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NR1A8xnde58P/4b4WlZYw0j++XhPI8CavZLwY31txIE=;
        b=VAaNhJzywiGP0n9z/as/EwHmr9XhyCQwTJHX43pTaTG/jVNrNMIjX2/oID2rm1CYEZ
         ISV/ZIjKawD7Fi0g1YriSWUlmu8R4mhQS0dyk+cqbDOPnkXnIBrGAZWEJaDJXry2mnZf
         wOJXF0a5bPgEHaFagXTucl16aTxfOxYQlaumDvZWrWkOgI5j1F6irBjfpskbctLA0sIY
         cJ6BfTZ+p0suVnur8J5xEm7XJj0DJf9+cPdL9n+KBrR7R/conNlStVYFBYA0m8lv6Rf4
         JIcyU1cxgQGDbMSxaC08sH8X8g/N/HN6drfKRgNAZUen5PxrY4Yz25THS+N12M3mnAgA
         A99g==
X-Gm-Message-State: AOAM530fbfbFKPcOT3bWz+oSaoNUCQM3po6j57mJwZaBS2/lZVIOAAiP
        ZNiKhjcpufzXvLmuwt1IyKQw+poh2tXUMZNnYAY=
X-Google-Smtp-Source: ABdhPJw6mfY2ddVmJVyyS9SihtTFD9YBh25NNuxveTijwdXsBZuME8+b+MZLY+LSfMgiyKzDKKqP8BptsPVgWkZ9rdY=
X-Received: by 2002:a05:6402:354b:: with SMTP id f11mr57805788edd.139.1621001810804;
 Fri, 14 May 2021 07:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
 <20210426171947.99233-10-olga.kornievskaia@gmail.com> <20210427044214.vlbmbfdh5dpq4vhl@gmail.com>
 <CAN-5tyGe32FEeK0+bnMU16zu5Y6RkVqEey4G3VocEtx8vSQwiw@mail.gmail.com> <E841CE1C-041E-4E9A-B14F-925CC0A08581@redhat.com>
In-Reply-To: <E841CE1C-041E-4E9A-B14F-925CC0A08581@redhat.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Fri, 14 May 2021 10:16:39 -0400
Message-ID: <CAN-5tyF_x+6vtyEtfkUNTj1-MWqTg0RoRJvofh5nbRq-miot8g@mail.gmail.com>
Subject: Re: [PATCH v3 09/13] sunrpc: add a symlink from rpc-client directory
 to the xprt_switch
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Dan Aloni <dan@kernelim.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 14, 2021 at 6:17 AM Benjamin Coddington <bcodding@redhat.com> wrote:
>
> On 13 May 2021, at 17:18, Olga Kornievskaia wrote:
> > On Tue, Apr 27, 2021 at 12:42 AM Dan Aloni <dan@kernelim.com> wrote:
> >> If a client can use a single switch, shouldn't the name of the symlink
> >> be just "switch"? This is to be consistent with other symlinks in
> >> `sysfs` such as the ones in block layer, for example in my
> >> `/sys/block/sda`:
> >>
> >>     bdi -> ../../../../../../../../../../../virtual/bdi/8:0
> >>     device -> ../../../5:0:0:0
> >>
> >
> > Jumping back to this comment because now that I went back to try to
> > modify the code I'm having doubts.
> >
> > We still need numbering of xprt switches because they are different
> > for different mounts. So xprt_switches directory would still have
> > switch-0 for say a mount to server A and then switch-0 for a mount to
> > server B.  While yes I see that for a given rpc client that's making a
> > link into a xprt_switches directory will only have 1 link. And "yes"
> > the name of the link could be "switch". But isn't it more informative
> > to keep this to be the same name as the name of the directory under
> > the xprt_switches?
>
> The information isn't lost, as the symlink points to the specific switch.
> Not using a number in the symlink name informs that there will only be one
> switch for each client and makes it more deterministic for users and
> software to navigate.

What will be lost is that when you look at the xprt_switches directory
and see switch-1... switch-10 subdirectory, there is no way to tell
which rpc client uses which switch. Because each client-1 directory
will only have an entry saying "switch".

Anyway, I submitted the new version but I think it's not as good as
the original.

>
> Ben
>
