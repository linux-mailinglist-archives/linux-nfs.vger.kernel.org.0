Return-Path: <linux-nfs+bounces-8503-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412539EB0CB
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 13:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF235169CA0
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 12:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DA319F438;
	Tue, 10 Dec 2024 12:30:11 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5663A1A08A8
	for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2024 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733833811; cv=none; b=RcFZPOsRCA6R2pNI3oyfyFqGpoN7xUvH9tJJJG77IKM71tm7UPRMo9YIXYbwm6tT0wkFPDsxh+qE72Zg/il9I78kKskdZdJqpo3vLxnZY5H2alBvrUp0V58oTnlQv4VJdRKEiKH5ZUhBV3rNVPoP3baE07YPBqt/q2W5vLtCUas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733833811; c=relaxed/simple;
	bh=rYT/ikpg9VJQCEQjwsRxNCHeHpVLbTuZFwcVsghB8pY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=tdB42CIjDl0ReigQdsG2iUWHrEswuXlI/IqZN3iElGc0ltSVvScBthleCs2focRy+2E/mxQYZYs7ZrjAHxUkPH6jlMaPyI5TZ6zlMo/K3s9GChpq/LrtIbOu2n3p0wtENMb5J09Nh/UAnwzhjbZnCb8lVsXYXLmvmdoB1kpBoRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org; spf=fail smtp.mailfrom=nrubsig.org; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nrubsig.org
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-unJMSIFJPIuO9FivT-jgjw-1; Tue,
 10 Dec 2024 07:28:51 -0500
X-MC-Unique: unJMSIFJPIuO9FivT-jgjw-1
X-Mimecast-MFC-AGG-ID: unJMSIFJPIuO9FivT-jgjw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1AFEA1955F3E
	for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2024 12:28:51 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.22.80.156])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 62C021956048
	for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2024 12:28:50 +0000 (UTC)
From: Roland Mainz <roland.mainz@nrubsig.org>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH V2] mount.nfs4: Add support for nfs://-URLs
Date: Tue, 10 Dec 2024 07:28:46 -0500
Message-ID: <20241210122846.821199-1-roland.mainz@nrubsig.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -Xe0FG5v44KYsiek_GxCH-6QZ7I9jaxCTw_hbxmORYs_1733833731
X-Mimecast-Originator: nrubsig.org
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true

Add support for RFC 2224-style nfs://-URLs as alternative to the
traditional hostname:/path+-o port=3D<tcp-port> notation,
providing standardised, extensible, single-string, crossplatform,
portable, Character-Encoding independent (e.g. mount point with
Japanese, Chinese, French etc. characters) and ASCII-compatible
descriptions of NFSv4 server resources (exports).

Reviewed-by: Martin Wege <martin.l.wege@gmail.com>
Signed-off-by: Marvin Wenzel <marvin.wenzel@rovema.de>
Signed-off-by: Cedric Blancher <cedric.blancher@gmail.com>
---
 utils/mount/Makefile.am  |   3 +-
 utils/mount/mount.c      |   3 +
 utils/mount/nfs4mount.c  |  69 +++++++-
 utils/mount/nfsmount.c   |  93 ++++++++--
 utils/mount/parse_dev.c  |  67 ++++++--
 utils/mount/stropts.c    |  96 ++++++++++-
 utils/mount/urlparser1.c | 358 +++++++++++++++++++++++++++++++++++++++
 utils/mount/urlparser1.h |  60 +++++++
 utils/mount/utils.c      | 155 +++++++++++++++++
 utils/mount/utils.h      |  23 +++
 10 files changed, 890 insertions(+), 37 deletions(-)
 create mode 100644 utils/mount/urlparser1.c
 create mode 100644 utils/mount/urlparser1.h

diff --git a/utils/mount/Makefile.am b/utils/mount/Makefile.am
index 83a8ee1c..0e4cab3e 100644
--- a/utils/mount/Makefile.am
+++ b/utils/mount/Makefile.am
@@ -13,7 +13,8 @@ sbin_PROGRAMS=09=3D mount.nfs
 EXTRA_DIST =3D nfsmount.conf $(man8_MANS) $(man5_MANS)
 mount_common =3D error.c network.c token.c \
 =09=09    parse_opt.c parse_dev.c \
-=09=09    nfsmount.c nfs4mount.c stropts.c\
+=09=09    nfsmount.c nfs4mount.c \
+=09=09    urlparser1.c urlparser1.h stropts.c \
 =09=09    mount_constants.h error.h network.h token.h \
 =09=09    parse_opt.h parse_dev.h \
 =09=09    nfs4_mount.h stropts.h version.h \
diff --git a/utils/mount/mount.c b/utils/mount/mount.c
index b98f9e00..2ce6209d 100644
--- a/utils/mount/mount.c
+++ b/utils/mount/mount.c
@@ -29,6 +29,7 @@
 #include <string.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <locale.h>
 #include <sys/mount.h>
 #include <getopt.h>
 #include <mntent.h>
@@ -386,6 +387,8 @@ int main(int argc, char *argv[])
 =09char *extra_opts =3D NULL, *mount_opts =3D NULL;
 =09uid_t uid =3D getuid();
=20
+=09(void)setlocale(LC_ALL, "");
+
 =09progname =3D basename(argv[0]);
=20
 =09nfs_mount_data_version =3D discover_nfs_mount_data_version(&string);
diff --git a/utils/mount/nfs4mount.c b/utils/mount/nfs4mount.c
index 0fe142a7..8e4fbf30 100644
--- a/utils/mount/nfs4mount.c
+++ b/utils/mount/nfs4mount.c
@@ -50,8 +50,10 @@
 #include "mount_constants.h"
 #include "nfs4_mount.h"
 #include "nfs_mount.h"
+#include "urlparser1.h"
 #include "error.h"
 #include "network.h"
+#include "utils.h"
=20
 #if defined(VAR_LOCK_DIR)
 #define DEFAULT_DIR VAR_LOCK_DIR
@@ -182,7 +184,7 @@ int nfs4mount(const char *spec, const char *node, int f=
lags,
 =09int num_flavour =3D 0;
 =09int ip_addr_in_opts =3D 0;
=20
-=09char *hostname, *dirname, *old_opts;
+=09char *hostname, *dirname, *mb_dirname =3D NULL, *old_opts;
 =09char new_opts[1024];
 =09char *opt, *opteq;
 =09char *s;
@@ -192,15 +194,66 @@ int nfs4mount(const char *spec, const char *node, int=
 flags,
 =09int retry;
 =09int retval =3D EX_FAIL;
 =09time_t timeout, t;
+=09int nfs_port =3D NFS_PORT;
+=09parsed_nfs_url pnu;
+
+=09(void)memset(&pnu, 0, sizeof(parsed_nfs_url));
=20
 =09if (strlen(spec) >=3D sizeof(hostdir)) {
 =09=09nfs_error(_("%s: excessively long host:dir argument\n"),
 =09=09=09=09progname);
 =09=09goto fail;
 =09}
-=09strcpy(hostdir, spec);
-=09if (parse_devname(hostdir, &hostname, &dirname))
-=09=09goto fail;
+
+=09/*
+=09 * Support nfs://-URLS per RFC 2224 ("NFS URL
+=09 * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
+=09 * including custom port (nfs://hostname@port/path/...)
+=09 * and URL parameter (e.g. nfs://.../?param1=3Dval1&param2=3Dval2
+=09 * support
+=09 */
+=09if (is_spec_nfs_url(spec)) {
+=09=09if (!mount_parse_nfs_url(spec, &pnu)) {
+=09=09=09goto fail;
+=09=09}
+
+=09=09/*
+=09=09 * |pnu.uctx->path| is in UTF-8, but we need the data
+=09=09 * in the current local locale's encoding, as mount(2)
+=09=09 * does not have something like a |MS_UTF8_SPEC| flag
+=09=09 * to indicate that the input path is in UTF-8,
+=09=09 * independently of the current locale
+=09=09 */
+=09=09hostname =3D pnu.uctx->hostport.hostname;
+=09=09dirname =3D mb_dirname =3D utf8str2mbstr(pnu.uctx->path);
+
+=09=09(void)snprintf(hostdir, sizeof(hostdir), "%s:/%s",
+=09=09=09hostname, dirname);
+=09=09spec =3D hostdir;
+
+=09=09if (pnu.uctx->hostport.port !=3D -1) {
+=09=09=09nfs_port =3D pnu.uctx->hostport.port;
+=09=09}
+
+=09=09/*
+=09=09 * Values added here based on URL parameters
+=09=09 * should be added the front of the list of options,
+=09=09 * so users can override the nfs://-URL given default.
+=09=09 *
+=09=09 * FIXME: We do not do that here for |MS_RDONLY|!
+=09=09 */
+=09=09if (pnu.mount_params.read_only !=3D TRIS_BOOL_NOT_SET) {
+=09=09=09if (pnu.mount_params.read_only)
+=09=09=09=09flags |=3D MS_RDONLY;
+=09=09=09else
+=09=09=09=09flags &=3D ~MS_RDONLY;
+=09=09}
+        } else {
+=09=09(void)strcpy(hostdir, spec);
+
+=09=09if (parse_devname(hostdir, &hostname, &dirname))
+=09=09=09goto fail;
+=09}
=20
 =09if (fill_ipv4_sockaddr(hostname, &server_addr))
 =09=09goto fail;
@@ -247,7 +300,7 @@ int nfs4mount(const char *spec, const char *node, int f=
lags,
 =09/*
 =09 * NFSv4 specifies that the default port should be 2049
 =09 */
-=09server_addr.sin_port =3D htons(NFS_PORT);
+=09server_addr.sin_port =3D htons(nfs_port);
=20
 =09/* parse options */
=20
@@ -474,8 +527,14 @@ int nfs4mount(const char *spec, const char *node, int =
flags,
 =09=09}
 =09}
=20
+=09mount_free_parse_nfs_url(&pnu);
+=09free(mb_dirname);
+
 =09return EX_SUCCESS;
=20
 fail:
+=09mount_free_parse_nfs_url(&pnu);
+=09free(mb_dirname);
+
 =09return retval;
 }
diff --git a/utils/mount/nfsmount.c b/utils/mount/nfsmount.c
index a1c92fe8..e61d718a 100644
--- a/utils/mount/nfsmount.c
+++ b/utils/mount/nfsmount.c
@@ -63,11 +63,13 @@
 #include "xcommon.h"
 #include "mount.h"
 #include "nfs_mount.h"
+#include "urlparser1.h"
 #include "mount_constants.h"
 #include "nls.h"
 #include "error.h"
 #include "network.h"
 #include "version.h"
+#include "utils.h"
=20
 #ifdef HAVE_RPCSVC_NFS_PROT_H
 #include <rpcsvc/nfs_prot.h>
@@ -493,7 +495,7 @@ nfsmount(const char *spec, const char *node, int flags,
 =09 char **extra_opts, int fake, int running_bg)
 {
 =09char hostdir[1024];
-=09char *hostname, *dirname, *old_opts, *mounthost =3D NULL;
+=09char *hostname, *dirname, *mb_dirname =3D NULL, *old_opts, *mounthost =
=3D NULL;
 =09char new_opts[1024], cbuf[1024];
 =09static struct nfs_mount_data data;
 =09int val;
@@ -521,29 +523,79 @@ nfsmount(const char *spec, const char *node, int flag=
s,
 =09time_t t;
 =09time_t prevt;
 =09time_t timeout;
+=09int nfsurl_port =3D -1;
+=09parsed_nfs_url pnu;
+
+=09(void)memset(&pnu, 0, sizeof(parsed_nfs_url));
=20
 =09if (strlen(spec) >=3D sizeof(hostdir)) {
 =09=09nfs_error(_("%s: excessively long host:dir argument"),
 =09=09=09=09progname);
 =09=09goto fail;
 =09}
-=09strcpy(hostdir, spec);
-=09if ((s =3D strchr(hostdir, ':'))) {
-=09=09hostname =3D hostdir;
-=09=09dirname =3D s + 1;
-=09=09*s =3D '\0';
-=09=09/* Ignore all but first hostname in replicated mounts
-=09=09   until they can be fully supported. (mack@sgi.com) */
-=09=09if ((s =3D strchr(hostdir, ','))) {
+
+=09/*
+=09 * Support nfs://-URLS per RFC 2224 ("NFS URL
+=09 * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
+=09 * including custom port (nfs://hostname@port/path/...)
+=09 * and URL parameter (e.g. nfs://.../?param1=3Dval1&param2=3Dval2
+=09 * support
+=09 */
+=09if (is_spec_nfs_url(spec)) {
+=09=09if (!mount_parse_nfs_url(spec, &pnu)) {
+=09=09=09goto fail;
+=09=09}
+
+=09=09/*
+=09=09 * |pnu.uctx->path| is in UTF-8, but we need the data
+=09=09 * in the current local locale's encoding, as mount(2)
+=09=09 * does not have something like a |MS_UTF8_SPEC| flag
+=09=09 * to indicate that the input path is in UTF-8,
+=09=09 * independently of the current locale
+=09=09 */
+=09=09hostname =3D pnu.uctx->hostport.hostname;
+=09=09dirname =3D mb_dirname =3D utf8str2mbstr(pnu.uctx->path);
+
+=09=09(void)snprintf(hostdir, sizeof(hostdir), "%s:/%s",
+=09=09=09hostname, dirname);
+=09=09spec =3D hostdir;
+
+=09=09if (pnu.uctx->hostport.port !=3D -1) {
+=09=09=09nfsurl_port =3D pnu.uctx->hostport.port;
+=09=09}
+
+=09=09/*
+=09=09 * Values added here based on URL parameters
+=09=09 * should be added the front of the list of options,
+=09=09 * so users can override the nfs://-URL given default.
+=09=09 *
+=09=09 * FIXME: We do not do that here for |MS_RDONLY|!
+=09=09 */
+=09=09if (pnu.mount_params.read_only !=3D TRIS_BOOL_NOT_SET) {
+=09=09=09if (pnu.mount_params.read_only)
+=09=09=09=09flags |=3D MS_RDONLY;
+=09=09=09else
+=09=09=09=09flags &=3D ~MS_RDONLY;
+=09=09}
+        } else {
+=09=09(void)strcpy(hostdir, spec);
+=09=09if ((s =3D strchr(hostdir, ':'))) {
+=09=09=09hostname =3D hostdir;
+=09=09=09dirname =3D s + 1;
 =09=09=09*s =3D '\0';
-=09=09=09nfs_error(_("%s: warning: "
-=09=09=09=09  "multiple hostnames not supported"),
+=09=09=09/* Ignore all but first hostname in replicated mounts
+=09=09=09   until they can be fully supported. (mack@sgi.com) */
+=09=09=09if ((s =3D strchr(hostdir, ','))) {
+=09=09=09=09*s =3D '\0';
+=09=09=09=09nfs_error(_("%s: warning: "
+=09=09=09=09=09"multiple hostnames not supported"),
 =09=09=09=09=09progname);
-=09=09}
-=09} else {
-=09=09nfs_error(_("%s: directory to mount not in host:dir format"),
+=09=09=09}
+=09=09} else {
+=09=09=09nfs_error(_("%s: directory to mount not in host:dir format"),
 =09=09=09=09progname);
-=09=09goto fail;
+=09=09=09goto fail;
+=09=09}
 =09}
=20
 =09if (!nfs_gethostbyname(hostname, nfs_saddr))
@@ -579,6 +631,14 @@ nfsmount(const char *spec, const char *node, int flags=
,
 =09memset(nfs_pmap, 0, sizeof(*nfs_pmap));
 =09nfs_pmap->pm_prog =3D NFS_PROGRAM;
=20
+=09if (nfsurl_port !=3D -1) {
+=09=09/*
+=09=09 * Set custom TCP port defined by a nfs://-URL here,
+=09=09 * so $ mount -o port ... # can be used to override
+=09=09 */
+=09=09nfs_pmap->pm_port =3D nfsurl_port;
+=09}
+
 =09/* parse options */
 =09new_opts[0] =3D 0;
 =09if (!parse_options(old_opts, &data, &bg, &retry, &mnt_server, &nfs_serv=
er,
@@ -863,10 +923,13 @@ noauth_flavors:
 =09=09}
 =09}
=20
+=09mount_free_parse_nfs_url(&pnu);
+
 =09return EX_SUCCESS;
=20
 =09/* abort */
  fail:
+=09mount_free_parse_nfs_url(&pnu);
 =09if (fsock !=3D -1)
 =09=09close(fsock);
 =09return retval;
diff --git a/utils/mount/parse_dev.c b/utils/mount/parse_dev.c
index 2ade5d5d..d9f8cf59 100644
--- a/utils/mount/parse_dev.c
+++ b/utils/mount/parse_dev.c
@@ -27,6 +27,8 @@
 #include "xcommon.h"
 #include "nls.h"
 #include "parse_dev.h"
+#include "urlparser1.h"
+#include "utils.h"
=20
 #ifndef NFS_MAXHOSTNAME
 #define NFS_MAXHOSTNAME=09=09(255)
@@ -179,17 +181,62 @@ static int nfs_parse_square_bracket(const char *dev,
 }
=20
 /*
- * RFC 2224 says an NFS client must grok "public file handles" to
- * support NFS URLs.  Linux doesn't do that yet.  Print a somewhat
- * helpful error message in this case instead of pressing forward
- * with the mount request and failing with a cryptic error message
- * later.
+ * Support nfs://-URLS per RFC 2224 ("NFS URL
+ * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
+ * including port support (nfs://hostname@port/path/...)
  */
-static int nfs_parse_nfs_url(__attribute__((unused)) const char *dev,
-=09=09=09     __attribute__((unused)) char **hostname,
-=09=09=09     __attribute__((unused)) char **pathname)
+static int nfs_parse_nfs_url(const char *dev,
+=09=09=09     char **out_hostname,
+=09=09=09     char **out_pathname)
 {
-=09nfs_error(_("%s: NFS URLs are not supported"), progname);
+=09parsed_nfs_url pnu;
+
+=09if (out_hostname)
+=09=09*out_hostname =3D NULL;
+=09if (out_pathname)
+=09=09*out_pathname =3D NULL;
+
+=09/*
+=09 * Support nfs://-URLS per RFC 2224 ("NFS URL
+=09 * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
+=09 * including custom port (nfs://hostname@port/path/...)
+=09 * and URL parameter (e.g. nfs://.../?param1=3Dval1&param2=3Dval2
+=09 * support
+=09 */
+=09if (!mount_parse_nfs_url(dev, &pnu)) {
+=09=09goto fail;
+=09}
+
+=09if (pnu.uctx->hostport.port !=3D -1) {
+=09=09/* NOP here, unless we switch from hostname to hostport */
+=09}
+
+=09if (out_hostname)
+=09=09*out_hostname =3D strdup(pnu.uctx->hostport.hostname);
+=09if (out_pathname)
+=09=09*out_pathname =3D utf8str2mbstr(pnu.uctx->path);
+
+=09if (((out_hostname)?(*out_hostname =3D=3D NULL):0) ||
+=09=09((out_pathname)?(*out_pathname =3D=3D NULL):0)) {
+=09=09nfs_error(_("%s: out of memory"),
+=09=09=09progname);
+=09=09goto fail;
+=09}
+
+=09mount_free_parse_nfs_url(&pnu);
+
+=09return 1;
+
+fail:
+=09mount_free_parse_nfs_url(&pnu);
+=09if (out_hostname) {
+=09=09free(*out_hostname);
+=09=09*out_hostname =3D NULL;
+=09}
+=09if (out_pathname) {
+=09=09free(*out_pathname);
+=09=09*out_pathname =3D NULL;
+=09}
 =09return 0;
 }
=20
@@ -223,7 +270,7 @@ int nfs_parse_devname(const char *devname,
 =09=09return nfs_pdn_nomem_err();
 =09if (*dev =3D=3D '[')
 =09=09result =3D nfs_parse_square_bracket(dev, hostname, pathname);
-=09else if (strncmp(dev, "nfs://", 6) =3D=3D 0)
+=09else if (is_spec_nfs_url(dev))
 =09=09result =3D nfs_parse_nfs_url(dev, hostname, pathname);
 =09else
 =09=09result =3D nfs_parse_simple_hostname(dev, hostname, pathname);
diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
index 23f0a8c0..ad92ab78 100644
--- a/utils/mount/stropts.c
+++ b/utils/mount/stropts.c
@@ -42,6 +42,7 @@
 #include "nls.h"
 #include "nfsrpc.h"
 #include "mount_constants.h"
+#include "urlparser1.h"
 #include "stropts.h"
 #include "error.h"
 #include "network.h"
@@ -50,6 +51,7 @@
 #include "parse_dev.h"
 #include "conffile.h"
 #include "misc.h"
+#include "utils.h"
=20
 #ifndef NFS_PROGRAM
 #define NFS_PROGRAM=09(100003)
@@ -643,24 +645,106 @@ static int nfs_sys_mount(struct nfsmount_info *mi, s=
truct mount_options *opts)
 {
 =09char *options =3D NULL;
 =09int result;
+=09int nfs_port =3D 2049;
=20
 =09if (mi->fake)
 =09=09return 1;
=20
-=09if (po_join(opts, &options) =3D=3D PO_FAILED) {
-=09=09errno =3D EIO;
-=09=09return 0;
-=09}
+=09/*
+=09 * Support nfs://-URLS per RFC 2224 ("NFS URL
+=09 * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
+=09 * including custom port (nfs://hostname@port/path/...)
+=09 * and URL parameter (e.g. nfs://.../?param1=3Dval1&param2=3Dval2
+=09 * support
+=09 */
+=09if (is_spec_nfs_url(mi->spec)) {
+=09=09parsed_nfs_url pnu;
+=09=09char *mb_path;
+=09=09char mount_source[1024];
+
+=09=09if (!mount_parse_nfs_url(mi->spec, &pnu)) {
+=09=09=09result =3D 1;
+=09=09=09errno =3D EINVAL;
+=09=09=09goto done;
+=09=09}
+
+=09=09/*
+=09=09 * |pnu.uctx->path| is in UTF-8, but we need the data
+=09=09 * in the current local locale's encoding, as mount(2)
+=09=09 * does not have something like a |MS_UTF8_SPEC| flag
+=09=09 * to indicate that the input path is in UTF-8,
+=09=09 * independently of the current locale
+=09=09 */
+=09=09mb_path =3D utf8str2mbstr(pnu.uctx->path);
+=09=09if (!mb_path) {
+=09=09=09nfs_error(_("%s: Could not convert path to local encoding."),
+=09=09=09=09progname);
+=09=09=09mount_free_parse_nfs_url(&pnu);
+=09=09=09result =3D 1;
+=09=09=09errno =3D EINVAL;
+=09=09=09goto done;
+=09=09}
+
+=09=09(void)snprintf(mount_source, sizeof(mount_source),
+=09=09=09"%s:/%s",
+=09=09=09pnu.uctx->hostport.hostname,
+=09=09=09mb_path);
+=09=09free(mb_path);
+
+=09=09if (pnu.uctx->hostport.port !=3D -1) {
+=09=09=09nfs_port =3D pnu.uctx->hostport.port;
+=09=09}
=20
-=09result =3D mount(mi->spec, mi->node, mi->type,
+=09=09/*
+=09=09 * Insert "port=3D" option with the value from the nfs://
+=09=09 * URL at the beginning of the list of options, so
+=09=09 * users can override it with $ mount.nfs4 -o port=3D #,
+=09=09 * e.g.
+=09=09 * $ mount.nfs4 -o port=3D1234 nfs://10.49.202.230:400//bigdisk /mnt=
4 #
+=09=09 * should use port 1234, and not port 400 as specified
+=09=09 * in the URL.
+=09=09 */
+=09=09char portoptbuf[5+32+1];
+=09=09(void)snprintf(portoptbuf, sizeof(portoptbuf), "port=3D%d", nfs_port=
);
+=09=09(void)po_insert(opts, portoptbuf);
+
+=09=09if (pnu.mount_params.read_only !=3D TRIS_BOOL_NOT_SET) {
+=09=09=09if (pnu.mount_params.read_only)
+=09=09=09=09mi->flags |=3D MS_RDONLY;
+=09=09=09else
+=09=09=09=09mi->flags &=3D ~MS_RDONLY;
+=09=09}
+
+=09=09mount_free_parse_nfs_url(&pnu);
+
+=09=09if (po_join(opts, &options) =3D=3D PO_FAILED) {
+=09=09=09errno =3D EIO;
+=09=09=09result =3D 1;
+=09=09=09goto done;
+=09=09}
+
+=09=09result =3D mount(mount_source, mi->node, mi->type,
+=09=09=09mi->flags & ~(MS_USER|MS_USERS), options);
+=09=09free(options);
+=09} else {
+=09=09if (po_join(opts, &options) =3D=3D PO_FAILED) {
+=09=09=09errno =3D EIO;
+=09=09=09result =3D 1;
+=09=09=09goto done;
+=09=09}
+
+=09=09result =3D mount(mi->spec, mi->node, mi->type,
 =09=09=09mi->flags & ~(MS_USER|MS_USERS), options);
-=09free(options);
+=09=09free(options);
+=09}
=20
 =09if (verbose && result) {
 =09=09int save =3D errno;
 =09=09nfs_error(_("%s: mount(2): %s"), progname, strerror(save));
 =09=09errno =3D save;
 =09}
+
+done:
 =09return !result;
 }
=20
diff --git a/utils/mount/urlparser1.c b/utils/mount/urlparser1.c
new file mode 100644
index 00000000..d4c6f339
--- /dev/null
+++ b/utils/mount/urlparser1.c
@@ -0,0 +1,358 @@
+/*
+ * MIT License
+ *
+ * Copyright (c) 2024 Roland Mainz <roland.mainz@nrubsig.org>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this software and associated documentation files (the "Software"), t=
o deal
+ * in the Software without restriction, including without limitation the r=
ights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in all
+ * copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL=
 THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN THE
+ * SOFTWARE.
+ */
+
+/* urlparser1.c - simple URL parser */
+
+#include <stdlib.h>
+#include <stdbool.h>
+#include <string.h>
+#include <ctype.h>
+#include <stdio.h>
+
+#ifdef DBG_USE_WIDECHAR
+#include <wchar.h>
+#include <locale.h>
+#include <io.h>
+#include <fcntl.h>
+#endif /* DBG_USE_WIDECHAR */
+
+#include "urlparser1.h"
+
+typedef struct _url_parser_context_private {
+=09url_parser_context c;
+
+=09/* Private data */
+=09char *parameter_string_buff;
+} url_parser_context_private;
+
+#define MAX_URL_PARAMETERS 256
+
+/*
+ * Original extended regular expression:
+ *
+ * "^"
+ * "(.+?)"=09=09=09=09// scheme
+ * "://"=09=09=09=09// '://'
+ * "("=09=09=09=09=09// login
+ *=09"(?:"
+ *=09"(.+?)"=09=09=09=09// user (optional)
+ *=09=09"(?::(.+))?"=09=09// password (optional)
+ *=09=09"@"
+ *=09")?"
+ *=09"("=09=09=09=09// hostport
+ *=09=09"(.+?)"=09=09=09// host
+ *=09=09"(?::([[:digit:]]+))?"=09// port (optional)
+ *=09")"
+ * ")"
+ * "(?:/(.*?))?"=09=09=09// path (optional)
+ * "(?:\?(.*?))?"=09=09=09// URL parameters (optional)
+ * "$"
+ */
+
+#define DBGNULLSTR(s) (((s)!=3DNULL)?(s):"<NULL>")
+#if 0 || defined(TEST_URLPARSER)
+#define D(x) x
+#else
+#define D(x)
+#endif
+
+#ifdef DBG_USE_WIDECHAR
+/*
+ * Use wide-char APIs on WIN32, otherwise we cannot output
+ * Japanese/Chinese/etc correctly
+ */
+#define DBG_PUTS(str, fp)=09=09fputws(L"" str, (fp))
+#define DBG_PUTC(c, fp)=09=09=09fputwc(btowc(c), (fp))
+#define DBG_PRINTF(fp, fmt, ...)=09fwprintf((fp), L"" fmt, __VA_ARGS__)
+#else
+#define DBG_PUTS(str, fp)=09=09fputs((str), (fp))
+#define DBG_PUTC(c, fp)=09=09=09fputc((c), (fp))
+#define DBG_PRINTF(fp, fmt, ...)=09fprintf((fp), fmt, __VA_ARGS__)
+#endif /* DBG_USE_WIDECHAR */
+
+static
+void urldecodestr(char *outbuff, const char *buffer, size_t len)
+{
+=09size_t i, j;
+
+=09for (i =3D j =3D 0 ; i < len ; ) {
+=09=09switch (buffer[i]) {
+=09=09=09case '%':
+=09=09=09=09if ((i + 2) < len) {
+=09=09=09=09=09if (isxdigit((int)buffer[i+1]) && isxdigit((int)buffer[i+2]=
)) {
+=09=09=09=09=09=09const char hexstr[3] =3D {
+=09=09=09=09=09=09=09buffer[i+1],
+=09=09=09=09=09=09=09buffer[i+2],
+=09=09=09=09=09=09=09'\0'
+=09=09=09=09=09=09};
+=09=09=09=09=09=09outbuff[j++] =3D (unsigned char)strtol(hexstr, NULL, 16)=
;
+=09=09=09=09=09=09i +=3D 3;
+=09=09=09=09=09} else {
+=09=09=09=09=09=09/* invalid hex digit */
+=09=09=09=09=09=09outbuff[j++] =3D buffer[i];
+=09=09=09=09=09=09i++;
+=09=09=09=09=09}
+=09=09=09=09} else {
+=09=09=09=09=09/* incomplete hex digit */
+=09=09=09=09=09outbuff[j++] =3D buffer[i];
+=09=09=09=09=09i++;
+=09=09=09=09}
+=09=09=09=09break;
+=09=09=09case '+':
+=09=09=09=09outbuff[j++] =3D ' ';
+=09=09=09=09i++;
+=09=09=09=09break;
+=09=09=09default:
+=09=09=09=09outbuff[j++] =3D buffer[i++];
+=09=09=09=09break;
+=09=09}
+=09}
+
+=09outbuff[j] =3D '\0';
+}
+
+url_parser_context *url_parser_create_context(const char *in_url, unsigned=
 int flags)
+{
+=09url_parser_context_private *uctx;
+=09char *s;
+=09size_t in_url_len;
+=09size_t context_len;
+
+=09/* |flags| is for future extensions */
+=09(void)flags;
+
+=09if (!in_url)
+=09=09return NULL;
+
+=09in_url_len =3D strlen(in_url);
+
+=09context_len =3D sizeof(url_parser_context_private) +
+=09=09((in_url_len+1)*6) +
+=09=09(sizeof(url_parser_name_value)*MAX_URL_PARAMETERS)+sizeof(void*);
+=09uctx =3D malloc(context_len);
+=09if (!uctx)
+=09=09return NULL;
+
+=09s =3D (void *)(uctx+1);
+=09uctx->c.in_url =3D s;=09=09s+=3D in_url_len+1;
+=09(void)strcpy(uctx->c.in_url, in_url);
+=09uctx->c.scheme =3D s;=09=09s+=3D in_url_len+1;
+=09uctx->c.login.username =3D s;=09s+=3D in_url_len+1;
+=09uctx->c.hostport.hostname =3D s;=09s+=3D in_url_len+1;
+=09uctx->c.path =3D s;=09=09s+=3D in_url_len+1;
+=09uctx->c.hostport.port =3D -1;
+=09uctx->c.num_parameters =3D -1;
+=09uctx->c.parameters =3D (void *)s;=09=09s+=3D (sizeof(url_parser_name_va=
lue)*MAX_URL_PARAMETERS)+sizeof(void*);
+=09uctx->parameter_string_buff =3D s;=09s+=3D in_url_len+1;
+
+=09return &uctx->c;
+}
+
+int url_parser_parse(url_parser_context *ctx)
+{
+=09url_parser_context_private *uctx =3D (url_parser_context_private *)ctx;
+
+=09D((void)DBG_PRINTF(stderr, "## parser in_url=3D'%s'\n", uctx->c.in_url)=
);
+
+=09char *s;
+=09const char *urlstr =3D uctx->c.in_url;
+=09size_t slen;
+
+=09s =3D strstr(urlstr, "://");
+=09if (!s) {
+=09=09D((void)DBG_PUTS("url_parser: Not an URL\n", stderr));
+=09=09return -1;
+=09}
+
+=09slen =3D s-urlstr;
+=09(void)memcpy(uctx->c.scheme, urlstr, slen);
+=09uctx->c.scheme[slen] =3D '\0';
+=09urlstr +=3D slen + 3;
+
+=09D((void)DBG_PRINTF(stdout, "scheme=3D'%s', rest=3D'%s'\n", uctx->c.sche=
me, urlstr));
+
+=09s =3D strstr(urlstr, "@");
+=09if (s) {
+=09=09/* URL has user/password */
+=09=09slen =3D s-urlstr;
+=09=09urldecodestr(uctx->c.login.username, urlstr, slen);
+=09=09urlstr +=3D slen + 1;
+
+=09=09s =3D strstr(uctx->c.login.username, ":");
+=09=09if (s) {
+=09=09=09/* found passwd */
+=09=09=09uctx->c.login.passwd =3D s+1;
+=09=09=09*s =3D '\0';
+=09=09}
+=09=09else {
+=09=09=09uctx->c.login.passwd =3D NULL;
+=09=09}
+
+=09=09/* catch password-only URLs */
+=09=09if (uctx->c.login.username[0] =3D=3D '\0')
+=09=09=09uctx->c.login.username =3D NULL;
+=09}
+=09else {
+=09=09uctx->c.login.username =3D NULL;
+=09=09uctx->c.login.passwd =3D NULL;
+=09}
+
+=09D((void)DBG_PRINTF(stdout, "login=3D'%s', passwd=3D'%s', rest=3D'%s'\n"=
,
+=09=09DBGNULLSTR(uctx->c.login.username),
+=09=09DBGNULLSTR(uctx->c.login.passwd),
+=09=09DBGNULLSTR(urlstr)));
+
+=09char *raw_parameters;
+
+=09uctx->c.num_parameters =3D 0;
+=09raw_parameters =3D strstr(urlstr, "?");
+=09/* Do we have a non-empty parameter string ? */
+=09if (raw_parameters && (raw_parameters[1] !=3D '\0')) {
+=09=09*raw_parameters++ =3D '\0';
+=09=09D((void)DBG_PRINTF(stdout, "raw parameters =3D '%s'\n", raw_paramete=
rs));
+
+=09=09char *ps =3D raw_parameters;
+=09=09char *pv; /* parameter value */
+=09=09char *na; /* next '&' */
+=09=09char *pb =3D uctx->parameter_string_buff;
+=09=09char *pname;
+=09=09char *pvalue;
+=09=09ssize_t pi;
+
+=09=09for (pi =3D 0; pi < MAX_URL_PARAMETERS ; pi++) {
+=09=09=09pname =3D ps;
+
+=09=09=09/*
+=09=09=09 * Handle parameters without value,
+=09=09=09 * e.g. "path?name1&name2=3Dvalue2"
+=09=09=09 */
+=09=09=09na =3D strstr(ps, "&");
+=09=09=09pv =3D strstr(ps, "=3D");
+=09=09=09if (pv && (na?(na > pv):true)) {
+=09=09=09=09*pv++ =3D '\0';
+=09=09=09=09pvalue =3D pv;
+=09=09=09=09ps =3D pv;
+=09=09=09}
+=09=09=09else {
+=09=09=09=09pvalue =3D NULL;
+=09=09=09}
+
+=09=09=09if (na) {
+=09=09=09=09*na++ =3D '\0';
+=09=09=09}
+
+=09=09=09/* URLDecode parameter name */
+=09=09=09urldecodestr(pb, pname, strlen(pname));
+=09=09=09uctx->c.parameters[pi].name =3D pb;
+=09=09=09pb +=3D strlen(uctx->c.parameters[pi].name)+1;
+
+=09=09=09/* URLDecode parameter value */
+=09=09=09if (pvalue) {
+=09=09=09=09urldecodestr(pb, pvalue, strlen(pvalue));
+=09=09=09=09uctx->c.parameters[pi].value =3D pb;
+=09=09=09=09pb +=3D strlen(uctx->c.parameters[pi].value)+1;
+=09=09=09}
+=09=09=09else {
+=09=09=09=09uctx->c.parameters[pi].value =3D NULL;
+=09=09=09}
+
+=09=09=09/* Next '&' ? */
+=09=09=09if (!na)
+=09=09=09=09break;
+
+=09=09=09ps =3D na;
+=09=09}
+
+=09=09uctx->c.num_parameters =3D pi+1;
+=09}
+
+=09s =3D strstr(urlstr, "/");
+=09if (s) {
+=09=09/* URL has hostport */
+=09=09slen =3D s-urlstr;
+=09=09urldecodestr(uctx->c.hostport.hostname, urlstr, slen);
+=09=09urlstr +=3D slen + 1;
+
+=09=09/*
+=09=09 * check for addresses within '[' and ']', like
+=09=09 * IPv6 addresses
+=09=09 */
+=09=09s =3D uctx->c.hostport.hostname;
+=09=09if (s[0] =3D=3D '[')
+=09=09=09s =3D strstr(s, "]");
+
+=09=09if (s =3D=3D NULL) {
+=09=09=09D((void)DBG_PUTS("url_parser: Unmatched '[' in hostname\n", stder=
r));
+=09=09=09return -1;
+=09=09}
+
+=09=09s =3D strstr(s, ":");
+=09=09if (s) {
+=09=09=09/* found port number */
+=09=09=09uctx->c.hostport.port =3D atoi(s+1);
+=09=09=09*s =3D '\0';
+=09=09}
+=09}
+=09else {
+=09=09(void)strcpy(uctx->c.hostport.hostname, urlstr);
+=09=09uctx->c.path =3D NULL;
+=09=09urlstr =3D NULL;
+=09}
+
+=09D(
+=09=09(void)DBG_PRINTF(stdout,
+=09=09=09"hostport=3D'%s', port=3D%d, rest=3D'%s', num_parameters=3D%d\n",
+=09=09=09DBGNULLSTR(uctx->c.hostport.hostname),
+=09=09=09uctx->c.hostport.port,
+=09=09=09DBGNULLSTR(urlstr),
+=09=09=09(int)uctx->c.num_parameters);
+=09);
+
+
+=09D(
+=09=09ssize_t dpi;
+=09=09for (dpi =3D 0 ; dpi < uctx->c.num_parameters ; dpi++) {
+=09=09=09(void)DBG_PRINTF(stdout,
+=09=09=09=09"param[%d]: name=3D'%s'/value=3D'%s'\n",
+=09=09=09=09(int)dpi,
+=09=09=09=09uctx->c.parameters[dpi].name,
+=09=09=09=09DBGNULLSTR(uctx->c.parameters[dpi].value));
+=09=09}
+=09);
+
+=09if (!urlstr) {
+=09=09goto done;
+=09}
+
+=09urldecodestr(uctx->c.path, urlstr, strlen(urlstr));
+=09D((void)DBG_PRINTF(stdout, "path=3D'%s'\n", uctx->c.path));
+
+done:
+=09return 0;
+}
+
+void url_parser_free_context(url_parser_context *c)
+{
+=09free(c);
+}
diff --git a/utils/mount/urlparser1.h b/utils/mount/urlparser1.h
new file mode 100644
index 00000000..515eea9d
--- /dev/null
+++ b/utils/mount/urlparser1.h
@@ -0,0 +1,60 @@
+/*
+ * MIT License
+ *
+ * Copyright (c) 2024 Roland Mainz <roland.mainz@nrubsig.org>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this software and associated documentation files (the "Software"), t=
o deal
+ * in the Software without restriction, including without limitation the r=
ights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in all
+ * copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL=
 THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN THE
+ * SOFTWARE.
+ */
+
+/* urlparser1.h - header for simple URL parser */
+
+#ifndef __URLPARSER1_H__
+#define __URLPARSER1_H__ 1
+
+#include <stdlib.h>
+
+typedef struct _url_parser_name_value {
+=09char *name;
+=09char *value;
+} url_parser_name_value;
+
+typedef struct _url_parser_context {
+=09char *in_url;
+
+=09char *scheme;
+=09struct {
+=09=09char *username;
+=09=09char *passwd;
+=09} login;
+=09struct {
+=09=09char *hostname;
+=09=09signed int port;
+=09} hostport;
+=09char *path;
+
+=09ssize_t num_parameters;
+=09url_parser_name_value *parameters;
+} url_parser_context;
+
+/* Prototypes */
+url_parser_context *url_parser_create_context(const char *in_url, unsigned=
 int flags);
+int url_parser_parse(url_parser_context *uctx);
+void url_parser_free_context(url_parser_context *c);
+
+#endif /* !__URLPARSER1_H__ */
diff --git a/utils/mount/utils.c b/utils/mount/utils.c
index b7562a47..3d55e997 100644
--- a/utils/mount/utils.c
+++ b/utils/mount/utils.c
@@ -28,6 +28,7 @@
 #include <unistd.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <iconv.h>
=20
 #include "sockaddr.h"
 #include "nfs_mount.h"
@@ -173,3 +174,157 @@ int nfs_umount23(const char *devname, char *string)
 =09free(dirname);
 =09return result;
 }
+
+/* Convert UTF-8 string to multibyte string in the current locale */
+char *utf8str2mbstr(const char *utf8_str)
+{
+=09iconv_t cd;
+
+=09cd =3D iconv_open("", "UTF-8");
+=09if (cd =3D=3D (iconv_t)-1) {
+=09=09perror("utf8str2mbstr: iconv_open failed");
+=09=09return NULL;
+=09}
+
+=09size_t inbytesleft =3D strlen(utf8_str);
+=09char *inbuf =3D (char *)utf8_str;
+=09size_t outbytesleft =3D inbytesleft*4+1;
+=09char *outbuf =3D malloc(outbytesleft);
+=09char *outbuf_orig =3D outbuf;
+
+=09if (!outbuf) {
+=09=09perror("utf8str2mbstr: out of memory");
+=09=09(void)iconv_close(cd);
+=09=09return NULL;
+=09}
+
+=09int ret =3D iconv(cd, &inbuf, &inbytesleft, &outbuf, &outbytesleft);
+=09if (ret =3D=3D -1) {
+=09=09perror("utf8str2mbstr: iconv() failed");
+=09=09free(outbuf_orig);
+=09=09(void)iconv_close(cd);
+=09=09return NULL;
+=09}
+
+=09*outbuf =3D '\0';
+
+=09(void)iconv_close(cd);
+=09return outbuf_orig;
+}
+
+/* fixme: We should use |bool|! */
+int is_spec_nfs_url(const char *spec)
+{
+=09return (!strncmp(spec, "nfs://", 6));
+}
+
+int mount_parse_nfs_url(const char *spec, parsed_nfs_url *pnu)
+{
+=09int result =3D 1;
+=09url_parser_context *uctx =3D NULL;
+
+=09(void)memset(pnu, 0, sizeof(parsed_nfs_url));
+=09pnu->mount_params.read_only =3D TRIS_BOOL_NOT_SET;
+
+=09uctx =3D url_parser_create_context(spec, 0);
+=09if (!uctx) {
+=09=09nfs_error(_("%s: out of memory"),
+=09=09=09progname);
+=09=09result =3D 1;
+=09=09goto done;
+=09}
+
+=09if (url_parser_parse(uctx) < 0) {
+=09=09nfs_error(_("%s: Error parsing nfs://-URL."),
+=09=09=09progname);
+=09=09result =3D 1;
+=09=09goto done;
+=09}
+=09if (uctx->login.username || uctx->login.passwd) {
+=09=09nfs_error(_("%s: Username/Password are not defined for nfs://-URL.")=
,
+=09=09=09progname);
+=09=09result =3D 1;
+=09=09goto done;
+=09}
+=09if (!uctx->path) {
+=09=09nfs_error(_("%s: Path missing in nfs://-URL."),
+=09=09=09progname);
+=09=09result =3D 1;
+=09=09goto done;
+=09}
+=09if (uctx->path[0] !=3D '/') {
+=09=09nfs_error(_("%s: Relative nfs://-URLs are not supported."),
+=09=09=09progname);
+=09=09result =3D 1;
+=09=09goto done;
+=09}
+
+=09if (uctx->num_parameters > 0) {
+=09=09int pi;
+=09=09const char *pname;
+=09=09const char *pvalue;
+
+=09=09/*
+=09=09 * Values added here based on URL parameters
+=09=09 * should be added the front of the list of options,
+=09=09 * so users can override the nfs://-URL given default.
+=09=09 */
+=09=09for (pi =3D 0; pi < uctx->num_parameters ; pi++) {
+=09=09=09pname =3D uctx->parameters[pi].name;
+=09=09=09pvalue =3D uctx->parameters[pi].value;
+
+=09=09=09if (!strcmp(pname, "rw")) {
+=09=09=09=09if ((pvalue =3D=3D NULL) || (!strcmp(pvalue, "1"))) {
+=09=09=09=09=09pnu->mount_params.read_only =3D TRIS_BOOL_FALSE;
+=09=09=09=09}
+=09=09=09=09else if (!strcmp(pvalue, "0")) {
+=09=09=09=09=09pnu->mount_params.read_only =3D TRIS_BOOL_TRUE;
+=09=09=09=09}
+=09=09=09=09else {
+=09=09=09=09=09nfs_error(_("%s: Unsupported nfs://-URL "
+=09=09=09=09=09=09"parameter '%s' value '%s'."),
+=09=09=09=09=09=09progname, pname, pvalue);
+=09=09=09=09=09result =3D 1;
+=09=09=09=09=09goto done;
+=09=09=09=09}
+=09=09=09}
+=09=09=09else if (!strcmp(pname, "ro")) {
+=09=09=09=09if ((pvalue =3D=3D NULL) || (!strcmp(pvalue, "1"))) {
+=09=09=09=09=09pnu->mount_params.read_only =3D TRIS_BOOL_TRUE;
+=09=09=09=09}
+=09=09=09=09else if (!strcmp(pvalue, "0")) {
+=09=09=09=09=09pnu->mount_params.read_only =3D TRIS_BOOL_FALSE;
+=09=09=09=09}
+=09=09=09=09else {
+=09=09=09=09=09nfs_error(_("%s: Unsupported nfs://-URL "
+=09=09=09=09=09=09"parameter '%s' value '%s'."),
+=09=09=09=09=09=09progname, pname, pvalue);
+=09=09=09=09=09result =3D 1;
+=09=09=09=09=09goto done;
+=09=09=09=09}
+=09=09=09}
+=09=09=09else {
+=09=09=09=09nfs_error(_("%s: Unsupported nfs://-URL "
+=09=09=09=09=09=09"parameter '%s'."),
+=09=09=09=09=09progname, pname);
+=09=09=09=09result =3D 1;
+=09=09=09=09goto done;
+=09=09=09}
+=09=09}
+=09}
+
+=09result =3D 0;
+done:
+=09if (result !=3D 0) {
+=09=09url_parser_free_context(uctx);
+=09=09return 0;
+=09}
+
+=09pnu->uctx =3D uctx;
+=09return 1;
+}
+
+void mount_free_parse_nfs_url(parsed_nfs_url *pnu)
+{
+=09url_parser_free_context(pnu->uctx);
+}
diff --git a/utils/mount/utils.h b/utils/mount/utils.h
index 224918ae..465c0a5e 100644
--- a/utils/mount/utils.h
+++ b/utils/mount/utils.h
@@ -24,13 +24,36 @@
 #define _NFS_UTILS_MOUNT_UTILS_H
=20
 #include "parse_opt.h"
+#include "urlparser1.h"
=20
+/* Boolean with three states: { not_set, false, true */
+typedef signed char tristate_bool;
+#define TRIS_BOOL_NOT_SET (-1)
+#define TRIS_BOOL_TRUE (1)
+#define TRIS_BOOL_FALSE (0)
+
+#define TRIS_BOOL_GET_VAL(tsb, tsb_default) \
+=09(((tsb)!=3DTRIS_BOOL_NOT_SET)?(tsb):(tsb_default))
+
+typedef struct _parsed_nfs_url {
+=09url_parser_context *uctx;
+=09struct {
+=09=09tristate_bool read_only;
+=09} mount_params;
+} parsed_nfs_url;
+
+/* Prototypes */
 int discover_nfs_mount_data_version(int *string_ver);
 void print_one(char *spec, char *node, char *type, char *opts);
 void mount_usage(void);
 void umount_usage(void);
 int chk_mountpoint(const char *mount_point);
+char *utf8str2mbstr(const char *utf8_str);
+int is_spec_nfs_url(const char *spec);
=20
 int nfs_umount23(const char *devname, char *string);
=20
+int mount_parse_nfs_url(const char *spec, parsed_nfs_url *pnu);
+void mount_free_parse_nfs_url(parsed_nfs_url *pnu);
+
 #endif=09/* !_NFS_UTILS_MOUNT_UTILS_H */
--=20
2.30.2


