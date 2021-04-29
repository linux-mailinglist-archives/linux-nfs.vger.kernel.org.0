Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5749A36EBEB
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Apr 2021 16:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbhD2OFl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Apr 2021 10:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237419AbhD2OFl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Apr 2021 10:05:41 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA3DC06138B
        for <linux-nfs@vger.kernel.org>; Thu, 29 Apr 2021 07:04:54 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h8so38602215edb.2
        for <linux-nfs@vger.kernel.org>; Thu, 29 Apr 2021 07:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HyBaqH38NGBV7Fdk/ZXaaW22G2J3zQ8RZMPvTlKZHac=;
        b=cQMB2YEcXqrCPNolimsvNpFSH14kJsvdKs0sZbhX3sSY4Yn6IUybD//cBosXsyo9Qi
         5jsft2UnHed54vBoxW5Lb4iTQzo18ob/XGKcdTfSQotl8LN+mtrtgLM+iXIZvGtk1FZr
         k7dGEWLataD2jRSoUgRSjEFL94fHrrVOrZGUZAKMO11D4uAD358JP3ixpnLro0vHX0Ry
         oC2vt1UB9mZR96/ix3ItkoDrqF+r+prSurw9DVxwy70fgWmTb92urtgmiJ2KYpGTdcr5
         Cxkn7HE/3Arsczww80/Z1/+ZTTE22MTeONn3kttxjwPIVXaItS1hoZ5o6woAAblxMGPV
         Gmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HyBaqH38NGBV7Fdk/ZXaaW22G2J3zQ8RZMPvTlKZHac=;
        b=Nxna5EbE800IARGMIya/MWsEB8GP2ab3vi0/ePsyMRfS0Gycz5vIozV4o5nmF1QVkj
         hZV7MXpqJmoghTj8BhuA+hotwYw5zNuuHGgbT0IUukU41rc5NKCpBjOBJp/b87ckeCVJ
         sHY1PLFBt9jNXSF8jVfTkaYpiQLFkmQ8GJFzcpDNqZJ5yM7QB1abMW7LXDQn7oDNGSMq
         U5YVsFqPvtoGqRckxl1GNjIDfj+ST6CDeBO5I9Yzo+OoNSu72SpGrjMyXlDwLc2xkSsD
         ijkE+gPMRy+loKcZoNuTGTm5atn73aHnquigqIQJx0AA9RD5bwUwTkRkMcpSebO5pDwo
         7Abg==
X-Gm-Message-State: AOAM530fzvDE+2ZHhuM0sipNpl5Jy7Nnx7gywefZ0cveLOETcKryjX5I
        ygS2lGfb4eAB69B4PSrVdSBIV6yiXO2ZN2XuYYO4KS7iyJQ=
X-Google-Smtp-Source: ABdhPJz+HaBxAg4UJ/cvAnAbmW/thNTpuX39QphwC2k8h6Y5hhrSTRV8fmDKMlizERx44+VRY0dHogwbsX+1wOVQzY8=
X-Received: by 2002:a05:6402:3591:: with SMTP id y17mr18320750edc.67.1619705092855;
 Thu, 29 Apr 2021 07:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210428213203.40059-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20210428213203.40059-1-olga.kornievskaia@gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 29 Apr 2021 10:04:41 -0400
Message-ID: <CAN-5tyFSOppGwzMHS6EqYTi7Dwa+Etp_Zi04-mDqaArCVsJ=dg@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] create sysfs files for changing IP address
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Apr 28, 2021 at 5:32 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> From: Olga Kornievskaia <kolga@netapp.com>
>
> v4: addresses the latest comments:
> --- void sysfs pointers are changed to pointers to structures
> --- removed the xprt_get/xprt_switch_get() before calling setup
> --- using xprt->address_strings[RPC_DISPLAY_PROTO] instead of creating
> adhoc labels for type of transport
> --- addressing the switching of xprt->address_strings[RPC_DISPLAY_ADDR]
> by using rcu_assign_pointer and freeing the old pointer using call_rcu()

Please hold off reviewing this patch series. Further testing revealed
an issue. Thank you.

> Anna Schumaker (4):
>   sunrpc: Prepare xs_connect() for taking NULL tasks
>   sunrpc: Create a sunrpc directory under /sys/kernel/
>   sunrpc: Create a client/ subdirectory in the sunrpc sysfs
>   sunrpc: Create per-rpc_clnt sysfs kobjects
>
> Dan Aloni (2):
>   sunrpc: add xprt id
>   sunrpc: add IDs to multipath
>
> Olga Kornievskaia (7):
>   sunrpc: keep track of the xprt_class in rpc_xprt structure
>   sunrpc: add xprt_switch direcotry to sunrpc's sysfs
>   sunrpc: add a symlink from rpc-client directory to the xprt_switch
>   sunrpc: add add sysfs directory per xprt under each xprt_switch
>   sunrpc: add dst_attr attributes to the sysfs xprt directory
>   sunrpc: provide transport info in the sysfs directory
>   sunrpc: provide multipath info in the sysfs directory
>
>  include/linux/sunrpc/clnt.h          |   2 +
>  include/linux/sunrpc/xprt.h          |   6 +
>  include/linux/sunrpc/xprtmultipath.h |   6 +
>  net/sunrpc/Makefile                  |   2 +-
>  net/sunrpc/clnt.c                    |   5 +
>  net/sunrpc/sunrpc_syms.c             |  10 +
>  net/sunrpc/sysfs.c                   | 472 +++++++++++++++++++++++++++
>  net/sunrpc/sysfs.h                   |  41 +++
>  net/sunrpc/xprt.c                    |  26 ++
>  net/sunrpc/xprtmultipath.c           |  34 ++
>  net/sunrpc/xprtrdma/transport.c      |   2 +
>  net/sunrpc/xprtsock.c                |  11 +-
>  12 files changed, 615 insertions(+), 2 deletions(-)
>  create mode 100644 net/sunrpc/sysfs.c
>  create mode 100644 net/sunrpc/sysfs.h
>
> --
> 2.27.0
>
