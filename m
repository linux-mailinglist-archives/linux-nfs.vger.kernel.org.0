Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02F3019E403
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Apr 2020 11:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgDDJDA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 4 Apr 2020 05:03:00 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:33620 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDDJC7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 4 Apr 2020 05:02:59 -0400
Received: by mail-pg1-f176.google.com with SMTP id d17so4860375pgo.0
        for <linux-nfs@vger.kernel.org>; Sat, 04 Apr 2020 02:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+z8kq4hBwW9sMlU4yvAkhfOXAEpLMCS+y1kOWMm1p/M=;
        b=cXfYqlF8aUd1OFqX8O/KO9I27BtJhUhQRRIRu1vIUbyn19PRvHA2G6jqaMVgMCnSAL
         K2zFU/+S6Ow9e2hBpqHi+i5pofylzHtyPZrZCp+pyHwI/6mhg1w4ik1Tq4a2KQBLFjGw
         wRLCtqkIVrlyRCuIvdvgOwzFIQocv18OoIqxiZlYK07PE4wk2077YwJcKMV7WibAatmN
         jVsph+AuuyFpuoaXeIb7a0oj0clyqCwGFEhe5PoWlJwjR1lFXlkIJ5wFO5uAUSBO6v2c
         6sEV07bEdHKyEfxR4LiP4g6YoEBsemH5g+yB0Orxs3FtzbXFeB8Q/FBM4xY3p6T5FL7e
         Q/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+z8kq4hBwW9sMlU4yvAkhfOXAEpLMCS+y1kOWMm1p/M=;
        b=GHZE6mJ8GCMwpIYEpRe/3etfA7mYKzxIHCMNvsRmttQjFKT2gynvGL0k4UiOafJOLd
         79sFvanTApddiw/uiqVJWuG4Kv/qTawtoJscq0w9pLf0pIJ9+UMZ9mEr6ywvTVE3D9Ur
         pAh+jbheF+dviTnm5+JLNFcQ/nGeG/GkSdipS28zxrVzcjpeJlI1Nz/9u+MaZdgk3RyG
         6WAM4rPRAwH5k1YKgyYrH+U8/fckwVUwA19ICHX4ZIXFg4IMTeLqhm/IyQND6m8zToxZ
         5FbB8vHGwvqj+nk5Gsu5pUqI7UMz4FdpmWuUadDN7jILihYm5NkV+NTAJHEu45e5irkU
         8z+Q==
X-Gm-Message-State: AGi0PubEJJpGRI2AzdLs5x05nosYhbOF8ngCU4pmCVbNaOw7FARdLtD1
        UqLCsbAiG9OnOIoalGqjnVyy4b7G2VA=
X-Google-Smtp-Source: APiQypLr1WafkBgyGErd0M6gdXSPgafJ4nLlOmGNXYWnMF3a7bi/z0F9A5MYsBs+K2bt5a1LW1IJDQ==
X-Received: by 2002:aa7:8643:: with SMTP id a3mr12992793pfo.133.1585990976686;
        Sat, 04 Apr 2020 02:02:56 -0700 (PDT)
Received: from localhost.localdomain ([192.146.154.244])
        by smtp.gmail.com with ESMTPSA id f9sm5899245pgj.2.2020.04.04.02.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 02:02:56 -0700 (PDT)
From:   Srikrishan Malik <srikrishanmalik@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     Srikrishan Malik <srikrishanmalik@gmail.com>
Subject: [PATCH] nfsidmap:umich_ldap: Add support for SASL binds.
Date:   Sat,  4 Apr 2020 02:02:41 -0700
Message-Id: <20200404090241.30009-1-srikrishanmalik@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

umich_ldap can now do a sasl interactive bind to LDAP server based
on the values of new tunables added.
The tunables are similar to the ones in nslcd for SASL binds.

Signed-off-by: Srikrishan Malik <srikrishanmalik@gmail.com>
---
 configure.ac                   |  23 ++-
 support/nfsidmap/Makefile.am   |   5 +-
 support/nfsidmap/idmapd.conf   |  23 +++
 support/nfsidmap/idmapd.conf.5 |  37 ++++-
 support/nfsidmap/umich_ldap.c  | 250 ++++++++++++++++++++++++++++++++-
 5 files changed, 330 insertions(+), 8 deletions(-)

diff --git a/configure.ac b/configure.ac
index bb8b000e..00b32800 100644
--- a/configure.ac
+++ b/configure.ac
@@ -453,12 +453,33 @@ if test "x$enable_ldap" != "xno" ; then
                               [have_ldap="yes"],[have_ldap="no"])],
                 [have_ldap="no"])
         if test "x$have_ldap" = "xyes" ; then
-                AC_DEFINE([ENABLE_LDAP], 1, [Enable LDAP Support])
+                dnl check for sasl funcs
+                AC_CHECK_HEADERS(sasl.h sasl/sasl.h)
+                AC_CHECK_HEADERS(gsssasl.h)
+                AC_CHECK_TYPE(sasl_interact_t,[have_sasl_interact_t="yes"],,[
+                        #ifdef HAVE_SASL_SASL_H
+                        #include <sasl/sasl.h>
+                        #elif defined(HAVE_SASL_H)
+                        #include <sasl.h>
+                        #endif])
+		AC_CHECK_LIB([ldap],[ldap_sasl_interactive_bind_s],[have_ldap_sasl_interactive_bind_s="yes"])
+		AC_CHECK_LIB([gssapi_krb5],[gss_krb5_ccache_name],[have_gss_krb5_ccache_name="yes"])
+		if test "x$have_sasl_interact_t" = "xyes" -a \
+			"x$have_ldap_sasl_interactive_bind_s" = "xyes" -a \
+			"x$have_gss_krb5_ccache_name" = "xyes"; then
+			AC_DEFINE([HAVE_LDAP_SASL_INTERACTIVE_BIND_S],[1],[Has ldap_sasl_interactive_bind_s function])
+			AC_DEFINE([HAVE_GSS_KRB5_CCACHE_NAME],[1],[Has gss_krb5_ccache_name function])
+			AC_CHECK_HEADERS(gssapi/gssapi.h gssapi/gssapi_generic.h gssapi/gssapi_krb5.h gssapi.h krb5.h)
+			AC_DEFINE([ENABLE_LDAP_SASL],1,[Enable LDAP SASL support])
+			have_ldap_sasl="yes"
+		fi
+		AC_DEFINE([ENABLE_LDAP], 1, [Enable LDAP Support])
         elif test "x$enable_ldap$have_ldap" = "xyesno" ; then
                 AC_MSG_ERROR(LDAP support not found!)
         fi
 fi
 AM_CONDITIONAL(ENABLE_LDAP, test "x$have_ldap" = "xyes")
+AM_CONDITIONAL(ENABLE_LDAP_SASL, test "x$have_ldap_sasl" = "xyes")
 
 dnl Should we build gums mapping library?
 AC_ARG_ENABLE([gums],
diff --git a/support/nfsidmap/Makefile.am b/support/nfsidmap/Makefile.am
index 9c21fa34..cb2c0ced 100644
--- a/support/nfsidmap/Makefile.am
+++ b/support/nfsidmap/Makefile.am
@@ -14,6 +14,9 @@ GUMS_MAPPING_LIB = gums.la
 else
 GUMS_MAPPING_LIB =
 endif
+if ENABLE_LDAP_SASL
+KRB5_GSS_LIB=-lgssapi_krb5
+endif
 lib_LTLIBRARIES = libnfsidmap.la
 pkgplugin_LTLIBRARIES = nsswitch.la static.la $(UMICH_LDAP_LIB) $(GUMS_MAPPING_LIB)
 
@@ -43,7 +46,7 @@ static_la_LIBADD = ../../support/nfs/libnfsconf.la
 
 umich_ldap_la_SOURCES = umich_ldap.c
 umich_ldap_la_LDFLAGS = -module -avoid-version
-umich_ldap_la_LIBADD = -lldap ../../support/nfs/libnfsconf.la
+umich_ldap_la_LIBADD = -lldap $(KRB5_GSS_LIB) ../../support/nfs/libnfsconf.la
 
 gums_la_SOURCES = gums.c
 gums_la_LDFLAGS = -module -avoid-version
diff --git a/support/nfsidmap/idmapd.conf b/support/nfsidmap/idmapd.conf
index b673c7d7..aeeca1bf 100644
--- a/support/nfsidmap/idmapd.conf
+++ b/support/nfsidmap/idmapd.conf
@@ -110,6 +110,29 @@ LDAP_base = dc=local,dc=domain,dc=edu
 # is not set to "never"
 #LDAP_ca_cert = /etc/ldapca.cert
 
+# SASL mechanism to use while binding to LDAP
+#LDAP_sasl_mech = <SASL mech>
+
+# SASL realm to be used for SASL auth
+#LDAP_sasl_realm = <SASL realm>
+
+# Authentication identity to be used for SASL auth
+#LDAP_sasl_authcid = <SASL authcid>
+
+# Authorization identity for SASL auth
+#LDAP_sasl_authzid = <SASL authzid>
+
+# Cyrus SASL security properties
+#LDAP_sasl_secprops = <secprops>
+
+# Specifies whether the LDAP server hostname should be canonicalised.
+# If set to yes LDAP lib with do a reverse hostname lookup.
+# If this is not set the LDAP library's default will be used.
+#LDAP_sasl_canonicalize <yes | no>
+
+# Specifies the kerberos ticket cache to be used
+#LDAP_sasl_krb5_ccname = <kerberos ticket cache>
+
 # Objectclass mapping information
 
 # Mapping for the person (account) object class
diff --git a/support/nfsidmap/idmapd.conf.5 b/support/nfsidmap/idmapd.conf.5
index 61fbb613..fdd6d589 100644
--- a/support/nfsidmap/idmapd.conf.5
+++ b/support/nfsidmap/idmapd.conf.5
@@ -206,6 +206,39 @@ It can take the same values as ldap.conf(5)'s
 tunable.
 (Default: "hard")
 .TP
+.B LDAP_timeout_seconds
+Number of seconds before timing out an LDAP request
+(Default: 4)
+.TP
+.B LDAP_sasl_mech
+SASL mechanism to be used for sasl authentication.  Required
+if SASL auth is to be used (Default: None)
+.TP
+.B LDAP_realm
+SASL realm to be used for sasl authentication. (Default: None)
+.TP
+.B LDAP_sasl_authcid
+Authentication identity to be used for sasl authentication. (Default: None)
+.TP
+.B LDAP_sasl_authzid
+Authorization identity to be used for sasl authentication. (Default: None)
+.TP
+.B LDAP_sasl_secprops
+Cyrus SASL security properties. It can  the same values as ldap.conf(5)'s
+sasl_secprops.
+.TP
+.B LDAP_sasl_canonicalize
+Specifies whether the LDAP server hostname should be canonicalised.
+If set to yes LDAP lib with do a reverse hostname lookup.
+If this is not set the LDAP library's default will be used. (Default:
+None)
+.TP
+.B LDAP_sasl_krb5_ccname
+Path to kerberos credential cache. If it is not set then the value
+of environment variable KRB5CCNAME will be used. If the environment
+variable is not set then the default mechanism of kerberos library
+will be used.
+.TP
 .B NFSv4_person_objectclass
 The object class name for people accounts in your local LDAP schema
 (Default: NFSv4RemotePerson)
@@ -257,10 +290,6 @@ is true, this is the attribute to be searched for.
 .B NFSv4_grouplist_filter
 An optional search filter for determining group membership.
 (No Default)
-.TP
-.B LDAP_timeout_seconds
-Number of seconds before timing out an LDAP request
-(Default: 4)
 .\"
 .\" -------------------------------------------------------------------
 .\" An Example
diff --git a/support/nfsidmap/umich_ldap.c b/support/nfsidmap/umich_ldap.c
index b7445c37..d5a7731a 100644
--- a/support/nfsidmap/umich_ldap.c
+++ b/support/nfsidmap/umich_ldap.c
@@ -31,6 +31,7 @@
  * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
+#include "config.h"
 
 #include <sys/types.h>
 #include <sys/socket.h>
@@ -43,6 +44,15 @@
 #include <limits.h>
 #include <pwd.h>
 #include <err.h>
+#ifdef HAVE_GSSAPI_GSSAPI_KRB5_H
+#include <gssapi/gssapi_krb5.h>
+#endif /* HAVE_GSSAPI_GSSAPI_KRB5_H */
+#ifdef HAVE_SASL_H
+#include <sasl.h>
+#endif /* HAVE_SASL_H */
+#ifdef HAVE_SASL_SASL_H
+#include <sasl/sasl.h>
+#endif /* HAVE_SASL_SASL_H */
 /* We are using deprecated functions, get the prototypes... */
 #define LDAP_DEPRECATED 1
 #include <ldap.h>
@@ -105,6 +115,13 @@ struct umich_ldap_info {
 				   looking up user groups */
 	int ldap_timeout;	/* Timeout in seconds for searches
 				   by ldap_search_st */
+	char *sasl_mech;	/* sasl mech to be used */
+	char *sasl_realm;	/* SASL realm for SASL authentication */
+	char *sasl_authcid;	/* authentication identity to be used  */
+	char *sasl_authzid;	/* authorization identity to be used */
+	char *sasl_secprops;	/* Cyrus SASL security properties. */
+	int sasl_canonicalize;	/* canonicalize LDAP server host name */
+	char *sasl_krb5_ccname;	/* krb5 ticket cache */
 };
 
 /* GLOBAL data */
@@ -122,6 +139,13 @@ static struct umich_ldap_info ldap_info = {
 	.tls_reqcert = LDAP_OPT_X_TLS_HARD,
 	.memberof_for_groups = 0,
 	.ldap_timeout = DEFAULT_UMICH_SEARCH_TIMEOUT,
+	.sasl_mech = NULL,
+	.sasl_realm = NULL,
+	.sasl_authcid = NULL,
+	.sasl_authzid = NULL,
+	.sasl_secprops = NULL,
+	.sasl_canonicalize = -1, /* leave to the LDAP lib */
+	.sasl_krb5_ccname = NULL,
 };
 
 static struct ldap_map_names ldap_map = {
@@ -138,6 +162,119 @@ static struct ldap_map_names ldap_map = {
 	.NFSv4_grouplist_filter = NULL,
 };
 
+#ifdef ENABLE_LDAP_SASL
+
+/**
+ * Set the path of the krb5 ticket cache
+ * use gss_krb5_ccache_name if available else set the env var
+ */
+static int set_krb5_ccname(const char *krb5_ccache_name)
+{
+	int retval = 0;
+#ifdef HAVE_GSS_KRB5_CCACHE_NAME
+	OM_uint32 status;
+
+	if (gss_krb5_ccache_name(&status, krb5_ccache_name, NULL) !=
+		GSS_S_COMPLETE) {
+		IDMAP_LOG(5,
+		  ("Failed to set creds cache for kerberos, minor_status(%d)",
+		   status));
+		retval = status;
+		goto out;
+	}
+#else /* HAVE_GSS_KRB5_CCACHE_NAME */
+	char *env;
+	int buflen = 0;
+
+	buflen = strlen("KRB5CCNAME=") + strlen(krb5_ccache_name) + 1;
+	env = malloc(buflen);
+	if (env == NULL) {
+		retval = ENOMEM;
+		goto out;
+	}
+	snprintf(env, buflen, "KRB5CCNAME=%s", krb5_ccache_name);
+	if (putenv(env) != 0) {
+		retval = errno;
+		IDMAP_LOG(5, ("Failed to set creds cache for kerberos, err(%d)",
+			      retval));
+	}
+#endif /* else HAVE_GSS_KRB5_CCACHE_NAME */
+out:
+	return retval;
+}
+
+/**
+ * SASL interact callback
+ */
+static int sasl_interact_cb(__attribute__((unused)) LDAP * ld,
+		__attribute__((unused)) unsigned int flags, void *defaults,
+		void *ctx)
+{
+	struct umich_ldap_info *linfo = defaults;
+	sasl_interact_t *interact = ctx;
+
+	while (interact->id != SASL_CB_LIST_END) {
+		switch (interact->id) {
+		case SASL_CB_AUTHNAME:
+			if (linfo->sasl_authcid == NULL ||
+			    linfo->sasl_authcid[0] == '\0') {
+				IDMAP_LOG(2, ("SASL_CB_AUTHNAME asked in "
+					    "callback but not found in conf"));
+			} else {
+				IDMAP_LOG(5,
+					  ("Setting SASL_CB_AUTHNAME to %s",
+					   linfo->sasl_authcid));
+				interact->result = linfo->sasl_authcid;
+				interact->len = strlen(linfo->sasl_authcid);
+			}
+			break;
+		case SASL_CB_PASS:
+			if (linfo->passwd == NULL || linfo->passwd[0] == '\0') {
+				IDMAP_LOG(2, ("SASL_CB_PASS asked in callback "
+					      "but not found in conf"));
+			} else {
+				IDMAP_LOG(5,
+					  ("Setting SASL_CB_PASS to ***"));
+				interact->result = linfo->passwd;
+				interact->len = strlen(linfo->passwd);
+			}
+			break;
+		case SASL_CB_GETREALM:
+			if (linfo->sasl_realm == NULL ||
+			    linfo->sasl_realm[0] == '\0') {
+				IDMAP_LOG(2, ("SASL_CB_GETREALM asked in "
+					    "callback but not found in conf"));
+			} else {
+				IDMAP_LOG(5,
+					  ("Setting SASL_CB_GETREALM to %s",
+					   linfo->sasl_realm));
+				interact->result = linfo->sasl_realm;
+				interact->len = strlen(linfo->sasl_realm);
+			}
+			break;
+		case SASL_CB_USER:
+			if (linfo->sasl_authzid == NULL ||
+			    linfo->sasl_authzid[0] == '\0') {
+				IDMAP_LOG(2, ("SASL_CB_USER asked in callback "
+					      "but not found in conf"));
+			} else {
+				IDMAP_LOG(5, ("Setting SASL_CB_USER to %s",
+					      linfo->sasl_authzid));
+				interact->result = linfo->sasl_authzid;
+				interact->len = strlen(linfo->sasl_authzid);
+			}
+			break;
+		default:
+			IDMAP_LOG(2, ("Undefined value requested %d",
+				      interact->id));
+			break;
+		}
+		interact++;
+	}
+	return LDAP_SUCCESS;
+}
+#endif /* ENABLE_LDAP_SASL */
+
 /* Local routines */
 
 static int
@@ -244,7 +381,57 @@ ldap_init_and_bind(LDAP **pld,
 	/* If we have a DN (and password) attempt an authenticated bind */
 	if (linfo->user_dn) {
 retry_bind:
+#ifdef ENABLE_LDAP_SASL
+		if (linfo->sasl_mech != NULL && linfo->sasl_mech[0] != '\0') {
+		/* use sasl bind */
+			if (linfo->sasl_canonicalize != -1) {
+				lerr = ldap_set_option(ld,
+						LDAP_OPT_X_SASL_NOCANON,
+						linfo->sasl_canonicalize ?
+						  LDAP_OPT_OFF : LDAP_OPT_ON);
+				if (lerr != LDAP_SUCCESS) {
+					IDMAP_LOG(2, ("ldap_init_and_bind: "
+						    "setting sasl_canonicalize"
+						    " failed: %s (%d)",
+						    ldap_err2string(lerr),
+						    lerr));
+					goto out;
+				}
+			}
+			if (linfo->sasl_secprops != NULL &&
+			    linfo->sasl_secprops[0] != '\0') {
+				lerr = ldap_set_option(ld,
+						LDAP_OPT_X_SASL_SECPROPS,
+						(void *) linfo->sasl_secprops);
+				if (lerr != LDAP_SUCCESS) {
+					IDMAP_LOG(2, ("ldap_init_and_bind: "
+						      "setting sasl_secprops"
+						      " failed: %s (%d)",
+						      ldap_err2string(lerr),
+						      lerr));
+					goto out;
+				}
+			}
+			if (linfo->sasl_krb5_ccname != NULL &&
+			    linfo->sasl_krb5_ccname[0] != '\0') {
+				lerr = set_krb5_ccname(linfo->sasl_krb5_ccname);
+				if (lerr != 0) {
+					IDMAP_LOG(2,
+						("ldap_init_and_bind: Failed "
+						 "to set krb5 ticket cache, "
+						 "err=%d", lerr));
+				}
+			}
+			lerr = ldap_sasl_interactive_bind_s(ld, linfo->user_dn,
+				linfo->sasl_mech, NULL, NULL, LDAP_SASL_QUIET,
+				sasl_interact_cb, linfo);
+		} else {
+			lerr = ldap_simple_bind_s(ld, linfo->user_dn,
+						  linfo->passwd);
+		}
+#else /* ENABLE_LDAP_SASL */
 		lerr = ldap_simple_bind_s(ld, linfo->user_dn, linfo->passwd);
+#endif /* else ENABLE_LDAP_SASL */
 		if (lerr) {
 			char *errmsg;
 			if (lerr == LDAP_PROTOCOL_ERROR) {
@@ -267,10 +454,22 @@ retry_bind:
 				}
 				goto retry_bind;
 			}
-			IDMAP_LOG(2, ("ldap_init_and_bind: ldap_simple_bind_s "
+#ifdef ENABLE_LDAP_SASL
+			IDMAP_LOG(2, ("ldap_init_and_bind: %s "
+				  "to [%s] as user '%s': %s (%d)",
+				  (linfo->sasl_mech != NULL &&
+				   linfo->sasl_mech[0] != '\0') ?
+				   "ldap_sasl_interactive_bind_s" :
+				   "ldap_simple_bind_s",
+				  server_url, linfo->user_dn,
+				  ldap_err2string(lerr), lerr));
+#else /* ENABLE_LDAP_SASL */
+			IDMAP_LOG(2, ("ldap_init_and_bind: ldap_simple_bind_s"
 				  "to [%s] as user '%s': %s (%d)",
 				  server_url, linfo->user_dn,
 				  ldap_err2string(lerr), lerr));
+
+#endif /* else ENABLE_LDAP_SASL */
 			if ((ldap_get_option(ld, LDAP_OPT_ERROR_STRING, &errmsg) == LDAP_SUCCESS)
 					&& (errmsg != NULL)&& (*errmsg != '\0')) {
 				IDMAP_LOG(2, ("ldap_init_and_bind: "
@@ -1155,6 +1354,30 @@ umichldap_init(void)
 				      (ldap_info.use_ssl) ?
 				      LDAPS_PORT : LDAP_PORT);
 
+	ldap_info.sasl_mech = conf_get_str(LDAP_SECTION, "LDAP_sasl_mech");
+	ldap_info.sasl_realm = conf_get_str(LDAP_SECTION, "LDAP_sasl_realm");
+	ldap_info.sasl_authcid = conf_get_str(LDAP_SECTION,
+					      "LDAP_sasl_authcid");
+	ldap_info.sasl_authzid = conf_get_str(LDAP_SECTION,
+					      "LDAP_sasl_authzid");
+	ldap_info.sasl_secprops = conf_get_str(LDAP_SECTION,
+					       "LDAP_sasl_secprops");
+
+	/* If it is not set let the ldap lib work with the lib default */
+	canonicalize = conf_get_str_with_def(LDAP_SECTION,
+					     "LDAP_sasl_canonicalize", "undef");
+	if ((strcasecmp(canonicalize, "true") == 0) ||
+	    (strcasecmp(canonicalize, "on") == 0) ||
+	    (strcasecmp(canonicalize, "yes") == 0)) {
+		ldap_info.sasl_canonicalize = 1;
+	} else if ((strcasecmp(canonicalize, "false") == 0) ||
+	    (strcasecmp(canonicalize, "off") == 0) ||
+	    (strcasecmp(canonicalize, "no") == 0)) {
+		ldap_info.sasl_canonicalize = 0;
+	}
+	ldap_info.sasl_krb5_ccname = conf_get_str(LDAP_SECTION,
+						  "LDAP_sasl_krb5_ccname");
+
 	/* Verify required information is supplied */
 	if (server_in == NULL || strlen(server_in) == 0)
 		strncat(missing_msg, "LDAP_server ", sizeof(missing_msg)-1);
@@ -1167,7 +1390,8 @@ umichldap_init(void)
 	}
 
 	ldap_info.server = server_in;
-	canonicalize = conf_get_str_with_def(LDAP_SECTION, "LDAP_canonicalize_name", "yes");
+	canonicalize = conf_get_str_with_def(LDAP_SECTION,
+					     "LDAP_canonicalize_name", "yes");
 	if ((strcasecmp(canonicalize, "true") == 0) ||
 	    (strcasecmp(canonicalize, "on") == 0) ||
 	    (strcasecmp(canonicalize, "yes") == 0)) {
@@ -1296,6 +1520,28 @@ umichldap_init(void)
 		  ldap_info.tls_reqcert));
 	IDMAP_LOG(1, ("umichldap_init: use_memberof_for_groups : %s",
 		  ldap_info.memberof_for_groups ? "yes" : "no"));
+	IDMAP_LOG(1, ("umichldap_init: sasl_mech: %s",
+		  (ldap_info.sasl_mech && strlen(ldap_info.sasl_mech) != 0) ?
+		  ldap_info.sasl_mech : "<not-supplied>"));
+	IDMAP_LOG(1, ("umichldap_init: sasl_realm: %s",
+		  (ldap_info.sasl_realm && strlen(ldap_info.sasl_realm) != 0) ?
+		  ldap_info.sasl_realm : "<not-supplied>"));
+	IDMAP_LOG(1, ("umichldap_init: sasl_authcid: %s",
+		  (ldap_info.sasl_authcid &&
+		   strlen(ldap_info.sasl_authcid) != 0) ?
+		  ldap_info.sasl_authcid : "<not-supplied>"));
+	IDMAP_LOG(1, ("umichldap_init: sasl_authzid: %s",
+		  (ldap_info.sasl_authzid &&
+		   strlen(ldap_info.sasl_authzid) != 0) ?
+		  ldap_info.sasl_authzid : "<not-supplied>"));
+	IDMAP_LOG(1, ("umichldap_init: sasl_secprops: %s",
+		  (ldap_info.sasl_secprops &&
+		   strlen(ldap_info.sasl_secprops) != 0) ?
+		  ldap_info.sasl_secprops : "<not-supplied>"));
+	IDMAP_LOG(1, ("umichldap_init: sasl_canonicalize: %d",
+		      ldap_info.sasl_canonicalize));
+	IDMAP_LOG(1, ("umichldap_init: sasl_krb5_ccname: %s",
+		      ldap_info.sasl_krb5_ccname));
 
 	IDMAP_LOG(1, ("umichldap_init: NFSv4_person_objectclass : %s",
 		  ldap_map.NFSv4_person_objcls));
-- 
2.25.1

