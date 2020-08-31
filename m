Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F03F257E6D
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Aug 2020 18:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgHaQPe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Aug 2020 12:15:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23647 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727957AbgHaQPd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Aug 2020 12:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598890533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=So2Y8AXDxtsu4IofkGl5YvRSgvYHtYDajJWY0boNKlc=;
        b=VgKoAxrFxOHqn39yzmkXBM7eUVrrAXuHO0J9mNCfJCKJhF7+XhP3Rdu5RBSz0PuMP8Ca5o
        S3j6YATSRj7FugKfATPojfuyv7yBCVSgDW0Phrinf7WG3yDKJMhZdvKo1kfAGB89XveIfH
        J2vMH+6C80s24O2kZs1BVeYAw8unSJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-2BqG0kf0OiCIEGN4A7bydQ-1; Mon, 31 Aug 2020 12:15:31 -0400
X-MC-Unique: 2BqG0kf0OiCIEGN4A7bydQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF1B381CBDD
        for <linux-nfs@vger.kernel.org>; Mon, 31 Aug 2020 16:15:30 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-190.phx2.redhat.com [10.3.113.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80BE2747B0
        for <linux-nfs@vger.kernel.org>; Mon, 31 Aug 2020 16:15:30 +0000 (UTC)
Subject: Re: [PATCH] rpc.gssd: munmap_chunk(): invalid pointer
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20200831161135.146867-1-steved@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <8c465f9f-ea73-69f0-6ac3-75a34e0ea658@RedHat.com>
Date:   Mon, 31 Aug 2020 12:15:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200831161135.146867-1-steved@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 8/31/20 12:11 PM, Steve Dickson wrote:
> Removed an errant call to gss_release_oid()
> to try and deal with memory leaks
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... (tag: nfs-utils-2-5-2-rc4)

steved.

> ---
>  utils/gssd/gssd_proc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
> index 2a8b618..e830f49 100644
> --- a/utils/gssd/gssd_proc.c
> +++ b/utils/gssd/gssd_proc.c
> @@ -687,7 +687,6 @@ process_krb5_upcall(struct clnt_info *clp, uid_t uid, int fd, char *srchost,
>  	} else {
>  		get_hostbased_client_buffer(gacceptor, mech, &acceptor);
>  		gss_release_name(&min_stat, &gacceptor);
> -		gss_release_oid(&min_stat, &mech);
>  	}
>  
>  	/*
> 

