Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1273357449
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Apr 2021 20:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355293AbhDGS2Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Apr 2021 14:28:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29327 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355247AbhDGS2O (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Apr 2021 14:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617820084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sa71qRprNwfgzLcPFVKiyVQP/xPLIdg7V1SGge3U7CY=;
        b=ENfGIkn9pGIaxGmjshJXce94DFagcQ1hH40+mJEvYwR8O53Q3bQ+EA8P+EGfMZGdYWaxzm
        uomnv30jir2nwgvJbHtjkCWLD7xLO4MtJyj/ROYRNCCLbv40FMNihW287/YIqoMfRFBD1X
        8RBQwprLfQ607DszkPbP/Ry0xgDgXQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-Vof35Xr4OEOKEVE1fhJkCw-1; Wed, 07 Apr 2021 14:28:02 -0400
X-MC-Unique: Vof35Xr4OEOKEVE1fhJkCw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24A091006CBF
        for <linux-nfs@vger.kernel.org>; Wed,  7 Apr 2021 18:28:02 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-148.phx2.redhat.com [10.3.112.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3F525D9D0;
        Wed,  7 Apr 2021 18:28:01 +0000 (UTC)
Subject: Re: [PATCH] exportfs: make root unexportable
To:     Roberto Bergantinos Corpas <rbergant@redhat.com>
Cc:     linux-nfs@vger.kernel.org
References: <20210329105435.17431-1-rbergant@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <a4722e51-5e42-605d-dbc0-bb00ee37d986@RedHat.com>
Date:   Wed, 7 Apr 2021 14:30:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210329105435.17431-1-rbergant@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

On 3/29/21 6:54 AM, Roberto Bergantinos Corpas wrote:
> If root of the filesystem is exported, it cannot be explicitly
> unexported, since unexportfs_parsed, in order to deal with trailing
> '/', will leave nlen at 0 for root exported case
> 
> Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
> ---
>  utils/exportfs/exportfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
> index 9fcae0b3..9b6f4f5a 100644
> --- a/utils/exportfs/exportfs.c
> +++ b/utils/exportfs/exportfs.c
> @@ -372,7 +372,7 @@ unexportfs_parsed(char *hname, char *path, int verbose)
>  	 * so need to deal with it.
>  	*/
>  	size_t nlen = strlen(path);
> -	while (path[nlen - 1] == '/')
> +	while ((path[nlen - 1] == '/') && (nlen > 1))
>  		nlen--;
I decided to use Ondrej's version sine the nlen is tested
first before the index into path was made.

steved.
>  
>  	for (exp = exportlist[htype].p_head; exp; exp = exp->m_next) {
> 

