Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCCB77DFFB
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Aug 2019 18:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732865AbfHAQUx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Aug 2019 12:20:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731915AbfHAQUx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 1 Aug 2019 12:20:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90BFD30C2B8B
        for <linux-nfs@vger.kernel.org>; Thu,  1 Aug 2019 16:20:52 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-78.phx2.redhat.com [10.3.117.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CAA2C5E7B5;
        Thu,  1 Aug 2019 16:20:47 +0000 (UTC)
Subject: Re: [PATCH] nfs-utils: Fix memory leak on error in
 nfs-server-generator
To:     Alice J Mitchell <ajmitchell@redhat.com>, linux-nfs@vger.kernel.org
References: <1564657141.8625.7.camel@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <3543e83f-f79b-2683-6249-4a8c22857852@RedHat.com>
Date:   Thu, 1 Aug 2019 12:20:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564657141.8625.7.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 01 Aug 2019 16:20:52 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 8/1/19 6:59 AM, Alice J Mitchell wrote:
> Fix the trivial memory leak in the error handling of nfs-server-generator
> 
> Signed-off-by: Alice J Mitchell <ajmitchell@redhat.com>
Committed... 

steved.
> ---
>  systemd/nfs-server-generator.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/systemd/nfs-server-generator.c b/systemd/nfs-server-generator.c
> index 737f109..eec98fd 100644
> --- a/systemd/nfs-server-generator.c
> +++ b/systemd/nfs-server-generator.c
> @@ -25,6 +25,7 @@
>  #include <ctype.h>
>  #include <stdio.h>
>  #include <mntent.h>
> +#include <alloca.h>
>  
>  #include "misc.h"
>  #include "nfslib.h"
> @@ -98,7 +99,7 @@ int main(int argc, char *argv[])
>  		exit(1);
>  	}
>  
> -	path = malloc(strlen(argv[1]) + sizeof(dirbase) + sizeof(filebase));
> +	path = alloca(strlen(argv[1]) + sizeof(dirbase) + sizeof(filebase));
>  	if (!path)
>  		exit(2);
>  	if (export_read(_PATH_EXPORTS, 1) +
> 
