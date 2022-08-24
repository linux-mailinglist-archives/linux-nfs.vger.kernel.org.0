Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B041359F658
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Aug 2022 11:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbiHXJfN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Aug 2022 05:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbiHXJfL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Aug 2022 05:35:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1493076443
        for <linux-nfs@vger.kernel.org>; Wed, 24 Aug 2022 02:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661333709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=svgx48O+sZiHrg49Ikl8xp1SYbrgYFheSwSNP4x6DZI=;
        b=ggO9rdGPEutrDCTOVNkBd9lE8nECeK+J+xChBz0e3TRQcXLCSs0+AJtoLYCnKOd4/W+isW
        pOR6oOALU35wJZUTqQ1Y1HBFM1oa5ORGC7wwyealdiJSR3R5u5a6WiX7FPI60x/aUnVA2F
        GB+16JFYhuv/t9SRCV18dOT3b33f8Ak=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-Tb0UZZv_OIG1CiPcDC0EGQ-1; Wed, 24 Aug 2022 05:35:04 -0400
X-MC-Unique: Tb0UZZv_OIG1CiPcDC0EGQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9FDF685A585;
        Wed, 24 Aug 2022 09:35:03 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.98])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ED36314152E0;
        Wed, 24 Aug 2022 09:35:02 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>
Subject: [RFC PATCH 0/3] Convert NFS to the new netfs API
Date:   Wed, 24 Aug 2022 05:34:58 -0400
Message-Id: <20220824093501.384755-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patchset converts NFS non-direct READ IO paths to unconditionally
use the netfs API with a non-invasive approach.  The existing NFS pgio
layer does not need extensive changes, and is the best way so far I've
found to avoid Trond's earlier objection [1].  I have not yet attempted
performance comparisions to address Chuck Lever's concern [2].

The main patch to be reviewed is patch #3 which converts nfs_read_folio
and nfs_readahead.

I do not really like this patchset but so far this is what I was able
to come up with the move things forward.  I think it is awkward and
still needs work, has some issues (below) though it is fairly stable
by running xfstests generic with various servers.  The known issues
are as follows:

1. Unit test setting rsize < readahead does not properly read from
fscache but re-reads data from the NFS server
* This will be fixed once another linux-cachefs [3] patch to resolve
"Stop read optimisation when folio removed from pagecache"

2. "Cache volume key already in use" after xfstest runs
* xfstests (hammerspace with vers=4.2,fsc) shows the following on the
console after some tests:
"NFS: Cache volume key already in use (nfs,4.1,2,c50,cfe0100a,3,,,8000,100000,100000,bb8,ea60,7530,ea60,1)"
* This may be fixed with another patch [4] that is in progress

3. Occasional process IO hangs in read paths
* May be due to out-of-order RPC replies or something unique to NetApp
triggering a bug in the conversion patch
* xfstests (Example: generic/075 with netapp ontap9 vers=4.1)
* Sample backtrace
 #2 [ffff888104967990] io_schedule at ffffffffbc46969d
 #3 [ffff8881049679b0] folio_wait_bit_common at ffffffffbb40214b
 #4 [ffff888104967ad0] filemap_get_pages at ffffffffbb40688c
 #5 [ffff888104967c00] filemap_read at ffffffffbb406a61
 #6 [ffff888104967d80] nfs_file_read at ffffffffc0e0f415 [nfs]
 #7 [ffff888104967db0] vfs_read at ffffffffbb5681a5

4. Data corruption seen with unit test where rsize < readahead
* Seen with vanilla 6.0-rc2 (did not occur on 5.19); likely unrelated
to this patchset
 mount -o vers=4.2,fsc,rsize=8192 127.0.0.1:/export /mnt
 dd if=/dev/urandom of=/tmp/integrity-rsize-file1.bin bs=16k count=1
 ./nfs-readahead.sh set /mnt 16384
 dd if=/tmp/integrity-rsize-file1.bin of=/mnt/integrity-rsize-file1.bin bs=16k count=1
 echo 3 > /proc/sys/vm/drop_caches
 md5sum /mnt/integrity-rsize-file1.bin /tmp/integrity-rsize-file1.bin
 md5sums don't match, MD5_NFS = 00eaf1a5bc1b3dfd54711db551619afa != MD5_LOCAL = e8d835c83ba1f1264869dc40673fa20c


The patchset is based on 6.0-rc2 and has been pushed to github at:
https://github.com/DaveWysochanskiRH/kernel/commits/nfs-fscache-netfs

[1] https://lore.kernel.org/linux-nfs/9cfd5bc3cfc6abc2d3316b0387222e708d67f595.camel@hammerspace.com/
[2] https://marc.info/?l=linux-nfs&m=160597917525083&w=4
[3] https://www.mail-archive.com/linux-cachefs@redhat.com/msg03043.html
[4] https://marc.info/?l=linux-nfs&m=165962662200679&w=4

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

