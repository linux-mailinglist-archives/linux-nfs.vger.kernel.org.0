Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFE0E08DD
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2019 18:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732674AbfJVQ31 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Oct 2019 12:29:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56670 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732660AbfJVQ31 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Oct 2019 12:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571761766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oc6JnYHv+WR7BhcilrYjRg6zWiQBk7nW50+Iq/r7Bm0=;
        b=Q6eNHdwjxjk3HeUKXxGH4FSuwnWUQhzwNaZpcM5l5yC5HCrvNSbOGUYC4dUSC10M8LeX86
        LuqKC0K9j5X+u1TdrC1yhyYTjx3Rww97p0gVwb6QAzZf7L8i2BBSz3ZQZvAbD3wiApPfuB
        KR3pxZYGLCBLlneezjs1WnuKYCDIG18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-a15Sj9ynOKKWciYI_Ynvmw-1; Tue, 22 Oct 2019 12:29:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E191B1005500
        for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2019 16:29:23 +0000 (UTC)
Received: from jumitche.remote.csb (unknown [10.33.36.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 655486012D
        for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2019 16:29:23 +0000 (UTC)
Message-ID: <1571761761.9226.3.camel@redhat.com>
Subject: [PATCH nfs-utils] Simplify vers string generation to fix issues
 with 4.0 handling
From:   Alice J Mitchell <ajmitchell@redhat.com>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 22 Oct 2019 17:29:21 +0100
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: a15Sj9ynOKKWciYI_Ynvmw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The existing handling does not correctly cope the case of disabling
v4.0 and then later not disabling it, the default strings omit the 4.0
flags and it thus does not get re-enabled. this simplified version
correctly handles this and other similar cases.

Signed-off-by: Alice J Mitchell <ajmitchell@redhat.com>
---
 utils/nfsd/nfsd.c   | 11 +----------
 utils/nfsd/nfssvc.c | 21 ++++++++++-----------
 utils/nfsd/nfssvc.h |  2 +-
 3 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/utils/nfsd/nfsd.c b/utils/nfsd/nfsd.c
index a412a02..0c1f6cb 100644
--- a/utils/nfsd/nfsd.c
+++ b/utils/nfsd/nfsd.c
@@ -72,7 +72,6 @@ main(int argc, char **argv)
 =09unsigned int protobits =3D NFSCTL_PROTODEFAULT;
 =09int grace =3D -1;
 =09int lease =3D -1;
-=09int force4dot0 =3D 0;
=20
 =09progname =3D basename(argv[0]);
 =09haddr =3D xmalloc(sizeof(char *));
@@ -141,14 +140,10 @@ main(int argc, char **argv)
 =09=09if (!conf_get_bool("nfsd", tag, 1)) {
 =09=09=09NFSCTL_MINORSET(minorversset, i);
 =09=09=09NFSCTL_MINORUNSET(minorvers, i);
-=09=09=09if (i =3D=3D 0)
-=09=09=09=09force4dot0 =3D 1;
 =09=09}
 =09=09if (conf_get_bool("nfsd", tag, 0)) {
 =09=09=09NFSCTL_MINORSET(minorversset, i);
 =09=09=09NFSCTL_MINORSET(minorvers, i);
-=09=09=09if (i =3D=3D 0)
-=09=09=09=09force4dot0 =3D 1;
 =09=09}
 =09}
=20
@@ -209,8 +204,6 @@ main(int argc, char **argv)
 =09=09=09=09=09}
 =09=09=09=09=09NFSCTL_MINORSET(minorversset, i);
 =09=09=09=09=09NFSCTL_MINORUNSET(minorvers, i);
-=09=09=09=09=09if (i =3D=3D 0)
-=09=09=09=09=09=09force4dot0 =3D 1;
 =09=09=09=09=09if (minorvers !=3D 0)
 =09=09=09=09=09=09break;
 =09=09=09=09} else {
@@ -238,8 +231,6 @@ main(int argc, char **argv)
 =09=09=09=09=09}
 =09=09=09=09=09NFSCTL_MINORSET(minorversset, i);
 =09=09=09=09=09NFSCTL_MINORSET(minorvers, i);
-=09=09=09=09=09if (i =3D=3D 0)
-=09=09=09=09=09=09force4dot0 =3D 1;
 =09=09=09=09} else
 =09=09=09=09=09minorvers =3D minorversset =3D minormask;
 =09=09=09=09/* FALLTHRU */
@@ -356,7 +347,7 @@ main(int argc, char **argv)
 =09 * Timeouts must also be set before ports are created else we get
 =09 * EBUSY.
 =09 */
-=09nfssvc_setvers(versbits, minorvers, minorversset, force4dot0);
+=09nfssvc_setvers(versbits, minorvers, minorversset);
 =09if (grace > 0)
 =09=09nfssvc_set_time("grace", grace);
 =09if (lease  > 0)
diff --git a/utils/nfsd/nfssvc.c b/utils/nfsd/nfssvc.c
index 720bdd9..1770ac2 100644
--- a/utils/nfsd/nfssvc.c
+++ b/utils/nfsd/nfssvc.c
@@ -368,19 +368,17 @@ out:
 }
=20
 static int
-nfssvc_print_vers(char *ptr, unsigned size, unsigned vers, unsigned minorv=
ers,
-=09=09int isset, int force4dot0)
+nfssvc_print_vers(char *ptr, unsigned size, unsigned vers, int minorvers,
+=09=09int isset)
 {
 =09char sign =3D isset ? '+' : '-';
-=09if (minorvers =3D=3D 0)
-=09=09if (linux_version_code() < MAKE_VERSION(4, 11, 0) || !force4dot0)
-=09=09=09return snprintf(ptr, size, "%c%u ", sign, vers);
+=09if (minorvers < 0)
+=09=09return snprintf(ptr, size, "%c%u ", sign, vers);
 =09return snprintf(ptr, size, "%c%u.%u ", sign, vers, minorvers);
 }
=20
 void
-nfssvc_setvers(unsigned int ctlbits, unsigned int minorvers, unsigned int =
minorversset,
-=09       int force4dot0)
+nfssvc_setvers(unsigned int ctlbits, unsigned int minorvers, unsigned int =
minorversset)
 {
 =09int fd, n, off;
=20
@@ -389,16 +387,17 @@ nfssvc_setvers(unsigned int ctlbits, unsigned int min=
orvers, unsigned int minorv
 =09if (fd < 0)
 =09=09return;
=20
-=09for (n =3D NFSD_MINVERS; n <=3D ((NFSD_MAXVERS < 3) ? NFSD_MAXVERS : 3)=
; n++)
+=09for (n =3D NFSD_MINVERS; n <=3D ((NFSD_MAXVERS < 4) ? NFSD_MAXVERS : 4)=
; n++)
 =09=09off +=3D nfssvc_print_vers(&buf[off], sizeof(buf) - off,
-=09=09=09=09n, 0, NFSCTL_VERISSET(ctlbits, n), 0);
+=09=09=09=09n, -1, NFSCTL_VERISSET(ctlbits, n));
=20
 =09for (n =3D 0; n <=3D NFS4_MAXMINOR; n++) {
 =09=09if (!NFSCTL_MINORISSET(minorversset, n))
 =09=09=09continue;
+=09=09if (n =3D=3D 0 && linux_version_code() < MAKE_VERSION(4, 11, 0))
+=09=09=09continue;
 =09=09off +=3D nfssvc_print_vers(&buf[off], sizeof(buf) - off,
-=09=09=09=094, n, NFSCTL_MINORISSET(minorvers, n),
-=09=09=09=09(n =3D=3D 0) ? force4dot0 : 0);
+=09=09=09=094, n, NFSCTL_MINORISSET(minorvers, n));
 =09}
 =09if (!off--)
 =09=09goto out;
diff --git a/utils/nfsd/nfssvc.h b/utils/nfsd/nfssvc.h
index 4d53af1..bf747b7 100644
--- a/utils/nfsd/nfssvc.h
+++ b/utils/nfsd/nfssvc.h
@@ -27,6 +27,6 @@ int=09nfssvc_set_sockets(const unsigned int protobits,
 void=09nfssvc_set_time(const char *type, const int seconds);
 int=09nfssvc_set_rdmaport(const char *port);
 void=09nfssvc_setvers(unsigned int ctlbits, unsigned int minorvers4,
-=09=09       unsigned int minorvers4set, int force4dot0);
+=09=09       unsigned int minorvers4set);
 int=09nfssvc_threads(int nrservs);
 void=09nfssvc_get_minormask(unsigned int *mask);
--=20
1.8.3.1

