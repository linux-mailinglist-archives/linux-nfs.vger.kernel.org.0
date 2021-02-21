Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B6D32094B
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Feb 2021 10:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbhBUJNt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 21 Feb 2021 04:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhBUJNs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 21 Feb 2021 04:13:48 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3CAC061574;
        Sun, 21 Feb 2021 01:13:06 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id w4so10741689wmi.4;
        Sun, 21 Feb 2021 01:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sxti6CnOOSbS39ZOnKJQFnh3i2szvBvlkpT+WOP/J+A=;
        b=vLksB6WQjLsyWv7GIUZFQOuJsk1edJ+F0ssyXB5gZEI+AhHmBV+hwtpjTf8ukUaNQx
         si/IPob52GTvFkI/lsDGvmSvDkxtC/VMcRLwQSBKuI8/wAo27zwqWBil1WJvokdTvKAR
         vdcmpZGcGFrPZnmYd74I6Yrjg6i/beIusJNuYqjti0ry6tfPq3TkZFpAsnNPNYKfvIpY
         mW4Jg53MITOY1uk2So/Uc99/h/75Ag6B+gJ+B8oo0/Rcp4XR9VbiEUBQkRFZpkIgtLCT
         dWXedQXYCDR0ZYE0l6edCYLCwUpULgA5yGR02hOPNRhBS1CPI1Y0Qv3klz8NXKZCzVPU
         +Cyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=sxti6CnOOSbS39ZOnKJQFnh3i2szvBvlkpT+WOP/J+A=;
        b=gJDKQ4qzNjV7NV0v3nYKY/QtgtCde8Exl2uN9OD7QItjtOveJzTMP0ctrag1Joz0B5
         mvAXO59pYxOKo5N6H66x25GV28oalodRyAvx7yKi3jYUPI1OL64jBHIJMFxneQvV2UwJ
         IxYHkouDQCD0kwj18kuf2TpW8Ak+Y9g0z4Uj3O9w7ZD+Hv/eR7Ry3kyzlcmWqDCuZBEa
         CtivZvDWAksSgTju52dAFUx1BTVAjNY9LF8MVK9iVWIfkTXj5eKkXWPNxi25mRuqjWhh
         PzJOG1CPiD5936Y5fhhMAUmNrnHkGB8e8Cw1ug/qjDIuWUOAi3yEXutCzfwSK9ehq5Dc
         lhew==
X-Gm-Message-State: AOAM530Adccm39mzVhtUcODC2ouX7NL5ig5O6KQ5RSHWOt8cGecCZru7
        THfWmLEKH9eYj7mpXIjhDiE=
X-Google-Smtp-Source: ABdhPJyXsI2ipNwUH991WhQrCW+li5wmjsg924NA5jpk5WTUkxTMReThXidY/6RJ8LcqfetnIjpr0Q==
X-Received: by 2002:a7b:cb81:: with SMTP id m1mr15506584wmi.117.1613898785363;
        Sun, 21 Feb 2021 01:13:05 -0800 (PST)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id 6sm29963574wra.63.2021.02.21.01.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 01:13:04 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Sun, 21 Feb 2021 10:13:03 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "940821@bugs.debian.org" <940821@bugs.debian.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Subject: Re: NFS Caching broken in 4.19.37
Message-ID: <YDIkH6yVgLoALT6x@eldamar.lan>
References: <5022bdc4-9f3e-9756-cbca-ada37f88ecc7@cambridgegreys.com>
 <YDFrN0rZAJBbouly@eldamar.lan>
 <af5cebbd-74c9-9345-9fe8-253fb96033f6@cambridgegreys.com>
 <BEBA9809-373A-4172-B4AD-E19D82E56DB1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BEBA9809-373A-4172-B4AD-E19D82E56DB1@oracle.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

On Sat, Feb 20, 2021 at 08:16:26PM +0000, Chuck Lever wrote:
> 
> 
> > On Feb 20, 2021, at 3:13 PM, Anton Ivanov <anton.ivanov@cambridgegreys.com> wrote:
> > 
> > On 20/02/2021 20:04, Salvatore Bonaccorso wrote:
> >> Hi,
> >> 
> >> On Mon, Jul 08, 2019 at 07:19:54PM +0100, Anton Ivanov wrote:
> >>> Hi list,
> >>> 
> >>> NFS caching appears broken in 4.19.37.
> >>> 
> >>> The more cores/threads the easier to reproduce. Tested with identical
> >>> results on Ryzen 1600 and 1600X.
> >>> 
> >>> 1. Mount an openwrt build tree over NFS v4
> >>> 2. Run make -j `cat /proc/cpuinfo | grep vendor | wc -l` ; make clean in a
> >>> loop
> >>> 3. Result after 3-4 iterations:
> >>> 
> >>> State on the client
> >>> 
> >>> ls -laF /var/autofs/local/src/openwrt/build_dir/target-mips_24kc_musl/linux-ar71xx_tiny/linux-4.14.125/arch/mips/include/generated/uapi/asm
> >>> 
> >>> total 8
> >>> drwxr-xr-x 2 anivanov anivanov 4096 Jul  8 11:40 ./
> >>> drwxr-xr-x 3 anivanov anivanov 4096 Jul  8 11:40 ../
> >>> 
> >>> State as seen on the server (mounted via nfs from localhost):
> >>> 
> >>> ls -laF /var/autofs/local/src/openwrt/build_dir/target-mips_24kc_musl/linux-ar71xx_tiny/linux-4.14.125/arch/mips/include/generated/uapi/asm
> >>> total 12
> >>> drwxr-xr-x 2 anivanov anivanov 4096 Jul  8 11:40 ./
> >>> drwxr-xr-x 3 anivanov anivanov 4096 Jul  8 11:40 ../
> >>> -rw-r--r-- 1 anivanov anivanov   32 Jul  8 11:40 ipcbuf.h
> >>> 
> >>> Actual state on the filesystem:
> >>> 
> >>> ls -laF /exports/work/src/openwrt/build_dir/target-mips_24kc_musl/linux-ar71xx_tiny/linux-4.14.125/arch/mips/include/generated/uapi/asm
> >>> total 12
> >>> drwxr-xr-x 2 anivanov anivanov 4096 Jul  8 11:40 ./
> >>> drwxr-xr-x 3 anivanov anivanov 4096 Jul  8 11:40 ../
> >>> -rw-r--r-- 1 anivanov anivanov   32 Jul  8 11:40 ipcbuf.h
> >>> 
> >>> So the client has quite clearly lost the plot. Telling it to drop caches and
> >>> re-reading the directory shows the file present.
> >>> 
> >>> It is possible to reproduce this using a linux kernel tree too, just takes
> >>> much more iterations - 10+ at least.
> >>> 
> >>> Both client and server run 4.19.37 from Debian buster. This is filed as
> >>> debian bug 931500. I originally thought it to be autofs related, but IMHO it
> >>> is actually something fundamentally broken in nfs caching resulting in cache
> >>> corruption.
> >> According to the reporter downstream in Debian, at
> >> https://bugs.debian.org/940821#26 thi seem still reproducible with
> >> more recent kernels than the initial reported. Is there anything Anton
> >> can provide to try to track down the issue?
> >> 
> >> Anton, can you reproduce with current stable series?
> > 
> > 100% reproducible with any kernel from 4.9 to 5.4, stable or backports. It may exist in earlier versions, but I do not have a machine with anything before 4.9 to test at present.
> 
> Confirming you are varying client-side kernels. Should the Linux
> NFS client maintainers be Cc'd?

Ok, agreed. Let's add them as well. NFS client maintainers any ideas
on how to trackle this?

> 
> > From 1-2 make clean && make  cycles to one afternoon depending on the number of machine cores. More cores/threads the faster it does it.
> > 
> > I tried playing with protocol minor versions, caching options, etc - it is still reproducible for any nfs4 settings as long as there is client side caching of metadata.
> > 
> > A.
> > 
> >> 
> >> Regards,
> >> Salvatore
> >> 
> > 
> > -- 
> > Anton R. Ivanov
> > Cambridgegreys Limited. Registered in England. Company Number 10273661
> > https://www.cambridgegreys.com/
> 
> --
> Chuck Lever

Regards,
Salvatore
