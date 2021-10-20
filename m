Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A982D435034
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Oct 2021 18:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhJTQft (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Oct 2021 12:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhJTQfr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Oct 2021 12:35:47 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1741C06161C
        for <linux-nfs@vger.kernel.org>; Wed, 20 Oct 2021 09:33:32 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id a25so27969214edx.8
        for <linux-nfs@vger.kernel.org>; Wed, 20 Oct 2021 09:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MY1M0nBx69T3tKMXEeLNytD4i/TT4mKmZ5QdHkuiyPE=;
        b=JaTbuRsZ39zxz7eHru8JC196GaLsXnI06Zh0qPtex+hFKfhR44aQuPsbQ6GzMfgDgR
         uSYtG8rXDNZ52gQAnALrZpMtoGriltQFRD2ydXFe3G+QewFod8Xaer/2ONDb+91FkLrX
         wG7N+zFRWlay1eY5iLSdJlUkFHD/uGC3VsopHGq661jIMT5Vd/wB7PI4J9Vt5fcwU88E
         5sdr1D7Uc3MWfYIk4jtnUW/5Hypar/7OGaUeDWq4UU8kbeQZ+Mf164BemWTVH9CXNF0A
         iv6zFvg7MXnGkUp+36TzVw8FHuht3qgE8J6OG2iPNNCB/lRbrLv+Wj365Fo5gJ2NseSU
         3i3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MY1M0nBx69T3tKMXEeLNytD4i/TT4mKmZ5QdHkuiyPE=;
        b=0YB/iHpOt/oiBJdXx5kv8faRts5ahrKW+r16Rp9e37p3GG899L8RGGpW0ZWEjSMrgg
         J5+q0yXHob+jglWS+NbuP4iViJkJMLFUmuOgSgMRKZwxIQRhKhYp0k2lYzcB9SygqZrJ
         UDHvraqmTT2YJ8LUOWtlow4CCuhS8cz7fteoFTbXxH/lU7bJJmRqPyHN9JyqpUx3vy1L
         0/xZOzq4zbvoeUQp5RoUzWbf3tcUSyy+PNnRyKhgKxY+U4NDfSSDGBnPtNgkcBvyuIYs
         3Ni/vtrH4eeZGhrmaMNqZBswuzgR/5ZJ3bvXp7Y+xizwXhUlYFtmADfNuONa1j50S3cr
         U8eQ==
X-Gm-Message-State: AOAM530KQZ2Ut3r22NUSAhGSzKzi0tld4hCPAym8ca0Ih5yMjFAShzH6
        lfjBEO+McYBEUBhfFGt3+Spq+mDNyVSQexIrYOLI15uAnxlLWg==
X-Google-Smtp-Source: ABdhPJwDLi7FT0soPrUdGe83h3B2RYoSxoZAzprzcF2h6Dd22fr8BqzwQKcHtAGvIdk3uEy9K7baZcyrGsU5UUOxhy8=
X-Received: by 2002:a50:9e43:: with SMTP id z61mr3187ede.278.1634747611019;
 Wed, 20 Oct 2021 09:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20211020155421.GC597@fieldses.org> <18E32DF5-3F1D-4C23-8C2F-A7963103CF8C@oracle.com>
In-Reply-To: <18E32DF5-3F1D-4C23-8C2F-A7963103CF8C@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 20 Oct 2021 12:33:19 -0400
Message-ID: <CAN-5tyEL4L2GH=-MDGS4qNTcCLRPFCQzfDQjFAVbG7wMKvHxOg@mail.gmail.com>
Subject: Re: server-to-server copy by default
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>, Steve Dickson <steved@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 20, 2021 at 12:00 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Oct 20, 2021, at 11:54 AM, J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > knfsd has supported server-to-server copy for a couple years (since
> > 5.5).  You have set a module parameter to enable it.  I'm getting asked
> > when we could turn that parameter on by default.
> >
> > I've got a couple vague criteria: one just general maturity, the other a
> > security question:
> >
> > 1. General maturity: the only reports I recall seeing are from testers.
> > Is anyone using this?  Does it work for them?  Do they find a benefit?
> > Maybe we could turn it on by default in one distro (Fedora?) and promote
> > it a little and see what that turns up?
>
> I like the idea of enabling it in one of the technology
> preview distributions.
>
> But wrt the maturity question, is the work finished? Or,
> perhaps a better question is do we have a minimum viable
> product here that can be enabled, or is more work needed
> to meet even that bar?
>
> One thing that I recall is missing is support for Kerberos
> in the server-to-server copy operation. Is that in plan,
> or deemed unimportant?

Netapp has some code for gssv3 support which is required for
server-to-server and possibly some copy offload pieces (Andy's work
before his retirement). Anna was picking up the gssv3 work but hasn't
had the cycles yet to complete it. We can make it more of a priority
if that is a show stopper.

> > 2. Security question: with server-to-server copy enabled, you can send
> > the server a COPY call with any random address, and the server will
> > mount that address, open a file, and read from it.  Is that safe?
> >
> > Normally we only mount servers that were chosen by root.  Here we'll
> > mount any random server that some client told us to.  What's the worst
> > that random server can do?  Do we trust our xdr decoding?  Can it DOS us
> > by throwing the client's state recovery code into some loop with weird
> > error returns?  Etc.
>
> A basic question is what is in distribution QE test suites
> that could exercise this feature? Should upstream be tasked
> with providing any missing pieces (as part of, say, pynfs,
> or nfstests)?

There are server-to-server tests in the nfstest testing suite. I'm not
sure if any of the xfstest copy_ofload exercise server to server
capability. Anna wrote the tests.

> > Maybe it's fine.  I'm OK with some level of risk.  I just want to make
> > sure somebody's thought this through.
> >
> > There's also interest in allowing unprivileged NFS mounts, but I don't
> > think we've turned that on yet, partly for similar reasons.  This is a
> > subset of that problem.
> >
> > --b.
>
> --
> Chuck Lever
>
>
>
