Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CEE2112B7
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2020 20:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732857AbgGAS2R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Jul 2020 14:28:17 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:34483 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732928AbgGAS2P (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Jul 2020 14:28:15 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jqhSs-0007ZC-0K
        for linux-nfs@vger.kernel.org; Wed, 01 Jul 2020 13:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=f2to4buDWDYYsu6ONLlg05F51lnZs+qeBWeFV96+1Bc=; b=Zyql6lMgMaTfZQ62tv4Utnn7Xf
        rFYAEMt9jZjwe/4j/47SSp+xxJmQwWnumf8cwJ6EA/w2izIenx946zoUxnJovJjXmKU53L2RWLbZV
        2N5RT1NWkBFrWyDldes6yV5dPBoPMFNXIYuOuQZGofjocR32lKXyDRLbvlftuGJB1x8qIqkKZLXL6
        38yHIPMblm6KBancxTqfIdFv1431kw6Gfjw/DTBZM5qdWFzvD9qLC4ZowiyUoc/eaxBRSu3qcByMs
        wW/ynJELy7kiGull90Lz7blCOVjSiCbyv/GTh/W7HncYqGFdzBoHsYeJGod308Wh9DpgFV6hLjqN1
        8aku9yog==;
Received: from [174.119.114.224] (port=43594 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jqhSr-0003Oc-Pt
        for linux-nfs@vger.kernel.org; Wed, 01 Jul 2020 14:28:09 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 09/10] Cleanup printf format attribute handling and fix various format strings
Date:   Wed,  1 Jul 2020 14:28:01 -0400
Message-Id: <20200701182803.14947-11-nazard@nazar.ca>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (1.16304197384e-08)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0f6LF1GdvkEexklpcFpSF5apSDasLI4SayDByyq9LIhVklPpP9+MltQ7
 c0rmPB0MOETNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dJZdpByI21dqeIGnBGb0WmGjJaflFkgi3Ayd8TYbXs853XpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQwzEEJbreAQRsbSZZ9fXoUEifL76GD10kuo3nOZaoX+gsjENmEszkjZCjfYHwrdv
 NOzx52pqgFKULzmTh7lC+C1OB0fQQI8VICRbS6zGNgmk2+y1r/Jt2+QI0NYgZu+YDGDmnroh/8hH
 WR/Etfk4HCQTo4dLz8XEDoyijq2CEGKcGplHcpVCCoX989hgB8R+yHz6Wz8d/Pp/n7kUT3MNKWyV
 mI6ol8ojWV/XK6LQktrh5Ge6dBNugO5GnQ0oUmeM139nMre3YEbkuALmW8gN9RXH3DI0NOgo6/Ab
 vYB8YDlEEBksfbu9yLQMc7lcHkHFV/djzQ6YC7Heg3Xf7O1TOd4Lp6/mezP3/ta7RoBl7TSj8Cd1
 02D1/PxWBdanhqFXVNDQ7yU+027LpSM25Xk8gZNnb47KQI8A+AxenA33dOIYZjEa/sNl+vcoDGoY
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
 support/include/compiler.h         | 14 ++++++++++++++
 support/include/xcommon.h          | 10 +---------
 support/include/xlog.h             | 20 ++++++--------------
 support/nfs/xcommon.c              |  2 ++
 support/nfsidmap/gums.c            |  2 ++
 support/nfsidmap/libnfsidmap.c     |  8 +++++---
 support/nfsidmap/nfsidmap.h        | 10 +++++++++-
 support/nfsidmap/nfsidmap_common.c |  1 +
 support/nfsidmap/nss.c             |  4 +++-
 support/nfsidmap/regex.c           |  6 ++++--
 support/nfsidmap/static.c          |  1 +
 support/nfsidmap/umich_ldap.c      | 10 ++++++----
 tools/locktest/testlk.c            |  6 ++++--
 utils/exportfs/exportfs.c          |  5 ++---
 utils/gssd/err_util.h              |  4 +++-
 utils/gssd/gss_names.c             |  9 +++++----
 utils/gssd/gss_util.c              |  2 +-
 utils/gssd/gssd_proc.c             |  8 ++++----
 utils/gssd/krb5_util.c             | 12 ++++++++----
 utils/gssd/svcgssd.c               |  4 +++-
 utils/gssd/svcgssd_proc.c          |  9 +++++----
 utils/idmapd/idmapd.c              |  3 ++-
 utils/nfsidmap/nfsidmap.c          |  3 ++-
 23 files changed, 93 insertions(+), 60 deletions(-)
 create mode 100644 support/include/compiler.h

diff --git a/support/include/compiler.h b/support/include/compiler.h
new file mode 100644
index 00000000..950c1ecd
--- /dev/null
+++ b/support/include/compiler.h
@@ -0,0 +1,14 @@
+#ifndef COMPILER_H
+#define COMPILER_H
+
+#ifndef CONFIG_H
+#include <config.h>
+#endif
+
+#ifdef HAVE_FUNC_ATTRIBUTE_FORMAT
+#define X_FORMAT(_x) __attribute__((__format__ _x))
+#else
+#define X_FORMAT(_x)
+#endif
+
+#endif
diff --git a/support/include/xcommon.h b/support/include/xcommon.h
index 30b0403b..0001e609 100644
--- a/support/include/xcommon.h
+++ b/support/include/xcommon.h
@@ -9,9 +9,7 @@
 #ifndef _XMALLOC_H
 #define _MALLOC_H
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
+#include "compiler.h"
 
 #include <sys/types.h>
 #include <fcntl.h>
@@ -29,12 +27,6 @@
 
 #define streq(s, t)	(strcmp ((s), (t)) == 0)
 
-#ifdef HAVE_FUNC_ATTRIBUTE_FORMAT
-#define X_FORMAT(_x) __attribute__((__format__ _x))
-#else
-#define X_FORMAT(_x)
-#endif
-
 /* Functions in sundries.c that are used in mount.c and umount.c  */
 char *canonicalize (const char *path);
 void nfs_error (const char *fmt, ...) X_FORMAT((printf, 1, 2));
diff --git a/support/include/xlog.h b/support/include/xlog.h
index 32ff5a1b..b79fe641 100644
--- a/support/include/xlog.h
+++ b/support/include/xlog.h
@@ -7,9 +7,7 @@
 #ifndef XLOG_H
 #define XLOG_H
 
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
+#include "compiler.h"
 
 #include <stdarg.h>
 
@@ -39,12 +37,6 @@ struct xlog_debugfac {
 	int		df_fac;
 };
 
-#ifdef HAVE_FUNC_ATTRIBUTE_FORMAT
-#define XLOG_FORMAT(_x) __attribute__((__format__ _x))
-#else
-#define XLOG_FORMAT(_x)
-#endif
-
 extern int export_errno;
 void			xlog_open(char *progname);
 void			xlog_stderr(int on);
@@ -53,10 +45,10 @@ void			xlog_config(int fac, int on);
 void			xlog_sconfig(char *, int on);
 void			xlog_from_conffile(char *);
 int			xlog_enabled(int fac);
-void			xlog(int fac, const char *fmt, ...) XLOG_FORMAT((printf, 2, 3));
-void			xlog_warn(const char *fmt, ...) XLOG_FORMAT((printf, 1, 2));
-void			xlog_err(const char *fmt, ...) XLOG_FORMAT((printf, 1, 2));
-void			xlog_errno(int err, const char *fmt, ...) XLOG_FORMAT((printf, 2, 3));
-void			xlog_backend(int fac, const char *fmt, va_list args) XLOG_FORMAT((printf, 2, 0));
+void			xlog(int fac, const char *fmt, ...) X_FORMAT((printf, 2, 3));
+void			xlog_warn(const char *fmt, ...) X_FORMAT((printf, 1, 2));
+void			xlog_err(const char *fmt, ...) X_FORMAT((printf, 1, 2));
+void			xlog_errno(int err, const char *fmt, ...) X_FORMAT((printf, 2, 3));
+void			xlog_backend(int fac, const char *fmt, va_list args) X_FORMAT((printf, 2, 0));
 
 #endif /* XLOG_H */
diff --git a/support/nfs/xcommon.c b/support/nfs/xcommon.c
index 3989f0bc..5974974d 100644
--- a/support/nfs/xcommon.c
+++ b/support/nfs/xcommon.c
@@ -98,7 +98,9 @@ nfs_error (const char *fmt, ...) {
 
      fmt2 = xstrconcat2 (fmt, "\n");
      va_start (args, fmt);
+#pragma GCC diagnostic ignored "-Wformat-nonliteral"
      vfprintf (stderr, fmt2, args);
+#pragma GCC diagnostic warning "-Wformat-nonliteral"
      va_end (args);
      free (fmt2);
 }
diff --git a/support/nfsidmap/gums.c b/support/nfsidmap/gums.c
index 1d6eb318..e46f24b7 100644
--- a/support/nfsidmap/gums.c
+++ b/support/nfsidmap/gums.c
@@ -41,6 +41,8 @@
 #include <grp.h>
 #include <err.h>
 #include <syslog.h>
+
+#include "compiler.h"
 #include "nfsidmap.h"
 #include "nfsidmap_plugin.h"
 
diff --git a/support/nfsidmap/libnfsidmap.c b/support/nfsidmap/libnfsidmap.c
index bce448cf..e1b52918 100644
--- a/support/nfsidmap/libnfsidmap.c
+++ b/support/nfsidmap/libnfsidmap.c
@@ -57,6 +57,7 @@
 #include <arpa/nameser.h>
 #include <arpa/nameser_compat.h>
 
+#include "compiler.h"
 #include "nfsidmap.h"
 #include "nfsidmap_private.h"
 #include "nfsidmap_plugin.h"
@@ -94,6 +95,7 @@ gid_t nobody_gid = (gid_t)-1;
 #endif
 
 /* Default logging fuction */
+X_FORMAT((__printf__, 1, 2))
 static void default_logger(const char *fmt, ...)
 {
 	va_list vp;
@@ -258,7 +260,7 @@ static int load_translation_plugin(char *method, struct mapping_plugin *plgn)
 	}
 	trans = init_func();
 	if (trans == NULL) {
-		IDMAP_LOG(1, ("libnfsidmap: Failed to initialize plugin %s",
+		IDMAP_LOG(1, ("libnfsidmap: %s failed to initialize plugin %s",
 			  PLUGIN_INIT_FUNC, plgname));
 		dlclose(dl);
 		return -1;
@@ -451,7 +453,7 @@ int nfs4_init_name_mapping(char *conffile)
 					nobody_user, strerror(errno)));
 			free(buf);
 		} else
-			IDMAP_LOG(0,("libnfsidmap: Nobody-User: no memory : %s", 
+			IDMAP_LOG(0,("libnfsidmap: Nobody-User (%s): no memory : %s",
 					nobody_user, strerror(errno)));
 	}
 
@@ -472,7 +474,7 @@ int nfs4_init_name_mapping(char *conffile)
 					nobody_group, strerror(errno)));
 			free(buf);
 		} else
-			IDMAP_LOG(0,("libnfsidmap: Nobody-Group: no memory : %s", 
+			IDMAP_LOG(0,("libnfsidmap: Nobody-Group (%s): no memory : %s",
 					nobody_group, strerror(errno)));
 	}
 
diff --git a/support/nfsidmap/nfsidmap.h b/support/nfsidmap/nfsidmap.h
index 10630654..dcd42eda 100644
--- a/support/nfsidmap/nfsidmap.h
+++ b/support/nfsidmap/nfsidmap.h
@@ -35,6 +35,14 @@
  *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+#ifndef X_FORMAT
+# ifdef __GNUC__
+#  define X_FORMAT(_x) __attribute__((__format__ _x))
+# else
+#  define X_FORMAT(_x)
+# endif
+#endif
+
 /* XXX arbitrary */
 #define NFS4_MAX_DOMAIN_LEN 512
 typedef enum {
@@ -47,7 +55,7 @@ typedef struct _extra_mapping_params {
 	int content_len;
 } extra_mapping_params;
 
-typedef void (*nfs4_idmap_log_function_t)(const char *, ...);
+typedef void (* nfs4_idmap_log_function_t)(const char *, ...) X_FORMAT((printf, 1, 2));
 
 int nfs4_init_name_mapping(char *conffile);
 int nfs4_get_default_domain(char *server, char *domain, size_t len);
diff --git a/support/nfsidmap/nfsidmap_common.c b/support/nfsidmap/nfsidmap_common.c
index f89b82ee..66390af2 100644
--- a/support/nfsidmap/nfsidmap_common.c
+++ b/support/nfsidmap/nfsidmap_common.c
@@ -19,6 +19,7 @@
 #include <errno.h>
 #include <string.h>
 
+#include "compiler.h"
 #include "nfsidmap.h"
 #include "nfsidmap_private.h"
 #include "nfsidmap_plugin.h"
diff --git a/support/nfsidmap/nss.c b/support/nfsidmap/nss.c
index 9d46499c..f422a9f8 100644
--- a/support/nfsidmap/nss.c
+++ b/support/nfsidmap/nss.c
@@ -47,10 +47,12 @@
 #include <grp.h>
 #include <limits.h>
 #include <ctype.h>
+#include <syslog.h>
+
+#include "compiler.h"
 #include "nfsidmap.h"
 #include "nfsidmap_plugin.h"
 #include "nfsidmap_private.h"
-#include <syslog.h>
 
 static char *get_default_domain(void)
 {
diff --git a/support/nfsidmap/regex.c b/support/nfsidmap/regex.c
index fdbb2e2f..a2e13148 100644
--- a/support/nfsidmap/regex.c
+++ b/support/nfsidmap/regex.c
@@ -44,6 +44,7 @@
 #include <err.h>
 #include <regex.h>
 
+#include "compiler.h"
 #include "nfsidmap.h"
 #include "nfsidmap_plugin.h"
 
@@ -229,8 +230,9 @@ static struct group *regex_getgrnam(const char *name, const char *UNUSED(domain)
 
 		if (err)
 		{
-			IDMAP_LOG(4, ("regexp_getgrnam: removing prefix '%s' (%d long) from group '%s'", group_name_prefix, group_name_prefix_length, localgroup));
-				groupname += group_name_prefix_length;
+			IDMAP_LOG(4, ("regexp_getgrnam: removing prefix '%s' (%zd long) from group '%s'",
+				      group_name_prefix, group_name_prefix_length, localgroup));
+			groupname += group_name_prefix_length;
 		}
 		else
 		{
diff --git a/support/nfsidmap/static.c b/support/nfsidmap/static.c
index 8ac4a398..a6e1e275 100644
--- a/support/nfsidmap/static.c
+++ b/support/nfsidmap/static.c
@@ -41,6 +41,7 @@
 #include <errno.h>
 #include <err.h>
 
+#include "compiler.h"
 #include "conffile.h"
 #include "nfsidmap.h"
 #include "nfsidmap_plugin.h"
diff --git a/support/nfsidmap/umich_ldap.c b/support/nfsidmap/umich_ldap.c
index c475d379..2954b61c 100644
--- a/support/nfsidmap/umich_ldap.c
+++ b/support/nfsidmap/umich_ldap.c
@@ -56,6 +56,8 @@
 /* We are using deprecated functions, get the prototypes... */
 #define LDAP_DEPRECATED 1
 #include <ldap.h>
+
+#include "compiler.h"
 #include "nfslib.h"
 #include "nfsidmap.h"
 #include "nfsidmap_plugin.h"
@@ -795,8 +797,8 @@ umich_id_to_name(uid_t id, int idtype, char **name, size_t len,
 	 */
 	if (strlen(names[0]) >= len) {
 		/* not enough space to return the name */
-		IDMAP_LOG(1, ("umich_id_to_name: output buffer size (%d) "
-			  "too small to return string, '%s', of length %d",
+		IDMAP_LOG(1, ("umich_id_to_name: output buffer size (%zd) "
+			  "too small to return string, '%s', of length %zd",
 			  len, names[0], strlen(names[0])));
 		goto out_memfree;
 	}
@@ -1307,7 +1309,7 @@ get_canonical_hostname(const char *inname)
 			     sizeof(tmphost), NULL, 0, 0);
 	if (error) {
 		IDMAP_LOG(1, ("%s: getnameinfo for host '%s' failed (%d)",
-			  __FUNCTION__, inname));
+			  __FUNCTION__, inname, error));
 		goto out_free;
 	}
 	return_name = strdup (tmphost);
@@ -1356,7 +1358,7 @@ umichldap_init(void)
 			ldap_info.tls_reqcert = LDAP_OPT_X_TLS_NEVER;
 		else {
 			IDMAP_LOG(0, ("umichldap_init: Invalid value(%s) for "
-				      "LDAP_tls_reqcert."));
+				      "LDAP_tls_reqcert.", cert_req));
 			goto fail;
 		}
 	}
diff --git a/tools/locktest/testlk.c b/tools/locktest/testlk.c
index ea51f788..5dbc39f1 100644
--- a/tools/locktest/testlk.c
+++ b/tools/locktest/testlk.c
@@ -2,6 +2,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <unistd.h>
@@ -81,8 +82,9 @@ main(int argc, char **argv)
 		if (fl.l_type == F_UNLCK) {
 			printf("%s: no conflicting lock\n", fname);
 		} else {
-			printf("%s: conflicting lock by %d on (%zd;%zd)\n",
-				fname, fl.l_pid, fl.l_start, fl.l_len);
+			printf("%s: conflicting lock by %d on "
+			       "(%" PRId64 ";%" PRId64 ")\n",
+			       fname, fl.l_pid, fl.l_start, fl.l_len);
 		}
 		return 0;
 	}
diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index a04a7898..6f5243f2 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -38,6 +38,7 @@
 #include "exportfs.h"
 #include "xlog.h"
 #include "conffile.h"
+#include "compiler.h"
 
 static void	export_all(int verbose);
 static void	exportfs(char *arg, char *options, int verbose);
@@ -651,9 +652,7 @@ out:
 	return result;
 }
 
-#ifdef HAVE_FUNC_ATTRIBUTE_FORMAT
-__attribute__((format (printf, 2, 3)))
-#endif
+X_FORMAT((printf, 2, 3))
 static char
 dumpopt(char c, char *fmt, ...)
 {
diff --git a/utils/gssd/err_util.h b/utils/gssd/err_util.h
index c4df32da..b4f5f40e 100644
--- a/utils/gssd/err_util.h
+++ b/utils/gssd/err_util.h
@@ -31,8 +31,10 @@
 #ifndef _ERR_UTIL_H_
 #define _ERR_UTIL_H_
 
+#include "compiler.h"
+
 void initerr(char *progname, int verbosity, int fg);
-void printerr(int priority, char *format, ...);
+void printerr(int priority, char *format, ...) X_FORMAT((printf, 2, 3));
 int get_verbosity(void);
 
 #endif /* _ERR_UTIL_H_ */
diff --git a/utils/gssd/gss_names.c b/utils/gssd/gss_names.c
index 2a7f3a13..5d2f2987 100644
--- a/utils/gssd/gss_names.c
+++ b/utils/gssd/gss_names.c
@@ -45,10 +45,11 @@
 #include <string.h>
 #include <fcntl.h>
 #include <errno.h>
-#include <nfsidmap.h>
-#include <nfslib.h>
 #include <time.h>
 
+#include "compiler.h"
+#include "nfsidmap.h"
+#include "nfslib.h"
 #include "svcgssd.h"
 #include "gss_util.h"
 #include "gss_names.h"
@@ -65,7 +66,7 @@ get_krb5_hostbased_name(gss_buffer_desc *name, char **hostbased_name)
 	if (strchr(name->value, '@') && strchr(name->value, '/')) {
 		if ((sname = calloc(name->length, 1)) == NULL) {
 			printerr(0, "ERROR: get_krb5_hostbased_name failed "
-				 "to allocate %d bytes\n", name->length);
+				 "to allocate %zu bytes\n", name->length);
 			return -1;
 		}
 		/* read in name and instance and replace '/' with '@' */
@@ -102,7 +103,7 @@ get_hostbased_client_name(gss_name_t client_name, gss_OID mech,
 	}
 	if (name.length >= 0xffff) {	    /* don't overflow */
 		printerr(0, "ERROR: get_hostbased_client_name: "
-			 "received gss_name is too long (%d bytes)\n",
+			 "received gss_name is too long (%zu bytes)\n",
 			 name.length);
 		goto out_rel_buf;
 	}
diff --git a/utils/gssd/gss_util.c b/utils/gssd/gss_util.c
index 2e6d40f0..e1714fa0 100644
--- a/utils/gssd/gss_util.c
+++ b/utils/gssd/gss_util.c
@@ -304,7 +304,7 @@ gssd_acquire_cred(char *server_name, const gss_OID oid)
 				target_name, &pbuf, NULL);
 		if (ignore_maj_stat == GSS_S_COMPLETE) {
 			printerr(1, "Unable to obtain credentials for '%.*s'\n",
-				 pbuf.length, pbuf.value);
+				 (int)pbuf.length, (char*)pbuf.value);
 			ignore_maj_stat = gss_release_buffer(&ignore_min_stat,
 							     &pbuf);
 		}
diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
index addac318..342bf693 100644
--- a/utils/gssd/gssd_proc.c
+++ b/utils/gssd/gssd_proc.c
@@ -151,7 +151,7 @@ do_downcall(int k5_fd, uid_t uid, struct authgss_private_data *pd,
 	unsigned int buf_size = 0;
 
 	printerr(2, "doing downcall: lifetime_rec=%u acceptor=%.*s\n",
-		lifetime_rec, acceptor->length, acceptor->value);
+		lifetime_rec, (int)acceptor->length, (char*)acceptor->value);
 	buf_size = sizeof(uid) + sizeof(timeout) + sizeof(pd->pd_seq_win) +
 		sizeof(pd->pd_ctx_hndl.length) + pd->pd_ctx_hndl.length +
 		sizeof(context_token->length) + context_token->length +
@@ -266,13 +266,13 @@ populate_port(struct sockaddr *sa, const socklen_t salen,
 
 	port = nfs_getport(sa, salen, program, version, protocol);
 	if (!port) {
-		printerr(0, "ERROR: unable to obtain port for prog %ld "
-			    "vers %ld\n", program, version);
+		printerr(0, "ERROR: unable to obtain port for prog %u "
+			    "vers %u\n", program, version);
 		return 0;
 	}
 
 set_port:
-	printerr(2, "DEBUG: setting port to %hu for prog %lu vers %lu\n", port,
+	printerr(2, "DEBUG: setting port to %hu for prog %u vers %u\n", port,
 		 program, version);
 
 	switch (sa->sa_family) {
diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index e5b81823..cb959425 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -293,7 +293,7 @@ gssd_find_existing_krb5_ccache(uid_t uid, char *dirname,
 				score++;
 
 			printerr(3, "CC '%s'(%s@%s) passed all checks and"
-				    " has mtime of %u\n",
+				    " has mtime of %ld\n",
 				 buf, princname, realm, 
 				 tmp_stat.st_mtime);
 			/*
@@ -330,8 +330,8 @@ gssd_find_existing_krb5_ccache(uid_t uid, char *dirname,
 				}
 				printerr(3, "CC '%s:%s/%s' is our "
 					    "current best match "
-					    "with mtime of %u\n",
-					 cctype, dirname,
+					    "with mtime of %lu\n",
+					 *cctype, dirname,
 					 best_match_dir->d_name,
 					 best_match_stat.st_mtime);
 			}
@@ -1260,8 +1260,12 @@ gssd_setup_krb5_user_gss_ccache(uid_t uid, char *servername, char *dirpattern)
 	if (err)
 		return err;
 
-	snprintf(buf, sizeof(buf), "%s:%s/%s", cctype, dirname, d->d_name);
+	err = snprintf(buf, sizeof(buf), "%s:%s/%s", cctype, dirname, d->d_name);
 	free(d);
+	if (err < 0) {
+		printerr(0, "WARNING: buffer to small for krb5 ccache");
+		return -ENOMEM;
+	}
 
 	printerr(2, "using %s as credentials cache for client with "
 		    "uid %u for server %s\n", buf, uid, servername);
diff --git a/utils/gssd/svcgssd.c b/utils/gssd/svcgssd.c
index ec49b616..cde4ffc9 100644
--- a/utils/gssd/svcgssd.c
+++ b/utils/gssd/svcgssd.c
@@ -56,7 +56,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <signal.h>
-#include <nfsidmap.h>
+
+#include "compiler.h"
+#include "nfsidmap.h"
 #include "nfslib.h"
 #include "svcgssd.h"
 #include "gss_util.h"
diff --git a/utils/gssd/svcgssd_proc.c b/utils/gssd/svcgssd_proc.c
index 72ec2540..5c0e46a8 100644
--- a/utils/gssd/svcgssd_proc.c
+++ b/utils/gssd/svcgssd_proc.c
@@ -48,10 +48,11 @@
 #include <string.h>
 #include <fcntl.h>
 #include <errno.h>
-#include <nfsidmap.h>
 #include <nfslib.h>
 #include <time.h>
 
+#include "compiler.h"
+#include "nfsidmap.h"
 #include "svcgssd.h"
 #include "gss_util.h"
 #include "err_util.h"
@@ -102,7 +103,7 @@ do_svc_downcall(gss_buffer_desc *out_handle, struct svc_cred *cred,
 	qword_addint(&bp, &blen, cred->cr_uid);
 	qword_addint(&bp, &blen, cred->cr_gid);
 	qword_addint(&bp, &blen, cred->cr_ngroups);
-	printerr(2, "mech: %s, hndl len: %d, ctx len %d, timeout: %d (%d from now), "
+	printerr(2, "mech: %s, hndl len: %zd, ctx len %zd, timeout: %d (%ld from now), "
 		 "clnt: %s, uid: %d, gid: %d, num aux grps: %d:\n",
 		 fname, out_handle->length, context_token->length,
 		 endtime, endtime - time(0),
@@ -232,7 +233,7 @@ get_ids(gss_name_t client_name, gss_OID mech, struct svc_cred *cred)
 	}
 	if (name.length >= 0xffff || /* be certain name.length+1 doesn't overflow */
 	    !(sname = calloc(name.length + 1, 1))) {
-		printerr(0, "WARNING: get_ids: error allocating %d bytes "
+		printerr(0, "WARNING: get_ids: error allocating %zd bytes "
 			"for sname\n", name.length + 1);
 		gss_release_buffer(&min_stat, &name);
 		goto out;
@@ -373,7 +374,7 @@ handle_nullreq(int f) {
 	if (in_handle.length != 0) { /* CONTINUE_INIT case */
 		if (in_handle.length != sizeof(ctx)) {
 			printerr(0, "WARNING: handle_nullreq: "
-				    "input handle has unexpected length %d\n",
+				    "input handle has unexpected length %zd\n",
 				    in_handle.length);
 			goto out_err;
 		}
diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
index 12648f67..fa6d920a 100644
--- a/utils/idmapd/idmapd.c
+++ b/utils/idmapd/idmapd.c
@@ -65,8 +65,9 @@
 #include <limits.h>
 #include <ctype.h>
 #include <libgen.h>
-#include <nfsidmap.h>
 
+#include "compiler.h"
+#include "nfsidmap.h"
 #include "xlog.h"
 #include "conffile.h"
 #include "queue.h"
diff --git a/utils/nfsidmap/nfsidmap.c b/utils/nfsidmap/nfsidmap.c
index cf7f65e9..792f832c 100644
--- a/utils/nfsidmap/nfsidmap.c
+++ b/utils/nfsidmap/nfsidmap.c
@@ -10,9 +10,10 @@
 #include <pwd.h>
 #include <grp.h>
 #include <keyutils.h>
-#include <nfsidmap.h>
 
 #include <unistd.h>
+#include "compiler.h"
+#include "nfsidmap.h"
 #include "xlog.h"
 #include "conffile.h"
 #include "xcommon.h"
-- 
2.26.2

