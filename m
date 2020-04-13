Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776691A684B
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Apr 2020 16:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgDMOol (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Apr 2020 10:44:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45109 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728557AbgDMOok (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Apr 2020 10:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586789079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wSqyBKl+wpXtU9Z0W3dj5PIs7MKtf+VZUzD4l0ECGYs=;
        b=eSQaMoRZaSqEGv/gKB0Slt8kUxDzNXl5IkKCc7JztoAW8DXHPFkbjWL4ID1PS0VnZxcpM8
        KxyLPCycv2Qwa07cOob2dXpt52QGoizXVuKszj7S2ynvHkgWwqyQerSKK4tVHr4vgRKZAo
        oWLwULf5PhGYe3gyE4ZprEh4S8GACbw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-fr3FOwJaNmSkD6-gAJfNzw-1; Mon, 13 Apr 2020 10:44:37 -0400
X-MC-Unique: fr3FOwJaNmSkD6-gAJfNzw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 571BF18C43C1
        for <linux-nfs@vger.kernel.org>; Mon, 13 Apr 2020 14:44:36 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-113-55.rdu2.redhat.com [10.10.113.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 39E945E001;
        Mon, 13 Apr 2020 14:44:36 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 738751A00A6; Mon, 13 Apr 2020 10:44:35 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH] nfsdcld: fix possible buffer overrun in sqlite_iterate_recovery()
Date:   Mon, 13 Apr 2020 10:44:35 -0400
Message-Id: <20200413144435.1220985-1-smayhew@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Prior to release, cp_data was originally intended to hold the gss
principal string.  When it was changed to hold a hash of the principal
instead, the size of the field was changed but the 'n' arg of the
memcpy() in sqlite_iterate_recovery() was not.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/nfsdcld/sqlite.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/nfsdcld/sqlite.c b/utils/nfsdcld/sqlite.c
index 09518e2..6666c86 100644
--- a/utils/nfsdcld/sqlite.c
+++ b/utils/nfsdcld/sqlite.c
@@ -1337,7 +1337,7 @@ sqlite_iterate_recovery(int (*cb)(struct cld_client=
 *clnt), struct cld_client *c
 		cmsg->cm_u.cm_clntinfo.cc_name.cn_len =3D sqlite3_column_bytes(stmt, 0=
);
 		if (sqlite3_column_bytes(stmt, 1) > 0) {
 			memcpy(&cmsg->cm_u.cm_clntinfo.cc_princhash.cp_data,
-				sqlite3_column_blob(stmt, 1), NFS4_OPAQUE_LIMIT);
+				sqlite3_column_blob(stmt, 1), SHA256_DIGEST_SIZE);
 			cmsg->cm_u.cm_clntinfo.cc_princhash.cp_len =3D sqlite3_column_bytes(s=
tmt, 1);
 		}
 #else
--=20
2.25.1

