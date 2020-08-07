Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B331623EFD4
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Aug 2020 17:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgHGPLy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Aug 2020 11:11:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30982 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725893AbgHGPLy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 Aug 2020 11:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596813112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pPuxnFHo3jjZjpkhbXsaIuwya0Ld+Dzk4mQeLTjZGNs=;
        b=L2RDxf9R1/ytVe3zSjP3uBUyj7BkghXwwyqpa/4WPDCOuTPckyoE5TlVCeXChL9XnznKej
        O+klK8qbvsoRo+Vf4q1bdyCWiIEQFgjKsmlun9WFAmmLPNYuLSphCdT/Cq6dqCSXePgJL0
        V24W1fd8Y+aDX1eL0jArwfnLrEb+TB8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-LmjF-B8jPxKXWvHC43ADDw-1; Fri, 07 Aug 2020 11:11:51 -0400
X-MC-Unique: LmjF-B8jPxKXWvHC43ADDw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32FF3100A8E7
        for <linux-nfs@vger.kernel.org>; Fri,  7 Aug 2020 15:11:50 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-70.phx2.redhat.com [10.3.112.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 041C61973B
        for <linux-nfs@vger.kernel.org>; Fri,  7 Aug 2020 15:11:49 +0000 (UTC)
Subject: Re: [PATCH] idmapd: Turn down the verbosity in flush_inotify()
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20200805190054.39513-1-steved@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <8d993f69-11d8-49f3-5146-02c1da8aae56@RedHat.com>
Date:   Fri, 7 Aug 2020 11:11:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200805190054.39513-1-steved@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 8/5/20 3:00 PM, Steve Dickson wrote:
> So idmapd does not flood the logs with messages
> nobody will understand, only print the message
> with verbose is set.
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed...

steved.
> ---
>  utils/idmapd/idmapd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
> index 8631414..7d1096d 100644
> --- a/utils/idmapd/idmapd.c
> +++ b/utils/idmapd/idmapd.c
> @@ -500,7 +500,8 @@ flush_inotify(int fd)
>  		     ptr += sizeof(struct inotify_event) + ev->len) {
>  
>  			ev = (const struct inotify_event *)ptr;
> -			xlog_warn("pipefs inotify: wd=%i, mask=0x%08x, len=%i, name=%s",
> +			if (verbose > 1)
> +				xlog_warn("pipefs inotify: wd=%i, mask=0x%08x, len=%i, name=%s",
>  				  ev->wd, ev->mask, ev->len, ev->len ? ev->name : "");
>  		}
>  	}
> 

