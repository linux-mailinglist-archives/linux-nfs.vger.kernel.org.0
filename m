Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA672351D9
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Aug 2020 13:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgHALKr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 1 Aug 2020 07:10:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34619 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728505AbgHALKq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 1 Aug 2020 07:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596280245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pAmL4k/JVZLMCB2r6A1QI/PffLuIzBDgu2w1EwYbcC8=;
        b=QvzIuR8j2hSqNvJ4Kvuj/P1IQT+wEy9/9/BKhRj40FgOfSuuDjh5ZoO+SeADSKUVUtu8BI
        Rk7uI4IAUV6/fKaG8tzKHS6nSTrEY9fjOZiYulaVal7eRObYhlVCskdraFkZbJxcjEFi1h
        Sd5XtdDUZn2IX3t+W47dhZWzPquIbcQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-J0AqIk8rPYeram2FWvJmPA-1; Sat, 01 Aug 2020 07:10:41 -0400
X-MC-Unique: J0AqIk8rPYeram2FWvJmPA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B81FF8014D7;
        Sat,  1 Aug 2020 11:10:40 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-115-198.rdu2.redhat.com [10.10.115.198])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 66F155D9E8;
        Sat,  1 Aug 2020 11:10:40 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 8C6BA1A0006; Sat,  1 Aug 2020 07:10:39 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/2] nfs: two writeback error reporting fixes
Date:   Sat,  1 Aug 2020 07:10:37 -0400
Message-Id: <20200801111039.1407632-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These fixes fix two regressions reported by Red Hat QE.  This first
issue reported was that writing a file larger than the available space
would result in a client hang instead of returning -ENOSPC.  The second
issue reported was that the client was returning -EIO instead of -EDQUOT
when a quota is exceeded.

On further investigation, I found that in the first issue the client
wasn't really hung.  Instead it was performing all of the requested
writes before it would eventually return -ENOSPC.  The dd command was
writing 400TB, which would have taken a few weeks to complete.
Adjusting the 'bs' and 'count' arguments so that the resulting file
would be much smaller (but still enough to fill up the space on the NFS
server) showed that the dd command would indeed complete with -ENOSPC.
But on older kernels even the 400TB dd would return -ENOSPC quickly.

In the second issue, I found that adding 'conv=fsync' would make the dd
command return -EDQUOT.  So what was happening with the original
command was that it was doing a close() without first calling fsync()
and the close() was returning -EIO.

I bisected both of these down to commit aded8d7b54f2 ("NFS: Don't
inadvertently clear writeback errors").  HOWEVER, as a test I reverted
that commit and it wasn't sufficient to bring back the old behavior.  I
turns out that was due to commit 6fbda89b257f ("NFS: Replace custom
error reporting mechanism with generic one").  This is why I listed the
second commit in the 'Fixes:' tag of both of my patches.

The first patch fixes the -EDQUOT issue and the second one fixes the
-ENOSPC issue.

-Scott

v2:
- Use filemap_sample_wb_err() & filemap_check_wb_err() instead of
  file_check_and_advance_wb_err() so that the error is not consumed.

Scott Mayhew (2):
  nfs: ensure correct writeback errors are returned on close()
  nfs: nfs_file_write() should check for writeback errors

 fs/nfs/file.c     | 17 +++++++++++++----
 fs/nfs/nfs4file.c |  5 ++++-
 2 files changed, 17 insertions(+), 5 deletions(-)

-- 
2.25.4

