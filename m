Return-Path: <linux-nfs+bounces-8400-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7669E7B32
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 22:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4641885FC6
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 21:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AFA22C6C3;
	Fri,  6 Dec 2024 21:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b="j9CB16bx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A91C1AAA3A
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 21:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733522113; cv=pass; b=K+vd5cFHkBVJszpK3XFuIVlkWrp3tg14KRS7bwqEEuBm9h8g0L4cqE33SVuYdsGB7I0z/9X1+OOfCraMwuigeVIkDBY/0Nk0PznLjHMemw58p1ODWU8WnSCF0kcS6/mvJhmmPEgdy8lAZ6zbenSm4pXvXIr+yzt9mXHT+Vb3Y/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733522113; c=relaxed/simple;
	bh=Aa6ScYxM8byctXVCNLA+hyXEXC3dq7KRMpzsBr9o0eU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=HPHh4lkGhWjZjQolaYR36/rgk3rDgzrWs+QnjyZ+xVN0+MBdeuf9sPqPwT5dxBuaAT/NQwx4VCRFB1ENUyl3D9TTecLqiTNMA+dpsfDuEzY1q7E4cbTDWlRNe72QHPj7D/8QB4sememTOTZd3+wqfOYeLYEqq0YNKfIMr9h8+FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org; spf=pass smtp.mailfrom=nrubsig.org; dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b=j9CB16bx; arc=pass smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id CAFF483206
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 21:49:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com (100-100-193-123.trex-nlb.outbound.svc.cluster.local [100.100.193.123])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 454F3831B8
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 21:49:41 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1733521781; a=rsa-sha256;
	cv=none;
	b=yTMu3RMhAD+jOla7mhl1uOWpRVBDAJ/YN6Tnm7fTUrwIOgU2XMU5Mb6LtsFkZAzgvfcS11
	G93cJy0KrjuLG544RrAd7SHGXhptLtz/IYC1K6q+xyDTEO9VjO95zVLwtnk+jHIQoprlbY
	At2cV+H6w+4pbZ7QQcdVQV3Tijd5Nz55CT74pWsEW2ppiNp0L8o+rWpCJh18bt+FgL0si/
	V0/8E21wj+HXJY2zwrfo8WzMrz++JzsOW07iCp5Sry249fIU7agO9Iy+kt6JJ4LVzsOSvJ
	vyDrn4pggyBvwwHV+YhheeCLTXIzLHXI3F3Pb5kJXOofIvC/lasYqJtxgdii5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1733521781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 dkim-signature; bh=JHW9+BLDb6FdQWY9b+Cr3LtnQIsf2q9EvC/hZX1qjnc=;
	b=u8xLqBzzvbTLrvPjIBCAgBFOk7ZbVnYX+kdK4SYfOy5WDvl3APvZ8OArrKopjK/FFGjpeV
	rgRcxAXralbrZi7Wv8ST8arTPdL6eygI2whLIWwGDh3ns/TCQIpbYO4nbPqZsErkQAH7u7
	GssuKkCMNUr+8bkqG7kPXELd3GQxceykIag58toCnDBq7/qf/uMII2UFXLQ6nV35DFQ5a3
	/owlrfkS+wLEYSz33J0GfC/gJH9IcEMziB2VrVFX30NZvWkd6FgD5VVkjcHHfgI0V+28Jo
	XolsTvNnxF2OzsnnB+Em8CacvmrN2Gxp21PeAp8Iowoq/1mH8udVf9UCVaK8yg==
ARC-Authentication-Results: i=1;
	rspamd-fc7fd4597-ml46n;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=roland.mainz@nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|gisburn@nrubsig.org
X-MailChannels-Auth-Id: dreamhost
X-Hook-Macabre: 473a1ed95533fa6a_1733521781512_3936271966
X-MC-Loop-Signature: 1733521781512:2536033328
X-MC-Ingress-Time: 1733521781511
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.100.193.123 (trex/7.0.2);
	Fri, 06 Dec 2024 21:49:41 +0000
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: gisburn@nrubsig.org)
	by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4Y4lKJ1zj3z82
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 13:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nrubsig.org;
	s=dreamhost; t=1733521780;
	bh=JHW9+BLDb6FdQWY9b+Cr3LtnQIsf2q9EvC/hZX1qjnc=;
	h=From:Date:Subject:To:Content-Type;
	b=j9CB16bxdp2qG2izatOnbgdtV8Dd+C5oHil16R97ZI5Nd//z3/orLkm9WHSIfPjhg
	 fTmdR/JQVlSGo2PYc8zG0HxcoO8DeaO41lB/EmBahtaaMhx1TyylqZllCT4iSA5yzT
	 vSFoTvdD3P0uWhRyyjfs4aPoez+3EvpZMOk6xmCzKZFRKKaAhZ6BDNMPXZyrJEJJmH
	 aDe7sZ5r9uNJn31xv5kIpEp729BJB0n3+FEFewIPiTdZAR6+FzqLpP2j1W2K9CYsGm
	 xBto7ksqYGd4ip0Wf6BL2ZhLQ2pC0X2wj1F2CvXGdXVEWwJpz17Aga1gGZIUZrSsX0
	 xjZ0BJtbOGH5w==
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385eed29d17so1994546f8f.0
        for <linux-nfs@vger.kernel.org>; Fri, 06 Dec 2024 13:49:40 -0800 (PST)
X-Gm-Message-State: AOJu0YyAg71bFtuyyvA2A7eK+zH+bEDVOrWW1+eI79F6Lh9QI4Q4/8xF
	lFz0R4xe2Go6qdq7gYntfRK4G4oeCRlVVguroFAelkWoJk8jMQlkSR9cH0UJzV/7VOn0B34boEg
	wRbS/ObBXJ5X5uDIhuggQazejJsk=
X-Google-Smtp-Source: AGHT+IE9d/K9HawH+x4II2mgfz8ifBssm7MRUKAt+x//cuO0PR0oziw51si3q65vxMu6AxU7jeFYrOQIRhN7ZfM1HHk=
X-Received: by 2002:a05:6000:2b0f:b0:385:f417:ee3d with SMTP id
 ffacd0b85a97d-3862b38147amr2376312f8f.35.1733521778183; Fri, 06 Dec 2024
 13:49:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Fri, 6 Dec 2024 22:49:10 +0100
X-Gmail-Original-Message-ID: <CAKAoaQk-T=yBU2jJ=E_WcSmbPPkKk78N_tkTacL7Nu=udUDNFg@mail.gmail.com>
Message-ID: <CAKAoaQk-T=yBU2jJ=E_WcSmbPPkKk78N_tkTacL7Nu=udUDNFg@mail.gmail.com>
Subject: [patch v2] mount.nfs: Add support for nfs://-URLs ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000ccb28f0628a0fd7d"

--000000000000ccb28f0628a0fd7d
Content-Type: text/plain; charset="UTF-8"

Hi!

----

Below (also attached as
"0001-mount.nfs4-Add-support-for-nfs-URLs_v2.patch" and available at
https://nrubsig.kpaste.net/e8c5cb) is version 2 of the patch which
adds support for nfs://-URLs in mount.nfs4, as alternative to the
traditional hostname:/path+-o port=<tcp-port> notation.

* Main advantages are:
- Single-line notation with the familiar URL syntax, which includes
hostname, path *AND* TCP port number (last one is a common generator
of *PAIN* with ISPs) in ONE string
- Support for non-ASCII mount points, e.g. paths with CJKV (Chinese,
Japanese, ...) characters, which is typically a big problem if you try
to transfer such mount point information across email/chat/clipboard
etc., which tends to mangle such characters to death (e.g.
transliteration, adding of ZWSP or just '?').
- URL parameters are supported, providing support for future extensions

* Notes:
- Similar support for nfs://-URLs exists in other NFSv4.*
implementations, including Illumos, Windows ms-nfs41-client,
sahlberg/libnfs, ...
- This is NOT about WebNFS, this is only to use an URL representation
to make the life of admins a LOT easier
- Only absolute paths are supported
- This feature will not be provided for NFSv3

* Patch version history:
- v2:
Added |setlocale()| for libc versions which need it
- v1:
Initial patch

---- snip ----
From 767e1aa096bacd4dd600d46ccaaefbc47ba863bf Mon Sep 17 00:00:00 2001
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Fri, 6 Dec 2024 15:22:23 +0100
Subject: [PATCH] mount.nfs4: Add support for nfs://-URLs

Add support for RFC 2224-style nfs://-URLs as alternative to the
traditional hostname:/path+-o port=<tcp-port> notation,
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
@@ -13,7 +13,8 @@ sbin_PROGRAMS = mount.nfs
 EXTRA_DIST = nfsmount.conf $(man8_MANS) $(man5_MANS)
 mount_common = error.c network.c token.c \
      parse_opt.c parse_dev.c \
-     nfsmount.c nfs4mount.c stropts.c\
+     nfsmount.c nfs4mount.c \
+     urlparser1.c urlparser1.h stropts.c \
      mount_constants.h error.h network.h token.h \
      parse_opt.h parse_dev.h \
      nfs4_mount.h stropts.h version.h \
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
  char *extra_opts = NULL, *mount_opts = NULL;
  uid_t uid = getuid();

+ (void)setlocale(LC_ALL, "");
+
  progname = basename(argv[0]);

  nfs_mount_data_version = discover_nfs_mount_data_version(&string);
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

 #if defined(VAR_LOCK_DIR)
 #define DEFAULT_DIR VAR_LOCK_DIR
@@ -182,7 +184,7 @@ int nfs4mount(const char *spec, const char *node, int flags,
  int num_flavour = 0;
  int ip_addr_in_opts = 0;

- char *hostname, *dirname, *old_opts;
+ char *hostname, *dirname, *mb_dirname = NULL, *old_opts;
  char new_opts[1024];
  char *opt, *opteq;
  char *s;
@@ -192,15 +194,66 @@ int nfs4mount(const char *spec, const char
*node, int flags,
  int retry;
  int retval = EX_FAIL;
  time_t timeout, t;
+ int nfs_port = NFS_PORT;
+ parsed_nfs_url pnu;
+
+ (void)memset(&pnu, 0, sizeof(parsed_nfs_url));

  if (strlen(spec) >= sizeof(hostdir)) {
  nfs_error(_("%s: excessively long host:dir argument\n"),
  progname);
  goto fail;
  }
- strcpy(hostdir, spec);
- if (parse_devname(hostdir, &hostname, &dirname))
- goto fail;
+
+ /*
+ * Support nfs://-URLS per RFC 2224 ("NFS URL
+ * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
+ * including custom port (nfs://hostname@port/path/...)
+ * and URL parameter (e.g. nfs://.../?param1=val1&param2=val2
+ * support
+ */
+ if (is_spec_nfs_url(spec)) {
+ if (!mount_parse_nfs_url(spec, &pnu)) {
+ goto fail;
+ }
+
+ /*
+ * |pnu.uctx->path| is in UTF-8, but we need the data
+ * in the current local locale's encoding, as mount(2)
+ * does not have something like a |MS_UTF8_SPEC| flag
+ * to indicate that the input path is in UTF-8,
+ * independently of the current locale
+ */
+ hostname = pnu.uctx->hostport.hostname;
+ dirname = mb_dirname = utf8str2mbstr(pnu.uctx->path);
+
+ (void)snprintf(hostdir, sizeof(hostdir), "%s:/%s",
+ hostname, dirname);
+ spec = hostdir;
+
+ if (pnu.uctx->hostport.port != -1) {
+ nfs_port = pnu.uctx->hostport.port;
+ }
+
+ /*
+ * Values added here based on URL parameters
+ * should be added the front of the list of options,
+ * so users can override the nfs://-URL given default.
+ *
+ * FIXME: We do not do that here for |MS_RDONLY|!
+ */
+ if (pnu.mount_params.read_only != TRIS_BOOL_NOT_SET) {
+ if (pnu.mount_params.read_only)
+ flags |= MS_RDONLY;
+ else
+ flags &= ~MS_RDONLY;
+ }
+        } else {
+ (void)strcpy(hostdir, spec);
+
+ if (parse_devname(hostdir, &hostname, &dirname))
+ goto fail;
+ }

  if (fill_ipv4_sockaddr(hostname, &server_addr))
  goto fail;
@@ -247,7 +300,7 @@ int nfs4mount(const char *spec, const char *node, int flags,
  /*
  * NFSv4 specifies that the default port should be 2049
  */
- server_addr.sin_port = htons(NFS_PORT);
+ server_addr.sin_port = htons(nfs_port);

  /* parse options */

@@ -474,8 +527,14 @@ int nfs4mount(const char *spec, const char *node,
int flags,
  }
  }

+ mount_free_parse_nfs_url(&pnu);
+ free(mb_dirname);
+
  return EX_SUCCESS;

 fail:
+ mount_free_parse_nfs_url(&pnu);
+ free(mb_dirname);
+
  return retval;
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

 #ifdef HAVE_RPCSVC_NFS_PROT_H
 #include <rpcsvc/nfs_prot.h>
@@ -493,7 +495,7 @@ nfsmount(const char *spec, const char *node, int flags,
  char **extra_opts, int fake, int running_bg)
 {
  char hostdir[1024];
- char *hostname, *dirname, *old_opts, *mounthost = NULL;
+ char *hostname, *dirname, *mb_dirname = NULL, *old_opts, *mounthost = NULL;
  char new_opts[1024], cbuf[1024];
  static struct nfs_mount_data data;
  int val;
@@ -521,29 +523,79 @@ nfsmount(const char *spec, const char *node, int flags,
  time_t t;
  time_t prevt;
  time_t timeout;
+ int nfsurl_port = -1;
+ parsed_nfs_url pnu;
+
+ (void)memset(&pnu, 0, sizeof(parsed_nfs_url));

  if (strlen(spec) >= sizeof(hostdir)) {
  nfs_error(_("%s: excessively long host:dir argument"),
  progname);
  goto fail;
  }
- strcpy(hostdir, spec);
- if ((s = strchr(hostdir, ':'))) {
- hostname = hostdir;
- dirname = s + 1;
- *s = '\0';
- /* Ignore all but first hostname in replicated mounts
-    until they can be fully supported. (mack@sgi.com) */
- if ((s = strchr(hostdir, ','))) {
+
+ /*
+ * Support nfs://-URLS per RFC 2224 ("NFS URL
+ * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
+ * including custom port (nfs://hostname@port/path/...)
+ * and URL parameter (e.g. nfs://.../?param1=val1&param2=val2
+ * support
+ */
+ if (is_spec_nfs_url(spec)) {
+ if (!mount_parse_nfs_url(spec, &pnu)) {
+ goto fail;
+ }
+
+ /*
+ * |pnu.uctx->path| is in UTF-8, but we need the data
+ * in the current local locale's encoding, as mount(2)
+ * does not have something like a |MS_UTF8_SPEC| flag
+ * to indicate that the input path is in UTF-8,
+ * independently of the current locale
+ */
+ hostname = pnu.uctx->hostport.hostname;
+ dirname = mb_dirname = utf8str2mbstr(pnu.uctx->path);
+
+ (void)snprintf(hostdir, sizeof(hostdir), "%s:/%s",
+ hostname, dirname);
+ spec = hostdir;
+
+ if (pnu.uctx->hostport.port != -1) {
+ nfsurl_port = pnu.uctx->hostport.port;
+ }
+
+ /*
+ * Values added here based on URL parameters
+ * should be added the front of the list of options,
+ * so users can override the nfs://-URL given default.
+ *
+ * FIXME: We do not do that here for |MS_RDONLY|!
+ */
+ if (pnu.mount_params.read_only != TRIS_BOOL_NOT_SET) {
+ if (pnu.mount_params.read_only)
+ flags |= MS_RDONLY;
+ else
+ flags &= ~MS_RDONLY;
+ }
+        } else {
+ (void)strcpy(hostdir, spec);
+ if ((s = strchr(hostdir, ':'))) {
+ hostname = hostdir;
+ dirname = s + 1;
  *s = '\0';
- nfs_error(_("%s: warning: "
-   "multiple hostnames not supported"),
+ /* Ignore all but first hostname in replicated mounts
+    until they can be fully supported. (mack@sgi.com) */
+ if ((s = strchr(hostdir, ','))) {
+ *s = '\0';
+ nfs_error(_("%s: warning: "
+ "multiple hostnames not supported"),
  progname);
- }
- } else {
- nfs_error(_("%s: directory to mount not in host:dir format"),
+ }
+ } else {
+ nfs_error(_("%s: directory to mount not in host:dir format"),
  progname);
- goto fail;
+ goto fail;
+ }
  }

  if (!nfs_gethostbyname(hostname, nfs_saddr))
@@ -579,6 +631,14 @@ nfsmount(const char *spec, const char *node, int flags,
  memset(nfs_pmap, 0, sizeof(*nfs_pmap));
  nfs_pmap->pm_prog = NFS_PROGRAM;

+ if (nfsurl_port != -1) {
+ /*
+ * Set custom TCP port defined by a nfs://-URL here,
+ * so $ mount -o port ... # can be used to override
+ */
+ nfs_pmap->pm_port = nfsurl_port;
+ }
+
  /* parse options */
  new_opts[0] = 0;
  if (!parse_options(old_opts, &data, &bg, &retry, &mnt_server, &nfs_server,
@@ -863,10 +923,13 @@ noauth_flavors:
  }
  }

+ mount_free_parse_nfs_url(&pnu);
+
  return EX_SUCCESS;

  /* abort */
  fail:
+ mount_free_parse_nfs_url(&pnu);
  if (fsock != -1)
  close(fsock);
  return retval;
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

 #ifndef NFS_MAXHOSTNAME
 #define NFS_MAXHOSTNAME (255)
@@ -179,17 +181,62 @@ static int nfs_parse_square_bracket(const char *dev,
 }

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
-      __attribute__((unused)) char **hostname,
-      __attribute__((unused)) char **pathname)
+static int nfs_parse_nfs_url(const char *dev,
+      char **out_hostname,
+      char **out_pathname)
 {
- nfs_error(_("%s: NFS URLs are not supported"), progname);
+ parsed_nfs_url pnu;
+
+ if (out_hostname)
+ *out_hostname = NULL;
+ if (out_pathname)
+ *out_pathname = NULL;
+
+ /*
+ * Support nfs://-URLS per RFC 2224 ("NFS URL
+ * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
+ * including custom port (nfs://hostname@port/path/...)
+ * and URL parameter (e.g. nfs://.../?param1=val1&param2=val2
+ * support
+ */
+ if (!mount_parse_nfs_url(dev, &pnu)) {
+ goto fail;
+ }
+
+ if (pnu.uctx->hostport.port != -1) {
+ /* NOP here, unless we switch from hostname to hostport */
+ }
+
+ if (out_hostname)
+ *out_hostname = strdup(pnu.uctx->hostport.hostname);
+ if (out_pathname)
+ *out_pathname = utf8str2mbstr(pnu.uctx->path);
+
+ if (((out_hostname)?(*out_hostname == NULL):0) ||
+ ((out_pathname)?(*out_pathname == NULL):0)) {
+ nfs_error(_("%s: out of memory"),
+ progname);
+ goto fail;
+ }
+
+ mount_free_parse_nfs_url(&pnu);
+
+ return 1;
+
+fail:
+ mount_free_parse_nfs_url(&pnu);
+ if (out_hostname) {
+ free(*out_hostname);
+ *out_hostname = NULL;
+ }
+ if (out_pathname) {
+ free(*out_pathname);
+ *out_pathname = NULL;
+ }
  return 0;
 }

@@ -223,7 +270,7 @@ int nfs_parse_devname(const char *devname,
  return nfs_pdn_nomem_err();
  if (*dev == '[')
  result = nfs_parse_square_bracket(dev, hostname, pathname);
- else if (strncmp(dev, "nfs://", 6) == 0)
+ else if (is_spec_nfs_url(dev))
  result = nfs_parse_nfs_url(dev, hostname, pathname);
  else
  result = nfs_parse_simple_hostname(dev, hostname, pathname);
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

 #ifndef NFS_PROGRAM
 #define NFS_PROGRAM (100003)
@@ -643,24 +645,106 @@ static int nfs_sys_mount(struct nfsmount_info
*mi, struct mount_options *opts)
 {
  char *options = NULL;
  int result;
+ int nfs_port = 2049;

  if (mi->fake)
  return 1;

- if (po_join(opts, &options) == PO_FAILED) {
- errno = EIO;
- return 0;
- }
+ /*
+ * Support nfs://-URLS per RFC 2224 ("NFS URL
+ * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
+ * including custom port (nfs://hostname@port/path/...)
+ * and URL parameter (e.g. nfs://.../?param1=val1&param2=val2
+ * support
+ */
+ if (is_spec_nfs_url(mi->spec)) {
+ parsed_nfs_url pnu;
+ char *mb_path;
+ char mount_source[1024];
+
+ if (!mount_parse_nfs_url(mi->spec, &pnu)) {
+ result = 1;
+ errno = EINVAL;
+ goto done;
+ }
+
+ /*
+ * |pnu.uctx->path| is in UTF-8, but we need the data
+ * in the current local locale's encoding, as mount(2)
+ * does not have something like a |MS_UTF8_SPEC| flag
+ * to indicate that the input path is in UTF-8,
+ * independently of the current locale
+ */
+ mb_path = utf8str2mbstr(pnu.uctx->path);
+ if (!mb_path) {
+ nfs_error(_("%s: Could not convert path to local encoding."),
+ progname);
+ mount_free_parse_nfs_url(&pnu);
+ result = 1;
+ errno = EINVAL;
+ goto done;
+ }
+
+ (void)snprintf(mount_source, sizeof(mount_source),
+ "%s:/%s",
+ pnu.uctx->hostport.hostname,
+ mb_path);
+ free(mb_path);
+
+ if (pnu.uctx->hostport.port != -1) {
+ nfs_port = pnu.uctx->hostport.port;
+ }

- result = mount(mi->spec, mi->node, mi->type,
+ /*
+ * Insert "port=" option with the value from the nfs://
+ * URL at the beginning of the list of options, so
+ * users can override it with $ mount.nfs4 -o port= #,
+ * e.g.
+ * $ mount.nfs4 -o port=1234 nfs://10.49.202.230:400//bigdisk /mnt4 #
+ * should use port 1234, and not port 400 as specified
+ * in the URL.
+ */
+ char portoptbuf[5+32+1];
+ (void)snprintf(portoptbuf, sizeof(portoptbuf), "port=%d", nfs_port);
+ (void)po_insert(opts, portoptbuf);
+
+ if (pnu.mount_params.read_only != TRIS_BOOL_NOT_SET) {
+ if (pnu.mount_params.read_only)
+ mi->flags |= MS_RDONLY;
+ else
+ mi->flags &= ~MS_RDONLY;
+ }
+
+ mount_free_parse_nfs_url(&pnu);
+
+ if (po_join(opts, &options) == PO_FAILED) {
+ errno = EIO;
+ result = 1;
+ goto done;
+ }
+
+ result = mount(mount_source, mi->node, mi->type,
+ mi->flags & ~(MS_USER|MS_USERS), options);
+ free(options);
+ } else {
+ if (po_join(opts, &options) == PO_FAILED) {
+ errno = EIO;
+ result = 1;
+ goto done;
+ }
+
+ result = mount(mi->spec, mi->node, mi->type,
  mi->flags & ~(MS_USER|MS_USERS), options);
- free(options);
+ free(options);
+ }

  if (verbose && result) {
  int save = errno;
  nfs_error(_("%s: mount(2): %s"), progname, strerror(save));
  errno = save;
  }
+
+done:
  return !result;
 }

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
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the
"Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be
included in all
+ * copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE
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
+ url_parser_context c;
+
+ /* Private data */
+ char *parameter_string_buff;
+} url_parser_context_private;
+
+#define MAX_URL_PARAMETERS 256
+
+/*
+ * Original extended regular expression:
+ *
+ * "^"
+ * "(.+?)" // scheme
+ * "://" // '://'
+ * "(" // login
+ * "(?:"
+ * "(.+?)" // user (optional)
+ * "(?::(.+))?" // password (optional)
+ * "@"
+ * ")?"
+ * "(" // hostport
+ * "(.+?)" // host
+ * "(?::([[:digit:]]+))?" // port (optional)
+ * ")"
+ * ")"
+ * "(?:/(.*?))?" // path (optional)
+ * "(?:\?(.*?))?" // URL parameters (optional)
+ * "$"
+ */
+
+#define DBGNULLSTR(s) (((s)!=NULL)?(s):"<NULL>")
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
+#define DBG_PUTS(str, fp) fputws(L"" str, (fp))
+#define DBG_PUTC(c, fp) fputwc(btowc(c), (fp))
+#define DBG_PRINTF(fp, fmt, ...) fwprintf((fp), L"" fmt, __VA_ARGS__)
+#else
+#define DBG_PUTS(str, fp) fputs((str), (fp))
+#define DBG_PUTC(c, fp) fputc((c), (fp))
+#define DBG_PRINTF(fp, fmt, ...) fprintf((fp), fmt, __VA_ARGS__)
+#endif /* DBG_USE_WIDECHAR */
+
+static
+void urldecodestr(char *outbuff, const char *buffer, size_t len)
+{
+ size_t i, j;
+
+ for (i = j = 0 ; i < len ; ) {
+ switch (buffer[i]) {
+ case '%':
+ if ((i + 2) < len) {
+ if (isxdigit((int)buffer[i+1]) && isxdigit((int)buffer[i+2])) {
+ const char hexstr[3] = {
+ buffer[i+1],
+ buffer[i+2],
+ '\0'
+ };
+ outbuff[j++] = (unsigned char)strtol(hexstr, NULL, 16);
+ i += 3;
+ } else {
+ /* invalid hex digit */
+ outbuff[j++] = buffer[i];
+ i++;
+ }
+ } else {
+ /* incomplete hex digit */
+ outbuff[j++] = buffer[i];
+ i++;
+ }
+ break;
+ case '+':
+ outbuff[j++] = ' ';
+ i++;
+ break;
+ default:
+ outbuff[j++] = buffer[i++];
+ break;
+ }
+ }
+
+ outbuff[j] = '\0';
+}
+
+url_parser_context *url_parser_create_context(const char *in_url,
unsigned int flags)
+{
+ url_parser_context_private *uctx;
+ char *s;
+ size_t in_url_len;
+ size_t context_len;
+
+ /* |flags| is for future extensions */
+ (void)flags;
+
+ if (!in_url)
+ return NULL;
+
+ in_url_len = strlen(in_url);
+
+ context_len = sizeof(url_parser_context_private) +
+ ((in_url_len+1)*6) +
+ (sizeof(url_parser_name_value)*MAX_URL_PARAMETERS)+sizeof(void*);
+ uctx = malloc(context_len);
+ if (!uctx)
+ return NULL;
+
+ s = (void *)(uctx+1);
+ uctx->c.in_url = s; s+= in_url_len+1;
+ (void)strcpy(uctx->c.in_url, in_url);
+ uctx->c.scheme = s; s+= in_url_len+1;
+ uctx->c.login.username = s; s+= in_url_len+1;
+ uctx->c.hostport.hostname = s; s+= in_url_len+1;
+ uctx->c.path = s; s+= in_url_len+1;
+ uctx->c.hostport.port = -1;
+ uctx->c.num_parameters = -1;
+ uctx->c.parameters = (void *)s; s+=
(sizeof(url_parser_name_value)*MAX_URL_PARAMETERS)+sizeof(void*);
+ uctx->parameter_string_buff = s; s+= in_url_len+1;
+
+ return &uctx->c;
+}
+
+int url_parser_parse(url_parser_context *ctx)
+{
+ url_parser_context_private *uctx = (url_parser_context_private *)ctx;
+
+ D((void)DBG_PRINTF(stderr, "## parser in_url='%s'\n", uctx->c.in_url));
+
+ char *s;
+ const char *urlstr = uctx->c.in_url;
+ size_t slen;
+
+ s = strstr(urlstr, "://");
+ if (!s) {
+ D((void)DBG_PUTS("url_parser: Not an URL\n", stderr));
+ return -1;
+ }
+
+ slen = s-urlstr;
+ (void)memcpy(uctx->c.scheme, urlstr, slen);
+ uctx->c.scheme[slen] = '\0';
+ urlstr += slen + 3;
+
+ D((void)DBG_PRINTF(stdout, "scheme='%s', rest='%s'\n",
uctx->c.scheme, urlstr));
+
+ s = strstr(urlstr, "@");
+ if (s) {
+ /* URL has user/password */
+ slen = s-urlstr;
+ urldecodestr(uctx->c.login.username, urlstr, slen);
+ urlstr += slen + 1;
+
+ s = strstr(uctx->c.login.username, ":");
+ if (s) {
+ /* found passwd */
+ uctx->c.login.passwd = s+1;
+ *s = '\0';
+ }
+ else {
+ uctx->c.login.passwd = NULL;
+ }
+
+ /* catch password-only URLs */
+ if (uctx->c.login.username[0] == '\0')
+ uctx->c.login.username = NULL;
+ }
+ else {
+ uctx->c.login.username = NULL;
+ uctx->c.login.passwd = NULL;
+ }
+
+ D((void)DBG_PRINTF(stdout, "login='%s', passwd='%s', rest='%s'\n",
+ DBGNULLSTR(uctx->c.login.username),
+ DBGNULLSTR(uctx->c.login.passwd),
+ DBGNULLSTR(urlstr)));
+
+ char *raw_parameters;
+
+ uctx->c.num_parameters = 0;
+ raw_parameters = strstr(urlstr, "?");
+ /* Do we have a non-empty parameter string ? */
+ if (raw_parameters && (raw_parameters[1] != '\0')) {
+ *raw_parameters++ = '\0';
+ D((void)DBG_PRINTF(stdout, "raw parameters = '%s'\n", raw_parameters));
+
+ char *ps = raw_parameters;
+ char *pv; /* parameter value */
+ char *na; /* next '&' */
+ char *pb = uctx->parameter_string_buff;
+ char *pname;
+ char *pvalue;
+ ssize_t pi;
+
+ for (pi = 0; pi < MAX_URL_PARAMETERS ; pi++) {
+ pname = ps;
+
+ /*
+ * Handle parameters without value,
+ * e.g. "path?name1&name2=value2"
+ */
+ na = strstr(ps, "&");
+ pv = strstr(ps, "=");
+ if (pv && (na?(na > pv):true)) {
+ *pv++ = '\0';
+ pvalue = pv;
+ ps = pv;
+ }
+ else {
+ pvalue = NULL;
+ }
+
+ if (na) {
+ *na++ = '\0';
+ }
+
+ /* URLDecode parameter name */
+ urldecodestr(pb, pname, strlen(pname));
+ uctx->c.parameters[pi].name = pb;
+ pb += strlen(uctx->c.parameters[pi].name)+1;
+
+ /* URLDecode parameter value */
+ if (pvalue) {
+ urldecodestr(pb, pvalue, strlen(pvalue));
+ uctx->c.parameters[pi].value = pb;
+ pb += strlen(uctx->c.parameters[pi].value)+1;
+ }
+ else {
+ uctx->c.parameters[pi].value = NULL;
+ }
+
+ /* Next '&' ? */
+ if (!na)
+ break;
+
+ ps = na;
+ }
+
+ uctx->c.num_parameters = pi+1;
+ }
+
+ s = strstr(urlstr, "/");
+ if (s) {
+ /* URL has hostport */
+ slen = s-urlstr;
+ urldecodestr(uctx->c.hostport.hostname, urlstr, slen);
+ urlstr += slen + 1;
+
+ /*
+ * check for addresses within '[' and ']', like
+ * IPv6 addresses
+ */
+ s = uctx->c.hostport.hostname;
+ if (s[0] == '[')
+ s = strstr(s, "]");
+
+ if (s == NULL) {
+ D((void)DBG_PUTS("url_parser: Unmatched '[' in hostname\n", stderr));
+ return -1;
+ }
+
+ s = strstr(s, ":");
+ if (s) {
+ /* found port number */
+ uctx->c.hostport.port = atoi(s+1);
+ *s = '\0';
+ }
+ }
+ else {
+ (void)strcpy(uctx->c.hostport.hostname, urlstr);
+ uctx->c.path = NULL;
+ urlstr = NULL;
+ }
+
+ D(
+ (void)DBG_PRINTF(stdout,
+ "hostport='%s', port=%d, rest='%s', num_parameters=%d\n",
+ DBGNULLSTR(uctx->c.hostport.hostname),
+ uctx->c.hostport.port,
+ DBGNULLSTR(urlstr),
+ (int)uctx->c.num_parameters);
+ );
+
+
+ D(
+ ssize_t dpi;
+ for (dpi = 0 ; dpi < uctx->c.num_parameters ; dpi++) {
+ (void)DBG_PRINTF(stdout,
+ "param[%d]: name='%s'/value='%s'\n",
+ (int)dpi,
+ uctx->c.parameters[dpi].name,
+ DBGNULLSTR(uctx->c.parameters[dpi].value));
+ }
+ );
+
+ if (!urlstr) {
+ goto done;
+ }
+
+ urldecodestr(uctx->c.path, urlstr, strlen(urlstr));
+ D((void)DBG_PRINTF(stdout, "path='%s'\n", uctx->c.path));
+
+done:
+ return 0;
+}
+
+void url_parser_free_context(url_parser_context *c)
+{
+ free(c);
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
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the
"Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be
included in all
+ * copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE
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
+ char *name;
+ char *value;
+} url_parser_name_value;
+
+typedef struct _url_parser_context {
+ char *in_url;
+
+ char *scheme;
+ struct {
+ char *username;
+ char *passwd;
+ } login;
+ struct {
+ char *hostname;
+ signed int port;
+ } hostport;
+ char *path;
+
+ ssize_t num_parameters;
+ url_parser_name_value *parameters;
+} url_parser_context;
+
+/* Prototypes */
+url_parser_context *url_parser_create_context(const char *in_url,
unsigned int flags);
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

 #include "sockaddr.h"
 #include "nfs_mount.h"
@@ -173,3 +174,157 @@ int nfs_umount23(const char *devname, char *string)
  free(dirname);
  return result;
 }
+
+/* Convert UTF-8 string to multibyte string in the current locale */
+char *utf8str2mbstr(const char *utf8_str)
+{
+ iconv_t cd;
+
+ cd = iconv_open("", "UTF-8");
+ if (cd == (iconv_t)-1) {
+ perror("utf8str2mbstr: iconv_open failed");
+ return NULL;
+ }
+
+ size_t inbytesleft = strlen(utf8_str);
+ char *inbuf = (char *)utf8_str;
+ size_t outbytesleft = inbytesleft*4+1;
+ char *outbuf = malloc(outbytesleft);
+ char *outbuf_orig = outbuf;
+
+ if (!outbuf) {
+ perror("utf8str2mbstr: out of memory");
+ (void)iconv_close(cd);
+ return NULL;
+ }
+
+ int ret = iconv(cd, &inbuf, &inbytesleft, &outbuf, &outbytesleft);
+ if (ret == -1) {
+ perror("utf8str2mbstr: iconv() failed");
+ free(outbuf_orig);
+ (void)iconv_close(cd);
+ return NULL;
+ }
+
+ *outbuf = '\0';
+
+ (void)iconv_close(cd);
+ return outbuf_orig;
+}
+
+/* fixme: We should use |bool|! */
+int is_spec_nfs_url(const char *spec)
+{
+ return (!strncmp(spec, "nfs://", 6));
+}
+
+int mount_parse_nfs_url(const char *spec, parsed_nfs_url *pnu)
+{
+ int result = 1;
+ url_parser_context *uctx = NULL;
+
+ (void)memset(pnu, 0, sizeof(parsed_nfs_url));
+ pnu->mount_params.read_only = TRIS_BOOL_NOT_SET;
+
+ uctx = url_parser_create_context(spec, 0);
+ if (!uctx) {
+ nfs_error(_("%s: out of memory"),
+ progname);
+ result = 1;
+ goto done;
+ }
+
+ if (url_parser_parse(uctx) < 0) {
+ nfs_error(_("%s: Error parsing nfs://-URL."),
+ progname);
+ result = 1;
+ goto done;
+ }
+ if (uctx->login.username || uctx->login.passwd) {
+ nfs_error(_("%s: Username/Password are not defined for nfs://-URL."),
+ progname);
+ result = 1;
+ goto done;
+ }
+ if (!uctx->path) {
+ nfs_error(_("%s: Path missing in nfs://-URL."),
+ progname);
+ result = 1;
+ goto done;
+ }
+ if (uctx->path[0] != '/') {
+ nfs_error(_("%s: Relative nfs://-URLs are not supported."),
+ progname);
+ result = 1;
+ goto done;
+ }
+
+ if (uctx->num_parameters > 0) {
+ int pi;
+ const char *pname;
+ const char *pvalue;
+
+ /*
+ * Values added here based on URL parameters
+ * should be added the front of the list of options,
+ * so users can override the nfs://-URL given default.
+ */
+ for (pi = 0; pi < uctx->num_parameters ; pi++) {
+ pname = uctx->parameters[pi].name;
+ pvalue = uctx->parameters[pi].value;
+
+ if (!strcmp(pname, "rw")) {
+ if ((pvalue == NULL) || (!strcmp(pvalue, "1"))) {
+ pnu->mount_params.read_only = TRIS_BOOL_FALSE;
+ }
+ else if (!strcmp(pvalue, "0")) {
+ pnu->mount_params.read_only = TRIS_BOOL_TRUE;
+ }
+ else {
+ nfs_error(_("%s: Unsupported nfs://-URL "
+ "parameter '%s' value '%s'."),
+ progname, pname, pvalue);
+ result = 1;
+ goto done;
+ }
+ }
+ else if (!strcmp(pname, "ro")) {
+ if ((pvalue == NULL) || (!strcmp(pvalue, "1"))) {
+ pnu->mount_params.read_only = TRIS_BOOL_TRUE;
+ }
+ else if (!strcmp(pvalue, "0")) {
+ pnu->mount_params.read_only = TRIS_BOOL_FALSE;
+ }
+ else {
+ nfs_error(_("%s: Unsupported nfs://-URL "
+ "parameter '%s' value '%s'."),
+ progname, pname, pvalue);
+ result = 1;
+ goto done;
+ }
+ }
+ else {
+ nfs_error(_("%s: Unsupported nfs://-URL "
+ "parameter '%s'."),
+ progname, pname);
+ result = 1;
+ goto done;
+ }
+ }
+ }
+
+ result = 0;
+done:
+ if (result != 0) {
+ url_parser_free_context(uctx);
+ return 0;
+ }
+
+ pnu->uctx = uctx;
+ return 1;
+}
+
+void mount_free_parse_nfs_url(parsed_nfs_url *pnu)
+{
+ url_parser_free_context(pnu->uctx);
+}
diff --git a/utils/mount/utils.h b/utils/mount/utils.h
index 224918ae..465c0a5e 100644
--- a/utils/mount/utils.h
+++ b/utils/mount/utils.h
@@ -24,13 +24,36 @@
 #define _NFS_UTILS_MOUNT_UTILS_H

 #include "parse_opt.h"
+#include "urlparser1.h"

+/* Boolean with three states: { not_set, false, true */
+typedef signed char tristate_bool;
+#define TRIS_BOOL_NOT_SET (-1)
+#define TRIS_BOOL_TRUE (1)
+#define TRIS_BOOL_FALSE (0)
+
+#define TRIS_BOOL_GET_VAL(tsb, tsb_default) \
+ (((tsb)!=TRIS_BOOL_NOT_SET)?(tsb):(tsb_default))
+
+typedef struct _parsed_nfs_url {
+ url_parser_context *uctx;
+ struct {
+ tristate_bool read_only;
+ } mount_params;
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

 int nfs_umount23(const char *devname, char *string);

+int mount_parse_nfs_url(const char *spec, parsed_nfs_url *pnu);
+void mount_free_parse_nfs_url(parsed_nfs_url *pnu);
+
 #endif /* !_NFS_UTILS_MOUNT_UTILS_H */
-- 
2.30.2
---- snip ----

----

Bye,
Roland
-- 
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /==\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)

--000000000000ccb28f0628a0fd7d
Content-Type: application/octet-stream; 
	name="0001-mount.nfs4-Add-support-for-nfs-URLs_v2.patch"
Content-Disposition: attachment; 
	filename="0001-mount.nfs4-Add-support-for-nfs-URLs_v2.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m4da24re0>
X-Attachment-Id: f_m4da24re0

RnJvbSA3NjdlMWFhMDk2YmFjZDRkZDYwMGQ0NmNjYWFlZmJjNDdiYTg2M2JmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSb2xhbmQgTWFpbnogPHJvbGFuZC5tYWluekBucnVic2lnLm9y
Zz4KRGF0ZTogRnJpLCA2IERlYyAyMDI0IDE1OjIyOjIzICswMTAwClN1YmplY3Q6IFtQQVRDSF0g
bW91bnQubmZzNDogQWRkIHN1cHBvcnQgZm9yIG5mczovLy1VUkxzCgpBZGQgc3VwcG9ydCBmb3Ig
UkZDIDIyMjQtc3R5bGUgbmZzOi8vLVVSTHMgYXMgYWx0ZXJuYXRpdmUgdG8gdGhlCnRyYWRpdGlv
bmFsIGhvc3RuYW1lOi9wYXRoKy1vIHBvcnQ9PHRjcC1wb3J0PiBub3RhdGlvbiwKcHJvdmlkaW5n
IHN0YW5kYXJkaXNlZCwgZXh0ZW5zaWJsZSwgc2luZ2xlLXN0cmluZywgY3Jvc3NwbGF0Zm9ybSwK
cG9ydGFibGUsIENoYXJhY3Rlci1FbmNvZGluZyBpbmRlcGVuZGVudCAoZS5nLiBtb3VudCBwb2lu
dCB3aXRoCkphcGFuZXNlLCBDaGluZXNlLCBGcmVuY2ggZXRjLiBjaGFyYWN0ZXJzKSBhbmQgQVND
SUktY29tcGF0aWJsZQpkZXNjcmlwdGlvbnMgb2YgTkZTdjQgc2VydmVyIHJlc291cmNlcyAoZXhw
b3J0cykuCgpSZXZpZXdlZC1ieTogTWFydGluIFdlZ2UgPG1hcnRpbi5sLndlZ2VAZ21haWwuY29t
PgpTaWduZWQtb2ZmLWJ5OiBNYXJ2aW4gV2VuemVsIDxtYXJ2aW4ud2VuemVsQHJvdmVtYS5kZT4K
U2lnbmVkLW9mZi1ieTogQ2VkcmljIEJsYW5jaGVyIDxjZWRyaWMuYmxhbmNoZXJAZ21haWwuY29t
PgotLS0KIHV0aWxzL21vdW50L01ha2VmaWxlLmFtICB8ICAgMyArLQogdXRpbHMvbW91bnQvbW91
bnQuYyAgICAgIHwgICAzICsKIHV0aWxzL21vdW50L25mczRtb3VudC5jICB8ICA2OSArKysrKysr
LQogdXRpbHMvbW91bnQvbmZzbW91bnQuYyAgIHwgIDkzICsrKysrKysrLS0KIHV0aWxzL21vdW50
L3BhcnNlX2Rldi5jICB8ICA2NyArKysrKystLQogdXRpbHMvbW91bnQvc3Ryb3B0cy5jICAgIHwg
IDk2ICsrKysrKysrKystCiB1dGlscy9tb3VudC91cmxwYXJzZXIxLmMgfCAzNTggKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiB1dGlscy9tb3VudC91cmxwYXJzZXIxLmgg
fCAgNjAgKysrKysrKwogdXRpbHMvbW91bnQvdXRpbHMuYyAgICAgIHwgMTU1ICsrKysrKysrKysr
KysrKysrCiB1dGlscy9tb3VudC91dGlscy5oICAgICAgfCAgMjMgKysrCiAxMCBmaWxlcyBjaGFu
Z2VkLCA4OTAgaW5zZXJ0aW9ucygrKSwgMzcgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2
NDQgdXRpbHMvbW91bnQvdXJscGFyc2VyMS5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgdXRpbHMvbW91
bnQvdXJscGFyc2VyMS5oCgpkaWZmIC0tZ2l0IGEvdXRpbHMvbW91bnQvTWFrZWZpbGUuYW0gYi91
dGlscy9tb3VudC9NYWtlZmlsZS5hbQppbmRleCA4M2E4ZWUxYy4uMGU0Y2FiM2UgMTAwNjQ0Ci0t
LSBhL3V0aWxzL21vdW50L01ha2VmaWxlLmFtCisrKyBiL3V0aWxzL21vdW50L01ha2VmaWxlLmFt
CkBAIC0xMyw3ICsxMyw4IEBAIHNiaW5fUFJPR1JBTVMJPSBtb3VudC5uZnMKIEVYVFJBX0RJU1Qg
PSBuZnNtb3VudC5jb25mICQobWFuOF9NQU5TKSAkKG1hbjVfTUFOUykKIG1vdW50X2NvbW1vbiA9
IGVycm9yLmMgbmV0d29yay5jIHRva2VuLmMgXAogCQkgICAgcGFyc2Vfb3B0LmMgcGFyc2VfZGV2
LmMgXAotCQkgICAgbmZzbW91bnQuYyBuZnM0bW91bnQuYyBzdHJvcHRzLmNcCisJCSAgICBuZnNt
b3VudC5jIG5mczRtb3VudC5jIFwKKwkJICAgIHVybHBhcnNlcjEuYyB1cmxwYXJzZXIxLmggc3Ry
b3B0cy5jIFwKIAkJICAgIG1vdW50X2NvbnN0YW50cy5oIGVycm9yLmggbmV0d29yay5oIHRva2Vu
LmggXAogCQkgICAgcGFyc2Vfb3B0LmggcGFyc2VfZGV2LmggXAogCQkgICAgbmZzNF9tb3VudC5o
IHN0cm9wdHMuaCB2ZXJzaW9uLmggXApkaWZmIC0tZ2l0IGEvdXRpbHMvbW91bnQvbW91bnQuYyBi
L3V0aWxzL21vdW50L21vdW50LmMKaW5kZXggYjk4ZjllMDAuLjJjZTYyMDlkIDEwMDY0NAotLS0g
YS91dGlscy9tb3VudC9tb3VudC5jCisrKyBiL3V0aWxzL21vdW50L21vdW50LmMKQEAgLTI5LDYg
KzI5LDcgQEAKICNpbmNsdWRlIDxzdHJpbmcuaD4KICNpbmNsdWRlIDxlcnJuby5oPgogI2luY2x1
ZGUgPGZjbnRsLmg+CisjaW5jbHVkZSA8bG9jYWxlLmg+CiAjaW5jbHVkZSA8c3lzL21vdW50Lmg+
CiAjaW5jbHVkZSA8Z2V0b3B0Lmg+CiAjaW5jbHVkZSA8bW50ZW50Lmg+CkBAIC0zODYsNiArMzg3
LDggQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAljaGFyICpleHRyYV9vcHRz
ID0gTlVMTCwgKm1vdW50X29wdHMgPSBOVUxMOwogCXVpZF90IHVpZCA9IGdldHVpZCgpOwogCisJ
KHZvaWQpc2V0bG9jYWxlKExDX0FMTCwgIiIpOworCiAJcHJvZ25hbWUgPSBiYXNlbmFtZShhcmd2
WzBdKTsKIAogCW5mc19tb3VudF9kYXRhX3ZlcnNpb24gPSBkaXNjb3Zlcl9uZnNfbW91bnRfZGF0
YV92ZXJzaW9uKCZzdHJpbmcpOwpkaWZmIC0tZ2l0IGEvdXRpbHMvbW91bnQvbmZzNG1vdW50LmMg
Yi91dGlscy9tb3VudC9uZnM0bW91bnQuYwppbmRleCAwZmUxNDJhNy4uOGU0ZmJmMzAgMTAwNjQ0
Ci0tLSBhL3V0aWxzL21vdW50L25mczRtb3VudC5jCisrKyBiL3V0aWxzL21vdW50L25mczRtb3Vu
dC5jCkBAIC01MCw4ICs1MCwxMCBAQAogI2luY2x1ZGUgIm1vdW50X2NvbnN0YW50cy5oIgogI2lu
Y2x1ZGUgIm5mczRfbW91bnQuaCIKICNpbmNsdWRlICJuZnNfbW91bnQuaCIKKyNpbmNsdWRlICJ1
cmxwYXJzZXIxLmgiCiAjaW5jbHVkZSAiZXJyb3IuaCIKICNpbmNsdWRlICJuZXR3b3JrLmgiCisj
aW5jbHVkZSAidXRpbHMuaCIKIAogI2lmIGRlZmluZWQoVkFSX0xPQ0tfRElSKQogI2RlZmluZSBE
RUZBVUxUX0RJUiBWQVJfTE9DS19ESVIKQEAgLTE4Miw3ICsxODQsNyBAQCBpbnQgbmZzNG1vdW50
KGNvbnN0IGNoYXIgKnNwZWMsIGNvbnN0IGNoYXIgKm5vZGUsIGludCBmbGFncywKIAlpbnQgbnVt
X2ZsYXZvdXIgPSAwOwogCWludCBpcF9hZGRyX2luX29wdHMgPSAwOwogCi0JY2hhciAqaG9zdG5h
bWUsICpkaXJuYW1lLCAqb2xkX29wdHM7CisJY2hhciAqaG9zdG5hbWUsICpkaXJuYW1lLCAqbWJf
ZGlybmFtZSA9IE5VTEwsICpvbGRfb3B0czsKIAljaGFyIG5ld19vcHRzWzEwMjRdOwogCWNoYXIg
Km9wdCwgKm9wdGVxOwogCWNoYXIgKnM7CkBAIC0xOTIsMTUgKzE5NCw2NiBAQCBpbnQgbmZzNG1v
dW50KGNvbnN0IGNoYXIgKnNwZWMsIGNvbnN0IGNoYXIgKm5vZGUsIGludCBmbGFncywKIAlpbnQg
cmV0cnk7CiAJaW50IHJldHZhbCA9IEVYX0ZBSUw7CiAJdGltZV90IHRpbWVvdXQsIHQ7CisJaW50
IG5mc19wb3J0ID0gTkZTX1BPUlQ7CisJcGFyc2VkX25mc191cmwgcG51OworCisJKHZvaWQpbWVt
c2V0KCZwbnUsIDAsIHNpemVvZihwYXJzZWRfbmZzX3VybCkpOwogCiAJaWYgKHN0cmxlbihzcGVj
KSA+PSBzaXplb2YoaG9zdGRpcikpIHsKIAkJbmZzX2Vycm9yKF8oIiVzOiBleGNlc3NpdmVseSBs
b25nIGhvc3Q6ZGlyIGFyZ3VtZW50XG4iKSwKIAkJCQlwcm9nbmFtZSk7CiAJCWdvdG8gZmFpbDsK
IAl9Ci0Jc3RyY3B5KGhvc3RkaXIsIHNwZWMpOwotCWlmIChwYXJzZV9kZXZuYW1lKGhvc3RkaXIs
ICZob3N0bmFtZSwgJmRpcm5hbWUpKQotCQlnb3RvIGZhaWw7CisKKwkvKgorCSAqIFN1cHBvcnQg
bmZzOi8vLVVSTFMgcGVyIFJGQyAyMjI0ICgiTkZTIFVSTAorCSAqIFNDSEVNRSIsIHNlZSBodHRw
czovL3d3dy5yZmMtZWRpdG9yLm9yZy9yZmMvcmZjMjIyNC5odG1sKSwKKwkgKiBpbmNsdWRpbmcg
Y3VzdG9tIHBvcnQgKG5mczovL2hvc3RuYW1lQHBvcnQvcGF0aC8uLi4pCisJICogYW5kIFVSTCBw
YXJhbWV0ZXIgKGUuZy4gbmZzOi8vLi4uLz9wYXJhbTE9dmFsMSZwYXJhbTI9dmFsMgorCSAqIHN1
cHBvcnQKKwkgKi8KKwlpZiAoaXNfc3BlY19uZnNfdXJsKHNwZWMpKSB7CisJCWlmICghbW91bnRf
cGFyc2VfbmZzX3VybChzcGVjLCAmcG51KSkgeworCQkJZ290byBmYWlsOworCQl9CisKKwkJLyoK
KwkJICogfHBudS51Y3R4LT5wYXRofCBpcyBpbiBVVEYtOCwgYnV0IHdlIG5lZWQgdGhlIGRhdGEK
KwkJICogaW4gdGhlIGN1cnJlbnQgbG9jYWwgbG9jYWxlJ3MgZW5jb2RpbmcsIGFzIG1vdW50KDIp
CisJCSAqIGRvZXMgbm90IGhhdmUgc29tZXRoaW5nIGxpa2UgYSB8TVNfVVRGOF9TUEVDfCBmbGFn
CisJCSAqIHRvIGluZGljYXRlIHRoYXQgdGhlIGlucHV0IHBhdGggaXMgaW4gVVRGLTgsCisJCSAq
IGluZGVwZW5kZW50bHkgb2YgdGhlIGN1cnJlbnQgbG9jYWxlCisJCSAqLworCQlob3N0bmFtZSA9
IHBudS51Y3R4LT5ob3N0cG9ydC5ob3N0bmFtZTsKKwkJZGlybmFtZSA9IG1iX2Rpcm5hbWUgPSB1
dGY4c3RyMm1ic3RyKHBudS51Y3R4LT5wYXRoKTsKKworCQkodm9pZClzbnByaW50Zihob3N0ZGly
LCBzaXplb2YoaG9zdGRpciksICIlczovJXMiLAorCQkJaG9zdG5hbWUsIGRpcm5hbWUpOworCQlz
cGVjID0gaG9zdGRpcjsKKworCQlpZiAocG51LnVjdHgtPmhvc3Rwb3J0LnBvcnQgIT0gLTEpIHsK
KwkJCW5mc19wb3J0ID0gcG51LnVjdHgtPmhvc3Rwb3J0LnBvcnQ7CisJCX0KKworCQkvKgorCQkg
KiBWYWx1ZXMgYWRkZWQgaGVyZSBiYXNlZCBvbiBVUkwgcGFyYW1ldGVycworCQkgKiBzaG91bGQg
YmUgYWRkZWQgdGhlIGZyb250IG9mIHRoZSBsaXN0IG9mIG9wdGlvbnMsCisJCSAqIHNvIHVzZXJz
IGNhbiBvdmVycmlkZSB0aGUgbmZzOi8vLVVSTCBnaXZlbiBkZWZhdWx0LgorCQkgKgorCQkgKiBG
SVhNRTogV2UgZG8gbm90IGRvIHRoYXQgaGVyZSBmb3IgfE1TX1JET05MWXwhCisJCSAqLworCQlp
ZiAocG51Lm1vdW50X3BhcmFtcy5yZWFkX29ubHkgIT0gVFJJU19CT09MX05PVF9TRVQpIHsKKwkJ
CWlmIChwbnUubW91bnRfcGFyYW1zLnJlYWRfb25seSkKKwkJCQlmbGFncyB8PSBNU19SRE9OTFk7
CisJCQllbHNlCisJCQkJZmxhZ3MgJj0gfk1TX1JET05MWTsKKwkJfQorICAgICAgICB9IGVsc2Ug
eworCQkodm9pZClzdHJjcHkoaG9zdGRpciwgc3BlYyk7CisKKwkJaWYgKHBhcnNlX2Rldm5hbWUo
aG9zdGRpciwgJmhvc3RuYW1lLCAmZGlybmFtZSkpCisJCQlnb3RvIGZhaWw7CisJfQogCiAJaWYg
KGZpbGxfaXB2NF9zb2NrYWRkcihob3N0bmFtZSwgJnNlcnZlcl9hZGRyKSkKIAkJZ290byBmYWls
OwpAQCAtMjQ3LDcgKzMwMCw3IEBAIGludCBuZnM0bW91bnQoY29uc3QgY2hhciAqc3BlYywgY29u
c3QgY2hhciAqbm9kZSwgaW50IGZsYWdzLAogCS8qCiAJICogTkZTdjQgc3BlY2lmaWVzIHRoYXQg
dGhlIGRlZmF1bHQgcG9ydCBzaG91bGQgYmUgMjA0OQogCSAqLwotCXNlcnZlcl9hZGRyLnNpbl9w
b3J0ID0gaHRvbnMoTkZTX1BPUlQpOworCXNlcnZlcl9hZGRyLnNpbl9wb3J0ID0gaHRvbnMobmZz
X3BvcnQpOwogCiAJLyogcGFyc2Ugb3B0aW9ucyAqLwogCkBAIC00NzQsOCArNTI3LDE0IEBAIGlu
dCBuZnM0bW91bnQoY29uc3QgY2hhciAqc3BlYywgY29uc3QgY2hhciAqbm9kZSwgaW50IGZsYWdz
LAogCQl9CiAJfQogCisJbW91bnRfZnJlZV9wYXJzZV9uZnNfdXJsKCZwbnUpOworCWZyZWUobWJf
ZGlybmFtZSk7CisKIAlyZXR1cm4gRVhfU1VDQ0VTUzsKIAogZmFpbDoKKwltb3VudF9mcmVlX3Bh
cnNlX25mc191cmwoJnBudSk7CisJZnJlZShtYl9kaXJuYW1lKTsKKwogCXJldHVybiByZXR2YWw7
CiB9CmRpZmYgLS1naXQgYS91dGlscy9tb3VudC9uZnNtb3VudC5jIGIvdXRpbHMvbW91bnQvbmZz
bW91bnQuYwppbmRleCBhMWM5MmZlOC4uZTYxZDcxOGEgMTAwNjQ0Ci0tLSBhL3V0aWxzL21vdW50
L25mc21vdW50LmMKKysrIGIvdXRpbHMvbW91bnQvbmZzbW91bnQuYwpAQCAtNjMsMTEgKzYzLDEz
IEBACiAjaW5jbHVkZSAieGNvbW1vbi5oIgogI2luY2x1ZGUgIm1vdW50LmgiCiAjaW5jbHVkZSAi
bmZzX21vdW50LmgiCisjaW5jbHVkZSAidXJscGFyc2VyMS5oIgogI2luY2x1ZGUgIm1vdW50X2Nv
bnN0YW50cy5oIgogI2luY2x1ZGUgIm5scy5oIgogI2luY2x1ZGUgImVycm9yLmgiCiAjaW5jbHVk
ZSAibmV0d29yay5oIgogI2luY2x1ZGUgInZlcnNpb24uaCIKKyNpbmNsdWRlICJ1dGlscy5oIgog
CiAjaWZkZWYgSEFWRV9SUENTVkNfTkZTX1BST1RfSAogI2luY2x1ZGUgPHJwY3N2Yy9uZnNfcHJv
dC5oPgpAQCAtNDkzLDcgKzQ5NSw3IEBAIG5mc21vdW50KGNvbnN0IGNoYXIgKnNwZWMsIGNvbnN0
IGNoYXIgKm5vZGUsIGludCBmbGFncywKIAkgY2hhciAqKmV4dHJhX29wdHMsIGludCBmYWtlLCBp
bnQgcnVubmluZ19iZykKIHsKIAljaGFyIGhvc3RkaXJbMTAyNF07Ci0JY2hhciAqaG9zdG5hbWUs
ICpkaXJuYW1lLCAqb2xkX29wdHMsICptb3VudGhvc3QgPSBOVUxMOworCWNoYXIgKmhvc3RuYW1l
LCAqZGlybmFtZSwgKm1iX2Rpcm5hbWUgPSBOVUxMLCAqb2xkX29wdHMsICptb3VudGhvc3QgPSBO
VUxMOwogCWNoYXIgbmV3X29wdHNbMTAyNF0sIGNidWZbMTAyNF07CiAJc3RhdGljIHN0cnVjdCBu
ZnNfbW91bnRfZGF0YSBkYXRhOwogCWludCB2YWw7CkBAIC01MjEsMjkgKzUyMyw3OSBAQCBuZnNt
b3VudChjb25zdCBjaGFyICpzcGVjLCBjb25zdCBjaGFyICpub2RlLCBpbnQgZmxhZ3MsCiAJdGlt
ZV90IHQ7CiAJdGltZV90IHByZXZ0OwogCXRpbWVfdCB0aW1lb3V0OworCWludCBuZnN1cmxfcG9y
dCA9IC0xOworCXBhcnNlZF9uZnNfdXJsIHBudTsKKworCSh2b2lkKW1lbXNldCgmcG51LCAwLCBz
aXplb2YocGFyc2VkX25mc191cmwpKTsKIAogCWlmIChzdHJsZW4oc3BlYykgPj0gc2l6ZW9mKGhv
c3RkaXIpKSB7CiAJCW5mc19lcnJvcihfKCIlczogZXhjZXNzaXZlbHkgbG9uZyBob3N0OmRpciBh
cmd1bWVudCIpLAogCQkJCXByb2duYW1lKTsKIAkJZ290byBmYWlsOwogCX0KLQlzdHJjcHkoaG9z
dGRpciwgc3BlYyk7Ci0JaWYgKChzID0gc3RyY2hyKGhvc3RkaXIsICc6JykpKSB7Ci0JCWhvc3Ru
YW1lID0gaG9zdGRpcjsKLQkJZGlybmFtZSA9IHMgKyAxOwotCQkqcyA9ICdcMCc7Ci0JCS8qIEln
bm9yZSBhbGwgYnV0IGZpcnN0IGhvc3RuYW1lIGluIHJlcGxpY2F0ZWQgbW91bnRzCi0JCSAgIHVu
dGlsIHRoZXkgY2FuIGJlIGZ1bGx5IHN1cHBvcnRlZC4gKG1hY2tAc2dpLmNvbSkgKi8KLQkJaWYg
KChzID0gc3RyY2hyKGhvc3RkaXIsICcsJykpKSB7CisKKwkvKgorCSAqIFN1cHBvcnQgbmZzOi8v
LVVSTFMgcGVyIFJGQyAyMjI0ICgiTkZTIFVSTAorCSAqIFNDSEVNRSIsIHNlZSBodHRwczovL3d3
dy5yZmMtZWRpdG9yLm9yZy9yZmMvcmZjMjIyNC5odG1sKSwKKwkgKiBpbmNsdWRpbmcgY3VzdG9t
IHBvcnQgKG5mczovL2hvc3RuYW1lQHBvcnQvcGF0aC8uLi4pCisJICogYW5kIFVSTCBwYXJhbWV0
ZXIgKGUuZy4gbmZzOi8vLi4uLz9wYXJhbTE9dmFsMSZwYXJhbTI9dmFsMgorCSAqIHN1cHBvcnQK
KwkgKi8KKwlpZiAoaXNfc3BlY19uZnNfdXJsKHNwZWMpKSB7CisJCWlmICghbW91bnRfcGFyc2Vf
bmZzX3VybChzcGVjLCAmcG51KSkgeworCQkJZ290byBmYWlsOworCQl9CisKKwkJLyoKKwkJICog
fHBudS51Y3R4LT5wYXRofCBpcyBpbiBVVEYtOCwgYnV0IHdlIG5lZWQgdGhlIGRhdGEKKwkJICog
aW4gdGhlIGN1cnJlbnQgbG9jYWwgbG9jYWxlJ3MgZW5jb2RpbmcsIGFzIG1vdW50KDIpCisJCSAq
IGRvZXMgbm90IGhhdmUgc29tZXRoaW5nIGxpa2UgYSB8TVNfVVRGOF9TUEVDfCBmbGFnCisJCSAq
IHRvIGluZGljYXRlIHRoYXQgdGhlIGlucHV0IHBhdGggaXMgaW4gVVRGLTgsCisJCSAqIGluZGVw
ZW5kZW50bHkgb2YgdGhlIGN1cnJlbnQgbG9jYWxlCisJCSAqLworCQlob3N0bmFtZSA9IHBudS51
Y3R4LT5ob3N0cG9ydC5ob3N0bmFtZTsKKwkJZGlybmFtZSA9IG1iX2Rpcm5hbWUgPSB1dGY4c3Ry
Mm1ic3RyKHBudS51Y3R4LT5wYXRoKTsKKworCQkodm9pZClzbnByaW50Zihob3N0ZGlyLCBzaXpl
b2YoaG9zdGRpciksICIlczovJXMiLAorCQkJaG9zdG5hbWUsIGRpcm5hbWUpOworCQlzcGVjID0g
aG9zdGRpcjsKKworCQlpZiAocG51LnVjdHgtPmhvc3Rwb3J0LnBvcnQgIT0gLTEpIHsKKwkJCW5m
c3VybF9wb3J0ID0gcG51LnVjdHgtPmhvc3Rwb3J0LnBvcnQ7CisJCX0KKworCQkvKgorCQkgKiBW
YWx1ZXMgYWRkZWQgaGVyZSBiYXNlZCBvbiBVUkwgcGFyYW1ldGVycworCQkgKiBzaG91bGQgYmUg
YWRkZWQgdGhlIGZyb250IG9mIHRoZSBsaXN0IG9mIG9wdGlvbnMsCisJCSAqIHNvIHVzZXJzIGNh
biBvdmVycmlkZSB0aGUgbmZzOi8vLVVSTCBnaXZlbiBkZWZhdWx0LgorCQkgKgorCQkgKiBGSVhN
RTogV2UgZG8gbm90IGRvIHRoYXQgaGVyZSBmb3IgfE1TX1JET05MWXwhCisJCSAqLworCQlpZiAo
cG51Lm1vdW50X3BhcmFtcy5yZWFkX29ubHkgIT0gVFJJU19CT09MX05PVF9TRVQpIHsKKwkJCWlm
IChwbnUubW91bnRfcGFyYW1zLnJlYWRfb25seSkKKwkJCQlmbGFncyB8PSBNU19SRE9OTFk7CisJ
CQllbHNlCisJCQkJZmxhZ3MgJj0gfk1TX1JET05MWTsKKwkJfQorICAgICAgICB9IGVsc2Ugewor
CQkodm9pZClzdHJjcHkoaG9zdGRpciwgc3BlYyk7CisJCWlmICgocyA9IHN0cmNocihob3N0ZGly
LCAnOicpKSkgeworCQkJaG9zdG5hbWUgPSBob3N0ZGlyOworCQkJZGlybmFtZSA9IHMgKyAxOwog
CQkJKnMgPSAnXDAnOwotCQkJbmZzX2Vycm9yKF8oIiVzOiB3YXJuaW5nOiAiCi0JCQkJICAibXVs
dGlwbGUgaG9zdG5hbWVzIG5vdCBzdXBwb3J0ZWQiKSwKKwkJCS8qIElnbm9yZSBhbGwgYnV0IGZp
cnN0IGhvc3RuYW1lIGluIHJlcGxpY2F0ZWQgbW91bnRzCisJCQkgICB1bnRpbCB0aGV5IGNhbiBi
ZSBmdWxseSBzdXBwb3J0ZWQuIChtYWNrQHNnaS5jb20pICovCisJCQlpZiAoKHMgPSBzdHJjaHIo
aG9zdGRpciwgJywnKSkpIHsKKwkJCQkqcyA9ICdcMCc7CisJCQkJbmZzX2Vycm9yKF8oIiVzOiB3
YXJuaW5nOiAiCisJCQkJCSJtdWx0aXBsZSBob3N0bmFtZXMgbm90IHN1cHBvcnRlZCIpLAogCQkJ
CQlwcm9nbmFtZSk7Ci0JCX0KLQl9IGVsc2UgewotCQluZnNfZXJyb3IoXygiJXM6IGRpcmVjdG9y
eSB0byBtb3VudCBub3QgaW4gaG9zdDpkaXIgZm9ybWF0IiksCisJCQl9CisJCX0gZWxzZSB7CisJ
CQluZnNfZXJyb3IoXygiJXM6IGRpcmVjdG9yeSB0byBtb3VudCBub3QgaW4gaG9zdDpkaXIgZm9y
bWF0IiksCiAJCQkJcHJvZ25hbWUpOwotCQlnb3RvIGZhaWw7CisJCQlnb3RvIGZhaWw7CisJCX0K
IAl9CiAKIAlpZiAoIW5mc19nZXRob3N0YnluYW1lKGhvc3RuYW1lLCBuZnNfc2FkZHIpKQpAQCAt
NTc5LDYgKzYzMSwxNCBAQCBuZnNtb3VudChjb25zdCBjaGFyICpzcGVjLCBjb25zdCBjaGFyICpu
b2RlLCBpbnQgZmxhZ3MsCiAJbWVtc2V0KG5mc19wbWFwLCAwLCBzaXplb2YoKm5mc19wbWFwKSk7
CiAJbmZzX3BtYXAtPnBtX3Byb2cgPSBORlNfUFJPR1JBTTsKIAorCWlmIChuZnN1cmxfcG9ydCAh
PSAtMSkgeworCQkvKgorCQkgKiBTZXQgY3VzdG9tIFRDUCBwb3J0IGRlZmluZWQgYnkgYSBuZnM6
Ly8tVVJMIGhlcmUsCisJCSAqIHNvICQgbW91bnQgLW8gcG9ydCAuLi4gIyBjYW4gYmUgdXNlZCB0
byBvdmVycmlkZQorCQkgKi8KKwkJbmZzX3BtYXAtPnBtX3BvcnQgPSBuZnN1cmxfcG9ydDsKKwl9
CisKIAkvKiBwYXJzZSBvcHRpb25zICovCiAJbmV3X29wdHNbMF0gPSAwOwogCWlmICghcGFyc2Vf
b3B0aW9ucyhvbGRfb3B0cywgJmRhdGEsICZiZywgJnJldHJ5LCAmbW50X3NlcnZlciwgJm5mc19z
ZXJ2ZXIsCkBAIC04NjMsMTAgKzkyMywxMyBAQCBub2F1dGhfZmxhdm9yczoKIAkJfQogCX0KIAor
CW1vdW50X2ZyZWVfcGFyc2VfbmZzX3VybCgmcG51KTsKKwogCXJldHVybiBFWF9TVUNDRVNTOwog
CiAJLyogYWJvcnQgKi8KICBmYWlsOgorCW1vdW50X2ZyZWVfcGFyc2VfbmZzX3VybCgmcG51KTsK
IAlpZiAoZnNvY2sgIT0gLTEpCiAJCWNsb3NlKGZzb2NrKTsKIAlyZXR1cm4gcmV0dmFsOwpkaWZm
IC0tZ2l0IGEvdXRpbHMvbW91bnQvcGFyc2VfZGV2LmMgYi91dGlscy9tb3VudC9wYXJzZV9kZXYu
YwppbmRleCAyYWRlNWQ1ZC4uZDlmOGNmNTkgMTAwNjQ0Ci0tLSBhL3V0aWxzL21vdW50L3BhcnNl
X2Rldi5jCisrKyBiL3V0aWxzL21vdW50L3BhcnNlX2Rldi5jCkBAIC0yNyw2ICsyNyw4IEBACiAj
aW5jbHVkZSAieGNvbW1vbi5oIgogI2luY2x1ZGUgIm5scy5oIgogI2luY2x1ZGUgInBhcnNlX2Rl
di5oIgorI2luY2x1ZGUgInVybHBhcnNlcjEuaCIKKyNpbmNsdWRlICJ1dGlscy5oIgogCiAjaWZu
ZGVmIE5GU19NQVhIT1NUTkFNRQogI2RlZmluZSBORlNfTUFYSE9TVE5BTUUJCSgyNTUpCkBAIC0x
NzksMTcgKzE4MSw2MiBAQCBzdGF0aWMgaW50IG5mc19wYXJzZV9zcXVhcmVfYnJhY2tldChjb25z
dCBjaGFyICpkZXYsCiB9CiAKIC8qCi0gKiBSRkMgMjIyNCBzYXlzIGFuIE5GUyBjbGllbnQgbXVz
dCBncm9rICJwdWJsaWMgZmlsZSBoYW5kbGVzIiB0bwotICogc3VwcG9ydCBORlMgVVJMcy4gIExp
bnV4IGRvZXNuJ3QgZG8gdGhhdCB5ZXQuICBQcmludCBhIHNvbWV3aGF0Ci0gKiBoZWxwZnVsIGVy
cm9yIG1lc3NhZ2UgaW4gdGhpcyBjYXNlIGluc3RlYWQgb2YgcHJlc3NpbmcgZm9yd2FyZAotICog
d2l0aCB0aGUgbW91bnQgcmVxdWVzdCBhbmQgZmFpbGluZyB3aXRoIGEgY3J5cHRpYyBlcnJvciBt
ZXNzYWdlCi0gKiBsYXRlci4KKyAqIFN1cHBvcnQgbmZzOi8vLVVSTFMgcGVyIFJGQyAyMjI0ICgi
TkZTIFVSTAorICogU0NIRU1FIiwgc2VlIGh0dHBzOi8vd3d3LnJmYy1lZGl0b3Iub3JnL3JmYy9y
ZmMyMjI0Lmh0bWwpLAorICogaW5jbHVkaW5nIHBvcnQgc3VwcG9ydCAobmZzOi8vaG9zdG5hbWVA
cG9ydC9wYXRoLy4uLikKICAqLwotc3RhdGljIGludCBuZnNfcGFyc2VfbmZzX3VybChfX2F0dHJp
YnV0ZV9fKCh1bnVzZWQpKSBjb25zdCBjaGFyICpkZXYsCi0JCQkgICAgIF9fYXR0cmlidXRlX18o
KHVudXNlZCkpIGNoYXIgKipob3N0bmFtZSwKLQkJCSAgICAgX19hdHRyaWJ1dGVfXygodW51c2Vk
KSkgY2hhciAqKnBhdGhuYW1lKQorc3RhdGljIGludCBuZnNfcGFyc2VfbmZzX3VybChjb25zdCBj
aGFyICpkZXYsCisJCQkgICAgIGNoYXIgKipvdXRfaG9zdG5hbWUsCisJCQkgICAgIGNoYXIgKipv
dXRfcGF0aG5hbWUpCiB7Ci0JbmZzX2Vycm9yKF8oIiVzOiBORlMgVVJMcyBhcmUgbm90IHN1cHBv
cnRlZCIpLCBwcm9nbmFtZSk7CisJcGFyc2VkX25mc191cmwgcG51OworCisJaWYgKG91dF9ob3N0
bmFtZSkKKwkJKm91dF9ob3N0bmFtZSA9IE5VTEw7CisJaWYgKG91dF9wYXRobmFtZSkKKwkJKm91
dF9wYXRobmFtZSA9IE5VTEw7CisKKwkvKgorCSAqIFN1cHBvcnQgbmZzOi8vLVVSTFMgcGVyIFJG
QyAyMjI0ICgiTkZTIFVSTAorCSAqIFNDSEVNRSIsIHNlZSBodHRwczovL3d3dy5yZmMtZWRpdG9y
Lm9yZy9yZmMvcmZjMjIyNC5odG1sKSwKKwkgKiBpbmNsdWRpbmcgY3VzdG9tIHBvcnQgKG5mczov
L2hvc3RuYW1lQHBvcnQvcGF0aC8uLi4pCisJICogYW5kIFVSTCBwYXJhbWV0ZXIgKGUuZy4gbmZz
Oi8vLi4uLz9wYXJhbTE9dmFsMSZwYXJhbTI9dmFsMgorCSAqIHN1cHBvcnQKKwkgKi8KKwlpZiAo
IW1vdW50X3BhcnNlX25mc191cmwoZGV2LCAmcG51KSkgeworCQlnb3RvIGZhaWw7CisJfQorCisJ
aWYgKHBudS51Y3R4LT5ob3N0cG9ydC5wb3J0ICE9IC0xKSB7CisJCS8qIE5PUCBoZXJlLCB1bmxl
c3Mgd2Ugc3dpdGNoIGZyb20gaG9zdG5hbWUgdG8gaG9zdHBvcnQgKi8KKwl9CisKKwlpZiAob3V0
X2hvc3RuYW1lKQorCQkqb3V0X2hvc3RuYW1lID0gc3RyZHVwKHBudS51Y3R4LT5ob3N0cG9ydC5o
b3N0bmFtZSk7CisJaWYgKG91dF9wYXRobmFtZSkKKwkJKm91dF9wYXRobmFtZSA9IHV0ZjhzdHIy
bWJzdHIocG51LnVjdHgtPnBhdGgpOworCisJaWYgKCgob3V0X2hvc3RuYW1lKT8oKm91dF9ob3N0
bmFtZSA9PSBOVUxMKTowKSB8fAorCQkoKG91dF9wYXRobmFtZSk/KCpvdXRfcGF0aG5hbWUgPT0g
TlVMTCk6MCkpIHsKKwkJbmZzX2Vycm9yKF8oIiVzOiBvdXQgb2YgbWVtb3J5IiksCisJCQlwcm9n
bmFtZSk7CisJCWdvdG8gZmFpbDsKKwl9CisKKwltb3VudF9mcmVlX3BhcnNlX25mc191cmwoJnBu
dSk7CisKKwlyZXR1cm4gMTsKKworZmFpbDoKKwltb3VudF9mcmVlX3BhcnNlX25mc191cmwoJnBu
dSk7CisJaWYgKG91dF9ob3N0bmFtZSkgeworCQlmcmVlKCpvdXRfaG9zdG5hbWUpOworCQkqb3V0
X2hvc3RuYW1lID0gTlVMTDsKKwl9CisJaWYgKG91dF9wYXRobmFtZSkgeworCQlmcmVlKCpvdXRf
cGF0aG5hbWUpOworCQkqb3V0X3BhdGhuYW1lID0gTlVMTDsKKwl9CiAJcmV0dXJuIDA7CiB9CiAK
QEAgLTIyMyw3ICsyNzAsNyBAQCBpbnQgbmZzX3BhcnNlX2Rldm5hbWUoY29uc3QgY2hhciAqZGV2
bmFtZSwKIAkJcmV0dXJuIG5mc19wZG5fbm9tZW1fZXJyKCk7CiAJaWYgKCpkZXYgPT0gJ1snKQog
CQlyZXN1bHQgPSBuZnNfcGFyc2Vfc3F1YXJlX2JyYWNrZXQoZGV2LCBob3N0bmFtZSwgcGF0aG5h
bWUpOwotCWVsc2UgaWYgKHN0cm5jbXAoZGV2LCAibmZzOi8vIiwgNikgPT0gMCkKKwllbHNlIGlm
IChpc19zcGVjX25mc191cmwoZGV2KSkKIAkJcmVzdWx0ID0gbmZzX3BhcnNlX25mc191cmwoZGV2
LCBob3N0bmFtZSwgcGF0aG5hbWUpOwogCWVsc2UKIAkJcmVzdWx0ID0gbmZzX3BhcnNlX3NpbXBs
ZV9ob3N0bmFtZShkZXYsIGhvc3RuYW1lLCBwYXRobmFtZSk7CmRpZmYgLS1naXQgYS91dGlscy9t
b3VudC9zdHJvcHRzLmMgYi91dGlscy9tb3VudC9zdHJvcHRzLmMKaW5kZXggMjNmMGE4YzAuLmFk
OTJhYjc4IDEwMDY0NAotLS0gYS91dGlscy9tb3VudC9zdHJvcHRzLmMKKysrIGIvdXRpbHMvbW91
bnQvc3Ryb3B0cy5jCkBAIC00Miw2ICs0Miw3IEBACiAjaW5jbHVkZSAibmxzLmgiCiAjaW5jbHVk
ZSAibmZzcnBjLmgiCiAjaW5jbHVkZSAibW91bnRfY29uc3RhbnRzLmgiCisjaW5jbHVkZSAidXJs
cGFyc2VyMS5oIgogI2luY2x1ZGUgInN0cm9wdHMuaCIKICNpbmNsdWRlICJlcnJvci5oIgogI2lu
Y2x1ZGUgIm5ldHdvcmsuaCIKQEAgLTUwLDYgKzUxLDcgQEAKICNpbmNsdWRlICJwYXJzZV9kZXYu
aCIKICNpbmNsdWRlICJjb25mZmlsZS5oIgogI2luY2x1ZGUgIm1pc2MuaCIKKyNpbmNsdWRlICJ1
dGlscy5oIgogCiAjaWZuZGVmIE5GU19QUk9HUkFNCiAjZGVmaW5lIE5GU19QUk9HUkFNCSgxMDAw
MDMpCkBAIC02NDMsMjQgKzY0NSwxMDYgQEAgc3RhdGljIGludCBuZnNfc3lzX21vdW50KHN0cnVj
dCBuZnNtb3VudF9pbmZvICptaSwgc3RydWN0IG1vdW50X29wdGlvbnMgKm9wdHMpCiB7CiAJY2hh
ciAqb3B0aW9ucyA9IE5VTEw7CiAJaW50IHJlc3VsdDsKKwlpbnQgbmZzX3BvcnQgPSAyMDQ5Owog
CiAJaWYgKG1pLT5mYWtlKQogCQlyZXR1cm4gMTsKIAotCWlmIChwb19qb2luKG9wdHMsICZvcHRp
b25zKSA9PSBQT19GQUlMRUQpIHsKLQkJZXJybm8gPSBFSU87Ci0JCXJldHVybiAwOwotCX0KKwkv
KgorCSAqIFN1cHBvcnQgbmZzOi8vLVVSTFMgcGVyIFJGQyAyMjI0ICgiTkZTIFVSTAorCSAqIFND
SEVNRSIsIHNlZSBodHRwczovL3d3dy5yZmMtZWRpdG9yLm9yZy9yZmMvcmZjMjIyNC5odG1sKSwK
KwkgKiBpbmNsdWRpbmcgY3VzdG9tIHBvcnQgKG5mczovL2hvc3RuYW1lQHBvcnQvcGF0aC8uLi4p
CisJICogYW5kIFVSTCBwYXJhbWV0ZXIgKGUuZy4gbmZzOi8vLi4uLz9wYXJhbTE9dmFsMSZwYXJh
bTI9dmFsMgorCSAqIHN1cHBvcnQKKwkgKi8KKwlpZiAoaXNfc3BlY19uZnNfdXJsKG1pLT5zcGVj
KSkgeworCQlwYXJzZWRfbmZzX3VybCBwbnU7CisJCWNoYXIgKm1iX3BhdGg7CisJCWNoYXIgbW91
bnRfc291cmNlWzEwMjRdOworCisJCWlmICghbW91bnRfcGFyc2VfbmZzX3VybChtaS0+c3BlYywg
JnBudSkpIHsKKwkJCXJlc3VsdCA9IDE7CisJCQllcnJubyA9IEVJTlZBTDsKKwkJCWdvdG8gZG9u
ZTsKKwkJfQorCisJCS8qCisJCSAqIHxwbnUudWN0eC0+cGF0aHwgaXMgaW4gVVRGLTgsIGJ1dCB3
ZSBuZWVkIHRoZSBkYXRhCisJCSAqIGluIHRoZSBjdXJyZW50IGxvY2FsIGxvY2FsZSdzIGVuY29k
aW5nLCBhcyBtb3VudCgyKQorCQkgKiBkb2VzIG5vdCBoYXZlIHNvbWV0aGluZyBsaWtlIGEgfE1T
X1VURjhfU1BFQ3wgZmxhZworCQkgKiB0byBpbmRpY2F0ZSB0aGF0IHRoZSBpbnB1dCBwYXRoIGlz
IGluIFVURi04LAorCQkgKiBpbmRlcGVuZGVudGx5IG9mIHRoZSBjdXJyZW50IGxvY2FsZQorCQkg
Ki8KKwkJbWJfcGF0aCA9IHV0ZjhzdHIybWJzdHIocG51LnVjdHgtPnBhdGgpOworCQlpZiAoIW1i
X3BhdGgpIHsKKwkJCW5mc19lcnJvcihfKCIlczogQ291bGQgbm90IGNvbnZlcnQgcGF0aCB0byBs
b2NhbCBlbmNvZGluZy4iKSwKKwkJCQlwcm9nbmFtZSk7CisJCQltb3VudF9mcmVlX3BhcnNlX25m
c191cmwoJnBudSk7CisJCQlyZXN1bHQgPSAxOworCQkJZXJybm8gPSBFSU5WQUw7CisJCQlnb3Rv
IGRvbmU7CisJCX0KKworCQkodm9pZClzbnByaW50Zihtb3VudF9zb3VyY2UsIHNpemVvZihtb3Vu
dF9zb3VyY2UpLAorCQkJIiVzOi8lcyIsCisJCQlwbnUudWN0eC0+aG9zdHBvcnQuaG9zdG5hbWUs
CisJCQltYl9wYXRoKTsKKwkJZnJlZShtYl9wYXRoKTsKKworCQlpZiAocG51LnVjdHgtPmhvc3Rw
b3J0LnBvcnQgIT0gLTEpIHsKKwkJCW5mc19wb3J0ID0gcG51LnVjdHgtPmhvc3Rwb3J0LnBvcnQ7
CisJCX0KIAotCXJlc3VsdCA9IG1vdW50KG1pLT5zcGVjLCBtaS0+bm9kZSwgbWktPnR5cGUsCisJ
CS8qCisJCSAqIEluc2VydCAicG9ydD0iIG9wdGlvbiB3aXRoIHRoZSB2YWx1ZSBmcm9tIHRoZSBu
ZnM6Ly8KKwkJICogVVJMIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhlIGxpc3Qgb2Ygb3B0aW9ucywg
c28KKwkJICogdXNlcnMgY2FuIG92ZXJyaWRlIGl0IHdpdGggJCBtb3VudC5uZnM0IC1vIHBvcnQ9
ICMsCisJCSAqIGUuZy4KKwkJICogJCBtb3VudC5uZnM0IC1vIHBvcnQ9MTIzNCBuZnM6Ly8xMC40
OS4yMDIuMjMwOjQwMC8vYmlnZGlzayAvbW50NCAjCisJCSAqIHNob3VsZCB1c2UgcG9ydCAxMjM0
LCBhbmQgbm90IHBvcnQgNDAwIGFzIHNwZWNpZmllZAorCQkgKiBpbiB0aGUgVVJMLgorCQkgKi8K
KwkJY2hhciBwb3J0b3B0YnVmWzUrMzIrMV07CisJCSh2b2lkKXNucHJpbnRmKHBvcnRvcHRidWYs
IHNpemVvZihwb3J0b3B0YnVmKSwgInBvcnQ9JWQiLCBuZnNfcG9ydCk7CisJCSh2b2lkKXBvX2lu
c2VydChvcHRzLCBwb3J0b3B0YnVmKTsKKworCQlpZiAocG51Lm1vdW50X3BhcmFtcy5yZWFkX29u
bHkgIT0gVFJJU19CT09MX05PVF9TRVQpIHsKKwkJCWlmIChwbnUubW91bnRfcGFyYW1zLnJlYWRf
b25seSkKKwkJCQltaS0+ZmxhZ3MgfD0gTVNfUkRPTkxZOworCQkJZWxzZQorCQkJCW1pLT5mbGFn
cyAmPSB+TVNfUkRPTkxZOworCQl9CisKKwkJbW91bnRfZnJlZV9wYXJzZV9uZnNfdXJsKCZwbnUp
OworCisJCWlmIChwb19qb2luKG9wdHMsICZvcHRpb25zKSA9PSBQT19GQUlMRUQpIHsKKwkJCWVy
cm5vID0gRUlPOworCQkJcmVzdWx0ID0gMTsKKwkJCWdvdG8gZG9uZTsKKwkJfQorCisJCXJlc3Vs
dCA9IG1vdW50KG1vdW50X3NvdXJjZSwgbWktPm5vZGUsIG1pLT50eXBlLAorCQkJbWktPmZsYWdz
ICYgfihNU19VU0VSfE1TX1VTRVJTKSwgb3B0aW9ucyk7CisJCWZyZWUob3B0aW9ucyk7CisJfSBl
bHNlIHsKKwkJaWYgKHBvX2pvaW4ob3B0cywgJm9wdGlvbnMpID09IFBPX0ZBSUxFRCkgeworCQkJ
ZXJybm8gPSBFSU87CisJCQlyZXN1bHQgPSAxOworCQkJZ290byBkb25lOworCQl9CisKKwkJcmVz
dWx0ID0gbW91bnQobWktPnNwZWMsIG1pLT5ub2RlLCBtaS0+dHlwZSwKIAkJCW1pLT5mbGFncyAm
IH4oTVNfVVNFUnxNU19VU0VSUyksIG9wdGlvbnMpOwotCWZyZWUob3B0aW9ucyk7CisJCWZyZWUo
b3B0aW9ucyk7CisJfQogCiAJaWYgKHZlcmJvc2UgJiYgcmVzdWx0KSB7CiAJCWludCBzYXZlID0g
ZXJybm87CiAJCW5mc19lcnJvcihfKCIlczogbW91bnQoMik6ICVzIiksIHByb2duYW1lLCBzdHJl
cnJvcihzYXZlKSk7CiAJCWVycm5vID0gc2F2ZTsKIAl9CisKK2RvbmU6CiAJcmV0dXJuICFyZXN1
bHQ7CiB9CiAKZGlmZiAtLWdpdCBhL3V0aWxzL21vdW50L3VybHBhcnNlcjEuYyBiL3V0aWxzL21v
dW50L3VybHBhcnNlcjEuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMC4uZDRj
NmYzMzkKLS0tIC9kZXYvbnVsbAorKysgYi91dGlscy9tb3VudC91cmxwYXJzZXIxLmMKQEAgLTAs
MCArMSwzNTggQEAKKy8qCisgKiBNSVQgTGljZW5zZQorICoKKyAqIENvcHlyaWdodCAoYykgMjAy
NCBSb2xhbmQgTWFpbnogPHJvbGFuZC5tYWluekBucnVic2lnLm9yZz4KKyAqCisgKiBQZXJtaXNz
aW9uIGlzIGhlcmVieSBncmFudGVkLCBmcmVlIG9mIGNoYXJnZSwgdG8gYW55IHBlcnNvbiBvYnRh
aW5pbmcgYSBjb3B5CisgKiBvZiB0aGlzIHNvZnR3YXJlIGFuZCBhc3NvY2lhdGVkIGRvY3VtZW50
YXRpb24gZmlsZXMgKHRoZSAiU29mdHdhcmUiKSwgdG8gZGVhbAorICogaW4gdGhlIFNvZnR3YXJl
IHdpdGhvdXQgcmVzdHJpY3Rpb24sIGluY2x1ZGluZyB3aXRob3V0IGxpbWl0YXRpb24gdGhlIHJp
Z2h0cworICogdG8gdXNlLCBjb3B5LCBtb2RpZnksIG1lcmdlLCBwdWJsaXNoLCBkaXN0cmlidXRl
LCBzdWJsaWNlbnNlLCBhbmQvb3Igc2VsbAorICogY29waWVzIG9mIHRoZSBTb2Z0d2FyZSwgYW5k
IHRvIHBlcm1pdCBwZXJzb25zIHRvIHdob20gdGhlIFNvZnR3YXJlIGlzCisgKiBmdXJuaXNoZWQg
dG8gZG8gc28sIHN1YmplY3QgdG8gdGhlIGZvbGxvd2luZyBjb25kaXRpb25zOgorICoKKyAqIFRo
ZSBhYm92ZSBjb3B5cmlnaHQgbm90aWNlIGFuZCB0aGlzIHBlcm1pc3Npb24gbm90aWNlIHNoYWxs
IGJlIGluY2x1ZGVkIGluIGFsbAorICogY29waWVzIG9yIHN1YnN0YW50aWFsIHBvcnRpb25zIG9m
IHRoZSBTb2Z0d2FyZS4KKyAqCisgKiBUSEUgU09GVFdBUkUgSVMgUFJPVklERUQgIkFTIElTIiwg
V0lUSE9VVCBXQVJSQU5UWSBPRiBBTlkgS0lORCwgRVhQUkVTUyBPUgorICogSU1QTElFRCwgSU5D
TFVESU5HIEJVVCBOT1QgTElNSVRFRCBUTyBUSEUgV0FSUkFOVElFUyBPRiBNRVJDSEFOVEFCSUxJ
VFksCisgKiBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRSBBTkQgTk9OSU5GUklOR0VN
RU5ULiBJTiBOTyBFVkVOVCBTSEFMTCBUSEUKKyAqIEFVVEhPUlMgT1IgQ09QWVJJR0hUIEhPTERF
UlMgQkUgTElBQkxFIEZPUiBBTlkgQ0xBSU0sIERBTUFHRVMgT1IgT1RIRVIKKyAqIExJQUJJTElU
WSwgV0hFVEhFUiBJTiBBTiBBQ1RJT04gT0YgQ09OVFJBQ1QsIFRPUlQgT1IgT1RIRVJXSVNFLCBB
UklTSU5HIEZST00sCisgKiBPVVQgT0YgT1IgSU4gQ09OTkVDVElPTiBXSVRIIFRIRSBTT0ZUV0FS
RSBPUiBUSEUgVVNFIE9SIE9USEVSIERFQUxJTkdTIElOIFRIRQorICogU09GVFdBUkUuCisgKi8K
KworLyogdXJscGFyc2VyMS5jIC0gc2ltcGxlIFVSTCBwYXJzZXIgKi8KKworI2luY2x1ZGUgPHN0
ZGxpYi5oPgorI2luY2x1ZGUgPHN0ZGJvb2wuaD4KKyNpbmNsdWRlIDxzdHJpbmcuaD4KKyNpbmNs
dWRlIDxjdHlwZS5oPgorI2luY2x1ZGUgPHN0ZGlvLmg+CisKKyNpZmRlZiBEQkdfVVNFX1dJREVD
SEFSCisjaW5jbHVkZSA8d2NoYXIuaD4KKyNpbmNsdWRlIDxsb2NhbGUuaD4KKyNpbmNsdWRlIDxp
by5oPgorI2luY2x1ZGUgPGZjbnRsLmg+CisjZW5kaWYgLyogREJHX1VTRV9XSURFQ0hBUiAqLwor
CisjaW5jbHVkZSAidXJscGFyc2VyMS5oIgorCit0eXBlZGVmIHN0cnVjdCBfdXJsX3BhcnNlcl9j
b250ZXh0X3ByaXZhdGUgeworCXVybF9wYXJzZXJfY29udGV4dCBjOworCisJLyogUHJpdmF0ZSBk
YXRhICovCisJY2hhciAqcGFyYW1ldGVyX3N0cmluZ19idWZmOworfSB1cmxfcGFyc2VyX2NvbnRl
eHRfcHJpdmF0ZTsKKworI2RlZmluZSBNQVhfVVJMX1BBUkFNRVRFUlMgMjU2CisKKy8qCisgKiBP
cmlnaW5hbCBleHRlbmRlZCByZWd1bGFyIGV4cHJlc3Npb246CisgKgorICogIl4iCisgKiAiKC4r
PykiCQkJCS8vIHNjaGVtZQorICogIjovLyIJCQkJLy8gJzovLycKKyAqICIoIgkJCQkJLy8gbG9n
aW4KKyAqCSIoPzoiCisgKgkiKC4rPykiCQkJCS8vIHVzZXIgKG9wdGlvbmFsKQorICoJCSIoPzo6
KC4rKSk/IgkJLy8gcGFzc3dvcmQgKG9wdGlvbmFsKQorICoJCSJAIgorICoJIik/IgorICoJIigi
CQkJCS8vIGhvc3Rwb3J0CisgKgkJIiguKz8pIgkJCS8vIGhvc3QKKyAqCQkiKD86OihbWzpkaWdp
dDpdXSspKT8iCS8vIHBvcnQgKG9wdGlvbmFsKQorICoJIikiCisgKiAiKSIKKyAqICIoPzovKC4q
PykpPyIJCQkvLyBwYXRoIChvcHRpb25hbCkKKyAqICIoPzpcPyguKj8pKT8iCQkJLy8gVVJMIHBh
cmFtZXRlcnMgKG9wdGlvbmFsKQorICogIiQiCisgKi8KKworI2RlZmluZSBEQkdOVUxMU1RSKHMp
ICgoKHMpIT1OVUxMKT8ocyk6IjxOVUxMPiIpCisjaWYgMCB8fCBkZWZpbmVkKFRFU1RfVVJMUEFS
U0VSKQorI2RlZmluZSBEKHgpIHgKKyNlbHNlCisjZGVmaW5lIEQoeCkKKyNlbmRpZgorCisjaWZk
ZWYgREJHX1VTRV9XSURFQ0hBUgorLyoKKyAqIFVzZSB3aWRlLWNoYXIgQVBJcyBvbiBXSU4zMiwg
b3RoZXJ3aXNlIHdlIGNhbm5vdCBvdXRwdXQKKyAqIEphcGFuZXNlL0NoaW5lc2UvZXRjIGNvcnJl
Y3RseQorICovCisjZGVmaW5lIERCR19QVVRTKHN0ciwgZnApCQlmcHV0d3MoTCIiIHN0ciwgKGZw
KSkKKyNkZWZpbmUgREJHX1BVVEMoYywgZnApCQkJZnB1dHdjKGJ0b3djKGMpLCAoZnApKQorI2Rl
ZmluZSBEQkdfUFJJTlRGKGZwLCBmbXQsIC4uLikJZndwcmludGYoKGZwKSwgTCIiIGZtdCwgX19W
QV9BUkdTX18pCisjZWxzZQorI2RlZmluZSBEQkdfUFVUUyhzdHIsIGZwKQkJZnB1dHMoKHN0ciks
IChmcCkpCisjZGVmaW5lIERCR19QVVRDKGMsIGZwKQkJCWZwdXRjKChjKSwgKGZwKSkKKyNkZWZp
bmUgREJHX1BSSU5URihmcCwgZm10LCAuLi4pCWZwcmludGYoKGZwKSwgZm10LCBfX1ZBX0FSR1Nf
XykKKyNlbmRpZiAvKiBEQkdfVVNFX1dJREVDSEFSICovCisKK3N0YXRpYwordm9pZCB1cmxkZWNv
ZGVzdHIoY2hhciAqb3V0YnVmZiwgY29uc3QgY2hhciAqYnVmZmVyLCBzaXplX3QgbGVuKQorewor
CXNpemVfdCBpLCBqOworCisJZm9yIChpID0gaiA9IDAgOyBpIDwgbGVuIDsgKSB7CisJCXN3aXRj
aCAoYnVmZmVyW2ldKSB7CisJCQljYXNlICclJzoKKwkJCQlpZiAoKGkgKyAyKSA8IGxlbikgewor
CQkJCQlpZiAoaXN4ZGlnaXQoKGludClidWZmZXJbaSsxXSkgJiYgaXN4ZGlnaXQoKGludClidWZm
ZXJbaSsyXSkpIHsKKwkJCQkJCWNvbnN0IGNoYXIgaGV4c3RyWzNdID0geworCQkJCQkJCWJ1ZmZl
cltpKzFdLAorCQkJCQkJCWJ1ZmZlcltpKzJdLAorCQkJCQkJCSdcMCcKKwkJCQkJCX07CisJCQkJ
CQlvdXRidWZmW2orK10gPSAodW5zaWduZWQgY2hhcilzdHJ0b2woaGV4c3RyLCBOVUxMLCAxNik7
CisJCQkJCQlpICs9IDM7CisJCQkJCX0gZWxzZSB7CisJCQkJCQkvKiBpbnZhbGlkIGhleCBkaWdp
dCAqLworCQkJCQkJb3V0YnVmZltqKytdID0gYnVmZmVyW2ldOworCQkJCQkJaSsrOworCQkJCQl9
CisJCQkJfSBlbHNlIHsKKwkJCQkJLyogaW5jb21wbGV0ZSBoZXggZGlnaXQgKi8KKwkJCQkJb3V0
YnVmZltqKytdID0gYnVmZmVyW2ldOworCQkJCQlpKys7CisJCQkJfQorCQkJCWJyZWFrOworCQkJ
Y2FzZSAnKyc6CisJCQkJb3V0YnVmZltqKytdID0gJyAnOworCQkJCWkrKzsKKwkJCQlicmVhazsK
KwkJCWRlZmF1bHQ6CisJCQkJb3V0YnVmZltqKytdID0gYnVmZmVyW2krK107CisJCQkJYnJlYWs7
CisJCX0KKwl9CisKKwlvdXRidWZmW2pdID0gJ1wwJzsKK30KKwordXJsX3BhcnNlcl9jb250ZXh0
ICp1cmxfcGFyc2VyX2NyZWF0ZV9jb250ZXh0KGNvbnN0IGNoYXIgKmluX3VybCwgdW5zaWduZWQg
aW50IGZsYWdzKQoreworCXVybF9wYXJzZXJfY29udGV4dF9wcml2YXRlICp1Y3R4OworCWNoYXIg
KnM7CisJc2l6ZV90IGluX3VybF9sZW47CisJc2l6ZV90IGNvbnRleHRfbGVuOworCisJLyogfGZs
YWdzfCBpcyBmb3IgZnV0dXJlIGV4dGVuc2lvbnMgKi8KKwkodm9pZClmbGFnczsKKworCWlmICgh
aW5fdXJsKQorCQlyZXR1cm4gTlVMTDsKKworCWluX3VybF9sZW4gPSBzdHJsZW4oaW5fdXJsKTsK
KworCWNvbnRleHRfbGVuID0gc2l6ZW9mKHVybF9wYXJzZXJfY29udGV4dF9wcml2YXRlKSArCisJ
CSgoaW5fdXJsX2xlbisxKSo2KSArCisJCShzaXplb2YodXJsX3BhcnNlcl9uYW1lX3ZhbHVlKSpN
QVhfVVJMX1BBUkFNRVRFUlMpK3NpemVvZih2b2lkKik7CisJdWN0eCA9IG1hbGxvYyhjb250ZXh0
X2xlbik7CisJaWYgKCF1Y3R4KQorCQlyZXR1cm4gTlVMTDsKKworCXMgPSAodm9pZCAqKSh1Y3R4
KzEpOworCXVjdHgtPmMuaW5fdXJsID0gczsJCXMrPSBpbl91cmxfbGVuKzE7CisJKHZvaWQpc3Ry
Y3B5KHVjdHgtPmMuaW5fdXJsLCBpbl91cmwpOworCXVjdHgtPmMuc2NoZW1lID0gczsJCXMrPSBp
bl91cmxfbGVuKzE7CisJdWN0eC0+Yy5sb2dpbi51c2VybmFtZSA9IHM7CXMrPSBpbl91cmxfbGVu
KzE7CisJdWN0eC0+Yy5ob3N0cG9ydC5ob3N0bmFtZSA9IHM7CXMrPSBpbl91cmxfbGVuKzE7CisJ
dWN0eC0+Yy5wYXRoID0gczsJCXMrPSBpbl91cmxfbGVuKzE7CisJdWN0eC0+Yy5ob3N0cG9ydC5w
b3J0ID0gLTE7CisJdWN0eC0+Yy5udW1fcGFyYW1ldGVycyA9IC0xOworCXVjdHgtPmMucGFyYW1l
dGVycyA9ICh2b2lkICopczsJCXMrPSAoc2l6ZW9mKHVybF9wYXJzZXJfbmFtZV92YWx1ZSkqTUFY
X1VSTF9QQVJBTUVURVJTKStzaXplb2Yodm9pZCopOworCXVjdHgtPnBhcmFtZXRlcl9zdHJpbmdf
YnVmZiA9IHM7CXMrPSBpbl91cmxfbGVuKzE7CisKKwlyZXR1cm4gJnVjdHgtPmM7Cit9CisKK2lu
dCB1cmxfcGFyc2VyX3BhcnNlKHVybF9wYXJzZXJfY29udGV4dCAqY3R4KQoreworCXVybF9wYXJz
ZXJfY29udGV4dF9wcml2YXRlICp1Y3R4ID0gKHVybF9wYXJzZXJfY29udGV4dF9wcml2YXRlICop
Y3R4OworCisJRCgodm9pZClEQkdfUFJJTlRGKHN0ZGVyciwgIiMjIHBhcnNlciBpbl91cmw9JyVz
J1xuIiwgdWN0eC0+Yy5pbl91cmwpKTsKKworCWNoYXIgKnM7CisJY29uc3QgY2hhciAqdXJsc3Ry
ID0gdWN0eC0+Yy5pbl91cmw7CisJc2l6ZV90IHNsZW47CisKKwlzID0gc3Ryc3RyKHVybHN0ciwg
IjovLyIpOworCWlmICghcykgeworCQlEKCh2b2lkKURCR19QVVRTKCJ1cmxfcGFyc2VyOiBOb3Qg
YW4gVVJMXG4iLCBzdGRlcnIpKTsKKwkJcmV0dXJuIC0xOworCX0KKworCXNsZW4gPSBzLXVybHN0
cjsKKwkodm9pZCltZW1jcHkodWN0eC0+Yy5zY2hlbWUsIHVybHN0ciwgc2xlbik7CisJdWN0eC0+
Yy5zY2hlbWVbc2xlbl0gPSAnXDAnOworCXVybHN0ciArPSBzbGVuICsgMzsKKworCUQoKHZvaWQp
REJHX1BSSU5URihzdGRvdXQsICJzY2hlbWU9JyVzJywgcmVzdD0nJXMnXG4iLCB1Y3R4LT5jLnNj
aGVtZSwgdXJsc3RyKSk7CisKKwlzID0gc3Ryc3RyKHVybHN0ciwgIkAiKTsKKwlpZiAocykgewor
CQkvKiBVUkwgaGFzIHVzZXIvcGFzc3dvcmQgKi8KKwkJc2xlbiA9IHMtdXJsc3RyOworCQl1cmxk
ZWNvZGVzdHIodWN0eC0+Yy5sb2dpbi51c2VybmFtZSwgdXJsc3RyLCBzbGVuKTsKKwkJdXJsc3Ry
ICs9IHNsZW4gKyAxOworCisJCXMgPSBzdHJzdHIodWN0eC0+Yy5sb2dpbi51c2VybmFtZSwgIjoi
KTsKKwkJaWYgKHMpIHsKKwkJCS8qIGZvdW5kIHBhc3N3ZCAqLworCQkJdWN0eC0+Yy5sb2dpbi5w
YXNzd2QgPSBzKzE7CisJCQkqcyA9ICdcMCc7CisJCX0KKwkJZWxzZSB7CisJCQl1Y3R4LT5jLmxv
Z2luLnBhc3N3ZCA9IE5VTEw7CisJCX0KKworCQkvKiBjYXRjaCBwYXNzd29yZC1vbmx5IFVSTHMg
Ki8KKwkJaWYgKHVjdHgtPmMubG9naW4udXNlcm5hbWVbMF0gPT0gJ1wwJykKKwkJCXVjdHgtPmMu
bG9naW4udXNlcm5hbWUgPSBOVUxMOworCX0KKwllbHNlIHsKKwkJdWN0eC0+Yy5sb2dpbi51c2Vy
bmFtZSA9IE5VTEw7CisJCXVjdHgtPmMubG9naW4ucGFzc3dkID0gTlVMTDsKKwl9CisKKwlEKCh2
b2lkKURCR19QUklOVEYoc3Rkb3V0LCAibG9naW49JyVzJywgcGFzc3dkPSclcycsIHJlc3Q9JyVz
J1xuIiwKKwkJREJHTlVMTFNUUih1Y3R4LT5jLmxvZ2luLnVzZXJuYW1lKSwKKwkJREJHTlVMTFNU
Uih1Y3R4LT5jLmxvZ2luLnBhc3N3ZCksCisJCURCR05VTExTVFIodXJsc3RyKSkpOworCisJY2hh
ciAqcmF3X3BhcmFtZXRlcnM7CisKKwl1Y3R4LT5jLm51bV9wYXJhbWV0ZXJzID0gMDsKKwlyYXdf
cGFyYW1ldGVycyA9IHN0cnN0cih1cmxzdHIsICI/Iik7CisJLyogRG8gd2UgaGF2ZSBhIG5vbi1l
bXB0eSBwYXJhbWV0ZXIgc3RyaW5nID8gKi8KKwlpZiAocmF3X3BhcmFtZXRlcnMgJiYgKHJhd19w
YXJhbWV0ZXJzWzFdICE9ICdcMCcpKSB7CisJCSpyYXdfcGFyYW1ldGVycysrID0gJ1wwJzsKKwkJ
RCgodm9pZClEQkdfUFJJTlRGKHN0ZG91dCwgInJhdyBwYXJhbWV0ZXJzID0gJyVzJ1xuIiwgcmF3
X3BhcmFtZXRlcnMpKTsKKworCQljaGFyICpwcyA9IHJhd19wYXJhbWV0ZXJzOworCQljaGFyICpw
djsgLyogcGFyYW1ldGVyIHZhbHVlICovCisJCWNoYXIgKm5hOyAvKiBuZXh0ICcmJyAqLworCQlj
aGFyICpwYiA9IHVjdHgtPnBhcmFtZXRlcl9zdHJpbmdfYnVmZjsKKwkJY2hhciAqcG5hbWU7CisJ
CWNoYXIgKnB2YWx1ZTsKKwkJc3NpemVfdCBwaTsKKworCQlmb3IgKHBpID0gMDsgcGkgPCBNQVhf
VVJMX1BBUkFNRVRFUlMgOyBwaSsrKSB7CisJCQlwbmFtZSA9IHBzOworCisJCQkvKgorCQkJICog
SGFuZGxlIHBhcmFtZXRlcnMgd2l0aG91dCB2YWx1ZSwKKwkJCSAqIGUuZy4gInBhdGg/bmFtZTEm
bmFtZTI9dmFsdWUyIgorCQkJICovCisJCQluYSA9IHN0cnN0cihwcywgIiYiKTsKKwkJCXB2ID0g
c3Ryc3RyKHBzLCAiPSIpOworCQkJaWYgKHB2ICYmIChuYT8obmEgPiBwdik6dHJ1ZSkpIHsKKwkJ
CQkqcHYrKyA9ICdcMCc7CisJCQkJcHZhbHVlID0gcHY7CisJCQkJcHMgPSBwdjsKKwkJCX0KKwkJ
CWVsc2UgeworCQkJCXB2YWx1ZSA9IE5VTEw7CisJCQl9CisKKwkJCWlmIChuYSkgeworCQkJCSpu
YSsrID0gJ1wwJzsKKwkJCX0KKworCQkJLyogVVJMRGVjb2RlIHBhcmFtZXRlciBuYW1lICovCisJ
CQl1cmxkZWNvZGVzdHIocGIsIHBuYW1lLCBzdHJsZW4ocG5hbWUpKTsKKwkJCXVjdHgtPmMucGFy
YW1ldGVyc1twaV0ubmFtZSA9IHBiOworCQkJcGIgKz0gc3RybGVuKHVjdHgtPmMucGFyYW1ldGVy
c1twaV0ubmFtZSkrMTsKKworCQkJLyogVVJMRGVjb2RlIHBhcmFtZXRlciB2YWx1ZSAqLworCQkJ
aWYgKHB2YWx1ZSkgeworCQkJCXVybGRlY29kZXN0cihwYiwgcHZhbHVlLCBzdHJsZW4ocHZhbHVl
KSk7CisJCQkJdWN0eC0+Yy5wYXJhbWV0ZXJzW3BpXS52YWx1ZSA9IHBiOworCQkJCXBiICs9IHN0
cmxlbih1Y3R4LT5jLnBhcmFtZXRlcnNbcGldLnZhbHVlKSsxOworCQkJfQorCQkJZWxzZSB7CisJ
CQkJdWN0eC0+Yy5wYXJhbWV0ZXJzW3BpXS52YWx1ZSA9IE5VTEw7CisJCQl9CisKKwkJCS8qIE5l
eHQgJyYnID8gKi8KKwkJCWlmICghbmEpCisJCQkJYnJlYWs7CisKKwkJCXBzID0gbmE7CisJCX0K
KworCQl1Y3R4LT5jLm51bV9wYXJhbWV0ZXJzID0gcGkrMTsKKwl9CisKKwlzID0gc3Ryc3RyKHVy
bHN0ciwgIi8iKTsKKwlpZiAocykgeworCQkvKiBVUkwgaGFzIGhvc3Rwb3J0ICovCisJCXNsZW4g
PSBzLXVybHN0cjsKKwkJdXJsZGVjb2Rlc3RyKHVjdHgtPmMuaG9zdHBvcnQuaG9zdG5hbWUsIHVy
bHN0ciwgc2xlbik7CisJCXVybHN0ciArPSBzbGVuICsgMTsKKworCQkvKgorCQkgKiBjaGVjayBm
b3IgYWRkcmVzc2VzIHdpdGhpbiAnWycgYW5kICddJywgbGlrZQorCQkgKiBJUHY2IGFkZHJlc3Nl
cworCQkgKi8KKwkJcyA9IHVjdHgtPmMuaG9zdHBvcnQuaG9zdG5hbWU7CisJCWlmIChzWzBdID09
ICdbJykKKwkJCXMgPSBzdHJzdHIocywgIl0iKTsKKworCQlpZiAocyA9PSBOVUxMKSB7CisJCQlE
KCh2b2lkKURCR19QVVRTKCJ1cmxfcGFyc2VyOiBVbm1hdGNoZWQgJ1snIGluIGhvc3RuYW1lXG4i
LCBzdGRlcnIpKTsKKwkJCXJldHVybiAtMTsKKwkJfQorCisJCXMgPSBzdHJzdHIocywgIjoiKTsK
KwkJaWYgKHMpIHsKKwkJCS8qIGZvdW5kIHBvcnQgbnVtYmVyICovCisJCQl1Y3R4LT5jLmhvc3Rw
b3J0LnBvcnQgPSBhdG9pKHMrMSk7CisJCQkqcyA9ICdcMCc7CisJCX0KKwl9CisJZWxzZSB7CisJ
CSh2b2lkKXN0cmNweSh1Y3R4LT5jLmhvc3Rwb3J0Lmhvc3RuYW1lLCB1cmxzdHIpOworCQl1Y3R4
LT5jLnBhdGggPSBOVUxMOworCQl1cmxzdHIgPSBOVUxMOworCX0KKworCUQoCisJCSh2b2lkKURC
R19QUklOVEYoc3Rkb3V0LAorCQkJImhvc3Rwb3J0PSclcycsIHBvcnQ9JWQsIHJlc3Q9JyVzJywg
bnVtX3BhcmFtZXRlcnM9JWRcbiIsCisJCQlEQkdOVUxMU1RSKHVjdHgtPmMuaG9zdHBvcnQuaG9z
dG5hbWUpLAorCQkJdWN0eC0+Yy5ob3N0cG9ydC5wb3J0LAorCQkJREJHTlVMTFNUUih1cmxzdHIp
LAorCQkJKGludCl1Y3R4LT5jLm51bV9wYXJhbWV0ZXJzKTsKKwkpOworCisKKwlEKAorCQlzc2l6
ZV90IGRwaTsKKwkJZm9yIChkcGkgPSAwIDsgZHBpIDwgdWN0eC0+Yy5udW1fcGFyYW1ldGVycyA7
IGRwaSsrKSB7CisJCQkodm9pZClEQkdfUFJJTlRGKHN0ZG91dCwKKwkJCQkicGFyYW1bJWRdOiBu
YW1lPSclcycvdmFsdWU9JyVzJ1xuIiwKKwkJCQkoaW50KWRwaSwKKwkJCQl1Y3R4LT5jLnBhcmFt
ZXRlcnNbZHBpXS5uYW1lLAorCQkJCURCR05VTExTVFIodWN0eC0+Yy5wYXJhbWV0ZXJzW2RwaV0u
dmFsdWUpKTsKKwkJfQorCSk7CisKKwlpZiAoIXVybHN0cikgeworCQlnb3RvIGRvbmU7CisJfQor
CisJdXJsZGVjb2Rlc3RyKHVjdHgtPmMucGF0aCwgdXJsc3RyLCBzdHJsZW4odXJsc3RyKSk7CisJ
RCgodm9pZClEQkdfUFJJTlRGKHN0ZG91dCwgInBhdGg9JyVzJ1xuIiwgdWN0eC0+Yy5wYXRoKSk7
CisKK2RvbmU6CisJcmV0dXJuIDA7Cit9CisKK3ZvaWQgdXJsX3BhcnNlcl9mcmVlX2NvbnRleHQo
dXJsX3BhcnNlcl9jb250ZXh0ICpjKQoreworCWZyZWUoYyk7Cit9CmRpZmYgLS1naXQgYS91dGls
cy9tb3VudC91cmxwYXJzZXIxLmggYi91dGlscy9tb3VudC91cmxwYXJzZXIxLmgKbmV3IGZpbGUg
bW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAuLjUxNWVlYTlkCi0tLSAvZGV2L251bGwKKysrIGIv
dXRpbHMvbW91bnQvdXJscGFyc2VyMS5oCkBAIC0wLDAgKzEsNjAgQEAKKy8qCisgKiBNSVQgTGlj
ZW5zZQorICoKKyAqIENvcHlyaWdodCAoYykgMjAyNCBSb2xhbmQgTWFpbnogPHJvbGFuZC5tYWlu
ekBucnVic2lnLm9yZz4KKyAqCisgKiBQZXJtaXNzaW9uIGlzIGhlcmVieSBncmFudGVkLCBmcmVl
IG9mIGNoYXJnZSwgdG8gYW55IHBlcnNvbiBvYnRhaW5pbmcgYSBjb3B5CisgKiBvZiB0aGlzIHNv
ZnR3YXJlIGFuZCBhc3NvY2lhdGVkIGRvY3VtZW50YXRpb24gZmlsZXMgKHRoZSAiU29mdHdhcmUi
KSwgdG8gZGVhbAorICogaW4gdGhlIFNvZnR3YXJlIHdpdGhvdXQgcmVzdHJpY3Rpb24sIGluY2x1
ZGluZyB3aXRob3V0IGxpbWl0YXRpb24gdGhlIHJpZ2h0cworICogdG8gdXNlLCBjb3B5LCBtb2Rp
ZnksIG1lcmdlLCBwdWJsaXNoLCBkaXN0cmlidXRlLCBzdWJsaWNlbnNlLCBhbmQvb3Igc2VsbAor
ICogY29waWVzIG9mIHRoZSBTb2Z0d2FyZSwgYW5kIHRvIHBlcm1pdCBwZXJzb25zIHRvIHdob20g
dGhlIFNvZnR3YXJlIGlzCisgKiBmdXJuaXNoZWQgdG8gZG8gc28sIHN1YmplY3QgdG8gdGhlIGZv
bGxvd2luZyBjb25kaXRpb25zOgorICoKKyAqIFRoZSBhYm92ZSBjb3B5cmlnaHQgbm90aWNlIGFu
ZCB0aGlzIHBlcm1pc3Npb24gbm90aWNlIHNoYWxsIGJlIGluY2x1ZGVkIGluIGFsbAorICogY29w
aWVzIG9yIHN1YnN0YW50aWFsIHBvcnRpb25zIG9mIHRoZSBTb2Z0d2FyZS4KKyAqCisgKiBUSEUg
U09GVFdBUkUgSVMgUFJPVklERUQgIkFTIElTIiwgV0lUSE9VVCBXQVJSQU5UWSBPRiBBTlkgS0lO
RCwgRVhQUkVTUyBPUgorICogSU1QTElFRCwgSU5DTFVESU5HIEJVVCBOT1QgTElNSVRFRCBUTyBU
SEUgV0FSUkFOVElFUyBPRiBNRVJDSEFOVEFCSUxJVFksCisgKiBGSVRORVNTIEZPUiBBIFBBUlRJ
Q1VMQVIgUFVSUE9TRSBBTkQgTk9OSU5GUklOR0VNRU5ULiBJTiBOTyBFVkVOVCBTSEFMTCBUSEUK
KyAqIEFVVEhPUlMgT1IgQ09QWVJJR0hUIEhPTERFUlMgQkUgTElBQkxFIEZPUiBBTlkgQ0xBSU0s
IERBTUFHRVMgT1IgT1RIRVIKKyAqIExJQUJJTElUWSwgV0hFVEhFUiBJTiBBTiBBQ1RJT04gT0Yg
Q09OVFJBQ1QsIFRPUlQgT1IgT1RIRVJXSVNFLCBBUklTSU5HIEZST00sCisgKiBPVVQgT0YgT1Ig
SU4gQ09OTkVDVElPTiBXSVRIIFRIRSBTT0ZUV0FSRSBPUiBUSEUgVVNFIE9SIE9USEVSIERFQUxJ
TkdTIElOIFRIRQorICogU09GVFdBUkUuCisgKi8KKworLyogdXJscGFyc2VyMS5oIC0gaGVhZGVy
IGZvciBzaW1wbGUgVVJMIHBhcnNlciAqLworCisjaWZuZGVmIF9fVVJMUEFSU0VSMV9IX18KKyNk
ZWZpbmUgX19VUkxQQVJTRVIxX0hfXyAxCisKKyNpbmNsdWRlIDxzdGRsaWIuaD4KKwordHlwZWRl
ZiBzdHJ1Y3QgX3VybF9wYXJzZXJfbmFtZV92YWx1ZSB7CisJY2hhciAqbmFtZTsKKwljaGFyICp2
YWx1ZTsKK30gdXJsX3BhcnNlcl9uYW1lX3ZhbHVlOworCit0eXBlZGVmIHN0cnVjdCBfdXJsX3Bh
cnNlcl9jb250ZXh0IHsKKwljaGFyICppbl91cmw7CisKKwljaGFyICpzY2hlbWU7CisJc3RydWN0
IHsKKwkJY2hhciAqdXNlcm5hbWU7CisJCWNoYXIgKnBhc3N3ZDsKKwl9IGxvZ2luOworCXN0cnVj
dCB7CisJCWNoYXIgKmhvc3RuYW1lOworCQlzaWduZWQgaW50IHBvcnQ7CisJfSBob3N0cG9ydDsK
KwljaGFyICpwYXRoOworCisJc3NpemVfdCBudW1fcGFyYW1ldGVyczsKKwl1cmxfcGFyc2VyX25h
bWVfdmFsdWUgKnBhcmFtZXRlcnM7Cit9IHVybF9wYXJzZXJfY29udGV4dDsKKworLyogUHJvdG90
eXBlcyAqLwordXJsX3BhcnNlcl9jb250ZXh0ICp1cmxfcGFyc2VyX2NyZWF0ZV9jb250ZXh0KGNv
bnN0IGNoYXIgKmluX3VybCwgdW5zaWduZWQgaW50IGZsYWdzKTsKK2ludCB1cmxfcGFyc2VyX3Bh
cnNlKHVybF9wYXJzZXJfY29udGV4dCAqdWN0eCk7Cit2b2lkIHVybF9wYXJzZXJfZnJlZV9jb250
ZXh0KHVybF9wYXJzZXJfY29udGV4dCAqYyk7CisKKyNlbmRpZiAvKiAhX19VUkxQQVJTRVIxX0hf
XyAqLwpkaWZmIC0tZ2l0IGEvdXRpbHMvbW91bnQvdXRpbHMuYyBiL3V0aWxzL21vdW50L3V0aWxz
LmMKaW5kZXggYjc1NjJhNDcuLjNkNTVlOTk3IDEwMDY0NAotLS0gYS91dGlscy9tb3VudC91dGls
cy5jCisrKyBiL3V0aWxzL21vdW50L3V0aWxzLmMKQEAgLTI4LDYgKzI4LDcgQEAKICNpbmNsdWRl
IDx1bmlzdGQuaD4KICNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KICNpbmNsdWRlIDxzeXMvc3RhdC5o
PgorI2luY2x1ZGUgPGljb252Lmg+CiAKICNpbmNsdWRlICJzb2NrYWRkci5oIgogI2luY2x1ZGUg
Im5mc19tb3VudC5oIgpAQCAtMTczLDMgKzE3NCwxNTcgQEAgaW50IG5mc191bW91bnQyMyhjb25z
dCBjaGFyICpkZXZuYW1lLCBjaGFyICpzdHJpbmcpCiAJZnJlZShkaXJuYW1lKTsKIAlyZXR1cm4g
cmVzdWx0OwogfQorCisvKiBDb252ZXJ0IFVURi04IHN0cmluZyB0byBtdWx0aWJ5dGUgc3RyaW5n
IGluIHRoZSBjdXJyZW50IGxvY2FsZSAqLworY2hhciAqdXRmOHN0cjJtYnN0cihjb25zdCBjaGFy
ICp1dGY4X3N0cikKK3sKKwlpY29udl90IGNkOworCisJY2QgPSBpY29udl9vcGVuKCIiLCAiVVRG
LTgiKTsKKwlpZiAoY2QgPT0gKGljb252X3QpLTEpIHsKKwkJcGVycm9yKCJ1dGY4c3RyMm1ic3Ry
OiBpY29udl9vcGVuIGZhaWxlZCIpOworCQlyZXR1cm4gTlVMTDsKKwl9CisKKwlzaXplX3QgaW5i
eXRlc2xlZnQgPSBzdHJsZW4odXRmOF9zdHIpOworCWNoYXIgKmluYnVmID0gKGNoYXIgKil1dGY4
X3N0cjsKKwlzaXplX3Qgb3V0Ynl0ZXNsZWZ0ID0gaW5ieXRlc2xlZnQqNCsxOworCWNoYXIgKm91
dGJ1ZiA9IG1hbGxvYyhvdXRieXRlc2xlZnQpOworCWNoYXIgKm91dGJ1Zl9vcmlnID0gb3V0YnVm
OworCisJaWYgKCFvdXRidWYpIHsKKwkJcGVycm9yKCJ1dGY4c3RyMm1ic3RyOiBvdXQgb2YgbWVt
b3J5Iik7CisJCSh2b2lkKWljb252X2Nsb3NlKGNkKTsKKwkJcmV0dXJuIE5VTEw7CisJfQorCisJ
aW50IHJldCA9IGljb252KGNkLCAmaW5idWYsICZpbmJ5dGVzbGVmdCwgJm91dGJ1ZiwgJm91dGJ5
dGVzbGVmdCk7CisJaWYgKHJldCA9PSAtMSkgeworCQlwZXJyb3IoInV0ZjhzdHIybWJzdHI6IGlj
b252KCkgZmFpbGVkIik7CisJCWZyZWUob3V0YnVmX29yaWcpOworCQkodm9pZClpY29udl9jbG9z
ZShjZCk7CisJCXJldHVybiBOVUxMOworCX0KKworCSpvdXRidWYgPSAnXDAnOworCisJKHZvaWQp
aWNvbnZfY2xvc2UoY2QpOworCXJldHVybiBvdXRidWZfb3JpZzsKK30KKworLyogZml4bWU6IFdl
IHNob3VsZCB1c2UgfGJvb2x8ISAqLworaW50IGlzX3NwZWNfbmZzX3VybChjb25zdCBjaGFyICpz
cGVjKQoreworCXJldHVybiAoIXN0cm5jbXAoc3BlYywgIm5mczovLyIsIDYpKTsKK30KKworaW50
IG1vdW50X3BhcnNlX25mc191cmwoY29uc3QgY2hhciAqc3BlYywgcGFyc2VkX25mc191cmwgKnBu
dSkKK3sKKwlpbnQgcmVzdWx0ID0gMTsKKwl1cmxfcGFyc2VyX2NvbnRleHQgKnVjdHggPSBOVUxM
OworCisJKHZvaWQpbWVtc2V0KHBudSwgMCwgc2l6ZW9mKHBhcnNlZF9uZnNfdXJsKSk7CisJcG51
LT5tb3VudF9wYXJhbXMucmVhZF9vbmx5ID0gVFJJU19CT09MX05PVF9TRVQ7CisKKwl1Y3R4ID0g
dXJsX3BhcnNlcl9jcmVhdGVfY29udGV4dChzcGVjLCAwKTsKKwlpZiAoIXVjdHgpIHsKKwkJbmZz
X2Vycm9yKF8oIiVzOiBvdXQgb2YgbWVtb3J5IiksCisJCQlwcm9nbmFtZSk7CisJCXJlc3VsdCA9
IDE7CisJCWdvdG8gZG9uZTsKKwl9CisKKwlpZiAodXJsX3BhcnNlcl9wYXJzZSh1Y3R4KSA8IDAp
IHsKKwkJbmZzX2Vycm9yKF8oIiVzOiBFcnJvciBwYXJzaW5nIG5mczovLy1VUkwuIiksCisJCQlw
cm9nbmFtZSk7CisJCXJlc3VsdCA9IDE7CisJCWdvdG8gZG9uZTsKKwl9CisJaWYgKHVjdHgtPmxv
Z2luLnVzZXJuYW1lIHx8IHVjdHgtPmxvZ2luLnBhc3N3ZCkgeworCQluZnNfZXJyb3IoXygiJXM6
IFVzZXJuYW1lL1Bhc3N3b3JkIGFyZSBub3QgZGVmaW5lZCBmb3IgbmZzOi8vLVVSTC4iKSwKKwkJ
CXByb2duYW1lKTsKKwkJcmVzdWx0ID0gMTsKKwkJZ290byBkb25lOworCX0KKwlpZiAoIXVjdHgt
PnBhdGgpIHsKKwkJbmZzX2Vycm9yKF8oIiVzOiBQYXRoIG1pc3NpbmcgaW4gbmZzOi8vLVVSTC4i
KSwKKwkJCXByb2duYW1lKTsKKwkJcmVzdWx0ID0gMTsKKwkJZ290byBkb25lOworCX0KKwlpZiAo
dWN0eC0+cGF0aFswXSAhPSAnLycpIHsKKwkJbmZzX2Vycm9yKF8oIiVzOiBSZWxhdGl2ZSBuZnM6
Ly8tVVJMcyBhcmUgbm90IHN1cHBvcnRlZC4iKSwKKwkJCXByb2duYW1lKTsKKwkJcmVzdWx0ID0g
MTsKKwkJZ290byBkb25lOworCX0KKworCWlmICh1Y3R4LT5udW1fcGFyYW1ldGVycyA+IDApIHsK
KwkJaW50IHBpOworCQljb25zdCBjaGFyICpwbmFtZTsKKwkJY29uc3QgY2hhciAqcHZhbHVlOwor
CisJCS8qCisJCSAqIFZhbHVlcyBhZGRlZCBoZXJlIGJhc2VkIG9uIFVSTCBwYXJhbWV0ZXJzCisJ
CSAqIHNob3VsZCBiZSBhZGRlZCB0aGUgZnJvbnQgb2YgdGhlIGxpc3Qgb2Ygb3B0aW9ucywKKwkJ
ICogc28gdXNlcnMgY2FuIG92ZXJyaWRlIHRoZSBuZnM6Ly8tVVJMIGdpdmVuIGRlZmF1bHQuCisJ
CSAqLworCQlmb3IgKHBpID0gMDsgcGkgPCB1Y3R4LT5udW1fcGFyYW1ldGVycyA7IHBpKyspIHsK
KwkJCXBuYW1lID0gdWN0eC0+cGFyYW1ldGVyc1twaV0ubmFtZTsKKwkJCXB2YWx1ZSA9IHVjdHgt
PnBhcmFtZXRlcnNbcGldLnZhbHVlOworCisJCQlpZiAoIXN0cmNtcChwbmFtZSwgInJ3IikpIHsK
KwkJCQlpZiAoKHB2YWx1ZSA9PSBOVUxMKSB8fCAoIXN0cmNtcChwdmFsdWUsICIxIikpKSB7CisJ
CQkJCXBudS0+bW91bnRfcGFyYW1zLnJlYWRfb25seSA9IFRSSVNfQk9PTF9GQUxTRTsKKwkJCQl9
CisJCQkJZWxzZSBpZiAoIXN0cmNtcChwdmFsdWUsICIwIikpIHsKKwkJCQkJcG51LT5tb3VudF9w
YXJhbXMucmVhZF9vbmx5ID0gVFJJU19CT09MX1RSVUU7CisJCQkJfQorCQkJCWVsc2UgeworCQkJ
CQluZnNfZXJyb3IoXygiJXM6IFVuc3VwcG9ydGVkIG5mczovLy1VUkwgIgorCQkJCQkJInBhcmFt
ZXRlciAnJXMnIHZhbHVlICclcycuIiksCisJCQkJCQlwcm9nbmFtZSwgcG5hbWUsIHB2YWx1ZSk7
CisJCQkJCXJlc3VsdCA9IDE7CisJCQkJCWdvdG8gZG9uZTsKKwkJCQl9CisJCQl9CisJCQllbHNl
IGlmICghc3RyY21wKHBuYW1lLCAicm8iKSkgeworCQkJCWlmICgocHZhbHVlID09IE5VTEwpIHx8
ICghc3RyY21wKHB2YWx1ZSwgIjEiKSkpIHsKKwkJCQkJcG51LT5tb3VudF9wYXJhbXMucmVhZF9v
bmx5ID0gVFJJU19CT09MX1RSVUU7CisJCQkJfQorCQkJCWVsc2UgaWYgKCFzdHJjbXAocHZhbHVl
LCAiMCIpKSB7CisJCQkJCXBudS0+bW91bnRfcGFyYW1zLnJlYWRfb25seSA9IFRSSVNfQk9PTF9G
QUxTRTsKKwkJCQl9CisJCQkJZWxzZSB7CisJCQkJCW5mc19lcnJvcihfKCIlczogVW5zdXBwb3J0
ZWQgbmZzOi8vLVVSTCAiCisJCQkJCQkicGFyYW1ldGVyICclcycgdmFsdWUgJyVzJy4iKSwKKwkJ
CQkJCXByb2duYW1lLCBwbmFtZSwgcHZhbHVlKTsKKwkJCQkJcmVzdWx0ID0gMTsKKwkJCQkJZ290
byBkb25lOworCQkJCX0KKwkJCX0KKwkJCWVsc2UgeworCQkJCW5mc19lcnJvcihfKCIlczogVW5z
dXBwb3J0ZWQgbmZzOi8vLVVSTCAiCisJCQkJCQkicGFyYW1ldGVyICclcycuIiksCisJCQkJCXBy
b2duYW1lLCBwbmFtZSk7CisJCQkJcmVzdWx0ID0gMTsKKwkJCQlnb3RvIGRvbmU7CisJCQl9CisJ
CX0KKwl9CisKKwlyZXN1bHQgPSAwOworZG9uZToKKwlpZiAocmVzdWx0ICE9IDApIHsKKwkJdXJs
X3BhcnNlcl9mcmVlX2NvbnRleHQodWN0eCk7CisJCXJldHVybiAwOworCX0KKworCXBudS0+dWN0
eCA9IHVjdHg7CisJcmV0dXJuIDE7Cit9CisKK3ZvaWQgbW91bnRfZnJlZV9wYXJzZV9uZnNfdXJs
KHBhcnNlZF9uZnNfdXJsICpwbnUpCit7CisJdXJsX3BhcnNlcl9mcmVlX2NvbnRleHQocG51LT51
Y3R4KTsKK30KZGlmZiAtLWdpdCBhL3V0aWxzL21vdW50L3V0aWxzLmggYi91dGlscy9tb3VudC91
dGlscy5oCmluZGV4IDIyNDkxOGFlLi40NjVjMGE1ZSAxMDA2NDQKLS0tIGEvdXRpbHMvbW91bnQv
dXRpbHMuaAorKysgYi91dGlscy9tb3VudC91dGlscy5oCkBAIC0yNCwxMyArMjQsMzYgQEAKICNk
ZWZpbmUgX05GU19VVElMU19NT1VOVF9VVElMU19ICiAKICNpbmNsdWRlICJwYXJzZV9vcHQuaCIK
KyNpbmNsdWRlICJ1cmxwYXJzZXIxLmgiCiAKKy8qIEJvb2xlYW4gd2l0aCB0aHJlZSBzdGF0ZXM6
IHsgbm90X3NldCwgZmFsc2UsIHRydWUgKi8KK3R5cGVkZWYgc2lnbmVkIGNoYXIgdHJpc3RhdGVf
Ym9vbDsKKyNkZWZpbmUgVFJJU19CT09MX05PVF9TRVQgKC0xKQorI2RlZmluZSBUUklTX0JPT0xf
VFJVRSAoMSkKKyNkZWZpbmUgVFJJU19CT09MX0ZBTFNFICgwKQorCisjZGVmaW5lIFRSSVNfQk9P
TF9HRVRfVkFMKHRzYiwgdHNiX2RlZmF1bHQpIFwKKwkoKCh0c2IpIT1UUklTX0JPT0xfTk9UX1NF
VCk/KHRzYik6KHRzYl9kZWZhdWx0KSkKKwordHlwZWRlZiBzdHJ1Y3QgX3BhcnNlZF9uZnNfdXJs
IHsKKwl1cmxfcGFyc2VyX2NvbnRleHQgKnVjdHg7CisJc3RydWN0IHsKKwkJdHJpc3RhdGVfYm9v
bCByZWFkX29ubHk7CisJfSBtb3VudF9wYXJhbXM7Cit9IHBhcnNlZF9uZnNfdXJsOworCisvKiBQ
cm90b3R5cGVzICovCiBpbnQgZGlzY292ZXJfbmZzX21vdW50X2RhdGFfdmVyc2lvbihpbnQgKnN0
cmluZ192ZXIpOwogdm9pZCBwcmludF9vbmUoY2hhciAqc3BlYywgY2hhciAqbm9kZSwgY2hhciAq
dHlwZSwgY2hhciAqb3B0cyk7CiB2b2lkIG1vdW50X3VzYWdlKHZvaWQpOwogdm9pZCB1bW91bnRf
dXNhZ2Uodm9pZCk7CiBpbnQgY2hrX21vdW50cG9pbnQoY29uc3QgY2hhciAqbW91bnRfcG9pbnQp
OworY2hhciAqdXRmOHN0cjJtYnN0cihjb25zdCBjaGFyICp1dGY4X3N0cik7CitpbnQgaXNfc3Bl
Y19uZnNfdXJsKGNvbnN0IGNoYXIgKnNwZWMpOwogCiBpbnQgbmZzX3Vtb3VudDIzKGNvbnN0IGNo
YXIgKmRldm5hbWUsIGNoYXIgKnN0cmluZyk7CiAKK2ludCBtb3VudF9wYXJzZV9uZnNfdXJsKGNv
bnN0IGNoYXIgKnNwZWMsIHBhcnNlZF9uZnNfdXJsICpwbnUpOwordm9pZCBtb3VudF9mcmVlX3Bh
cnNlX25mc191cmwocGFyc2VkX25mc191cmwgKnBudSk7CisKICNlbmRpZgkvKiAhX05GU19VVElM
U19NT1VOVF9VVElMU19IICovCi0tIAoyLjMwLjIKCg==
--000000000000ccb28f0628a0fd7d--

