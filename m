Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7489F427A28
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Oct 2021 14:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhJIMiW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 9 Oct 2021 08:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26062 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232982AbhJIMiW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 9 Oct 2021 08:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633782985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=jdTmtgaMNwpebhIB6PoYaRSJghKCrcGVuFo7wht5iso=;
        b=e7UAxsf0TX5GpA3OyHb0RC8yXsH/imKdehWb9RtJ/t/YsF6hhSeGWvJIDxvPFk4L+3jfCU
        kSHZHS3nSZW+B8sv3zQRn4XmhxoImb/nCaqSiiFkSIVT5AxbjNnOkJTggcITU5nN9eQnD9
        DnI590gxWOdXNCfY77gq9y5R8szjZp4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-CJbEELwANZO9XNZGWuSSLQ-1; Sat, 09 Oct 2021 08:36:23 -0400
X-MC-Unique: CJbEELwANZO9XNZGWuSSLQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9D5810059DF;
        Sat,  9 Oct 2021 12:36:22 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9495110016FF;
        Sat,  9 Oct 2021 12:36:04 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>, linux-cachefs@redhat.com,
        linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/1] Convert nfs_readpages() to nfs_readahead()
Date:   Sat,  9 Oct 2021 08:36:01 -0400
Message-Id: <1633782962-18335-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch converts nfs_readpages() to nfs_readahead().  It was
applied as follows:
0. Start with trond's testing branch at
0abb8895b065 NFS: Fix an Oops in pnfs_mark_request_commit()
1. Apply David Howells v3 of "fscache: Replace and remove old I/O API" [1]
2. Apply my fscache patches v2 of "Various NFS fscache cleanups" [2]
3. Apply Chucks v3 of "NFS: Replace dprintk callsites in nfs_readpage(s)"
plus one fixup (remove the "read_complete:" label in last hunk, which
conflicts with #2) [3]
4. Apply this patch

So far the existing BakeAThon tests have gone well with no oops or any
failure differences in xfstests (generic) between 5.15.0-rc4 and kernel
with #2 and #3 above.  I will continue testing now with all patches as
described above (#1 - #5).

As far as I know this has been an outstanding item for the NFS client
for a while and the fscache fallback IO API clears the way for this
patch.

I also just posted a v2 of the nfs-utils patch to display a "VFS readahead"
count rather than a readpages count [4].

[1] https://marc.info/?l=linux-nfs&m=163363955619832&w=2
[2] https://marc.info/?l=linux-nfs&m=163364580324243&w=2
[3] https://marc.info/?l=linux-nfs&m=163370503223875&w=2
[4] https://marc.info/?l=linux-nfs&m=163378240328297&w=2

Dave Wysochanski (1):
  NFS: Convert from readpages() to readahead()

 fs/nfs/file.c              |  2 +-
 fs/nfs/read.c              | 18 +++++++++++++-----
 include/linux/nfs_fs.h     |  3 +--
 include/linux/nfs_iostat.h |  6 +++---
 4 files changed, 18 insertions(+), 11 deletions(-)

-- 
1.8.3.1

