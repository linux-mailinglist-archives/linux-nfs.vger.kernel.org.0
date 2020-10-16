Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2EF290571
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Oct 2020 14:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407809AbgJPMp7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 16 Oct 2020 08:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407808AbgJPMp4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 16 Oct 2020 08:45:56 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504F7C0613D4
        for <linux-nfs@vger.kernel.org>; Fri, 16 Oct 2020 05:45:56 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id hk7so1451247pjb.2
        for <linux-nfs@vger.kernel.org>; Fri, 16 Oct 2020 05:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O1evu/uCI+QRNY7SsK/no8njk1hcUqNItCkuJRC3dLc=;
        b=xCglPQVh3uc2/EcXbuONJAMpl3eRtAkldgrib6XbBiKmiqFboP4mrxqB3XKvmyML2t
         L9QK5x65jCp7F9T7lv7UfCAznFLwlyTRfJt2fM03kdhw1JI6DH6TVr5Lx6nBw5nljyTN
         OdCnpsw2/yC6Ty1P8Muc2ds3bUZXgimXWmXi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O1evu/uCI+QRNY7SsK/no8njk1hcUqNItCkuJRC3dLc=;
        b=cGQnVoHrWvPBy/tsyL/QYMd8+zzLqy5JghzYuWX975Mfqc7vthdf4kaZWvKMOWhOYR
         Pg+xR7EA0VA+3DAJdDKugPrP7P3x6NB9qd39Ejt/u1TptM2VdkJ21trfEvcViIOGIv/A
         bVnJt7RsWBObJvcDVMjo0KvbvbHRQS/OQG8tQtPmFe1w1ZmCTAmHeZpWvKi3FuNR3dQZ
         MuWvYfP0DkE3ZcbCmkQ9wiRZrcdzIMXzPofrtC2Y0B1aaTbTrLcNQYbDbhcD0C3DOumB
         SUGB7CeL+YqwvRdWYVjuJjRVCzSDv+qCJlx2Kt0FmdBpQcCYKp5U5RAA/k3JG47MrLGa
         xZ3Q==
X-Gm-Message-State: AOAM533mquYRtksKNM6ynXwzc2MeJhY3A0AOfbY1s/LE+0ODS81ugb+/
        rNXA42tKWTlBIaui4+E4NEeyQw==
X-Google-Smtp-Source: ABdhPJxo4t9bHKXFNNwhW4adl1rskGMnIohne6crnWi1t7gHuVBHRDAwqYw4qmZN/etpvhxC+f1MSw==
X-Received: by 2002:a17:90a:318d:: with SMTP id j13mr3920577pjb.209.1602852355655;
        Fri, 16 Oct 2020 05:45:55 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id q123sm2906732pfq.56.2020.10.16.05.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 05:45:54 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 0/3] NFS User Namespaces with new mount API
Date:   Fri, 16 Oct 2020 05:45:47 -0700
Message-Id: <20201016124550.10739-1-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patchset adds some functionality to allow NFS to be used from
NFS namespaces (containers).

Changes since v1:
  * Added samples

Sargun Dhillon (3):
  NFS: Use cred from fscontext during fsmount
  samples/vfs: Split out common code for new syscall APIs
  samples/vfs: Add example leveraging NFS with new APIs and user
    namespaces

 fs/nfs/client.c                        |   2 +-
 fs/nfs/flexfilelayout/flexfilelayout.c |   1 +
 fs/nfs/nfs4client.c                    |   2 +-
 samples/vfs/.gitignore                 |   2 +
 samples/vfs/Makefile                   |   5 +-
 samples/vfs/test-fsmount.c             |  86 +-----------
 samples/vfs/test-nfs-userns.c          | 181 +++++++++++++++++++++++++
 samples/vfs/vfs-helper.c               |  43 ++++++
 samples/vfs/vfs-helper.h               |  55 ++++++++
 9 files changed, 289 insertions(+), 88 deletions(-)
 create mode 100644 samples/vfs/test-nfs-userns.c
 create mode 100644 samples/vfs/vfs-helper.c
 create mode 100644 samples/vfs/vfs-helper.h

-- 
2.25.1

