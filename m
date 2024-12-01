Return-Path: <linux-nfs+bounces-8287-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D459DF64E
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Dec 2024 16:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1399162B14
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Dec 2024 15:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2655A1632FB;
	Sun,  1 Dec 2024 15:43:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1818B148FE8
	for <linux-nfs@vger.kernel.org>; Sun,  1 Dec 2024 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733067793; cv=none; b=LA9UYBTjuua4OeNsmBGvamUEDwcYz4bw/P7KJrcilHFgM7oOFPv4fNw7XKAwoKeVUxYr3izJTqD5H6/VjJAJ9Wq6lpG6oFd8cYaXQtdfXcnUp5EbTTiFMg9cDHawJmt58aip/eBnXVl46iCqcRS4OApgX5C+WikvNgbG7jjz/wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733067793; c=relaxed/simple;
	bh=KXzstK6GIQQ2i08Gv6vi/mq+88gHJD30ci2PyIf0//g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WeclEHN7UzaTNfmVdCZ/ZPAazUVaY13V1fL2AU/3gXqvEe29bwy8SmB3jqTZsGYOQXD02u/vEqVNrfFZDHKs6qdqJfdEi+fbiUZIEt9br0QmCfA3IScDMB3MHY6X9rwubgMcfXQszHkQwxlJITdfuymZheDlDupclqVfE4k5a5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-U8sSVDHTPLWU_Zdbi4o2HA-1; Sun,
 01 Dec 2024 10:36:39 -0500
X-MC-Unique: U8sSVDHTPLWU_Zdbi4o2HA-1
X-Mimecast-MFC-AGG-ID: U8sSVDHTPLWU_Zdbi4o2HA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2A2019560B7
	for <linux-nfs@vger.kernel.org>; Sun,  1 Dec 2024 15:36:38 +0000 (UTC)
Received: from bighat.boston.devel.redhat.com (unknown [10.22.64.9])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C95D1956089
	for <linux-nfs@vger.kernel.org>; Sun,  1 Dec 2024 15:36:38 +0000 (UTC)
From: Bogdan-Cristian Ttroiu <b.tataroiu@gmail.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH V2] Add guards around [nfsidmap] usages of [sysconf].
Date: Sun,  1 Dec 2024 10:36:37 -0500
Message-ID: <20241201153637.449538-1-b.tataroiu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lKUs7N59ZgfUEJCaCj4f96Kqm0W_VKonUGoOc2dct_U_1733067399
X-Mimecast-Originator: gmail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Bogdan-Cristian T=C4=83t=C4=83roiu <b.tataroiu@gmail.com>

sysconf(_SC_GETPW_R_SIZE_MAX) and sysconf(_SC_GETGR_R_SIZE_MAX)
return -1 on musl, which causes either segmentation faults or ENOMEM
errors.

Replace all usages of sysconf with dedicated methods that guard against
a result of -1.
---
 support/nfsidmap/gums.c             |  4 ++--
 support/nfsidmap/libnfsidmap.c      |  4 ++--
 support/nfsidmap/nfsidmap_common.c  | 16 ++++++++++++++++
 support/nfsidmap/nfsidmap_private.h |  2 ++
 support/nfsidmap/nss.c              |  8 ++++----
 support/nfsidmap/regex.c            |  9 +++++----
 support/nfsidmap/static.c           |  5 +++--
 7 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/support/nfsidmap/gums.c b/support/nfsidmap/gums.c
index 1d6eb318..e94a4c50 100644
--- a/support/nfsidmap/gums.c
+++ b/support/nfsidmap/gums.c
@@ -475,7 +475,7 @@ static int translate_to_uid(char *local_uid, uid_t *uid=
, uid_t *gid)
 =09int ret =3D -1;
 =09struct passwd *pw =3D NULL;
 =09struct pwbuf *buf =3D NULL;
-=09size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
+=09size_t buflen =3D get_pwnam_buflen();
=20
 =09buf =3D malloc(sizeof(*buf) + buflen);
 =09if (buf =3D=3D NULL)
@@ -501,7 +501,7 @@ static int translate_to_gid(char *local_gid, uid_t *gid=
)
 =09struct group *gr =3D NULL;
 =09struct group grbuf;
 =09char *buf =3D NULL;
-=09size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
+=09size_t buflen =3D get_grnam_buflen();
 =09int ret =3D -1;
=20
 =09do {
diff --git a/support/nfsidmap/libnfsidmap.c b/support/nfsidmap/libnfsidmap.=
c
index f8c36480..e1475879 100644
--- a/support/nfsidmap/libnfsidmap.c
+++ b/support/nfsidmap/libnfsidmap.c
@@ -457,7 +457,7 @@ int nfs4_init_name_mapping(char *conffile)
=20
 =09nobody_user =3D conf_get_str("Mapping", "Nobody-User");
 =09if (nobody_user) {
-=09=09size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
+=09=09size_t buflen =3D get_pwnam_buflen();
 =09=09struct passwd *buf;
 =09=09struct passwd *pw =3D NULL;
 =09=09int err;
@@ -478,7 +478,7 @@ int nfs4_init_name_mapping(char *conffile)
=20
 =09nobody_group =3D conf_get_str("Mapping", "Nobody-Group");
 =09if (nobody_group) {
-=09=09size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
+=09=09size_t buflen =3D get_grnam_buflen();
 =09=09struct group *buf;
 =09=09struct group *gr =3D NULL;
 =09=09int err;
diff --git a/support/nfsidmap/nfsidmap_common.c b/support/nfsidmap/nfsidmap=
_common.c
index 4d2cb14f..1d5b542b 100644
--- a/support/nfsidmap/nfsidmap_common.c
+++ b/support/nfsidmap/nfsidmap_common.c
@@ -116,3 +116,19 @@ int get_reformat_group(void)
=20
 =09return reformat_group;
 }
+
+size_t get_pwnam_buflen(void)
+{
+=09long buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
+=09if (buflen =3D=3D -1)
+=09=09buflen =3D 16384;
+=09return (size_t)buflen;
+}
+
+size_t get_grnam_buflen(void)
+{
+=09long buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
+=09if (buflen =3D=3D -1)
+=09=09buflen =3D 16384;
+=09return (size_t)buflen;
+}
diff --git a/support/nfsidmap/nfsidmap_private.h b/support/nfsidmap/nfsidma=
p_private.h
index a5cb6dda..234ca9d4 100644
--- a/support/nfsidmap/nfsidmap_private.h
+++ b/support/nfsidmap/nfsidmap_private.h
@@ -40,6 +40,8 @@ struct conf_list *get_local_realms(void);
 void free_local_realms(void);
 int get_nostrip(void);
 int get_reformat_group(void);
+size_t get_pwnam_buflen(void);
+size_t get_grnam_buflen(void);
=20
 typedef enum {
 =09IDTYPE_USER =3D 1,
diff --git a/support/nfsidmap/nss.c b/support/nfsidmap/nss.c
index 0f43076e..3fc045dc 100644
--- a/support/nfsidmap/nss.c
+++ b/support/nfsidmap/nss.c
@@ -91,7 +91,7 @@ static int nss_uid_to_name(uid_t uid, char *domain, char =
*name, size_t len)
 =09struct passwd *pw =3D NULL;
 =09struct passwd pwbuf;
 =09char *buf;
-=09size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
+=09size_t buflen =3D get_pwnam_buflen();
 =09int err =3D -ENOMEM;
=20
 =09buf =3D malloc(buflen);
@@ -119,7 +119,7 @@ static int nss_gid_to_name(gid_t gid, char *domain, cha=
r *name, size_t len)
 =09struct group *gr =3D NULL;
 =09struct group grbuf;
 =09char *buf;
-=09size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
+=09size_t buflen =3D get_grnam_buflen();
 =09int err;
=20
 =09if (domain =3D=3D NULL)
@@ -192,7 +192,7 @@ static struct passwd *nss_getpwnam(const char *name, co=
nst char *domain,
 {
 =09struct passwd *pw;
 =09struct pwbuf *buf;
-=09size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
+=09size_t buflen =3D get_pwnam_buflen();
 =09char *localname;
 =09int err =3D ENOMEM;
=20
@@ -301,7 +301,7 @@ static int _nss_name_to_gid(char *name, gid_t *gid, int=
 dostrip)
 =09struct group *gr =3D NULL;
 =09struct group grbuf;
 =09char *buf, *domain;
-=09size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
+=09size_t buflen =3D get_grnam_buflen();
 =09int err =3D -EINVAL;
 =09char *localname =3D NULL;
 =09char *ref_name =3D NULL;
diff --git a/support/nfsidmap/regex.c b/support/nfsidmap/regex.c
index 8424179f..ea094b95 100644
--- a/support/nfsidmap/regex.c
+++ b/support/nfsidmap/regex.c
@@ -46,6 +46,7 @@
=20
 #include "nfsidmap.h"
 #include "nfsidmap_plugin.h"
+#include "nfsidmap_private.h"
=20
 #define CONFIG_GET_STRING nfsidmap_config_get
 extern const char *nfsidmap_config_get(const char *, const char *);
@@ -95,7 +96,7 @@ static struct passwd *regex_getpwnam(const char *name, co=
nst char *UNUSED(domain
 {
 =09struct passwd *pw;
 =09struct pwbuf *buf;
-=09size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
+=09size_t buflen =3D get_pwnam_buflen();
 =09char *localname;
 =09size_t namelen;
 =09int err;
@@ -175,7 +176,7 @@ static struct group *regex_getgrnam(const char *name, c=
onst char *UNUSED(domain)
 {
 =09struct group *gr;
 =09struct grbuf *buf;
-=09size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
+=09size_t buflen =3D get_grnam_buflen();
 =09char *localgroup;
 =09char *groupname;
 =09size_t namelen;
@@ -366,7 +367,7 @@ static int regex_uid_to_name(uid_t uid, char *domain, c=
har *name, size_t len)
 =09struct passwd *pw =3D NULL;
 =09struct passwd pwbuf;
 =09char *buf;
-=09size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
+=09size_t buflen =3D get_pwnam_buflen();
 =09int err =3D -ENOMEM;
=20
 =09buf =3D malloc(buflen);
@@ -392,7 +393,7 @@ static int regex_gid_to_name(gid_t gid, char *UNUSED(do=
main), char *name, size_t
 =09struct group grbuf;
 =09char *buf;
     const char *name_prefix;
-=09size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
+=09size_t buflen =3D get_grnam_buflen();
 =09int err;
     char * groupname =3D NULL;
=20
diff --git a/support/nfsidmap/static.c b/support/nfsidmap/static.c
index 8ac4a398..395cac06 100644
--- a/support/nfsidmap/static.c
+++ b/support/nfsidmap/static.c
@@ -44,6 +44,7 @@
 #include "conffile.h"
 #include "nfsidmap.h"
 #include "nfsidmap_plugin.h"
+#include "nfsidmap_private.h"
=20
 /*
  * Static Translation Methods
@@ -98,7 +99,7 @@ static struct passwd *static_getpwnam(const char *name,
 {
 =09struct passwd *pw;
 =09struct pwbuf *buf;
-=09size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
+=09size_t buflen =3D get_pwnam_buflen();
 =09char *localname;
 =09int err;
=20
@@ -149,7 +150,7 @@ static struct group *static_getgrnam(const char *name,
 {
 =09struct group *gr;
 =09struct grbuf *buf;
-=09size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
+=09size_t buflen =3D get_grnam_buflen();
 =09char *localgroup;
 =09int err;
=20
--=20
2.45.2


