Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371811CB179
	for <lists+linux-nfs@lfdr.de>; Fri,  8 May 2020 16:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgEHOMN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 May 2020 10:12:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45081 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726770AbgEHOMN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 May 2020 10:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588947131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2KAJj4LQQJVH1QuSP1EjOTAeskP7gdZBG4xPf1USFUM=;
        b=FMPSVq9AhVd0c7X4G40oRnf56s2ZPwe9bbiVi9/WyEgMZw5ePug+LvLIGcxFS+BMG1JKTt
        a55519RMiwa0Y4/yqWVXLlKWlBDZiG0gxAEsmSwVWjq9Zed8STCMFH1KLHeCEJpLbX6lFO
        bOo7HavgASOPq314yMvwR70AGq75WXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-whlrwWxZPMKk-odMIZV7IA-1; Fri, 08 May 2020 10:12:07 -0400
X-MC-Unique: whlrwWxZPMKk-odMIZV7IA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77BC1835B4A;
        Fri,  8 May 2020 14:12:06 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-12.phx2.redhat.com [10.3.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15FF01002393;
        Fri,  8 May 2020 14:12:06 +0000 (UTC)
Subject: Re: [PATCH] nfsidmap:umich_ldap: Add tunable to control action for
 ldap referrals.
To:     Srikrishan Malik <srikrishanmalik@gmail.com>,
        linux-nfs@vger.kernel.org
References: <20200418142856.22896-1-srikrishanmalik@gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <4920991d-5442-4a63-8072-67d950a96b3e@RedHat.com>
Date:   Fri, 8 May 2020 10:12:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200418142856.22896-1-srikrishanmalik@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/18/20 10:28 AM, Srikrishan Malik wrote:
> LDAP library follows referrals received in ldap response by default.
> This commit adds a param ldap_follow_referrals for umich_schema to control
> the behaviour. The default value of this tunable is 'true' i.e set to
> follow referrals. This is similar to nslcd::referrals param.
> 
> Signed-off-by: Srikrishan Malik <srikrishanmalik@gmail.com>
> ---
>  support/nfsidmap/idmapd.conf   |  3 +++
>  support/nfsidmap/idmapd.conf.5 |  3 +++
>  support/nfsidmap/umich_ldap.c  | 25 ++++++++++++++++++++++++-
>  3 files changed, 30 insertions(+), 1 deletion(-)
Committed... (tag: nfs-utils-2-4-4-rc4)

steved.
> 
> diff --git a/support/nfsidmap/idmapd.conf b/support/nfsidmap/idmapd.conf
> index aeeca1bf..2a2f79a1 100644
> --- a/support/nfsidmap/idmapd.conf
> +++ b/support/nfsidmap/idmapd.conf
> @@ -98,6 +98,9 @@ LDAP_base = dc=local,dc=domain,dc=edu
>  # absolute search base for groups
>  #LDAP_group_base = <LDAP_base>
>  
> +# Whether to follow ldap referrals
> +#LDAP_follow_referrals = true
> +
>  # Set to true to enable SSL - anything else is not enabled
>  #LDAP_use_ssl = false
>  
> diff --git a/support/nfsidmap/idmapd.conf.5 b/support/nfsidmap/idmapd.conf.5
> index d2fd3a20..f5b18167 100644
> --- a/support/nfsidmap/idmapd.conf.5
> +++ b/support/nfsidmap/idmapd.conf.5
> @@ -239,6 +239,9 @@ name given as
>  .B LDAP_server
>  (Default: "true")
>  .TP
> +.B LDAP_follow_referrals
> +Whether or not to follow ldap referrals. (Default: "true")
> +.TP
>  .B LDAP_use_ssl
>  Set to "true" to enable SSL communication with the LDAP server.
>  (Default: "false")
> diff --git a/support/nfsidmap/umich_ldap.c b/support/nfsidmap/umich_ldap.c
> index d5a7731a..c475d379 100644
> --- a/support/nfsidmap/umich_ldap.c
> +++ b/support/nfsidmap/umich_ldap.c
> @@ -115,6 +115,7 @@ struct umich_ldap_info {
>  				   looking up user groups */
>  	int ldap_timeout;	/* Timeout in seconds for searches
>  				   by ldap_search_st */
> +	int follow_referrals;	/* whether to follow ldap referrals */
>  	char *sasl_mech;	/* sasl mech to be used */
>  	char *sasl_realm;	/* SASL realm for SASL authentication */
>  	char *sasl_authcid;	/* authentication identity to be used  */
> @@ -139,6 +140,7 @@ static struct umich_ldap_info ldap_info = {
>  	.tls_reqcert = LDAP_OPT_X_TLS_HARD,
>  	.memberof_for_groups = 0,
>  	.ldap_timeout = DEFAULT_UMICH_SEARCH_TIMEOUT,
> +	.follow_referrals = 1,
>  	.sasl_mech = NULL,
>  	.sasl_realm = NULL,
>  	.sasl_authcid = NULL,
> @@ -346,6 +348,15 @@ ldap_init_and_bind(LDAP **pld,
>  		ldap_set_option(ld, LDAP_OPT_SIZELIMIT, (void *)sizelimit);
>  	}
>  
> +	lerr = ldap_set_option(ld, LDAP_OPT_REFERRALS,
> +			linfo->follow_referrals ? (void *)LDAP_OPT_ON :
> +						  (void *)LDAP_OPT_OFF);
> +	if (lerr != LDAP_SUCCESS) {
> +		IDMAP_LOG(2, ("ldap_init_and_bind: setting LDAP_OPT_REFERRALS "
> +			      "failed: %s (%d)", ldap_err2string(lerr), lerr));
> +		goto out;
> +	}
> +
>  	/* Set option to to use SSL/TLS if requested */
>  	if (linfo->use_ssl) {
>  		int tls_type = LDAP_OPT_X_TLS_HARD;
> @@ -1310,7 +1321,7 @@ out_err:
>  static int
>  umichldap_init(void)
>  {
> -	char *tssl, *canonicalize, *memberof, *cert_req;
> +	char *tssl, *canonicalize, *memberof, *cert_req, *follow_referrals;
>  	char missing_msg[128] = "";
>  	char *server_in, *canon_name;
>  
> @@ -1378,6 +1389,16 @@ umichldap_init(void)
>  	ldap_info.sasl_krb5_ccname = conf_get_str(LDAP_SECTION,
>  						  "LDAP_sasl_krb5_ccname");
>  
> +	follow_referrals = conf_get_str_with_def(LDAP_SECTION,
> +						 "LDAP_follow_referrals",
> +						 "true");
> +	if ((strcasecmp(follow_referrals, "true") == 0) ||
> +	    (strcasecmp(follow_referrals, "on") == 0) ||
> +	    (strcasecmp(follow_referrals, "yes") == 0))
> +		ldap_info.follow_referrals = 1;
> +	else
> +		ldap_info.follow_referrals = 0;
> +
>  	/* Verify required information is supplied */
>  	if (server_in == NULL || strlen(server_in) == 0)
>  		strncat(missing_msg, "LDAP_server ", sizeof(missing_msg)-1);
> @@ -1542,6 +1563,8 @@ umichldap_init(void)
>  		      ldap_info.sasl_canonicalize));
>  	IDMAP_LOG(1, ("umichldap_init: sasl_krb5_ccname: %s",
>  		      ldap_info.sasl_krb5_ccname));
> +	IDMAP_LOG(1, ("umichldap_init: follow_referrals: %s",
> +		  ldap_info.follow_referrals ? "yes" : "no"));
>  
>  	IDMAP_LOG(1, ("umichldap_init: NFSv4_person_objectclass : %s",
>  		  ldap_map.NFSv4_person_objcls));
> 

