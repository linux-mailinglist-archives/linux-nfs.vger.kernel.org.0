Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8ACA23F46
	for <lists+linux-nfs@lfdr.de>; Mon, 20 May 2019 19:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390979AbfETRnH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 May 2019 13:43:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390970AbfETRnH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 20 May 2019 13:43:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 42FEA3082E69
        for <linux-nfs@vger.kernel.org>; Mon, 20 May 2019 17:43:07 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-44.phx2.redhat.com [10.3.116.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E15360BEC
        for <linux-nfs@vger.kernel.org>; Mon, 20 May 2019 17:43:06 +0000 (UTC)
Subject: Re: [PATCH] mount: Report correct error in the fall_back cases.
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20190514200418.19902-1-steved@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <32b5b347-7c97-fbd9-6534-8a675163a945@RedHat.com>
Date:   Mon, 20 May 2019 13:43:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514200418.19902-1-steved@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 20 May 2019 17:43:07 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/14/19 4:04 PM, Steve Dickson wrote:
> In mount auto negotiation, a v3 mount is tried
> when the v4 fails with error that could mean
> v4 is not supported.
> 
> When the v3 mount fails, the original v4 failure
> should be used to set the errno, not the v3 failure.
> 
> Fixes:https://bugzilla.redhat.com/show_bug.cgi?id=1709961
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed.... 

steved,
> ---
>  utils/mount/stropts.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
> index 1bb7a73..901f995 100644
> --- a/utils/mount/stropts.c
> +++ b/utils/mount/stropts.c
> @@ -889,7 +889,7 @@ out:
>   */
>  static int nfs_autonegotiate(struct nfsmount_info *mi)
>  {
> -	int result;
> +	int result, olderrno;
>  
>  	result = nfs_try_mount_v4(mi);
>  check_result:
> @@ -949,7 +949,18 @@ fall_back:
>  	if (mi->version.v_mode == V_GENERAL)
>  		/* v2,3 fallback not allowed */
>  		return result;
> -	return nfs_try_mount_v3v2(mi, FALSE);
> +
> +	/*
> +	 * Save the original errno in case the v3 
> +	 * mount fails from one of the fall_back cases. 
> +	 * Report the first failure not the v3 mount failure
> +	 */
> +	olderrno = errno;
> +	if ((result = nfs_try_mount_v3v2(mi, FALSE)))
> +		return result;
> +
> +	errno = olderrno;
> +	return result;
>  }
>  
>  /*
> 
