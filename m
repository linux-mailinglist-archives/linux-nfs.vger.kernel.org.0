Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97F6427EDB
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2019 15:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbfEWNye (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 May 2019 09:54:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730323AbfEWNye (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 23 May 2019 09:54:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A8DC58830F;
        Thu, 23 May 2019 13:54:33 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-47.phx2.redhat.com [10.3.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B7E16840D;
        Thu, 23 May 2019 13:54:33 +0000 (UTC)
Subject: Re: [nfs-utils:nfsidmap PATCH] Add LDAP_tls_reqcert tunable to
 idmapd.conf.
To:     Srikrishan Malik <srikrishanmalik@gmail.com>
Cc:     linux-nfs@vger.kernel.org
References: <20190522120526.59335-1-srikrishanmalik@gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <0a9cbe6a-3c24-08d5-7383-f32bd8be4e09@RedHat.com>
Date:   Thu, 23 May 2019 09:54:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522120526.59335-1-srikrishanmalik@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 23 May 2019 13:54:33 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Srikrishan,

On 5/22/19 8:05 AM, Srikrishan Malik wrote:
> This tunable will control the checks on server certs for a TLS session
> similar to ldap.conf(5).
> LDAP_ca_cert can be skipped if LDAP_tls_reqcert is set to "never"
> 
> Signed-off-by: Srikrishan Malik <srikrishanmalik@gmail.com>
Would it be possible to added LDAP_tls_reqcert to idmap.conf, 
commented out and explaining what it does? Similar to the other 
commented out LDAP variables in that file.

steved.

> ---
>  support/nfsidmap/umich_ldap.c | 57 +++++++++++++++++++++++++++++------
>  1 file changed, 47 insertions(+), 10 deletions(-)
> 
> diff --git a/support/nfsidmap/umich_ldap.c b/support/nfsidmap/umich_ldap.c
> index 10d1d979..b7445c37 100644
> --- a/support/nfsidmap/umich_ldap.c
> +++ b/support/nfsidmap/umich_ldap.c
> @@ -100,6 +100,7 @@ struct umich_ldap_info {
>  	char *passwd;		/* Password to use when binding to directory */
>  	int use_ssl;		/* SSL flag */
>  	char *ca_cert;		/* File location of the ca_cert */
> +	int tls_reqcert;	/* req and validate server cert */
>  	int memberof_for_groups;/* Use 'memberof' attribute when
>  				   looking up user groups */
>  	int ldap_timeout;	/* Timeout in seconds for searches
> @@ -118,6 +119,7 @@ static struct umich_ldap_info ldap_info = {
>  	.passwd = NULL,
>  	.use_ssl = 0,
>  	.ca_cert = NULL,
> +	.tls_reqcert = LDAP_OPT_X_TLS_HARD,
>  	.memberof_for_groups = 0,
>  	.ldap_timeout = DEFAULT_UMICH_SEARCH_TIMEOUT,
>  };
> @@ -153,7 +155,7 @@ ldap_init_and_bind(LDAP **pld,
>  	LDAPAPIInfo apiinfo = {.ldapai_info_version = LDAP_API_INFO_VERSION};
>  
>  	snprintf(server_url, sizeof(server_url), "%s://%s:%d",
> -		 (linfo->use_ssl && linfo->ca_cert) ? "ldaps" : "ldap",
> +		 (linfo->use_ssl) ? "ldaps" : "ldap",
>  		 linfo->server, linfo->port);
>  
>  	/*
> @@ -208,9 +210,8 @@ ldap_init_and_bind(LDAP **pld,
>  	}
>  
>  	/* Set option to to use SSL/TLS if requested */
> -	if (linfo->use_ssl && linfo->ca_cert) {
> +	if (linfo->use_ssl) {
>  		int tls_type = LDAP_OPT_X_TLS_HARD;
> -
>  		lerr = ldap_set_option(ld, LDAP_OPT_X_TLS, &tls_type);
>  		if (lerr != LDAP_SUCCESS) {
>  			IDMAP_LOG(2, ("ldap_init_and_bind: setting SSL "
> @@ -218,11 +219,23 @@ ldap_init_and_bind(LDAP **pld,
>  				  ldap_err2string(lerr), lerr));
>  			goto out;
>  		}
> -		lerr = ldap_set_option(NULL, LDAP_OPT_X_TLS_CACERTFILE,
> -				       linfo->ca_cert);
> +
> +		if (linfo->ca_cert != NULL) {
> +			lerr = ldap_set_option(NULL, LDAP_OPT_X_TLS_CACERTFILE,
> +					       linfo->ca_cert);
> +			if (lerr != LDAP_SUCCESS) {
> +				IDMAP_LOG(2, ("ldap_init_and_bind: setting CA "
> +					  "certificate file failed : %s (%d)",
> +					  ldap_err2string(lerr), lerr));
> +				goto out;
> +			}
> +		}
> +
> +		lerr = ldap_set_option(NULL, LDAP_OPT_X_TLS_REQUIRE_CERT,
> +				       &linfo->tls_reqcert);
>  		if (lerr != LDAP_SUCCESS) {
> -			IDMAP_LOG(2, ("ldap_init_and_bind: setting CA "
> -				  "certificate file failed : %s (%d)",
> +			IDMAP_LOG(2, ("ldap_init_and_bind: setting "
> +				      "req CA cert failed : %s(%d)",
>  				  ldap_err2string(lerr), lerr));
>  			goto out;
>  		}
> @@ -1098,7 +1111,7 @@ out_err:
>  static int
>  umichldap_init(void)
>  {
> -	char *tssl, *canonicalize, *memberof;
> +	char *tssl, *canonicalize, *memberof, *cert_req;
>  	char missing_msg[128] = "";
>  	char *server_in, *canon_name;
>  
> @@ -1119,6 +1132,24 @@ umichldap_init(void)
>  	else
>  		ldap_info.use_ssl = 0;
>  	ldap_info.ca_cert = conf_get_str(LDAP_SECTION, "LDAP_CA_CERT");
> +	cert_req = conf_get_str(LDAP_SECTION, "LDAP_tls_reqcert");
> +	if (cert_req != NULL) {
> +		if (strcasecmp(cert_req, "hard") == 0)
> +			ldap_info.tls_reqcert = LDAP_OPT_X_TLS_HARD;
> +		else if (strcasecmp(cert_req, "demand") == 0)
> +			ldap_info.tls_reqcert = LDAP_OPT_X_TLS_DEMAND;
> +		else if (strcasecmp(cert_req, "try") == 0)
> +			ldap_info.tls_reqcert = LDAP_OPT_X_TLS_TRY;
> +		else if (strcasecmp(cert_req, "allow") == 0)
> +			ldap_info.tls_reqcert = LDAP_OPT_X_TLS_ALLOW;
> +		else if (strcasecmp(cert_req, "never") == 0)
> +			ldap_info.tls_reqcert = LDAP_OPT_X_TLS_NEVER;
> +		else {
> +			IDMAP_LOG(0, ("umichldap_init: Invalid value(%s) for "
> +				      "LDAP_tls_reqcert."));
> +			goto fail;
> +		}
> +	}
>  	/* vary the default port depending on whether they use SSL or not */
>  	ldap_info.port = conf_get_num(LDAP_SECTION, "LDAP_port",
>  				      (ldap_info.use_ssl) ?
> @@ -1230,9 +1261,12 @@ umichldap_init(void)
>  	if (ldap_info.group_tree == NULL || strlen(ldap_info.group_tree) == 0)
>  		ldap_info.group_tree = ldap_info.base;
>  
> -	if (ldap_info.use_ssl && ldap_info.ca_cert == NULL) {
> +	if (ldap_info.use_ssl &&
> +	    ldap_info.tls_reqcert != LDAP_OPT_X_TLS_NEVER &&
> +	    ldap_info.ca_cert == NULL) {
>  		IDMAP_LOG(0, ("umichldap_init: You must specify LDAP_ca_cert "
> -			  "with LDAP_use_ssl=yes"));
> +			  "with LDAP_use_ssl=yes and "
> +			  "LDAP_tls_reqcert not set to \"never\""));
>  		goto fail;
>  	}
>  
> @@ -1257,6 +1291,9 @@ umichldap_init(void)
>  		  ldap_info.use_ssl ? "yes" : "no"));
>  	IDMAP_LOG(1, ("umichldap_init: ca_cert : %s",
>  		  ldap_info.ca_cert ? ldap_info.ca_cert : "<not-supplied>"));
> +	IDMAP_LOG(1, ("umichldap_init: tls_reqcert : %s(%d)",
> +		  cert_req ? cert_req : "<not-supplied>",
> +		  ldap_info.tls_reqcert));
>  	IDMAP_LOG(1, ("umichldap_init: use_memberof_for_groups : %s",
>  		  ldap_info.memberof_for_groups ? "yes" : "no"));
>  
> 
