Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDE93A8E16
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jun 2021 03:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhFPBMY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Jun 2021 21:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbhFPBMX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Jun 2021 21:12:23 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D576C061574
        for <linux-nfs@vger.kernel.org>; Tue, 15 Jun 2021 18:10:17 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id g12so629951qtb.2
        for <linux-nfs@vger.kernel.org>; Tue, 15 Jun 2021 18:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UFYXooIxSa5ReULONWXd+eAzsgMOWrBDP5X4qSHwSLU=;
        b=BWEstJ4ANBPsyZ5lL7O0C4W6K8LljqBCuTCcbG1KnaH3OSW1M6OPA50odFpU1Btela
         wMUSTmiFi/9a0N1TJOTTiuF0O4OskvPStfdEX8LflZzwfUYyfw9/Dqpv9gzzzLJlrBhY
         nce9sNGq+Q6SzI4wm3YX4CvfOXPLC53AFoU7gsEuyqs+hjJcSW0TAlg0/AXqBB58yLTy
         a5zVAMNkmjx728YUhtl4nAscPYnddIrJQdwu5r8c7fsg/XUKh9X0tK/wyr4+3cxBxwQs
         vKluQppnZUFk1xURUGwLrnMEGupAiu9jYXY7iPtk3S+uye1goBNUy43T/Yh9GLI/3fMU
         j2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UFYXooIxSa5ReULONWXd+eAzsgMOWrBDP5X4qSHwSLU=;
        b=gmT7ADZUXFk9uk5hEzGYWQjTCKCDdxhj6oUEhXOWWd84sfSQM6nwzWzTymq+2CblJz
         FTE+UTu+c3QvihuVl4V/g/mAh2ht1Tm2t183ChnDlM0J7a1Wfd0J+G3Cd7RsJyPfhvDA
         UL2w8b5CioKuDpJVAU10btYnFj0viBeCHn+fFVs2JCYx0nUvKRcKPEmEUnsHuj+wdNGY
         rpH960VqYi65dwqVaRWVtRPDIEaMkSSYg5atX/481NT87/wonbqKC6so7cMMo6um92jY
         WU1iC7yYIO7ktlSlx1MSAxsuk9KlFCJdhnvTxvniGe0Y58VQJ24D5DMvccQDEGY+DVE0
         5iZA==
X-Gm-Message-State: AOAM530FXJ2X32EZ9YNYw33UAfh861h7La5W673z5Ucy+5ViYpLblPM2
        2cU1H2zHA0CFp5uj88hNX07qaFAFwrB3oA==
X-Google-Smtp-Source: ABdhPJw36SA1+Ayo0M7l6itY2tswfpn4m8fx1X0cdyFpqRxwQ1JW8ibnpb5U0v2RhjdBziU8ykvu7A==
X-Received: by 2002:ac8:5813:: with SMTP id g19mr2525194qtg.383.1623805816594;
        Tue, 15 Jun 2021 18:10:16 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id m189sm546007qkd.107.2021.06.15.18.10.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jun 2021 18:10:15 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 0/6] do not collapse trunkable transports
Date:   Tue, 15 Jun 2021 21:10:07 -0400
Message-Id: <20210616011013.50547-1-olga.kornievskaia@gmail.com>
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

v3:
-- add a new counter to xprt_switch to keep track of transports with
unique addresses
-- control of enforcing the limit is moved into the sunrpc layer
into the function rpc_clnt_test_and_add_xprt
-- after a trunking transport is created if mount request asked for
nconnect connections, create as many as the original/first mount had

Olga Kornievskaia (6):
  SUNRPC keep track of number of transports to unique addresses
  SUNRPC add xps_nunique_destaddr_xprts to xprt_switch_info in sysfs
  NFSv4 introduce max_connect mount options
  SUNRPC enforce creation of no more than max_connect xprts
  NFSv4 add network transport when session trunking is detected
  NFSv4 allow for nconnect value of trunkable transport

 fs/nfs/client.c                      |  2 ++
 fs/nfs/fs_context.c                  |  7 ++++
 fs/nfs/internal.h                    |  2 ++
 fs/nfs/nfs4client.c                  | 50 ++++++++++++++++++++++++++--
 fs/nfs/super.c                       |  2 ++
 include/linux/nfs_fs.h               |  5 +++
 include/linux/nfs_fs_sb.h            |  1 +
 include/linux/sunrpc/clnt.h          |  2 ++
 include/linux/sunrpc/xprtmultipath.h |  1 +
 net/sunrpc/clnt.c                    | 11 +++++-
 net/sunrpc/sysfs.c                   |  4 ++-
 net/sunrpc/xprtmultipath.c           |  1 +
 12 files changed, 84 insertions(+), 4 deletions(-)

-- 
2.27.0

