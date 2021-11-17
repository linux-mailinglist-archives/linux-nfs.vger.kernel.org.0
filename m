Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F04455038
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Nov 2021 23:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241081AbhKQWUb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Nov 2021 17:20:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48997 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235740AbhKQWU3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Nov 2021 17:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637187449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=baF2NB2dsezJEIAIv+cZAzMxoQIAWqc6cGMeSZcsMUU=;
        b=X8VtKTy63fS1aS0LhWtLPj2WKWgQJhGm8iDimLwI0EjsY49198XbsLXqSMxjARI6vslVpF
        iCJvAIUeI2o6AVFVexGpyF1i2D0YRoVQJqIFmfXJgsovdLH9ef4MBv66hYtGryJ11kaJNa
        9yCwu6Sc9w+isfAS8f8d6s/Pfdt+usw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-IIJzNNiSNqWZKC0-FE0r-A-1; Wed, 17 Nov 2021 17:17:26 -0500
X-MC-Unique: IIJzNNiSNqWZKC0-FE0r-A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D21BA180831B;
        Wed, 17 Nov 2021 22:17:24 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.32.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2070460657;
        Wed, 17 Nov 2021 22:17:20 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [PATCH 0/7] Cleanups for NFS fscache and convert from dfprintk to trace events
Date:   Wed, 17 Nov 2021 17:17:11 -0500
Message-Id: <1637187438-18858-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The first 3 patches are cleanups and refactorings of the NFS fscache code.
The last 4 patches convert dfprintks to trace events in the NFS fscache code.
These patches were built / tested on 5.16.0-rc1.

Dave Wysochanski (7):
  NFS: Use nfs_i_fscache() consistently within NFS fscache code
  NFS: Cleanup usage of nfs_inode in fscache interface and handle i_size
    properly
  NFS: Rename fscache read and write pages functions
  NFS: Convert NFS fscache enable/disable dfprintks to tracepoints
  NFS: Replace dfprintks with tracepoints in fscache read and write page
    functions
  NFS: Remove remaining dfprintks related to fscache cookies
  NFS: Remove remaining usages of NFSDBG_FSCACHE

 fs/nfs/fscache-index.c      |   2 -
 fs/nfs/fscache.c            | 106 ++++++++++++++++----------------------------
 fs/nfs/fscache.h            |  33 +++++++-------
 fs/nfs/nfstrace.h           | 103 ++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/read.c               |   6 +--
 include/uapi/linux/nfs_fs.h |   2 +-
 6 files changed, 162 insertions(+), 90 deletions(-)

-- 
1.8.3.1

