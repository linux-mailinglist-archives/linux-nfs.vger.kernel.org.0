Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 398B119CC4A
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Apr 2020 23:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732600AbgDBVUv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Apr 2020 17:20:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30942 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727412AbgDBVUv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Apr 2020 17:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585862449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TMahs0dFL+7jWby6jv8zkqEFyP7Kw+3r93qGDC+Fe98=;
        b=aDeHBxB601PgpRHhhFVPP5JETsui70mPSDjXgNvgF4Qwol6wbb+JVrAysSNoXnlYCuNwj5
        /82LPd3V/E6kX9aTph/O9Gd4Yj4wSn9TiaWds6NrhvjeT8Y0mYdeEpc5kkJ0vT9WXZaSPZ
        5/MPeNldoKdzWmJIm8lMG5nGhq8F++I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-VeQgcmLlMHW4zcFrXfsjeQ-1; Thu, 02 Apr 2020 17:20:46 -0400
X-MC-Unique: VeQgcmLlMHW4zcFrXfsjeQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 050DE18A6EC7;
        Thu,  2 Apr 2020 21:20:45 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-113-45.rdu2.redhat.com [10.10.113.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DD69A99E11;
        Thu,  2 Apr 2020 21:20:44 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 5D4841A02B4; Thu,  2 Apr 2020 17:20:44 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     aglo@umich.edu, linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Fix a few constant_table array definitions
Date:   Thu,  2 Apr 2020 17:20:44 -0400
Message-Id: <20200402212044.10318-1-smayhew@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfs_vers_tokens, nfs_xprt_protocol_tokens, and nfs_secflavor_tokens were
all missing an empty item at the end of the array, allowing
lookup_constant() to potentially walk off the end and trigger and oops.

Reported-by: Olga Kornievskaia <aglo@umich.edu>
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/fs_context.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index e113fcb4bb4c..1c8d8bedf34e 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -190,6 +190,7 @@ static const struct constant_table nfs_vers_tokens[] =
=3D {
 	{ "4.0",	Opt_vers_4_0 },
 	{ "4.1",	Opt_vers_4_1 },
 	{ "4.2",	Opt_vers_4_2 },
+	{}
 };
=20
 enum {
@@ -202,13 +203,14 @@ enum {
 	nr__Opt_xprt
 };
=20
-static const struct constant_table nfs_xprt_protocol_tokens[nr__Opt_xprt=
] =3D {
+static const struct constant_table nfs_xprt_protocol_tokens[] =3D {
 	{ "rdma",	Opt_xprt_rdma },
 	{ "rdma6",	Opt_xprt_rdma6 },
 	{ "tcp",	Opt_xprt_tcp },
 	{ "tcp6",	Opt_xprt_tcp6 },
 	{ "udp",	Opt_xprt_udp },
 	{ "udp6",	Opt_xprt_udp6 },
+	{}
 };
=20
 enum {
@@ -239,6 +241,7 @@ static const struct constant_table nfs_secflavor_toke=
ns[] =3D {
 	{ "spkm3i",	Opt_sec_spkmi },
 	{ "spkm3p",	Opt_sec_spkmp },
 	{ "sys",	Opt_sec_sys },
+	{}
 };
=20
 /*
--=20
2.25.1

