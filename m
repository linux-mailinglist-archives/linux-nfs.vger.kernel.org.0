Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77E7425FDE
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Oct 2021 00:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbhJGWcl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Oct 2021 18:32:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38766 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237851AbhJGWcl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Oct 2021 18:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633645846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=YNKAHYhoBnVbj0WoMI1GxVxqQW7WEuhHubvdP148BEQ=;
        b=Q8NDDUzpzY8HStHgLPFvOPme0aP4jcEWw2hw90s8C2t2gRiOWlImVrDfIbQRwODdqL+zA0
        F84LzP3lBGMNSbMP5C3ER96QneC2pMWjmDys4QUThI6/oJDQFKqDGBExIQcFYaYYLLw9V2
        fFPACXBJ8wG5VAOj7eVqR7+iAWKE6lk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-A55Efm-OOk2Fkticdz2c4Q-1; Thu, 07 Oct 2021 18:30:44 -0400
X-MC-Unique: A55Efm-OOk2Fkticdz2c4Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF5B31005E64;
        Thu,  7 Oct 2021 22:30:43 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.139])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F6CE5D9C6;
        Thu,  7 Oct 2021 22:30:25 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/7] Various NFS fscache cleanups
Date:   Thu,  7 Oct 2021 18:30:16 -0400
Message-Id: <1633645823-31235-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patchset is on top of David Howells patchset he just posted as
v3 of "fscache: Replace and remove old I/O API" and is based on his
fscache-remove-old-io branch at
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-remove-old-io
NOTE: fscache-remove-old-io was previously "fscache-iter-3" but it's been
renamed to better reflect the purpose.

The series is also at:
https://github.com/DaveWysochanskiRH/kernel.git
https://github.com/DaveWysochanskiRH/kernel/tree/fscache-remove-old-io-nfs-fixes

Testing is looking ok so far and is still ongoing at BakeAThon and in
my local testbed with tracepoints enabled via:
trace-cmd start -e fscache:* -e nfs:* -e nfs4:* -e cachefiles:*

Changes in v2 of this series
- Dropped first patch of v1 series (dhowells updated his patch)
- Don't rename or change the value of NFSDBG_FSCACHE (Trond)
- Rename nfs_readpage_from_fscache and nfs_readpage_to_fscache
- Rename enable/disable tracepoints to start with "nfs_fscache"
- Rename fscache IO tracepoints to better reflect the new function names
- Place the fscache IO tracepoints at begin and end of the functions

Dave Wysochanski (7):
  NFS: Use nfs_i_fscache() consistently within NFS fscache code
  NFS: Cleanup usage of nfs_inode in fscache interface and handle i_size
    properly
  NFS: Convert NFS fscache enable/disable dfprintks to tracepoints
  NFS: Rename fscache read and write pages functions
  NFS: Replace dfprintks with tracepoints in read and write page
    functions
  NFS: Remove remaining dfprintks related to fscache cookies
  NFS: Remove remaining usages of NFSDBG_FSCACHE

 fs/nfs/fscache-index.c      |  2 -
 fs/nfs/fscache.c            | 76 +++++++++++++----------------------
 fs/nfs/fscache.h            | 25 ++++++------
 fs/nfs/nfstrace.h           | 98 +++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/read.c               |  4 +-
 include/uapi/linux/nfs_fs.h |  2 +-
 6 files changed, 140 insertions(+), 67 deletions(-)

-- 
1.8.3.1

