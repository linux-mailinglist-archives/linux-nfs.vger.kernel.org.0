Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F6F261F11
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Sep 2020 21:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbgIHT6l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Sep 2020 15:58:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54335 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730475AbgIHPfq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Sep 2020 11:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599579337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YAfemmp0Bt/EOqPC4VWHkvI5RGStK9hr1r53ZyHgTv0=;
        b=dYs3Op4S26ZFCFFNyD3ju4PsfH/NYLNcTc9vdWETlAjcDdRiUdF6U26THAOxXwGMV5QAWh
        GIItOy/L9lopG6O7oYhO7gBiWImgokLQIWAGI/LFRmegQz/BkxSVNdEkUwhKsqtpMVCDlR
        Z6eJP8/PMdODYelKENx06wRzMUxT+38=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-eQ-OnyeBPC2-bwquvvj0pQ-1; Tue, 08 Sep 2020 11:27:30 -0400
X-MC-Unique: eQ-OnyeBPC2-bwquvvj0pQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94E43800402
        for <linux-nfs@vger.kernel.org>; Tue,  8 Sep 2020 15:27:28 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-89.phx2.redhat.com [10.3.113.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66D7F7D8AE
        for <linux-nfs@vger.kernel.org>; Tue,  8 Sep 2020 15:27:28 +0000 (UTC)
Subject: Re: [PATCH] rpc.idmapd: Do not free config varibles
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20200904181957.9772-1-steved@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <5ad5c795-66d3-bebc-6ae6-050d516047e6@RedHat.com>
Date:   Tue, 8 Sep 2020 11:27:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904181957.9772-1-steved@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 9/4/20 2:19 PM, Steve Dickson wrote:
> Commit 93e8f092e added a conf_cleanup() call to clean
> up memory after the config file was parsed. It turns
> out that memory still needed and it is not very much
> so the call is removed.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1873965
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... 

steved.
> ---
>  utils/idmapd/idmapd.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
> index f3d2314..51c71fb 100644
> --- a/utils/idmapd/idmapd.c
> +++ b/utils/idmapd/idmapd.c
> @@ -306,9 +306,6 @@ main(int argc, char **argv)
>  			serverstart = 0;
>  	}
>  
> -	/* Config memory is no longer needed */
> -	conf_cleanup();
> -
>  	while ((opt = getopt(argc, argv, GETOPTSTR)) != -1)
>  		switch (opt) {
>  		case 'v':
> 

