Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14941375CDC
	for <lists+linux-nfs@lfdr.de>; Thu,  6 May 2021 23:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhEFVfi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 May 2021 17:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbhEFVfh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 May 2021 17:35:37 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC26C061761
        for <linux-nfs@vger.kernel.org>; Thu,  6 May 2021 14:34:39 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e2so6033418ilr.1
        for <linux-nfs@vger.kernel.org>; Thu, 06 May 2021 14:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TaxXGVRhs00iV4/YujewYM76Z6i9KbyxJpsyZdzG68I=;
        b=IjXZJXFMdumCrprL1eJUFY4vXQ8B2dXee5edSNJduCt7pnN3X7dziLNkSnOUSwTGzD
         kiozAHkbdMhAOqPPWzBytjRugjEEnHXx3/tepPWEWejUZxmgSIA6MiBq5f5aJxYGOCAr
         2ToY+oynOykyFcELLK52JECmy2ITgWoHP2dr9RtJdC4zMNnuKUXSUB1UWr3OEVJu0KIA
         E++RjpDAZKNpdtyJlAFSghUM3zUzgALCqvg0idZiFmpDcpztmzfbwAoP9jMKE34/TFxf
         aOUJxB1b4UIuVPbrXAIecPKjR7lndk1HO6KxJjA03M8n0LugdV1t0qzL9tiR8P3BQoVS
         P8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TaxXGVRhs00iV4/YujewYM76Z6i9KbyxJpsyZdzG68I=;
        b=IAUjOqFQTwLP42wVqi1wykMhQGi4uZOiOltvjJTtvebxne6NEmaB7Un4AZnPS1T/K7
         fhXm/Ep7B1hEyZdB6ybHGAaneJFNRDm1ceOdaEF6KlOUp3WymqTaQdiVPfdx8vedzXiy
         7CqaNLysPYGZR0CMfQlcR/mF+rzVR49HgQcpWAY9CHxOaZsqIIXVCRbi+zmsAbPFaf/H
         qkTF9mKPCXvLOd7rTWkRCI/eUvZF6rJtuUjGhE9w2vEKxeMJ5Kh/t2y1hmWiH8lVcyqv
         A89ATKFBd8vNXpPqvUCms52KD6+sS4ugakPjCxVDdISCVPVRvca2kXE8jY3eIdRcZTvD
         QPJw==
X-Gm-Message-State: AOAM532T3H1IPobcne7aCeucPjJAULwakEhNnWNctfgQ8q/5Qu1uh+fJ
        TaNLlEEjKW/CjWVDcWvS18pGmYDHQIcGZg==
X-Google-Smtp-Source: ABdhPJwe06QAZgT31sKbnQpDYY5HOMhIdGSrGw96tQnOHdPbTRTaUX+3cQydZ/Pn0BX8LQD3LggW8w==
X-Received: by 2002:a05:6e02:13e2:: with SMTP id w2mr6403151ilj.53.1620336878619;
        Thu, 06 May 2021 14:34:38 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id 6sm1486019iog.36.2021.05.06.14.34.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 May 2021 14:34:37 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 00/12] create sysfs files for changing IP address
Date:   Thu,  6 May 2021 17:34:23 -0400
Message-Id: <20210506213435.42457-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

v5: all changes were in "sunrpc: add dst_attr attributes to the sysfs
xprt directory" and one patch removed (patch4 in previous series)
--- do an explicit disconnect before trying to connect
--- instead of using xprt->ops->connect() create a fake task and
call xprt_connect() but in that function make sure that this fake
task is not added to pending tasks.

Anna Schumaker (3):
  sunrpc: Create a sunrpc directory under /sys/kernel/
  sunrpc: Create a client/ subdirectory in the sunrpc sysfs
  sunrpc: Create per-rpc_clnt sysfs kobjects

Dan Aloni (2):
  sunrpc: add xprt id
  sunrpc: add IDs to multipath

Olga Kornievskaia (7):
  sunrpc: keep track of the xprt_class in rpc_xprt structure
  sunrpc: add xprt_switch direcotry to sunrpc's sysfs
  sunrpc: add a symlink from rpc-client directory to the xprt_switch
  sunrpc: add add sysfs directory per xprt under each xprt_switch
  sunrpc: add dst_attr attributes to the sysfs xprt directory
  sunrpc: provide transport info in the sysfs directory
  sunrpc: provide multipath info in the sysfs directory

 include/linux/sunrpc/clnt.h          |   2 +
 include/linux/sunrpc/xprt.h          |   6 +
 include/linux/sunrpc/xprtmultipath.h |   6 +
 net/sunrpc/Makefile                  |   2 +-
 net/sunrpc/clnt.c                    |   5 +
 net/sunrpc/sunrpc_syms.c             |  10 +
 net/sunrpc/sysfs.c                   | 489 +++++++++++++++++++++++++++
 net/sunrpc/sysfs.h                   |  41 +++
 net/sunrpc/xprt.c                    |  29 +-
 net/sunrpc/xprtmultipath.c           |  34 ++
 net/sunrpc/xprtrdma/transport.c      |   2 +
 net/sunrpc/xprtsock.c                |   9 +
 12 files changed, 633 insertions(+), 2 deletions(-)
 create mode 100644 net/sunrpc/sysfs.c
 create mode 100644 net/sunrpc/sysfs.h

-- 
2.27.0

