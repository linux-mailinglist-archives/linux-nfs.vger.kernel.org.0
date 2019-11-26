Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0A0210A16C
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Nov 2019 16:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfKZPrX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Nov 2019 10:47:23 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21386 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728620AbfKZPrX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Nov 2019 10:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574783242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zx3+WHOqf+QPSHd0o58wVu48U2o0GqPsWDqk3svFzyE=;
        b=AJ7dFhR56TSCoBpEGcMzPY9zZRm0Y1nAD7P6wNdFkmm0fYoJh7P2MUWIY+ZBhjOsC0zS5r
        XDVIqkGhzdf2FUklIJxDFiVE/pfidmx3ptRLD1/LYZWuqZkXJNcHHeKbLeAOAR9qeF9+28
        RF/+yAXn0+5sxSgtiaqRqIGnuxN0Nq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-e81MP0fKMz-fISGmwxyEMA-1; Tue, 26 Nov 2019 10:47:20 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68D07DB3D
        for <linux-nfs@vger.kernel.org>; Tue, 26 Nov 2019 15:47:19 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C36E60BEC;
        Tue, 26 Nov 2019 15:47:19 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id E1C56207A3; Tue, 26 Nov 2019 10:47:18 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH 2/3] systemd: install nfsdcld.service when nfsdcld is enabled
Date:   Tue, 26 Nov 2019 10:47:17 -0500
Message-Id: <20191126154718.22645-3-smayhew@redhat.com>
In-Reply-To: <20191126154718.22645-1-smayhew@redhat.com>
References: <20191126154718.22645-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: e81MP0fKMz-fISGmwxyEMA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 systemd/Makefile.am | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/systemd/Makefile.am b/systemd/Makefile.am
index 590258a..75cdd9f 100644
--- a/systemd/Makefile.am
+++ b/systemd/Makefile.am
@@ -36,6 +36,11 @@ unit_files +=3D \
 endif
 endif
=20
+if CONFIG_NFSDCLD
+unit_files +=3D \
+    nfsdcld.service
+endif
+
 man5_MANS=09=3D nfs.conf.man
 man7_MANS=09=3D nfs.systemd.man
 EXTRA_DIST =3D $(unit_files) $(man5_MANS) $(man7_MANS)
--=20
2.17.2

