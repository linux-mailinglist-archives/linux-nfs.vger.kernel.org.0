Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD2E33C89F
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Mar 2021 22:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbhCOVmZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Mar 2021 17:42:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46914 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233479AbhCOVmO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Mar 2021 17:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615844533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fdrQLXPbpA6XJI59PEuwm+soL03/ADYRdyC/LN2Owog=;
        b=B1/wv/6QUcTaxcHNn/od7fiUW3s/VrEM0Y5ji7RniIyJVudG4xcjeJjiu4VWSxi+yg2erh
        DHgEiB7hkiuNmiTvIvU1C3x6f5dJSKt3/OLuEJIRrotgZzJoSAXUFC/2ykKM7GDpEe7xre
        wWOOdLCW/f5qXnwMHXN61ldVnY2JGDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-AriJSH_bMz2lzKdI7lnIhw-1; Mon, 15 Mar 2021 17:42:11 -0400
X-MC-Unique: AriJSH_bMz2lzKdI7lnIhw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8614FA40C0;
        Mon, 15 Mar 2021 21:42:10 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-22.phx2.redhat.com [10.3.112.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A33C60C0F;
        Mon, 15 Mar 2021 21:42:10 +0000 (UTC)
Subject: Re: [PATCH] libtirpc: disallow calling auth_refresh from clnt_call
 with RPCSEC_GSS
To:     Scott Mayhew <smayhew@redhat.com>,
        libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org
References: <20210304191955.1928383-1-smayhew@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <dc1a97bb-c09c-cb10-1f46-7fe83c254edc@RedHat.com>
Date:   Mon, 15 Mar 2021 17:43:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210304191955.1928383-1-smayhew@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/4/21 2:19 PM, Scott Mayhew wrote:
> Disallow calling auth_refresh from clnt_{dg,vc}_call if the client is
> using RPCSEC_GSS.  Doing so can recurse back into clnt_{dg,vc}_call,
> where we'll self-deadlock waiting on the condition variable.
> 
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Committed... (tag: libtirpc-1-3-2-rc1)

steved.

> ---
>  src/auth_gss.c       | 6 ++++++
>  src/clnt_dg.c        | 8 ++++++++
>  src/clnt_vc.c        | 9 +++++++++
>  tirpc/rpc/auth_gss.h | 2 ++
>  4 files changed, 25 insertions(+)
> 
> diff --git a/src/auth_gss.c b/src/auth_gss.c
> index d871672..e317664 100644
> --- a/src/auth_gss.c
> +++ b/src/auth_gss.c
> @@ -982,3 +982,9 @@ rpc_gss_max_data_length(AUTH *auth, int maxlen)
>  	rpc_gss_clear_error();
>  	return result;
>  }
> +
> +bool_t
> +is_authgss_client(CLIENT *clnt)
> +{
> +	return (clnt->cl_auth->ah_ops == &authgss_ops);
> +}
> diff --git a/src/clnt_dg.c b/src/clnt_dg.c
> index abc09f1..e1255de 100644
> --- a/src/clnt_dg.c
> +++ b/src/clnt_dg.c
> @@ -61,6 +61,9 @@
>  #include <sys/uio.h>
>  #endif
>  
> +#ifdef HAVE_RPCSEC_GSS
> +#include <rpc/auth_gss.h>
> +#endif
>  
>  #define MAX_DEFAULT_FDS                 20000
>  
> @@ -334,6 +337,11 @@ clnt_dg_call(cl, proc, xargs, argsp, xresults, resultsp, utimeout)
>  		salen = cu->cu_rlen;
>  	}
>  
> +#ifdef HAVE_RPCSEC_GSS
> +	if (is_authgss_client(cl))
> +		nrefreshes = 0;
> +#endif
> +
>  	/* Clean up in case the last call ended in a longjmp(3) call. */
>  call_again:
>  	xdrs = &(cu->cu_outxdrs);
> diff --git a/src/clnt_vc.c b/src/clnt_vc.c
> index 6f7f7da..a07e297 100644
> --- a/src/clnt_vc.c
> +++ b/src/clnt_vc.c
> @@ -69,6 +69,10 @@
>  #include "rpc_com.h"
>  #include "clnt_fd_locks.h"
>  
> +#ifdef HAVE_RPCSEC_GSS
> +#include <rpc/auth_gss.h>
> +#endif
> +
>  #define MCALL_MSG_SIZE 24
>  
>  #define CMGROUP_MAX    16
> @@ -363,6 +367,11 @@ clnt_vc_call(cl, proc, xdr_args, args_ptr, xdr_results, results_ptr, timeout)
>  	    (xdr_results == NULL && timeout.tv_sec == 0
>  	    && timeout.tv_usec == 0) ? FALSE : TRUE;
>  
> +#ifdef HAVE_RPCSEC_GSS
> +	if (is_authgss_client(cl))
> +		refreshes = 0;
> +#endif
> +
>  call_again:
>  	xdrs->x_op = XDR_ENCODE;
>  	ct->ct_error.re_status = RPC_SUCCESS;
> diff --git a/tirpc/rpc/auth_gss.h b/tirpc/rpc/auth_gss.h
> index 5316ed6..f2af6e9 100644
> --- a/tirpc/rpc/auth_gss.h
> +++ b/tirpc/rpc/auth_gss.h
> @@ -120,6 +120,8 @@ void	gss_log_debug		(const char *fmt, ...);
>  void	gss_log_status		(char *m, OM_uint32 major, OM_uint32 minor);
>  void	gss_log_hexdump		(const u_char *buf, int len, int offset);
>  
> +bool_t	is_authgss_client	(CLIENT *);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> 

