Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A47747959E
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 21:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240868AbhLQUnM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 15:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240874AbhLQUnI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 15:43:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8C4C061401
        for <linux-nfs@vger.kernel.org>; Fri, 17 Dec 2021 12:43:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBD57B82799
        for <linux-nfs@vger.kernel.org>; Fri, 17 Dec 2021 20:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530B4C36AE2;
        Fri, 17 Dec 2021 20:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639773785;
        bh=FGiZErYZZ069aVtx1UN4NABMOrhS0+u46NQecYmm+F0=;
        h=From:To:Cc:Subject:Date:From;
        b=EOy6zqZlDox366CpLkteSIpkHfMQhM98QBJjMfbLfXlSqK9QJUJXYvfOXbCDdusny
         AaF2jLkA/PiqbIWaOIgsEXhiNkkTLKgDwezpujMGjRSGIaSZt7s6tPD0+bm5IyIfTz
         QVeeGNMvpiRn7Dbx24fHF74ZgM/80PlAREkQqqVjbQBCGxkVDC5xcsjcv9HDsvzyQC
         aURgXaQ8YjSDua9Jsuj4kTufmIUCV+ieNkvid+xigyHpQ/u0o/HYv0vRydQGkWd1hH
         HdoxFuMoW1sW0dJTLh0lYKNw8CxwVjxPNYLB9drMBAcOiu4Y8Lwua6bmazsFu3kLMx
         J4r38kr1St75w==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/5] Support case insensitive filesystems in NFSv4
Date:   Fri, 17 Dec 2021 15:36:53 -0500
Message-Id: <20211217203658.439352-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Add support for detecting an export of a case insensitive filesystem in
NFSv4. If that is the case, then we need to adjust the dentry caching
and invalidation rules to ensure that we don't inadvertently end up
caching other case folded aliases after an operation that results in a
directory entry name change.

Trond Myklebust (5):
  NFSv4: Add some support for case insensitive filesystems
  NFSv4: Just don't cache negative dentries on case insensitive servers
  NFS: Invalidate negative dentries on all case insensitive directory
    changes
  NFS: Add a helper to remove case-insensitive aliases
  NFS: Fix the verifier for case sensitive filesystem in
    nfs_atomic_open()

 fs/nfs/dir.c              | 41 +++++++++++++++++++++++++++++++++------
 fs/nfs/internal.h         |  1 +
 fs/nfs/nfs4proc.c         | 13 +++++++++++--
 fs/nfs/nfs4xdr.c          | 40 ++++++++++++++++++++++++++++++++++++++
 include/linux/nfs_fs_sb.h |  2 ++
 include/linux/nfs_xdr.h   |  2 ++
 6 files changed, 91 insertions(+), 8 deletions(-)

-- 
2.33.1

