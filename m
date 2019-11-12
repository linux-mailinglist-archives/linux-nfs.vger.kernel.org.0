Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2F0F9943
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2019 20:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfKLTCB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Nov 2019 14:02:01 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52417 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726952AbfKLTCB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Nov 2019 14:02:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573585320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1feI9EKUPd44UXi5eUrQQI0QVVdtYSwR1BfGPNKxR9E=;
        b=gF7/yjjXuB9h5Q8e5Fr4aiBMhUpm707uz9nwS8zODlUHBfwUvLu1ySFx39yr5NjHwbrg/5
        KfwhQItb6nPUN5sDkqEAYDZAIW63+MMqonz/aMk12puAvZQ2odmvcO5WsYKEWLda0UXYhM
        PHCw1D1nnFeh7JvtYT6wJIZFB0Xxru4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-cw4tKdJ-MCa5xGptBklOsQ-1; Tue, 12 Nov 2019 14:01:57 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8818C101AEF5;
        Tue, 12 Nov 2019 19:01:56 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-122-210.rdu2.redhat.com [10.10.122.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D25B1891F;
        Tue, 12 Nov 2019 19:01:56 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id BF48B208EC; Tue, 12 Nov 2019 14:01:55 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     bfields@fieldses.org, chuck.lever@oracle.com
Cc:     jamie@audible.transient.net, linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: v4 support requires CRYPTO_SHA256
Date:   Tue, 12 Nov 2019 14:01:55 -0500
Message-Id: <20191112190155.12872-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: cw4tKdJ-MCa5xGptBklOsQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The new nfsdcld client tracking operations use sha256 to compute hashes
of the kerberos principals, so make sure CRYPTO_SHA256 is enabled.

Fixes: 6ee95d1c8991 ("nfsd: add support for upcall version 2")
Reported-by: Jamie Heilman <jamie@audible.transient.net>
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfsd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index 10cefb0c07c7..c4b1a89b8845 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -73,7 +73,7 @@ config NFSD_V4
 =09select NFSD_V3
 =09select FS_POSIX_ACL
 =09select SUNRPC_GSS
-=09select CRYPTO
+=09select CRYPTO_SHA256
 =09select GRACE_PERIOD
 =09help
 =09  This option enables support in your system's NFS server for
--=20
2.17.2

