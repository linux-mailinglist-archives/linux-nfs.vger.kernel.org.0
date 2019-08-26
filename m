Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 589AA9D55A
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2019 20:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbfHZSDF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 14:03:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39857 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731879AbfHZSDF (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Aug 2019 14:03:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5830D10C030C;
        Mon, 26 Aug 2019 18:03:05 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-35.phx2.redhat.com [10.3.116.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0F46196AE;
        Mon, 26 Aug 2019 18:03:04 +0000 (UTC)
Subject: Re: [PATCH 1/3] mount: fix compilation if __GLIBC__ is not defined
To:     Patrick Steinhardt <ps@pks.im>, linux-nfs@vger.kernel.org
References: <6de0089348765e60bcdf59ef5813d7bb631c967f.1566805721.git.ps@pks.im>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <8a22b4ac-ada6-83b1-361a-62b74f957878@RedHat.com>
Date:   Mon, 26 Aug 2019 14:03:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6de0089348765e60bcdf59ef5813d7bb631c967f.1566805721.git.ps@pks.im>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Mon, 26 Aug 2019 18:03:05 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 8/26/19 3:48 AM, Patrick Steinhardt wrote:
> As glibc versions before v2.24 couldn't safely include <linux/in6.h>,
> commit 8af595b7 (mount: support compiling with old glibc, 2017-07-26)
> introduced some preprocessor checks to special-case such old versions.
> While there is a check whether __GLIBC__ is defined at all, it only
> applies to the first comparison `__GLIBC__ < 2`, but doesn't apply to
> the second check due to operator precedence. Thus the preprocessor may
> use an undefined value and thus generate an error if __GLIBC__ is not
> defined.
> 
> Fix the issue by wrapping the version check in braces.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
Commited....

steved.
> ---
>  utils/mount/network.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/utils/mount/network.c b/utils/mount/network.c
> index e166a823..6ac913d9 100644
> --- a/utils/mount/network.c
> +++ b/utils/mount/network.c
> @@ -39,7 +39,7 @@
>  #include <sys/socket.h>
>  #include <sys/wait.h>
>  #include <sys/stat.h>
> -#if defined(__GLIBC__) && (__GLIBC__ < 2) || (__GLIBC__ == 2 && __GLIBC_MINOR__ < 24)
> +#if defined(__GLIBC__) && ((__GLIBC__ < 2) || (__GLIBC__ == 2 && __GLIBC_MINOR__ < 24))
>  /* Cannot safely include linux/in6.h in old glibc, so hardcode the needed values */
>  # define IPV6_PREFER_SRC_PUBLIC 2
>  # define IPV6_ADDR_PREFERENCES 72
> 
