Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F34390871
	for <lists+linux-nfs@lfdr.de>; Tue, 25 May 2021 20:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhEYSGQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 May 2021 14:06:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42367 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230145AbhEYSGP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 May 2021 14:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621965885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IXa+If68+s28EwNOtxA1CBQhlqvz5sofqzf+80KoJro=;
        b=buAnKkoSsXxw31acU0ClIGqvM65x81o1Cpg/PAJdAlbXYakElhzhkGbYpHui5nAZPMkXIt
        TUHhfvnHBMLTe26TwXD1MygeZrHjJIbHjjuxbqHyhB0FLlRBqr47eWZUN9RrPh6wR14P2D
        LlwJWeY/LBV2/0myMWMwPd/YJJ0X/Rs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-ukBIWPKfPp-l2nYAF4V8xg-1; Tue, 25 May 2021 14:04:42 -0400
X-MC-Unique: ukBIWPKfPp-l2nYAF4V8xg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0ABE5188E3C1;
        Tue, 25 May 2021 18:04:41 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-214.phx2.redhat.com [10.3.112.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97855100EBB0;
        Tue, 25 May 2021 18:04:40 +0000 (UTC)
Subject: Re: [PATCH nfs-utils 1/2] README: update git repository URL
To:     Roland Hieber <rhi@pengutronix.de>
Cc:     linux-nfs@vger.kernel.org
References: <20210525112729.29062-1-rhi@pengutronix.de>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <7655df6c-076c-c22e-0687-86b0c2e0b9e7@RedHat.com>
Date:   Tue, 25 May 2021 14:07:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210525112729.29062-1-rhi@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/25/21 7:27 AM, Roland Hieber wrote:
> The old URL is no longer available. Update to the new URL that is
> mentioned on https://linux-nfs.org.
> 
> Signed-off-by: Roland Hieber <rhi@pengutronix.de>
> ---
>  README | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
Committed (tag: nfs-utils-2-5-4-rc5)

steved.

> 
> diff --git a/README b/README
> index 7034c0091d49..663b667437dc 100644
> --- a/README
> +++ b/README
> @@ -34,7 +34,7 @@ To install binaries and documenation, run this command:
>  
>  Getting nfs-utils for the first time:
>  
> -	git clone git://linux-nfs.org/nfs-utils
> +	git clone git://git.linux-nfs.org/projects/steved/nfs-utils.git
>  
>  Updating to the latest head after you've already got it.
>  
> 

