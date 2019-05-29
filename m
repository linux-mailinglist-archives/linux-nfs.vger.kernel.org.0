Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB7E52DDB1
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2019 15:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfE2NHi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 May 2019 09:07:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbfE2NHi (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 May 2019 09:07:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 33D073179B46;
        Wed, 29 May 2019 13:07:38 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-143.phx2.redhat.com [10.3.117.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C45EC5D982;
        Wed, 29 May 2019 13:07:37 +0000 (UTC)
Subject: Re: [PATCH v2] Fix mountd segfault
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
References: <20190514150755.12543.64896.stgit@oracle-102.nfsv4bat.org>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <e261874d-e877-922c-31f1-154e86625dd8@RedHat.com>
Date:   Wed, 29 May 2019 09:07:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514150755.12543.64896.stgit@oracle-102.nfsv4bat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 29 May 2019 13:07:38 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/14/19 11:10 AM, Chuck Lever wrote:
> After commit 8f459a072f93 ("Remove abuse of ai_canonname") the
> ai_canonname field in addrinfo structs returned from
> host_reliable_addrinfo() is always NULL. This results in mountd
> segfaults when there are netgroups or hostname wildcards in
> /etc/exports.
> 
> Add an extra DNS query in check_wildcard() and check_netgroup() to
> obtain the client's canonical hostname instead of dereferencing
> the NULL pointer.
> 
> Reported-by: Mark Wagner <mark@lanfear.net>
> Fixes: 8f459a072f93 ("Remove abuse of ai_canonname")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Committed... 

steved.
> ---
> 
> Changes since v1:
> - Added similar fix for check_netgroup
> - Restructured exit/error paths in check_wildcard
> 
>  support/export/client.c |   32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/support/export/client.c b/support/export/client.c
> index a1fba01..ea4f89d 100644
> --- a/support/export/client.c
> +++ b/support/export/client.c
> @@ -608,24 +608,36 @@ check_subnetwork(const nfs_client *clp, const struct addrinfo *ai)
>  static int
>  check_wildcard(const nfs_client *clp, const struct addrinfo *ai)
>  {
> -	char *cname = clp->m_hostname;
> -	char *hname = ai->ai_canonname;
> +	char *hname, *cname = clp->m_hostname;
>  	struct hostent *hp;
>  	char **ap;
> +	int match;
>  
> -	if (wildmat(hname, cname))
> -		return 1;
> +	match = 0;
> +
> +	hname = host_canonname(ai->ai_addr);
> +	if (hname == NULL)
> +		goto out;
> +
> +	if (wildmat(hname, cname)) {
> +		match = 1;
> +		goto out;
> +	}
>  
>  	/* See if hname aliases listed in /etc/hosts or nis[+]
>  	 * match the requested wildcard */
>  	hp = gethostbyname(hname);
>  	if (hp != NULL) {
>  		for (ap = hp->h_aliases; *ap; ap++)
> -			if (wildmat(*ap, cname))
> -				return 1;
> +			if (wildmat(*ap, cname)) {
> +				match = 1;
> +				goto out;
> +			}
>  	}
>  
> -	return 0;
> +out:
> +	free(hname);
> +	return match;
>  }
>  
>  /*
> @@ -645,11 +657,9 @@ check_netgroup(const nfs_client *clp, const struct addrinfo *ai)
>  
>  	match = 0;
>  
> -	hname = strdup(ai->ai_canonname);
> -	if (hname == NULL) {
> -		xlog(D_GENERAL, "%s: no memory for strdup", __func__);
> +	hname = host_canonname(ai->ai_addr);
> +	if (hname == NULL)
>  		goto out;
> -	}
>  
>  	/* First, try to match the hostname without
>  	 * splitting off the domain */
> 
