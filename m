Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1AB1B7DF4
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Apr 2020 20:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgDXSjT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Apr 2020 14:39:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60046 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727898AbgDXSjT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Apr 2020 14:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587753558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zT3Nhz6fr5Lbl6hQrtm6QTQfRtk2cX6yj+qVx0GtcV8=;
        b=WeFcmZs8UJtNzoJSXA39KQHkWmxfongMQABiXu5/rILSP2UelqvfGx60u177Zw0AjAUsIB
        eYSyJQElZhfiRjKBsU+2Bs2tAUw9Dz35pTbzIZ6W78/y9mN16RmHH9iBnJtsohIfnHX/V1
        WB0cGpHd0/Z/UchpSsQXccr3QGsIA4k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-mGhi0YchOpqa7wJlMs7SLA-1; Fri, 24 Apr 2020 14:39:14 -0400
X-MC-Unique: mGhi0YchOpqa7wJlMs7SLA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A881C13F7
        for <linux-nfs@vger.kernel.org>; Fri, 24 Apr 2020 18:39:13 +0000 (UTC)
Received: from localhost.localdomain (ovpn-114-147.phx2.redhat.com [10.3.114.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57A2C19629;
        Fri, 24 Apr 2020 18:39:13 +0000 (UTC)
From:   Tom Stellard <tstellar@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     Tom Stellard <tstellar@redhat.com>
Subject: [PATCH 1/2] Fix -Wformat-nonliteral warning
Date:   Fri, 24 Apr 2020 18:39:05 +0000
Message-Id: <20200424183906.119687-2-tstellar@redhat.com>
In-Reply-To: <20200424183906.119687-1-tstellar@redhat.com>
References: <20200424183906.119687-1-tstellar@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

xcommon.c:101:24: error: format string is not a string literal [-Werror,-=
Wformat-nonliteral]
     vfprintf (stderr, fmt2, args);
                       ^~~~
---
 support/nfs/xcommon.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/support/nfs/xcommon.c b/support/nfs/xcommon.c
index 3989f0bc..1d04dd11 100644
--- a/support/nfs/xcommon.c
+++ b/support/nfs/xcommon.c
@@ -94,13 +94,11 @@ xstrconcat4 (const char *s, const char *t, const char=
 *u, const char *v) {
 void
 nfs_error (const char *fmt, ...) {
      va_list args;
-     char *fmt2;
=20
-     fmt2 =3D xstrconcat2 (fmt, "\n");
      va_start (args, fmt);
-     vfprintf (stderr, fmt2, args);
+     vfprintf (stderr, fmt, args);
+     fprintf (stderr, "\n");
      va_end (args);
-     free (fmt2);
 }
=20
 /* Make a canonical pathname from PATH.  Returns a freshly malloced stri=
ng.
--=20
2.25.3

