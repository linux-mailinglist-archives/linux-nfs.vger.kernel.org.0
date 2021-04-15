Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65EE936057B
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Apr 2021 11:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhDOJUP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Apr 2021 05:20:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24146 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229457AbhDOJUP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Apr 2021 05:20:15 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-AV4RVgTgOxizqDsDJ59Row-1; Thu, 15 Apr 2021 05:19:50 -0400
X-MC-Unique: AV4RVgTgOxizqDsDJ59Row-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 847F0107ACE6;
        Thu, 15 Apr 2021 09:19:49 +0000 (UTC)
Received: from localhost (unknown [10.66.61.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF2832AAAA;
        Thu, 15 Apr 2021 09:19:48 +0000 (UTC)
From:   Yongcheng Yang <yongcheng.yang@gmail.com>
To:     steved@redhat.com
Cc:     NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org,
        Yongcheng Yang <yongcheng.yang@gmail.com>
Subject: [PATCH 1/1] mountd/exports: Fix typo in the man page
Date:   Thu, 15 Apr 2021 17:19:38 +0800
Message-Id: <20210415091938.24021-1-yongcheng.yang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Yongcheng Yang <yongcheng.yang@gmail.com>
---
Hi SteveD and Neil,

Please check if I understand it correctly.

Thanks,
Yongcheng

 utils/exportd/exportd.man | 4 ++--
 utils/mountd/mountd.man   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/utils/exportd/exportd.man b/utils/exportd/exportd.man
index b238ff05..fae434b5 100644
--- a/utils/exportd/exportd.man
+++ b/utils/exportd/exportd.man
@@ -14,7 +14,7 @@ is used to manage NFSv4 exports.
 The NFS server
 .RI ( nfsd )
 maintains a cache of authentication and authorization information which
-is used to identify the source of each requent, and then what access
+is used to identify the source of each request, and then what access
 permissions that source has to any local filesystem.  When required
 information is not found in the cache, the server sends a request to
 .B nfsv4.exportd
@@ -134,7 +134,7 @@ listing exports, export options, and access control lists
 .BR exports (5),
 .BR showmount (8),
 .BR nfs.conf (5),
-.BR firwall-cmd (1),
+.BR firewall-cmd (1),
 .sp
 RFC 7530 - "Network File System (NFS) Version 4 Protocol"
 .br
diff --git a/utils/mountd/mountd.man b/utils/mountd/mountd.man
index 1155cf94..77e6299a 100644
--- a/utils/mountd/mountd.man
+++ b/utils/mountd/mountd.man
@@ -19,7 +19,7 @@ clients and provides details of access permissions.
 The NFS server
 .RI ( nfsd )
 maintains a cache of authentication and authorization information which
-is used to identify the source of each requent, and then what access
+is used to identify the source of each request, and then what access
 permissions that source has to any local filesystem.  When required
 information is not found in the cache, the server sends a request to
 .B mountd
-- 
2.20.1

