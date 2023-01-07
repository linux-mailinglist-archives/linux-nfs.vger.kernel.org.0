Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77C56610B5
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Jan 2023 19:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjAGSJY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Sat, 7 Jan 2023 13:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjAGSJY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 7 Jan 2023 13:09:24 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29173592C;
        Sat,  7 Jan 2023 10:09:20 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id a16so4693844qtw.10;
        Sat, 07 Jan 2023 10:09:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8JdubVnfWVZT3REzrdZPER7Eknzu9xZpR/N3zlHFZY=;
        b=rCSsG/piXkT0/CXvIv6MDPzv8kNQ0uNjmmXYB7QJWroLQ92QC7A+ISnljvxZ7mk+B1
         vWEpmgGEao7jkm8tEB/mrZzaZZR5/MLny6tz5ivYpP9INxrb7c/2Y8wvL+dVlJlmf331
         w4Belciqz2fwe9OTsnVj6/0OKhKndtcotu3ohrKBoJet1VYuRZlou2CPugQtkqesqymu
         urNQCixZD0JFwXq/jYW52dRyW/ArrcWE0UvOgh/esqxgLl4nkqjsfJOoIlOf9prT/cir
         qAa54ylQs1ck8dBsgiVe2hHDRSbqr8vRLlJJ2aQ/taEC+nxxopUj05psbIo9Z5S8L/c2
         bNUg==
X-Gm-Message-State: AFqh2kqJkZX/thrduVBfbWfErdCBCQx5pa7m6E3UIY8BmYHLNMB9SqFp
        ZTRu68vQ1kyCqiGdZ7BL84s0iN9sWQ==
X-Google-Smtp-Source: AMrXdXvyiJ3+HD+/WZvlaqYDFzdFIihPkiMqy6z2EuO1ePL8XVX8aAqZa0b9fuq321TNWHdcIfJPRQ==
X-Received: by 2002:a05:622a:4810:b0:3a5:4e34:fafe with SMTP id fb16-20020a05622a481000b003a54e34fafemr94210668qtb.68.1673114959868;
        Sat, 07 Jan 2023 10:09:19 -0800 (PST)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id 7-20020a05620a040700b006fc8fc061f7sm2471973qkp.129.2023.01.07.10.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 10:09:19 -0800 (PST)
Message-ID: <79e77f294451933c2264d8e149d45cc546e31066.camel@kernel.org>
Subject: [GIT PULL] Please pull NFS client bugfixes
From:   Trond Myklebust <trondmy@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Sat, 07 Jan 2023 13:09:18 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

The following changes since commit 7fd461c47c6cfab4ca4d003790ec276209e52978:

  NFSv4.2: Change the default KConfig value for READ_PLUS (2022-12-10 13:24:59 -0500)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.2-2

for you to fetch changes up to 5e9a7b9c2ea18551759833146a181b14835bfe39:

  NFS: Fix up a sparse warning (2023-01-01 20:17:26 -0500)

Thanks!
  Trond

----------------------------------------------------------------
NFS client fixes for Linux 6.2

Highlights include:

Bugfixes
- Fix a race in the RPCSEC_GSS upcall code that causes hung RPC calls
- Fix a broken coalescing test in the pNFS file layout driver
- Ensure that the access cache rcu path also applies the login test
- Fix up for a sparse warning

----------------------------------------------------------------
Chengen Du (1):
      NFS: Judge the file access cache's timestamp in rcu path

Olga Kornievskaia (1):
      pNFS/filelayout: Fix coalescing test for single DS

Trond Myklebust (1):
      NFS: Fix up a sparse warning

minoura makoto (1):
      SUNRPC: ensure the matching upcall is in-flight upon downcall

 fs/nfs/dir.c                       |  7 ++++++-
 fs/nfs/filelayout/filelayout.c     |  8 ++++++++
 include/linux/sunrpc/rpc_pipe_fs.h |  5 +++++
 net/sunrpc/auth_gss/auth_gss.c     | 19 +++++++++++++++++--
 4 files changed, 36 insertions(+), 3 deletions(-)

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


