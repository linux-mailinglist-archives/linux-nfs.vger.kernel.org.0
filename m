Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3266EB06E
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Apr 2023 19:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjDURTb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Apr 2023 13:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjDURT3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Apr 2023 13:19:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE00810F
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 10:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682097522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZANFOfnDvOnk5iS1Fz8Ne/mYBQjPnrhL6RXhlUon1D4=;
        b=M5HSq7mERrwHZ5K2N6hjCx6R+2wzFvW+4zFodNoEOTLkHOzzYHyeTL0at+9wxnl55aT8C/
        4AGeu7UYLBEYIHYikbqEfFXHa1auaapNIHD5NhynQ5dkFLiU4QO+HT8LmAm9HAqnWhlpCe
        Pc9dTNZiHCNL7URlqcZssuCNCmkdyWw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-MHUwpD3XNuK7mzPD8FbvJA-1; Fri, 21 Apr 2023 13:18:40 -0400
X-MC-Unique: MHUwpD3XNuK7mzPD8FbvJA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DC772807D67
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 17:18:40 +0000 (UTC)
Received: from bcodding.csb.redhat.com (ovpn-0-3.rdu2.redhat.com [10.22.0.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0949A40C2064
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 17:18:39 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/9 RFC v3] NFS sysfs scaffolding
Date:   Fri, 21 Apr 2023 13:18:30 -0400
Message-Id: <cover.1682097420.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

.. and an immediate new version because I had the wrong patch in 0/8 last
time.  Sorry for the noise.

Here's another round of sysfs entries for each nfs_server, this time with a
single use-case: a "shutdown" toggle that causes the basic rpc_clnt(s) to
immediately fail tasks with -EIO.  It works well for the non pNFS cases to
allow an unmount of a filesystem when the NFS server has gone away.

I'm posting to gain potential NACKing, or to be redirected, or to serve as
fodder for discussion at LSF.

I'm thinking I'd like to toggle v4.2 things like READ_PLUS in here next, or
other module-level options that maybe would be useful per-mount.

Benjamin Coddington (9):
  NFS: rename nfs_client_kset to nfs_kset
  NFS: rename nfs_client_kobj to nfs_net_kobj
  NFS: add superblock sysfs entries
  NFS: Add sysfs links to sunrpc clients for nfs_clients
  NFS: add a sysfs link to the lockd rpc_client
  NFS: add a sysfs link to the acl rpc_client
  NFS: add sysfs shutdown knob
  NFS: Cancel all existing RPC tasks when shutdown
  NFSv4: Clean up some shutdown loops

 fs/lockd/clntlock.c         |   6 ++
 fs/nfs/client.c             |  21 +++++
 fs/nfs/nfs3client.c         |   4 +
 fs/nfs/nfs4client.c         |   2 +
 fs/nfs/nfs4proc.c           |   2 +-
 fs/nfs/nfs4state.c          |   3 +
 fs/nfs/super.c              |   6 +-
 fs/nfs/sysfs.c              | 159 +++++++++++++++++++++++++++++++++---
 fs/nfs/sysfs.h              |   9 +-
 include/linux/lockd/bind.h  |   2 +
 include/linux/nfs_fs_sb.h   |   3 +
 include/linux/sunrpc/clnt.h |  11 ++-
 net/sunrpc/clnt.c           |   5 ++
 net/sunrpc/sysfs.h          |   7 --
 14 files changed, 216 insertions(+), 24 deletions(-)

-- 
2.39.2

