Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD8B3C25DC
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jul 2021 16:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhGIO1s (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Jul 2021 10:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhGIO1s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Jul 2021 10:27:48 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B9DC0613DD
        for <linux-nfs@vger.kernel.org>; Fri,  9 Jul 2021 07:25:03 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id he13so16468920ejc.11
        for <linux-nfs@vger.kernel.org>; Fri, 09 Jul 2021 07:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eejoTRp3qNgLrhrAajsG+SB26t9DdJJ1WdX9otTjk7s=;
        b=t2GLdhBpWVMO7k8EZPYLVEoItTIqsnBTkZZoJPPaP1RxC6VZ075YfswISbi7q7VgYY
         JNuSQRAi122ZJoDvlk07v1D4iqiBCDVbJ0pT7GZ0JRLpOavHlPYecEmqPxKAue8CZRmZ
         1OdHvPYPb0/RyPsSBhiSTcRkVEJcOZljCxolgvBc8r0gzpSimnAggXPecPoHElcJFvc/
         lQnEi81uKzEHF+6XuL3h/dpeQxlL24T5pxTsNh/xEjVLyeztf67JUYLO1gF6yFM6Yl2v
         z+DLq1C/G2y3TaHMG0HoR2SEHi/rPfCMl8B88ly9mnBwQ7lJOqVPZH4jyhGRJCz7CR0O
         Y5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eejoTRp3qNgLrhrAajsG+SB26t9DdJJ1WdX9otTjk7s=;
        b=QVGQ7q0Qnyt05oxq0jzOe7W/BnpVj/1bakTEPG/fHyQ++mFG8Bgu4CrffbcTDLwTOr
         ZZq6oYtcwhiJdjrJCCiIM2PVRfDH5yFXG2fbEnd8Kcjn27Ab9uItE7FWRPjTA/F/sMLn
         vc7XNOEK0CNH5t7JJRsteAjESKRocxAOWoA8Cffm/9p3t1kfl+X3XWgiNFi3PO+XX1Wy
         3KXUlWGjcV1shTKz/ZZajfQL/e7APhpd0JfINOvmfdE7/DlKj5POMn4N/1fo5a6lIeFV
         kppLgcf7RpIlxSQyXbUfTUn97x+sXgl5PVuokMLCZK1geZ2tZcIyhJxtyLnKV0ncAFbu
         HWDg==
X-Gm-Message-State: AOAM532eVtcPCl68ZPGeUxJzl4nOqUWy38P6e7JTcm8mvF/bwk7+W9Lz
        2cdrRUM6ISXImg/bVK1UaEtAtbTh13wCVG+8vQE=
X-Google-Smtp-Source: ABdhPJwk88A/HSO/g5HULdM/wYX/E9H05gW+neEUOchaSLl2xtrcH7acu4WQp1jtYdym1OpxaggxGs5fo05X3M5RaBA=
X-Received: by 2002:a17:906:478e:: with SMTP id cw14mr23829633ejc.432.1625840702097;
 Fri, 09 Jul 2021 07:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210616011013.50547-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20210616011013.50547-1-olga.kornievskaia@gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Fri, 9 Jul 2021 10:24:50 -0400
Message-ID: <CAN-5tyFWuEKcFd40qqo-w2FGPgDu3WiLvF7P2Vc_anL743MBNw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] do not collapse trunkable transports
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 15, 2021 at 9:10 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> From: Olga Kornievskaia <kolga@netapp.com>
>
> This patch series attempts to allow for new mounts that are to the
> same server (ie nfsv4.1+ session trunkable servers) but different
> network addresses to use connections associated with those mounts
> but still use the same client structure.
>
> A new mount options, "max_connect", controls how many extra transports
> can be added to an existing client, with maximum of 16 such transports.
>
> v3:
> -- add a new counter to xprt_switch to keep track of transports with
> unique addresses
> -- control of enforcing the limit is moved into the sunrpc layer
> into the function rpc_clnt_test_and_add_xprt
> -- after a trunking transport is created if mount request asked for
> nconnect connections, create as many as the original/first mount had

Any comments on/objections to this version?

>
> Olga Kornievskaia (6):
>   SUNRPC keep track of number of transports to unique addresses
>   SUNRPC add xps_nunique_destaddr_xprts to xprt_switch_info in sysfs
>   NFSv4 introduce max_connect mount options
>   SUNRPC enforce creation of no more than max_connect xprts
>   NFSv4 add network transport when session trunking is detected
>   NFSv4 allow for nconnect value of trunkable transport
>
>  fs/nfs/client.c                      |  2 ++
>  fs/nfs/fs_context.c                  |  7 ++++
>  fs/nfs/internal.h                    |  2 ++
>  fs/nfs/nfs4client.c                  | 50 ++++++++++++++++++++++++++--
>  fs/nfs/super.c                       |  2 ++
>  include/linux/nfs_fs.h               |  5 +++
>  include/linux/nfs_fs_sb.h            |  1 +
>  include/linux/sunrpc/clnt.h          |  2 ++
>  include/linux/sunrpc/xprtmultipath.h |  1 +
>  net/sunrpc/clnt.c                    | 11 +++++-
>  net/sunrpc/sysfs.c                   |  4 ++-
>  net/sunrpc/xprtmultipath.c           |  1 +
>  12 files changed, 84 insertions(+), 4 deletions(-)
>
> --
> 2.27.0
>
