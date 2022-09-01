Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AF85A89F6
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Sep 2022 02:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiIAAs7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Aug 2022 20:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiIAAs5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Aug 2022 20:48:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897AD11C150
        for <linux-nfs@vger.kernel.org>; Wed, 31 Aug 2022 17:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661993334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yCF+DBve3h4AnKlkwDUlDnxkqvtSxNvpVJVeM7urb9c=;
        b=dAOZohQM0ndUXZtmGOcCiDJ2ZgBkESQ0iOwXhfIMfCAwTkdNRMNEv7oX7uIEZyec9tJi2w
        O+PAec6j+m0xXFmjEC7D69FkwuRMqlUncRGnmG80s2R95IK3hdqXq/lY9VckXzX/nX9BFS
        olvjO3qBmUOArQl9rxw9KGB/DQ6r5ak=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-S7rGUJ3pOo22Se1tMscE-A-1; Wed, 31 Aug 2022 20:48:53 -0400
X-MC-Unique: S7rGUJ3pOo22Se1tMscE-A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3E1E964084;
        Thu,  1 Sep 2022 00:48:52 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.98])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C0D8492C3B;
        Thu,  1 Sep 2022 00:48:52 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>
Subject: [PATCH v4 0/3] Convert NFS with fscache to the netfs API
Date:   Wed, 31 Aug 2022 20:48:47 -0400
Message-Id: <20220901004850.1431412-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
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

Changes since v3
- PATCH2: Improve #ifdef readability; use VFS_I #define (Jeff Layton)
- PATCH3: Fix Aug 30 kernel test robot <lkp@intel.com> compile warning due
  to unusued 'sreq' variables in fscache.c (test build with W=1)
- PATCH3: Simplify nfs_netfs_init_request (Jeff Layton, Matt Wilcox)

The patches are fairly stable as evidenced with xfstests generic with
various servers: hammerspace w/NFS4.2+fscache,
NetApp(ontap9) NFSv4.1+fscache (other tests in progress)
The known issues are as follows:

No major issues outstanding - the data corruption is unrelated to this
patchset.  The known issues are as follows:

1. Unit test setting rsize < readahead does not properly read from
fscache but re-reads data from the NFS server
* This will be fixed with another linux-cachefs [4] patch to resolve
"Stop read optimisation when folio removed from pagecache"

2. "Cache volume key already in use" after xfstest runs
* xfstests (hammerspace with vers=4.2,fsc) shows the following on the
console after some tests:
"NFS: Cache volume key already in use (nfs,4.1,2,c50,cfe0100a,3,,,8000,100000,100000,bb8,ea60,7530,ea60,1)"
* This may be fixed with another patch [4] that is in progress

3. (RESOLVED) Hang

4. (DEFERRED/UNRELATED) Data corruption seen with unit test where rsize < readahead
* Confirmed unrelated to this patchset
* Seen with vanilla 6.0-rc2 (did not occur on 5.19)
* Not 100% reproducible (maybe 75% of the time)
* NFS protocol version doesn't matter
* First page is always fine, next 3 pages are not
* Garbage data is coming over the wire from the NFS server
because the NFS server file is garbage (the dd of the file from
/tmp to NFS /mnt corrupts it).
 mount -o vers=4.2,fsc,rsize=8192 127.0.0.1:/export /mnt
 dd if=/dev/urandom of=/tmp/integrity-rsize-file1.bin bs=16k count=1
 ./nfs-readahead.sh set /mnt 16384
 dd if=/tmp/integrity-rsize-file1.bin of=/mnt/integrity-rsize-file1.bin bs=16k count=1
 echo 3 > /proc/sys/vm/drop_caches
 md5sum /mnt/integrity-rsize-file1.bin /tmp/integrity-rsize-file1.bin
 md5sums don't match, MD5_NFS = 00eaf1a5bc1b3dfd54711db551619afa != MD5_LOCAL = e8d835c83ba1f1264869dc40673fa20c

5. generic/127 triggers "Subreq overread" warning
* just hit one time; did not stop test
[ 4196.864176] run fstests generic/127 at 2022-08-31 17:29:38
[ 5608.997945] ------------[ cut here ]------------
[ 5609.000476] Subreq overread: R1c85d[0] 73728 > 70073 - 0


The patchset is based on 6.0-rc3 and has been pushed to github at:
https://github.com/DaveWysochanskiRH/kernel/commits/nfs-fscache-netfs

[1] https://lore.kernel.org/linux-nfs/9cfd5bc3cfc6abc2d3316b0387222e708d67f595.camel@hammerspace.com/
[2] https://lore.kernel.org/linux-nfs/da9200f1bded9b8b078a7aef227fd6b92eb028fb.camel@hammerspace.com/
[3] https://marc.info/?l=linux-nfs&m=160597917525083&w=4
[4] https://www.mail-archive.com/linux-cachefs@redhat.com/msg03043.html
[5] https://marc.info/?l=linux-nfs&m=165962662200679&w=4

Dave Wysochanski (3):
  NFS: Rename readpage_async_filler to nfs_pageio_add_page
  NFS: Add support for netfs in struct nfs_inode and Kconfig
  NFS: Convert nfs_read_folio and nfs_readahead to netfs APIs

 fs/nfs/Kconfig           |   1 +
 fs/nfs/delegation.c      |   2 +-
 fs/nfs/dir.c             |   2 +-
 fs/nfs/fscache.c         | 191 ++++++++++++++++++---------------------
 fs/nfs/fscache.h         |  77 ++++++++--------
 fs/nfs/inode.c           |   8 +-
 fs/nfs/internal.h        |  10 +-
 fs/nfs/pagelist.c        |  14 +++
 fs/nfs/pnfs.c            |  12 +--
 fs/nfs/read.c            | 117 ++++++++----------------
 fs/nfs/write.c           |   2 +-
 include/linux/nfs_fs.h   |  19 +---
 include/linux/nfs_page.h |   1 +
 include/linux/nfs_xdr.h  |   1 +
 14 files changed, 210 insertions(+), 247 deletions(-)

-- 
2.31.1

