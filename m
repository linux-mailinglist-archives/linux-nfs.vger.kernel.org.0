Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60421479323
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 18:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239528AbhLQRyg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 12:54:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38146 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231992AbhLQRyf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 12:54:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639763675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=ORXQcro20WgfBBYaRJHM0boVXW2sM4chWAKFEsLwHOE=;
        b=f0tnpLvBo9fUFEAjSm3Ctmi2n0D0gC5u5C08qP7mWbOTsWO5yRLLZxcMLO5Rf3Qt0iRGAy
        Q02sEtsiNWZyGFNtofNzwlzKNTL2e0wRXxAg1v4q01dighKkuj5zVe14tA7nexjnO/1lOD
        xTPsWUgtcverZHf1j+pKey5tjaGa48U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-UZXx-3xyOlO203MmvQRrvA-1; Fri, 17 Dec 2021 12:54:32 -0500
X-MC-Unique: UZXx-3xyOlO203MmvQRrvA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 488B010144E0;
        Fri, 17 Dec 2021 17:54:31 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4912D1037F39;
        Fri, 17 Dec 2021 17:54:27 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [PATCH v2 0/4] Cleanups for NFS fscache and convert from dfprintk to trace events
Date:   Fri, 17 Dec 2021 12:54:21 -0500
Message-Id: <1639763665-4917-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a second version of a series posted previously [1]
These ran into conflicts [2] with dhowell's fscache-rewrite patches [3],
and they probably should go in his fscache-rewrite.  Note that a couple
patches have been either dropped or folded into other patches, so there's
only 4 patches left from the original 7.

The patches are also at:
https://github.com/DaveWysochanskiRH/kernel/tree/fscache-rewrite-plus-nfs

Changes since v1
- Rebase on top of dhowells fscache-rewrite (v3) and Anna's linux-next to
avoid future conflicts
- Fold in "NFS: Use nfs_i_fscache() consistently within NFS fscache code"
to other patches
- Drop "NFS: Convert NFS fscache enable/disable dfprintks to tracepoints"
since we can use fscache trace events
- Combine the last two patches into one:
NFS: Remove remaining dfprintks related to fscache cookies
NFS: Remove remaining usages of NFSDBG_FSCACHE
- Dropped Signed-off-by and Reviewed-by tags due to rebase

[1] https://marc.info/?l=linux-nfs&m=163718744111509&w=2
[2] https://marc.info/?l=linux-nfs&m=163974120915758&w=2
[3] https://marc.info/?l=linux-nfs&m=163967071213398&w=2

Dave Wysochanski (4):
  NFS: Cleanup usage of nfs_inode in fscache interface and handle i_size
    properly
  NFS: Rename fscache read and write pages functions
  NFS: Replace dfprintks with tracepoints in fscache read and write page
    functions
  NFS: Remove remaining dfprintks related to fscache and remove
    NFSDBG_FSCACHE

 fs/nfs/fscache.c            | 53 +++++++++-----------------
 fs/nfs/fscache.h            | 45 ++++++++++------------
 fs/nfs/nfstrace.h           | 91 +++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/read.c               |  4 +-
 include/uapi/linux/nfs_fs.h |  2 +-
 5 files changed, 130 insertions(+), 65 deletions(-)

-- 
1.8.3.1

