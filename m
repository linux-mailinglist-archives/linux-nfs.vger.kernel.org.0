Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1196860B67E
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Oct 2022 21:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbiJXTAK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 15:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbiJXS73 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 14:59:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A1ECC4
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 10:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666633067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7/s1kRxTaDDvJBa8I9Ag1tt9kzj48JGRJaVSwWYzxfk=;
        b=gWvxgc6lix3LgIv5TIAkv+5aXDEg8ZjoPUHSujwrOHaRDk/kaQzg/n7VGzeY1pTxqc5rLz
        yXrcAKkH/MT+mfn/8gWI8MTpO15FQgjQAiRM4QD8gX3nzIKvOnebBBS6Tx4sg2t9RoSYmw
        WR99AJe2VxGWuvSTaAyqSsOv+Nphtqw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-489-2N10j9OJPmaUcOEiXsEteQ-1; Mon, 24 Oct 2022 13:37:46 -0400
X-MC-Unique: 2N10j9OJPmaUcOEiXsEteQ-1
Received: by mail-qv1-f69.google.com with SMTP id em2-20020ad44f82000000b004af5338777cso5594288qvb.4
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 10:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/s1kRxTaDDvJBa8I9Ag1tt9kzj48JGRJaVSwWYzxfk=;
        b=1yfcFeOMKBUamU1edp/oP1TEnf4eCVbGDE9DXj/0CBjV+Yr65X0e+qsPj0s5/kO1gJ
         eQHljQLqZw7r7yelKS36NjYKWam8UqyVhIX38gwkYoIwpU/l2PKqBxY5sbkEWBk6Y/rc
         DY4UB08la18E/2OSlaO3ae6J6TQUxlnkVz7f3ZtoF4OQAbPd1aVHy7CbtkMrMfxmxGrL
         PN3uNPOYw+Hy4fyC1rBUzFWREzbZF2N22+bLN5/bE0Gvdk2J9yeAXQdVrm5xPpNCfTJt
         ziU4+Ha7etOwkP+IAQD9e0/DLszfN4PKPdRW9BvcDuPMOtlDjn1MJg/p6W80VdeFWWYc
         0H/A==
X-Gm-Message-State: ACrzQf07MiQbBdYYiurc52QBDXaN0+Oqyvr298QPf65G3/P9diNapCQF
        NBJgE9ilKeMCvahADAVpJLGtqfCmtHGXwSdYKVmgv7mTXF5UlYgvvItkbW6BGW6csVubZtbWeNX
        J7iHyytN4RP0EGCHwhkf1
X-Received: by 2002:a05:620a:440e:b0:6f6:2a11:c497 with SMTP id v14-20020a05620a440e00b006f62a11c497mr2457791qkp.213.1666633066051;
        Mon, 24 Oct 2022 10:37:46 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4JRwazno70h8MMqnCoGyZqsPXyldCsbJ/RH9TE/9eKLET2N7VFYaL581l2wHtfetgFEsIOrQ==
X-Received: by 2002:a05:620a:440e:b0:6f6:2a11:c497 with SMTP id v14-20020a05620a440e00b006f62a11c497mr2457773qkp.213.1666633065781;
        Mon, 24 Oct 2022 10:37:45 -0700 (PDT)
Received: from ?IPV6:2603:6000:d605:db00:db8c:7bbd:f449:802d? (2603-6000-d605-db00-db8c-7bbd-f449-802d.res6.spectrum.com. [2603:6000:d605:db00:db8c:7bbd:f449:802d])
        by smtp.gmail.com with ESMTPSA id ay14-20020a05620a178e00b006c479acd82fsm376265qkb.7.2022.10.24.10.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 10:37:45 -0700 (PDT)
Message-ID: <f5242951-a6d5-30c0-62da-91eef42ad890@redhat.com>
Date:   Mon, 24 Oct 2022 13:37:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] [nfs/nfs-utils] mount.nfs: fix NULL pointer derefernce in
 nfs_parse_square_bracket
Content-Language: en-US
To:     Zhi Li <yieli@redhat.com>, linux-nfs@vger.kernel.org
References: <20221021124148.4035709-1-yieli@redhat.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20221021124148.4035709-1-yieli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 10/21/22 8:41 AM, Zhi Li wrote:
> In function nfs_parse_square_bracket, hostname could be NULL,
> dereferencing it in free(*hostname) may cause an unexpected segfault.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2136807
> Signed-off-by: Zhi Li <yieli@redhat.com>
Committed...

steved.
> ---
>   utils/mount/parse_dev.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/utils/mount/parse_dev.c b/utils/mount/parse_dev.c
> index 0d3bcb95..2ade5d5d 100644
> --- a/utils/mount/parse_dev.c
> +++ b/utils/mount/parse_dev.c
> @@ -170,7 +170,8 @@ static int nfs_parse_square_bracket(const char *dev,
>   	if (pathname) {
>   		*pathname = strndup(cbrace, path_len);
>   		if (*pathname == NULL) {
> -			free(*hostname);
> +			if (hostname)
> +				free(*hostname);
>   			return nfs_pdn_nomem_err();
>   		}
>   	}

