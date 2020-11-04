Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191232A699D
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Nov 2020 17:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbgKDQ1D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 11:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgKDQ1D (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Nov 2020 11:27:03 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7C0C0613D3
        for <linux-nfs@vger.kernel.org>; Wed,  4 Nov 2020 08:27:02 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id p12so5248870qtp.7
        for <linux-nfs@vger.kernel.org>; Wed, 04 Nov 2020 08:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vdvkrsiUfa3kJXoUDQKjJ53EohVCxJvQumeRMRWjiEg=;
        b=PG6FfNFHou6y3zNAH6paO8Lvt6ZzZbc8YL7TyNolcCfOQJm4RNaKQcuHEFbeqa8lKI
         n9fzy3TAPXe5NuyY7mUZc8itEWHJ3vn92FecsZ8LAqf2DXxURv/NPo8O7n5jsK/UU8ZI
         yYUz44og8MCoV4977Yo9b2DZEkbrdl90QTV+xP22mNkdyuleU0h0M6Q2INct+m3wWlil
         BawLmIcTxpSm4dSabQsu+h8Zk2lI370H4QhVCxNdu6Ys3HhnQQpdErxK5OgSmpthRwa3
         Y96SKZCGMfMFxpuDV4PMK6mkvj/+QKvoQkWCKwcr+45SM6pE5NyyhOb0j5UWq2n9iMXb
         TTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vdvkrsiUfa3kJXoUDQKjJ53EohVCxJvQumeRMRWjiEg=;
        b=YlsqXG3WSySf9EQjGaIwQTt6BXRjlDRq6rxfWMgrzgWNF+urDI3Nr/B3d+ilXKudqU
         VGIxcslKoc2yP+1NKLpc+QDgQ6nDDG/qJsr81C3L21QcxzMmjio/dwMjgUQZ/TiK2swT
         jhLVpdi0ud+9P0XXhPyUeT/kl32pRzreu7XNS2oyh2Kjd0gaNzL80IfAu1wkXq8adPf7
         u5Yjak+UpLDDyqMxAxTaT/Pk321BClkNZhIYqPrgTmphbCiYbnbCxIC9jJAjaTVgVg5q
         4LdbWnRCZCJTAjY3SdX4g3f1y5TRbXTz4X76cj0NTUpF81E8p60aq2Tis5Z75T4i9BRM
         k0Uw==
X-Gm-Message-State: AOAM531qqRDvi/XRGoTO/HNxD8NPBk+67i3n9kXyiYsIhtfjTkol2a9l
        iHq6r5xvuI+gkcyBdvDKAeMyarkaU7p0
X-Google-Smtp-Source: ABdhPJzLUoS0n1K2Yq4An0rYOL3LuIz+f6yCLtENOnI3weY4TRwOR95bpU5JOh4S+UBssyiWm8hQwA==
X-Received: by 2002:ac8:590c:: with SMTP id 12mr12387055qty.28.1604507220884;
        Wed, 04 Nov 2020 08:27:00 -0800 (PST)
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id g78sm2896924qke.88.2020.11.04.08.26.59
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:26:59 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 00/17] Readdir enhancements
Date:   Wed,  4 Nov 2020 11:16:21 -0500
Message-Id: <20201104161638.300324-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The following patch series performs a number of cleanups on the readdir
code.
It also adds support for 1MB readdir RPC calls on-the-wire, and modifies
the caching code to ensure that we cache the entire contents of that
1MB call (instead of discarding the data that doesn't fit into a single
page).

v2: Fix the handling of the NFSv3/v4 directory verifier
v3: Optimise searching when the readdir cookies are seen to be ordered

Trond Myklebust (17):
  NFS: Ensure contents of struct nfs_open_dir_context are consistent
  NFS: Clean up readdir struct nfs_cache_array
  NFS: Clean up nfs_readdir_page_filler()
  NFS: Clean up directory array handling
  NFS: Don't discard readdir results
  NFS: Remove unnecessary kmap in nfs_readdir_xdr_to_array()
  NFS: Replace kmap() with kmap_atomic() in nfs_readdir_search_array()
  NFS: Simplify struct nfs_cache_array_entry
  NFS: Support larger readdir buffers
  NFS: More readdir cleanups
  NFS: nfs_do_filldir() does not return a value
  NFS: Reduce readdir stack usage
  NFS: Cleanup to remove nfs_readdir_descriptor_t typedef
  NFS: Allow the NFS generic code to pass in a verifier to readdir
  NFS: Handle NFS4ERR_NOT_SAME and NFSERR_BADCOOKIE from readdir calls
  NFS: Improve handling of directory verifiers
  NFS: Optimisations for monotonically increasing readdir cookies

 fs/nfs/client.c         |   4 +-
 fs/nfs/dir.c            | 629 +++++++++++++++++++++++++---------------
 fs/nfs/inode.c          |   7 -
 fs/nfs/internal.h       |   6 -
 fs/nfs/nfs3proc.c       |  35 ++-
 fs/nfs/nfs4proc.c       |  40 +--
 fs/nfs/proc.c           |  18 +-
 include/linux/nfs_fs.h  |   9 +-
 include/linux/nfs_xdr.h |  17 +-
 9 files changed, 459 insertions(+), 306 deletions(-)

-- 
2.28.0

