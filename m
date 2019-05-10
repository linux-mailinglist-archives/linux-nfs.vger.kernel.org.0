Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 797A219FD8
	for <lists+linux-nfs@lfdr.de>; Fri, 10 May 2019 17:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfEJPIW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 May 2019 11:08:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbfEJPIW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 10 May 2019 11:08:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2B4803084029
        for <linux-nfs@vger.kernel.org>; Fri, 10 May 2019 15:08:22 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (madhat.boston.devel.redhat.com [10.19.60.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC2B560501
        for <linux-nfs@vger.kernel.org>; Fri, 10 May 2019 15:08:21 +0000 (UTC)
Subject: Re: [PATCH] configure.ac: Turn off cast-function warnings
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20190508130523.14175-1-steved@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <cafb59f5-c388-ec82-d064-add3a4b73086@RedHat.com>
Date:   Fri, 10 May 2019 11:08:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508130523.14175-1-steved@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 10 May 2019 15:08:22 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/8/19 9:05 AM, Steve Dickson wrote:
> The rpcgen generated code from .x files creates
> a cast-function-type warning.
> 
> Due to the age and stability of the code
> turning off the warning makes more sense
> than re-writing the .x files.
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed...

steved.

> ---
>  configure.ac | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configure.ac b/configure.ac
> index e89ca67..4e72790 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -592,6 +592,7 @@ my_am_cflags="\
>   -Werror=parentheses \
>   -Werror=aggregate-return \
>   -Werror=unused-result \
> + -Wno-cast-function-type \
>   -fno-strict-aliasing \
>  "
>  
> 
