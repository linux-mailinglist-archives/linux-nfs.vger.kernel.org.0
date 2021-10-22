Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0C0437B8E
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 19:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbhJVRNq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 13:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbhJVRNd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 13:13:33 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77444C061764
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 10:11:15 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id bp7so5119449qkb.12
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 10:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L6XwBM38V3VuOd8aYUJ8rarWPGROhSzF8Qguldyjjig=;
        b=cM+9rw9GCDkJY0uQGKbnp+EbMjRsCwYQFQ6bWNVzeu0/7lQN47JlP7MaASXMtMEaul
         mDy+8z3pNN1edOLclvHuUgnpscQIhVgpzY2OvIvoipZ5aSmeHAyp7ZR4xSTJqvvceDFd
         maIDKLvjJRkcsY0827+xUn8lE2KncXdqmbTyDQPEmQvw6DjnWM8Z+IYujQopOu3dFzH1
         tAvAA/TpsZCmeXS/6H2DLU2q+H4LOGwIji46p+43fk63q4gpDsXTVCpsyQzEbumkiyZC
         jZ6d3ymoC5G+Y3GnqZtyx5bEVeaFRSrgKmT5M975tzJCUrq65j3QRP/me5iJQE3JJdYN
         Hx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=L6XwBM38V3VuOd8aYUJ8rarWPGROhSzF8Qguldyjjig=;
        b=0Ul8ZQ8Mcg5qIxKqiFa0e6Ee8xHedPJZTWk26JsUET5rL6wknbX8AdWNOCYTXDnR8r
         pY3FEy1oTGZpAyThRvPqiC4z7SXouSD4XY4M7biTUhoq7PfKv6PEJ9T/sSINvf5YzLk4
         QjL3hSoNTl6weh/mXVR+uIy13TsskKMAkpt3Vdp4xgXmYC0mOLEgwcUXL4431iC5MKma
         /GBt7RiCeZCAY0Be8ftkUAIM/YRdoV1VqVSpDTiP7gCn4FQIYDLfRl4rWcjsQHk8ns8N
         bAbeK2zMjtBsJitkk6zfOZWhP6xowAwGjCXQPxg8sJy59MzwRvw9wxFq7AeJPAdGLtAg
         2jQA==
X-Gm-Message-State: AOAM531WGrQmPhzuPnsTPTvut5PSlRZM+I2FYoM1eX4KLgnpO18wtTao
        FM7dPeseVr+k9zwAmuINO/gPvuiPH5c=
X-Google-Smtp-Source: ABdhPJymBEAP7giJm2QuB7hB4Kg3l7tJbGpXIjAClL7EM54ZT5xARwuD9TkZeUZeKYFun0gF3oF0xg==
X-Received: by 2002:a37:7ce:: with SMTP id 197mr1094470qkh.59.1634922674375;
        Fri, 22 Oct 2021 10:11:14 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id s22sm4484586qko.135.2021.10.22.10.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 10:11:14 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 00/14] NFS: Clean up nfs4_label allocation
Date:   Fri, 22 Oct 2021 13:10:59 -0400
Message-Id: <20211022171113.16739-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

In the functions where we want a label we also tend to allocate a
struct fattr, which happens to have a field for labels that goes unused
in most cases. Let's just allocate the label at the same time as the
fattr if we know we'll want one. This lets us pass fattrs around by
themselves, and also remove the struct nfs4_label argument from
functions like nfs3_proc_getattr().

Changes in v2:
- Rebased on v5.15-rc6

Thoughts?
Anna

Anna Schumaker (14):
  NFS: Create a new nfs_alloc_fattr_with_label() function
  NFS: Remove the nfs4_label from the nfs_entry struct
  NFS: Remove the nfs4_label from the nfs4_create_res struct
  NFS: Remove the nfs4_label from the nfs4_link_res struct
  NFS: Remove the label from the nfs4_lookup_res struct
  NFS: Remove the nfs4_label from the nfs4_lookupp_res struct
  NFS: Remove the f_label from the nfs4_opendata and nfs_openres
  NFS: Remove the nfs4_label from the nfs4_getattr_res
  NFS: Remove the nfs4_label from the nfs_setattrres
  NFS: Remove the nfs4_label argument from nfs_instantiate()
  NFS: Remove the nfs4_label argument from nfs_add_or_obtain()
  NFS: Remove the nfs4_label argument from nfs_fhget()
  NFS: Remove the nfs4_label argument from nfs_setsecurity
  NFS: Remove the nfs4_label argument from decode_getattr_*() functions

 fs/nfs/client.c         |   2 +-
 fs/nfs/dir.c            |  66 ++++++----------
 fs/nfs/export.c         |  44 +++--------
 fs/nfs/getroot.c        |  21 ++---
 fs/nfs/inode.c          |  59 +++++++-------
 fs/nfs/internal.h       |   9 ---
 fs/nfs/namespace.c      |   3 +-
 fs/nfs/nfs3proc.c       |  10 +--
 fs/nfs/nfs4_fs.h        |   4 +-
 fs/nfs/nfs4file.c       |   5 +-
 fs/nfs/nfs4proc.c       | 165 +++++++++++++---------------------------
 fs/nfs/nfs4xdr.c        |  43 +++++------
 fs/nfs/proc.c           |  14 ++--
 include/linux/nfs_fs.h  |  23 ++++--
 include/linux/nfs_xdr.h |  16 +---
 15 files changed, 180 insertions(+), 304 deletions(-)

-- 
2.33.1

