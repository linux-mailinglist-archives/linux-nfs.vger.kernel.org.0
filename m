Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAE46D9939
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Apr 2023 16:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239052AbjDFOLc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Apr 2023 10:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239110AbjDFOLG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Apr 2023 10:11:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB019747
        for <linux-nfs@vger.kernel.org>; Thu,  6 Apr 2023 07:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680790212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sqRECnhkg8Mn2JC/nWdHDxxGOA36SmHMyiSlUo3xfMU=;
        b=HodSxbICWnCO1PcwKLk/9S1WKu5AUHKzxSXnH1VbwbslwXxP9+g00O2poCyItw+fxpARNY
        UJVHrTuQlxn7+Cq0aRm0/mAI8MupofbjfMSO3CjdWfFzfhV0PeaDlWj+8TKE4qdqhCYT33
        PZ8ldmR9y8wEVqwyTOH3ukWhdwn7eMU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-t8cA6j6vMZ2NYVyQvLT2bQ-1; Thu, 06 Apr 2023 10:10:09 -0400
X-MC-Unique: t8cA6j6vMZ2NYVyQvLT2bQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 867EE88B7A0;
        Thu,  6 Apr 2023 14:10:05 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.10.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3AE342166B26;
        Thu,  6 Apr 2023 14:10:05 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@netapp.com, Olga.Kornievskaia@netapp.com
Subject: [PATCH 0/6] RFC: NFS sysfs mounts to rpc client structure
Date:   Thu,  6 Apr 2023 10:09:58 -0400
Message-Id: <cover.1680786859.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Here's a bit of sysfs scaffolding that creates structure for each mount and
links that to the sunrpc transport objects.  Having links between mounts and
rpc clients can help admins figure out which sunrpc objects are associated
with which mount.

Ultimately, I would like to flesh out the mount side of this interface with
knobs that allow an "nfs shutdown" and the ability to control various
optional features without having to continually add mount options.  Even
though I don't have anything stable enough to share on that front, I'm
sharing these first few patches for criticism or collaboration.

Benjamin Coddington (6):
  NFS: rename nfs_client_kset to nfs_kset
  NFS: rename nfs_client_kobj to nfs_net_kobj
  NFS: add superblock sysfs entries
  NFS: Add sysfs links to sunrpc clients for nfs_clients
  NFS: add a sysfs link to the lockd rpc_client
  NFS: add a sysfs link to the acl rpc_client

 fs/lockd/clntlock.c         |  6 +++
 fs/nfs/client.c             | 21 ++++++++
 fs/nfs/nfs3client.c         |  4 ++
 fs/nfs/nfs4client.c         |  2 +
 fs/nfs/super.c              |  6 ++-
 fs/nfs/sysfs.c              | 98 ++++++++++++++++++++++++++++++++-----
 fs/nfs/sysfs.h              |  7 +++
 include/linux/lockd/bind.h  |  2 +
 include/linux/nfs_fs_sb.h   |  2 +
 include/linux/sunrpc/clnt.h |  8 ++-
 net/sunrpc/sysfs.h          |  7 ---
 11 files changed, 142 insertions(+), 21 deletions(-)

-- 
2.39.2

