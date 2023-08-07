Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7193A77212D
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Aug 2023 13:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjHGLTw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Aug 2023 07:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjHGLTP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Aug 2023 07:19:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E941BFF
        for <linux-nfs@vger.kernel.org>; Mon,  7 Aug 2023 04:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691406952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NxHJYUUpShLasjr4CK7rlgS4tbM+VMqWxie89UdURac=;
        b=gI9ww8nTAkAwzb2qGnTytUepbjo9KsrpktaeN9deyINWUp/wD0kREhAHgXGXuE5Hp3jc7r
        NRdtHu4F8xsQMUjsSNcuX8TgT9zKjcf5SjDSdoRI1Fvde4JYrdZLoxBqpywtIWKpwBrEvj
        2eel6ICurErlYfndBFIDknGQE/WqJKc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-WQmF3ugINJSKu6Ge4kkRjA-1; Mon, 07 Aug 2023 07:15:50 -0400
X-MC-Unique: WQmF3ugINJSKu6Ge4kkRjA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-40fa24ab5c8so11198591cf.1
        for <linux-nfs@vger.kernel.org>; Mon, 07 Aug 2023 04:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691406950; x=1692011750;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NxHJYUUpShLasjr4CK7rlgS4tbM+VMqWxie89UdURac=;
        b=WAPMjeQiReXT/XXhAHqzpUW5w7kW/WVE02hPj+RTkHjNEyvd6DISGcFd5MhUAm41hC
         eG7OcD7Vdr/8gmB2JmCL9D2qww8uSohpZvAGjdrrDwZZBu70oMiA/a1ZXPF0duAmJuL5
         Gd9pvEDqnJYOUyO7WILIQpk92hjVfep0UUZMQ7yp0fyt9jadXzj4lDucPdzUNbCsIRVF
         XzOIqWs/PBWuvpkaWn/hVL2osKTwKS5T7kQYndlH+F0n7oLz/ix8oKEEzmgpuGnFyBuB
         JFD3e/YklWIWzGJ4yW1I59Gno7hvWWO+nfDQxziGQAmQFHOP00Opaqq65IT/Xf9Ko+Dz
         J/zQ==
X-Gm-Message-State: ABy/qLZzWGSD6M4TvK40J2PqVwI1oun0Zrk9Se8gUCIPBW0OTumLqUUA
        jP5RIOgNRb9YeWOWdUvN9Hm5u8O+hcm1rYbleRp1qtBDttOdT9XIg6lILIiXXsPMg0girnyrWgD
        V3H4c0HVX0KOKXveR0XQA
X-Received: by 2002:a05:620a:294b:b0:76c:a3bb:f8c0 with SMTP id n11-20020a05620a294b00b0076ca3bbf8c0mr35302511qkp.0.1691406950469;
        Mon, 07 Aug 2023 04:15:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGLaXLhthXyjzLA1ny5ejms8rVUBacFqjEBUTANjr+EQHxpr+0UZpyDLjqVaME3PggLHVyHbg==
X-Received: by 2002:a05:620a:294b:b0:76c:a3bb:f8c0 with SMTP id n11-20020a05620a294b00b0076ca3bbf8c0mr35302496qkp.0.1691406950231;
        Mon, 07 Aug 2023 04:15:50 -0700 (PDT)
Received: from [172.31.1.12] ([71.161.93.223])
        by smtp.gmail.com with ESMTPSA id v26-20020a05620a123a00b0076816153dcdsm2520037qkj.106.2023.08.07.04.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 04:15:49 -0700 (PDT)
Message-ID: <e9bb64cb-eece-f6e7-9a13-e059e2e088ae@redhat.com>
Date:   Mon, 7 Aug 2023 07:15:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Libtirpc-devel] [PATCH 1/2] rpcb_clnt.c: memory leak in
 destroy_addr
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
To:     Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20230801144209.557175-1-steved@redhat.com>
In-Reply-To: <20230801144209.557175-1-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 8/1/23 10:42 AM, Steve Dickson wrote:
> From: Herb Wartens <wartens2@llnl.gov>
> 
> Null pointers so they are not used again
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2225226
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... (tag: libtirpc-1-3-4-rc2)

steved
> ---
>   src/rpcb_clnt.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/src/rpcb_clnt.c b/src/rpcb_clnt.c
> index d178d86..c0a9e12 100644
> --- a/src/rpcb_clnt.c
> +++ b/src/rpcb_clnt.c
> @@ -104,17 +104,27 @@ destroy_addr(addr)
>   {
>   	if (addr == NULL)
>   		return;
> -	if(addr->ac_host != NULL)
> +	if (addr->ac_host != NULL) {
>   		free(addr->ac_host);
> -	if(addr->ac_netid != NULL)
> +		addr->ac_host = NULL;
> +	}
> +	if (addr->ac_netid != NULL) {
>   		free(addr->ac_netid);
> -	if(addr->ac_uaddr != NULL)
> +		addr->ac_netid = NULL;
> +	}
> +	if (addr->ac_uaddr != NULL) {
>   		free(addr->ac_uaddr);
> -	if(addr->ac_taddr != NULL) {
> -		if(addr->ac_taddr->buf != NULL)
> +		addr->ac_uaddr = NULL;
> +	}
> +	if (addr->ac_taddr != NULL) {
> +		if(addr->ac_taddr->buf != NULL) {
>   			free(addr->ac_taddr->buf);
> +			addr->ac_taddr->buf = NULL;
> +		}
> +		addr->ac_taddr = NULL;
>   	}
>   	free(addr);
> +	addr = NULL;
>   }
>   
>   /*

