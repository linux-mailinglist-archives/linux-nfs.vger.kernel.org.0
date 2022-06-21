Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C2B553395
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jun 2022 15:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351061AbiFUNeS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Jun 2022 09:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbiFUNbG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Jun 2022 09:31:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A3FF22B07
        for <linux-nfs@vger.kernel.org>; Tue, 21 Jun 2022 06:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655817985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j/2O2c8s1LKn8qdzaiTFmrQtYEezdKcO1gjTE1Qe/FA=;
        b=NB59N+2too1HCs2/Qjy4uIYROmUieH0meyjSwOyQEyWkKRxX6keXXHyVUg6DsE7LJcEONo
        ySs73XrSQKH+qzDUl5DYK0U+8YqjTdRpCNPNnPsYc7X+E0Vpzn7IFBb+C8+SLDiRAiyLws
        gftcpLp5nR54hShmpxxco9XC73fbxm8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-UmUjZpmzNUa8PRun_XdRJw-1; Tue, 21 Jun 2022 09:26:23 -0400
X-MC-Unique: UmUjZpmzNUa8PRun_XdRJw-1
Received: by mail-qk1-f197.google.com with SMTP id x4-20020a05620a448400b006ac665e1dfeso8971817qkp.17
        for <linux-nfs@vger.kernel.org>; Tue, 21 Jun 2022 06:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j/2O2c8s1LKn8qdzaiTFmrQtYEezdKcO1gjTE1Qe/FA=;
        b=eILVT/WQrWESKEEVV67N53FC78n7xOWFwGCpe/iwofFL9v/+qMokfhmQbIEoHeAhl+
         lIcjutHhwoQkiAJyGLk2LzNLH0QHWcbu+X04uLlohz43N0akjpcq9GvCFU+ZdOjCOVsY
         fvVe313pk9PBPX8UxCOFYy4KA2XdBEnvAqBtwN2BiO+Dl7SgFVwdruTV/L1BIB6MZiDH
         Nzu11fjNLHzbgoLd4b16R2WBgLNRO5MTXP4wevHDxiOg2mhFrmy9CN1yL7chD1uYst15
         oN0xbv3GiMwKXWUR1Y3oBub+HWO3AzMQ1CRK4Bjj79NqPlwtN1sZG6IJFj2rdSSsHH3H
         U2tg==
X-Gm-Message-State: AJIora8StXlAcPfy6++kv2d5atcxHGEZUCQxBF6JB8JoEmi6IrPVztNL
        XoKEAoOsOZA033anpY8cmJGRYwEsnRndBIDVDfXqIUMujb8PU/580ZvwfNUrCj0EJZuLJ2LDYpn
        cyGO4eO8wziYTXj//5uos
X-Received: by 2002:a37:de0c:0:b0:69e:cd37:7646 with SMTP id h12-20020a37de0c000000b0069ecd377646mr20224525qkj.449.1655817981748;
        Tue, 21 Jun 2022 06:26:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vYyZg9jdScwBpYrKtwlXhNgzGwXJxQuaNUPRlqB29cYeKEdPkOd0/HtTPPnKqLf5OJaoAhEQ==
X-Received: by 2002:a37:de0c:0:b0:69e:cd37:7646 with SMTP id h12-20020a37de0c000000b0069ecd377646mr20224500qkj.449.1655817981456;
        Tue, 21 Jun 2022 06:26:21 -0700 (PDT)
Received: from [172.31.1.6] ([70.109.186.229])
        by smtp.gmail.com with ESMTPSA id z12-20020ac86b8c000000b00304e8938800sm12306519qts.96.2022.06.21.06.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 06:26:21 -0700 (PDT)
Message-ID: <8337cf24-d8d2-034a-a6e7-47900d2d2165@redhat.com>
Date:   Tue, 21 Jun 2022 09:26:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] cifs-utils/svcgssd: Fix use-after-free bug (config
 variables)
Content-Language: en-US
To:     marcel@linux-ng.de, linux-nfs@vger.kernel.org
References: <20220607081909.1216287-1-marcel@linux-ng.de>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220607081909.1216287-1-marcel@linux-ng.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

All 3 patch committed (tag: nfs-utils-2-6-2-rc7)

steved.

On 6/7/22 4:19 AM, marcel@linux-ng.de wrote:
> From: Marcel Ritter <marcel@linux-ng.de>
> 
> This patch fixes a bug when trying to set "principal" in /etc/nfs.conf.
> Memory gets freed by conf_cleanup() before being used - moving cleanup
> code resolves that.
> 
> ---
>   utils/gssd/svcgssd.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/utils/gssd/svcgssd.c b/utils/gssd/svcgssd.c
> index 881207b3..a242b789 100644
> --- a/utils/gssd/svcgssd.c
> +++ b/utils/gssd/svcgssd.c
> @@ -211,9 +211,6 @@ main(int argc, char *argv[])
>   	rpc_verbosity = conf_get_num("svcgssd", "RPC-Verbosity", rpc_verbosity);
>   	idmap_verbosity = conf_get_num("svcgssd", "IDMAP-Verbosity", idmap_verbosity);
>   
> -	/* We don't need the config anymore */
> -	conf_cleanup();
> -
>   	while ((opt = getopt(argc, argv, "fivrnp:")) != -1) {
>   		switch (opt) {
>   			case 'f':
> @@ -328,6 +325,9 @@ main(int argc, char *argv[])
>   
>   	daemon_ready();
>   
> +	/* We don't need the config anymore */
> +	conf_cleanup();
> +
>   	nfs4_init_name_mapping(NULL); /* XXX: should only do this once */
>   
>   	rc = event_base_dispatch(evbase);

