Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3563F320702
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Feb 2021 21:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhBTUEv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 20 Feb 2021 15:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhBTUEu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 20 Feb 2021 15:04:50 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295DAC061574;
        Sat, 20 Feb 2021 12:04:10 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m1so10813772wml.2;
        Sat, 20 Feb 2021 12:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EvyUzGApNtWB9y0SWjnEDS7m8ylDiJ5z5Bt63yfEHOE=;
        b=tqrUB60qTvPKU/Gl/J9m0xRclcqYMmdYM+wnKfjF4+Uk+XGB770WT99fgyd0GN2K7x
         fE9WKJ938K0ep5QEklN6oMK483AziJk+ererm+LrsiPbU48YBXyVMFfJEv/BI4F6Xf7o
         vooaGA41LhBggtnEdm8fbBuBXVgB+pDKJ9qAWtKjaPDffjFDmmHTvBB31wAok/hFkykl
         By4oQOSIoqTR1XtYYKrm+xOr5gT/pYWGGvM8CebPKWVIWS+g3Tmczhbn3V6czvW0pPLh
         wP5gPpP9z2XD8I4cu0cUp4keyf7cvmitvO4vhyJid0lmD8lCPRZbTwdxq4PVNCpRtktb
         ZVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=EvyUzGApNtWB9y0SWjnEDS7m8ylDiJ5z5Bt63yfEHOE=;
        b=CZLMDOg3PyAOTb+fo+t2cE7NHSsx/0ODJYqGNk/FJTr0AhOcsZFBcT9hI27C31s+Lj
         3dZgnHNyavsw9OLYfkRabXGJMEoc7VLkHiEBBgEElkf0b9g8Kt7nGmlU+7m9XVVZNS3S
         boY72d5VKnaX8G63NmFGdoXT0zoHIaJNmst4iZyysk8WVqq6W/nMDta8qKK+gNhEWDV+
         4nlOBW+x9TAyHLdnDtiFwW18fSEly3UlYjY+ZLE6wkK+rvEOypLj/QaCIoFnlwU66f5V
         YjA9DLio42SKcVtmsp7hHmEtbPh7VWLq4Yw7fQXFKkiCNb1YjIDLkS2XMzScH4pRzJzN
         HSCQ==
X-Gm-Message-State: AOAM530IkJih4KlPVzfqKzGswAwGcCggImDjeGhdzSj2ZO8Kj7tuMW6E
        KrODyE1cyVoROGe6c8D8T5H+VKTLBawE3A==
X-Google-Smtp-Source: ABdhPJxNJVEYpvxMTtDS7jiigiuzSazEuiVthYwWSypTrGYxwoLBYhjx0L+3vUFAYI/xk2hHynZ1CQ==
X-Received: by 2002:a1c:7c17:: with SMTP id x23mr1621201wmc.95.1613851448989;
        Sat, 20 Feb 2021 12:04:08 -0800 (PST)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id p3sm4832666wro.55.2021.02.20.12.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 12:04:08 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Sat, 20 Feb 2021 21:04:07 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        940821@bugs.debian.org, linux-nfs@vger.kernel.org,
        bfields@fieldses.org, chuck.lever@oracle.com
Subject: Re: NFS Caching broken in 4.19.37
Message-ID: <YDFrN0rZAJBbouly@eldamar.lan>
References: <5022bdc4-9f3e-9756-cbca-ada37f88ecc7@cambridgegreys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5022bdc4-9f3e-9756-cbca-ada37f88ecc7@cambridgegreys.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

On Mon, Jul 08, 2019 at 07:19:54PM +0100, Anton Ivanov wrote:
> Hi list,
> 
> NFS caching appears broken in 4.19.37.
> 
> The more cores/threads the easier to reproduce. Tested with identical
> results on Ryzen 1600 and 1600X.
> 
> 1. Mount an openwrt build tree over NFS v4
> 2. Run make -j `cat /proc/cpuinfo | grep vendor | wc -l` ; make clean in a
> loop
> 3. Result after 3-4 iterations:
> 
> State on the client
> 
> ls -laF /var/autofs/local/src/openwrt/build_dir/target-mips_24kc_musl/linux-ar71xx_tiny/linux-4.14.125/arch/mips/include/generated/uapi/asm
> 
> total 8
> drwxr-xr-x 2 anivanov anivanov 4096 Jul  8 11:40 ./
> drwxr-xr-x 3 anivanov anivanov 4096 Jul  8 11:40 ../
> 
> State as seen on the server (mounted via nfs from localhost):
> 
> ls -laF /var/autofs/local/src/openwrt/build_dir/target-mips_24kc_musl/linux-ar71xx_tiny/linux-4.14.125/arch/mips/include/generated/uapi/asm
> total 12
> drwxr-xr-x 2 anivanov anivanov 4096 Jul  8 11:40 ./
> drwxr-xr-x 3 anivanov anivanov 4096 Jul  8 11:40 ../
> -rw-r--r-- 1 anivanov anivanov   32 Jul  8 11:40 ipcbuf.h
> 
> Actual state on the filesystem:
> 
> ls -laF /exports/work/src/openwrt/build_dir/target-mips_24kc_musl/linux-ar71xx_tiny/linux-4.14.125/arch/mips/include/generated/uapi/asm
> total 12
> drwxr-xr-x 2 anivanov anivanov 4096 Jul  8 11:40 ./
> drwxr-xr-x 3 anivanov anivanov 4096 Jul  8 11:40 ../
> -rw-r--r-- 1 anivanov anivanov   32 Jul  8 11:40 ipcbuf.h
> 
> So the client has quite clearly lost the plot. Telling it to drop caches and
> re-reading the directory shows the file present.
> 
> It is possible to reproduce this using a linux kernel tree too, just takes
> much more iterations - 10+ at least.
> 
> Both client and server run 4.19.37 from Debian buster. This is filed as
> debian bug 931500. I originally thought it to be autofs related, but IMHO it
> is actually something fundamentally broken in nfs caching resulting in cache
> corruption.

According to the reporter downstream in Debian, at
https://bugs.debian.org/940821#26 thi seem still reproducible with
more recent kernels than the initial reported. Is there anything Anton
can provide to try to track down the issue?

Anton, can you reproduce with current stable series?

Regards,
Salvatore
