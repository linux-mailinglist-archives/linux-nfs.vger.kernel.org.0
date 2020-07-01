Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0332112B5
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2020 20:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732911AbgGAS2P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Jul 2020 14:28:15 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:55469 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732869AbgGAS2N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Jul 2020 14:28:13 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jqhSs-0007a1-CT
        for linux-nfs@vger.kernel.org; Wed, 01 Jul 2020 13:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=yol48g76G/CptNepW7rQ2BpzclExf+UoHkSCiXuYQnU=; b=eGQHYqiQkcnxqcIx7sZX8Pc8nr
        TlUc+MRipp1lmYHZKAWE0T3FBw+sWtMoH8Bvk672xMJ1VqqSnMpCMlDINACcpwcd1VToVB7Cpv2Yj
        ltASk5mV/e+Poe3kTz+0b0S2bbbWjwFOZA9Eg0EXFTtyy+SZGSs4vNmCJGWHGuziVP4x4uCMV3S7z
        VFQt621/7DjbxxB8FKBSQCNzE9G/V2JAwXWu4Ajn8MLSoZQHQAXECPKn1QAhDJ4N7PMYGvMCJ2vkN
        qrMSwjSBvTBqCzcUmnIl9RciLLLAe6uO4+AYVxwFVhMfQJZdAzEraxxHllhm4BDX2+oiYajIcq+N2
        r/SArHEA==;
Received: from [174.119.114.224] (port=43594 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jqhSs-0003Oc-4a
        for linux-nfs@vger.kernel.org; Wed, 01 Jul 2020 14:28:10 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 10/10] Fix various clang warnings.
Date:   Wed,  1 Jul 2020 14:28:03 -0400
Message-Id: <20200701182803.14947-13-nazard@nazar.ca>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701182803.14947-1-nazard@nazar.ca>
References: <20200701182803.14947-1-nazard@nazar.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Get-Message-Sender-Via: nyc006.hawkhost.com: authenticated_id: nazard@nazar.ca
X-Authenticated-Sender: nyc006.hawkhost.com: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: 172.96.186.142
Authentication-Results: arandomserver.com; auth=pass smtp.auth=172.96.186.142@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.000379806333186)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0f6LF1GdvkEexklpcFpSF5apSDasLI4SayDByyq9LIhVGAyMZJjDD8Pe
 pJV4POpEhUTNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dKkvKloQwzQ5fLtC3IogyqWsl7H6aAPMkVWPpyCe5BmaHXpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQwzEEJbreAQRsbSZZ9fXoUEifL76GD10kuo3nOZaoX+gsjENmEszkjZCjfYHwrdv
 NOzx52pqgFKULzmTh7lC+C1OB0fQQI8VICRbS6zGNgmk2+y1r/Jt2+QI0NYgZu+YDGDmnroh/8hH
 WR/Etfk4HCQTo4dLz8XEDoyijq2CEGKcGplHcpVCCoX989hgB8R+yHz6Wz8d/Pp/n7kUT3MNKWyV
 mI6ol8ojWV/XK6LQktrhstUndym6eyemMQhECmFJmn9nMre3YEbkuALmW8gN9RXH3DI0NOgo6/Ab
 vYB8YDlEEBksfbu9yLQMc7lcHkHFV/djzQ6YC7Heg3Xf7O1TOd4Lp6/mezP3/ta7RoBl7TSj8Cd1
 02D1/PxWBdanhqFXVNDQ7yU+027LpSM25Xk8gZN9F6hgfa49iyJ35rdphc3nZjEa/sNl+vcoDGoY
 k0DAXQsuA+ZOE6ZCLBhP3Kw7GhP6DxWSEoQUnaVSVuR240Ewmn4rjkt/ing/Kst6lT+FgU1vUJm2
 lwcjBA1nf30dydyo/g58MkufxisELuuE3bZK19QhM8um7L9VndMW7hyljAQWfxYdU0gXE07BZ9Ya
 Ke+gc5LamkkGaPkiMxmyjA0L/Ub/yrYgxwwQmd72Iri+RjEvuGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Doug Nazar <nazard@nazar.ca>
---
 configure.ac              | 6 +++---
 support/include/xcommon.h | 2 +-
 utils/mount/network.c     | 4 ++--
 utils/mount/stropts.c     | 2 --
 utils/mountd/cache.c      | 2 +-
 5 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/configure.ac b/configure.ac
index 942f3c05..dbb795f0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -638,13 +638,12 @@ my_am_cflags="\
  -Werror=parentheses \
  -Werror=aggregate-return \
  -Werror=unused-result \
- -Wno-cast-function-type \
  -fno-strict-aliasing \
 "
 
 AC_DEFUN([CHECK_CCSUPPORT], [
   my_save_cflags="$CFLAGS"
-  CFLAGS=$1
+  CFLAGS="-Werror $1"
   AC_MSG_CHECKING([whether CC supports $1])
   AC_COMPILE_IFELSE([AC_LANG_PROGRAM([])],
     [AC_MSG_RESULT([yes])]
@@ -658,9 +657,10 @@ CHECK_CCSUPPORT([-Werror=format-overflow=2], [flg1])
 CHECK_CCSUPPORT([-Werror=int-conversion], [flg2])
 CHECK_CCSUPPORT([-Werror=incompatible-pointer-types], [flg3])
 CHECK_CCSUPPORT([-Werror=misleading-indentation], [flg4])
+CHECK_CCSUPPORT([-Wno-cast-function-type], [flg5])
 AX_GCC_FUNC_ATTRIBUTE([format])
 
-AC_SUBST([AM_CFLAGS], ["$my_am_cflags $flg1 $flg2 $flg3 $flg4"])
+AC_SUBST([AM_CFLAGS], ["$my_am_cflags $flg1 $flg2 $flg3 $flg4 $flg5"])
 
 # Make sure that $ACLOCAL_FLAGS are used during a rebuild
 AC_SUBST([ACLOCAL_AMFLAGS], ["-I $ac_macro_dir \$(ACLOCAL_FLAGS)"])
diff --git a/support/include/xcommon.h b/support/include/xcommon.h
index 0001e609..2120a194 100644
--- a/support/include/xcommon.h
+++ b/support/include/xcommon.h
@@ -7,7 +7,7 @@
  */
 
 #ifndef _XMALLOC_H
-#define _MALLOC_H
+#define _XMALLOC_H
 
 #include "compiler.h"
 
diff --git a/utils/mount/network.c b/utils/mount/network.c
index 6ac913d9..d9c0b513 100644
--- a/utils/mount/network.c
+++ b/utils/mount/network.c
@@ -1268,14 +1268,14 @@ nfs_nfs_program(struct mount_options *options, unsigned long *program)
 int
 nfs_nfs_version(char *type, struct mount_options *options, struct nfs_version *version)
 {
-	char *version_key, *version_val, *cptr;
+	char *version_key, *version_val = NULL, *cptr;
 	int i, found = 0;
 
 	version->v_mode = V_DEFAULT;
 
 	for (i = 0; nfs_version_opttbl[i]; i++) {
 		if (po_contains_prefix(options, nfs_version_opttbl[i],
-								&version_key) == PO_FOUND) {
+				       &version_key) == PO_FOUND) {
 			found++;
 			break;
 		}
diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
index 901f995a..91a976b4 100644
--- a/utils/mount/stropts.c
+++ b/utils/mount/stropts.c
@@ -1094,9 +1094,7 @@ static int nfsmount_fg(struct nfsmount_info *mi)
 		if (nfs_try_mount(mi))
 			return EX_SUCCESS;
 
-#pragma GCC diagnostic ignored "-Wdiscarded-qualifiers"
 		if (errno == EBUSY && is_mountpoint(mi->node)) {
-#pragma GCC diagnostic warning "-Wdiscarded-qualifiers"
 			/*
 			 * EBUSY can happen when mounting a filesystem that
 			 * is already mounted or when the context= are
diff --git a/utils/mountd/cache.c b/utils/mountd/cache.c
index 6cba2883..ea740672 100644
--- a/utils/mountd/cache.c
+++ b/utils/mountd/cache.c
@@ -57,7 +57,7 @@ enum nfsd_fsid {
 };
 
 #undef is_mountpoint
-static int is_mountpoint(char *path)
+static int is_mountpoint(const char *path)
 {
 	return check_is_mountpoint(path, nfsd_path_lstat);
 }
-- 
2.26.2

