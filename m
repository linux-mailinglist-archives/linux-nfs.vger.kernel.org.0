Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145BB677FB9
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jan 2023 16:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjAWP2m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Jan 2023 10:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjAWP2k (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Jan 2023 10:28:40 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD402887F
        for <linux-nfs@vger.kernel.org>; Mon, 23 Jan 2023 07:28:30 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id bk15so31395815ejb.9
        for <linux-nfs@vger.kernel.org>; Mon, 23 Jan 2023 07:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arrikto-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r+FrutqSNuV68lqvrrNh7Sr4U3SUrCUehEehb2FWvBU=;
        b=l/RvdiZx97yPnfnrcXAeZruddl2rIVvJFHwf03yiGon9MAWC7QHtZsBX5x4txGCUcC
         iJXAit7OrRoqwUMki/zYmHZX1JbkO6B8MQWhN7XZCV8x4ePMnAS5AdoFfIaM7VCOK2Wh
         5tskng0CwQi521xCojxGC5z2ZJBKfYCB9Y5ldn6RruKTG2nLZC4P1MY4sdcwr6zXvFfS
         dUsJ6jidO4GZbTyYYlbu4HOs4yHpAbZk3eVotDKXIvRWgGpV/ffKHY3+R/smFnY0vfPp
         A6kdGtd3wfv8R9rbp7QUIkyWWb4KQ9WGM4OWvM9eh5Xn+YhIkthG9mNZsOp/Udx1zOwD
         2Wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+FrutqSNuV68lqvrrNh7Sr4U3SUrCUehEehb2FWvBU=;
        b=plM8NGiQpDt5QWky+kQmPMX5ng2sZv9wiCWjUntKCbRFMcJ1SUfiF0WOj49mahRZHm
         TgH7clZiYNK97tTYEJgBdnTjuzEOBcblYOLmsT3HSAPU9DkCExfkARr97V+kJLzwAg1P
         ecjLmC20HpxMYbmemXrtywCAj3S/nIh0YDQ3/gJv9+beFc43Zygwxk5raZ/aY5htDbnp
         JFntdTQ6D/FADbc4KKUg5EBiOwWiLUMEFnajMhTY6RtsVGlSGGkfus4F9AvZPXbG0N4h
         ZxIj9sJYP3HiPXJhitP1BrfgIXQnMEYiPAgBFVfRdg/4I6bUC7i4XJVd3xgrifLlc2/J
         T+SA==
X-Gm-Message-State: AFqh2kqbkZSjRT7YZvhoY6kh7Orat65yr+ImQcCFMfgPaQYL8kgjFUTu
        ApqrNTlpbmm/HSl4e3Ehf5OVH1KJaL4b9RNN
X-Google-Smtp-Source: AMrXdXtE8yIyzqzPfqZux5hb9Zuy1mHJBY5+v3xKMjawW8t9AV+Y63oW8vo+2pTYKRew04TGdf5cxQ==
X-Received: by 2002:a17:906:7156:b0:86d:f880:5195 with SMTP id z22-20020a170906715600b0086df8805195mr25572874ejj.56.1674487708653;
        Mon, 23 Jan 2023 07:28:28 -0800 (PST)
Received: from marvin.internal.lan (193.92.101.37.dsl.dyn.forthnet.gr. [193.92.101.37])
        by smtp.gmail.com with ESMTPSA id 21-20020a170906301500b007c0985aa6b0sm22274876ejz.191.2023.01.23.07.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:28:28 -0800 (PST)
From:   Nikos Tsironis <ntsironis@arrikto.com>
To:     stable@vger.kernel.org
Cc:     bfields@fieldses.org, chuck.lever@oracle.com,
        ntsironis@arrikto.com, linux-nfs@vger.kernel.org,
        trond.myklebust@hammerspace.com
Subject: [PATCH 5.4 0/1] nfsd: Ensure knfsd shuts down when the "nfsd" pseudofs is unmounted
Date:   Mon, 23 Jan 2023 17:28:21 +0200
Message-Id: <20230123152822.868326-1-ntsironis@arrikto.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The bug that upstream commit c6c7f2a84da45 ("nfsd: Ensure knfsd shuts
down when the "nfsd" pseudofs is unmounted") fixes in kernel v5.13
exists in kernel v5.4 too.

That is, knfsd threads are left behind once the nfsd pseudofs is
unmounted, e.g. when the container is killed.

I backported the patch to kernel v5.4, and tested it.

Trond Myklebust (1):
  nfsd: Ensure knfsd shuts down when the "nfsd" pseudofs is unmounted

 fs/nfsd/netns.h     |  6 +++---
 fs/nfsd/nfs4state.c |  8 +-------
 fs/nfsd/nfsctl.c    | 14 ++------------
 fs/nfsd/nfsd.h      |  3 +--
 fs/nfsd/nfssvc.c    | 35 ++++++++++++++++++++++++++++++++++-
 5 files changed, 41 insertions(+), 25 deletions(-)

-- 
2.30.2

