Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66364234A6E
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jul 2020 19:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387429AbgGaRqU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 Jul 2020 13:46:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42569 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729018AbgGaRqT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 31 Jul 2020 13:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596217578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xiiP36tfbwvvObrNRZ6Hnur1uEP0vsW4lm684yYKuBI=;
        b=WgF4cLrqlVCjKEoVUKKWMWT4s1GYZdZWrZUUHem0+E1IRVez56yXqcR+BpUpYqpQeJ4CBi
        hIw1dFb0i8GN+vdLWqYpalz9jwdwuuZa+CaRTBT8jTXOhnar4Xh/Nx5wnxlqpzjnL3+tgm
        iePs4bBbCxxYvDXdUyKtL5rpITHSqBE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-mePwr5_5OHeLtjVAKpcb7w-1; Fri, 31 Jul 2020 13:46:16 -0400
X-MC-Unique: mePwr5_5OHeLtjVAKpcb7w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E895100AA21;
        Fri, 31 Jul 2020 17:46:15 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-115-198.rdu2.redhat.com [10.10.115.198])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 43E451C92D;
        Fri, 31 Jul 2020 17:46:15 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 746DF1A0006; Fri, 31 Jul 2020 13:46:14 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] nfs: two writeback error reporting fixes
Date:   Fri, 31 Jul 2020 13:46:12 -0400
Message-Id: <20200731174614.1299346-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

Scott Mayhew (2):
  nfs: ensure correct writeback errors are returned on close()
  nfs: nfs_file_write() should check for writeback errors

 fs/nfs/file.c     | 15 +++++++++++----
 fs/nfs/nfs4file.c |  3 ++-
 2 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.25.4

