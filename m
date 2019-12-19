Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7FEC1268DB
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2019 19:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLSSUi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Dec 2019 13:20:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33526 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726797AbfLSSUh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Dec 2019 13:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576779636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ASxBVEdQlAyyKcUj7UyeCQWZjbf/Z6PLZtdzHIKn9k=;
        b=KnEehBFfhFg08w9/x90BkBt3biZqS9iyCZ2F6oAlJI+9sQkODdnaj0Wne4QaVFBrenLc0J
        k6lKr198FoNFw5G/uOUKIf+vUIv8Q5WAb3hSBadI0JGEg+eHWGFw15Ef86zLaG2XfCZUNx
        x0R1mqn7M3KcE/rEymKh+kzqlxECP+c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-HoLpBUuUPTmFLySYG9vRKQ-1; Thu, 19 Dec 2019 13:20:34 -0500
X-MC-Unique: HoLpBUuUPTmFLySYG9vRKQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA19E107ACC5
        for <linux-nfs@vger.kernel.org>; Thu, 19 Dec 2019 18:20:33 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-81.phx2.redhat.com [10.3.116.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84EB5620BE
        for <linux-nfs@vger.kernel.org>; Thu, 19 Dec 2019 18:20:33 +0000 (UTC)
Subject: Re: [PATCH] libnfsidmap: Turn off default verbosity
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20191219175452.14317-1-steved@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <06c33d98-736a-8a51-312c-617f843e0b94@RedHat.com>
Date:   Thu, 19 Dec 2019 13:20:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219175452.14317-1-steved@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 12/19/19 12:54 PM, Steve Dickson wrote:
> Commit f080188e changed the library's verbosity
> to be on by default. The patch turns it off by
> default
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1774787
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed...

steved.
> ---
>  support/nfsidmap/libnfsidmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/support/nfsidmap/libnfsidmap.c b/support/nfsidmap/libnfsidmap.c
> index 9299e65..d11710f 100644
> --- a/support/nfsidmap/libnfsidmap.c
> +++ b/support/nfsidmap/libnfsidmap.c
> @@ -101,7 +101,7 @@ static void default_logger(const char *fmt, ...)
>  
>  #pragma GCC visibility pop
>  nfs4_idmap_log_function_t idmap_log_func = default_logger;
> -int idmap_verbosity = 2;
> +int idmap_verbosity = 0;
>  #pragma GCC visibility push(hidden)
>  
>  static int id_as_chars(char *name, uid_t *id)
> 

