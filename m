Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4D479D55C
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2019 20:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731753AbfHZSDg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 14:03:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53046 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731879AbfHZSDg (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Aug 2019 14:03:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 32B8CC054907;
        Mon, 26 Aug 2019 18:03:36 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-35.phx2.redhat.com [10.3.116.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E140660920;
        Mon, 26 Aug 2019 18:03:35 +0000 (UTC)
Subject: Re: [PATCH 2/3] nfsdcld: add missing include for PATH_MAX
To:     Patrick Steinhardt <ps@pks.im>, linux-nfs@vger.kernel.org
References: <6de0089348765e60bcdf59ef5813d7bb631c967f.1566805721.git.ps@pks.im>
 <15b474e6fa7aee12e64e4376f7716a232e40100a.1566805721.git.ps@pks.im>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <06e5c667-a5dd-4b37-b31b-8db384e33dbd@RedHat.com>
Date:   Mon, 26 Aug 2019 14:03:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <15b474e6fa7aee12e64e4376f7716a232e40100a.1566805721.git.ps@pks.im>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 26 Aug 2019 18:03:36 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 8/26/19 3:48 AM, Patrick Steinhardt wrote:
> While glibc transitively includes <limits.h> and thus has PATH_MAX
> available, other libc implementations may not have the transitive
> include and thus miss the definition. Add an explicit include of
> <limits.h> to fix compilation with musl libc.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
Committed... 

steved.
> ---
>  utils/nfsdcld/legacy.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/utils/nfsdcld/legacy.c b/utils/nfsdcld/legacy.c
> index f0ca3168..07f477ab 100644
> --- a/utils/nfsdcld/legacy.c
> +++ b/utils/nfsdcld/legacy.c
> @@ -24,6 +24,7 @@
>  #include <errno.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> +#include <limits.h>
>  #include "cld.h"
>  #include "sqlite.h"
>  #include "xlog.h"
> 
