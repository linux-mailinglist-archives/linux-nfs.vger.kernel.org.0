Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6F32B0CCF
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 19:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgKLSjH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 13:39:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38981 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726148AbgKLSjH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Nov 2020 13:39:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605206345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TLYlpTmtPif+qTK5NrtIfPW0wVodqMycWBRSSi/2sp4=;
        b=H3TsbCOvAlGC6V64uJbv0yyyGTbW3K+U5x0vBFNPVyD8EJBgG44F9CxttUwsgx/m0X5Q43
        Jpd/1fMeF1ED1CBXucSw0B0Au6pDN+PsgvJATjFHlZ6JLSYgPYKeK1eatQMv/QgjIzl9OJ
        49TD/ugOPdalPEcYF1xeo/HtwDNdDMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-QCFgUSSEOYC_XxHsq5mL7g-1; Thu, 12 Nov 2020 13:39:04 -0500
X-MC-Unique: QCFgUSSEOYC_XxHsq5mL7g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA16F8BE489;
        Thu, 12 Nov 2020 18:39:02 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-194.rdu2.redhat.com [10.10.64.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 867325B4A7;
        Thu, 12 Nov 2020 18:39:02 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     dwysocha@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v5 00/22] Readdir enhancements
Date:   Thu, 12 Nov 2020 13:39:01 -0500
Message-ID: <DC49EB88-4B79-40FC-97C3-47D2A588F96C@redhat.com>
In-Reply-To: <6b07ff95824f5b46237fa07f5f72d8261d764007.camel@hammerspace.com>
References: <20201110213741.860745-1-trondmy@kernel.org>
 <CALF+zOkdXMDZ3TNGSNJQPtxy-ru_4iCYTz3U2uwkPAo3j55FZg@mail.gmail.com>
 <CALF+zO=-Si+CcEJvgzaYAjd2j8APV=4Xwm=FJibhuJRV+zWE5Q@mail.gmail.com>
 <723ef5d47994e34804f5514b06940e96620e2b70.camel@hammerspace.com>
 <6b07ff95824f5b46237fa07f5f72d8261d764007.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 12 Nov 2020, at 13:26, Trond Myklebust wrote:

> On Thu, 2020-11-12 at 16:51 +0000, Trond Myklebust wrote:
>>
>> I was going to ask you if perhaps reverting Scott's commit
>> 07b5ce8ef2d8
>> ("NFS: Make nfs_readdir revalidate less often") might help here?
>> My thinking is that will trigger more cache invalidations when the
>> directory is changing underneath us, and will now trigger uncached
>> readdir in those situations.
>>
>>>
>
> IOW, the suggestion would be to apply something like the following on
> top of the existing readdir patchset:

I'm all for this approach, but - I'm rarely seeing the mapping->nrpages == 0
since the cache is dropped by a process in nfs_readdir() that immediately
starts filling the cache again.

It would make a lot more sense to me if we could do something like stash
desc->page_index << PAGE_SHIFT in f_pos after each nfs_readdir, then the
hueristic could check f_pos >> PAGE_SHIFT > nrpages.

Yes, f_pos is growing many different meanings in NFS directories, maybe we
can stash it on the directory context.

Ben

>
> ---
>  fs/nfs/dir.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 3f70697729d8..384a4663f742 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -956,10 +956,10 @@ static int readdir_search_pagecache(struct
> nfs_readdir_descriptor *desc)
>  {
>  	int res;
>
> -	if (nfs_readdir_dont_search_cache(desc))
> -		return -EBADCOOKIE;
> -
>  	do {
> +		if (nfs_readdir_dont_search_cache(desc))
> +			return -EBADCOOKIE;
> +
>  		if (desc->page_index == 0) {
>  			desc->current_index = 0;
>  			desc->prev_index = 0;
> @@ -1082,11 +1082,9 @@ static int nfs_readdir(struct file *file, struct
> dir_context *ctx)
>  	 * to either find the entry with the appropriate number or
>  	 * revalidate the cookie.
>  	 */
> -	if (ctx->pos == 0 || nfs_attribute_cache_expired(inode)) {
> -		res = nfs_revalidate_mapping(inode, file->f_mapping);
> -		if (res < 0)
> -			goto out;
> -	}
> +	res = nfs_revalidate_mapping(inode, file->f_mapping);
> +	if (res < 0)
> +		goto out;
>
>  	res = -ENOMEM;
>  	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
>
>
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

