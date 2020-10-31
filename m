Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DFA2A18B3
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Oct 2020 17:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgJaQYX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 31 Oct 2020 12:24:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27899 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726586AbgJaQYX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 31 Oct 2020 12:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604161462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LNGLtMIxS2KzaBS6OCaspAZngaWBEk9pvWCTZBso3p4=;
        b=ASEUbrab8pnLPFLrwZUPl5RcciMkYgwbIpfnBcgurCXZfSze0s5A6pLAv1fzjGL92UWMGJ
        enUMDWK9Otzz3sNxinwCVQjqtp74jGii/h49v4ax2e43zP+j4S8IVZ061JRXpmnS1XnHMa
        ZhPkoUYZXq0dJvOKyzaEHHcQ2iKjsaQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-wSD2oVzXOG2rZMlN7dA3mg-1; Sat, 31 Oct 2020 12:24:18 -0400
X-MC-Unique: wSD2oVzXOG2rZMlN7dA3mg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 217EC1006C82;
        Sat, 31 Oct 2020 16:24:17 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-8.phx2.redhat.com [10.3.113.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA00D19D61;
        Sat, 31 Oct 2020 16:24:16 +0000 (UTC)
Subject: Re: [PATCH] nfs-utils: remove leftover debugging messages
To:     =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        linux-nfs@vger.kernel.org
References: <eff057db-38f8-6c5f-7378-8ce1343f84fa@applied-asynchrony.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <237d202e-785a-17e6-07f3-64771bfa6297@RedHat.com>
Date:   Sat, 31 Oct 2020 12:24:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <eff057db-38f8-6c5f-7378-8ce1343f84fa@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 10/29/20 5:18 PM, Holger Hoffstätte wrote:
> 
> After updating to nfs-utils-2.5.2 I noticed extra output on the console
> when exporting mounts. Apparently commit 482e72ba04 forgot to remove some
> debugging messages and accidentally committed them.
> 
> Signed-off-by: Holger Hoffstätte <holger@applied-asynchrony.com>
WOW! I did skip a beat on this one! Thanks for the clean up!!!

Committed!

steved.
> ---
>  support/misc/nfsd_path.c  | 2 +-
>  utils/exportfs/exportfs.c | 3 ---
>  2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/support/misc/nfsd_path.c b/support/misc/nfsd_path.c
> index 8efbfcd3..65e53c13 100644
> --- a/support/misc/nfsd_path.c
> +++ b/support/misc/nfsd_path.c
> @@ -110,7 +110,7 @@ nfsd_setup_workqueue(void)
>  
>      if (!rootdir)
>          return;
> -printf("rootdir %s\n", rootdir);
> +
>      nfsd_wq = xthread_workqueue_alloc();
>      if (!nfsd_wq)
>          return;
> diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
> index 9d5e575b..cde5e517 100644
> --- a/utils/exportfs/exportfs.c
> +++ b/utils/exportfs/exportfs.c
> @@ -176,10 +176,8 @@ main(int argc, char **argv)
>          xlog(L_ERROR, "-r and -u are incompatible");
>          return 1;
>      }
> -printf("point 1\n");
>      if (!setup_state_path_names(progname, ETAB, ETABTMP, ETABLCK, &etab))
>          return 1;
> -printf("point 2\n");
>      if (optind == argc && ! f_all) {
>          if (force_flush) {
>              cache_flush(1);
> @@ -193,7 +191,6 @@ printf("point 2\n");
>              return 0;
>          }
>      }
> -printf("point 3\n");
>  
>      /*
>       * Serialize things as best we can

