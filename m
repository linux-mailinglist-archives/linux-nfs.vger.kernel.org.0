Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6080D4BC213
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Feb 2022 22:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbiBRVbF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Feb 2022 16:31:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239780AbiBRVbF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Feb 2022 16:31:05 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB20377C0
        for <linux-nfs@vger.kernel.org>; Fri, 18 Feb 2022 13:30:48 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id n6so17256191qvk.13
        for <linux-nfs@vger.kernel.org>; Fri, 18 Feb 2022 13:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3YqnYcirkMfTuyvz6iCTDxWYSsFvuL9ZojscLhCzLOs=;
        b=F8nQrr0z7Ut/Xzp29DAvdGh1PY+ZWXezUKleKtMjF9IlQgYjxDlP4Y39S1ENFLzVYG
         t04744y1stiWpwzAr6nYYT7M7lNbpIpqUvV7kJFSTethcGUfbkA8rypOBJraGrj8zQSq
         qT/hIx9UrF5/J6FHGG2PmV3c3XVVDiXOUYNzpftodMJ0k4CzASooVv7HABPEmpceOm4j
         q1lK9cCNx1sfWBUA1jhVl26ck8LL7jnQAXlVd50oo7rYIViC7HkDnS+JZBBiBOW7s4oy
         kxvJkli6UCqCxVL8fYQu2N/n6Cfk3beTiUTi4a4o0LjTUNOVTTcO2VKTS/qxMUATzj7y
         eSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3YqnYcirkMfTuyvz6iCTDxWYSsFvuL9ZojscLhCzLOs=;
        b=r0/Zx6US0iMayiaRw0k8QyiEF/7ptWU2AesDMuDzUre2wl+y8pq8zqnvCpmmHL5j73
         c4MJJfTM/N+r/Lh+ZP3b5P3AB/ZMpqlyt9DwiPP39G8XxZbaix4vU+qiBBmcJD/CsTPl
         CdRUzMpWfF3j6QbraQMt+rpziHbj2tGfaTFEKYl0jULW7b3xMZxVpnbZRJdV6FcZl+4t
         t9HkptfEMcyt3oH0r2pp15op7nSc+5bhrT/HoFWNK6VecMLDHDga/mbzAGWiG3hoVGyy
         Sr2UZsWYVPYDTPPv2e0lPy8RXA5MHOi+IfuNbMF0+z7PTVmLwtw3i/8tPG7kgh69GsXA
         B+xw==
X-Gm-Message-State: AOAM531RDeW2xjYjc8FZzqc5gmoQnZGPQAQfv+x54I59yFEAAbPlV6Ij
        7I52kccMyyoZIRi8ERVFGVGiU7IW9w==
X-Google-Smtp-Source: ABdhPJwTiGgCi0gPEN8Fm7DbiltxCeR1M19GFA/8IyWTKShpOHkARA7QHGAdpzZx5Z5kDJSoclBnOg==
X-Received: by 2002:ad4:4ea7:0:b0:42c:b235:aa7 with SMTP id ed7-20020ad44ea7000000b0042cb2350aa7mr7495890qvb.19.1645219846643;
        Fri, 18 Feb 2022 13:30:46 -0800 (PST)
Received: from localhost.localdomain (c-68-56-145-227.hsd1.mi.comcast.net. [68.56.145.227])
        by smtp.gmail.com with ESMTPSA id w22sm26928656qtk.7.2022.02.18.13.30.45
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 13:30:46 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 0/6] Readdir improvements
Date:   Fri, 18 Feb 2022 16:24:18 -0500
Message-Id: <20220218212424.1840077-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The current NFS readdir code will always try to maximise the amount of
readahead it performs on the assumption that we can cache anything that
isn't immediately read by the process.
There are several cases where this assumption breaks down, including
when the 'ls -l' heuristic kicks in to try to force use of readdirplus
as a batch replacement for lookup/getattr.

--
v2: Remove reset of dtsize when NFS_INO_FORCE_READDIR is set
v3: Avoid excessive window shrinking in uncached_readdir case
v4: Track 'ls -l' cache hit/miss statistics
    Improved algorithm for falling back to uncached readdir
    Skip readdirplus when files are being written to
v5: bugfixes
    Skip readdirplus when the acdirmax/acregmax values are low
    Request a full XDR buffer when doing READDIRPLUS

Trond Myklebust (6):
  NFS: Adjust the amount of readahead performed by NFS readdir
  NFS: Simplify nfs_readdir_xdr_to_array()
  NFS: Improve algorithm for falling back to uncached readdir
  NFS: Improve heuristic for readdirplus
  NFS: Don't ask for readdirplus unless it can help nfs_getattr()
  NFSv4: Ask for a full XDR buffer of readdir goodness

 fs/nfs/dir.c           | 214 +++++++++++++++++++++++++++--------------
 fs/nfs/inode.c         |  37 +++----
 fs/nfs/internal.h      |   4 +-
 fs/nfs/nfs3xdr.c       |   7 +-
 fs/nfs/nfs4xdr.c       |   6 +-
 fs/nfs/nfstrace.h      |   1 -
 include/linux/nfs_fs.h |   7 +-
 7 files changed, 173 insertions(+), 103 deletions(-)

-- 
2.35.1

