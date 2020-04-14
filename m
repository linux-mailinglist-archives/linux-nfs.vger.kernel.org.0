Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F9D1A7FA5
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2020 16:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgDNOZa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Apr 2020 10:25:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58516 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728850AbgDNOZ1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Apr 2020 10:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586874323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rpUGHT0RI67PZglh57oLAA8rtaOtTmoZvwJSQMUdCI4=;
        b=hbf4+n0SJVFlUi9yey4m79Pec2HFv1Pro4lcOxtT4r+ZezQl0o7p/UsdZvn48m8X0UsEoM
        HTA+n4JX42Hmx1U1GIZdMNgyQgMrw4Uw2ApLWv56r2cnwYjlsiQv6tKfMkqmGXQS4eoOkp
        FmnMZjknftxa/zDWbwto0TSy9TnYsXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-H1RVsD37OWSg_g23vc9-fw-1; Tue, 14 Apr 2020 10:25:00 -0400
X-MC-Unique: H1RVsD37OWSg_g23vc9-fw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32A2DDBA3;
        Tue, 14 Apr 2020 14:24:59 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-136.phx2.redhat.com [10.3.113.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7DC060BE1;
        Tue, 14 Apr 2020 14:24:58 +0000 (UTC)
Subject: Re: [PATCH] Add regex plugin for nfsidmap
To:     Stefan Walter <walteste@inf.ethz.ch>, linux-nfs@vger.kernel.org
References: <20200331090237.D56A4B7279@osaka.inf.ethz.ch>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <925d5e58-f993-ada8-14b9-eb7d57201b87@RedHat.com>
Date:   Tue, 14 Apr 2020 10:24:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200331090237.D56A4B7279@osaka.inf.ethz.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/31/20 5:02 AM, Stefan Walter wrote:
> The patch below adds a new nfsidmap plugin that uses regex to extract
> ids from NFSv4 names. Names are created from ids by pre- and appending
> static strings. It works with both idmapd on servers and nfsidmap on
> clients.
>=20
> This plugin is especially useful in environments with Active Directory
> where distributed NFS servers use a mix of short (uname) and long
> (domain\uname) names. Combining it with the nsswitch plugin covers both
> variants.
>=20
> Currently this plugin has its own git project on github but I think
> it could be helpful if it would be incorporated in the main nfs-utils
> plugin set.
Committed... (tag: nfs-utils-2-4-4-rc3)

steved.

>=20
> ---
>  support/nfsidmap/Makefile.am   |   6 +-
>  support/nfsidmap/idmapd.conf.5 |  66 +++-
>  support/nfsidmap/regex.c       | 548 +++++++++++++++++++++++++++++++++
>  3 files changed, 617 insertions(+), 3 deletions(-)
>  create mode 100644 support/nfsidmap/regex.c
>=20
> diff --git a/support/nfsidmap/Makefile.am b/support/nfsidmap/Makefile.a=
m
> index 9c21fa34..35575a95 100644
> --- a/support/nfsidmap/Makefile.am
> +++ b/support/nfsidmap/Makefile.am
> @@ -15,7 +15,7 @@ else
>  GUMS_MAPPING_LIB =3D
>  endif
>  lib_LTLIBRARIES =3D libnfsidmap.la
> -pkgplugin_LTLIBRARIES =3D nsswitch.la static.la $(UMICH_LDAP_LIB) $(GU=
MS_MAPPING_LIB)
> +pkgplugin_LTLIBRARIES =3D nsswitch.la static.la regex.la $(UMICH_LDAP_=
LIB) $(GUMS_MAPPING_LIB)
> =20
>  # Library versioning notes from:
>  #  http://sources.redhat.com/autobook/autobook/autobook_91.html
> @@ -41,6 +41,10 @@ static_la_SOURCES =3D static.c
>  static_la_LDFLAGS =3D -module -avoid-version
>  static_la_LIBADD =3D ../../support/nfs/libnfsconf.la
> =20
> +regex_la_SOURCES =3D regex.c
> +regex_la_LDFLAGS =3D -module -avoid-version
> +regex_la_LIBADD =3D ../../support/nfs/libnfsconf.la
> +
>  umich_ldap_la_SOURCES =3D umich_ldap.c
>  umich_ldap_la_LDFLAGS =3D -module -avoid-version
>  umich_ldap_la_LIBADD =3D -lldap ../../support/nfs/libnfsconf.la
> diff --git a/support/nfsidmap/idmapd.conf.5 b/support/nfsidmap/idmapd.c=
onf.5
> index 61fbb613..e554a44e 100644
> --- a/support/nfsidmap/idmapd.conf.5
> +++ b/support/nfsidmap/idmapd.conf.5
> @@ -151,6 +151,58 @@ names to local user names.  Entries in the list ar=
e of the form:
>  .fi
>  .\"
>  .\" ------------------------------------------------------------------=
-
> +.\" The [REGEX] section
> +.\" ------------------------------------------------------------------=
-
> +.\"
> +.SS "[REGEX] section variables"
> +.nf
> +
> +.fi
> +If the "regex" translation method is specified, the following
> +variables within the [REGEX] section are used to map between NFS4 name=
s and local IDs.
> +.TP
> +.B User-Regex
> +Case-insensitive regular expression that extracts the local user name =
from an NFSv4 name. Multiple expressions may be concatenated with '|'. Th=
e first match will be used.
> +There is no default. A basic regular expression for domain DOMAIN.ORG =
and realm MY.DOMAIN.ORG would be:
> +.nf
> +^DOMAIN\\([^@]+)@MY.DOMAIN.ORG$
> +.fi
> +.TP
> +.B Group-Regex
> +Case-insensitive regular expression that extracts the local group name=
 from an NFSv4 name. Multiple expressions may be concatenated with '|'. T=
he first match will be used.
> +There is no default. A basic regular expression for domain DOMAIN.ORG =
and realm MY.DOMAIN.ORG would be:
> +.nf
> +^([^@]+)@DOMAIN.ORG@MY.DOMAIN.ORG$|^DOMAIN\\([^@]+)@MY.DOMAIN.ORG$
> +.fi
> +.TP
> +.B Prepend-Before-User
> +Constant string to put before a local user name when building an NFSv4=
 name. Usually this is the short domain name followed by '\'.
> +(Default: none)
> +.TP
> +.B Append-After-User
> +Constant string to put after a local user name when building an NFSv4 =
name. Usually this is '@' followed by the default realm.
> +(Default: none)
> +.TP
> +.B Prepend-Before-Group
> +Constant string to put before a local group name when building an NFSv=
4 name. Usually not used.
> +(Default: none)
> +.TP
> +.B Append-After-Group
> +Constant string to put before a local group name when building an NFSv=
4 name. Usually this is '@' followed by the domain name followed by anoth=
er '@' and the default realm.
> +(Default: none)
> +.TP
> +.B Group-Name-Prefix
> +Constant string that is prepended to a local group name when convertin=
g it to an NFSv4 name. If an NFSv4 group name has this prefix it is remov=
ed when converting it to a local group name.
> +With this group names of a central directory can be shortened for an i=
solated organizational unit if all groups have a common prefix.
> +(Default: none)
> +.TP
> +.B Group-Name-No-Prefix-Regex
> +Case-insensitive regular expression to exclude groups from adding and =
removing the prefix set by
> +.B Group-Name-Prefix
> +. The regular expression must match both the remote and local group na=
mes. Multiple expressions may be concatenated with '|'.
> +(Default: none)
> +.\"
> +.\" ------------------------------------------------------------------=
-
>  .\" The [UMICH_SCHEMA] section
>  .\" ------------------------------------------------------------------=
-
>  .\"
> @@ -286,13 +338,23 @@ Nobody-Group =3D nfsnobody
> =20
>  [Translation]
> =20
> -Method =3D umich_ldap,nsswitch
> -GSS-Methods =3D umich_ldap,static
> +Method =3D umich_ldap,regex,nsswitch
> +GSS-Methods =3D umich_ldap,regex,static
> =20
>  [Static]
> =20
>  johndoe@OTHER.DOMAIN.ORG =3D johnny
> =20
> +[Regex]
> +
> +User-Regex =3D ^DOMAIN\\([^@]+)@DOMAIN.ORG$
> +Group-Regex =3D ^([^@]+)@DOMAIN.ORG@DOMAIN.ORG$|^DOMAIN\\([^@]+)@DOMAI=
N.ORG$
> +Prepend-Before-User =3D DOMAIN\=20
> +Append-After-User =3D @DOMAIN.ORG
> +Append-After-Group =3D @domain.org@domain.org
> +Group-Name-Prefix =3D sales-
> +Group-Name-No-Prefix-Regex =3D -personal-group$
> +
>  [UMICH_SCHEMA]
> =20
>  LDAP_server =3D ldap.domain.org
> diff --git a/support/nfsidmap/regex.c b/support/nfsidmap/regex.c
> new file mode 100644
> index 00000000..3a793152
> --- /dev/null
> +++ b/support/nfsidmap/regex.c
> @@ -0,0 +1,548 @@
> +/*
> + *  regex.c
> + *
> + *  regex idmapping functions.
> + *
> + *  Copyright (c) 2017-2020 Stefan Walter <stefan.walter@inf.ethz.ch>.
> + *  Copyright (c) 2008 David H=C3=A4rdeman <david@hardeman.nu>.
> + *  All rights reserved.
> + *
> + *  Redistribution and use in source and binary forms, with or without
> + *  modification, are permitted provided that the following conditions
> + *  are met:
> + *
> + *  1. Redistributions of source code must retain the above copyright
> + *     notice, this list of conditions and the following disclaimer.
> + *  2. Redistributions in binary form must reproduce the above copyrig=
ht
> + *     notice, this list of conditions and the following disclaimer in=
 the
> + *     documentation and/or other materials provided with the distribu=
tion.
> + *  3. Neither the name of the University nor the names of its
> + *     contributors may be used to endorse or promote products derived
> + *     from this software without specific prior written permission.
> + *
> + *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
> + *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES =
OF
> + *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
> + *  DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABL=
E
> + *  FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> + *  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT =
OF
> + *  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
> + *  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
> + *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDI=
NG
> + *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
> + *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/types.h>
> +#include <pwd.h>
> +#include <grp.h>
> +#include <errno.h>
> +#include <err.h>
> +#include <regex.h>
> +
> +#include "nfsidmap.h"
> +#include "nfsidmap_plugin.h"
> +
> +#define CONFIG_GET_STRING nfsidmap_config_get
> +extern const char *nfsidmap_config_get(const char *, const char *);
> +
> +#define MAX_MATCHES 100
> +
> +regex_t group_re;
> +regex_t user_re;
> +regex_t gpx_re;
> +int use_gpx;
> +const char * group_prefix;
> +const char * group_name_prefix;
> +const char * group_suffix;
> +const char * user_prefix;
> +const char * user_suffix;
> +const char * group_map_file;
> +const char * group_map_section;
> +char empty =3D '\0';
> +size_t group_name_prefix_length;
> +
> +struct pwbuf {
> +        struct passwd pwbuf;
> +        char buf[1];
> +};
> +
> +struct grbuf {
> +        struct group grbuf;
> +        char buf[1];
> +};
> +
> +static char *get_default_domain(void)
> +{
> +        static char default_domain[NFS4_MAX_DOMAIN_LEN] =3D "";
> +        if (default_domain[0] =3D=3D 0) {
> +                nfs4_get_default_domain(NULL, default_domain, NFS4_MAX=
_DOMAIN_LEN);
> +        }
> +        return default_domain;
> +}
> +
> +/*
> + * Regexp Translation Methods
> + *
> + */
> +
> +static struct passwd *regex_getpwnam(const char *name, const char *UNU=
SED(domain),
> +				      int *err_p)
> +{
> +	struct passwd *pw;
> +	struct pwbuf *buf;
> +	size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> +	char *localname;
> +	size_t namelen;
> +	int err;
> +	int status;
> +	int index;
> +	regmatch_t matches[MAX_MATCHES];
> +
> +	buf =3D malloc(sizeof(*buf) + buflen);
> +	if (!buf) {
> +		err =3D ENOMEM;
> +		goto err;
> +	}
> +
> +	status =3D regexec(&user_re, name, MAX_MATCHES, matches, 0);
> +	if (status) {
> +		IDMAP_LOG(4, ("regexp_getpwnam: user '%s' did not match regex", name=
));
> +		err =3D ENOENT;
> +		goto err_free_buf;
> +	}
> +
> +	for (index =3D 1; index < MAX_MATCHES ; index++)
> +	{
> +		if (matches[index].rm_so >=3D 0)
> +			break;
> +	}
> +
> +	if (index =3D=3D MAX_MATCHES) {
> +		IDMAP_LOG(4, ("regexp_getpwnam: user '%s' did not match regex", name=
));
> +		err =3D ENOENT;
> +		goto err_free_buf;
> +	}
> +
> +	namelen =3D matches[index].rm_eo - matches[index].rm_so;
> +	localname=3D malloc(namelen + 1);
> +	if (!localname)
> +	{
> +		err =3D ENOMEM;
> +		goto err_free_buf;
> +	}
> +	strncpy(localname, name+matches[index].rm_so, namelen);
> +	localname[namelen] =3D '\0';
> +
> +again:
> +	err =3D getpwnam_r(localname, &buf->pwbuf, buf->buf, buflen, &pw);
> +
> +	if (err =3D=3D EINTR)
> +		goto again;
> +
> +	if (!pw) {
> +		if (err =3D=3D 0)
> +			err =3D ENOENT;
> +
> +		IDMAP_LOG(4, ("regex_getpwnam: local user '%s' for '%s' not found",
> +		  localname, name));
> +
> +		goto err_free_name;
> +	}
> +
> +	IDMAP_LOG(4, ("regexp_getpwnam: name '%s' mapped to '%s'",
> +		  name, localname));
> +
> +	*err_p =3D 0;
> +	return pw;
> +
> +err_free_name:
> +	free(localname);
> +err_free_buf:
> +	free(buf);
> +err:
> +	*err_p =3D err;
> +	return NULL;
> +}
> +
> +static struct group *regex_getgrnam(const char *name, const char *UNUS=
ED(domain),
> +				      int *err_p)
> +{
> +	struct group *gr;
> +	struct grbuf *buf;
> +	size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
> +	char *localgroup;
> +	char *groupname;
> +	size_t namelen;
> +	int err =3D 0;
> +	int index;
> +	int status;
> +	regmatch_t matches[MAX_MATCHES];
> +
> +	buf =3D malloc(sizeof(*buf) + buflen);
> +	if (!buf) {
> +		err =3D ENOMEM;
> +		goto err;
> +	}
> +
> +	status =3D regexec(&group_re, name, MAX_MATCHES, matches, 0);
> +	if (status) {
> +		IDMAP_LOG(4, ("regexp_getgrnam: group '%s' did not match regex", nam=
e));
> +		err =3D ENOENT;
> +		goto err_free_buf;
> +	}
> +
> +	for (index =3D 1; index < MAX_MATCHES ; index++)
> +	{
> +		if (matches[index].rm_so >=3D 0)
> +			break;
> +	}
> +
> +	if (index =3D=3D MAX_MATCHES) {
> +		IDMAP_LOG(4, ("regexp_getgrnam: group '%s' did not match regex", nam=
e));
> +		err =3D ENOENT;
> +		goto err_free_buf;
> +	}
> +
> +	namelen =3D matches[index].rm_eo - matches[index].rm_so;
> +	localgroup =3D malloc(namelen + 1);
> +	if (!localgroup)
> +	{
> +		err =3D ENOMEM;
> +		goto err_free_buf;
> +	}
> +	strncpy(localgroup, name+matches[index].rm_so, namelen);
> +	localgroup[namelen] =3D '\0';
> +
> +	IDMAP_LOG(4, ("regexp_getgrnam: group '%s' after match of regex", loc=
algroup));
> +
> +        groupname =3D localgroup;
> +    	if (group_name_prefix_length && ! strncmp(group_name_prefix, loca=
lgroup, group_name_prefix_length))
> +	{
> +		err =3D 1;
> +		if (use_gpx)
> +			err =3D regexec(&gpx_re, localgroup, 0, NULL, 0);
> +
> +		if (err)
> +		{
> +			IDMAP_LOG(4, ("regexp_getgrnam: removing prefix '%s' (%d long) from=
 group '%s'", group_name_prefix, group_name_prefix_length, localgroup));
> +				groupname +=3D group_name_prefix_length;
> +		}
> +		else
> +		{
> +			IDMAP_LOG(4, ("regexp_getgrnam: not removing prefix from group '%s'=
", localgroup));
> +		}
> +	}
> +
> +	IDMAP_LOG(4, ("regexp_getgrnam: will use '%s'", groupname));
> +
> +again:
> +	err =3D getgrnam_r(groupname, &buf->grbuf, buf->buf, buflen, &gr);
> +
> +	if (err =3D=3D EINTR)
> +		goto again;
> +
> +	if (!gr) {
> +		if (err =3D=3D 0)
> +			err =3D ENOENT;
> +
> +		IDMAP_LOG(4, ("regex_getgrnam: local group '%s' for '%s' not found",=
 groupname, name));
> +
> +		goto err_free_name;
> +	}
> +
> +	IDMAP_LOG(4, ("regex_getgrnam: group '%s' mapped to '%s'", name, grou=
pname));
> +
> +	free(localgroup);
> +
> +	*err_p =3D 0;
> +	return gr;
> +
> +err_free_name:
> +	free(localgroup);
> +err_free_buf:
> +	free(buf);
> +err:
> +	*err_p =3D err;
> +	return NULL;
> +}
> +
> +static int regex_gss_princ_to_ids(char *secname, char *princ,
> +				   uid_t *uid, uid_t *gid,
> +				   extra_mapping_params **UNUSED(ex))
> +{
> +	struct passwd *pw;
> +	int err;
> +
> +	/* XXX: Is this necessary? */
> +	if (strcmp(secname, "krb5") !=3D 0 && strcmp(secname, "spkm3") !=3D 0=
)
> +		return -EINVAL;
> +
> +	pw =3D regex_getpwnam(princ, NULL, &err);
> +
> +	if (pw) {
> +		*uid =3D pw->pw_uid;
> +		*gid =3D pw->pw_gid;
> +		free(pw);
> +	}
> +
> +	return -err;
> +}
> +
> +static int regex_gss_princ_to_grouplist(char *secname, char *princ,
> +					 gid_t *groups, int *ngroups,
> +					 extra_mapping_params **UNUSED(ex))
> +{
> +	struct passwd *pw;
> +	int err;
> +
> +	/* XXX: Is this necessary? */
> +	if (strcmp(secname, "krb5") !=3D 0 && strcmp(secname, "spkm3") !=3D 0=
)
> +		return -EINVAL;
> +
> +	pw =3D regex_getpwnam(princ, NULL, &err);
> +
> +	if (pw) {
> +		if (getgrouplist(pw->pw_name, pw->pw_gid, groups, ngroups) < 0)
> +			err =3D -ERANGE;
> +		free(pw);
> +	}
> +
> +	return -err;
> +}
> +
> +static int regex_name_to_uid(char *name, uid_t *uid)
> +{
> +	struct passwd *pw;
> +	int err;
> +
> +	pw =3D regex_getpwnam(name, NULL, &err);
> +
> +	if (pw) {
> +		*uid =3D pw->pw_uid;
> +		free(pw);
> +	}
> +
> +	return -err;
> +}
> +
> +static int regex_name_to_gid(char *name, gid_t *gid)
> +{
> +	struct group *gr;
> +	int err;
> +
> +	gr =3D regex_getgrnam(name, NULL, &err);
> +
> +	if (gr) {
> +		*gid =3D gr->gr_gid;
> +		free(gr);
> +	}
> +
> +	return -err;
> +}
> +
> +static int write_name(char *dest, char *localname, const char* name_pr=
efix, const char *prefix, const char *suffix, size_t len)
> +{
> +	if (strlen(localname) + strlen(name_prefix) + strlen(prefix) + strlen=
(suffix) + 1 > len) {
> +		return -ENOMEM; /* XXX: Is there an -ETOOLONG? */
> +	}
> +	strcpy(dest, prefix);
> +	strcat(dest, name_prefix);
> +	strcat(dest, localname);
> +	strcat(dest, suffix);
> +
> +   	IDMAP_LOG(4, ("write_name: will use '%s'", dest));
> +
> +	return 0;
> +}
> +
> +static int regex_uid_to_name(uid_t uid, char *domain, char *name, size=
_t len)
> +{
> +	struct passwd *pw =3D NULL;
> +	struct passwd pwbuf;
> +	char *buf;
> +	size_t buflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> +	int err =3D -ENOMEM;
> +
> +	buf =3D malloc(buflen);
> +	if (!buf)
> +		goto out;
> +	if (domain =3D=3D NULL)
> +		domain =3D get_default_domain();
> +	err =3D -getpwuid_r(uid, &pwbuf, buf, buflen, &pw);
> +	if (pw =3D=3D NULL)
> +		err =3D -ENOENT;
> +	if (err)
> +		goto out_buf;
> +	err =3D write_name(name, pw->pw_name, &empty, user_prefix, user_suffi=
x, len);
> +out_buf:
> +	free(buf);
> +out:
> +	return err;
> +}
> +
> +static int regex_gid_to_name(gid_t gid, char *UNUSED(domain), char *na=
me, size_t len)
> +{
> +	struct group *gr =3D NULL;
> +	struct group grbuf;
> +	char *buf;
> +    const char *name_prefix;
> +	size_t buflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
> +	int err;
> +    char * groupname =3D NULL;
> +
> +	do {
> +		err =3D -ENOMEM;
> +		buf =3D malloc(buflen);
> +		if (!buf)
> +			goto out;
> +		err =3D -getgrgid_r(gid, &grbuf, buf, buflen, &gr);
> +		if (gr =3D=3D NULL && !err)
> +			err =3D -ENOENT;
> +		if (err =3D=3D -ERANGE) {
> +			buflen *=3D 2;
> +			free(buf);
> +		}
> +	} while (err =3D=3D -ERANGE);
> +
> +	if (err)
> +		goto out_buf;
> +
> +	groupname =3D gr->gr_name;
> +    	name_prefix =3D group_name_prefix;
> +    	if (group_name_prefix_length)
> +        {
> +            if(! strncmp(group_name_prefix, groupname, group_name_pref=
ix_length))
> +            {
> +			    name_prefix =3D &empty;
> +            }
> +            else if (use_gpx)
> +            {
> +	            err =3D regexec(&gpx_re, groupname, 0, NULL, 0);
> +	            if (!err)
> +                {
> +   			        IDMAP_LOG(4, ("regex_gid_to_name: not adding prefix to g=
roup '%s'", groupname));
> +			        name_prefix =3D &empty;
> +                }
> +            }
> +	}
> +     =20
> +	err =3D write_name(name, groupname, name_prefix, group_prefix, group_=
suffix, len);
> +
> +out_buf:
> +	free(buf);
> +out:
> +	return err;
> +}
> +
> +static int regex_init(void) {=09
> +	const char *string;
> +	int status;
> +
> +
> +        string =3D CONFIG_GET_STRING("Regex", "User-Regex");
> +	if (!string)
> +	{
> +		warnx("regex_init: regex for user mapping missing");
> +		goto error1;
> +	}
> +   =20
> +	status =3D regcomp(&user_re, string, REG_EXTENDED|REG_ICASE);=20
> +	if (status)
> +	{
> +		warnx("regex_init: compiling regex for user mapping failed with stat=
us %u", status);
> +		goto error1;
> +	}
> +
> +	string =3D CONFIG_GET_STRING("Regex", "Group-Regex");
> +	if (!string)
> +	{
> +		warnx("regex_init: regex for group mapping missing");
> +		goto error2;
> +	}
> +   =20
> +    status =3D regcomp(&group_re, string, REG_EXTENDED|REG_ICASE);=20
> +    if (status)
> +    {
> +		warnx("regex_init: compiling regex for group mapping failed with sta=
tus %u", status);
> +		goto error2;
> +    }
> +
> +	group_name_prefix =3D CONFIG_GET_STRING("Regex", "Group-Name-Prefix")=
;
> +    if (!group_name_prefix)
> +    {
> +        group_name_prefix =3D &empty;
> +    }
> +    group_name_prefix_length =3D strlen(group_name_prefix);
> +
> +    user_prefix =3D CONFIG_GET_STRING("Regex", "Prepend-Before-User");
> +    if (!user_prefix)
> +    {
> +        user_prefix =3D &empty;
> +    }
> +
> +    user_suffix =3D CONFIG_GET_STRING("Regex", "Append-After-User");=20
> +    if (!user_suffix)
> +    {
> +        user_suffix =3D &empty;
> +    }
> +
> +    group_prefix =3D CONFIG_GET_STRING("Regex", "Prepend-Before-Group"=
);=20
> +    if (!group_prefix)
> +    {
> +        group_prefix =3D &empty;
> +    }
> +
> +    group_suffix =3D CONFIG_GET_STRING("Regex", "Append-After-Group");=
=20
> +    if (!group_suffix)
> +    {
> +        group_suffix =3D &empty;
> +    }
> +
> +    string =3D CONFIG_GET_STRING("Regex", "Group-Name-No-Prefix-Regex"=
);
> +    use_gpx =3D 0;
> +    if (string)
> +    {
> +        status =3D regcomp(&gpx_re, string, REG_EXTENDED|REG_ICASE);=20
> +
> +        if (status)
> +        {
> +	    	warnx("regex_init: compiling regex for group prefix exclusion fa=
iled with status %u", status);
> +		    goto error3;
> +        }
> +
> +        use_gpx =3D 1;
> +    }
> +
> +    return 0;
> +
> +error3:
> +	regfree(&group_re);
> +error2:
> +	regfree(&user_re);
> +error1:
> +	return 0;
> + /* return -EINVAL; */
> +}
> +
> +
> +struct trans_func regex_trans =3D {
> +	.name			=3D "regex",
> +	.init			=3D regex_init,
> +	.name_to_uid		=3D regex_name_to_uid,
> +	.name_to_gid		=3D regex_name_to_gid,
> +	.uid_to_name		=3D regex_uid_to_name,
> +	.gid_to_name		=3D regex_gid_to_name,
> +	.princ_to_ids		=3D regex_gss_princ_to_ids,
> +	.gss_princ_to_grouplist	=3D regex_gss_princ_to_grouplist,
> +};
> +
> +struct trans_func *libnfsidmap_plugin_init()
> +{
> +	return (&regex_trans);
> +}
> +
>=20

