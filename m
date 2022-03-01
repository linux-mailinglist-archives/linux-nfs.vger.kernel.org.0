Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBDC4C9472
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Mar 2022 20:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbiCATjI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Mar 2022 14:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236904AbiCATjH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Mar 2022 14:39:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CC8C6548E
        for <linux-nfs@vger.kernel.org>; Tue,  1 Mar 2022 11:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646163503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jxmlHyJszZ33Ouc9QeUczvba3E4YWbIAEbTImDzI3rk=;
        b=c632yLvkTJ/oseISzyJBeNuqpewUvGaYM0/SoGwdOWkeh5ApIAo40hJM9825WoGWem3SWh
        b+9JrSxHPKKZYbp9SAumVHi7fLDWqjJrkUdbBPjxNcdvw1ZaM0tCesIwsQsM1jBi6BB91C
        NfCJzIQO+Nxz7VqLMmcv0/R8K9KuQ/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-251-Cay1_CxRPt20liqDh9g7Uw-1; Tue, 01 Mar 2022 14:38:22 -0500
X-MC-Unique: Cay1_CxRPt20liqDh9g7Uw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07FF251DC;
        Tue,  1 Mar 2022 19:38:21 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.9.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F3BB5DAA5;
        Tue,  1 Mar 2022 19:37:28 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        David Howells <dhowells@redhat.com>
Subject: [PATCH 0/4] Cleanups for NFS fscache and convert from dfprintk to trace events
Date:   Tue,  1 Mar 2022 14:37:23 -0500
Message-Id: <20220301193727.18847-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a re-post of these patches, unchanged from previous postings [1][2],
rebased on top of 5.17-rc5.

The patches were dependent on dhowells patchset which was taken in the
last merge window, so they apply on 5.17-rc5 cleanly now.

[1] https://marc.info/?l=linux-nfs&m=164225455702418&w=2
[2] https://marc.info/?l=linux-nfs&m=163976362831065&w=2

Dave Wysochanski (4):
  NFS: Cleanup usage of nfs_inode in fscache interface
  NFS: Rename fscache read and write pages functions
  NFS: Replace dfprintks with tracepoints in fscache read and write page functions
  NFS: Remove remaining dfprintks related to fscache and remove NFSDBG_FSCACHE

 fs/nfs/fscache.c            | 53 +++++++--------------
 fs/nfs/fscache.h            | 45 ++++++++----------
 fs/nfs/nfstrace.h           | 91 +++++++++++++++++++++++++++++++++++++
 fs/nfs/read.c               |  4 +-
 include/uapi/linux/nfs_fs.h |  2 +-
 5 files changed, 130 insertions(+), 65 deletions(-)

-- 
2.27.1

