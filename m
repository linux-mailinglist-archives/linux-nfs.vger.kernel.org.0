Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2B12264ED
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jul 2020 17:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbgGTPtZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jul 2020 11:49:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60942 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731009AbgGTPtY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jul 2020 11:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595260162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hGj6lhQqEqxwh+1OanEmaJ5WyK9z28bmgR7d5Disb0s=;
        b=inCLQ3tzHn1OmigHpDQY0JzDt+3yb2laFFi7SUxSeMsF+n75nuMn9gtG10jNAttyTMy0L5
        gJT6Fv7DcayeitSazkpjxhyeir7Q6zMWTf6n1/TClOqFxj9DW8J9zzEi+iWtzhHd4hSjPa
        wMrF9vnlrLY37xpkjZD0bRTE2m8yF2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-nC6IaESFNlmPCvA1W1d6KQ-1; Mon, 20 Jul 2020 11:49:20 -0400
X-MC-Unique: nC6IaESFNlmPCvA1W1d6KQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 893D780BCC0;
        Mon, 20 Jul 2020 15:49:19 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-147.phx2.redhat.com [10.3.113.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21BC41001901;
        Mon, 20 Jul 2020 15:49:19 +0000 (UTC)
Subject: Re: [PATCH 09/11] nfsidmap: Add support to cleanup resources on exit
To:     Doug Nazar <nazard@nazar.ca>, linux-nfs@vger.kernel.org
References: <20200718092421.31691-1-nazard@nazar.ca>
 <20200718092421.31691-10-nazard@nazar.ca>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <84277cb9-03da-3065-1848-f8c1e2bee167@RedHat.com>
Date:   Mon, 20 Jul 2020 11:49:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200718092421.31691-10-nazard@nazar.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey,

On 7/18/20 5:24 AM, Doug Nazar wrote:
> Signed-off-by: Doug Nazar <nazard@nazar.ca>
> ---
>  support/nfsidmap/libnfsidmap.c      | 13 +++++++++++++
>  support/nfsidmap/nfsidmap.h         |  1 +
>  support/nfsidmap/nfsidmap_common.c  | 11 ++++++++++-
>  support/nfsidmap/nfsidmap_private.h |  1 +
>  support/nfsidmap/nss.c              |  8 ++++++++
>  5 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/support/nfsidmap/libnfsidmap.c b/support/nfsidmap/libnfsidmap.c
> index bce448cf..6b5647d2 100644
> --- a/support/nfsidmap/libnfsidmap.c
> +++ b/support/nfsidmap/libnfsidmap.c
> @@ -496,6 +496,19 @@ out:
>  	return ret ? -ENOENT: 0;
>  }
>  
> +void nfs4_term_name_mapping(void)
> +{
> +	if (nfs4_plugins)
> +		unload_plugins(nfs4_plugins);
> +	if (gss_plugins)
> +		unload_plugins(gss_plugins);
> +
> +	nfs4_plugins = gss_plugins = NULL;
> +
> +	free_local_realms();
> +	conf_cleanup();
> +}
> +
>  int
>  nfs4_get_default_domain(char *UNUSED(server), char *domain, size_t len)
>  {
> diff --git a/support/nfsidmap/nfsidmap.h b/support/nfsidmap/nfsidmap.h
> index 10630654..5a795684 100644
> --- a/support/nfsidmap/nfsidmap.h
> +++ b/support/nfsidmap/nfsidmap.h
> @@ -50,6 +50,7 @@ typedef struct _extra_mapping_params {
>  typedef void (*nfs4_idmap_log_function_t)(const char *, ...);
>  
>  int nfs4_init_name_mapping(char *conffile);
> +void nfs4_term_name_mapping(void);
>  int nfs4_get_default_domain(char *server, char *domain, size_t len);
>  int nfs4_uid_to_name(uid_t uid, char *domain, char *name, size_t len);
>  int nfs4_gid_to_name(gid_t gid, char *domain, char *name, size_t len);
> diff --git a/support/nfsidmap/nfsidmap_common.c b/support/nfsidmap/nfsidmap_common.c
> index f89b82ee..4d2cb14f 100644
> --- a/support/nfsidmap/nfsidmap_common.c
> +++ b/support/nfsidmap/nfsidmap_common.c
> @@ -34,12 +34,21 @@ static char * toupper_str(char *s)
>          return s;
>  }
>  
> +static struct conf_list *local_realms = NULL;
> +
> +void free_local_realms(void)
> +{
> +	if (local_realms) {
> +		conf_free_list(local_realms);
> +		local_realms = NULL;
> +	}
> +}
> +
>  /* Get list of "local equivalent" realms.  Meaning the list of realms
>   * where john@REALM.A is considered the same user as john@REALM.B
>   * If not specified, default to upper-case of local domain name */
>  struct conf_list *get_local_realms(void)
>  {
> -	static struct conf_list *local_realms = NULL;
>  	if (local_realms) return local_realms;
>  
>  	local_realms = conf_get_list("General", "Local-Realms");
> diff --git a/support/nfsidmap/nfsidmap_private.h b/support/nfsidmap/nfsidmap_private.h
> index f1af55fa..a5cb6dda 100644
> --- a/support/nfsidmap/nfsidmap_private.h
> +++ b/support/nfsidmap/nfsidmap_private.h
> @@ -37,6 +37,7 @@
>  #include "conffile.h"
>  
>  struct conf_list *get_local_realms(void);
> +void free_local_realms(void);
>  int get_nostrip(void);
>  int get_reformat_group(void);
>  
> diff --git a/support/nfsidmap/nss.c b/support/nfsidmap/nss.c
> index 9d46499c..f8dbb94a 100644
> --- a/support/nfsidmap/nss.c
> +++ b/support/nfsidmap/nss.c
> @@ -467,6 +467,14 @@ static int nss_plugin_init(void)
>  	return 0;
>  }
>  
> +__attribute__((destructor))
> +static int nss_plugin_term(void)
> +{
> +	free_local_realms();
> +	conf_cleanup();
> +	return 0;
> +}
> +
Just wondering... How is nss_plugin_term() called/used?

steved.

>  
>  struct trans_func nss_trans = {
>  	.name		= "nsswitch",
> 

