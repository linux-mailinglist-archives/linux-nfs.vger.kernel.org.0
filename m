Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C253F9EEC
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Aug 2021 20:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhH0SiR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Aug 2021 14:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhH0SiQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Aug 2021 14:38:16 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D6FC061757
        for <linux-nfs@vger.kernel.org>; Fri, 27 Aug 2021 11:37:27 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id y144so8205379qkb.6
        for <linux-nfs@vger.kernel.org>; Fri, 27 Aug 2021 11:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0KIPn5nEPcZq/fwMgTVVtNyI6Jjle3VCa49JKgS12rI=;
        b=tV+n/BMBdUMZgWDH4GjyfzbsS9+BkjlDPEzFX6FakA64U1dSVTz1yahLuWDb0JD5w7
         vqmX9NIyWD5Qh0Aj3EyeHy2yMYakE16/Cto019+2TMto5EiNpJI8dlIEKV/H2pkCz1tu
         TwWSXsFrcfwvU1l4BjmIWXjixtWgIR4awIEOwxdHK55/iyLbBT36mdXh+bZ7j73S3ZMI
         JWxAxedSf19V5aXqMLDvFVRm4CrHlhWhl3b9GkxHLynE2r4Jsvf0mlT7CCPCw8KblRU/
         /+ii6TduAO0XTumc7347157nf8sFl7PEKSd0mscUoVVQGCrLEbn3tAlxRiAzWJtbrhTO
         PEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0KIPn5nEPcZq/fwMgTVVtNyI6Jjle3VCa49JKgS12rI=;
        b=r/jAciiwwpi3Va+fLGQrrgdWN75w+5mVXR+txqpVzn20LM6Q1COGksGwzISEJLHyTi
         9gELCfLgiiKjSdYqOb0+ET5wN+y7h9/q0iDM6xSZd3FnobYaf3btj1bhl4xDIRcFm3u0
         bkUt3wRXmLQk/oIA1nZo6L5HIlxnXtBVx3E1EMbzNV00luU+pYqfQQqvjtAXnBOYBKZb
         1wLzAkF98sLn9GCIGSKj7nlQLVCTlyYBnn+v4pbFDcSBgzlOjXaO8awcHNoqxaiX9be7
         lpJ8gbHgBEP7O/noLTKdt1GA8IzGs7+8k9/gDh0V4Sy3IbPXMnvywwIrcaKIgXowchtK
         /dCQ==
X-Gm-Message-State: AOAM533sMkT0WBBpg27aCVfuP1DBuI1TE/eFtrUHZ//wmbs2Wz6jiwmM
        veeu77IPZP2G8TMQ03YMyoVrbfkJQQvsQg==
X-Google-Smtp-Source: ABdhPJyktQiB1tw7wRtL5agb5iLpZiEyVpYnkLFmgwAeSfFkNkjcJB8LGRU6EiF5UbqIBgwzHjrVQA==
X-Received: by 2002:a05:620a:2045:: with SMTP id d5mr10573681qka.281.1630089447006;
        Fri, 27 Aug 2021 11:37:27 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:b143:41d3:e2f6:337b])
        by smtp.gmail.com with ESMTPSA id bl36sm5207463qkb.37.2021.08.27.11.37.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Aug 2021 11:37:26 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 0/5] do not collapse trunkable transports
Date:   Fri, 27 Aug 2021 14:37:13 -0400
Message-Id: <20210827183719.41057-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

This patch series attempts to allow for new mounts that are to the
same server (ie nfsv4.1+ session trunkable servers) but different
network addresses to use connections associated with those mounts
but still use the same client structure.

A new mount options, "max_connect", controls how many extra transports
can be added to an existing client, with maximum of 16 such transports.

v5: fix compile warning

v4:
no change to 5 patches were made.
patch 6 dropped.
man page patch added

Olga Kornievskaia (5):
  SUNRPC keep track of number of transports to unique addresses
  SUNRPC add xps_nunique_destaddr_xprts to xprt_switch_info in sysfs
  NFSv4 introduce max_connect mount options
  SUNRPC enforce creation of no more than max_connect xprts
  NFSv4.1 add network transport when session trunking is detected

 fs/nfs/client.c                      |  2 ++
 fs/nfs/fs_context.c                  |  7 +++++
 fs/nfs/internal.h                    |  2 ++
 fs/nfs/nfs4client.c                  | 41 ++++++++++++++++++++++++++--
 fs/nfs/super.c                       |  2 ++
 include/linux/nfs_fs.h               |  5 ++++
 include/linux/nfs_fs_sb.h            |  1 +
 include/linux/sunrpc/clnt.h          |  2 ++
 include/linux/sunrpc/xprtmultipath.h |  1 +
 net/sunrpc/clnt.c                    | 11 +++++++-
 net/sunrpc/sysfs.c                   |  4 ++-
 net/sunrpc/xprtmultipath.c           |  1 +
 12 files changed, 75 insertions(+), 4 deletions(-)

-- 
2.27.0

