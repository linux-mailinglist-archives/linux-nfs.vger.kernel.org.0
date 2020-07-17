Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E672245D4
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jul 2020 23:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgGQV15 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jul 2020 17:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgGQV14 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jul 2020 17:27:56 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9757EC0619D2
        for <linux-nfs@vger.kernel.org>; Fri, 17 Jul 2020 14:27:56 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a1so12228478ejg.12
        for <linux-nfs@vger.kernel.org>; Fri, 17 Jul 2020 14:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=zbzJtWyhJhp0kXdKNcBwInqRot9fG4JS8H2lCRqJtm0=;
        b=cHMl9zlNNuQml1qunHJDJmznzz4O6MkFtAsrGJlMYWmaad0pEuVBrQY2H7qO63WxIJ
         mXO1mjJ4tFqW8fk3EKWYcNlWvRkl2gutQyhNkw7whI7A4TRCTLoWv01uWNCPqJTShJy1
         5/lfptVX3uofM0+556A23XgHm0lLjM7e26FTLrXuyANHV97/FtVFbfQ+pLMlhHkyUcpE
         U3Q67XS4Zc7O9+woFik+CgI5l9hSSd9SVW+vaYukCduDXduv5PiGwvn0jhHzLcBLMq9/
         GVaNeIdYUa6eRgQ9L3/Xxfvzbc26MgX627mjzwQca4CQ1UQl8qilxqo+AfXwaXzpuj2W
         eoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zbzJtWyhJhp0kXdKNcBwInqRot9fG4JS8H2lCRqJtm0=;
        b=LzVXr53U/zkaif7FgDQm3mGyaDVSGfl4EUtiNfFW/Lx7jeXthUUs6rKFH8pXCG6wm3
         BjRxq0oX26mbtkrq1ImuxX1sx6WeBo60jtYoXNAZu5kmbH3C2YM73Ie8Me+rQS3lHN1x
         K6dcCGmHuL8I8XVy05iwLDPJOwTPLHAIZbOY4r6cSI8YHAJqcqsdxfzorLZLP7P+bjLH
         2BDoYdMCfbwUnzpOXcLQGf+X26MRcGrby7rUCAePBXM+pluInIIgIYUPwoIOQUnt0f3r
         EYwNgTSRHHZ92chuM/Ebr4iZyKTol1vh+9A9UOulPwiPOqsax6TCzxRB2tQqdH5Lpgtr
         u0AQ==
X-Gm-Message-State: AOAM5315rR6PHykhiYgZzxxIwZMiOE2JoqNR41sVoRF/Tzvw56j+o/RX
        SVsM/AAJSx2SY/51f4XNGhfbDkKYqGtYiArj8gnTED7z
X-Google-Smtp-Source: ABdhPJz2aK6+oA+ceHBG6QERVXZBQYRwzG8Dl7Rrv62aMeVkS1unG+uwBIbMw4hiH1EiR3vVx3OpoXr0Ywb4N6hXDo8=
X-Received: by 2002:a17:906:945:: with SMTP id j5mr10216763ejd.436.1595021274459;
 Fri, 17 Jul 2020 14:27:54 -0700 (PDT)
MIME-Version: 1.0
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Fri, 17 Jul 2020 17:27:38 -0400
Message-ID: <CAFX2Jfmu8sMKGgvUSkvntktDZD_uDhu=5d6TyqH-RuDpG4xgaA@mail.gmail.com>
Subject: [GIT PULL] A few more NFS client bugfixes for Linux 5.8
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

The following changes since commit 11ba468877bb23f28956a35e896356252d63c983:

  Linux 5.8-rc5 (2020-07-12 16:34:50 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git nfs-for-5.8-3

for you to fetch changes up to 65caafd0d2145d1dd02072c4ced540624daeab40:

  SUNRPC reverting d03727b248d0 ("NFSv4 fix CLOSE not waiting for
direct IO compeletion") (2020-07-17 14:47:38 -0400)

----------------------------------------------------------------
These are mostly SUNRPC and NFSoRDMA fixes, but there is an NFS layer fix too.

- NFS: Fix interrupted slots by using the SEQUENCE operation
- SUNRPC: reverte d03727b248d0 to fix unkillable IOs
- xprtrdma: Fix double-free in rpcrdma_ep_create()
- xprtrdma: Fix recursion into rpcrdma_xprt_disconnect()
- xprtrdma: Fix return code from rpcrdma_xprt_connect()
- xprtrdma: Fix handling of connect errors
- xprtrdma: Fix incorrect header size calculations

Thanks,
Anna

----------------------------------------------------------------
Anna Schumaker (1):
      NFS: Fix interrupted slots by sending a solo SEQUENCE operation

Chuck Lever (4):
      xprtrdma: Fix double-free in rpcrdma_ep_create()
      xprtrdma: Fix recursion into rpcrdma_xprt_disconnect()
      xprtrdma: Fix return code from rpcrdma_xprt_connect()
      xprtrdma: Fix handling of connect errors

Colin Ian King (1):
      xprtrdma: fix incorrect header size calculations

Olga Kornievskaia (1):
      SUNRPC reverting d03727b248d0 ("NFSv4 fix CLOSE not waiting for
direct IO compeletion")

 fs/nfs/direct.c                 | 13 ++++---------
 fs/nfs/file.c                   |  1 -
 fs/nfs/nfs4proc.c               | 20 ++++++++++++++++++--
 net/sunrpc/xprtrdma/rpc_rdma.c  |  4 ++--
 net/sunrpc/xprtrdma/transport.c |  5 +++++
 net/sunrpc/xprtrdma/verbs.c     | 35 ++++++++++++++++-------------------
 6 files changed, 45 insertions(+), 33 deletions(-)
