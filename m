Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EC11B7DF3
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Apr 2020 20:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgDXSjS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Apr 2020 14:39:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44018 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726813AbgDXSjS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Apr 2020 14:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587753557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pRWjt1jNRT9b4RDTw3tQQTwJ2Uu6juw8u/PT0DtCcLI=;
        b=QYHgKi1FwI4capG+cTaOurAfoZf2zmdITkphUb9/SItbpUmXtOzZBqGGTYRy3LCArqMUsC
        gDHdLp1ltlzLKHCHVyL3wpUnSkQLUWww/ET7uvnyCzahQrwulwTSfWCrIN3/hjxBvoPP7B
        Dh4QnYQKrJiOkY6Nw6agwJCo3Dthf+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-9HxYoIRDOBqdQxRokGWk5Q-1; Fri, 24 Apr 2020 14:39:14 -0400
X-MC-Unique: 9HxYoIRDOBqdQxRokGWk5Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B8711800D42
        for <linux-nfs@vger.kernel.org>; Fri, 24 Apr 2020 18:39:14 +0000 (UTC)
Received: from localhost.localdomain (ovpn-114-147.phx2.redhat.com [10.3.114.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C245960626;
        Fri, 24 Apr 2020 18:39:13 +0000 (UTC)
From:   Tom Stellard <tstellar@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     Tom Stellard <tstellar@redhat.com>
Subject: [PATCH 2/2] Use format attribute to silence -Wformat-nonliteral warnings
Date:   Fri, 24 Apr 2020 18:39:06 +0000
Message-Id: <20200424183906.119687-3-tstellar@redhat.com>
In-Reply-To: <20200424183906.119687-1-tstellar@redhat.com>
References: <20200424183906.119687-1-tstellar@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This will also cause the compiler to add checks to ensure the
arguments are consistent with the printf format.
---
 support/nfsidmap/libnfsidmap.c | 2 +-
 utils/gssd/err_util.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/support/nfsidmap/libnfsidmap.c b/support/nfsidmap/libnfsidma=
p.c
index bce448cf..5d551e4f 100644
--- a/support/nfsidmap/libnfsidmap.c
+++ b/support/nfsidmap/libnfsidmap.c
@@ -94,7 +94,7 @@ gid_t nobody_gid =3D (gid_t)-1;
 #endif
=20
 /* Default logging fuction */
-static void default_logger(const char *fmt, ...)
+__attribute__ ((format (printf, 1, 2))) static void default_logger(const=
 char *fmt, ...)
 {
 	va_list vp;
=20
diff --git a/utils/gssd/err_util.c b/utils/gssd/err_util.c
index 2b1132ac..7179cc02 100644
--- a/utils/gssd/err_util.c
+++ b/utils/gssd/err_util.c
@@ -50,7 +50,7 @@ void initerr(char *progname, int set_verbosity, int set=
_fg)
 }
=20
=20
-void printerr(int priority, char *format, ...)
+__attribute__ ((format (printf, 2, 3))) void printerr(int priority, char=
 *format, ...)
 {
 	va_list args;
=20
--=20
2.25.3

