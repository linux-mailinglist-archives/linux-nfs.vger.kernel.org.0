Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D49A5AC38B
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Sep 2022 11:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiIDJGI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 4 Sep 2022 05:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiIDJGF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 4 Sep 2022 05:06:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A55491C7
        for <linux-nfs@vger.kernel.org>; Sun,  4 Sep 2022 02:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662282362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XTVzWA0eooFVA3AIOfqIs5zlZ1Ssmg5A/OrMyXDrzVI=;
        b=XQlctMzrRuwI9hH2kZqioS5IWLXYBYUm/Dd90pKZYC20p6mnsHg5oC+VbCCl5/kvrLnk+b
        lHXqKnFcNCdMxrotEbY2IZtIiztzgIv11I2JIsdI/NmZEgUaECNrkfSmI/nbnMm3iE6LTu
        +jPtl0NEgYtRj14FfZe/1gG9v2BEQK4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-mrg6s_fZPNalU_LuCoSYuA-1; Sun, 04 Sep 2022 05:05:59 -0400
X-MC-Unique: mrg6s_fZPNalU_LuCoSYuA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC64E80418F;
        Sun,  4 Sep 2022 09:05:58 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.98])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B6061415102;
        Sun,  4 Sep 2022 09:05:58 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>
Subject: [PATCH v6 0/3] Convert NFS with fscache to the netfs API
Date:   Sun,  4 Sep 2022 05:05:54 -0400
Message-Id: <20220904090557.1901131-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patchset converts NFS with fscache non-direct READ IO paths to
use the netfs API with a non-invasive approach.  The existing NFS pgio
layer does not need extensive changes, and is the best way so far I've
found to address Trond's concerns about modifying the IO path [1] as
well as only enabling netfs when fscache is configured and enabled [2].
I have not attempted performance comparisions to address Chuck
Lever's concern [3] because we are not converting the non-fscache
enabled NFS IO paths to netfs.

The main patch to be reviewed is patch #3 which converts nfs_read_folio
and nfs_readahead.

The patchset is based on 6.0-rc3 and has been pushed to github at:
https://github.com/DaveWysochanskiRH/kernel/commits/nfs-fscache-netfs
https://github.com/DaveWysochanskiRH/kernel/commit/152f43e3de2cce4e331593bd425c638a4a430a7c


Changes since v5
================
Patch1: Add Jeff Layton's reviewed-by (from v3 posting)
Patch2: Add Jeff Layton's reviewed-by (from v5 posting)
Patch3: Make netfs->transferred atomic64_t, drop spinlock (Jeff Layton)
Patch3: Various cleanups
- rename nfs_netfs_read_initiate to nfs_netfs_initiate_read
- rename nfs_fscache_read_folio to nfs_netfs_read_folio
- rename nfs_fscache_readahead to nfs_netfs_readahead
- rename nfs_netfs_read_done nfs_netfs_readpage_done
- move unlock_page inside nfs_netfs_readpage_release
- use netfs_inode() helper in more places


Testing
=======
The patches are fairly stable as evidenced with xfstests generic with
various servers, both with and without fscache enabled: 
hammerspace(pNFS flexfiles): NFS4.1,NFS4.2
NetApp(pNFS filelayout): NFS3,NFS4.0,NFS4.1
RHEL8: NFS3,NFS4.1,NFS4.2

No major issues outstanding.  The known issues are as follows:

1. Unit test setting rsize < readahead does not properly read from
fscache but re-reads data from the NFS server
* This will be fixed with another linux-cachefs [4] patch to resolve
"Stop read optimisation when folio removed from pagecache"
* Daire Byrne also verified the patch fixes his issue as well

2. "Cache volume key already in use" after xfstest runs
* xfstests (hammerspace with vers=4.2,fsc) shows the following on the
console after some tests:
"NFS: Cache volume key already in use (nfs,4.1,2,c50,cfe0100a,3,,,8000,100000,100000,bb8,ea60,7530,ea60,1)"
* This may be fixed with another patch [5] that is in progress

3. generic/127 triggers "Subreq overread" warning
* Intermittent, hard to reproduce 
* Seen with NFSv3 and RHEL8 server
[ 4196.864176] run fstests generic/127 at 2022-08-31 17:29:38
[ 5608.997945] ------------[ cut here ]------------
[ 5609.000476] Subreq overread: R1c85d[0] 73728 > 70073 - 0


Outstanding work
================
Note that the existing NFS fscache stats ("fsc:" line in /proc/self/mountstats)
as well as trace events still need removed.  I've left these out of
this patchset for now as removing them are benign and can come later
(the stats will all be 0, and trace events are no longer used).
The existing NFS fscache stat counts no longer apply since the new
API is not page based - they are not meaningful or possible to obtain,
and there are new fscache stats in /proc/fs/fscache/stats.  A similar
situation exists with the NFS trace events - netfs and fscache have
plenty of trace events so the NFS specific ones probably are not needed.


References
==========
[1] https://lore.kernel.org/linux-nfs/9cfd5bc3cfc6abc2d3316b0387222e708d67f595.camel@hammerspace.com/
[2] https://lore.kernel.org/linux-nfs/da9200f1bded9b8b078a7aef227fd6b92eb028fb.camel@hammerspace.com/
[3] https://marc.info/?l=linux-nfs&m=160597917525083&w=4
[4] https://www.mail-archive.com/linux-cachefs@redhat.com/msg03043.html
[5] https://marc.info/?l=linux-nfs&m=165962662200679&w=4

Dave Wysochanski (3):
  NFS: Rename readpage_async_filler to nfs_pageio_add_page
  NFS: Configure support for netfs when NFS fscache is configured
  NFS: Convert buffered read paths to use netfs when fscache is enabled

 fs/nfs/Kconfig           |   1 +
 fs/nfs/delegation.c      |   2 +-
 fs/nfs/dir.c             |   2 +-
 fs/nfs/fscache.c         | 251 +++++++++++++++++++++++----------------
 fs/nfs/fscache.h         | 101 ++++++++++------
 fs/nfs/inode.c           |   8 +-
 fs/nfs/internal.h        |  11 +-
 fs/nfs/pagelist.c        |  12 ++
 fs/nfs/pnfs.c            |  12 +-
 fs/nfs/read.c            | 111 +++++++++--------
 fs/nfs/write.c           |   2 +-
 include/linux/nfs_fs.h   |  34 ++++--
 include/linux/nfs_page.h |   3 +
 include/linux/nfs_xdr.h  |   3 +
 14 files changed, 335 insertions(+), 218 deletions(-)

-- 
2.31.1

