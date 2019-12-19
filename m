Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0D9E12687A
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2019 18:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLSRy6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Dec 2019 12:54:58 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35326 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726797AbfLSRy6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Dec 2019 12:54:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576778097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/JhP8Uvlx3YYeeNrsS5JaFsMByNLWx35JcNbthSfVC8=;
        b=WpT4OJfA8dpsPlJid/1W0SPrN0a3oO+XsNbjcodyJChpH5j+ztECI8ksxelhATUk6jd+Yj
        ywVIZNSwJFzy1rDaV5wVAHWsgh/Xp0mmSc+HUDU99LDtRlz5ZtS18p7g4FE0D3QNDp469M
        Qvp2QBg42vpBSWp/t5sDKOos/m6YrIE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-sKCbQ6KZPoO8r2ez8w70Ug-1; Thu, 19 Dec 2019 12:54:56 -0500
X-MC-Unique: sKCbQ6KZPoO8r2ez8w70Ug-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F6A394EEE
        for <linux-nfs@vger.kernel.org>; Thu, 19 Dec 2019 17:54:55 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-81.phx2.redhat.com [10.3.116.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06BF47D97C
        for <linux-nfs@vger.kernel.org>; Thu, 19 Dec 2019 17:54:54 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] libnfsidmap: Turn off default verbosity
Date:   Thu, 19 Dec 2019 12:54:52 -0500
Message-Id: <20191219175452.14317-1-steved@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit f080188e changed the library's verbosity
to be on by default. The patch turns it off by
default

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1774787

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/nfsidmap/libnfsidmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/support/nfsidmap/libnfsidmap.c b/support/nfsidmap/libnfsidma=
p.c
index 9299e65..d11710f 100644
--- a/support/nfsidmap/libnfsidmap.c
+++ b/support/nfsidmap/libnfsidmap.c
@@ -101,7 +101,7 @@ static void default_logger(const char *fmt, ...)
=20
 #pragma GCC visibility pop
 nfs4_idmap_log_function_t idmap_log_func =3D default_logger;
-int idmap_verbosity =3D 2;
+int idmap_verbosity =3D 0;
 #pragma GCC visibility push(hidden)
=20
 static int id_as_chars(char *name, uid_t *id)
--=20
2.21.0

