Return-Path: <linux-nfs+bounces-8385-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A649E6CD1
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 12:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5712167261
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 11:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CF71DA0ED;
	Fri,  6 Dec 2024 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b="MvuJKm5O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from antelope.banana.relay.mailchannels.net (antelope.banana.relay.mailchannels.net [23.83.217.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC529155C94
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.217.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483423; cv=pass; b=t797P8djDrtnM+KKajsMs1mZro6j7VLjVn9d9rKolUNP8YCheoC5n1PZXl+biRpKzSIJWn0l5m2HFgKtx6daYY4GI5uYKKhs9A0g8gtf2K3ZxTEaDRHN0XQII8pEpv4VMg7xHU3EieXxS2N1WiSPExs0jhIPrjCaVhZNejpu/zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483423; c=relaxed/simple;
	bh=kY2gJvn2r86rEKQSJDtVweaXUxaF2PifEDDRGQl4xus=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ieI6+uw8M9OlcJDeWEjWHd0kXUeCH6MlJ5gbq9Nfe6rDZwefoY5rc8cc0tSWnTI8D5weO7hJgtfKxHyhaTF4cBOfwWUNayaCpy9oWJCreKTTZL//TkVUc3Jnsvv6lurjIImCFFTkh81FfvMCy5cELz0rJXySXzoD0PilnWGbrxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org; spf=pass smtp.mailfrom=nrubsig.org; dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b=MvuJKm5O; arc=pass smtp.client-ip=23.83.217.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 20FEF322BBF
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 10:54:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a212.dreamhost.com (trex-3.trex.outbound.svc.cluster.local [100.100.164.43])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C755C322D07
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 10:54:36 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1733482476; a=rsa-sha256;
	cv=none;
	b=nSMVaRzcjqo5aYm1ccY4DymbV3Pab4M7LYHuwq5H1fWKhtvmPfjAQkgFa/lxSc/KuJz08M
	JqgP3jxep31MIwL5DMA7XU8M651V6FTUWvNN2zHeYfcnTVlcm6irVzssLFrhl0MQCmZhwn
	1inkeT31I2T0MUGTrcnT0xcchUUWTBEr3NMiBiuNqUj8kvEIatkOPPttxvVLxyngg/DBWS
	5yvoDGs/l1MGrSWA8s+mB1aSlPVIjOQlLlw2T4O442+VLnxlWuL+eb0dclkZtf0YXE6u18
	zukeeCRoKCbXICtIJ0gF2VuzaTnYhXmHnlEuHh10c9SFPzaoMq6HlqDP7ylSdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1733482476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 dkim-signature; bh=Jk1mK/itU/RXAnNe2uWYrv98nqzQ6/erir4clX92NUU=;
	b=OgpjtW1b+iOonh3EjbV14ngqg1+fEx9s27y3CBZp/jYVhTXaxitIxYl7+KHsDqtc1wiJ0x
	vl4lDZz2mfg7N9f62tYyta0hu6X1Ug49gC+qoGy/dkafo+4MD0sHjfYmZrVuql+1ZI3qFe
	s2JdU5DEB0kfadwvhZfjwFDqLQWVPItfiAWP7YtAmBhlfzVdTmXv4vXCiJnR1LsxvDgaF/
	P/sBb7Z+pl8QPrQTOq907TFPwNmc/LL2X4OS9MHGvN0dN/Y1CozpLx9JtaOSjfE5O/LvX+
	YuV/kuDA2SLvd7jKxhnMPbyjJYIz7fWusAH81DzFWXwohVKiFqTGRjM3Su9JrA==
ARC-Authentication-Results: i=1;
	rspamd-fc7fd4597-n5wqx;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=roland.mainz@nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
X-MC-Relay: Bad
X-MailChannels-SenderId: dreamhost|x-authsender|gisburn@nrubsig.org
X-MailChannels-Auth-Id: dreamhost
X-Harbor-Well-Made: 4132a66b6d7b9f52_1733482477047_314972510
X-MC-Loop-Signature: 1733482477046:89437670
X-MC-Ingress-Time: 1733482477046
Received: from pdx1-sub0-mail-a212.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.100.164.43 (trex/7.0.2);
	Fri, 06 Dec 2024 10:54:37 +0000
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: gisburn@nrubsig.org)
	by pdx1-sub0-mail-a212.dreamhost.com (Postfix) with ESMTPSA id 4Y4SnS1bQzzFP
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 02:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nrubsig.org;
	s=dreamhost; t=1733482476;
	bh=Jk1mK/itU/RXAnNe2uWYrv98nqzQ6/erir4clX92NUU=;
	h=From:Date:Subject:To:Content-Type;
	b=MvuJKm5OSn8Xszp5IxgFEpm/SvOSum9ATyxhm2H1XrUE3EiN/pFayg1ovjrF4IDnG
	 IKiDTKMWpdrumPzZKclZaMx780toJ1hN4KdfIrSFk1PV/ZHtNOQ6LWlOFAwSwmHufB
	 iuQsTq2qJ2ALxt3wS2s0ZLmKAuw8E2xnoUV0JDeDKZ8G9Uwlbnyp+WAkcLpYRggTf+
	 oUfJbCpni0CuD/1w97vuHcHOwKuq5DGw/vi2AwIAFLK4cTf0aJuAbBDgh12WR5r3Tx
	 +Iw2G6lXpe1ihAgWIAQFK8JwSn7NxYvDu1Wp40btZl8tjAskC4BEFJ7DPshPPmSVRa
	 xrLv0lbjjGEzw==
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385ed7f6605so874492f8f.3
        for <linux-nfs@vger.kernel.org>; Fri, 06 Dec 2024 02:54:36 -0800 (PST)
X-Gm-Message-State: AOJu0Yy34vU6QTRfOWu9L6o3+DFOUmCb2XyZC9Io0V2dLrPcBNbh95B8
	MjfrQuWnpPBFyQJ5xheTI7RtCcaKG2fkjoA1JdWOv4SgsMV41C0bvs6Irw3TLA2xgs23MBafzAs
	Fi9P+sUnhazCX0HCLZr9x39q3H1k=
X-Google-Smtp-Source: AGHT+IG84cFvzkzfbki+DjYnNKSCIkO3+lyEvQ2d3SNl72DNzqQdLFnunUfQ3oel4cLym1KYZtt089Jhpg3mpD5FC2g=
X-Received: by 2002:a05:6000:2cb:b0:385:ee40:2d75 with SMTP id
 ffacd0b85a97d-3862b350c8cmr1720690f8f.20.1733482474065; Fri, 06 Dec 2024
 02:54:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Fri, 6 Dec 2024 11:54:07 +0100
X-Gmail-Original-Message-ID: <CAKAoaQmaf7d01vK4TfR+=8k4CVN-CX3ESPFh88EaxvcOAQDWtQ@mail.gmail.com>
Message-ID: <CAKAoaQmaf7d01vK4TfR+=8k4CVN-CX3ESPFh88EaxvcOAQDWtQ@mail.gmail.com>
Subject: [patch] mount.nfs: Add support for nfs://-URLs ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000178ad5062897d7aa"

--000000000000178ad5062897d7aa
Content-Type: text/plain; charset="UTF-8"

Hi!

----

Below (and also available at https://nrubsig.kpaste.net/b37) is a
patch which adds support for nfs://-URLs in mount.nfs4, as alternative
to the traditional hostname:/path+-o port=<tcp-port> notation.

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

---- snip ----
From e7b5a3ac981727e4585288bd66d1a9b2dea045dc Mon Sep 17 00:00:00 2001
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Fri, 6 Dec 2024 10:58:48 +0100
Subject: [PATCH] mount.nfs4: Add support for nfs://-URLs

Add support for RFC 2224-style nfs://-URLs as alternative to the
traditional hostname:/path+-o port=<tcp-port> notation,
providing standardised, extensible, single-string, crossplatform,
portable, Character-Encoding independent (e.g. mount point with
Japanese, Chinese, French etc. characters) and ASCII-compatible
descriptions of NFSv4 server resources (exports).

Reviewed-by: Martin Wege <martin.l.wege@gmail.com>
Signed-off-by: Cedric Blancher <cedric.blancher@gmail.com>
---
 utils/mount/Makefile.am  |   3 +-
 utils/mount/nfs4mount.c  |  69 +++++++-
 utils/mount/nfsmount.c   |  93 ++++++++--
 utils/mount/parse_dev.c  |  67 ++++++--
 utils/mount/stropts.c    |  96 ++++++++++-
 utils/mount/urlparser1.c | 358 +++++++++++++++++++++++++++++++++++++++
 utils/mount/urlparser1.h |  60 +++++++
 utils/mount/utils.c      | 155 +++++++++++++++++
 utils/mount/utils.h      |  23 +++
 9 files changed, 887 insertions(+), 37 deletions(-)
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
index b7562a47..2d4cfa5a 100644
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
+ cd = iconv_open("UTF-8", "");
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

--000000000000178ad5062897d7aa
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-mount.nfs4-Add-support-for-nfs-URLs.patch"
Content-Disposition: attachment; 
	filename="0001-mount.nfs4-Add-support-for-nfs-URLs.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m4cm5lf60>
X-Attachment-Id: f_m4cm5lf60

RnJvbSBlN2I1YTNhYzk4MTcyN2U0NTg1Mjg4YmQ2NmQxYTliMmRlYTA0NWRjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSb2xhbmQgTWFpbnogPHJvbGFuZC5tYWluekBucnVic2lnLm9y
Zz4KRGF0ZTogRnJpLCA2IERlYyAyMDI0IDEwOjU4OjQ4ICswMTAwClN1YmplY3Q6IFtQQVRDSF0g
bW91bnQubmZzNDogQWRkIHN1cHBvcnQgZm9yIG5mczovLy1VUkxzCgpBZGQgc3VwcG9ydCBmb3Ig
UkZDIDIyMjQtc3R5bGUgbmZzOi8vLVVSTHMgYXMgYWx0ZXJuYXRpdmUgdG8gdGhlCnRyYWRpdGlv
bmFsIGhvc3RuYW1lOi9wYXRoKy1vIHBvcnQ9PHRjcC1wb3J0PiBub3RhdGlvbiwKcHJvdmlkaW5n
IHN0YW5kYXJkaXNlZCwgZXh0ZW5zaWJsZSwgc2luZ2xlLXN0cmluZywgY3Jvc3NwbGF0Zm9ybSwK
cG9ydGFibGUsIENoYXJhY3Rlci1FbmNvZGluZyBpbmRlcGVuZGVudCAoZS5nLiBtb3VudCBwb2lu
dCB3aXRoCkphcGFuZXNlLCBDaGluZXNlLCBGcmVuY2ggZXRjLiBjaGFyYWN0ZXJzKSBhbmQgQVND
SUktY29tcGF0aWJsZQpkZXNjcmlwdGlvbnMgb2YgTkZTdjQgc2VydmVyIHJlc291cmNlcyAoZXhw
b3J0cykuCgpSZXZpZXdlZC1ieTogTWFydGluIFdlZ2UgPG1hcnRpbi5sLndlZ2VAZ21haWwuY29t
PgpTaWduZWQtb2ZmLWJ5OiBDZWRyaWMgQmxhbmNoZXIgPGNlZHJpYy5ibGFuY2hlckBnbWFpbC5j
b20+Ci0tLQogdXRpbHMvbW91bnQvTWFrZWZpbGUuYW0gIHwgICAzICstCiB1dGlscy9tb3VudC9u
ZnM0bW91bnQuYyAgfCAgNjkgKysrKysrKy0KIHV0aWxzL21vdW50L25mc21vdW50LmMgICB8ICA5
MyArKysrKysrKy0tCiB1dGlscy9tb3VudC9wYXJzZV9kZXYuYyAgfCAgNjcgKysrKysrLS0KIHV0
aWxzL21vdW50L3N0cm9wdHMuYyAgICB8ICA5NiArKysrKysrKysrLQogdXRpbHMvbW91bnQvdXJs
cGFyc2VyMS5jIHwgMzU4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwog
dXRpbHMvbW91bnQvdXJscGFyc2VyMS5oIHwgIDYwICsrKysrKysKIHV0aWxzL21vdW50L3V0aWxz
LmMgICAgICB8IDE1NSArKysrKysrKysrKysrKysrKwogdXRpbHMvbW91bnQvdXRpbHMuaCAgICAg
IHwgIDIzICsrKwogOSBmaWxlcyBjaGFuZ2VkLCA4ODcgaW5zZXJ0aW9ucygrKSwgMzcgZGVsZXRp
b25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgdXRpbHMvbW91bnQvdXJscGFyc2VyMS5jCiBjcmVh
dGUgbW9kZSAxMDA2NDQgdXRpbHMvbW91bnQvdXJscGFyc2VyMS5oCgpkaWZmIC0tZ2l0IGEvdXRp
bHMvbW91bnQvTWFrZWZpbGUuYW0gYi91dGlscy9tb3VudC9NYWtlZmlsZS5hbQppbmRleCA4M2E4
ZWUxYy4uMGU0Y2FiM2UgMTAwNjQ0Ci0tLSBhL3V0aWxzL21vdW50L01ha2VmaWxlLmFtCisrKyBi
L3V0aWxzL21vdW50L01ha2VmaWxlLmFtCkBAIC0xMyw3ICsxMyw4IEBAIHNiaW5fUFJPR1JBTVMJ
PSBtb3VudC5uZnMKIEVYVFJBX0RJU1QgPSBuZnNtb3VudC5jb25mICQobWFuOF9NQU5TKSAkKG1h
bjVfTUFOUykKIG1vdW50X2NvbW1vbiA9IGVycm9yLmMgbmV0d29yay5jIHRva2VuLmMgXAogCQkg
ICAgcGFyc2Vfb3B0LmMgcGFyc2VfZGV2LmMgXAotCQkgICAgbmZzbW91bnQuYyBuZnM0bW91bnQu
YyBzdHJvcHRzLmNcCisJCSAgICBuZnNtb3VudC5jIG5mczRtb3VudC5jIFwKKwkJICAgIHVybHBh
cnNlcjEuYyB1cmxwYXJzZXIxLmggc3Ryb3B0cy5jIFwKIAkJICAgIG1vdW50X2NvbnN0YW50cy5o
IGVycm9yLmggbmV0d29yay5oIHRva2VuLmggXAogCQkgICAgcGFyc2Vfb3B0LmggcGFyc2VfZGV2
LmggXAogCQkgICAgbmZzNF9tb3VudC5oIHN0cm9wdHMuaCB2ZXJzaW9uLmggXApkaWZmIC0tZ2l0
IGEvdXRpbHMvbW91bnQvbmZzNG1vdW50LmMgYi91dGlscy9tb3VudC9uZnM0bW91bnQuYwppbmRl
eCAwZmUxNDJhNy4uOGU0ZmJmMzAgMTAwNjQ0Ci0tLSBhL3V0aWxzL21vdW50L25mczRtb3VudC5j
CisrKyBiL3V0aWxzL21vdW50L25mczRtb3VudC5jCkBAIC01MCw4ICs1MCwxMCBAQAogI2luY2x1
ZGUgIm1vdW50X2NvbnN0YW50cy5oIgogI2luY2x1ZGUgIm5mczRfbW91bnQuaCIKICNpbmNsdWRl
ICJuZnNfbW91bnQuaCIKKyNpbmNsdWRlICJ1cmxwYXJzZXIxLmgiCiAjaW5jbHVkZSAiZXJyb3Iu
aCIKICNpbmNsdWRlICJuZXR3b3JrLmgiCisjaW5jbHVkZSAidXRpbHMuaCIKIAogI2lmIGRlZmlu
ZWQoVkFSX0xPQ0tfRElSKQogI2RlZmluZSBERUZBVUxUX0RJUiBWQVJfTE9DS19ESVIKQEAgLTE4
Miw3ICsxODQsNyBAQCBpbnQgbmZzNG1vdW50KGNvbnN0IGNoYXIgKnNwZWMsIGNvbnN0IGNoYXIg
Km5vZGUsIGludCBmbGFncywKIAlpbnQgbnVtX2ZsYXZvdXIgPSAwOwogCWludCBpcF9hZGRyX2lu
X29wdHMgPSAwOwogCi0JY2hhciAqaG9zdG5hbWUsICpkaXJuYW1lLCAqb2xkX29wdHM7CisJY2hh
ciAqaG9zdG5hbWUsICpkaXJuYW1lLCAqbWJfZGlybmFtZSA9IE5VTEwsICpvbGRfb3B0czsKIAlj
aGFyIG5ld19vcHRzWzEwMjRdOwogCWNoYXIgKm9wdCwgKm9wdGVxOwogCWNoYXIgKnM7CkBAIC0x
OTIsMTUgKzE5NCw2NiBAQCBpbnQgbmZzNG1vdW50KGNvbnN0IGNoYXIgKnNwZWMsIGNvbnN0IGNo
YXIgKm5vZGUsIGludCBmbGFncywKIAlpbnQgcmV0cnk7CiAJaW50IHJldHZhbCA9IEVYX0ZBSUw7
CiAJdGltZV90IHRpbWVvdXQsIHQ7CisJaW50IG5mc19wb3J0ID0gTkZTX1BPUlQ7CisJcGFyc2Vk
X25mc191cmwgcG51OworCisJKHZvaWQpbWVtc2V0KCZwbnUsIDAsIHNpemVvZihwYXJzZWRfbmZz
X3VybCkpOwogCiAJaWYgKHN0cmxlbihzcGVjKSA+PSBzaXplb2YoaG9zdGRpcikpIHsKIAkJbmZz
X2Vycm9yKF8oIiVzOiBleGNlc3NpdmVseSBsb25nIGhvc3Q6ZGlyIGFyZ3VtZW50XG4iKSwKIAkJ
CQlwcm9nbmFtZSk7CiAJCWdvdG8gZmFpbDsKIAl9Ci0Jc3RyY3B5KGhvc3RkaXIsIHNwZWMpOwot
CWlmIChwYXJzZV9kZXZuYW1lKGhvc3RkaXIsICZob3N0bmFtZSwgJmRpcm5hbWUpKQotCQlnb3Rv
IGZhaWw7CisKKwkvKgorCSAqIFN1cHBvcnQgbmZzOi8vLVVSTFMgcGVyIFJGQyAyMjI0ICgiTkZT
IFVSTAorCSAqIFNDSEVNRSIsIHNlZSBodHRwczovL3d3dy5yZmMtZWRpdG9yLm9yZy9yZmMvcmZj
MjIyNC5odG1sKSwKKwkgKiBpbmNsdWRpbmcgY3VzdG9tIHBvcnQgKG5mczovL2hvc3RuYW1lQHBv
cnQvcGF0aC8uLi4pCisJICogYW5kIFVSTCBwYXJhbWV0ZXIgKGUuZy4gbmZzOi8vLi4uLz9wYXJh
bTE9dmFsMSZwYXJhbTI9dmFsMgorCSAqIHN1cHBvcnQKKwkgKi8KKwlpZiAoaXNfc3BlY19uZnNf
dXJsKHNwZWMpKSB7CisJCWlmICghbW91bnRfcGFyc2VfbmZzX3VybChzcGVjLCAmcG51KSkgewor
CQkJZ290byBmYWlsOworCQl9CisKKwkJLyoKKwkJICogfHBudS51Y3R4LT5wYXRofCBpcyBpbiBV
VEYtOCwgYnV0IHdlIG5lZWQgdGhlIGRhdGEKKwkJICogaW4gdGhlIGN1cnJlbnQgbG9jYWwgbG9j
YWxlJ3MgZW5jb2RpbmcsIGFzIG1vdW50KDIpCisJCSAqIGRvZXMgbm90IGhhdmUgc29tZXRoaW5n
IGxpa2UgYSB8TVNfVVRGOF9TUEVDfCBmbGFnCisJCSAqIHRvIGluZGljYXRlIHRoYXQgdGhlIGlu
cHV0IHBhdGggaXMgaW4gVVRGLTgsCisJCSAqIGluZGVwZW5kZW50bHkgb2YgdGhlIGN1cnJlbnQg
bG9jYWxlCisJCSAqLworCQlob3N0bmFtZSA9IHBudS51Y3R4LT5ob3N0cG9ydC5ob3N0bmFtZTsK
KwkJZGlybmFtZSA9IG1iX2Rpcm5hbWUgPSB1dGY4c3RyMm1ic3RyKHBudS51Y3R4LT5wYXRoKTsK
KworCQkodm9pZClzbnByaW50Zihob3N0ZGlyLCBzaXplb2YoaG9zdGRpciksICIlczovJXMiLAor
CQkJaG9zdG5hbWUsIGRpcm5hbWUpOworCQlzcGVjID0gaG9zdGRpcjsKKworCQlpZiAocG51LnVj
dHgtPmhvc3Rwb3J0LnBvcnQgIT0gLTEpIHsKKwkJCW5mc19wb3J0ID0gcG51LnVjdHgtPmhvc3Rw
b3J0LnBvcnQ7CisJCX0KKworCQkvKgorCQkgKiBWYWx1ZXMgYWRkZWQgaGVyZSBiYXNlZCBvbiBV
UkwgcGFyYW1ldGVycworCQkgKiBzaG91bGQgYmUgYWRkZWQgdGhlIGZyb250IG9mIHRoZSBsaXN0
IG9mIG9wdGlvbnMsCisJCSAqIHNvIHVzZXJzIGNhbiBvdmVycmlkZSB0aGUgbmZzOi8vLVVSTCBn
aXZlbiBkZWZhdWx0LgorCQkgKgorCQkgKiBGSVhNRTogV2UgZG8gbm90IGRvIHRoYXQgaGVyZSBm
b3IgfE1TX1JET05MWXwhCisJCSAqLworCQlpZiAocG51Lm1vdW50X3BhcmFtcy5yZWFkX29ubHkg
IT0gVFJJU19CT09MX05PVF9TRVQpIHsKKwkJCWlmIChwbnUubW91bnRfcGFyYW1zLnJlYWRfb25s
eSkKKwkJCQlmbGFncyB8PSBNU19SRE9OTFk7CisJCQllbHNlCisJCQkJZmxhZ3MgJj0gfk1TX1JE
T05MWTsKKwkJfQorICAgICAgICB9IGVsc2UgeworCQkodm9pZClzdHJjcHkoaG9zdGRpciwgc3Bl
Yyk7CisKKwkJaWYgKHBhcnNlX2Rldm5hbWUoaG9zdGRpciwgJmhvc3RuYW1lLCAmZGlybmFtZSkp
CisJCQlnb3RvIGZhaWw7CisJfQogCiAJaWYgKGZpbGxfaXB2NF9zb2NrYWRkcihob3N0bmFtZSwg
JnNlcnZlcl9hZGRyKSkKIAkJZ290byBmYWlsOwpAQCAtMjQ3LDcgKzMwMCw3IEBAIGludCBuZnM0
bW91bnQoY29uc3QgY2hhciAqc3BlYywgY29uc3QgY2hhciAqbm9kZSwgaW50IGZsYWdzLAogCS8q
CiAJICogTkZTdjQgc3BlY2lmaWVzIHRoYXQgdGhlIGRlZmF1bHQgcG9ydCBzaG91bGQgYmUgMjA0
OQogCSAqLwotCXNlcnZlcl9hZGRyLnNpbl9wb3J0ID0gaHRvbnMoTkZTX1BPUlQpOworCXNlcnZl
cl9hZGRyLnNpbl9wb3J0ID0gaHRvbnMobmZzX3BvcnQpOwogCiAJLyogcGFyc2Ugb3B0aW9ucyAq
LwogCkBAIC00NzQsOCArNTI3LDE0IEBAIGludCBuZnM0bW91bnQoY29uc3QgY2hhciAqc3BlYywg
Y29uc3QgY2hhciAqbm9kZSwgaW50IGZsYWdzLAogCQl9CiAJfQogCisJbW91bnRfZnJlZV9wYXJz
ZV9uZnNfdXJsKCZwbnUpOworCWZyZWUobWJfZGlybmFtZSk7CisKIAlyZXR1cm4gRVhfU1VDQ0VT
UzsKIAogZmFpbDoKKwltb3VudF9mcmVlX3BhcnNlX25mc191cmwoJnBudSk7CisJZnJlZShtYl9k
aXJuYW1lKTsKKwogCXJldHVybiByZXR2YWw7CiB9CmRpZmYgLS1naXQgYS91dGlscy9tb3VudC9u
ZnNtb3VudC5jIGIvdXRpbHMvbW91bnQvbmZzbW91bnQuYwppbmRleCBhMWM5MmZlOC4uZTYxZDcx
OGEgMTAwNjQ0Ci0tLSBhL3V0aWxzL21vdW50L25mc21vdW50LmMKKysrIGIvdXRpbHMvbW91bnQv
bmZzbW91bnQuYwpAQCAtNjMsMTEgKzYzLDEzIEBACiAjaW5jbHVkZSAieGNvbW1vbi5oIgogI2lu
Y2x1ZGUgIm1vdW50LmgiCiAjaW5jbHVkZSAibmZzX21vdW50LmgiCisjaW5jbHVkZSAidXJscGFy
c2VyMS5oIgogI2luY2x1ZGUgIm1vdW50X2NvbnN0YW50cy5oIgogI2luY2x1ZGUgIm5scy5oIgog
I2luY2x1ZGUgImVycm9yLmgiCiAjaW5jbHVkZSAibmV0d29yay5oIgogI2luY2x1ZGUgInZlcnNp
b24uaCIKKyNpbmNsdWRlICJ1dGlscy5oIgogCiAjaWZkZWYgSEFWRV9SUENTVkNfTkZTX1BST1Rf
SAogI2luY2x1ZGUgPHJwY3N2Yy9uZnNfcHJvdC5oPgpAQCAtNDkzLDcgKzQ5NSw3IEBAIG5mc21v
dW50KGNvbnN0IGNoYXIgKnNwZWMsIGNvbnN0IGNoYXIgKm5vZGUsIGludCBmbGFncywKIAkgY2hh
ciAqKmV4dHJhX29wdHMsIGludCBmYWtlLCBpbnQgcnVubmluZ19iZykKIHsKIAljaGFyIGhvc3Rk
aXJbMTAyNF07Ci0JY2hhciAqaG9zdG5hbWUsICpkaXJuYW1lLCAqb2xkX29wdHMsICptb3VudGhv
c3QgPSBOVUxMOworCWNoYXIgKmhvc3RuYW1lLCAqZGlybmFtZSwgKm1iX2Rpcm5hbWUgPSBOVUxM
LCAqb2xkX29wdHMsICptb3VudGhvc3QgPSBOVUxMOwogCWNoYXIgbmV3X29wdHNbMTAyNF0sIGNi
dWZbMTAyNF07CiAJc3RhdGljIHN0cnVjdCBuZnNfbW91bnRfZGF0YSBkYXRhOwogCWludCB2YWw7
CkBAIC01MjEsMjkgKzUyMyw3OSBAQCBuZnNtb3VudChjb25zdCBjaGFyICpzcGVjLCBjb25zdCBj
aGFyICpub2RlLCBpbnQgZmxhZ3MsCiAJdGltZV90IHQ7CiAJdGltZV90IHByZXZ0OwogCXRpbWVf
dCB0aW1lb3V0OworCWludCBuZnN1cmxfcG9ydCA9IC0xOworCXBhcnNlZF9uZnNfdXJsIHBudTsK
KworCSh2b2lkKW1lbXNldCgmcG51LCAwLCBzaXplb2YocGFyc2VkX25mc191cmwpKTsKIAogCWlm
IChzdHJsZW4oc3BlYykgPj0gc2l6ZW9mKGhvc3RkaXIpKSB7CiAJCW5mc19lcnJvcihfKCIlczog
ZXhjZXNzaXZlbHkgbG9uZyBob3N0OmRpciBhcmd1bWVudCIpLAogCQkJCXByb2duYW1lKTsKIAkJ
Z290byBmYWlsOwogCX0KLQlzdHJjcHkoaG9zdGRpciwgc3BlYyk7Ci0JaWYgKChzID0gc3RyY2hy
KGhvc3RkaXIsICc6JykpKSB7Ci0JCWhvc3RuYW1lID0gaG9zdGRpcjsKLQkJZGlybmFtZSA9IHMg
KyAxOwotCQkqcyA9ICdcMCc7Ci0JCS8qIElnbm9yZSBhbGwgYnV0IGZpcnN0IGhvc3RuYW1lIGlu
IHJlcGxpY2F0ZWQgbW91bnRzCi0JCSAgIHVudGlsIHRoZXkgY2FuIGJlIGZ1bGx5IHN1cHBvcnRl
ZC4gKG1hY2tAc2dpLmNvbSkgKi8KLQkJaWYgKChzID0gc3RyY2hyKGhvc3RkaXIsICcsJykpKSB7
CisKKwkvKgorCSAqIFN1cHBvcnQgbmZzOi8vLVVSTFMgcGVyIFJGQyAyMjI0ICgiTkZTIFVSTAor
CSAqIFNDSEVNRSIsIHNlZSBodHRwczovL3d3dy5yZmMtZWRpdG9yLm9yZy9yZmMvcmZjMjIyNC5o
dG1sKSwKKwkgKiBpbmNsdWRpbmcgY3VzdG9tIHBvcnQgKG5mczovL2hvc3RuYW1lQHBvcnQvcGF0
aC8uLi4pCisJICogYW5kIFVSTCBwYXJhbWV0ZXIgKGUuZy4gbmZzOi8vLi4uLz9wYXJhbTE9dmFs
MSZwYXJhbTI9dmFsMgorCSAqIHN1cHBvcnQKKwkgKi8KKwlpZiAoaXNfc3BlY19uZnNfdXJsKHNw
ZWMpKSB7CisJCWlmICghbW91bnRfcGFyc2VfbmZzX3VybChzcGVjLCAmcG51KSkgeworCQkJZ290
byBmYWlsOworCQl9CisKKwkJLyoKKwkJICogfHBudS51Y3R4LT5wYXRofCBpcyBpbiBVVEYtOCwg
YnV0IHdlIG5lZWQgdGhlIGRhdGEKKwkJICogaW4gdGhlIGN1cnJlbnQgbG9jYWwgbG9jYWxlJ3Mg
ZW5jb2RpbmcsIGFzIG1vdW50KDIpCisJCSAqIGRvZXMgbm90IGhhdmUgc29tZXRoaW5nIGxpa2Ug
YSB8TVNfVVRGOF9TUEVDfCBmbGFnCisJCSAqIHRvIGluZGljYXRlIHRoYXQgdGhlIGlucHV0IHBh
dGggaXMgaW4gVVRGLTgsCisJCSAqIGluZGVwZW5kZW50bHkgb2YgdGhlIGN1cnJlbnQgbG9jYWxl
CisJCSAqLworCQlob3N0bmFtZSA9IHBudS51Y3R4LT5ob3N0cG9ydC5ob3N0bmFtZTsKKwkJZGly
bmFtZSA9IG1iX2Rpcm5hbWUgPSB1dGY4c3RyMm1ic3RyKHBudS51Y3R4LT5wYXRoKTsKKworCQko
dm9pZClzbnByaW50Zihob3N0ZGlyLCBzaXplb2YoaG9zdGRpciksICIlczovJXMiLAorCQkJaG9z
dG5hbWUsIGRpcm5hbWUpOworCQlzcGVjID0gaG9zdGRpcjsKKworCQlpZiAocG51LnVjdHgtPmhv
c3Rwb3J0LnBvcnQgIT0gLTEpIHsKKwkJCW5mc3VybF9wb3J0ID0gcG51LnVjdHgtPmhvc3Rwb3J0
LnBvcnQ7CisJCX0KKworCQkvKgorCQkgKiBWYWx1ZXMgYWRkZWQgaGVyZSBiYXNlZCBvbiBVUkwg
cGFyYW1ldGVycworCQkgKiBzaG91bGQgYmUgYWRkZWQgdGhlIGZyb250IG9mIHRoZSBsaXN0IG9m
IG9wdGlvbnMsCisJCSAqIHNvIHVzZXJzIGNhbiBvdmVycmlkZSB0aGUgbmZzOi8vLVVSTCBnaXZl
biBkZWZhdWx0LgorCQkgKgorCQkgKiBGSVhNRTogV2UgZG8gbm90IGRvIHRoYXQgaGVyZSBmb3Ig
fE1TX1JET05MWXwhCisJCSAqLworCQlpZiAocG51Lm1vdW50X3BhcmFtcy5yZWFkX29ubHkgIT0g
VFJJU19CT09MX05PVF9TRVQpIHsKKwkJCWlmIChwbnUubW91bnRfcGFyYW1zLnJlYWRfb25seSkK
KwkJCQlmbGFncyB8PSBNU19SRE9OTFk7CisJCQllbHNlCisJCQkJZmxhZ3MgJj0gfk1TX1JET05M
WTsKKwkJfQorICAgICAgICB9IGVsc2UgeworCQkodm9pZClzdHJjcHkoaG9zdGRpciwgc3BlYyk7
CisJCWlmICgocyA9IHN0cmNocihob3N0ZGlyLCAnOicpKSkgeworCQkJaG9zdG5hbWUgPSBob3N0
ZGlyOworCQkJZGlybmFtZSA9IHMgKyAxOwogCQkJKnMgPSAnXDAnOwotCQkJbmZzX2Vycm9yKF8o
IiVzOiB3YXJuaW5nOiAiCi0JCQkJICAibXVsdGlwbGUgaG9zdG5hbWVzIG5vdCBzdXBwb3J0ZWQi
KSwKKwkJCS8qIElnbm9yZSBhbGwgYnV0IGZpcnN0IGhvc3RuYW1lIGluIHJlcGxpY2F0ZWQgbW91
bnRzCisJCQkgICB1bnRpbCB0aGV5IGNhbiBiZSBmdWxseSBzdXBwb3J0ZWQuIChtYWNrQHNnaS5j
b20pICovCisJCQlpZiAoKHMgPSBzdHJjaHIoaG9zdGRpciwgJywnKSkpIHsKKwkJCQkqcyA9ICdc
MCc7CisJCQkJbmZzX2Vycm9yKF8oIiVzOiB3YXJuaW5nOiAiCisJCQkJCSJtdWx0aXBsZSBob3N0
bmFtZXMgbm90IHN1cHBvcnRlZCIpLAogCQkJCQlwcm9nbmFtZSk7Ci0JCX0KLQl9IGVsc2Ugewot
CQluZnNfZXJyb3IoXygiJXM6IGRpcmVjdG9yeSB0byBtb3VudCBub3QgaW4gaG9zdDpkaXIgZm9y
bWF0IiksCisJCQl9CisJCX0gZWxzZSB7CisJCQluZnNfZXJyb3IoXygiJXM6IGRpcmVjdG9yeSB0
byBtb3VudCBub3QgaW4gaG9zdDpkaXIgZm9ybWF0IiksCiAJCQkJcHJvZ25hbWUpOwotCQlnb3Rv
IGZhaWw7CisJCQlnb3RvIGZhaWw7CisJCX0KIAl9CiAKIAlpZiAoIW5mc19nZXRob3N0YnluYW1l
KGhvc3RuYW1lLCBuZnNfc2FkZHIpKQpAQCAtNTc5LDYgKzYzMSwxNCBAQCBuZnNtb3VudChjb25z
dCBjaGFyICpzcGVjLCBjb25zdCBjaGFyICpub2RlLCBpbnQgZmxhZ3MsCiAJbWVtc2V0KG5mc19w
bWFwLCAwLCBzaXplb2YoKm5mc19wbWFwKSk7CiAJbmZzX3BtYXAtPnBtX3Byb2cgPSBORlNfUFJP
R1JBTTsKIAorCWlmIChuZnN1cmxfcG9ydCAhPSAtMSkgeworCQkvKgorCQkgKiBTZXQgY3VzdG9t
IFRDUCBwb3J0IGRlZmluZWQgYnkgYSBuZnM6Ly8tVVJMIGhlcmUsCisJCSAqIHNvICQgbW91bnQg
LW8gcG9ydCAuLi4gIyBjYW4gYmUgdXNlZCB0byBvdmVycmlkZQorCQkgKi8KKwkJbmZzX3BtYXAt
PnBtX3BvcnQgPSBuZnN1cmxfcG9ydDsKKwl9CisKIAkvKiBwYXJzZSBvcHRpb25zICovCiAJbmV3
X29wdHNbMF0gPSAwOwogCWlmICghcGFyc2Vfb3B0aW9ucyhvbGRfb3B0cywgJmRhdGEsICZiZywg
JnJldHJ5LCAmbW50X3NlcnZlciwgJm5mc19zZXJ2ZXIsCkBAIC04NjMsMTAgKzkyMywxMyBAQCBu
b2F1dGhfZmxhdm9yczoKIAkJfQogCX0KIAorCW1vdW50X2ZyZWVfcGFyc2VfbmZzX3VybCgmcG51
KTsKKwogCXJldHVybiBFWF9TVUNDRVNTOwogCiAJLyogYWJvcnQgKi8KICBmYWlsOgorCW1vdW50
X2ZyZWVfcGFyc2VfbmZzX3VybCgmcG51KTsKIAlpZiAoZnNvY2sgIT0gLTEpCiAJCWNsb3NlKGZz
b2NrKTsKIAlyZXR1cm4gcmV0dmFsOwpkaWZmIC0tZ2l0IGEvdXRpbHMvbW91bnQvcGFyc2VfZGV2
LmMgYi91dGlscy9tb3VudC9wYXJzZV9kZXYuYwppbmRleCAyYWRlNWQ1ZC4uZDlmOGNmNTkgMTAw
NjQ0Ci0tLSBhL3V0aWxzL21vdW50L3BhcnNlX2Rldi5jCisrKyBiL3V0aWxzL21vdW50L3BhcnNl
X2Rldi5jCkBAIC0yNyw2ICsyNyw4IEBACiAjaW5jbHVkZSAieGNvbW1vbi5oIgogI2luY2x1ZGUg
Im5scy5oIgogI2luY2x1ZGUgInBhcnNlX2Rldi5oIgorI2luY2x1ZGUgInVybHBhcnNlcjEuaCIK
KyNpbmNsdWRlICJ1dGlscy5oIgogCiAjaWZuZGVmIE5GU19NQVhIT1NUTkFNRQogI2RlZmluZSBO
RlNfTUFYSE9TVE5BTUUJCSgyNTUpCkBAIC0xNzksMTcgKzE4MSw2MiBAQCBzdGF0aWMgaW50IG5m
c19wYXJzZV9zcXVhcmVfYnJhY2tldChjb25zdCBjaGFyICpkZXYsCiB9CiAKIC8qCi0gKiBSRkMg
MjIyNCBzYXlzIGFuIE5GUyBjbGllbnQgbXVzdCBncm9rICJwdWJsaWMgZmlsZSBoYW5kbGVzIiB0
bwotICogc3VwcG9ydCBORlMgVVJMcy4gIExpbnV4IGRvZXNuJ3QgZG8gdGhhdCB5ZXQuICBQcmlu
dCBhIHNvbWV3aGF0Ci0gKiBoZWxwZnVsIGVycm9yIG1lc3NhZ2UgaW4gdGhpcyBjYXNlIGluc3Rl
YWQgb2YgcHJlc3NpbmcgZm9yd2FyZAotICogd2l0aCB0aGUgbW91bnQgcmVxdWVzdCBhbmQgZmFp
bGluZyB3aXRoIGEgY3J5cHRpYyBlcnJvciBtZXNzYWdlCi0gKiBsYXRlci4KKyAqIFN1cHBvcnQg
bmZzOi8vLVVSTFMgcGVyIFJGQyAyMjI0ICgiTkZTIFVSTAorICogU0NIRU1FIiwgc2VlIGh0dHBz
Oi8vd3d3LnJmYy1lZGl0b3Iub3JnL3JmYy9yZmMyMjI0Lmh0bWwpLAorICogaW5jbHVkaW5nIHBv
cnQgc3VwcG9ydCAobmZzOi8vaG9zdG5hbWVAcG9ydC9wYXRoLy4uLikKICAqLwotc3RhdGljIGlu
dCBuZnNfcGFyc2VfbmZzX3VybChfX2F0dHJpYnV0ZV9fKCh1bnVzZWQpKSBjb25zdCBjaGFyICpk
ZXYsCi0JCQkgICAgIF9fYXR0cmlidXRlX18oKHVudXNlZCkpIGNoYXIgKipob3N0bmFtZSwKLQkJ
CSAgICAgX19hdHRyaWJ1dGVfXygodW51c2VkKSkgY2hhciAqKnBhdGhuYW1lKQorc3RhdGljIGlu
dCBuZnNfcGFyc2VfbmZzX3VybChjb25zdCBjaGFyICpkZXYsCisJCQkgICAgIGNoYXIgKipvdXRf
aG9zdG5hbWUsCisJCQkgICAgIGNoYXIgKipvdXRfcGF0aG5hbWUpCiB7Ci0JbmZzX2Vycm9yKF8o
IiVzOiBORlMgVVJMcyBhcmUgbm90IHN1cHBvcnRlZCIpLCBwcm9nbmFtZSk7CisJcGFyc2VkX25m
c191cmwgcG51OworCisJaWYgKG91dF9ob3N0bmFtZSkKKwkJKm91dF9ob3N0bmFtZSA9IE5VTEw7
CisJaWYgKG91dF9wYXRobmFtZSkKKwkJKm91dF9wYXRobmFtZSA9IE5VTEw7CisKKwkvKgorCSAq
IFN1cHBvcnQgbmZzOi8vLVVSTFMgcGVyIFJGQyAyMjI0ICgiTkZTIFVSTAorCSAqIFNDSEVNRSIs
IHNlZSBodHRwczovL3d3dy5yZmMtZWRpdG9yLm9yZy9yZmMvcmZjMjIyNC5odG1sKSwKKwkgKiBp
bmNsdWRpbmcgY3VzdG9tIHBvcnQgKG5mczovL2hvc3RuYW1lQHBvcnQvcGF0aC8uLi4pCisJICog
YW5kIFVSTCBwYXJhbWV0ZXIgKGUuZy4gbmZzOi8vLi4uLz9wYXJhbTE9dmFsMSZwYXJhbTI9dmFs
MgorCSAqIHN1cHBvcnQKKwkgKi8KKwlpZiAoIW1vdW50X3BhcnNlX25mc191cmwoZGV2LCAmcG51
KSkgeworCQlnb3RvIGZhaWw7CisJfQorCisJaWYgKHBudS51Y3R4LT5ob3N0cG9ydC5wb3J0ICE9
IC0xKSB7CisJCS8qIE5PUCBoZXJlLCB1bmxlc3Mgd2Ugc3dpdGNoIGZyb20gaG9zdG5hbWUgdG8g
aG9zdHBvcnQgKi8KKwl9CisKKwlpZiAob3V0X2hvc3RuYW1lKQorCQkqb3V0X2hvc3RuYW1lID0g
c3RyZHVwKHBudS51Y3R4LT5ob3N0cG9ydC5ob3N0bmFtZSk7CisJaWYgKG91dF9wYXRobmFtZSkK
KwkJKm91dF9wYXRobmFtZSA9IHV0ZjhzdHIybWJzdHIocG51LnVjdHgtPnBhdGgpOworCisJaWYg
KCgob3V0X2hvc3RuYW1lKT8oKm91dF9ob3N0bmFtZSA9PSBOVUxMKTowKSB8fAorCQkoKG91dF9w
YXRobmFtZSk/KCpvdXRfcGF0aG5hbWUgPT0gTlVMTCk6MCkpIHsKKwkJbmZzX2Vycm9yKF8oIiVz
OiBvdXQgb2YgbWVtb3J5IiksCisJCQlwcm9nbmFtZSk7CisJCWdvdG8gZmFpbDsKKwl9CisKKwlt
b3VudF9mcmVlX3BhcnNlX25mc191cmwoJnBudSk7CisKKwlyZXR1cm4gMTsKKworZmFpbDoKKwlt
b3VudF9mcmVlX3BhcnNlX25mc191cmwoJnBudSk7CisJaWYgKG91dF9ob3N0bmFtZSkgeworCQlm
cmVlKCpvdXRfaG9zdG5hbWUpOworCQkqb3V0X2hvc3RuYW1lID0gTlVMTDsKKwl9CisJaWYgKG91
dF9wYXRobmFtZSkgeworCQlmcmVlKCpvdXRfcGF0aG5hbWUpOworCQkqb3V0X3BhdGhuYW1lID0g
TlVMTDsKKwl9CiAJcmV0dXJuIDA7CiB9CiAKQEAgLTIyMyw3ICsyNzAsNyBAQCBpbnQgbmZzX3Bh
cnNlX2Rldm5hbWUoY29uc3QgY2hhciAqZGV2bmFtZSwKIAkJcmV0dXJuIG5mc19wZG5fbm9tZW1f
ZXJyKCk7CiAJaWYgKCpkZXYgPT0gJ1snKQogCQlyZXN1bHQgPSBuZnNfcGFyc2Vfc3F1YXJlX2Jy
YWNrZXQoZGV2LCBob3N0bmFtZSwgcGF0aG5hbWUpOwotCWVsc2UgaWYgKHN0cm5jbXAoZGV2LCAi
bmZzOi8vIiwgNikgPT0gMCkKKwllbHNlIGlmIChpc19zcGVjX25mc191cmwoZGV2KSkKIAkJcmVz
dWx0ID0gbmZzX3BhcnNlX25mc191cmwoZGV2LCBob3N0bmFtZSwgcGF0aG5hbWUpOwogCWVsc2UK
IAkJcmVzdWx0ID0gbmZzX3BhcnNlX3NpbXBsZV9ob3N0bmFtZShkZXYsIGhvc3RuYW1lLCBwYXRo
bmFtZSk7CmRpZmYgLS1naXQgYS91dGlscy9tb3VudC9zdHJvcHRzLmMgYi91dGlscy9tb3VudC9z
dHJvcHRzLmMKaW5kZXggMjNmMGE4YzAuLmFkOTJhYjc4IDEwMDY0NAotLS0gYS91dGlscy9tb3Vu
dC9zdHJvcHRzLmMKKysrIGIvdXRpbHMvbW91bnQvc3Ryb3B0cy5jCkBAIC00Miw2ICs0Miw3IEBA
CiAjaW5jbHVkZSAibmxzLmgiCiAjaW5jbHVkZSAibmZzcnBjLmgiCiAjaW5jbHVkZSAibW91bnRf
Y29uc3RhbnRzLmgiCisjaW5jbHVkZSAidXJscGFyc2VyMS5oIgogI2luY2x1ZGUgInN0cm9wdHMu
aCIKICNpbmNsdWRlICJlcnJvci5oIgogI2luY2x1ZGUgIm5ldHdvcmsuaCIKQEAgLTUwLDYgKzUx
LDcgQEAKICNpbmNsdWRlICJwYXJzZV9kZXYuaCIKICNpbmNsdWRlICJjb25mZmlsZS5oIgogI2lu
Y2x1ZGUgIm1pc2MuaCIKKyNpbmNsdWRlICJ1dGlscy5oIgogCiAjaWZuZGVmIE5GU19QUk9HUkFN
CiAjZGVmaW5lIE5GU19QUk9HUkFNCSgxMDAwMDMpCkBAIC02NDMsMjQgKzY0NSwxMDYgQEAgc3Rh
dGljIGludCBuZnNfc3lzX21vdW50KHN0cnVjdCBuZnNtb3VudF9pbmZvICptaSwgc3RydWN0IG1v
dW50X29wdGlvbnMgKm9wdHMpCiB7CiAJY2hhciAqb3B0aW9ucyA9IE5VTEw7CiAJaW50IHJlc3Vs
dDsKKwlpbnQgbmZzX3BvcnQgPSAyMDQ5OwogCiAJaWYgKG1pLT5mYWtlKQogCQlyZXR1cm4gMTsK
IAotCWlmIChwb19qb2luKG9wdHMsICZvcHRpb25zKSA9PSBQT19GQUlMRUQpIHsKLQkJZXJybm8g
PSBFSU87Ci0JCXJldHVybiAwOwotCX0KKwkvKgorCSAqIFN1cHBvcnQgbmZzOi8vLVVSTFMgcGVy
IFJGQyAyMjI0ICgiTkZTIFVSTAorCSAqIFNDSEVNRSIsIHNlZSBodHRwczovL3d3dy5yZmMtZWRp
dG9yLm9yZy9yZmMvcmZjMjIyNC5odG1sKSwKKwkgKiBpbmNsdWRpbmcgY3VzdG9tIHBvcnQgKG5m
czovL2hvc3RuYW1lQHBvcnQvcGF0aC8uLi4pCisJICogYW5kIFVSTCBwYXJhbWV0ZXIgKGUuZy4g
bmZzOi8vLi4uLz9wYXJhbTE9dmFsMSZwYXJhbTI9dmFsMgorCSAqIHN1cHBvcnQKKwkgKi8KKwlp
ZiAoaXNfc3BlY19uZnNfdXJsKG1pLT5zcGVjKSkgeworCQlwYXJzZWRfbmZzX3VybCBwbnU7CisJ
CWNoYXIgKm1iX3BhdGg7CisJCWNoYXIgbW91bnRfc291cmNlWzEwMjRdOworCisJCWlmICghbW91
bnRfcGFyc2VfbmZzX3VybChtaS0+c3BlYywgJnBudSkpIHsKKwkJCXJlc3VsdCA9IDE7CisJCQll
cnJubyA9IEVJTlZBTDsKKwkJCWdvdG8gZG9uZTsKKwkJfQorCisJCS8qCisJCSAqIHxwbnUudWN0
eC0+cGF0aHwgaXMgaW4gVVRGLTgsIGJ1dCB3ZSBuZWVkIHRoZSBkYXRhCisJCSAqIGluIHRoZSBj
dXJyZW50IGxvY2FsIGxvY2FsZSdzIGVuY29kaW5nLCBhcyBtb3VudCgyKQorCQkgKiBkb2VzIG5v
dCBoYXZlIHNvbWV0aGluZyBsaWtlIGEgfE1TX1VURjhfU1BFQ3wgZmxhZworCQkgKiB0byBpbmRp
Y2F0ZSB0aGF0IHRoZSBpbnB1dCBwYXRoIGlzIGluIFVURi04LAorCQkgKiBpbmRlcGVuZGVudGx5
IG9mIHRoZSBjdXJyZW50IGxvY2FsZQorCQkgKi8KKwkJbWJfcGF0aCA9IHV0ZjhzdHIybWJzdHIo
cG51LnVjdHgtPnBhdGgpOworCQlpZiAoIW1iX3BhdGgpIHsKKwkJCW5mc19lcnJvcihfKCIlczog
Q291bGQgbm90IGNvbnZlcnQgcGF0aCB0byBsb2NhbCBlbmNvZGluZy4iKSwKKwkJCQlwcm9nbmFt
ZSk7CisJCQltb3VudF9mcmVlX3BhcnNlX25mc191cmwoJnBudSk7CisJCQlyZXN1bHQgPSAxOwor
CQkJZXJybm8gPSBFSU5WQUw7CisJCQlnb3RvIGRvbmU7CisJCX0KKworCQkodm9pZClzbnByaW50
Zihtb3VudF9zb3VyY2UsIHNpemVvZihtb3VudF9zb3VyY2UpLAorCQkJIiVzOi8lcyIsCisJCQlw
bnUudWN0eC0+aG9zdHBvcnQuaG9zdG5hbWUsCisJCQltYl9wYXRoKTsKKwkJZnJlZShtYl9wYXRo
KTsKKworCQlpZiAocG51LnVjdHgtPmhvc3Rwb3J0LnBvcnQgIT0gLTEpIHsKKwkJCW5mc19wb3J0
ID0gcG51LnVjdHgtPmhvc3Rwb3J0LnBvcnQ7CisJCX0KIAotCXJlc3VsdCA9IG1vdW50KG1pLT5z
cGVjLCBtaS0+bm9kZSwgbWktPnR5cGUsCisJCS8qCisJCSAqIEluc2VydCAicG9ydD0iIG9wdGlv
biB3aXRoIHRoZSB2YWx1ZSBmcm9tIHRoZSBuZnM6Ly8KKwkJICogVVJMIGF0IHRoZSBiZWdpbm5p
bmcgb2YgdGhlIGxpc3Qgb2Ygb3B0aW9ucywgc28KKwkJICogdXNlcnMgY2FuIG92ZXJyaWRlIGl0
IHdpdGggJCBtb3VudC5uZnM0IC1vIHBvcnQ9ICMsCisJCSAqIGUuZy4KKwkJICogJCBtb3VudC5u
ZnM0IC1vIHBvcnQ9MTIzNCBuZnM6Ly8xMC40OS4yMDIuMjMwOjQwMC8vYmlnZGlzayAvbW50NCAj
CisJCSAqIHNob3VsZCB1c2UgcG9ydCAxMjM0LCBhbmQgbm90IHBvcnQgNDAwIGFzIHNwZWNpZmll
ZAorCQkgKiBpbiB0aGUgVVJMLgorCQkgKi8KKwkJY2hhciBwb3J0b3B0YnVmWzUrMzIrMV07CisJ
CSh2b2lkKXNucHJpbnRmKHBvcnRvcHRidWYsIHNpemVvZihwb3J0b3B0YnVmKSwgInBvcnQ9JWQi
LCBuZnNfcG9ydCk7CisJCSh2b2lkKXBvX2luc2VydChvcHRzLCBwb3J0b3B0YnVmKTsKKworCQlp
ZiAocG51Lm1vdW50X3BhcmFtcy5yZWFkX29ubHkgIT0gVFJJU19CT09MX05PVF9TRVQpIHsKKwkJ
CWlmIChwbnUubW91bnRfcGFyYW1zLnJlYWRfb25seSkKKwkJCQltaS0+ZmxhZ3MgfD0gTVNfUkRP
TkxZOworCQkJZWxzZQorCQkJCW1pLT5mbGFncyAmPSB+TVNfUkRPTkxZOworCQl9CisKKwkJbW91
bnRfZnJlZV9wYXJzZV9uZnNfdXJsKCZwbnUpOworCisJCWlmIChwb19qb2luKG9wdHMsICZvcHRp
b25zKSA9PSBQT19GQUlMRUQpIHsKKwkJCWVycm5vID0gRUlPOworCQkJcmVzdWx0ID0gMTsKKwkJ
CWdvdG8gZG9uZTsKKwkJfQorCisJCXJlc3VsdCA9IG1vdW50KG1vdW50X3NvdXJjZSwgbWktPm5v
ZGUsIG1pLT50eXBlLAorCQkJbWktPmZsYWdzICYgfihNU19VU0VSfE1TX1VTRVJTKSwgb3B0aW9u
cyk7CisJCWZyZWUob3B0aW9ucyk7CisJfSBlbHNlIHsKKwkJaWYgKHBvX2pvaW4ob3B0cywgJm9w
dGlvbnMpID09IFBPX0ZBSUxFRCkgeworCQkJZXJybm8gPSBFSU87CisJCQlyZXN1bHQgPSAxOwor
CQkJZ290byBkb25lOworCQl9CisKKwkJcmVzdWx0ID0gbW91bnQobWktPnNwZWMsIG1pLT5ub2Rl
LCBtaS0+dHlwZSwKIAkJCW1pLT5mbGFncyAmIH4oTVNfVVNFUnxNU19VU0VSUyksIG9wdGlvbnMp
OwotCWZyZWUob3B0aW9ucyk7CisJCWZyZWUob3B0aW9ucyk7CisJfQogCiAJaWYgKHZlcmJvc2Ug
JiYgcmVzdWx0KSB7CiAJCWludCBzYXZlID0gZXJybm87CiAJCW5mc19lcnJvcihfKCIlczogbW91
bnQoMik6ICVzIiksIHByb2duYW1lLCBzdHJlcnJvcihzYXZlKSk7CiAJCWVycm5vID0gc2F2ZTsK
IAl9CisKK2RvbmU6CiAJcmV0dXJuICFyZXN1bHQ7CiB9CiAKZGlmZiAtLWdpdCBhL3V0aWxzL21v
dW50L3VybHBhcnNlcjEuYyBiL3V0aWxzL21vdW50L3VybHBhcnNlcjEuYwpuZXcgZmlsZSBtb2Rl
IDEwMDY0NAppbmRleCAwMDAwMDAwMC4uZDRjNmYzMzkKLS0tIC9kZXYvbnVsbAorKysgYi91dGls
cy9tb3VudC91cmxwYXJzZXIxLmMKQEAgLTAsMCArMSwzNTggQEAKKy8qCisgKiBNSVQgTGljZW5z
ZQorICoKKyAqIENvcHlyaWdodCAoYykgMjAyNCBSb2xhbmQgTWFpbnogPHJvbGFuZC5tYWluekBu
cnVic2lnLm9yZz4KKyAqCisgKiBQZXJtaXNzaW9uIGlzIGhlcmVieSBncmFudGVkLCBmcmVlIG9m
IGNoYXJnZSwgdG8gYW55IHBlcnNvbiBvYnRhaW5pbmcgYSBjb3B5CisgKiBvZiB0aGlzIHNvZnR3
YXJlIGFuZCBhc3NvY2lhdGVkIGRvY3VtZW50YXRpb24gZmlsZXMgKHRoZSAiU29mdHdhcmUiKSwg
dG8gZGVhbAorICogaW4gdGhlIFNvZnR3YXJlIHdpdGhvdXQgcmVzdHJpY3Rpb24sIGluY2x1ZGlu
ZyB3aXRob3V0IGxpbWl0YXRpb24gdGhlIHJpZ2h0cworICogdG8gdXNlLCBjb3B5LCBtb2RpZnks
IG1lcmdlLCBwdWJsaXNoLCBkaXN0cmlidXRlLCBzdWJsaWNlbnNlLCBhbmQvb3Igc2VsbAorICog
Y29waWVzIG9mIHRoZSBTb2Z0d2FyZSwgYW5kIHRvIHBlcm1pdCBwZXJzb25zIHRvIHdob20gdGhl
IFNvZnR3YXJlIGlzCisgKiBmdXJuaXNoZWQgdG8gZG8gc28sIHN1YmplY3QgdG8gdGhlIGZvbGxv
d2luZyBjb25kaXRpb25zOgorICoKKyAqIFRoZSBhYm92ZSBjb3B5cmlnaHQgbm90aWNlIGFuZCB0
aGlzIHBlcm1pc3Npb24gbm90aWNlIHNoYWxsIGJlIGluY2x1ZGVkIGluIGFsbAorICogY29waWVz
IG9yIHN1YnN0YW50aWFsIHBvcnRpb25zIG9mIHRoZSBTb2Z0d2FyZS4KKyAqCisgKiBUSEUgU09G
VFdBUkUgSVMgUFJPVklERUQgIkFTIElTIiwgV0lUSE9VVCBXQVJSQU5UWSBPRiBBTlkgS0lORCwg
RVhQUkVTUyBPUgorICogSU1QTElFRCwgSU5DTFVESU5HIEJVVCBOT1QgTElNSVRFRCBUTyBUSEUg
V0FSUkFOVElFUyBPRiBNRVJDSEFOVEFCSUxJVFksCisgKiBGSVRORVNTIEZPUiBBIFBBUlRJQ1VM
QVIgUFVSUE9TRSBBTkQgTk9OSU5GUklOR0VNRU5ULiBJTiBOTyBFVkVOVCBTSEFMTCBUSEUKKyAq
IEFVVEhPUlMgT1IgQ09QWVJJR0hUIEhPTERFUlMgQkUgTElBQkxFIEZPUiBBTlkgQ0xBSU0sIERB
TUFHRVMgT1IgT1RIRVIKKyAqIExJQUJJTElUWSwgV0hFVEhFUiBJTiBBTiBBQ1RJT04gT0YgQ09O
VFJBQ1QsIFRPUlQgT1IgT1RIRVJXSVNFLCBBUklTSU5HIEZST00sCisgKiBPVVQgT0YgT1IgSU4g
Q09OTkVDVElPTiBXSVRIIFRIRSBTT0ZUV0FSRSBPUiBUSEUgVVNFIE9SIE9USEVSIERFQUxJTkdT
IElOIFRIRQorICogU09GVFdBUkUuCisgKi8KKworLyogdXJscGFyc2VyMS5jIC0gc2ltcGxlIFVS
TCBwYXJzZXIgKi8KKworI2luY2x1ZGUgPHN0ZGxpYi5oPgorI2luY2x1ZGUgPHN0ZGJvb2wuaD4K
KyNpbmNsdWRlIDxzdHJpbmcuaD4KKyNpbmNsdWRlIDxjdHlwZS5oPgorI2luY2x1ZGUgPHN0ZGlv
Lmg+CisKKyNpZmRlZiBEQkdfVVNFX1dJREVDSEFSCisjaW5jbHVkZSA8d2NoYXIuaD4KKyNpbmNs
dWRlIDxsb2NhbGUuaD4KKyNpbmNsdWRlIDxpby5oPgorI2luY2x1ZGUgPGZjbnRsLmg+CisjZW5k
aWYgLyogREJHX1VTRV9XSURFQ0hBUiAqLworCisjaW5jbHVkZSAidXJscGFyc2VyMS5oIgorCit0
eXBlZGVmIHN0cnVjdCBfdXJsX3BhcnNlcl9jb250ZXh0X3ByaXZhdGUgeworCXVybF9wYXJzZXJf
Y29udGV4dCBjOworCisJLyogUHJpdmF0ZSBkYXRhICovCisJY2hhciAqcGFyYW1ldGVyX3N0cmlu
Z19idWZmOworfSB1cmxfcGFyc2VyX2NvbnRleHRfcHJpdmF0ZTsKKworI2RlZmluZSBNQVhfVVJM
X1BBUkFNRVRFUlMgMjU2CisKKy8qCisgKiBPcmlnaW5hbCBleHRlbmRlZCByZWd1bGFyIGV4cHJl
c3Npb246CisgKgorICogIl4iCisgKiAiKC4rPykiCQkJCS8vIHNjaGVtZQorICogIjovLyIJCQkJ
Ly8gJzovLycKKyAqICIoIgkJCQkJLy8gbG9naW4KKyAqCSIoPzoiCisgKgkiKC4rPykiCQkJCS8v
IHVzZXIgKG9wdGlvbmFsKQorICoJCSIoPzo6KC4rKSk/IgkJLy8gcGFzc3dvcmQgKG9wdGlvbmFs
KQorICoJCSJAIgorICoJIik/IgorICoJIigiCQkJCS8vIGhvc3Rwb3J0CisgKgkJIiguKz8pIgkJ
CS8vIGhvc3QKKyAqCQkiKD86OihbWzpkaWdpdDpdXSspKT8iCS8vIHBvcnQgKG9wdGlvbmFsKQor
ICoJIikiCisgKiAiKSIKKyAqICIoPzovKC4qPykpPyIJCQkvLyBwYXRoIChvcHRpb25hbCkKKyAq
ICIoPzpcPyguKj8pKT8iCQkJLy8gVVJMIHBhcmFtZXRlcnMgKG9wdGlvbmFsKQorICogIiQiCisg
Ki8KKworI2RlZmluZSBEQkdOVUxMU1RSKHMpICgoKHMpIT1OVUxMKT8ocyk6IjxOVUxMPiIpCisj
aWYgMCB8fCBkZWZpbmVkKFRFU1RfVVJMUEFSU0VSKQorI2RlZmluZSBEKHgpIHgKKyNlbHNlCisj
ZGVmaW5lIEQoeCkKKyNlbmRpZgorCisjaWZkZWYgREJHX1VTRV9XSURFQ0hBUgorLyoKKyAqIFVz
ZSB3aWRlLWNoYXIgQVBJcyBvbiBXSU4zMiwgb3RoZXJ3aXNlIHdlIGNhbm5vdCBvdXRwdXQKKyAq
IEphcGFuZXNlL0NoaW5lc2UvZXRjIGNvcnJlY3RseQorICovCisjZGVmaW5lIERCR19QVVRTKHN0
ciwgZnApCQlmcHV0d3MoTCIiIHN0ciwgKGZwKSkKKyNkZWZpbmUgREJHX1BVVEMoYywgZnApCQkJ
ZnB1dHdjKGJ0b3djKGMpLCAoZnApKQorI2RlZmluZSBEQkdfUFJJTlRGKGZwLCBmbXQsIC4uLikJ
ZndwcmludGYoKGZwKSwgTCIiIGZtdCwgX19WQV9BUkdTX18pCisjZWxzZQorI2RlZmluZSBEQkdf
UFVUUyhzdHIsIGZwKQkJZnB1dHMoKHN0ciksIChmcCkpCisjZGVmaW5lIERCR19QVVRDKGMsIGZw
KQkJCWZwdXRjKChjKSwgKGZwKSkKKyNkZWZpbmUgREJHX1BSSU5URihmcCwgZm10LCAuLi4pCWZw
cmludGYoKGZwKSwgZm10LCBfX1ZBX0FSR1NfXykKKyNlbmRpZiAvKiBEQkdfVVNFX1dJREVDSEFS
ICovCisKK3N0YXRpYwordm9pZCB1cmxkZWNvZGVzdHIoY2hhciAqb3V0YnVmZiwgY29uc3QgY2hh
ciAqYnVmZmVyLCBzaXplX3QgbGVuKQoreworCXNpemVfdCBpLCBqOworCisJZm9yIChpID0gaiA9
IDAgOyBpIDwgbGVuIDsgKSB7CisJCXN3aXRjaCAoYnVmZmVyW2ldKSB7CisJCQljYXNlICclJzoK
KwkJCQlpZiAoKGkgKyAyKSA8IGxlbikgeworCQkJCQlpZiAoaXN4ZGlnaXQoKGludClidWZmZXJb
aSsxXSkgJiYgaXN4ZGlnaXQoKGludClidWZmZXJbaSsyXSkpIHsKKwkJCQkJCWNvbnN0IGNoYXIg
aGV4c3RyWzNdID0geworCQkJCQkJCWJ1ZmZlcltpKzFdLAorCQkJCQkJCWJ1ZmZlcltpKzJdLAor
CQkJCQkJCSdcMCcKKwkJCQkJCX07CisJCQkJCQlvdXRidWZmW2orK10gPSAodW5zaWduZWQgY2hh
cilzdHJ0b2woaGV4c3RyLCBOVUxMLCAxNik7CisJCQkJCQlpICs9IDM7CisJCQkJCX0gZWxzZSB7
CisJCQkJCQkvKiBpbnZhbGlkIGhleCBkaWdpdCAqLworCQkJCQkJb3V0YnVmZltqKytdID0gYnVm
ZmVyW2ldOworCQkJCQkJaSsrOworCQkJCQl9CisJCQkJfSBlbHNlIHsKKwkJCQkJLyogaW5jb21w
bGV0ZSBoZXggZGlnaXQgKi8KKwkJCQkJb3V0YnVmZltqKytdID0gYnVmZmVyW2ldOworCQkJCQlp
Kys7CisJCQkJfQorCQkJCWJyZWFrOworCQkJY2FzZSAnKyc6CisJCQkJb3V0YnVmZltqKytdID0g
JyAnOworCQkJCWkrKzsKKwkJCQlicmVhazsKKwkJCWRlZmF1bHQ6CisJCQkJb3V0YnVmZltqKytd
ID0gYnVmZmVyW2krK107CisJCQkJYnJlYWs7CisJCX0KKwl9CisKKwlvdXRidWZmW2pdID0gJ1ww
JzsKK30KKwordXJsX3BhcnNlcl9jb250ZXh0ICp1cmxfcGFyc2VyX2NyZWF0ZV9jb250ZXh0KGNv
bnN0IGNoYXIgKmluX3VybCwgdW5zaWduZWQgaW50IGZsYWdzKQoreworCXVybF9wYXJzZXJfY29u
dGV4dF9wcml2YXRlICp1Y3R4OworCWNoYXIgKnM7CisJc2l6ZV90IGluX3VybF9sZW47CisJc2l6
ZV90IGNvbnRleHRfbGVuOworCisJLyogfGZsYWdzfCBpcyBmb3IgZnV0dXJlIGV4dGVuc2lvbnMg
Ki8KKwkodm9pZClmbGFnczsKKworCWlmICghaW5fdXJsKQorCQlyZXR1cm4gTlVMTDsKKworCWlu
X3VybF9sZW4gPSBzdHJsZW4oaW5fdXJsKTsKKworCWNvbnRleHRfbGVuID0gc2l6ZW9mKHVybF9w
YXJzZXJfY29udGV4dF9wcml2YXRlKSArCisJCSgoaW5fdXJsX2xlbisxKSo2KSArCisJCShzaXpl
b2YodXJsX3BhcnNlcl9uYW1lX3ZhbHVlKSpNQVhfVVJMX1BBUkFNRVRFUlMpK3NpemVvZih2b2lk
Kik7CisJdWN0eCA9IG1hbGxvYyhjb250ZXh0X2xlbik7CisJaWYgKCF1Y3R4KQorCQlyZXR1cm4g
TlVMTDsKKworCXMgPSAodm9pZCAqKSh1Y3R4KzEpOworCXVjdHgtPmMuaW5fdXJsID0gczsJCXMr
PSBpbl91cmxfbGVuKzE7CisJKHZvaWQpc3RyY3B5KHVjdHgtPmMuaW5fdXJsLCBpbl91cmwpOwor
CXVjdHgtPmMuc2NoZW1lID0gczsJCXMrPSBpbl91cmxfbGVuKzE7CisJdWN0eC0+Yy5sb2dpbi51
c2VybmFtZSA9IHM7CXMrPSBpbl91cmxfbGVuKzE7CisJdWN0eC0+Yy5ob3N0cG9ydC5ob3N0bmFt
ZSA9IHM7CXMrPSBpbl91cmxfbGVuKzE7CisJdWN0eC0+Yy5wYXRoID0gczsJCXMrPSBpbl91cmxf
bGVuKzE7CisJdWN0eC0+Yy5ob3N0cG9ydC5wb3J0ID0gLTE7CisJdWN0eC0+Yy5udW1fcGFyYW1l
dGVycyA9IC0xOworCXVjdHgtPmMucGFyYW1ldGVycyA9ICh2b2lkICopczsJCXMrPSAoc2l6ZW9m
KHVybF9wYXJzZXJfbmFtZV92YWx1ZSkqTUFYX1VSTF9QQVJBTUVURVJTKStzaXplb2Yodm9pZCop
OworCXVjdHgtPnBhcmFtZXRlcl9zdHJpbmdfYnVmZiA9IHM7CXMrPSBpbl91cmxfbGVuKzE7CisK
KwlyZXR1cm4gJnVjdHgtPmM7Cit9CisKK2ludCB1cmxfcGFyc2VyX3BhcnNlKHVybF9wYXJzZXJf
Y29udGV4dCAqY3R4KQoreworCXVybF9wYXJzZXJfY29udGV4dF9wcml2YXRlICp1Y3R4ID0gKHVy
bF9wYXJzZXJfY29udGV4dF9wcml2YXRlICopY3R4OworCisJRCgodm9pZClEQkdfUFJJTlRGKHN0
ZGVyciwgIiMjIHBhcnNlciBpbl91cmw9JyVzJ1xuIiwgdWN0eC0+Yy5pbl91cmwpKTsKKworCWNo
YXIgKnM7CisJY29uc3QgY2hhciAqdXJsc3RyID0gdWN0eC0+Yy5pbl91cmw7CisJc2l6ZV90IHNs
ZW47CisKKwlzID0gc3Ryc3RyKHVybHN0ciwgIjovLyIpOworCWlmICghcykgeworCQlEKCh2b2lk
KURCR19QVVRTKCJ1cmxfcGFyc2VyOiBOb3QgYW4gVVJMXG4iLCBzdGRlcnIpKTsKKwkJcmV0dXJu
IC0xOworCX0KKworCXNsZW4gPSBzLXVybHN0cjsKKwkodm9pZCltZW1jcHkodWN0eC0+Yy5zY2hl
bWUsIHVybHN0ciwgc2xlbik7CisJdWN0eC0+Yy5zY2hlbWVbc2xlbl0gPSAnXDAnOworCXVybHN0
ciArPSBzbGVuICsgMzsKKworCUQoKHZvaWQpREJHX1BSSU5URihzdGRvdXQsICJzY2hlbWU9JyVz
JywgcmVzdD0nJXMnXG4iLCB1Y3R4LT5jLnNjaGVtZSwgdXJsc3RyKSk7CisKKwlzID0gc3Ryc3Ry
KHVybHN0ciwgIkAiKTsKKwlpZiAocykgeworCQkvKiBVUkwgaGFzIHVzZXIvcGFzc3dvcmQgKi8K
KwkJc2xlbiA9IHMtdXJsc3RyOworCQl1cmxkZWNvZGVzdHIodWN0eC0+Yy5sb2dpbi51c2VybmFt
ZSwgdXJsc3RyLCBzbGVuKTsKKwkJdXJsc3RyICs9IHNsZW4gKyAxOworCisJCXMgPSBzdHJzdHIo
dWN0eC0+Yy5sb2dpbi51c2VybmFtZSwgIjoiKTsKKwkJaWYgKHMpIHsKKwkJCS8qIGZvdW5kIHBh
c3N3ZCAqLworCQkJdWN0eC0+Yy5sb2dpbi5wYXNzd2QgPSBzKzE7CisJCQkqcyA9ICdcMCc7CisJ
CX0KKwkJZWxzZSB7CisJCQl1Y3R4LT5jLmxvZ2luLnBhc3N3ZCA9IE5VTEw7CisJCX0KKworCQkv
KiBjYXRjaCBwYXNzd29yZC1vbmx5IFVSTHMgKi8KKwkJaWYgKHVjdHgtPmMubG9naW4udXNlcm5h
bWVbMF0gPT0gJ1wwJykKKwkJCXVjdHgtPmMubG9naW4udXNlcm5hbWUgPSBOVUxMOworCX0KKwll
bHNlIHsKKwkJdWN0eC0+Yy5sb2dpbi51c2VybmFtZSA9IE5VTEw7CisJCXVjdHgtPmMubG9naW4u
cGFzc3dkID0gTlVMTDsKKwl9CisKKwlEKCh2b2lkKURCR19QUklOVEYoc3Rkb3V0LCAibG9naW49
JyVzJywgcGFzc3dkPSclcycsIHJlc3Q9JyVzJ1xuIiwKKwkJREJHTlVMTFNUUih1Y3R4LT5jLmxv
Z2luLnVzZXJuYW1lKSwKKwkJREJHTlVMTFNUUih1Y3R4LT5jLmxvZ2luLnBhc3N3ZCksCisJCURC
R05VTExTVFIodXJsc3RyKSkpOworCisJY2hhciAqcmF3X3BhcmFtZXRlcnM7CisKKwl1Y3R4LT5j
Lm51bV9wYXJhbWV0ZXJzID0gMDsKKwlyYXdfcGFyYW1ldGVycyA9IHN0cnN0cih1cmxzdHIsICI/
Iik7CisJLyogRG8gd2UgaGF2ZSBhIG5vbi1lbXB0eSBwYXJhbWV0ZXIgc3RyaW5nID8gKi8KKwlp
ZiAocmF3X3BhcmFtZXRlcnMgJiYgKHJhd19wYXJhbWV0ZXJzWzFdICE9ICdcMCcpKSB7CisJCSpy
YXdfcGFyYW1ldGVycysrID0gJ1wwJzsKKwkJRCgodm9pZClEQkdfUFJJTlRGKHN0ZG91dCwgInJh
dyBwYXJhbWV0ZXJzID0gJyVzJ1xuIiwgcmF3X3BhcmFtZXRlcnMpKTsKKworCQljaGFyICpwcyA9
IHJhd19wYXJhbWV0ZXJzOworCQljaGFyICpwdjsgLyogcGFyYW1ldGVyIHZhbHVlICovCisJCWNo
YXIgKm5hOyAvKiBuZXh0ICcmJyAqLworCQljaGFyICpwYiA9IHVjdHgtPnBhcmFtZXRlcl9zdHJp
bmdfYnVmZjsKKwkJY2hhciAqcG5hbWU7CisJCWNoYXIgKnB2YWx1ZTsKKwkJc3NpemVfdCBwaTsK
KworCQlmb3IgKHBpID0gMDsgcGkgPCBNQVhfVVJMX1BBUkFNRVRFUlMgOyBwaSsrKSB7CisJCQlw
bmFtZSA9IHBzOworCisJCQkvKgorCQkJICogSGFuZGxlIHBhcmFtZXRlcnMgd2l0aG91dCB2YWx1
ZSwKKwkJCSAqIGUuZy4gInBhdGg/bmFtZTEmbmFtZTI9dmFsdWUyIgorCQkJICovCisJCQluYSA9
IHN0cnN0cihwcywgIiYiKTsKKwkJCXB2ID0gc3Ryc3RyKHBzLCAiPSIpOworCQkJaWYgKHB2ICYm
IChuYT8obmEgPiBwdik6dHJ1ZSkpIHsKKwkJCQkqcHYrKyA9ICdcMCc7CisJCQkJcHZhbHVlID0g
cHY7CisJCQkJcHMgPSBwdjsKKwkJCX0KKwkJCWVsc2UgeworCQkJCXB2YWx1ZSA9IE5VTEw7CisJ
CQl9CisKKwkJCWlmIChuYSkgeworCQkJCSpuYSsrID0gJ1wwJzsKKwkJCX0KKworCQkJLyogVVJM
RGVjb2RlIHBhcmFtZXRlciBuYW1lICovCisJCQl1cmxkZWNvZGVzdHIocGIsIHBuYW1lLCBzdHJs
ZW4ocG5hbWUpKTsKKwkJCXVjdHgtPmMucGFyYW1ldGVyc1twaV0ubmFtZSA9IHBiOworCQkJcGIg
Kz0gc3RybGVuKHVjdHgtPmMucGFyYW1ldGVyc1twaV0ubmFtZSkrMTsKKworCQkJLyogVVJMRGVj
b2RlIHBhcmFtZXRlciB2YWx1ZSAqLworCQkJaWYgKHB2YWx1ZSkgeworCQkJCXVybGRlY29kZXN0
cihwYiwgcHZhbHVlLCBzdHJsZW4ocHZhbHVlKSk7CisJCQkJdWN0eC0+Yy5wYXJhbWV0ZXJzW3Bp
XS52YWx1ZSA9IHBiOworCQkJCXBiICs9IHN0cmxlbih1Y3R4LT5jLnBhcmFtZXRlcnNbcGldLnZh
bHVlKSsxOworCQkJfQorCQkJZWxzZSB7CisJCQkJdWN0eC0+Yy5wYXJhbWV0ZXJzW3BpXS52YWx1
ZSA9IE5VTEw7CisJCQl9CisKKwkJCS8qIE5leHQgJyYnID8gKi8KKwkJCWlmICghbmEpCisJCQkJ
YnJlYWs7CisKKwkJCXBzID0gbmE7CisJCX0KKworCQl1Y3R4LT5jLm51bV9wYXJhbWV0ZXJzID0g
cGkrMTsKKwl9CisKKwlzID0gc3Ryc3RyKHVybHN0ciwgIi8iKTsKKwlpZiAocykgeworCQkvKiBV
UkwgaGFzIGhvc3Rwb3J0ICovCisJCXNsZW4gPSBzLXVybHN0cjsKKwkJdXJsZGVjb2Rlc3RyKHVj
dHgtPmMuaG9zdHBvcnQuaG9zdG5hbWUsIHVybHN0ciwgc2xlbik7CisJCXVybHN0ciArPSBzbGVu
ICsgMTsKKworCQkvKgorCQkgKiBjaGVjayBmb3IgYWRkcmVzc2VzIHdpdGhpbiAnWycgYW5kICdd
JywgbGlrZQorCQkgKiBJUHY2IGFkZHJlc3NlcworCQkgKi8KKwkJcyA9IHVjdHgtPmMuaG9zdHBv
cnQuaG9zdG5hbWU7CisJCWlmIChzWzBdID09ICdbJykKKwkJCXMgPSBzdHJzdHIocywgIl0iKTsK
KworCQlpZiAocyA9PSBOVUxMKSB7CisJCQlEKCh2b2lkKURCR19QVVRTKCJ1cmxfcGFyc2VyOiBV
bm1hdGNoZWQgJ1snIGluIGhvc3RuYW1lXG4iLCBzdGRlcnIpKTsKKwkJCXJldHVybiAtMTsKKwkJ
fQorCisJCXMgPSBzdHJzdHIocywgIjoiKTsKKwkJaWYgKHMpIHsKKwkJCS8qIGZvdW5kIHBvcnQg
bnVtYmVyICovCisJCQl1Y3R4LT5jLmhvc3Rwb3J0LnBvcnQgPSBhdG9pKHMrMSk7CisJCQkqcyA9
ICdcMCc7CisJCX0KKwl9CisJZWxzZSB7CisJCSh2b2lkKXN0cmNweSh1Y3R4LT5jLmhvc3Rwb3J0
Lmhvc3RuYW1lLCB1cmxzdHIpOworCQl1Y3R4LT5jLnBhdGggPSBOVUxMOworCQl1cmxzdHIgPSBO
VUxMOworCX0KKworCUQoCisJCSh2b2lkKURCR19QUklOVEYoc3Rkb3V0LAorCQkJImhvc3Rwb3J0
PSclcycsIHBvcnQ9JWQsIHJlc3Q9JyVzJywgbnVtX3BhcmFtZXRlcnM9JWRcbiIsCisJCQlEQkdO
VUxMU1RSKHVjdHgtPmMuaG9zdHBvcnQuaG9zdG5hbWUpLAorCQkJdWN0eC0+Yy5ob3N0cG9ydC5w
b3J0LAorCQkJREJHTlVMTFNUUih1cmxzdHIpLAorCQkJKGludCl1Y3R4LT5jLm51bV9wYXJhbWV0
ZXJzKTsKKwkpOworCisKKwlEKAorCQlzc2l6ZV90IGRwaTsKKwkJZm9yIChkcGkgPSAwIDsgZHBp
IDwgdWN0eC0+Yy5udW1fcGFyYW1ldGVycyA7IGRwaSsrKSB7CisJCQkodm9pZClEQkdfUFJJTlRG
KHN0ZG91dCwKKwkJCQkicGFyYW1bJWRdOiBuYW1lPSclcycvdmFsdWU9JyVzJ1xuIiwKKwkJCQko
aW50KWRwaSwKKwkJCQl1Y3R4LT5jLnBhcmFtZXRlcnNbZHBpXS5uYW1lLAorCQkJCURCR05VTExT
VFIodWN0eC0+Yy5wYXJhbWV0ZXJzW2RwaV0udmFsdWUpKTsKKwkJfQorCSk7CisKKwlpZiAoIXVy
bHN0cikgeworCQlnb3RvIGRvbmU7CisJfQorCisJdXJsZGVjb2Rlc3RyKHVjdHgtPmMucGF0aCwg
dXJsc3RyLCBzdHJsZW4odXJsc3RyKSk7CisJRCgodm9pZClEQkdfUFJJTlRGKHN0ZG91dCwgInBh
dGg9JyVzJ1xuIiwgdWN0eC0+Yy5wYXRoKSk7CisKK2RvbmU6CisJcmV0dXJuIDA7Cit9CisKK3Zv
aWQgdXJsX3BhcnNlcl9mcmVlX2NvbnRleHQodXJsX3BhcnNlcl9jb250ZXh0ICpjKQoreworCWZy
ZWUoYyk7Cit9CmRpZmYgLS1naXQgYS91dGlscy9tb3VudC91cmxwYXJzZXIxLmggYi91dGlscy9t
b3VudC91cmxwYXJzZXIxLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAuLjUx
NWVlYTlkCi0tLSAvZGV2L251bGwKKysrIGIvdXRpbHMvbW91bnQvdXJscGFyc2VyMS5oCkBAIC0w
LDAgKzEsNjAgQEAKKy8qCisgKiBNSVQgTGljZW5zZQorICoKKyAqIENvcHlyaWdodCAoYykgMjAy
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
KworLyogdXJscGFyc2VyMS5oIC0gaGVhZGVyIGZvciBzaW1wbGUgVVJMIHBhcnNlciAqLworCisj
aWZuZGVmIF9fVVJMUEFSU0VSMV9IX18KKyNkZWZpbmUgX19VUkxQQVJTRVIxX0hfXyAxCisKKyNp
bmNsdWRlIDxzdGRsaWIuaD4KKwordHlwZWRlZiBzdHJ1Y3QgX3VybF9wYXJzZXJfbmFtZV92YWx1
ZSB7CisJY2hhciAqbmFtZTsKKwljaGFyICp2YWx1ZTsKK30gdXJsX3BhcnNlcl9uYW1lX3ZhbHVl
OworCit0eXBlZGVmIHN0cnVjdCBfdXJsX3BhcnNlcl9jb250ZXh0IHsKKwljaGFyICppbl91cmw7
CisKKwljaGFyICpzY2hlbWU7CisJc3RydWN0IHsKKwkJY2hhciAqdXNlcm5hbWU7CisJCWNoYXIg
KnBhc3N3ZDsKKwl9IGxvZ2luOworCXN0cnVjdCB7CisJCWNoYXIgKmhvc3RuYW1lOworCQlzaWdu
ZWQgaW50IHBvcnQ7CisJfSBob3N0cG9ydDsKKwljaGFyICpwYXRoOworCisJc3NpemVfdCBudW1f
cGFyYW1ldGVyczsKKwl1cmxfcGFyc2VyX25hbWVfdmFsdWUgKnBhcmFtZXRlcnM7Cit9IHVybF9w
YXJzZXJfY29udGV4dDsKKworLyogUHJvdG90eXBlcyAqLwordXJsX3BhcnNlcl9jb250ZXh0ICp1
cmxfcGFyc2VyX2NyZWF0ZV9jb250ZXh0KGNvbnN0IGNoYXIgKmluX3VybCwgdW5zaWduZWQgaW50
IGZsYWdzKTsKK2ludCB1cmxfcGFyc2VyX3BhcnNlKHVybF9wYXJzZXJfY29udGV4dCAqdWN0eCk7
Cit2b2lkIHVybF9wYXJzZXJfZnJlZV9jb250ZXh0KHVybF9wYXJzZXJfY29udGV4dCAqYyk7CisK
KyNlbmRpZiAvKiAhX19VUkxQQVJTRVIxX0hfXyAqLwpkaWZmIC0tZ2l0IGEvdXRpbHMvbW91bnQv
dXRpbHMuYyBiL3V0aWxzL21vdW50L3V0aWxzLmMKaW5kZXggYjc1NjJhNDcuLjJkNGNmYTVhIDEw
MDY0NAotLS0gYS91dGlscy9tb3VudC91dGlscy5jCisrKyBiL3V0aWxzL21vdW50L3V0aWxzLmMK
QEAgLTI4LDYgKzI4LDcgQEAKICNpbmNsdWRlIDx1bmlzdGQuaD4KICNpbmNsdWRlIDxzeXMvdHlw
ZXMuaD4KICNpbmNsdWRlIDxzeXMvc3RhdC5oPgorI2luY2x1ZGUgPGljb252Lmg+CiAKICNpbmNs
dWRlICJzb2NrYWRkci5oIgogI2luY2x1ZGUgIm5mc19tb3VudC5oIgpAQCAtMTczLDMgKzE3NCwx
NTcgQEAgaW50IG5mc191bW91bnQyMyhjb25zdCBjaGFyICpkZXZuYW1lLCBjaGFyICpzdHJpbmcp
CiAJZnJlZShkaXJuYW1lKTsKIAlyZXR1cm4gcmVzdWx0OwogfQorCisvKiBDb252ZXJ0IFVURi04
IHN0cmluZyB0byBtdWx0aWJ5dGUgc3RyaW5nIGluIHRoZSBjdXJyZW50IGxvY2FsZSAqLworY2hh
ciAqdXRmOHN0cjJtYnN0cihjb25zdCBjaGFyICp1dGY4X3N0cikKK3sKKwlpY29udl90IGNkOwor
CisJY2QgPSBpY29udl9vcGVuKCJVVEYtOCIsICIiKTsKKwlpZiAoY2QgPT0gKGljb252X3QpLTEp
IHsKKwkJcGVycm9yKCJ1dGY4c3RyMm1ic3RyOiBpY29udl9vcGVuIGZhaWxlZCIpOworCQlyZXR1
cm4gTlVMTDsKKwl9CisKKwlzaXplX3QgaW5ieXRlc2xlZnQgPSBzdHJsZW4odXRmOF9zdHIpOwor
CWNoYXIgKmluYnVmID0gKGNoYXIgKil1dGY4X3N0cjsKKwlzaXplX3Qgb3V0Ynl0ZXNsZWZ0ID0g
aW5ieXRlc2xlZnQqNCsxOworCWNoYXIgKm91dGJ1ZiA9IG1hbGxvYyhvdXRieXRlc2xlZnQpOwor
CWNoYXIgKm91dGJ1Zl9vcmlnID0gb3V0YnVmOworCisJaWYgKCFvdXRidWYpIHsKKwkJcGVycm9y
KCJ1dGY4c3RyMm1ic3RyOiBvdXQgb2YgbWVtb3J5Iik7CisJCSh2b2lkKWljb252X2Nsb3NlKGNk
KTsKKwkJcmV0dXJuIE5VTEw7CisJfQorCisJaW50IHJldCA9IGljb252KGNkLCAmaW5idWYsICZp
bmJ5dGVzbGVmdCwgJm91dGJ1ZiwgJm91dGJ5dGVzbGVmdCk7CisJaWYgKHJldCA9PSAtMSkgewor
CQlwZXJyb3IoInV0ZjhzdHIybWJzdHI6IGljb252KCkgZmFpbGVkIik7CisJCWZyZWUob3V0YnVm
X29yaWcpOworCQkodm9pZClpY29udl9jbG9zZShjZCk7CisJCXJldHVybiBOVUxMOworCX0KKwor
CSpvdXRidWYgPSAnXDAnOworCisJKHZvaWQpaWNvbnZfY2xvc2UoY2QpOworCXJldHVybiBvdXRi
dWZfb3JpZzsKK30KKworLyogZml4bWU6IFdlIHNob3VsZCB1c2UgfGJvb2x8ISAqLworaW50IGlz
X3NwZWNfbmZzX3VybChjb25zdCBjaGFyICpzcGVjKQoreworCXJldHVybiAoIXN0cm5jbXAoc3Bl
YywgIm5mczovLyIsIDYpKTsKK30KKworaW50IG1vdW50X3BhcnNlX25mc191cmwoY29uc3QgY2hh
ciAqc3BlYywgcGFyc2VkX25mc191cmwgKnBudSkKK3sKKwlpbnQgcmVzdWx0ID0gMTsKKwl1cmxf
cGFyc2VyX2NvbnRleHQgKnVjdHggPSBOVUxMOworCisJKHZvaWQpbWVtc2V0KHBudSwgMCwgc2l6
ZW9mKHBhcnNlZF9uZnNfdXJsKSk7CisJcG51LT5tb3VudF9wYXJhbXMucmVhZF9vbmx5ID0gVFJJ
U19CT09MX05PVF9TRVQ7CisKKwl1Y3R4ID0gdXJsX3BhcnNlcl9jcmVhdGVfY29udGV4dChzcGVj
LCAwKTsKKwlpZiAoIXVjdHgpIHsKKwkJbmZzX2Vycm9yKF8oIiVzOiBvdXQgb2YgbWVtb3J5Iiks
CisJCQlwcm9nbmFtZSk7CisJCXJlc3VsdCA9IDE7CisJCWdvdG8gZG9uZTsKKwl9CisKKwlpZiAo
dXJsX3BhcnNlcl9wYXJzZSh1Y3R4KSA8IDApIHsKKwkJbmZzX2Vycm9yKF8oIiVzOiBFcnJvciBw
YXJzaW5nIG5mczovLy1VUkwuIiksCisJCQlwcm9nbmFtZSk7CisJCXJlc3VsdCA9IDE7CisJCWdv
dG8gZG9uZTsKKwl9CisJaWYgKHVjdHgtPmxvZ2luLnVzZXJuYW1lIHx8IHVjdHgtPmxvZ2luLnBh
c3N3ZCkgeworCQluZnNfZXJyb3IoXygiJXM6IFVzZXJuYW1lL1Bhc3N3b3JkIGFyZSBub3QgZGVm
aW5lZCBmb3IgbmZzOi8vLVVSTC4iKSwKKwkJCXByb2duYW1lKTsKKwkJcmVzdWx0ID0gMTsKKwkJ
Z290byBkb25lOworCX0KKwlpZiAoIXVjdHgtPnBhdGgpIHsKKwkJbmZzX2Vycm9yKF8oIiVzOiBQ
YXRoIG1pc3NpbmcgaW4gbmZzOi8vLVVSTC4iKSwKKwkJCXByb2duYW1lKTsKKwkJcmVzdWx0ID0g
MTsKKwkJZ290byBkb25lOworCX0KKwlpZiAodWN0eC0+cGF0aFswXSAhPSAnLycpIHsKKwkJbmZz
X2Vycm9yKF8oIiVzOiBSZWxhdGl2ZSBuZnM6Ly8tVVJMcyBhcmUgbm90IHN1cHBvcnRlZC4iKSwK
KwkJCXByb2duYW1lKTsKKwkJcmVzdWx0ID0gMTsKKwkJZ290byBkb25lOworCX0KKworCWlmICh1
Y3R4LT5udW1fcGFyYW1ldGVycyA+IDApIHsKKwkJaW50IHBpOworCQljb25zdCBjaGFyICpwbmFt
ZTsKKwkJY29uc3QgY2hhciAqcHZhbHVlOworCisJCS8qCisJCSAqIFZhbHVlcyBhZGRlZCBoZXJl
IGJhc2VkIG9uIFVSTCBwYXJhbWV0ZXJzCisJCSAqIHNob3VsZCBiZSBhZGRlZCB0aGUgZnJvbnQg
b2YgdGhlIGxpc3Qgb2Ygb3B0aW9ucywKKwkJICogc28gdXNlcnMgY2FuIG92ZXJyaWRlIHRoZSBu
ZnM6Ly8tVVJMIGdpdmVuIGRlZmF1bHQuCisJCSAqLworCQlmb3IgKHBpID0gMDsgcGkgPCB1Y3R4
LT5udW1fcGFyYW1ldGVycyA7IHBpKyspIHsKKwkJCXBuYW1lID0gdWN0eC0+cGFyYW1ldGVyc1tw
aV0ubmFtZTsKKwkJCXB2YWx1ZSA9IHVjdHgtPnBhcmFtZXRlcnNbcGldLnZhbHVlOworCisJCQlp
ZiAoIXN0cmNtcChwbmFtZSwgInJ3IikpIHsKKwkJCQlpZiAoKHB2YWx1ZSA9PSBOVUxMKSB8fCAo
IXN0cmNtcChwdmFsdWUsICIxIikpKSB7CisJCQkJCXBudS0+bW91bnRfcGFyYW1zLnJlYWRfb25s
eSA9IFRSSVNfQk9PTF9GQUxTRTsKKwkJCQl9CisJCQkJZWxzZSBpZiAoIXN0cmNtcChwdmFsdWUs
ICIwIikpIHsKKwkJCQkJcG51LT5tb3VudF9wYXJhbXMucmVhZF9vbmx5ID0gVFJJU19CT09MX1RS
VUU7CisJCQkJfQorCQkJCWVsc2UgeworCQkJCQluZnNfZXJyb3IoXygiJXM6IFVuc3VwcG9ydGVk
IG5mczovLy1VUkwgIgorCQkJCQkJInBhcmFtZXRlciAnJXMnIHZhbHVlICclcycuIiksCisJCQkJ
CQlwcm9nbmFtZSwgcG5hbWUsIHB2YWx1ZSk7CisJCQkJCXJlc3VsdCA9IDE7CisJCQkJCWdvdG8g
ZG9uZTsKKwkJCQl9CisJCQl9CisJCQllbHNlIGlmICghc3RyY21wKHBuYW1lLCAicm8iKSkgewor
CQkJCWlmICgocHZhbHVlID09IE5VTEwpIHx8ICghc3RyY21wKHB2YWx1ZSwgIjEiKSkpIHsKKwkJ
CQkJcG51LT5tb3VudF9wYXJhbXMucmVhZF9vbmx5ID0gVFJJU19CT09MX1RSVUU7CisJCQkJfQor
CQkJCWVsc2UgaWYgKCFzdHJjbXAocHZhbHVlLCAiMCIpKSB7CisJCQkJCXBudS0+bW91bnRfcGFy
YW1zLnJlYWRfb25seSA9IFRSSVNfQk9PTF9GQUxTRTsKKwkJCQl9CisJCQkJZWxzZSB7CisJCQkJ
CW5mc19lcnJvcihfKCIlczogVW5zdXBwb3J0ZWQgbmZzOi8vLVVSTCAiCisJCQkJCQkicGFyYW1l
dGVyICclcycgdmFsdWUgJyVzJy4iKSwKKwkJCQkJCXByb2duYW1lLCBwbmFtZSwgcHZhbHVlKTsK
KwkJCQkJcmVzdWx0ID0gMTsKKwkJCQkJZ290byBkb25lOworCQkJCX0KKwkJCX0KKwkJCWVsc2Ug
eworCQkJCW5mc19lcnJvcihfKCIlczogVW5zdXBwb3J0ZWQgbmZzOi8vLVVSTCAiCisJCQkJCQki
cGFyYW1ldGVyICclcycuIiksCisJCQkJCXByb2duYW1lLCBwbmFtZSk7CisJCQkJcmVzdWx0ID0g
MTsKKwkJCQlnb3RvIGRvbmU7CisJCQl9CisJCX0KKwl9CisKKwlyZXN1bHQgPSAwOworZG9uZToK
KwlpZiAocmVzdWx0ICE9IDApIHsKKwkJdXJsX3BhcnNlcl9mcmVlX2NvbnRleHQodWN0eCk7CisJ
CXJldHVybiAwOworCX0KKworCXBudS0+dWN0eCA9IHVjdHg7CisJcmV0dXJuIDE7Cit9CisKK3Zv
aWQgbW91bnRfZnJlZV9wYXJzZV9uZnNfdXJsKHBhcnNlZF9uZnNfdXJsICpwbnUpCit7CisJdXJs
X3BhcnNlcl9mcmVlX2NvbnRleHQocG51LT51Y3R4KTsKK30KZGlmZiAtLWdpdCBhL3V0aWxzL21v
dW50L3V0aWxzLmggYi91dGlscy9tb3VudC91dGlscy5oCmluZGV4IDIyNDkxOGFlLi40NjVjMGE1
ZSAxMDA2NDQKLS0tIGEvdXRpbHMvbW91bnQvdXRpbHMuaAorKysgYi91dGlscy9tb3VudC91dGls
cy5oCkBAIC0yNCwxMyArMjQsMzYgQEAKICNkZWZpbmUgX05GU19VVElMU19NT1VOVF9VVElMU19I
CiAKICNpbmNsdWRlICJwYXJzZV9vcHQuaCIKKyNpbmNsdWRlICJ1cmxwYXJzZXIxLmgiCiAKKy8q
IEJvb2xlYW4gd2l0aCB0aHJlZSBzdGF0ZXM6IHsgbm90X3NldCwgZmFsc2UsIHRydWUgKi8KK3R5
cGVkZWYgc2lnbmVkIGNoYXIgdHJpc3RhdGVfYm9vbDsKKyNkZWZpbmUgVFJJU19CT09MX05PVF9T
RVQgKC0xKQorI2RlZmluZSBUUklTX0JPT0xfVFJVRSAoMSkKKyNkZWZpbmUgVFJJU19CT09MX0ZB
TFNFICgwKQorCisjZGVmaW5lIFRSSVNfQk9PTF9HRVRfVkFMKHRzYiwgdHNiX2RlZmF1bHQpIFwK
KwkoKCh0c2IpIT1UUklTX0JPT0xfTk9UX1NFVCk/KHRzYik6KHRzYl9kZWZhdWx0KSkKKwordHlw
ZWRlZiBzdHJ1Y3QgX3BhcnNlZF9uZnNfdXJsIHsKKwl1cmxfcGFyc2VyX2NvbnRleHQgKnVjdHg7
CisJc3RydWN0IHsKKwkJdHJpc3RhdGVfYm9vbCByZWFkX29ubHk7CisJfSBtb3VudF9wYXJhbXM7
Cit9IHBhcnNlZF9uZnNfdXJsOworCisvKiBQcm90b3R5cGVzICovCiBpbnQgZGlzY292ZXJfbmZz
X21vdW50X2RhdGFfdmVyc2lvbihpbnQgKnN0cmluZ192ZXIpOwogdm9pZCBwcmludF9vbmUoY2hh
ciAqc3BlYywgY2hhciAqbm9kZSwgY2hhciAqdHlwZSwgY2hhciAqb3B0cyk7CiB2b2lkIG1vdW50
X3VzYWdlKHZvaWQpOwogdm9pZCB1bW91bnRfdXNhZ2Uodm9pZCk7CiBpbnQgY2hrX21vdW50cG9p
bnQoY29uc3QgY2hhciAqbW91bnRfcG9pbnQpOworY2hhciAqdXRmOHN0cjJtYnN0cihjb25zdCBj
aGFyICp1dGY4X3N0cik7CitpbnQgaXNfc3BlY19uZnNfdXJsKGNvbnN0IGNoYXIgKnNwZWMpOwog
CiBpbnQgbmZzX3Vtb3VudDIzKGNvbnN0IGNoYXIgKmRldm5hbWUsIGNoYXIgKnN0cmluZyk7CiAK
K2ludCBtb3VudF9wYXJzZV9uZnNfdXJsKGNvbnN0IGNoYXIgKnNwZWMsIHBhcnNlZF9uZnNfdXJs
ICpwbnUpOwordm9pZCBtb3VudF9mcmVlX3BhcnNlX25mc191cmwocGFyc2VkX25mc191cmwgKnBu
dSk7CisKICNlbmRpZgkvKiAhX05GU19VVElMU19NT1VOVF9VVElMU19IICovCi0tIAoyLjMwLjIK
Cg==
--000000000000178ad5062897d7aa--

