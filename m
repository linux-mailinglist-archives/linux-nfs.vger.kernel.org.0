Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43FA91076FE
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Nov 2019 19:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfKVSJY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Nov 2019 13:09:24 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25801 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726686AbfKVSJY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Nov 2019 13:09:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574446162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EGJBXq+KB12nGwgTY7Z0hcDMm/Nad6LYB8Fyiq7XiAM=;
        b=ZVZVffFS3Nyqrcsm7o5BBttCy/ijKN9dSNp067VbYfqCK1i7lkXU3wMaW9dleDolnod3IM
        miTo+O2wAXJgUcvXUs9jBUjcbb7ETlfZgap8LA24DlbiP/KqMLxp0s/JMjYe6Io/1S95tI
        c6H+6FXhl+U5hD91xv7GlSZ3JGWPOnU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-1MwSBjmgPtivOsWVIfw2yg-1; Fri, 22 Nov 2019 13:09:19 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E43B8FFAC1;
        Fri, 22 Nov 2019 18:09:18 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-36.phx2.redhat.com [10.3.117.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32A366E720;
        Fri, 22 Nov 2019 18:09:18 +0000 (UTC)
Subject: Re: [nfs-utils PATCH 1/1] mount: Fix return 0 from void function
To:     Petr Vorel <petr.vorel@gmail.com>, linux-nfs@vger.kernel.org
References: <20191122162528.18199-1-petr.vorel@gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <d1bb4228-977e-0b8c-23bd-7eac5447d659@RedHat.com>
Date:   Fri, 22 Nov 2019 13:09:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191122162528.18199-1-petr.vorel@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 1MwSBjmgPtivOsWVIfw2yg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/22/19 11:25 AM, Petr Vorel wrote:
> Fixes: d5e30346 ("mount: Do not overwrite /etc/mtab if it's symlink")
> 
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> ---
> Hi Steve,
> 
> sorry for introducing a regression.
No biggie... I should have caught it and I would think the 
compiler should say something... Throw a warning or something.

Committed (tag: nfs-utils-2-4-3-rc2)

steved.

> 
> Kind regards,
> Petr
> 
>  utils/mount/mount.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/utils/mount/mount.c b/utils/mount/mount.c
> index 92a0dfe4..2be3dc2f 100644
> --- a/utils/mount/mount.c
> +++ b/utils/mount/mount.c
> @@ -208,7 +208,7 @@ create_mtab (void) {
>  	   that would create a file /proc/mounts in case the proc filesystem
>  	   is not mounted, and the fchmod below would also fail. */
>  	if (mtab_is_a_symlink()) {
> -		return EX_SUCCESS;
> +		return;
>  	}
>  
>  	lock_mtab();
> 

