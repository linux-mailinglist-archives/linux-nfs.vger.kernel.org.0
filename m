Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DA32FF3F6
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 20:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbhAUTMi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 14:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbhAUTLF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 14:11:05 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A6BC0613D6
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 11:10:24 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m2so2413139wmm.1
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 11:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0iyVltByHnGoJJ0DqUFPeSCNE6AdYbPEXFJvYewGE6E=;
        b=Q07HW7w6WltC6pb2boEf4L/NaMeAMFxuqbhsB/WsrHc2uCOAwr60DvJGwiVVVF/bhd
         eZl51tntaUHzmJ+G/FPn5TqOLL5iSO48byCtcsvPITZlvDwLj6L7f5JeC1fLg6w7Hm18
         GJsgzDSQ2kHeEQsHEmhN45zXc795CandoQoP65V2tjDLJpB2Oxr7UPMJKJ689oRima9/
         F4+v0i/IMZHFn9nSWu+z7LVSRSGQHS5xcoMeOf83Xaxh1xkjcWtiWGbTLNzawX+hjWEF
         ARcTtD5hSAumNCxg0Ua8eIrkDmXMC3+yzYVlMscqiM/CIb9l9RRLW3spTt5J30V9wLq7
         85fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0iyVltByHnGoJJ0DqUFPeSCNE6AdYbPEXFJvYewGE6E=;
        b=o94p734CvX+ehmSrMqrO2fnYmyJwWONKmHh6yK0uQMn8Bg0jINBzOkYthxBc+n+XVZ
         YihdNRhuKBRSTDkfwtYI1pNW4xt5GIOQ54WXLAAy8mP3x35NnGpVZzR6FOQmP4dmCaor
         n17jvkDduk0/+kSbsmmJOPuJFzo1hQxDQM7AbpaJcFLjGIK+C8NZigS05WXKfoWsoKEK
         L6USX+xi1csjfS6Rr5Qf1B/BI9X9FeVL9/+NDVO+rSd246KT1n6h42Voc6XKtunLfK+L
         LvRdGffUBG4JBNo6dlU0Jy0BNzKqjlP/I7WODwFcZ/oA+oYYIdex2lYgYouxZq6S6Ug7
         NHkA==
X-Gm-Message-State: AOAM53066tTJpMnOqmNrov277vflWtWkxSXXTu2lJOKeyWbUx0Du5gJp
        qalbPPN3RZzEFusxB4VelVlMKZHVqQOsTsbn
X-Google-Smtp-Source: ABdhPJy+UEkAEiRlsGfvULNi20G5HK4R/T+EoP9WRpu1FEP3JUQVhpLfjgC/U/pB2ttTndis8UldBw==
X-Received: by 2002:a05:600c:19c8:: with SMTP id u8mr730747wmq.59.1611256223124;
        Thu, 21 Jan 2021 11:10:23 -0800 (PST)
Received: from jupiter.home.aloni.org ([77.124.84.167])
        by smtp.gmail.com with ESMTPSA id d30sm11160353wrc.92.2021.01.21.11.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 11:10:22 -0800 (PST)
From:   Dan Aloni <dan@kernelim.com>
To:     linux-nfs@vger.kernel.org
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: [PATCH v1 0/5] NFSv3 client RDMA multipath enhancements
Date:   Thu, 21 Jan 2021 21:10:15 +0200
Message-Id: <20210121191020.3144948-1-dan@kernelim.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

The purpose of the following changes is to allow specifying multiple
target IP addresses in a single mount. Combining this with nconnect and
servers that support exposing multiple ports, we can achieve load
balancing and much greater throughput, especially on RDMA setups,
even with the older NFSv3 protocol.

The changes allow specifing a new `remoteports=<IP-addresses-ranges>`
mount option providing a group of IP addresses, from which `nconnect` at
sunrpc scope picks target transport address in round-robin. There's also
an accompanying `localports` parameter that allows local address bind so
that the source port is better controlled in a way to ensure that
transports are not hogging a single local interface.

This patchset targets the linux-next tree.

Dan Aloni (5):
  sunrpc: Allow specifying a vector of IP addresses for nconnect
  xprtrdma: Bind to a local address if requested
  nfs: Extend nconnect with remoteports and localports mount params
  sunrpc: Add srcaddr to xprt sysfs debug
  nfs: Increase NFS_MAX_CONNECTIONS

 fs/nfs/client.c                            |  24 +++
 fs/nfs/fs_context.c                        | 173 ++++++++++++++++++++-
 fs/nfs/internal.h                          |   4 +
 include/linux/nfs_fs_sb.h                  |   2 +
 include/linux/sunrpc/clnt.h                |   9 ++
 include/linux/sunrpc/xprt.h                |   1 +
 net/sunrpc/clnt.c                          |  47 ++++++
 net/sunrpc/debugfs.c                       |   8 +-
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |   2 +-
 net/sunrpc/xprtrdma/transport.c            |  17 +-
 net/sunrpc/xprtrdma/verbs.c                |  15 +-
 net/sunrpc/xprtrdma/xprt_rdma.h            |   5 +-
 net/sunrpc/xprtsock.c                      |  49 +++---
 13 files changed, 329 insertions(+), 27 deletions(-)

-- 
2.26.2

