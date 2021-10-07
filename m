Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBB7426067
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Oct 2021 01:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhJGXfa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Oct 2021 19:35:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33593 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229778AbhJGXfa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Oct 2021 19:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633649615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=iTO3S+R+06LA5TW4HMUsIIUwq9GFfftwKljdE4zhZkE=;
        b=L+0FOoGp0g6OkhESuzTOKKvYPkWVmzx4ENF9ew1OdjHWXJHM9fL68XJVQ4GprkMSat40qZ
        zEjjL2v+9/hZokbmq/ykmP98Ki3jIh3XavxLO+/Wpmz6Du5lHTlDuGRdK1sAISEC9h3bZT
        1fZ5onoo4/cTTQRodxsHk4aADqV1hzA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-598-9_I7UE_FMsi_LoZyB4Q_lA-1; Thu, 07 Oct 2021 19:33:34 -0400
X-MC-Unique: 9_I7UE_FMsi_LoZyB4Q_lA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A60D1090064;
        Thu,  7 Oct 2021 23:32:12 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.139])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF4BF6A902;
        Thu,  7 Oct 2021 23:32:10 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>, linux-cachefs@redhat.com,
        linux-nfs@vger.kernel.org
Subject: [PATCH 0/1] Convert nfs_readpages() to nfs_readahead()
Date:   Thu,  7 Oct 2021 19:32:07 -0400
Message-Id: <1633649528-1321-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch converts nfs_readpages() to nfs_readahead().  It was
applied on top of the set I just posted [1] plus Chuck's v1 patch to
convert dfprintks to tracepoints [2].  It is being tested on top of
these patches at BakeAThon against various servers, cthon, xfstests,
and my fscache unit tests.  Note that Chuck may post a v3 of his
patch and this would need rebased on that patch.

Note that a nfs-utils patch will need to be done to properly account
for the changed NFSIOS_* counters.

I would consider this a "nice to have" for this cycle but I wanted
to get it out there sooner than later.  As far as I know this has
been an outstanding item for the NFS client for a while and the
fscache fallback IO API clears the way for this patch.

[1] https://marc.info/?l=linux-nfs&m=163364580324243&w=2
[2] https://marc.info/?l=linux-nfs&m=163345402812426&w=2


Dave Wysochanski (1):
  NFS: Convert from readpages() to readahead()

 fs/nfs/file.c              |  2 +-
 fs/nfs/nfstrace.h          |  2 +-
 fs/nfs/read.c              | 21 +++++++++++++++------
 include/linux/nfs_fs.h     |  3 +--
 include/linux/nfs_iostat.h |  6 +++---
 5 files changed, 21 insertions(+), 13 deletions(-)

-- 
1.8.3.1

