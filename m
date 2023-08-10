Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FD5777D44
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Aug 2023 18:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbjHJQD4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Aug 2023 12:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjHJQDl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Aug 2023 12:03:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E572E30E5
        for <linux-nfs@vger.kernel.org>; Thu, 10 Aug 2023 09:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691683366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wzubSgM1DQlmqScJe9bM9135ZO9WE0zvvbKlCDNyWkY=;
        b=b+EoDi1cULG356AVoiXttgwvy7EoV1/SxFyRLc8XPuUSvSTNI9qbYf/zpsw5XMJtWRG6lR
        BXhQOg1Jz8q+NT9OGShFPkGa/PxKzpxQcrTC6dH0Z4a3tShHe26kImshdQnzETEoxiY2/F
        zv9eMI4a+HGYSFVWBN2h4cBqGENuNQc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-oVMbqJ9kOUaZVtMhNl_XrA-1; Thu, 10 Aug 2023 12:02:44 -0400
X-MC-Unique: oVMbqJ9kOUaZVtMhNl_XrA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-40fd6d83c21so2668651cf.1
        for <linux-nfs@vger.kernel.org>; Thu, 10 Aug 2023 09:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691683364; x=1692288164;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wzubSgM1DQlmqScJe9bM9135ZO9WE0zvvbKlCDNyWkY=;
        b=RTX3tEW7G0KPwgxBuj1rW8LW15+dkVApcPfO+vL8a2wvnHxPgUhlUlyuzfROUBya5a
         cv1YiwxLbv6+5DxKSWtxRke2pbzKbeXLb/29g16S/C0Dm7HAt0tJXtjuIIMlhfUrO9PM
         JcVV+ljekZ6MemZUsmKjfPtGqmKMEMTwL+6EIJg9nS5f/xVHxNApjK+Gh570SM8mmLVB
         aP6OpJw7w4E7cfQY4cf4dRcpcISOcSz4ZGP8N5rgHJ1vcMhaX+HuLNJGM/vOzH4nrsaZ
         PfUcIu0x94Gq1Zvf+/uEiIgNFD80bBDbGH6YwcmQVNp826GtUaFxs/6y5VdFTgL02njV
         C9ew==
X-Gm-Message-State: AOJu0YzJrCbJN2Ga6aAmpTFO9jj4qdxgOnjpXZoU2Jj5WHkoC3d8VAoQ
        6AxWIw+2U9qXxaXof5rTKwtylMGeyOLuz+536ryJGvj0bZWlDASVDN6DhjzHbVUhsgJi5TdK7ly
        piSVxgYoz856LoVrrFAZ6aYqRlfHB8xC/0w4muMcAkEAXUc3TXOlP+s5Nm2Qu7tDS2wbYUjZTHT
        S/2w==
X-Received: by 2002:a05:622a:1884:b0:403:b115:fbe with SMTP id v4-20020a05622a188400b00403b1150fbemr3307791qtc.1.1691683363485;
        Thu, 10 Aug 2023 09:02:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjAtUOP9vepS4SCPCCLOKkviANJqQkOyayZtDdv2/pHMMlQMiacePgLWivX5j3qWAcDhgbXw==
X-Received: by 2002:a05:622a:1884:b0:403:b115:fbe with SMTP id v4-20020a05622a188400b00403b1150fbemr3307746qtc.1.1691683362852;
        Thu, 10 Aug 2023 09:02:42 -0700 (PDT)
Received: from [10.19.60.48] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id jj6-20020a05622a740600b0040c72cae9f9sm566599qtb.93.2023.08.10.09.02.42
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 09:02:42 -0700 (PDT)
Message-ID: <c1cc7fc4-1375-d6f1-997f-386580756cd5@redhat.com>
Date:   Thu, 10 Aug 2023 12:02:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Fixed a regression in the junction code
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20230809130018.184633-1-steved@redhat.com>
In-Reply-To: <20230809130018.184633-1-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 8/9/23 9:00 AM, Steve Dickson wrote:
> commit cdbef4e9 created a regression in the
> in the junction code by adding a O_PATH flag
> to the open() in junction_open_path()
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2213669
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed...

steved.
> ---
>   support/junction/junction.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/support/junction/junction.c b/support/junction/junction.c
> index 0628bb0f..c1ec8ff8 100644
> --- a/support/junction/junction.c
> +++ b/support/junction/junction.c
> @@ -63,7 +63,7 @@ junction_open_path(const char *pathname, int *fd)
>   	if (pathname == NULL || fd == NULL)
>   		return FEDFS_ERR_INVAL;
>   
> -	tmp = open(pathname, O_PATH|O_DIRECTORY);
> +	tmp = open(pathname, O_DIRECTORY);
>   	if (tmp == -1) {
>   		switch (errno) {
>   		case EPERM:

