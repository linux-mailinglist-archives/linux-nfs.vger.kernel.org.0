Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB62A30C6EC
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 18:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237170AbhBBREd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 12:04:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27565 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236318AbhBBRAv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Feb 2021 12:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612285162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LqPjowFOIhHHzFKRXTk+xJ9T1CMz1/doRKVSIXtmAf4=;
        b=Rfc3diGilomWUNPFmyC3fFFc/L6KiArjheswMUcvpA8Rmj28tfR8iaBbG1g3f3unV71r7P
        tryxExBOGYHGQoCWEHwtV+qVfagSyWa+aO7pnA7Ag7KIArjj/yLCbZ6U6rr52mBMPuRJfm
        rwRvX1I0Nn19YH49PgCKySrrrEEcDN4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-Qgg8fp4dORaQpbvmK-sJ0A-1; Tue, 02 Feb 2021 11:59:21 -0500
X-MC-Unique: Qgg8fp4dORaQpbvmK-sJ0A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 324DB804004;
        Tue,  2 Feb 2021 16:59:20 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-114-82.phx2.redhat.com [10.3.114.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E00625C1CF;
        Tue,  2 Feb 2021 16:59:19 +0000 (UTC)
Subject: Re: [PATCH nfs-utils v2] mount: fix parsing of default options
To:     NeilBrown <neilb@suse.de>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20210106184028.150925-1-steved@redhat.com>
 <87o8h8fx7a.fsf@notabene.neil.brown.name>
 <87lfccfx5t.fsf@notabene.neil.brown.name>
 <875z3cfklw.fsf@notabene.neil.brown.name>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <6a5fc99d-90e7-b58b-7650-d1d294cad6ef@RedHat.com>
Date:   Tue, 2 Feb 2021 12:00:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <875z3cfklw.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2/1/21 12:00 AM, NeilBrown wrote:
> 
> A recent patch to change configfile.c to use parse_opt.c contained code
> which was intended to remove all "default*" options from the list before
> that could be passed to the kernel.  This code didn't work, so default*
> options WERE passed to the kernel, and the kernel complained and failed
> the mount attempt.
> 
> A more recent patch attempted to fix this by not including the
> "default*" options in the option list at all.  This resulting in
> global-default defaults over-riding per-mount or per-server defaults.
> 
> This patch reverse the "more recent" patch, and fixes the original patch
> by providing correct code to remove all "default*" options before the
> kernel can see them.
> 
> Fixes: 88c22f924f1b ("mount: convert configfile.c to use parse_opt.c")
> Fixes: 8142542bda28 ("mount: parse default values correctly")
> Signed-off-by: NeilBrown <neilb@suse.de>
Committed.... (tag: nfs-utils-2-5-3-rc5)

steved.
> ---
> 
> I realized that po_remove_all() could free 'ptr' and then compare it
> against the next option, which would have undefined results.
> So best to strdup and free it.
> 
> 
>  utils/mount/configfile.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/utils/mount/configfile.c b/utils/mount/configfile.c
> index e865998dd5a9..3d3684efa186 100644
> --- a/utils/mount/configfile.c
> +++ b/utils/mount/configfile.c
> @@ -277,10 +277,9 @@ conf_parse_mntopts(char *section, char *arg, struct mount_options *options)
>  		}
>  		if (buf[0] == '\0')
>  			continue;
> -		if (default_value(buf))
> -			continue;
>  
>  		po_append(options, buf);
> +		default_value(buf);
>  	}
>  	conf_free_list(list);
>  }
> @@ -335,7 +334,11 @@ char *conf_get_mntopts(char *spec, char *mount_point,
>  	 * Strip out defaults, which have already been handled,
>  	 * then join the rest and return.
>  	 */
> -	po_remove_all(options, "default");
> +	while (po_contains_prefix(options, "default", &ptr, 0) == PO_FOUND) {
> +		ptr = strdup(ptr);
> +		po_remove_all(options, ptr);
> +		free(ptr);
> +	}
>  
>  	po_join(options, &mount_opts);
>  	po_destroy(options);
> 

