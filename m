Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44145583FCB
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jul 2022 15:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238214AbiG1NSH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jul 2022 09:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238377AbiG1NSB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jul 2022 09:18:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0FB958B71
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 06:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659014278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SIWhBtZn+Fx+WbOycTgxhlRYNHadkUPvik/tJFrBHuM=;
        b=G/V6tUXit6r/VDualuWtDvsRhpuaUcuI5ex5vcwxHPA/bUghdtKbAYG4z6D87cvv8exU48
        mxFBJRBIgVOuOXC6bSOijNzxYgzYDpglfQlcWpf11R6dpDOrWvJnqrJhTyjRIQROGDPUJh
        50iDCqZw74fS7ahULU4Wepj+bm49fCs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-20CC7BtjMaGRQq0YecRxkw-1; Thu, 28 Jul 2022 09:17:57 -0400
X-MC-Unique: 20CC7BtjMaGRQq0YecRxkw-1
Received: by mail-qt1-f197.google.com with SMTP id n14-20020ac8674e000000b0031ede6b9526so999599qtp.3
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 06:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SIWhBtZn+Fx+WbOycTgxhlRYNHadkUPvik/tJFrBHuM=;
        b=0UYgHjHSH6rsYME2jbKfCAWOzQA3vj7ZcuiF+C/WyKziMeLnAPcLYS52cX/i6ej4zW
         gC/jhoYFG12O1fEbP2g4tdGVp/wlxydBjIMT9gH+BgGXt8GYRtgQKu3WPoQSXPFfVN7O
         R1ZpF1+O9PsozYWa3UtSupZUlOWWGOq4g14K5Z6gIIQpEvHzcmRroROoGegXzYb9rpWJ
         9bYVAYO8aFL5dX4ug0UdJFdlQwlAtNsXUyu34lAJYJv+BZ4qnY3VjF46LuwMRUSqOPxn
         L1XOlkms1WQnpqXOCX0LOwvZXHleYM+2bzmDJNvCFgYa1wwM1ZyH+kNmYMVNgMAYQVgO
         wCjQ==
X-Gm-Message-State: AJIora/ZGnvBWEJlOB9ZRjtRFQWtj7Pt/zq/Wtp8C3dSdcKnH/BAQ2FT
        EtOsd1hsgqvwhAwiW3zZRa50f8Y69GSAkY+QBr2crDyiSvmwPVp4wmt9sO3MiuUvWKi6lmrMJ+R
        5Pj9yDR9/KST0LHygGy2B
X-Received: by 2002:a05:6214:5195:b0:474:454a:cfe7 with SMTP id kl21-20020a056214519500b00474454acfe7mr17786425qvb.85.1659014276103;
        Thu, 28 Jul 2022 06:17:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uz86qB3MNr56xuLm+4Lv/q1SUSzeixWPCjrY1jhJdKICVo+gWn5oKsi3FT/IJDLxntXAsrwg==
X-Received: by 2002:a05:6214:5195:b0:474:454a:cfe7 with SMTP id kl21-20020a056214519500b00474454acfe7mr17786407qvb.85.1659014275841;
        Thu, 28 Jul 2022 06:17:55 -0700 (PDT)
Received: from [172.31.1.6] ([70.109.154.36])
        by smtp.gmail.com with ESMTPSA id w16-20020ac857d0000000b0031f0b43629dsm448912qta.23.2022.07.28.06.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 06:17:55 -0700 (PDT)
Message-ID: <63159ce7-72a7-038e-1c9f-f725b321668c@redhat.com>
Date:   Thu, 28 Jul 2022 09:17:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] SUNRPC: mutexed access blacklist_read state variable.
Content-Language: en-US
To:     Attila Kovacs <attila.kovacs@cfa.harvard.edu>,
        Libtirpc-devel Mailing List 
        <libtirpc-devel@lists.sourceforge.net>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20220726201243.103800-1-attila.kovacs@cfa.harvard.edu>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220726201243.103800-1-attila.kovacs@cfa.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 7/26/22 4:12 PM, Attila Kovacs wrote:
> From: Attila Kovacs <attipaci@gmail.com>
> 
> bindresvport()_sa(), in bidresvport.c checks blacklist_read w/o mutex
> before calling load_blacklist() which changes blacklist_read() also
> unmutexed.
> 
> Clearly, the point is to read the blacklist only once on the first call,
> but because the checking whether the blacklist is loaded is not mutexed,
> more than one thread may race to load the blacklist concurrently, which
> of course can jumble the list because of the race condition.
> 
> The fix simply moves the checking within the mutexed aread of the code
> to eliminate the race condition.
Committed (tag: libtirpc-1-3-3-rc4)

steved.
> 
> ---
>   src/bindresvport.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/bindresvport.c b/src/bindresvport.c
> index ef9b345..5c0ddcf 100644
> --- a/src/bindresvport.c
> +++ b/src/bindresvport.c
> @@ -164,10 +164,11 @@ bindresvport_sa(sd, sa)
>   	int endport = ENDPORT;
>   	int i;
>   
> +	mutex_lock(&port_lock);
> +
>   	if (!blacklist_read)
>   		load_blacklist();
>   
> -	mutex_lock(&port_lock);
>   	nports = ENDPORT - startport + 1;
>   
>           if (sa == NULL) {

