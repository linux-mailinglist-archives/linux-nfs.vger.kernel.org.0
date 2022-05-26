Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE98153528A
	for <lists+linux-nfs@lfdr.de>; Thu, 26 May 2022 19:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346263AbiEZRdD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 May 2022 13:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbiEZRdC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 May 2022 13:33:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F24A03057F
        for <linux-nfs@vger.kernel.org>; Thu, 26 May 2022 10:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653586377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VFw1SxqWcsJHS56N7zDWnSK3r6Jw/GJFSyONqmyo96w=;
        b=dg180jdY2L+LJ3rBNoXXF83h2k9F8mpSJGR4GGEppU+SsAkZ4sxB04pBFoqmrvkcBD/9gQ
        lNRqRhznp4uj8ANAjSHp1x7PVU40b81vTzsel0PgklEuzuOknepCaW/A6yV1/zD+43VmcV
        DAQoge4F22tlzBADWZMceu8oqqyEBDQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399-XlXNbbArPZaazq9Xzk97tA-1; Thu, 26 May 2022 13:32:56 -0400
X-MC-Unique: XlXNbbArPZaazq9Xzk97tA-1
Received: by mail-qt1-f200.google.com with SMTP id t25-20020a05622a181900b002f3b32a6e30so2299302qtc.11
        for <linux-nfs@vger.kernel.org>; Thu, 26 May 2022 10:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VFw1SxqWcsJHS56N7zDWnSK3r6Jw/GJFSyONqmyo96w=;
        b=KPgIgUZ0rQhhLB202P4sPeVpjfmQQBTvGisOUV/vGNALYYG/f+uWa9dCbLfkjMgk4d
         cnKhh+FyvRmt5R7Sj1vQx+fD3yCvE7n6xchWXEqwSWS21jW+rUYL5BVYTvEZFkp0vDan
         PQSb8b6gaMXZOYzq8WjL9/qeiaEkfNwHgvcxAWE5DU2AirILIa/cW3aezdpl2ET2HZFZ
         EcppinIghJm/asrBbCUuzCgSwGMkppYMU5qGDF8Z6TuQrCFGdBsgQISnk5VcDQqH4Xci
         USionVXECD4s40RF09XXQumXs7THt4wJ5I4S96V/phPdrncaNTpcagjQIgKn1nEAX8AU
         FmhQ==
X-Gm-Message-State: AOAM531qBHW0OqwgvpIvrPaNl1jh6ZppThjJijG+lQVubf8kXAn2pRTR
        BII2sydQUeuZJPlAfExfT2H9C4gFRK9naZdVTi8bcH+klRTDx6Nj00Xz2osYd0/VGtWK2Fei5ck
        akjR1HEI8GsyxWyZ3WFLa
X-Received: by 2002:a37:de08:0:b0:6a3:2a1b:d096 with SMTP id h8-20020a37de08000000b006a32a1bd096mr24872982qkj.91.1653586375898;
        Thu, 26 May 2022 10:32:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLNW7JHpEiEcwhLnvOW8JmnacvuVKgdhvFZ54dV3PWSdOs31wfi7m76pZy/DTDV7aNo1j1TQ==
X-Received: by 2002:a37:de08:0:b0:6a3:2a1b:d096 with SMTP id h8-20020a37de08000000b006a32a1bd096mr24872962qkj.91.1653586375638;
        Thu, 26 May 2022 10:32:55 -0700 (PDT)
Received: from [10.19.60.33] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o1-20020a05620a15c100b006a3325fd985sm1437254qkm.13.2022.05.26.10.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 10:32:55 -0700 (PDT)
Message-ID: <9955e6a5-5097-a10b-2cd4-467e28f8d8ee@redhat.com>
Date:   Thu, 26 May 2022 13:32:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] nfsrahead: getopt return type is int
Content-Language: en-US
To:     Thiago Becker <tbecker@redhat.com>, linux-nfs@vger.kernel.org
References: <20220513191808.2930668-1-tbecker@redhat.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220513191808.2930668-1-tbecker@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/13/22 3:18 PM, Thiago Becker wrote:
> While compiling for aarch64, the compiler throws the warning below
> because char is unsigned for aarch64.
> 
> main.c: In function ‘main’:
> main.c:145:48: warning: comparison is always true due to limited range of data type [-Wtype-limits]
>    145 |         while((opt = getopt(argc, argv, "dF")) != -1) {
>        |
> 
> This makes nfsrahead to run forever. Fix opt type to the same as getopt
> type.
> 
> Signed-off-by: Thiago Becker <tbecker@redhat.com>
Committed... (tag: nfs-utils-2-6-2-rc5)

steved
> ---
>   tools/nfsrahead/main.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
> index 5fae941c..c83c6f71 100644
> --- a/tools/nfsrahead/main.c
> +++ b/tools/nfsrahead/main.c
> @@ -135,10 +135,9 @@ static int conf_get_readahead(const char *kind) {
>   
>   int main(int argc, char **argv)
>   {
> -	int ret = 0, retry;
> +	int ret = 0, retry, opt;
>   	struct device_info device;
>   	unsigned int readahead = 128, log_level, log_stderr = 0;
> -	char opt;
>   
>   
>   	log_level = D_ALL & ~D_GENERAL;

