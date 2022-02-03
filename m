Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E7E4A84FF
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Feb 2022 14:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiBCNRh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Feb 2022 08:17:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25713 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229981AbiBCNRh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Feb 2022 08:17:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643894256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=f4GGEtkTxFJY6Ux5Y3qrC8+gtxkH0FL9hwI1wkXvKPk=;
        b=Qrm4KizCfeB/Qhm64f5zOmm1gwpbdNLs22B9h2JcnDb/zLuE0OKflKfGjQ4Z2fHGGA+e98
        X91d15pel9N/ByRonQSi8dMIqMk5TEzrzOVffe+E3H50/hvSM8ARcpKFiaimgrXaLI0Fqe
        Uo4qb6m6z8EoB5fFEhzo//U+9WoZ9cs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-sXcNROsrNbqPiSwnvIR9Tw-1; Thu, 03 Feb 2022 08:17:33 -0500
X-MC-Unique: sXcNROsrNbqPiSwnvIR9Tw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EACDA1054F90;
        Thu,  3 Feb 2022 13:17:32 +0000 (UTC)
Received: from fedora.rsable.com (unknown [10.74.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C7A368049C;
        Thu,  3 Feb 2022 13:17:31 +0000 (UTC)
Date:   Thu, 3 Feb 2022 18:47:28 +0530
From:   Rohan Sable <rsable@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     rohanjsable@gmail.com
Subject: [PATCH] Fix error reporting for already mounted shares.
Message-ID: <YfvV6O+accmE0yVb@fedora.rsable.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When mount is triggered for an already mounted
share (using auto negotiation), it displays
"mount.nfs: Protocol not supported" or
"mount.nfs: access denied by server while mounting"
instead of EBUSY. This easily causes confusion if
the mount was not tried verbose :

[root@rsable ~]# mount 127.0.0.1:/export /mnt
mount.nfs: Protocol not supported

[root@rsable ~]# mount -v 127.0.0.1:/export /mnt
mount.nfs: timeout set for Mon Apr  5 16:03:53 2021
mount.nfs: trying text-based options 'vers=4.2,addr=127.0.0.1,clientaddr=127.0.0.1'
mount.nfs: mount(2): Protocol not supported
mount.nfs: trying text-based options 'vers=4,minorversion=1,addr=127.0.0.1,clientaddr=127.0.0.1'
mount.nfs: mount(2): Protocol not supported
mount.nfs: trying text-based options 'vers=4,addr=127.0.0.1,clientaddr=127.0.0.1'
mount.nfs: mount(2): Protocol not supported
mount.nfs: trying text-based options 'addr=127.0.0.1'
mount.nfs: prog 100003, trying vers=3, prot=6
mount.nfs: trying 127.0.0.1 prog 100003 vers 3 prot TCP port 2049
mount.nfs: prog 100005, trying vers=3, prot=17
mount.nfs: trying 127.0.0.1 prog 100005 vers 3 prot UDP port 20048
mount.nfs: mount(2): Device or resource busy  << actual error
mount.nfs: Protocol not supported

[root@rsable ~]# mount rsable76server:/testshare /mnt
mount.nfs: access denied by server while mounting rsable76server:/testshare

[root@rsable ~]# mount rsable76server:/testshare /mnt -v
mount.nfs: timeout set for Mon Jan 17 13:36:16 2022
mount.nfs: trying text-based options 'vers=4.1,addr=192.168.122.58,clientaddr=192.168.122.82'
mount.nfs: mount(2): Permission denied
mount.nfs: trying text-based options 'vers=4.0,addr=192.168.122.58,clientaddr=192.168.122.82'
mount.nfs: mount(2): Permission denied
mount.nfs: trying text-based options 'addr=192.168.122.58'
mount.nfs: prog 100003, trying vers=3, prot=6
mount.nfs: trying 192.168.122.58 prog 100003 vers 3 prot TCP port 2049
mount.nfs: prog 100005, trying vers=3, prot=17
mount.nfs: trying 192.168.122.58 prog 100005 vers 3 prot UDP port 20048
mount.nfs: mount(2): Device or resource busy	<< actual error
mount.nfs: access denied by server while mounting rsable76server:/testshare

Signed-off-by: Rohan Sable <rsable@redhat.com>
Signed-off-by: Yongcheng Yang <yoyang@redhat.com>
---
 utils/mount/stropts.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
index 3c4e218a..573df6ee 100644
--- a/utils/mount/stropts.c
+++ b/utils/mount/stropts.c
@@ -973,7 +973,9 @@ fall_back:
 	if ((result = nfs_try_mount_v3v2(mi, FALSE)))
 		return result;
 
-	errno = olderrno;
+	if (errno != EBUSY || errno != EACCES)
+		errno = olderrno;
+
 	return result;
 }
 
-- 
2.34.1

