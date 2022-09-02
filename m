Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A5C5AB2D7
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Sep 2022 16:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238089AbiIBOER (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Sep 2022 10:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239034AbiIBODx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Sep 2022 10:03:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8A81306CE
        for <linux-nfs@vger.kernel.org>; Fri,  2 Sep 2022 06:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662125547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=//oTww4IL10gAZlRaKa6BxR+9lgtxLhYYaSzRmGcp9k=;
        b=Odf7ELZNcMcfZOeb76rsRU3JmZs/KrT5GxvdPXyy+BBRujOvEIELAYHFbA2KjZxPHc6LBb
        ERnojjZBjK2epRwAuEtfhmxCbLBKFUQVH9zYnUqKsKzOtBt1S3bhAvJrt9TU/vONJSw2XZ
        TabMyfzob/9P4a5ylusPvzu/bJVfpW8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-6RagR_8hPkGMAlUs1vMoIA-1; Fri, 02 Sep 2022 08:53:48 -0400
X-MC-Unique: 6RagR_8hPkGMAlUs1vMoIA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E0DB2919EB8;
        Fri,  2 Sep 2022 12:53:48 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.98])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AA45F492C3B;
        Fri,  2 Sep 2022 12:53:47 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>
Subject: [PATCH v5 0/3] Convert NFS with fscache to the netfs API
Date:   Fri,  2 Sep 2022 08:53:43 -0400
Message-Id: <20220902125346.1619659-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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

Changes since v4 (all PATCH3)
- Remove more #ifdefs, replace with stub functions (Jeff Layton)[6]
- Use refcount for last RPC marker (Jeff Layton)[6]

The patches are fairly stable as evidenced with xfstests generic with
various servers, both with and without fscache enabled: 
hammerspace(pNFS flexfiles): vers=4.2,fsc; vers=4.2
NetApp(pNFS filelayout): vers=4.1,fsc; vers=4.0,fsc
RHEL8: vers=3,fsc; vers=3

No major issues outstanding.  Even the previous issue with the
"Subreq overread" was not reproducible with this set.
The known issues are as follows:

1. Unit test setting rsize < readahead does not properly read from
fscache but re-reads data from the NFS server
* This will be fixed with another linux-cachefs [4] patch to resolve
"Stop read optimisation when folio removed from pagecache"
* Daire Byrne also verified the patch fixes his issue as well

2. "Cache volume key already in use" after xfstest runs
* xfstests (hammerspace with vers=4.2,fsc) shows the following on the
console after some tests:
"NFS: Cache volume key already in use (nfs,4.1,2,c50,cfe0100a,3,,,8000,100000,100000,bb8,ea60,7530,ea60,1)"
* This may be fixed with another patch [4] that is in progress

The patchset is based on 6.0-rc3 and has been pushed to github at:
https://github.com/DaveWysochanskiRH/kernel/commits/nfs-fscache-netfs

[1] https://lore.kernel.org/linux-nfs/9cfd5bc3cfc6abc2d3316b0387222e708d67f595.camel@hammerspace.com/
[2] https://lore.kernel.org/linux-nfs/da9200f1bded9b8b078a7aef227fd6b92eb028fb.camel@hammerspace.com/
[3] https://marc.info/?l=linux-nfs&m=160597917525083&w=4
[4] https://www.mail-archive.com/linux-cachefs@redhat.com/msg03043.html
[5] https://marc.info/?l=linux-nfs&m=165962662200679&w=4
[6] https://marc.info/?l=linux-nfs&m=166204800323762&w=4

Dave Wysochanski (3):
  NFS: Rename readpage_async_filler to nfs_pageio_add_page
  NFS: Configure support for netfs when NFS fscache is configured
  NFS: Convert buffered read paths to use netfs when fscache is enabled

 fs/nfs/Kconfig           |   1 +
 fs/nfs/delegation.c      |   2 +-
 fs/nfs/dir.c             |   2 +-
 fs/nfs/fscache.c         | 256 ++++++++++++++++++++++++---------------
 fs/nfs/fscache.h         | 102 ++++++++++------
 fs/nfs/inode.c           |   8 +-
 fs/nfs/internal.h        |  11 +-
 fs/nfs/pagelist.c        |  12 ++
 fs/nfs/pnfs.c            |  12 +-
 fs/nfs/read.c            | 110 ++++++++---------
 fs/nfs/write.c           |   2 +-
 include/linux/nfs_fs.h   |  34 ++++--
 include/linux/nfs_page.h |   3 +
 include/linux/nfs_xdr.h  |   3 +
 14 files changed, 341 insertions(+), 217 deletions(-)

-- 
2.31.1

