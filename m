Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A065449B82
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Nov 2021 19:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbhKHSSs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Nov 2021 13:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbhKHSSq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Nov 2021 13:18:46 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402B3C061570
        for <linux-nfs@vger.kernel.org>; Mon,  8 Nov 2021 10:16:02 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id u60so30123763ybi.9
        for <linux-nfs@vger.kernel.org>; Mon, 08 Nov 2021 10:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jm5Izkg1G50wA3pmIoYSPtUuKzKz9NiOffhCARbvsfs=;
        b=fCWa+cYcM1jSKKho8UyUYo8JPJDn9CbgfmJxgXRDbB777CJ84i1D7a8PYf6dwLPbaa
         sV9eO6daiGqminuwPdPkrRgEmT4qQtb/yaJEX2ddXKj3G1800ePp2IdgL4865ani3+KI
         YJfHCHsqzLNDc64LxHzizPJoKl9yYmN8cZZeEC40RW7UHezGPqcQ10OXHkTVbKugfs2L
         iHCpQ6Try+YwldxVvEUiC8I/A8GQNMCNPevG3ymfUv5SmF18sxlq8vuRnnkvkoiyncCM
         Gds2yLhes8W+kz31ZdAkW41eSnaVXXiCThTlmhKY+K/mPMjKMzJaEWirpW1TEvQG8qPL
         SQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jm5Izkg1G50wA3pmIoYSPtUuKzKz9NiOffhCARbvsfs=;
        b=IEMcX1wWFz3U0ravCc0F3NI8mUAxgiPiTdut8JSa5I8VmUGryNdrqtG+n0c60x88z3
         IbLnGKHI98Aqp3eJde6+C28CDklUnn6hsvbLW47nxvgk1OSD+ZHuiuGrJYIGYMtjB81g
         S72cjhFP/FHCtQbAjdgorfMPqlVTwxoo0Cku+hllGkVYHLEPhhHrR5dMGaZQYOE/2J/g
         xEEv950iEWUCm2p/9KFeXl9ATkg7F/33HLdIPIL1GYGZeAcSx7TtJEUAhIQj3NRtqIQA
         YdDt9FVq3Z5GrxO5Ej1b5dbwZ1h2LXQsnOmO1kldMCfkiNhrAalUAdIkUvVxzXqMjZwl
         PWBQ==
X-Gm-Message-State: AOAM531flQ98vBmMPxhXRqu/4kiX2ryjNCVQIzWWgp1Dh+n7R0uUVI7e
        0/sL9UmmUlqlXN1eny2g1HeFPHv/3zd/SEzbjnM=
X-Google-Smtp-Source: ABdhPJzG4iHaQr9h3j3Wa4SHAwhsWcBuoZscvCFRSHl01rOgRhFi1J6n4ofa9gSpnP9axNixRt5jCg+OMN9YR/r3UCs=
X-Received: by 2002:a25:183:: with SMTP id 125mr1289601ybb.143.1636395361379;
 Mon, 08 Nov 2021 10:16:01 -0800 (PST)
MIME-Version: 1.0
References: <20211028183519.160772-1-Anna.Schumaker@Netapp.com>
 <20211028183519.160772-10-Anna.Schumaker@Netapp.com> <f9e404ec-4e7f-3673-73a5-0df1bd8cf52d@redhat.com>
 <c753a360-2ad1-0dc9-074a-a6a3460386dc@redhat.com>
In-Reply-To: <c753a360-2ad1-0dc9-074a-a6a3460386dc@redhat.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Mon, 8 Nov 2021 13:15:45 -0500
Message-ID: <CAFX2Jfmt4xdcFki3svrFwUy5tgfnu8Y+ESofQv2h87GdTJ0X2g@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] rpcctl: Add installation to the Makefile
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 8, 2021 at 12:19 PM Steve Dickson <steved@redhat.com> wrote:
>
>
>
> On 11/8/21 12:15, Steve Dickson wrote:
> > Hello,
> >
> > On 10/28/21 14:35, schumaker.anna@gmail.com wrote:
> >> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >>
> >> And create a shell script that launches the python program from the
> >> $(libdir)
> >>
> >> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >> ---
> >>   configure.ac             |  1 +
> >>   tools/Makefile.am        |  2 +-
> >>   tools/rpcctl/Makefile.am | 20 ++++++++++++++++++++
> >>   tools/rpcctl/rpcctl      |  5 +++++
> >>   4 files changed, 27 insertions(+), 1 deletion(-)
> >>   create mode 100644 tools/rpcctl/Makefile.am
> >>   create mode 100644 tools/rpcctl/rpcctl
> >>
> >> diff --git a/configure.ac b/configure.ac
> >> index 93626d62be40..dcd3be0c8a8b 100644
> >> --- a/configure.ac
> >> +++ b/configure.ac
> >> @@ -737,6 +737,7 @@ AC_CONFIG_FILES([
> >>       tools/rpcgen/Makefile
> >>       tools/mountstats/Makefile
> >>       tools/nfs-iostat/Makefile
> >> +    tools/rpcctl/Makefile
> >>       tools/nfsdclnts/Makefile
> >>       tools/nfsconf/Makefile
> >>       tools/nfsdclddb/Makefile
> >> diff --git a/tools/Makefile.am b/tools/Makefile.am
> >> index 9b4b0803db39..c3feabbec681 100644
> >> --- a/tools/Makefile.am
> >> +++ b/tools/Makefile.am
> >> @@ -12,6 +12,6 @@ if CONFIG_NFSDCLD
> >>   OPTDIRS += nfsdclddb
> >>   endif
> >> -SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat nfsdclnts
> >> $(OPTDIRS)
> >> +SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat rpcctl
> >> nfsdclnts $(OPTDIRS)
> >>   MAINTAINERCLEANFILES = Makefile.in
> >> diff --git a/tools/rpcctl/Makefile.am b/tools/rpcctl/Makefile.am
> >> new file mode 100644
> >> index 000000000000..f4237dbc89e5
> >> --- /dev/null
> >> +++ b/tools/rpcctl/Makefile.am
> >> @@ -0,0 +1,20 @@
> >> +## Process this file with automake to produce Makefile.in
> >> +PYTHON_FILES =  rpcctl.py client.py switch.py sysfs.py xprt.py
> >> +tooldir = $(DESTDIR)$(libdir)/rpcctl
> >> +
> >> +man8_MANS = rpcctl.man
> >> +
> >> +all-local: $(PYTHON_FILES)
> >> +
> >> +install-data-hook:
> >> +    mkdir -p $(tooldir)
> >> +    for f in $(PYTHON_FILES) ; do \
> >> +        $(INSTALL) -m 644 $$f $(tooldir)/$$f ; \
> >> +    done
> >> +    chmod +x $(tooldir)/rpcctl.py
> >> +    $(INSTALL) -m 755 rpcctl $(DESTDIR)$(sbindir)/rpcctl
> >> +    sed -i "s|LIBDIR=.|LIBDIR=$(tooldir)|" $(DESTDIR)$(sbindir)/rpcctl
> > A couple issues here....
> >
> > * Changing a file after installed breaks rpm process since it
> >    changes the checksum of the file so the process thinks it is
> >    an undeclared file.
> >
> > * Why is the $(sbindir)/rpcctl wrapper even needed?
> >    Why not simply put the code that is in $(tooldir)/rpcctl.py
> >    in the /usr/sbin/rpcctl?
> >
> > * It appears the proper place to put .py modules is
> >    under /usr/lib/python-<ver>/rpcctl not /usr/lib64/rpcctl
> Correction: under /usr/lib/python-<ver>/site-packages/

Sure

> >
> > Finally when I manually set  LIBDIR=/usr/lib64/rpcctl in
> > the /usr/sbin/rpcctl wrapper all I got was
> > # rpcctl --help
> > ERROR: sysfs is not mounted
> >
> > So I know it was seeing sys.py module but not seeing
> > /sys/kernel/sunrpc/ which does exist.
> >
> > # ls /sys/kernel/sunrpc/
> > ./  ../  rpc-clients/  xprt-switches/
> >
> > So my suggestion is get rid of that wrapper
> > and look under /usr/lib/python-<ver>/rpcctl
> The same correction here... under
> /usr/lib/python-<ver>/site-packages/rpcctl

Okay, I will try all that. Thanks for looking it over!

Anna
>
> steved.
> > for the .py modules.
> >
> > steved.
> >
> >> +
> >> +
> >> +
> >> +MAINTAINERCLEANFILES=Makefile.in
> >> diff --git a/tools/rpcctl/rpcctl b/tools/rpcctl/rpcctl
> >> new file mode 100644
> >> index 000000000000..4cc35e1ea3f9
> >> --- /dev/null
> >> +++ b/tools/rpcctl/rpcctl
> >> @@ -0,0 +1,5 @@
> >> +#!/bin/bash
> >> +LIBDIR=.
> >> +PYTHON3=/usr/bin/python
> >> +
> >> +exec $PYTHON3 $LIBDIR/rpcctl.py $*
> >>
>
