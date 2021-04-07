Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2C9357434
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Apr 2021 20:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344889AbhDGS0M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Apr 2021 14:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29657 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355208AbhDGS0K (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Apr 2021 14:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617819960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NdNCtvjn0O9GP49ujE97/4sBczuYYWzVt/b7EPyJKJA=;
        b=fbripXxH7tJfxpSRpGDMsVlAr6GI7sDwb3czqg1RjgAJgGd+4uaTx4hW3PjX8Q2N2Hs6dB
        vzqqhRon2uB3yIY7N+J3cWQxM9I3OySQreZnjyQRVmVOXFbAn5fDxErQHecfW4/+v6g+TS
        Fl+L4oHiF6+kP1Lb4O+Rjqye1kBGcB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-GZTug9U0NlueMLIWKbIDOg-1; Wed, 07 Apr 2021 14:25:57 -0400
X-MC-Unique: GZTug9U0NlueMLIWKbIDOg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C42EF10054F6
        for <linux-nfs@vger.kernel.org>; Wed,  7 Apr 2021 18:25:56 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-148.phx2.redhat.com [10.3.112.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8087A5D6CF;
        Wed,  7 Apr 2021 18:25:56 +0000 (UTC)
Subject: Re: [PATCH] exportfs: fix unexporting of '/'
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     linux-nfs@vger.kernel.org
References: <20210322210238.96915-1-omosnace@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <51d09ad3-c439-08a7-49f9-4c55a5637798@RedHat.com>
Date:   Wed, 7 Apr 2021 14:28:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210322210238.96915-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/22/21 5:02 PM, Ondrej Mosnacek wrote:
> The code that has been added to strip trailing slashes from path in
> unexportfs_parsed() forgot to account for the case of the root
> directory, which is simply '/'. In that case it accesses path[-1] and
> reduces the path to an empty string, which then fails to match any
> export.
> 
> Fix it by stopping the stripping when the path is just a single
> character - it doesn't matter if it's a '/' or not, we want to keep it
> either way in that case.
> 
> Reproducer:
> 
>     exportfs localhost:/
>     exportfs -u localhost:/
> 
> Without this patch, the unexport step fails with "exportfs: Could not
> find 'localhost:/' to unexport."
> 
> Fixes: a9a7728d8743 ("exportfs: Deal with path's trailing "/" in unexportfs_parsed()")
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1941171
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Committed... (tag: nfs-utils-2-5-4-rc2)

steved.

> ---
>  utils/exportfs/exportfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
> index 262dd19a..1aedd3d6 100644
> --- a/utils/exportfs/exportfs.c
> +++ b/utils/exportfs/exportfs.c
> @@ -383,7 +383,7 @@ unexportfs_parsed(char *hname, char *path, int verbose)
>  	 * so need to deal with it.
>  	*/
>  	size_t nlen = strlen(path);
> -	while (path[nlen - 1] == '/')
> +	while (nlen > 1 && path[nlen - 1] == '/')
>  		nlen--;
>  
>  	for (exp = exportlist[htype].p_head; exp; exp = exp->m_next) {
> 

