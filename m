Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81DA2D6ACC
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Dec 2020 23:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbgLJWbA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Dec 2020 17:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405141AbgLJW2S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Dec 2020 17:28:18 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D828C0613CF
        for <linux-nfs@vger.kernel.org>; Thu, 10 Dec 2020 13:44:38 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id p22so7139390edu.11
        for <linux-nfs@vger.kernel.org>; Thu, 10 Dec 2020 13:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=EnIfnybGQFdRVR+tzauMl5wOs45tQkGhy56c5X1Sb+E=;
        b=NAbhoS1QK6ATMhZTPJpt2XgfVImFQJ/aRbIZk+kgxdOdv30TabDc8ufyoO43Js/mRH
         5MJWrJLAcb+l0EDhqqzx+YGP/rNdKh0lrq3mQHsCoRJjSEQLWH0SbXL5yRnbxIgT4y8H
         IOkyDoOoqQxoduWXMSxC7Jv29TvK8k3ywrpvbo6od3XjGsNKyPYyZ3OnidjDiN/pSvnf
         IQqYxpD35NK5YjV/VASOuUeeyYUHMZSzpNjXXuZTzhQCKQV/xn5IbIgpDs8WBkALkZbN
         3QBnVbdz3OQuyc38O4rpJOjMlPO/PJe1bNQBQnHoQM5kJFZcATCAk7D5pES4wL/PVCM0
         Z99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=EnIfnybGQFdRVR+tzauMl5wOs45tQkGhy56c5X1Sb+E=;
        b=e0ygo1xigKNSzk1mMzk5HXESCROCWeWXCMdcVJkcmMhBd57NoU9rNqFRwEQCjMT6xm
         B7kiptrERDj2XVdNcmKMxyGQPjQMzQpeEeZ6wq233L1QM8DkVy1iyp5rAldfbqg0xpR4
         viLUi5wMy6nd7jQOCAW+5mH7HM4hNXHfbOyPrmu8354LfwBOiTRPbdjDeJ/PadRMb5mw
         6bTVJ5EocZWHi7GJ4gtd5rMRnRf2AP58Iine+4eWVJYmefElCXlxuOkUyO+7qajphx55
         9uYD8BaNXCal0kx3oJShat4peu8jdigkcu1EWMEavYbpDGelFTHauNuooTEwXpFIGCfR
         Ba1A==
X-Gm-Message-State: AOAM533wgXP5+6+v8nhP6m6OSxFGU6iSd+XVu7sJcyRKQAH3MZFWJfWD
        b8xSvVQ5wk20DP6Wb9qkjGv30ek4pZX0lPI0kg55egaeTqs=
X-Google-Smtp-Source: ABdhPJz3OXy+O6sMAQbiur1EBVJYmSKO4f7YzTeCC494hq02xYSU7tWdQwhO1+Mf37/o7Me/XsRdEFhjk8LUMC7GOxw=
X-Received: by 2002:a05:6402:202e:: with SMTP id ay14mr9181100edb.102.1607636676760;
 Thu, 10 Dec 2020 13:44:36 -0800 (PST)
MIME-Version: 1.0
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Thu, 10 Dec 2020 16:44:20 -0500
Message-ID: <CAFX2Jf=OJupgeAqUZOVqB73Jda2xbKyDO4kaGqg5qJz-Jc5YDA@mail.gmail.com>
Subject: [GIT PULL] Please pull NFSoRDMA Client Updates for 5.11
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

The following changes since commit f8394f232b1eab649ce2df5c5f15b0e528c92091:

  Linux 5.10-rc3 (2020-11-08 16:10:16 -0800)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-rdma-for-5.11-1

for you to fetch changes up to 7a03aeb66c410366acc5439ae2a341f110c4f845:

  xprtrdma: Micro-optimize MR DMA-unmapping (2020-11-11 10:57:39 -0500)

----------------------------------------------------------------
Cleanups and improvements:
  - Remove use of raw kernel memory addresses in tracepoints
  - Replace dprintk() call sites in ERR_CHUNK path
  - Trace unmap sync calls
  - Optimize MR DMA-unmapping

Thanks,
Anna
----------------------------------------------------------------
Chuck Lever (13):
      xprtrdma: Replace dprintk call sites in ERR_CHUNK path
      xprtrdma: Introduce Receive completion IDs
      xprtrdma: Introduce Send completion IDs
      xprtrdma: Introduce FRWR completion IDs
      xprtrdma: Clean up trace_xprtrdma_post_linv
      xprtrdma: Clean up reply parsing error tracepoints
      xprtrdma: Clean up tracepoints in the reply path
      xprtrdma: Clean up xprtrdma callback tracepoints
      xprtrdma: Clean up trace_xprtrdma_nomrs()
      xprtrdma: Display the task ID when reporting MR events
      xprtrdma: Trace unmap_sync calls
      xprtrdma: Move rpcrdma_mr_put()
      xprtrdma: Micro-optimize MR DMA-unmapping

 include/trace/events/rpcrdma.h    | 460
+++++++++++++++++++++++++++++++++++++++--------------------------------------------
 net/sunrpc/xprtrdma/backchannel.c |   6 +-
 net/sunrpc/xprtrdma/frwr_ops.c    |  81 ++++++++++-----
 net/sunrpc/xprtrdma/rpc_rdma.c    |  32 ++----
 net/sunrpc/xprtrdma/transport.c   |   7 +-
 net/sunrpc/xprtrdma/verbs.c       |  30 ++----
 net/sunrpc/xprtrdma/xprt_rdma.h   |   9 +-
 7 files changed, 307 insertions(+), 318 deletions(-)
