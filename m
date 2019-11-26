Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8B3410A16A
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Nov 2019 16:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfKZPrW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Nov 2019 10:47:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38701 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728620AbfKZPrW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Nov 2019 10:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574783241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VRQrRgYBZsPKfq68KFpJ+l9WP997s45cG28WLAZ1K9Q=;
        b=WqPX4ml5PWg0snDYfItJ7h4dQr4a6u5G9/30HO4Xu5Y/Y/QXlyJfeKJyVGSzCVWRr2OZ4Q
        fUJP9FS7cW3pKjtdSEqyHO+EPjpIlE6s1J7mjGoSpO/iQ20Aiwk2q+NC5lPz6GUE7/6g24
        UOfk7ODzEbNEXuL8xUrIrzGr1cSdhO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-_ZK_r-7ZPkOqqwwc7ga8kQ-1; Tue, 26 Nov 2019 10:47:20 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6988E18B9FCB
        for <linux-nfs@vger.kernel.org>; Tue, 26 Nov 2019 15:47:19 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4EBB31001281;
        Tue, 26 Nov 2019 15:47:19 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id E76A020844; Tue, 26 Nov 2019 10:47:18 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH 3/3] nfsdcld: getopt_long() returns an int, not a char
Date:   Tue, 26 Nov 2019 10:47:18 -0500
Message-Id: <20191126154718.22645-4-smayhew@redhat.com>
In-Reply-To: <20191126154718.22645-1-smayhew@redhat.com>
References: <20191126154718.22645-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: _ZK_r-7ZPkOqqwwc7ga8kQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This was causing nfsdcld to spit out a usage message instead of starting
up on non-x86_64 arches.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/nfsdcld/nfsdcld.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/nfsdcld/nfsdcld.c b/utils/nfsdcld/nfsdcld.c
index 9297df5..2ad1001 100644
--- a/utils/nfsdcld/nfsdcld.c
+++ b/utils/nfsdcld/nfsdcld.c
@@ -737,7 +737,7 @@ out:
 int
 main(int argc, char **argv)
 {
-=09char arg;
+=09int arg;
 =09int rc =3D 0;
 =09bool foreground =3D false;
 =09char *progname;
--=20
2.17.2

