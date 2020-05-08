Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F381F1CB178
	for <lists+linux-nfs@lfdr.de>; Fri,  8 May 2020 16:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgEHOLV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 May 2020 10:11:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40886 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726950AbgEHOLV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 May 2020 10:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588947080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zOxd17GPJsksbtIiFLrt1KLKzryhCynBuMT1pI86iec=;
        b=VptYFLp06TBJcoDYHB4P72AvUrJSZ4grBo0DSF6mNx6X4vpTAZUBkEDweIfVrKQIP61Lpt
        ob8M0/0ZRgTtiaUfzv3Fxf66N57M/uPNzKkgDEWLWVdGDBaZaQ9etFOxCcz+swkAvD4Drd
        YuasqFcl5sTNM2oZEG6Y69kd9+ZhszA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-uTZOW0HjOJm4InC0dkLLew-1; Fri, 08 May 2020 10:11:18 -0400
X-MC-Unique: uTZOW0HjOJm4InC0dkLLew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16E9FA0BD9;
        Fri,  8 May 2020 14:11:17 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-12.phx2.redhat.com [10.3.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88DB062ABC;
        Fri,  8 May 2020 14:11:16 +0000 (UTC)
Subject: Re: [PATCH] mountd: Preserve special characters in refer and replica
 path options
To:     trondmy@kernel.org
Cc:     Lance Shelton <lance.shelton@hammerspace.com>,
        linux-nfs@vger.kernel.org
References: <20200416213722.80201-1-trondmy@kernel.org>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <e4d69b30-1015-b5c4-1003-1a9fe28b2622@RedHat.com>
Date:   Fri, 8 May 2020 10:11:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200416213722.80201-1-trondmy@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/16/20 5:37 PM, trondmy@kernel.org wrote:
> From: Lance Shelton <lance.shelton@hammerspace.com>
> 
> Allow referral paths to contain special character by adding an
> escaping mechanism.
> 
> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  support/nfs/exports.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
Committed... (tag: nfs-utils-2-4-4-rc4)

steved.

> 
> diff --git a/support/nfs/exports.c b/support/nfs/exports.c
> index 8fbb6b15c299..97eb31837816 100644
> --- a/support/nfs/exports.c
> +++ b/support/nfs/exports.c
> @@ -247,23 +247,28 @@ void secinfo_show(FILE *fp, struct exportent *ep)
>  	}
>  }
>  
> +static void
> +fprintpath(FILE *fp, const char *path)
> +{
> +	int i;
> +	for (i=0; path[i]; i++)
> +		if (iscntrl(path[i]) || path[i] == '"' || path[i] == '\\' || path[i] == '#' || isspace(path[i]))
> +			fprintf(fp, "\\%03o", path[i]);
> +		else
> +			fprintf(fp, "%c", path[i]);
> +}
> +
>  void
>  putexportent(struct exportent *ep)
>  {
>  	FILE	*fp;
>  	int	*id, i;
> -	char	*esc=ep->e_path;
>  
>  	if (!efp)
>  		return;
>  
>  	fp = efp->x_fp;
> -	for (i=0; esc[i]; i++)
> -	        if (iscntrl(esc[i]) || esc[i] == '"' || esc[i] == '\\' || esc[i] == '#' || isspace(esc[i]))
> -			fprintf(fp, "\\%03o", esc[i]);
> -		else
> -			fprintf(fp, "%c", esc[i]);
> -
> +	fprintpath(fp, ep->e_path);
>  	fprintf(fp, "\t%s(", ep->e_hostname);
>  	fprintf(fp, "%s,", (ep->e_flags & NFSEXP_READONLY)? "ro" : "rw");
>  	fprintf(fp, "%ssync,", (ep->e_flags & NFSEXP_ASYNC)? "a" : "");
> @@ -302,10 +307,14 @@ putexportent(struct exportent *ep)
>  	case FSLOC_NONE:
>  		break;
>  	case FSLOC_REFER:
> -		fprintf(fp, "refer=%s,", ep->e_fslocdata);
> +		fprintf(fp, "refer=");
> +		fprintpath(fp, ep->e_fslocdata);
> +		fprintf(fp, ",");
>  		break;
>  	case FSLOC_REPLICA:
> -		fprintf(fp, "replicas=%s,", ep->e_fslocdata);
> +		fprintf(fp, "replicas=");
> +		fprintpath(fp, ep->e_fslocdata);
> +		fprintf(fp, ",");
>  		break;
>  #ifdef DEBUG
>  	case FSLOC_STUB:
> 

