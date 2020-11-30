Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B212C9079
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 23:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgK3WEC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 17:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgK3WEC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 17:04:02 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F37C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 14:03:22 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id u4so12461166qkk.10
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 14:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+BRei2E7Nvobh7kFz2MVHgmPHzHXWzwfZ7PzmhWpKCU=;
        b=AEmiasZqnyG25y++J5bXUPltLqgUvmhT9bCMjBQFRYYbMRM0mwJTsokRE9Om9JAApe
         vS9/UAxDTL3GUZYCR9TrJUZYQuvfnNDxIzHMh2X9ma6PcJIE7sI4lZXZ/shEbuNt5ogv
         CxHAmpscLyGT1x/Ym0XZmB78ZlG7yegEdhyRM1IcINS2X2biaIRhEdE5nh9LGV68ZdR2
         uTH4O2nNhCF59rA+os3+Te9Ol+fBSrT7AZZJjrNj1HOr6yt8rPVbAsCG/WifJIHsRONa
         p4zd+vHdGgW8DUIchLWuJ7H0Rn9BWImhhNpu7m84LvdA3/DEibVTFjhgNfwTpsmKQXz1
         Svzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+BRei2E7Nvobh7kFz2MVHgmPHzHXWzwfZ7PzmhWpKCU=;
        b=B1pzeo9ZPlGaPkE+XPgsDMcgccbTPxCRnYNlM+K2sX9uLSYoqssyUqTEEgrkSroJl2
         KZO2umpXegE0JQ8sFduxXv6h4Lef3HyCHQPl0iV0Z25BvN8bows+wOUZrZ1OpdzZGcpj
         lnVSCjWL6RSP5OmpfNIIQn0f7fE1A8gBJoeFSnnGyX7ZDvcUu1fi7iShgGYHFZI5a5y0
         7KzHPPc4P68uiXkK47ly5ejU0DMYqZMya27tFGxthfWyS21h85HhkBpP/3f0pGNvkcXD
         jMI+M31GoKWb5JNVWdMRK7tfGgxNZgLvOTTef0ehiBBuSNSrSqLmkdiggTBnUnItM1OQ
         q0sw==
X-Gm-Message-State: AOAM532VeiaPmYuKI7A+ivmuhJ2ubEWiiG/c2g5Fvy0cg/2+1PgbITZn
        eFoTMDyNm1roeXh/NZ1GY+zl1/dNmw==
X-Google-Smtp-Source: ABdhPJylZfvkxmlMcKib7+bTkgNyKn5qbSk0OhZpFeoWYnZsq/3i5XZC54WH331xaSWwsq3NWplyDA==
X-Received: by 2002:a37:4796:: with SMTP id u144mr25609148qka.235.1606773801349;
        Mon, 30 Nov 2020 14:03:21 -0800 (PST)
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id q62sm17642886qkf.86.2020.11.30.14.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 14:03:20 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/6] Patches to support NFS re-exporting
Date:   Mon, 30 Nov 2020 17:03:13 -0500
Message-Id: <20201130220319.501064-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

These patches fix a number of issues that Hammerspace has hit when doing
re-exporting of NFS.

- v2: Rebased on top of cel-next.

Jeff Layton (3):
  nfsd: add a new EXPORT_OP_NOWCC flag to struct export_operations
  nfsd: allow filesystems to opt out of subtree checking
  nfsd: close cached files prior to a REMOVE or RENAME that would
    replace target

Trond Myklebust (3):
  exportfs: Add a function to return the raw output from fh_to_dentry()
  nfsd: Fix up nfsd to ensure that timeout errors don't result in ESTALE
  nfsd: Set PF_LOCAL_THROTTLE on local filesystems only

 Documentation/filesystems/nfs/exporting.rst | 52 +++++++++++++++++++++
 fs/exportfs/expfs.c                         | 32 +++++++++----
 fs/nfs/export.c                             |  2 +
 fs/nfsd/export.c                            |  6 +++
 fs/nfsd/nfs3xdr.c                           |  7 ++-
 fs/nfsd/nfsfh.c                             | 30 ++++++++++--
 fs/nfsd/nfsfh.h                             |  2 +-
 fs/nfsd/vfs.c                               | 29 ++++++++----
 include/linux/exportfs.h                    | 10 ++++
 9 files changed, 146 insertions(+), 24 deletions(-)

-- 
2.28.0

