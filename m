Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5454E2D47CC
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Dec 2020 18:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbgLIRXl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Dec 2020 12:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgLIRXl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Dec 2020 12:23:41 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BC6C0613D6
        for <linux-nfs@vger.kernel.org>; Wed,  9 Dec 2020 09:23:00 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id a16so3256005ejj.5
        for <linux-nfs@vger.kernel.org>; Wed, 09 Dec 2020 09:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=belknf+T6vCIqS2bVBSuDGbb/F/FSJn/Xa2Db/vLa10=;
        b=R828rOFQ8V7kGjZTTGQBsWSUXZO02sJhxS2GAJX5Cgyi+S3Va5HnkJEK1yEohBTZpB
         YKIrV3jW+WeDd/UM6F/juW2fl9JNivDleX7lU806P9RuI5Y0dmK+esBb7RyISI90s0BY
         bhPur/YL/asZFvtleKj2OaM2COQs82sqAuhY/Bss9cmhBgUZ2rt5jrw6MxX/hNM+fVj3
         I43InHi2ps/1tkzT4C5C3fqJCW1tJ1uv1nTA7swlqYUsTMPCmYKq1DkKrFmp+unBb6R3
         X3nKDRdxixfAWerxC05uPWYwnx8mboO9gBIw91xDoHfrc3UHi+HCq6EDq1xJZdKBNvqn
         zNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=belknf+T6vCIqS2bVBSuDGbb/F/FSJn/Xa2Db/vLa10=;
        b=OgAJszO+kmlipAj9LzW8I6t7674HlfodjFewCKyU0ax3iBFvcMxXX9Pk+7TP3ikOzt
         1L4evskSi44Jpsofzygt6WbgFszb/fmN2tY8a43MMjEWerzIa/D3wx9waZeZntPU2Tyu
         qzMmUmPaUGHQL+VGC0cHq3BO9mIenb60L9+QWehD3N6Yi/WcY+mntjBG8kLnEiMCX49P
         ZhCSLvdurum2pxLk9pJw9HPqzO7t+yp5APkA65tIfK8UgRjdfLuGAyUOQDUZdf6RH3st
         6NSNvA2ogu2RTC5TY1PG5yJYUe7x2HPsWmbl6BkKz/Jal+CNfo5CIRUiPE/GcfO7pRSW
         A52g==
X-Gm-Message-State: AOAM531G3dJI4lULPWN048Rwp/h4Yh1cPCz7dg6aljW+XLJ2yEGva73r
        /BMaIsRKk8OyDi2W3DdJX2VNsN2K+xC2xYc+WgQ=
X-Google-Smtp-Source: ABdhPJyc7ORyLGFQWMUMcjQb1k5G/e/pZb94Zj2rwJ9G9lMAPhwo08twfM9QlouCrGLwqRhmcPbpRpTZDi8eJLMA+Cs=
X-Received: by 2002:a17:906:f894:: with SMTP id lg20mr2927599ejb.348.1607534579544;
 Wed, 09 Dec 2020 09:22:59 -0800 (PST)
MIME-Version: 1.0
References: <20201203201841.103294-1-Anna.Schumaker@Netapp.com>
 <852166252.2305208.1607096860375.JavaMail.zimbra@desy.de> <CAN-5tyFJeLRyDUdtGkheGkmDE=i-FJprLFiav_mEPA35QeKLQA@mail.gmail.com>
 <14eac8ec352c76206c811f75b130957bb75ff590.camel@hammerspace.com>
 <CAN-5tyFwgWTBsCOBJ=7ELS4md4SBgiMQ4EPAS7LCxzCK74X13g@mail.gmail.com> <a70034b9506c650aa10480727f9f5e00cc71e25a.camel@hammerspace.com>
In-Reply-To: <a70034b9506c650aa10480727f9f5e00cc71e25a.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 9 Dec 2020 12:22:47 -0500
Message-ID: <CAN-5tyFUmQQeQQjHtmetvTN2rcJpf3KwPbhm+6TB_N33auirag@mail.gmail.com>
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

On Wed, Dec 9, 2020 at 12:12 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Wed, 2020-12-09 at 12:07 -0500, Olga Kornievskaia wrote:
> > On Wed, Dec 9, 2020 at 11:59 AM Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> > >
> > > On Fri, 2020-12-04 at 15:00 -0500, Olga Kornievskaia wrote:
> > > > I object to putting the disable patch in, I think we need to fix
> > > > the
> > > > problem.
> > >
> > > I can't see the problem is fixable in 5.10. There are way too many
> > > changes required, and we're in the middle of the week of the last -
> > > rc
> > > for 5.10. Furthermore, there are no regressions introduced by just
> > > disabling the functionality, because READ_PLUS has only just been
> > > merged in this release cycle.
> > >
> > > I therefore strongly suggest we just send [PATCH 1/3] NFS: Disable
> > > READ_PLUS by default and then fix the rest in 5.11.
> >
> > Sure, but shouldn't there be more ifdefs inside of the xdr code to
> > turn it off completely?
>
> AFAICT, those functions are not called by anything else, so as long as
> the READ_PLUS client functionality is disabled, they should be
> harmless.

Is it benign that in the normal read path sunrpc will be calling a new
function of xdr_realign_pages()? Non readplus code didn't have it.

>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
