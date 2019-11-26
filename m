Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28F0810A16B
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Nov 2019 16:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfKZPrX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Nov 2019 10:47:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35521 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728640AbfKZPrX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Nov 2019 10:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574783242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8glIoe+uaCE1EMr9+WlvtJO7cptuN17G6ARrJ+sD2OM=;
        b=D2IybterU3aw4bkB8D+Eqi822ZgjPgx/j/mz1S9AJzjiTU+IjnoPm67nIzrJ4zFk57lmJj
        cr7QmHd64lRbm2mOvuhmrKBOl8XigcvaYswOVUKIpJB5yrdQqZjTQ7WjlNfxbN6I5/wjpP
        BP6u1AO5uQt1j66zqOvgQ2Ri3izOw48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-wOSuCoErMQ67e0Pm86zuTw-1; Tue, 26 Nov 2019 10:47:20 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CEB418B9FCC
        for <linux-nfs@vger.kernel.org>; Tue, 26 Nov 2019 15:47:19 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E0495D9CA;
        Tue, 26 Nov 2019 15:47:19 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id D920B20694; Tue, 26 Nov 2019 10:47:18 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH 1/3] nfsdcld: don't override sbindir
Date:   Tue, 26 Nov 2019 10:47:16 -0500
Message-Id: <20191126154718.22645-2-smayhew@redhat.com>
In-Reply-To: <20191126154718.22645-1-smayhew@redhat.com>
References: <20191126154718.22645-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: wOSuCoErMQ67e0Pm86zuTw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

According to the guidelines in hier(7), nfsdcld should live in /usr/sbin
and not /sbin.  Plus, the nfsdcld.service systemd unit file is looking
for it in /usr/sbin.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/nfsdcld/Makefile.am | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/utils/nfsdcld/Makefile.am b/utils/nfsdcld/Makefile.am
index 2c4e5a1..273d64f 100644
--- a/utils/nfsdcld/Makefile.am
+++ b/utils/nfsdcld/Makefile.am
@@ -1,9 +1,5 @@
 ## Process this file with automake to produce Makefile.in
=20
-# These binaries go in /sbin (not /usr/sbin), and that cannot be
-# overridden at config time. The kernel "knows" the /sbin name.
-sbindir =3D /sbin
-
 man8_MANS=09=3D nfsdcld.man
 EXTRA_DIST=09=3D $(man8_MANS)
=20
--=20
2.17.2

