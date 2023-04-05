Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6826D83B0
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Apr 2023 18:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjDEQ3p (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Apr 2023 12:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbjDEQ3n (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Apr 2023 12:29:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9DD173C
        for <linux-nfs@vger.kernel.org>; Wed,  5 Apr 2023 09:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680712138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9XXa7u/ZymdLZshDt7Rw2pqVY2tMNdpMevRdngIpft4=;
        b=bXMZYN45T22XyyYBtLcb8amP8j7ln2+Lojef9i3FdXoVHn4Dk0z/R9yxhO4im6LTmtFoJJ
        EG82gUgpzJO5CbOlZU4itiSGcguMGjcmhOpqGZ+jQnO546AqH4WQpnDbuCBWZ4Jwt0XNwc
        n/LCjagImxBJ2tdAUtvtZOmqtEie/fk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-GJyIaBEKNUaiVlGVAsAzSA-1; Wed, 05 Apr 2023 12:28:57 -0400
X-MC-Unique: GJyIaBEKNUaiVlGVAsAzSA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-74a65b255beso1631385a.0
        for <linux-nfs@vger.kernel.org>; Wed, 05 Apr 2023 09:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680712136;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9XXa7u/ZymdLZshDt7Rw2pqVY2tMNdpMevRdngIpft4=;
        b=jUH16lLo8j2reXU2Gzao6OdR1pPtAD4Jv3jhtrim5LpMsE3xbX0Tv9q95NQUw8n/4d
         VqueHQzFn3HqAmA2pHWS6PcXKLrNloSXKWe2yL6oqXFsXufVB8nox6qGEbimV7GD2/i7
         jC/oSZnCY9Mj55Xkslfg5dpmw9UJJjw+xexGBVTMFFyeiLlew2skdaQI6myMdZ46+ihk
         c+1DA0CD7hSzI4VPF6FCWO22bRKcJRgeXfBovfdgUCqs/mgcxFMMUKTFhaMd3HHz0alj
         dRVmmuyo7HOiEaK2fcaPL1wQUeRJjfnELyEDLcame8A/CztnYl3IkYKzblm3pNnDYqMB
         M6zQ==
X-Gm-Message-State: AAQBX9fmcDY3cgrUEdk77YxgAFLaZl/RAOrv2vayzP1fmFwPb1L4NcYV
        UzjPo7v6slqI++MDaroxEQcnaaaF24IbfAs8A60gysuDT5Ej9uqO/8qFq6VmIRz0jO1t7p1k/qO
        Lnr8cDFUq4KmPkqYpxsSP7wXDxEQm
X-Received: by 2002:a05:622a:1a1d:b0:3e3:1d31:e37 with SMTP id f29-20020a05622a1a1d00b003e31d310e37mr5042427qtb.1.1680712136360;
        Wed, 05 Apr 2023 09:28:56 -0700 (PDT)
X-Google-Smtp-Source: AKy350aUhagyU/7xwTLI/cv+7Yw5TOtA76tRal77Rjh/0OZFiAA1r246s4L55Af/KYtr3jj//1T68g==
X-Received: by 2002:a05:622a:1a1d:b0:3e3:1d31:e37 with SMTP id f29-20020a05622a1a1d00b003e31d310e37mr5042381qtb.1.1680712135860;
        Wed, 05 Apr 2023 09:28:55 -0700 (PDT)
Received: from [172.31.1.6] ([70.109.174.217])
        by smtp.gmail.com with ESMTPSA id v19-20020ac87293000000b003e2e919bcf7sm4081818qto.78.2023.04.05.09.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 09:28:55 -0700 (PDT)
Message-ID: <3661346d-da08-927e-fd76-20bdf6587c11@redhat.com>
Date:   Wed, 5 Apr 2023 12:28:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] [nfs/nfs-utils] rpcdebug: avoid buffer underflow if
 read() returns 0
Content-Language: en-US
To:     Zhi Li <yieli@redhat.com>, linux-nfs@vger.kernel.org
References: <20230309062025.731671-1-yieli@redhat.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20230309062025.731671-1-yieli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/9/23 1:20 AM, Zhi Li wrote:
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2176740
> 
> Signed-off-by: Zhi Li <yieli@redhat.com>
Committed... (tag: nfs-utils-2-6-3-rc7)

steved.
> ---
>   tools/rpcdebug/rpcdebug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/rpcdebug/rpcdebug.c b/tools/rpcdebug/rpcdebug.c
> index 68206cc5..ec05179e 100644
> --- a/tools/rpcdebug/rpcdebug.c
> +++ b/tools/rpcdebug/rpcdebug.c
> @@ -257,7 +257,7 @@ get_flags(char *module)
>   		perror(filename);
>   		exit(1);
>   	}
> -	if ((len = read(sysfd, buffer, sizeof(buffer))) < 0) {
> +	if ((len = read(sysfd, buffer, sizeof(buffer))) <= 0) {
>   		perror("read");
>   		exit(1);
>   	}

