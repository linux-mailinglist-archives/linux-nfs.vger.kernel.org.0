Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B55D1AB260
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Apr 2020 22:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441995AbgDOUOw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Apr 2020 16:14:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46855 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2441993AbgDOUOv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Apr 2020 16:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586981689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc; bh=uhLQTt1EhkOR7lKRcEjMAOmv9o1JxeyWPK7wmruvwmE=;
        b=iALPwY87LbHh43Ieh95HArlTqR/qlbH2csDyPZfjovNPpufuHYwe+FPsy7QyIiUfJz4qCM
        CV8bxr2xyOQXF+3Pwxvnv/NIGuz6FeRmnRBQeoTMHzsGxvBsSog3PVukPfURKuA5lSbL8E
        ydhKJkm2yePKSGweX+xdkbeW4lUZnF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-RKfkgMpFN5eX7c6iKn3Kyg-1; Wed, 15 Apr 2020 16:14:46 -0400
X-MC-Unique: RKfkgMpFN5eX7c6iKn3Kyg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C62EE8018A2
        for <linux-nfs@vger.kernel.org>; Wed, 15 Apr 2020 20:14:45 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-112-216.rdu2.redhat.com [10.10.112.216])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7025C116D88;
        Wed, 15 Apr 2020 20:14:45 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     dhowells@redhat.com, linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFS: Fix fscache super_cookie index_key from changing after umount
Date:   Wed, 15 Apr 2020 16:14:41 -0400
Message-Id: <1586981683-3077-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit 402cb8dda949 ("fscache: Attach the index key and aux data to
the cookie") added the index_key and index_key_len parameters to
fscache_acquire_cookie(), and updated the callers in the NFS client.
One of the callers was inside nfs_fscache_get_super_cookie()
and was changed to use the full struct nfs_fscache_key as the
index_key.  However, a couple members of this structure contain
pointers and thus will change each time the same NFS share is
remounted.  Since index_key is used for fscache_cookie->key_hash
and this subsequently is used to compare cookies, the effectiveness
of fscache with NFS is reduced to the point at which a umount
occurs.   Any subsequent remount of the same share will cause a
unique NFS super_block index_key and key_hash to be generated for
the same data, rendering any prior fscache data unable to be
found.  A simple reproducer demonstrates the problem.

1. Mount share with 'fsc', create a file, drop page cache
systemctl start cachefilesd
mount -o vers=3,fsc 127.0.0.1:/export /mnt
dd if=/dev/zero of=/mnt/file1.bin bs=4096 count=1
echo 3 > /proc/sys/vm/drop_caches

2. Read file into page cache and fscache, then unmount
dd if=/mnt/file1.bin of=/dev/null bs=4096 count=1
umount /mnt

3. Remount and re-read which should come from fscache
mount -o vers=3,fsc 127.0.0.1:/export /mnt
echo 3 > /proc/sys/vm/drop_caches
dd if=/mnt/file1.bin of=/dev/null bs=4096 count=1

4. Check for READ ops in mountstats - there should be none
grep READ: /proc/self/mountstats

Looking at the history and the removed function, nfs_super_get_key(),
we should only use nfs_fscache_key.key plus any uniquifier, for
the fscache index_key.

Fixes: 402cb8dda949 ("fscache: Attach the index key and aux data to the cookie")
Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/fscache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 1abf126c2df4..8eff1fd806b1 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -188,7 +188,8 @@ void nfs_fscache_get_super_cookie(struct super_block *sb, const char *uniq, int
 	/* create a cache index for looking up filehandles */
 	nfss->fscache = fscache_acquire_cookie(nfss->nfs_client->fscache,
 					       &nfs_fscache_super_index_def,
-					       key, sizeof(*key) + ulen,
+					       &key->key,
+					       sizeof(key->key) + ulen,
 					       NULL, 0,
 					       nfss, 0, true);
 	dfprintk(FSCACHE, "NFS: get superblock cookie (0x%p/0x%p)\n",
-- 
1.8.3.1

