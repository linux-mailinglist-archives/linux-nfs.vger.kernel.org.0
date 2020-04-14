Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F17E1A7FC3
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2020 16:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgDNO2S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Apr 2020 10:28:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25179 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390865AbgDNO2K (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Apr 2020 10:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586874486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Edoo4PneJNmm/PUUJbt9ike4Ndxrl8ZFMZus8P7ip+Y=;
        b=QKINcGyoBZjrpQnm730DNsBQ0w07FIfdIQaim5QjTkVHB8L8lnfOOtTY7WAKh/BYjR0LkD
        GQlAxfL1t8pDX8HU8MiwpeBVYMCT2T7uvLMiYhdpSR9xT7XrUt1SYw97kDu8XostwLW3BN
        45hdoEg+cJHwH7/u9LVv9IUo6/RyrO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-HuEsYwuZMDy9TVZpC6f6_A-1; Tue, 14 Apr 2020 10:27:32 -0400
X-MC-Unique: HuEsYwuZMDy9TVZpC6f6_A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2DAD107ACC7;
        Tue, 14 Apr 2020 14:27:31 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-136.phx2.redhat.com [10.3.113.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55F1160BF1;
        Tue, 14 Apr 2020 14:27:31 +0000 (UTC)
Subject: Re: [PATCH] nfsidmap:umich_ldap: Add support for SASL binds.
To:     Srikrishan Malik <srikrishanmalik@gmail.com>,
        linux-nfs@vger.kernel.org
References: <20200404090241.30009-1-srikrishanmalik@gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <e28ea9b2-4946-e6d9-d48b-33f7afa5a430@RedHat.com>
Date:   Tue, 14 Apr 2020 10:27:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200404090241.30009-1-srikrishanmalik@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/4/20 5:02 AM, Srikrishan Malik wrote:
> umich_ldap can now do a sasl interactive bind to LDAP server based
> on the values of new tunables added.
> The tunables are similar to the ones in nslcd for SASL binds.
Committed... (tag: nfs-utils-2-4-4-rc3)

steved.
> 
> Signed-off-by: Srikrishan Malik <srikrishanmalik@gmail.com>
> ---
>  configure.ac                   |  23 ++-
>  support/nfsidmap/Makefile.am   |   5 +-
>  support/nfsidmap/idmapd.conf   |  23 +++
>  support/nfsidmap/idmapd.conf.5 |  37 ++++-
>  support/nfsidmap/umich_ldap.c  | 250 ++++++++++++++++++++++++++++++++-
>  5 files changed, 330 insertions(+), 8 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index bb8b000e..00b32800 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -453,12 +453,33 @@ if test "x$enable_ldap" != "xno" ; then
>                                [have_ldap="yes"],[have_ldap="no"])],
>                  [have_ldap="no"])
>          if test "x$have_ldap" = "xyes" ; then
> -                AC_DEFINE([ENABLE_LDAP], 1, [Enable LDAP Support])
> +                dnl check for sasl funcs
> +                AC_CHECK_HEADERS(sasl.h sasl/sasl.h)
> +                AC_CHECK_HEADERS(gsssasl.h)
> +                AC_CHECK_TYPE(sasl_interact_t,[have_sasl_interact_t="yes"],,[
> +                        #ifdef HAVE_SASL_SASL_H
> +                        #include <sasl/sasl.h>
> +                        #elif defined(HAVE_SASL_H)
> +                        #include <sasl.h>
> +                        #endif])
> +		AC_CHECK_LIB([ldap],[ldap_sasl_interactive_bind_s],[have_ldap_sasl_interactive_bind_s="yes"])
> +		AC_CHECK_LIB([gssapi_krb5],[gss_krb5_ccache_name],[have_gss_krb5_ccache_name="yes"])
> +		if test "x$have_sasl_interact_t" = "xyes" -a \
> +			"x$have_ldap_sasl_interactive_bind_s" = "xyes" -a \
> +			"x$have_gss_krb5_ccache_name" = "xyes"; then
> +			AC_DEFINE([HAVE_LDAP_SASL_INTERACTIVE_BIND_S],[1],[Has ldap_sasl_interactive_bind_s function])
> +			AC_DEFINE([HAVE_GSS_KRB5_CCACHE_NAME],[1],[Has gss_krb5_ccache_name function])
> +			AC_CHECK_HEADERS(gssapi/gssapi.h gssapi/gssapi_generic.h gssapi/gssapi_krb5.h gssapi.h krb5.h)
> +			AC_DEFINE([ENABLE_LDAP_SASL],1,[Enable LDAP SASL support])
> +			have_ldap_sasl="yes"
> +		fi
> +		AC_DEFINE([ENABLE_LDAP], 1, [Enable LDAP Support])
>          elif test "x$enable_ldap$have_ldap" = "xyesno" ; then
>                  AC_MSG_ERROR(LDAP support not found!)
>          fi
>  fi
>  AM_CONDITIONAL(ENABLE_LDAP, test "x$have_ldap" = "xyes")
> +AM_CONDITIONAL(ENABLE_LDAP_SASL, test "x$have_ldap_sasl" = "xyes")
>  
>  dnl Should we build gums mapping library?
>  AC_ARG_ENABLE([gums],
> diff --git a/support/nfsidmap/Makefile.am b/support/nfsidmap/Makefile.am
> index 9c21fa34..cb2c0ced 100644
> --- a/support/nfsidmap/Makefile.am
> +++ b/support/nfsidmap/Makefile.am
> @@ -14,6 +14,9 @@ GUMS_MAPPING_LIB = gums.la
>  else
>  GUMS_MAPPING_LIB =
>  endif
> +if ENABLE_LDAP_SASL
> +KRB5_GSS_LIB=-lgssapi_krb5
> +endif
>  lib_LTLIBRARIES = libnfsidmap.la
>  pkgplugin_LTLIBRARIES = nsswitch.la static.la $(UMICH_LDAP_LIB) $(GUMS_MAPPING_LIB)
>  
> @@ -43,7 +46,7 @@ static_la_LIBADD = ../../support/nfs/libnfsconf.la
>  
>  umich_ldap_la_SOURCES = umich_ldap.c
>  umich_ldap_la_LDFLAGS = -module -avoid-version
> -umich_ldap_la_LIBADD = -lldap ../../support/nfs/libnfsconf.la
> +umich_ldap_la_LIBADD = -lldap $(KRB5_GSS_LIB) ../../support/nfs/libnfsconf.la
>  
>  gums_la_SOURCES = gums.c
>  gums_la_LDFLAGS = -module -avoid-version
> diff --git a/support/nfsidmap/idmapd.conf b/support/nfsidmap/idmapd.conf
> index b673c7d7..aeeca1bf 100644
> --- a/support/nfsidmap/idmapd.conf
> +++ b/support/nfsidmap/idmapd.conf
> @@ -110,6 +110,29 @@ LDAP_base = dc=local,dc=domain,dc=edu
>  # is not set to "never"
>  #LDAP_ca_cert = /etc/ldapca.cert
>  
> +# SASL mechanism to use while binding to LDAP
> +#LDAP_sasl_mech = <SASL mech>
> +
> +# SASL realm to be used for SASL auth
> +#LDAP_sasl_realm = <SASL realm>
> +
> +# Authentication identity to be used for SASL auth
> +#LDAP_sasl_authcid = <SASL authcid>
> +
> +# Authorization identity for SASL auth
> +#LDAP_sasl_authzid = <SASL authzid>
> +
> +# Cyrus SASL security properties
> +#LDAP_sasl_secprops = <secprops>
> +
> +# Specifies whether the LDAP server hostname should be canonicalised.
> +# If set to yes LDAP lib with do a reverse hostname lookup.
> +# If this is not set the LDAP library's default will be used.
> +#LDAP_sasl_canonicalize <yes | no>
> +
> +# Specifies the kerberos ticket cache to be used
> +#LDAP_sasl_krb5_ccname = <kerberos ticket cache>
> +
>  # Objectclass mapping information
>  
>  # Mapping for the person (account) object class
> diff --git a/support/nfsidmap/idmapd.conf.5 b/support/nfsidmap/idmapd.conf.5
> index 61fbb613..fdd6d589 100644
> --- a/support/nfsidmap/idmapd.conf.5
> +++ b/support/nfsidmap/idmapd.conf.5
> @@ -206,6 +206,39 @@ It can take the same values as ldap.conf(5)'s
>  tunable.
>  (Default: "hard")
>  .TP
> +.B LDAP_timeout_seconds
> +Number of seconds before timing out an LDAP request
> +(Default: 4)
> +.TP
> +.B LDAP_sasl_mech
> +SASL mechanism to be used for sasl authentication.  Required
> +if SASL auth is to be used (Default: None)
> +.TP
> +.B LDAP_realm
> +SASL realm to be used for sasl authentication. (Default: None)
> +.TP
> +.B LDAP_sasl_authcid
> +Authentication identity to be used for sasl authentication. (Default: None)
> +.TP
> +.B LDAP_sasl_authzid
> +Authorization identity to be used for sasl authentication. (Default: None)
> +.TP
> +.B LDAP_sasl_secprops
> +Cyrus SASL security properties. It can  the same values as ldap.conf(5)'s
> +sasl_secprops.
> +.TP
> +.B LDAP_sasl_canonicalize
> +Specifies whether the LDAP server hostname should be canonicalised.
> +If set to yes LDAP lib with do a reverse hostname lookup.
> +If this is not set the LDAP library's default will be used. (Default:
> +None)
> +.TP
> +.B LDAP_sasl_krb5_ccname
> +Path to kerberos credential cache. If it is not set then the value
> +of environment variable KRB5CCNAME will be used. If the environment
> +variable is not set then the default mechanism of kerberos library
> +will be used.
> +.TP
>  .B NFSv4_person_objectclass
>  The object class name for people accounts in your local LDAP schema
>  (Default: NFSv4RemotePerson)
> @@ -257,10 +290,6 @@ is true, this is the attribute to be searched for.
>  .B NFSv4_grouplist_filter
>  An optional search filter for determining group membership.
>  (No Default)
> -.TP
> -.B LDAP_timeout_seconds
> -Number of seconds before timing out an LDAP request
> -(Default: 4)
>  .\"
>  .\" -------------------------------------------------------------------
>  .\" An Example
> diff --git a/support/nfsidmap/umich_ldap.c b/support/nfsidmap/umich_ldap.c
> index b7445c37..d5a7731a 100644
> --- a/support/nfsidmap/umich_ldap.c
> +++ b/support/nfsidmap/umich_ldap.c
> @@ -31,6 +31,7 @@
>   * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
>   * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>   */
> +#include "config.h"
>  
>  #include <sys/types.h>
>  #include <sys/socket.h>
> @@ -43,6 +44,15 @@
>  #include <limits.h>
>  #include <pwd.h>
>  #include <err.h>
> +#ifdef HAVE_GSSAPI_GSSAPI_KRB5_H
> +#include <gssapi/gssapi_krb5.h>
> +#endif /* HAVE_GSSAPI_GSSAPI_KRB5_H */
> +#ifdef HAVE_SASL_H
> +#include <sasl.h>
> +#endif /* HAVE_SASL_H */
> +#ifdef HAVE_SASL_SASL_H
> +#include <sasl/sasl.h>
> +#endif /* HAVE_SASL_SASL_H */
>  /* We are using deprecated functions, get the prototypes... */
>  #define LDAP_DEPRECATED 1
>  #include <ldap.h>
> @@ -105,6 +115,13 @@ struct umich_ldap_info {
>  				   looking up user groups */
>  	int ldap_timeout;	/* Timeout in seconds for searches
>  				   by ldap_search_st */
> +	char *sasl_mech;	/* sasl mech to be used */
> +	char *sasl_realm;	/* SASL realm for SASL authentication */
> +	char *sasl_authcid;	/* authentication identity to be used  */
> +	char *sasl_authzid;	/* authorization identity to be used */
> +	char *sasl_secprops;	/* Cyrus SASL security properties. */
> +	int sasl_canonicalize;	/* canonicalize LDAP server host name */
> +	char *sasl_krb5_ccname;	/* krb5 ticket cache */
>  };
>  
>  /* GLOBAL data */
> @@ -122,6 +139,13 @@ static struct umich_ldap_info ldap_info = {
>  	.tls_reqcert = LDAP_OPT_X_TLS_HARD,
>  	.memberof_for_groups = 0,
>  	.ldap_timeout = DEFAULT_UMICH_SEARCH_TIMEOUT,
> +	.sasl_mech = NULL,
> +	.sasl_realm = NULL,
> +	.sasl_authcid = NULL,
> +	.sasl_authzid = NULL,
> +	.sasl_secprops = NULL,
> +	.sasl_canonicalize = -1, /* leave to the LDAP lib */
> +	.sasl_krb5_ccname = NULL,
>  };
>  
>  static struct ldap_map_names ldap_map = {
> @@ -138,6 +162,119 @@ static struct ldap_map_names ldap_map = {
>  	.NFSv4_grouplist_filter = NULL,
>  };
>  
> +#ifdef ENABLE_LDAP_SASL
> +
> +/**
> + * Set the path of the krb5 ticket cache
> + * use gss_krb5_ccache_name if available else set the env var
> + */
> +static int set_krb5_ccname(const char *krb5_ccache_name)
> +{
> +	int retval = 0;
> +#ifdef HAVE_GSS_KRB5_CCACHE_NAME
> +	OM_uint32 status;
> +
> +	if (gss_krb5_ccache_name(&status, krb5_ccache_name, NULL) !=
> +		GSS_S_COMPLETE) {
> +		IDMAP_LOG(5,
> +		  ("Failed to set creds cache for kerberos, minor_status(%d)",
> +		   status));
> +		retval = status;
> +		goto out;
> +	}
> +#else /* HAVE_GSS_KRB5_CCACHE_NAME */
> +	char *env;
> +	int buflen = 0;
> +
> +	buflen = strlen("KRB5CCNAME=") + strlen(krb5_ccache_name) + 1;
> +	env = malloc(buflen);
> +	if (env == NULL) {
> +		retval = ENOMEM;
> +		goto out;
> +	}
> +	snprintf(env, buflen, "KRB5CCNAME=%s", krb5_ccache_name);
> +	if (putenv(env) != 0) {
> +		retval = errno;
> +		IDMAP_LOG(5, ("Failed to set creds cache for kerberos, err(%d)",
> +			      retval));
> +	}
> +#endif /* else HAVE_GSS_KRB5_CCACHE_NAME */
> +out:
> +	return retval;
> +}
> +
> +/**
> + * SASL interact callback
> + */
> +static int sasl_interact_cb(__attribute__((unused)) LDAP * ld,
> +		__attribute__((unused)) unsigned int flags, void *defaults,
> +		void *ctx)
> +{
> +	struct umich_ldap_info *linfo = defaults;
> +	sasl_interact_t *interact = ctx;
> +
> +	while (interact->id != SASL_CB_LIST_END) {
> +		switch (interact->id) {
> +		case SASL_CB_AUTHNAME:
> +			if (linfo->sasl_authcid == NULL ||
> +			    linfo->sasl_authcid[0] == '\0') {
> +				IDMAP_LOG(2, ("SASL_CB_AUTHNAME asked in "
> +					    "callback but not found in conf"));
> +			} else {
> +				IDMAP_LOG(5,
> +					  ("Setting SASL_CB_AUTHNAME to %s",
> +					   linfo->sasl_authcid));
> +				interact->result = linfo->sasl_authcid;
> +				interact->len = strlen(linfo->sasl_authcid);
> +			}
> +			break;
> +		case SASL_CB_PASS:
> +			if (linfo->passwd == NULL || linfo->passwd[0] == '\0') {
> +				IDMAP_LOG(2, ("SASL_CB_PASS asked in callback "
> +					      "but not found in conf"));
> +			} else {
> +				IDMAP_LOG(5,
> +					  ("Setting SASL_CB_PASS to ***"));
> +				interact->result = linfo->passwd;
> +				interact->len = strlen(linfo->passwd);
> +			}
> +			break;
> +		case SASL_CB_GETREALM:
> +			if (linfo->sasl_realm == NULL ||
> +			    linfo->sasl_realm[0] == '\0') {
> +				IDMAP_LOG(2, ("SASL_CB_GETREALM asked in "
> +					    "callback but not found in conf"));
> +			} else {
> +				IDMAP_LOG(5,
> +					  ("Setting SASL_CB_GETREALM to %s",
> +					   linfo->sasl_realm));
> +				interact->result = linfo->sasl_realm;
> +				interact->len = strlen(linfo->sasl_realm);
> +			}
> +			break;
> +		case SASL_CB_USER:
> +			if (linfo->sasl_authzid == NULL ||
> +			    linfo->sasl_authzid[0] == '\0') {
> +				IDMAP_LOG(2, ("SASL_CB_USER asked in callback "
> +					      "but not found in conf"));
> +			} else {
> +				IDMAP_LOG(5, ("Setting SASL_CB_USER to %s",
> +					      linfo->sasl_authzid));
> +				interact->result = linfo->sasl_authzid;
> +				interact->len = strlen(linfo->sasl_authzid);
> +			}
> +			break;
> +		default:
> +			IDMAP_LOG(2, ("Undefined value requested %d",
> +				      interact->id));
> +			break;
> +		}
> +		interact++;
> +	}
> +	return LDAP_SUCCESS;
> +}
> +#endif /* ENABLE_LDAP_SASL */
> +
>  /* Local routines */
>  
>  static int
> @@ -244,7 +381,57 @@ ldap_init_and_bind(LDAP **pld,
>  	/* If we have a DN (and password) attempt an authenticated bind */
>  	if (linfo->user_dn) {
>  retry_bind:
> +#ifdef ENABLE_LDAP_SASL
> +		if (linfo->sasl_mech != NULL && linfo->sasl_mech[0] != '\0') {
> +		/* use sasl bind */
> +			if (linfo->sasl_canonicalize != -1) {
> +				lerr = ldap_set_option(ld,
> +						LDAP_OPT_X_SASL_NOCANON,
> +						linfo->sasl_canonicalize ?
> +						  LDAP_OPT_OFF : LDAP_OPT_ON);
> +				if (lerr != LDAP_SUCCESS) {
> +					IDMAP_LOG(2, ("ldap_init_and_bind: "
> +						    "setting sasl_canonicalize"
> +						    " failed: %s (%d)",
> +						    ldap_err2string(lerr),
> +						    lerr));
> +					goto out;
> +				}
> +			}
> +			if (linfo->sasl_secprops != NULL &&
> +			    linfo->sasl_secprops[0] != '\0') {
> +				lerr = ldap_set_option(ld,
> +						LDAP_OPT_X_SASL_SECPROPS,
> +						(void *) linfo->sasl_secprops);
> +				if (lerr != LDAP_SUCCESS) {
> +					IDMAP_LOG(2, ("ldap_init_and_bind: "
> +						      "setting sasl_secprops"
> +						      " failed: %s (%d)",
> +						      ldap_err2string(lerr),
> +						      lerr));
> +					goto out;
> +				}
> +			}
> +			if (linfo->sasl_krb5_ccname != NULL &&
> +			    linfo->sasl_krb5_ccname[0] != '\0') {
> +				lerr = set_krb5_ccname(linfo->sasl_krb5_ccname);
> +				if (lerr != 0) {
> +					IDMAP_LOG(2,
> +						("ldap_init_and_bind: Failed "
> +						 "to set krb5 ticket cache, "
> +						 "err=%d", lerr));
> +				}
> +			}
> +			lerr = ldap_sasl_interactive_bind_s(ld, linfo->user_dn,
> +				linfo->sasl_mech, NULL, NULL, LDAP_SASL_QUIET,
> +				sasl_interact_cb, linfo);
> +		} else {
> +			lerr = ldap_simple_bind_s(ld, linfo->user_dn,
> +						  linfo->passwd);
> +		}
> +#else /* ENABLE_LDAP_SASL */
>  		lerr = ldap_simple_bind_s(ld, linfo->user_dn, linfo->passwd);
> +#endif /* else ENABLE_LDAP_SASL */
>  		if (lerr) {
>  			char *errmsg;
>  			if (lerr == LDAP_PROTOCOL_ERROR) {
> @@ -267,10 +454,22 @@ retry_bind:
>  				}
>  				goto retry_bind;
>  			}
> -			IDMAP_LOG(2, ("ldap_init_and_bind: ldap_simple_bind_s "
> +#ifdef ENABLE_LDAP_SASL
> +			IDMAP_LOG(2, ("ldap_init_and_bind: %s "
> +				  "to [%s] as user '%s': %s (%d)",
> +				  (linfo->sasl_mech != NULL &&
> +				   linfo->sasl_mech[0] != '\0') ?
> +				   "ldap_sasl_interactive_bind_s" :
> +				   "ldap_simple_bind_s",
> +				  server_url, linfo->user_dn,
> +				  ldap_err2string(lerr), lerr));
> +#else /* ENABLE_LDAP_SASL */
> +			IDMAP_LOG(2, ("ldap_init_and_bind: ldap_simple_bind_s"
>  				  "to [%s] as user '%s': %s (%d)",
>  				  server_url, linfo->user_dn,
>  				  ldap_err2string(lerr), lerr));
> +
> +#endif /* else ENABLE_LDAP_SASL */
>  			if ((ldap_get_option(ld, LDAP_OPT_ERROR_STRING, &errmsg) == LDAP_SUCCESS)
>  					&& (errmsg != NULL)&& (*errmsg != '\0')) {
>  				IDMAP_LOG(2, ("ldap_init_and_bind: "
> @@ -1155,6 +1354,30 @@ umichldap_init(void)
>  				      (ldap_info.use_ssl) ?
>  				      LDAPS_PORT : LDAP_PORT);
>  
> +	ldap_info.sasl_mech = conf_get_str(LDAP_SECTION, "LDAP_sasl_mech");
> +	ldap_info.sasl_realm = conf_get_str(LDAP_SECTION, "LDAP_sasl_realm");
> +	ldap_info.sasl_authcid = conf_get_str(LDAP_SECTION,
> +					      "LDAP_sasl_authcid");
> +	ldap_info.sasl_authzid = conf_get_str(LDAP_SECTION,
> +					      "LDAP_sasl_authzid");
> +	ldap_info.sasl_secprops = conf_get_str(LDAP_SECTION,
> +					       "LDAP_sasl_secprops");
> +
> +	/* If it is not set let the ldap lib work with the lib default */
> +	canonicalize = conf_get_str_with_def(LDAP_SECTION,
> +					     "LDAP_sasl_canonicalize", "undef");
> +	if ((strcasecmp(canonicalize, "true") == 0) ||
> +	    (strcasecmp(canonicalize, "on") == 0) ||
> +	    (strcasecmp(canonicalize, "yes") == 0)) {
> +		ldap_info.sasl_canonicalize = 1;
> +	} else if ((strcasecmp(canonicalize, "false") == 0) ||
> +	    (strcasecmp(canonicalize, "off") == 0) ||
> +	    (strcasecmp(canonicalize, "no") == 0)) {
> +		ldap_info.sasl_canonicalize = 0;
> +	}
> +	ldap_info.sasl_krb5_ccname = conf_get_str(LDAP_SECTION,
> +						  "LDAP_sasl_krb5_ccname");
> +
>  	/* Verify required information is supplied */
>  	if (server_in == NULL || strlen(server_in) == 0)
>  		strncat(missing_msg, "LDAP_server ", sizeof(missing_msg)-1);
> @@ -1167,7 +1390,8 @@ umichldap_init(void)
>  	}
>  
>  	ldap_info.server = server_in;
> -	canonicalize = conf_get_str_with_def(LDAP_SECTION, "LDAP_canonicalize_name", "yes");
> +	canonicalize = conf_get_str_with_def(LDAP_SECTION,
> +					     "LDAP_canonicalize_name", "yes");
>  	if ((strcasecmp(canonicalize, "true") == 0) ||
>  	    (strcasecmp(canonicalize, "on") == 0) ||
>  	    (strcasecmp(canonicalize, "yes") == 0)) {
> @@ -1296,6 +1520,28 @@ umichldap_init(void)
>  		  ldap_info.tls_reqcert));
>  	IDMAP_LOG(1, ("umichldap_init: use_memberof_for_groups : %s",
>  		  ldap_info.memberof_for_groups ? "yes" : "no"));
> +	IDMAP_LOG(1, ("umichldap_init: sasl_mech: %s",
> +		  (ldap_info.sasl_mech && strlen(ldap_info.sasl_mech) != 0) ?
> +		  ldap_info.sasl_mech : "<not-supplied>"));
> +	IDMAP_LOG(1, ("umichldap_init: sasl_realm: %s",
> +		  (ldap_info.sasl_realm && strlen(ldap_info.sasl_realm) != 0) ?
> +		  ldap_info.sasl_realm : "<not-supplied>"));
> +	IDMAP_LOG(1, ("umichldap_init: sasl_authcid: %s",
> +		  (ldap_info.sasl_authcid &&
> +		   strlen(ldap_info.sasl_authcid) != 0) ?
> +		  ldap_info.sasl_authcid : "<not-supplied>"));
> +	IDMAP_LOG(1, ("umichldap_init: sasl_authzid: %s",
> +		  (ldap_info.sasl_authzid &&
> +		   strlen(ldap_info.sasl_authzid) != 0) ?
> +		  ldap_info.sasl_authzid : "<not-supplied>"));
> +	IDMAP_LOG(1, ("umichldap_init: sasl_secprops: %s",
> +		  (ldap_info.sasl_secprops &&
> +		   strlen(ldap_info.sasl_secprops) != 0) ?
> +		  ldap_info.sasl_secprops : "<not-supplied>"));
> +	IDMAP_LOG(1, ("umichldap_init: sasl_canonicalize: %d",
> +		      ldap_info.sasl_canonicalize));
> +	IDMAP_LOG(1, ("umichldap_init: sasl_krb5_ccname: %s",
> +		      ldap_info.sasl_krb5_ccname));
>  
>  	IDMAP_LOG(1, ("umichldap_init: NFSv4_person_objectclass : %s",
>  		  ldap_map.NFSv4_person_objcls));
> 

