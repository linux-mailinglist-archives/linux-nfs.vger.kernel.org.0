Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B38964B88D
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Dec 2022 16:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbiLMPf4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 13 Dec 2022 10:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236021AbiLMPfy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Dec 2022 10:35:54 -0500
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A561F610;
        Tue, 13 Dec 2022 07:35:53 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-417b63464c6so96892487b3.8;
        Tue, 13 Dec 2022 07:35:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWfK5TG77qY0hvED3ahJWc5TqBesFFZhoxEpetGC3XI=;
        b=B2CGibJiLONOq2O9LyYVdhrSYzdgrvzGxJhK/CJo0IXXijuWWlk6qN9DcvasNg/Ion
         msBX3OxPEF3t3M2Th5ZXaMdLy+f0QK+2cAzLcCWW9gdeGZt5txjdP/0Z3RYEkxdxOp06
         yZnvygnOx/o5jMiUnop5o+Q+BpJhRUqJ0L+D41PnLYMoA9LRTULGJ43cxiELxXEWjF0k
         2vcAhi9+vNigSELJN/6k/Isto++NeeS66u9DuZrXfoDlZQ0DwyWfstcYuLVlsZZA7Taq
         9e/pBNnwcMH5X+aPEE9S7ARiFKuVczo6i+IEZ1RkMnD9yL31rcfFp9JAERCsYQfnLDo5
         qXag==
X-Gm-Message-State: ANoB5pkqe9pdsAUvbpme3L1efMZKh/qiLP9ZCwOgJmF9G5EjrePJbbmM
        XgFhx+1JLSidYcPQMxwYTZzO9G8c0A==
X-Google-Smtp-Source: AA0mqf5f8f9Tb3rsYVE9luOlaFohhS2iNk4H5OApcqiVZgHP4KIp44px23bykHw4rYa7IqMOtBUuTQ==
X-Received: by 2002:a05:7508:658d:b0:47:22a6:6047 with SMTP id dn13-20020a057508658d00b0004722a66047mr1531315gbb.12.1670945751972;
        Tue, 13 Dec 2022 07:35:51 -0800 (PST)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id o18-20020a05620a111200b006fc92cf4703sm7721916qkk.132.2022.12.13.07.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 07:35:51 -0800 (PST)
Message-ID: <a91ef5f6937333955610acebf92c8efb2f9b8391.camel@kernel.org>
Subject: [GIT PULL] Please pull NFS client updates
From:   Trond Myklebust <trondmy@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 13 Dec 2022 10:35:50 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

The following changes since commit b7b275e60bcd5f89771e865a8239325f86d9927d:

  Linux 6.1-rc7 (2022-11-27 13:31:48 -0800)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.2-1

for you to fetch changes up to 7fd461c47c6cfab4ca4d003790ec276209e52978:

  NFSv4.2: Change the default KConfig value for READ_PLUS (2022-12-10 13:24:59 -0500)

Cheers,
  Trond

----------------------------------------------------------------
NFS client updates for Linux 6.2

Highlights include:

Bugfixes
- Fix a NULL pointer dereference in the mount parser
- Fix a memory stomp in decode_attr_security_label
- Fix a credential leak in _nfs4_discover_trunking()
- Fix a buffer leak in rpcrdma_req_create()
- Fix a leaked socket in rpc_sockname()
- Fix a deadlock between nfs4_open_recover_helper() and delegreturn
- Fix an Oops in nfs_d_automount()
- Fix a potential race in nfs_call_unlink()
- Multiple fixes for the open context mode
- NFSv4.2 READ_PLUS fixes
- Fix a regression in which small rsize/wsize values are being forbidden
- Fail client initialisation if the NFSv4.x state manager thread can't run
- avoid spurious warning of lost lock that is being unlocked.
- Ensure the initialisation of struct nfs4_label

Features and cleanups
- Trigger the "ls -l" readdir heuristic sooner
- Clear the file access cache upon login to ensure supplementary group
  info is in sync between the client and server
- pnfs: Fix up the logging of layout stateids
- NFSv4.2: Change the default KConfig value for READ_PLUS
- Use sysfs_emit() instead of scnprintf() where appropriate

----------------------------------------------------------------
Anna Schumaker (4):
      NFSv4.2: Set the correct size scratch buffer for decoding READ_PLUS
      NFSv4.2: Fix up READ_PLUS alignment
      NFS: Allow very small rsize & wsize again
      NFSv4.2: Change the default KConfig value for READ_PLUS

Benjamin Coddington (1):
      NFS: Trigger the "ls -l" readdir heuristic sooner

ChenXiaoSong (2):
      NFS: make sure open context mode have FMODE_EXEC when file open for exec
      NFSv4: check FMODE_EXEC from open context mode in nfs4_opendata_access()

Hawkins Jiawei (1):
      nfs: fix possible null-ptr-deref when parsing param

NeilBrown (1):
      NFS: avoid spurious warning of lost lock that is being unlocked.

Trond Myklebust (11):
      NFS: Clear the file access cache upon login
      NFSv4.2: Clear FATTR4_WORD2_SECURITY_LABEL when done decoding
      NFSv4.2: Always decode the security label
      NFSv4.2: Fix a memory stomp in decode_attr_security_label
      NFSv4.2: Fix initialisation of struct nfs4_label
      NFSv4: Fix a credential leak in _nfs4_discover_trunking()
      NFSv4: Fix a deadlock between nfs4_open_recover_helper() and delegreturn
      NFS: Fix an Oops in nfs_d_automount()
      NFS: Fix a race in nfs_call_unlink()
      NFS4.x/pnfs: Fix up logging of layout stateids
      NFSv4.x: Fail client initialisation if state manager thread can't run

Wang ShaoBo (1):
      SUNRPC: Fix missing release socket in rpc_sockname()

Zhang Xiaoxu (1):
      xprtrdma: Fix regbuf data not freed in rpcrdma_req_create()

ye xingchen (2):
      NFS: use sysfs_emit() to instead of scnprintf()
      fs: nfs: sysfs: use sysfs_emit() to instead of scnprintf()

 fs/nfs/Kconfig              |  8 +++----
 fs/nfs/dir.c                | 32 +++++++++++++++++++++++--
 fs/nfs/fs_context.c         |  6 +++++
 fs/nfs/inode.c              |  3 ++-
 fs/nfs/internal.h           |  6 ++---
 fs/nfs/namespace.c          |  4 ++--
 fs/nfs/nfs42xdr.c           |  9 +++----
 fs/nfs/nfs4_fs.h            |  1 +
 fs/nfs/nfs4file.c           | 12 ++++------
 fs/nfs/nfs4proc.c           | 57 +++++++++++++++++++++++++--------------------
 fs/nfs/nfs4state.c          |  5 +++-
 fs/nfs/nfs4trace.h          |  4 ++--
 fs/nfs/nfs4xdr.c            | 22 +++++++----------
 fs/nfs/sysfs.c              |  2 +-
 fs/nfs/unlink.c             |  1 +
 include/linux/nfs_fs.h      |  1 +
 net/sunrpc/clnt.c           |  2 +-
 net/sunrpc/xprtrdma/verbs.c |  2 +-
 18 files changed, 108 insertions(+), 69 deletions(-)

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


