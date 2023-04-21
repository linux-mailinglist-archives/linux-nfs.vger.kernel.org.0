Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5006EB178
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Apr 2023 20:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjDUSTt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Apr 2023 14:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjDUSTs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Apr 2023 14:19:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B21510E0
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 11:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682101140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E9SyDoqjOzCoHU0CLcEEQiVLTDc8JZCJBxnRlrk87Ds=;
        b=fre09ebqeh9wFjIpsgQtYhwIvzAL0gEBcZC/1QT2maewottZa7uftt1QWlz0Amr4RtpqjU
        P0gR9nCBFUb2qVR+D7wor/2UdVu1ZDMYrNkQV/TlGwnExTWJDUFin2iUMH7JrmGdEv+2yg
        7q/FxV7XWx/xVT8xRk2rNmKJA1jzMmU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-QpfU3eWUPyayTv43yCbgHQ-1; Fri, 21 Apr 2023 14:18:59 -0400
X-MC-Unique: QpfU3eWUPyayTv43yCbgHQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3ecc0c4b867so6637281cf.1
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 11:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682101138; x=1684693138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E9SyDoqjOzCoHU0CLcEEQiVLTDc8JZCJBxnRlrk87Ds=;
        b=FIanldpEvXygHrgdgG5cTq/X5wQ2EGf7ZQ3POJ7XtAh7oIiB0J0XKCSh8xvoUHe1Ms
         vmvvOeX7Tpmjx8HBjv816JSJ7v1gAz5iz0OE+KFhwivuhiyRHeG/NJWN7sDesYV1wjHm
         UPgMnOeE++HbYluGJOBHxld60hQI3x60ZHjWngeEF7NhtjX2/jpBf4K4qUcIbNxfXYRd
         Q6UxCd19+a7JS+CrBlYSoKHOSQ7gEI03LqxerBGsYuaAnP8GKvG2XivOrcN9plyYCgfN
         R1V/GeL11qqcInagBJHZkYA2ELQDVLpE92u7aHCB3DGn7e+DjLT8t4eVtLB9VVQuKTfn
         YV7A==
X-Gm-Message-State: AAQBX9dPui+k8xvUQGs+R3G0iBwrWvnwftKKxLPSkpJAOy10rP1DNDqQ
        Ro1IxI0PmUXREsAjsUWqPjAotNGNlF7mhmz8OPPCi1KF2EDyruucVA5gpgx1MhbEBMoDOpAiKmB
        p4woJm5o5DU/9IX6+S7BB
X-Received: by 2002:a05:622a:1348:b0:3ef:5587:723b with SMTP id w8-20020a05622a134800b003ef5587723bmr9667004qtk.3.1682101138554;
        Fri, 21 Apr 2023 11:18:58 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z96RworQ01tJmqVnX6zy79/fZWu0P6riCY4RVvEYIzAlHQrb7q9MbZfM2bFnWA2BGa+R/XMQ==
X-Received: by 2002:a05:622a:1348:b0:3ef:5587:723b with SMTP id w8-20020a05622a134800b003ef5587723bmr9666971qtk.3.1682101138276;
        Fri, 21 Apr 2023 11:18:58 -0700 (PDT)
Received: from [172.31.1.6] ([71.161.80.57])
        by smtp.gmail.com with ESMTPSA id px6-20020a05620a870600b00749fa9e12e9sm1492057qkn.124.2023.04.21.11.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 11:18:57 -0700 (PDT)
Message-ID: <bdd364a9-4e54-df31-2c3b-2d58925bd8d9@redhat.com>
Date:   Fri, 21 Apr 2023 14:18:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [Libtirpc-devel] [PATCH] allow TCP-only portmapper
Content-Language: en-US
To:     =?UTF-8?Q?Dan_Hor=c3=a1k?= <dan@danny.cz>,
        libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org, Rob Riggs <rob+redhat@pangalactic.org>
References: <20230411121142.23312-1-dan@danny.cz>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20230411121142.23312-1-dan@danny.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/11/23 8:11 AM, Dan Horák wrote:
> Code that works in GLIBC's runrpc implementation fails with libtirpc.
> libtirpc forces the RPC library to talk to the portmapper via UDP,
> even when the client specifies TCP.  This breaks existing code which
> expect the protocol specified to be honored, even when talking to
> portmapper.
> 
> This is upstreaming of an old patch by Rob Riggs reported in Fedora.
> 
> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=1725329
> Signed-off-by: Rob Riggs <rob+redhat@pangalactic.org>
> Signed-off-by: Dan Horák <dan@danny.cz>
Committed... (tag: libtirpc-1-3-4-rc1)

steved.
> ---
>   src/rpcb_clnt.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/src/rpcb_clnt.c b/src/rpcb_clnt.c
> index 9a9de69..d178d86 100644
> --- a/src/rpcb_clnt.c
> +++ b/src/rpcb_clnt.c
> @@ -496,11 +496,7 @@ getpmaphandle(nconf, hostname, tgtaddr)
>   	CLIENT *client = NULL;
>   	rpcvers_t pmapvers = 2;
>   
> -	/*
> -	 * Try UDP only - there are some portmappers out
> -	 * there that use UDP only.
> -	 */
> -	if (nconf == NULL || strcmp(nconf->nc_proto, NC_TCP) == 0) {
> +	if (nconf == NULL) {
>   		struct netconfig *newnconf;
>   
>   		if ((newnconf = getnetconfigent("udp")) == NULL) {
> @@ -509,7 +505,8 @@ getpmaphandle(nconf, hostname, tgtaddr)
>   		}
>   		client = getclnthandle(hostname, newnconf, tgtaddr);
>   		freenetconfigent(newnconf);
> -	} else if (strcmp(nconf->nc_proto, NC_UDP) == 0) {
> +	} else if (strcmp(nconf->nc_proto, NC_UDP) == 0 ||
> +	    strcmp(nconf->nc_proto, NC_TCP) == 0) {
>   		if (strcmp(nconf->nc_protofmly, NC_INET) != 0)
>   			return NULL;
>   		client = getclnthandle(hostname, nconf, tgtaddr);

