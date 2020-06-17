Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715821FC358
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2020 03:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgFQBZD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Jun 2020 21:25:03 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17142 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726044AbgFQBZC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Jun 2020 21:25:02 -0400
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jun 2020 21:25:02 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1592356182; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=PjxwOBwaZwUX83ncBcY4KfwBsUbCHCghqqVN3xUmoPt1W10SfxfD36xovTPZU1zrGpcVWoNRKVEizeJK5m/6PUhjabmrWBWB/3oALGOD3YxhdHP4F5900ygr1sqpkzAv0IyDAduDpGP4SAbJurFH6jqkqf3V4dp6xlvM7XUFjCM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1592356182; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=a5jahkrSma4oijnYxC3Nne3+YP0mZTv6O0xiXdTrSSM=; 
        b=kzx4l83BCmJuVDzOLbeDTSyC8eBL3NTTknUDPlXPgTcqwiGk64YRa+MohuuxCfhsMyexCUcwoYkL3dJa9ezF4KHl5lnGe8Z7UP7QtW8Aglp+scqpC0m+QEm6H/FS5HpgfFQ2uavIpdAg2eoL/2FHreDu37fRf8cr//01oXhVix8=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1592356182;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=a5jahkrSma4oijnYxC3Nne3+YP0mZTv6O0xiXdTrSSM=;
        b=GBSU8Rdd0NxglUMaY9aStXGUThsjU3y5gXhvzzmWqtJYFwJyzL9jYBVYc6GeSURn
        UQzz8iNQlbqaoFadORM03qCQVK92MsojJ2TLAjuSvI8kJU2e1b9zBHYHnyHsVqXcNgd
        k3CSGogSV1b8MEYF4YVoIEUNBccUKGQGV97U29gI=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1592356180846624.5090902346486; Wed, 17 Jun 2020 09:09:40 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20200617010939.19087-1-cgxu519@mykernel.net>
Subject: [PATCH] nfs4: strengthen error check to avoid unexpected result
Date:   Wed, 17 Jun 2020 09:09:39 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The variable error is ssize_t, which is signed and will
cast to unsigned when comapre with variable size, so add
a check to avoid unexpected result in case of negative
value of error.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/nfs/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 9056f3dd380e..5f04c6f818b8 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7392,7 +7392,7 @@ nfs4_listxattr_nfs4_label(struct inode *inode, char *=
list, size_t list_len)
=20
 =09if (nfs_server_capable(inode, NFS_CAP_SECURITY_LABEL)) {
 =09=09len =3D security_inode_listsecurity(inode, list, list_len);
-=09=09if (list_len && len > list_len)
+=09=09if (len >=3D 0 && list_len && len > list_len)
 =09=09=09return -ERANGE;
 =09}
 =09return len;
--=20
2.20.1


