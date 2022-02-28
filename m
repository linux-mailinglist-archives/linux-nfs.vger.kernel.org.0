Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11FF4C7A54
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 21:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiB1U1u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 15:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiB1U1t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 15:27:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B04BB59383
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 12:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646080023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PsnNDbXpCEIrDedLjKUS6B8dFk/ohd/5tx0Y6gtUciE=;
        b=fsVVZh/fgBXgrBi3oY/TSrhXg6vyKVN273FMu/KZFiVO2WR90sKcMD1kBK22bpqu47Zcai
        iXGH6JCphUbv1zY69ENgWlB5B3r+W67SpuZWp2Cqxfyn8nAyYroDQKcHQ2U8Bc66R4OjOb
        2LuHraW0/xWak8x5hDcfUTaELNVz20U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-269-nSuSooVRMriCTWNUOS0wvQ-1; Mon, 28 Feb 2022 15:27:01 -0500
X-MC-Unique: nSuSooVRMriCTWNUOS0wvQ-1
Received: by mail-qv1-f72.google.com with SMTP id g2-20020a0562141cc200b004123b0abe18so13392414qvd.2
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 12:27:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=PsnNDbXpCEIrDedLjKUS6B8dFk/ohd/5tx0Y6gtUciE=;
        b=Xv5lUa7St4ey6lTWmD3pR2raE/cy3zcu73Nqj/s26zOnKcKU2HL4PikXIt0BNu5cWg
         UvcYJud0AkWSkyxohO2xPLyh5df4Wt0KgAphNBg85tYgIARzFIbZTB7zl6dmYv4IiKuy
         1CVwk8QEA+3kpqjJFNeA1koSX4qEC2NFicMMusaNjvSvXY3k5FVAR92tEvxPEwV4GVMy
         ixe7iDt8Rq5gnDLVC8jAVdHmMa08FeR0I/FbSduM5sqk8NAb2uBPcmyboQE7Rg4Lo81y
         kmvW7qunJTl0zMsPV9AuJXZXZac0/tIBSsvOMvlksT9co9x/pp0d2BMduer+V98DDMw8
         j6kw==
X-Gm-Message-State: AOAM531CXrMgtWeXMgzGgmUBaFZEJomKPqhpKMLDeZWJaYNFLTAe0fov
        sJIkaFmVOsaUv0SlHSkc8Yr7xH5YNeg/fgrXu7pDO/hfn7Lu5NdRjjaaD7dokIqVjUgYtT+l4/e
        b4vON/KlGCbzB2fmD8fkikgqqo3DWA/F+0VmouxfomxqDR82xRCQyz/jBxAM71SpN9DWPMw==
X-Received: by 2002:a05:622a:120a:b0:2de:2bf5:a990 with SMTP id y10-20020a05622a120a00b002de2bf5a990mr17421322qtx.143.1646080020626;
        Mon, 28 Feb 2022 12:27:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwmEB6Pi9e6sYk2K6eo/tuqYAKxoKtLJknvi3jiYNxTxzoooI9A9gJ5myHpDhDqVUjAv4FXlQ==
X-Received: by 2002:a05:622a:120a:b0:2de:2bf5:a990 with SMTP id y10-20020a05622a120a00b002de2bf5a990mr17421298qtx.143.1646080020333;
        Mon, 28 Feb 2022 12:27:00 -0800 (PST)
Received: from [172.31.1.6] ([71.161.196.139])
        by smtp.gmail.com with ESMTPSA id u3-20020a05622a010300b002dd22803f20sm7517602qtw.46.2022.02.28.12.26.59
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 12:27:00 -0800 (PST)
Message-ID: <5819a1ec-e65f-7c10-00a6-fafae7b12c0f@redhat.com>
Date:   Mon, 28 Feb 2022 15:26:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mountd: Fix potential data corrupter
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20220224190604.291491-1-steved@redhat.com>
In-Reply-To: <20220224190604.291491-1-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2/24/22 2:06 PM, Steve Dickson wrote:
> Commit 9c99b463 typecast an uint into a int
> to fix a Coverity warning. Potentially this
> could cause a very large rogue value to be
> negative allow the rouge value to index into
> a table causing corruption.
> 
> A check has been added to detect this type
> of situation.
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... (tag: nfs-utils-2-6-2-rc3)
With the addition of
   Reported-by: Richard Weinberger <richard@nod.at>

steved.
> ---
>   support/nfs/rpcdispatch.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/support/nfs/rpcdispatch.c b/support/nfs/rpcdispatch.c
> index f7c27c98..7329f419 100644
> --- a/support/nfs/rpcdispatch.c
> +++ b/support/nfs/rpcdispatch.c
> @@ -26,12 +26,13 @@ rpc_dispatch(struct svc_req *rqstp, SVCXPRT *transp,
>   			void *argp, void *resp)
>   {
>   	struct rpc_dentry	*dent;
> +	int rq_vers = (int)rqstp->rq_vers;
>   
> -	if (((int)rqstp->rq_vers) > nvers) {
> +	if (rq_vers < 1 || rq_vers > nvers) {
>   		svcerr_progvers(transp, 1, nvers);
>   		return;
>   	}
> -	dtable += (rqstp->rq_vers - 1);
> +	dtable += (rq_vers - 1);
>   	if (rqstp->rq_proc > dtable->nproc) {
>   		svcerr_noproc(transp);
>   		return;

