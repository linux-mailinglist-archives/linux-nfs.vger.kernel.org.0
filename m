Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD90A1991D8
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2020 11:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbgCaJVw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Mar 2020 05:21:52 -0400
Received: from edge10s.ethz.ch ([82.130.75.187]:55708 "EHLO edge10s.ethz.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731018AbgCaJIo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 31 Mar 2020 05:08:44 -0400
Received: from osaka.inf.ethz.ch (129.132.10.50) by edge10s.ethz.ch
 (82.130.75.187) with Microsoft SMTP Server id 14.3.487.0; Tue, 31 Mar 2020
 11:02:36 +0200
Received: by osaka.inf.ethz.ch (Postfix, from userid 50515)     id D56A4B7279;
 Tue, 31 Mar 2020 11:02:37 +0200 (CEST)
Date:   Tue, 31 Mar 2020 11:02:37 +0200
To:     <linux-nfs@vger.kernel.org>
Subject: [PATCH] Add regex plugin for nfsidmap
User-Agent: Heirloom mailx 12.5 7/5/10
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-ID: <20200331090237.D56A4B7279@osaka.inf.ethz.ch>
From:   Stefan Walter <walteste@inf.ethz.ch>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The patch below adds a new nfsidmap plugin that uses regex to extract
ids from NFSv4 names. Names are created from ids by pre- and appending
static strings. It works with both idmapd on servers and nfsidmap on
clients.

This plugin is especially useful in environments with Active Directory
where distributed NFS servers use a mix of short (uname) and long
(domain\uname) names. Combining it with the nsswitch plugin covers both
variants.

Currently this plugin has its own git project on github but I think
it could be helpful if it would be incorporated in the main nfs-utils
plugin set.

---
 support/nfsidmap/Makefile.am   |   6 +-
 support/nfsidmap/idmapd.conf.5 |  66 +++-
 support/nfsidmap/regex.c       | 548 +++++++++++++++++++++++++++++++++
 3 files changed, 617 insertions(+), 3 deletions(-)
 create mode 100644 support/nfsidmap/regex.c

diff --git a/support/nfsidmap/Makefile.am b/support/nfsidmap/Makefile.am
index 9c21fa34..35575a95 100644
--- a/support/nfsidmap/Makefile.am
+++ b/support/nfsidmap/Makefile.am
@@ -15,7 +15,7 @@ else
 GUMS_MAPPING_LIB =
 endif
 lib_LTLIBRARIES = libnfsidmap.la
-pkgplugin_LTLIBRARIES = nsswitch.la static.la $(UMICH_LDAP_LIB) $(GUMS_MAPPING_LIB)
+pkgplugin_LTLIBRARIES = nsswitch.la static.la regex.la $(UMICH_LDAP_LIB) $(GUMS_MAPPING_LIB)
 
 # Library versioning notes from:
 #  http://sources.redhat.com/autobook/autobook/autobook_91.html
@@ -41,6 +41,10 @@ static_la_SOURCES = static.c
 static_la_LDFLAGS = -module -avoid-version
 static_la_LIBADD = ../../support/nfs/libnfsconf.la
 
+regex_la_SOURCES = regex.c
+regex_la_LDFLAGS = -module -avoid-version
+regex_la_LIBADD = ../../support/nfs/libnfsconf.la
+
 umich_ldap_la_SOURCES = umich_ldap.c
 umich_ldap_la_LDFLAGS = -module -avoid-version
 umich_ldap_la_LIBADD = -lldap ../../support/nfs/libnfsconf.la
diff --git a/support/nfsidmap/idmapd.conf.5 b/support/nfsidmap/idmapd.conf.5
index 61fbb613..e554a44e 100644
--- a/support/nfsidmap/idmapd.conf.5
+++ b/support/nfsidmap/idmapd.conf.5
@@ -151,6 +151,58 @@ names to local user names.  Entries in the list are of the form:
 .fi
 .\"
 .\" -------------------------------------------------------------------
+.\" The [REGEX] section
+.\" -------------------------------------------------------------------
+.\"
+.SS "[REGEX] section variables"
+.nf
+
+.fi
+If the "regex" translation method is specified, the following
+variables within the [REGEX] section are used to map between NFS4 names and local IDs.
+.TP
+.B User-Regex
+Case-insensitive regular expression that extracts the local user name from an NFSv4 name. Multiple expressions may be concatenated with '|'. The first match will be used.
+There is no default. A basic regular expression for domain DOMAIN.ORG and realm MY.DOMAIN.ORG would be:
+.nf
+^DOMAIN\\([^@]+)@MY.DOMAIN.ORG$
+.fi
+.TP
+.B Group-Regex
+Case-insensitive regular expression that extracts the local group name from an NFSv4 name. Multiple expressions may be concatenated with '|'. The first match will be used.
+There is no default. A basic regular expression for domain DOMAIN.ORG and realm MY.DOMAIN.ORG would be:
+.nf
+^([^@]+)@DOMAIN.ORG@MY.DOMAIN.ORG$|^DOMAIN\\([^@]+)@MY.DOMAIN.ORG$
+.fi
+.TP
+.B Prepend-Before-User
+Constant string to put before a local user name when building an NFSv4 name. Usually this is the short domain name followed by '\'.
+(Default: none)
+.TP
+.B Append-After-User
+Constant string to put after a local user name when building an NFSv4 name. Usually this is '@' followed by the default realm.
+(Default: none)
+.TP
+.B Prepend-Before-Group
+Constant string to put before a local group name when building an NFSv4 name. Usually not used.
+(Default: none)
+.TP
+.B Append-After-Group
+Constant string to put before a local group name when building an NFSv4 name. Usually this is '@' followed by the domain name followed by another '@' and the default realm.
+(Default: none)
+.TP
+.B Group-Name-Prefix
+Constant string that is prepended to a local group name when converting it to an NFSv4 name. If an NFSv4 group name has this prefix it is removed when converting it to a local group name.
+With this group names of a central directory can be shortened for an isolated organizational unit if all groups have a common prefix.
+(Default: none)
+.TP
+.B Group-Name-No-Prefix-Regex
+Case-insensitive regular expression to exclude groups from adding and removing the prefix set by
+.B Group-Name-Prefix
+. The regular expression must match both the remote and local group names. Multiple expressions may be concatenated with '|'.
+(Default: none)
+.\"
+.\" -------------------------------------------------------------------
 .\" The [UMICH_SCHEMA] section
 .\" -------------------------------------------------------------------
 .\"
@@ -286,13 +338,23 @@ Nobody-Group = nfsnobody
 
 [Translation]
 
-Method = umich_ldap,nsswitch
-GSS-Methods = umich_ldap,static
+Method = umich_ldap,regex,nsswitch
+GSS-Methods = umich_ldap,regex,static
 
 [Static]
 
 johndoe@OTHER.DOMAIN.ORG = johnny
 
+[Regex]
+
+User-Regex = ^DOMAIN\\([^@]+)@DOMAIN.ORG$
+Group-Regex = ^([^@]+)@DOMAIN.ORG@DOMAIN.ORG$|^DOMAIN\\([^@]+)@DOMAIN.ORG$
+Prepend-Before-User = DOMAIN\ 
+Append-After-User = @DOMAIN.ORG
+Append-After-Group = @domain.org@domain.org
+Group-Name-Prefix = sales-
+Group-Name-No-Prefix-Regex = -personal-group$
+
 [UMICH_SCHEMA]
 
 LDAP_server = ldap.domain.org
diff --git a/support/nfsidmap/regex.c b/support/nfsidmap/regex.c
new file mode 100644
index 00000000..3a793152
--- /dev/null
+++ b/support/nfsidmap/regex.c
@@ -0,0 +1,548 @@
+/*
+ *  regex.c
+ *
+ *  regex idmapping functions.
+ *
+ *  Copyright (c) 2017-2020 Stefan Walter <stefan.walter@inf.ethz.ch>.
+ *  Copyright (c) 2008 David Härdeman <david@hardeman.nu>.
+ *  All rights reserved.
+ *
+ *  Redistribution and use in source and binary forms, with or without
+ *  modification, are permitted provided that the following conditions
+ *  are met:
+ *
+ *  1. Redistributions of source code must retain the above copyright
+ *     notice, this list of conditions and the following disclaimer.
+ *  2. Redistributions in binary form must reproduce the above copyright
+ *     notice, this list of conditions and the following disclaimer in the
+ *     documentation and/or other materials provided with the distribution.
+ *  3. Neither the name of the University nor the names of its
+ *     contributors may be used to endorse or promote products derived
+ *     from this software without specific prior written permission.
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ *  DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
+ *  FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ *  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ *  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ *  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
+ *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <pwd.h>
+#include <grp.h>
+#include <errno.h>
+#include <err.h>
+#include <regex.h>
+
+#include "nfsidmap.h"
+#include "nfsidmap_plugin.h"
+
+#define CONFIG_GET_STRING nfsidmap_config_get
+extern const char *nfsidmap_config_get(const char *, const char *);
+
+#define MAX_MATCHES 100
+
+regex_t group_re;
+regex_t user_re;
+regex_t gpx_re;
+int use_gpx;
+const char * group_prefix;
+const char * group_name_prefix;
+const char * group_suffix;
+const char * user_prefix;
+const char * user_suffix;
+const char * group_map_file;
+const char * group_map_section;
+char empty = '\0';
+size_t group_name_prefix_length;
+
+struct pwbuf {
+        struct passwd pwbuf;
+        char buf[1];
+};
+
+struct grbuf {
+        struct group grbuf;
+        char buf[1];
+};
+
+static char *get_default_domain(void)
+{
+        static char default_domain[NFS4_MAX_DOMAIN_LEN] = "";
+        if (default_domain[0] == 0) {
+                nfs4_get_default_domain(NULL, default_domain, NFS4_MAX_DOMAIN_LEN);
+        }
+        return default_domain;
+}
+
+/*
+ * Regexp Translation Methods
+ *
+ */
+
+static struct passwd *regex_getpwnam(const char *name, const char *UNUSED(domain),
+				      int *err_p)
+{
+	struct passwd *pw;
+	struct pwbuf *buf;
+	size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	char *localname;
+	size_t namelen;
+	int err;
+	int status;
+	int index;
+	regmatch_t matches[MAX_MATCHES];
+
+	buf = malloc(sizeof(*buf) + buflen);
+	if (!buf) {
+		err = ENOMEM;
+		goto err;
+	}
+
+	status = regexec(&user_re, name, MAX_MATCHES, matches, 0);
+	if (status) {
+		IDMAP_LOG(4, ("regexp_getpwnam: user '%s' did not match regex", name));
+		err = ENOENT;
+		goto err_free_buf;
+	}
+
+	for (index = 1; index < MAX_MATCHES ; index++)
+	{
+		if (matches[index].rm_so >= 0)
+			break;
+	}
+
+	if (index == MAX_MATCHES) {
+		IDMAP_LOG(4, ("regexp_getpwnam: user '%s' did not match regex", name));
+		err = ENOENT;
+		goto err_free_buf;
+	}
+
+	namelen = matches[index].rm_eo - matches[index].rm_so;
+	localname= malloc(namelen + 1);
+	if (!localname)
+	{
+		err = ENOMEM;
+		goto err_free_buf;
+	}
+	strncpy(localname, name+matches[index].rm_so, namelen);
+	localname[namelen] = '\0';
+
+again:
+	err = getpwnam_r(localname, &buf->pwbuf, buf->buf, buflen, &pw);
+
+	if (err == EINTR)
+		goto again;
+
+	if (!pw) {
+		if (err == 0)
+			err = ENOENT;
+
+		IDMAP_LOG(4, ("regex_getpwnam: local user '%s' for '%s' not found",
+		  localname, name));
+
+		goto err_free_name;
+	}
+
+	IDMAP_LOG(4, ("regexp_getpwnam: name '%s' mapped to '%s'",
+		  name, localname));
+
+	*err_p = 0;
+	return pw;
+
+err_free_name:
+	free(localname);
+err_free_buf:
+	free(buf);
+err:
+	*err_p = err;
+	return NULL;
+}
+
+static struct group *regex_getgrnam(const char *name, const char *UNUSED(domain),
+				      int *err_p)
+{
+	struct group *gr;
+	struct grbuf *buf;
+	size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
+	char *localgroup;
+	char *groupname;
+	size_t namelen;
+	int err = 0;
+	int index;
+	int status;
+	regmatch_t matches[MAX_MATCHES];
+
+	buf = malloc(sizeof(*buf) + buflen);
+	if (!buf) {
+		err = ENOMEM;
+		goto err;
+	}
+
+	status = regexec(&group_re, name, MAX_MATCHES, matches, 0);
+	if (status) {
+		IDMAP_LOG(4, ("regexp_getgrnam: group '%s' did not match regex", name));
+		err = ENOENT;
+		goto err_free_buf;
+	}
+
+	for (index = 1; index < MAX_MATCHES ; index++)
+	{
+		if (matches[index].rm_so >= 0)
+			break;
+	}
+
+	if (index == MAX_MATCHES) {
+		IDMAP_LOG(4, ("regexp_getgrnam: group '%s' did not match regex", name));
+		err = ENOENT;
+		goto err_free_buf;
+	}
+
+	namelen = matches[index].rm_eo - matches[index].rm_so;
+	localgroup = malloc(namelen + 1);
+	if (!localgroup)
+	{
+		err = ENOMEM;
+		goto err_free_buf;
+	}
+	strncpy(localgroup, name+matches[index].rm_so, namelen);
+	localgroup[namelen] = '\0';
+
+	IDMAP_LOG(4, ("regexp_getgrnam: group '%s' after match of regex", localgroup));
+
+        groupname = localgroup;
+    	if (group_name_prefix_length && ! strncmp(group_name_prefix, localgroup, group_name_prefix_length))
+	{
+		err = 1;
+		if (use_gpx)
+			err = regexec(&gpx_re, localgroup, 0, NULL, 0);
+
+		if (err)
+		{
+			IDMAP_LOG(4, ("regexp_getgrnam: removing prefix '%s' (%d long) from group '%s'", group_name_prefix, group_name_prefix_length, localgroup));
+				groupname += group_name_prefix_length;
+		}
+		else
+		{
+			IDMAP_LOG(4, ("regexp_getgrnam: not removing prefix from group '%s'", localgroup));
+		}
+	}
+
+	IDMAP_LOG(4, ("regexp_getgrnam: will use '%s'", groupname));
+
+again:
+	err = getgrnam_r(groupname, &buf->grbuf, buf->buf, buflen, &gr);
+
+	if (err == EINTR)
+		goto again;
+
+	if (!gr) {
+		if (err == 0)
+			err = ENOENT;
+
+		IDMAP_LOG(4, ("regex_getgrnam: local group '%s' for '%s' not found", groupname, name));
+
+		goto err_free_name;
+	}
+
+	IDMAP_LOG(4, ("regex_getgrnam: group '%s' mapped to '%s'", name, groupname));
+
+	free(localgroup);
+
+	*err_p = 0;
+	return gr;
+
+err_free_name:
+	free(localgroup);
+err_free_buf:
+	free(buf);
+err:
+	*err_p = err;
+	return NULL;
+}
+
+static int regex_gss_princ_to_ids(char *secname, char *princ,
+				   uid_t *uid, uid_t *gid,
+				   extra_mapping_params **UNUSED(ex))
+{
+	struct passwd *pw;
+	int err;
+
+	/* XXX: Is this necessary? */
+	if (strcmp(secname, "krb5") != 0 && strcmp(secname, "spkm3") != 0)
+		return -EINVAL;
+
+	pw = regex_getpwnam(princ, NULL, &err);
+
+	if (pw) {
+		*uid = pw->pw_uid;
+		*gid = pw->pw_gid;
+		free(pw);
+	}
+
+	return -err;
+}
+
+static int regex_gss_princ_to_grouplist(char *secname, char *princ,
+					 gid_t *groups, int *ngroups,
+					 extra_mapping_params **UNUSED(ex))
+{
+	struct passwd *pw;
+	int err;
+
+	/* XXX: Is this necessary? */
+	if (strcmp(secname, "krb5") != 0 && strcmp(secname, "spkm3") != 0)
+		return -EINVAL;
+
+	pw = regex_getpwnam(princ, NULL, &err);
+
+	if (pw) {
+		if (getgrouplist(pw->pw_name, pw->pw_gid, groups, ngroups) < 0)
+			err = -ERANGE;
+		free(pw);
+	}
+
+	return -err;
+}
+
+static int regex_name_to_uid(char *name, uid_t *uid)
+{
+	struct passwd *pw;
+	int err;
+
+	pw = regex_getpwnam(name, NULL, &err);
+
+	if (pw) {
+		*uid = pw->pw_uid;
+		free(pw);
+	}
+
+	return -err;
+}
+
+static int regex_name_to_gid(char *name, gid_t *gid)
+{
+	struct group *gr;
+	int err;
+
+	gr = regex_getgrnam(name, NULL, &err);
+
+	if (gr) {
+		*gid = gr->gr_gid;
+		free(gr);
+	}
+
+	return -err;
+}
+
+static int write_name(char *dest, char *localname, const char* name_prefix, const char *prefix, const char *suffix, size_t len)
+{
+	if (strlen(localname) + strlen(name_prefix) + strlen(prefix) + strlen(suffix) + 1 > len) {
+		return -ENOMEM; /* XXX: Is there an -ETOOLONG? */
+	}
+	strcpy(dest, prefix);
+	strcat(dest, name_prefix);
+	strcat(dest, localname);
+	strcat(dest, suffix);
+
+   	IDMAP_LOG(4, ("write_name: will use '%s'", dest));
+
+	return 0;
+}
+
+static int regex_uid_to_name(uid_t uid, char *domain, char *name, size_t len)
+{
+	struct passwd *pw = NULL;
+	struct passwd pwbuf;
+	char *buf;
+	size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	int err = -ENOMEM;
+
+	buf = malloc(buflen);
+	if (!buf)
+		goto out;
+	if (domain == NULL)
+		domain = get_default_domain();
+	err = -getpwuid_r(uid, &pwbuf, buf, buflen, &pw);
+	if (pw == NULL)
+		err = -ENOENT;
+	if (err)
+		goto out_buf;
+	err = write_name(name, pw->pw_name, &empty, user_prefix, user_suffix, len);
+out_buf:
+	free(buf);
+out:
+	return err;
+}
+
+static int regex_gid_to_name(gid_t gid, char *UNUSED(domain), char *name, size_t len)
+{
+	struct group *gr = NULL;
+	struct group grbuf;
+	char *buf;
+    const char *name_prefix;
+	size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
+	int err;
+    char * groupname = NULL;
+
+	do {
+		err = -ENOMEM;
+		buf = malloc(buflen);
+		if (!buf)
+			goto out;
+		err = -getgrgid_r(gid, &grbuf, buf, buflen, &gr);
+		if (gr == NULL && !err)
+			err = -ENOENT;
+		if (err == -ERANGE) {
+			buflen *= 2;
+			free(buf);
+		}
+	} while (err == -ERANGE);
+
+	if (err)
+		goto out_buf;
+
+	groupname = gr->gr_name;
+    	name_prefix = group_name_prefix;
+    	if (group_name_prefix_length)
+        {
+            if(! strncmp(group_name_prefix, groupname, group_name_prefix_length))
+            {
+			    name_prefix = &empty;
+            }
+            else if (use_gpx)
+            {
+	            err = regexec(&gpx_re, groupname, 0, NULL, 0);
+	            if (!err)
+                {
+   			        IDMAP_LOG(4, ("regex_gid_to_name: not adding prefix to group '%s'", groupname));
+			        name_prefix = &empty;
+                }
+            }
+	}
+      
+	err = write_name(name, groupname, name_prefix, group_prefix, group_suffix, len);
+
+out_buf:
+	free(buf);
+out:
+	return err;
+}
+
+static int regex_init(void) {	
+	const char *string;
+	int status;
+
+
+        string = CONFIG_GET_STRING("Regex", "User-Regex");
+	if (!string)
+	{
+		warnx("regex_init: regex for user mapping missing");
+		goto error1;
+	}
+    
+	status = regcomp(&user_re, string, REG_EXTENDED|REG_ICASE); 
+	if (status)
+	{
+		warnx("regex_init: compiling regex for user mapping failed with status %u", status);
+		goto error1;
+	}
+
+	string = CONFIG_GET_STRING("Regex", "Group-Regex");
+	if (!string)
+	{
+		warnx("regex_init: regex for group mapping missing");
+		goto error2;
+	}
+    
+    status = regcomp(&group_re, string, REG_EXTENDED|REG_ICASE); 
+    if (status)
+    {
+		warnx("regex_init: compiling regex for group mapping failed with status %u", status);
+		goto error2;
+    }
+
+	group_name_prefix = CONFIG_GET_STRING("Regex", "Group-Name-Prefix");
+    if (!group_name_prefix)
+    {
+        group_name_prefix = &empty;
+    }
+    group_name_prefix_length = strlen(group_name_prefix);
+
+    user_prefix = CONFIG_GET_STRING("Regex", "Prepend-Before-User");
+    if (!user_prefix)
+    {
+        user_prefix = &empty;
+    }
+
+    user_suffix = CONFIG_GET_STRING("Regex", "Append-After-User"); 
+    if (!user_suffix)
+    {
+        user_suffix = &empty;
+    }
+
+    group_prefix = CONFIG_GET_STRING("Regex", "Prepend-Before-Group"); 
+    if (!group_prefix)
+    {
+        group_prefix = &empty;
+    }
+
+    group_suffix = CONFIG_GET_STRING("Regex", "Append-After-Group"); 
+    if (!group_suffix)
+    {
+        group_suffix = &empty;
+    }
+
+    string = CONFIG_GET_STRING("Regex", "Group-Name-No-Prefix-Regex");
+    use_gpx = 0;
+    if (string)
+    {
+        status = regcomp(&gpx_re, string, REG_EXTENDED|REG_ICASE); 
+
+        if (status)
+        {
+	    	warnx("regex_init: compiling regex for group prefix exclusion failed with status %u", status);
+		    goto error3;
+        }
+
+        use_gpx = 1;
+    }
+
+    return 0;
+
+error3:
+	regfree(&group_re);
+error2:
+	regfree(&user_re);
+error1:
+	return 0;
+ /* return -EINVAL; */
+}
+
+
+struct trans_func regex_trans = {
+	.name			= "regex",
+	.init			= regex_init,
+	.name_to_uid		= regex_name_to_uid,
+	.name_to_gid		= regex_name_to_gid,
+	.uid_to_name		= regex_uid_to_name,
+	.gid_to_name		= regex_gid_to_name,
+	.princ_to_ids		= regex_gss_princ_to_ids,
+	.gss_princ_to_grouplist	= regex_gss_princ_to_grouplist,
+};
+
+struct trans_func *libnfsidmap_plugin_init()
+{
+	return (&regex_trans);
+}
+
-- 
2.25.1

