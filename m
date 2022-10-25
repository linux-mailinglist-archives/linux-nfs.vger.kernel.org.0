Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB97B60D1B6
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Oct 2022 18:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiJYQgd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Oct 2022 12:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiJYQgb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Oct 2022 12:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8F0E22D3
        for <linux-nfs@vger.kernel.org>; Tue, 25 Oct 2022 09:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666715789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pG0Z6dQuKKYZSRJ48ZIkSokVJqm5GLinIq+PBpjn/10=;
        b=XtuIplWXZvFcg7xy/cAprOnOVyApaoeh8MVaIxbKevB3BTZAAtCznmsXEe7xPenPSfL6YC
        K4nRqqN9D1ObjXUVHKorqN6fLnqhstYAPchesCNfNo7xj6K0itr19XC2pZeb7Qg/CLMqau
        tnwZenYxo8T0zwCK5OClyDZOvG2aJ4Y=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-447-r-EN9vxCOry-dzbRVomYow-1; Tue, 25 Oct 2022 12:36:28 -0400
X-MC-Unique: r-EN9vxCOry-dzbRVomYow-1
Received: by mail-qt1-f198.google.com with SMTP id d25-20020ac847d9000000b0039d0dd90182so9341355qtr.3
        for <linux-nfs@vger.kernel.org>; Tue, 25 Oct 2022 09:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pG0Z6dQuKKYZSRJ48ZIkSokVJqm5GLinIq+PBpjn/10=;
        b=K3Jh2gPqK5KoSqan47GfODoaxeWEOiGU9EIUbqCrmsHicghKBj5t3l9KalDY4XbhPN
         DHDYoZKTv8qTPKBpR2tAINAzbFxTb00RC94Ry5cR4k4DmgiL5OOD9wxYfoVmhyyUwohg
         txaFFgDyQyv0KKfVYRidsCdG66yM8kLSa6MtmMglMgeWCWrpm9F+UvjHZrFLmdV6B8cS
         9/HkricHTNc8BiNGBvdmA6lMhvKwH8M4pRKnuvlN4C4W8/3wr6g0kWrN0VxOYOVwgB9a
         SC5rNQurRxL/QzT6Bh1xpuU22rwY/k3IEPcySH9jWKmDFDY0F41gx4iJBbEaKNpLjhgM
         W8pQ==
X-Gm-Message-State: ACrzQf3IqPWiZ2lz+ppq/O4iU5IQFEiv36imZHk6GFqWG8oMf1kT29Jb
        4WRt/TC5UmVtB4bKZVtKEJVvssXH1rhS7+NaW92yBuWwXcGfGDLa0FyyT8zwWbguNC3Z3Rnz3tP
        KObj99YePm571NGHoxtD4
X-Received: by 2002:a05:6214:c89:b0:4b1:99b8:9260 with SMTP id r9-20020a0562140c8900b004b199b89260mr32730630qvr.116.1666715787457;
        Tue, 25 Oct 2022 09:36:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7A15oRdyTpQsRtp+k9OYtmYujwtxYlCb5ieONNzqU/LoV10kZIAw/Wtckbd3A/xt6aUTBmow==
X-Received: by 2002:a05:6214:c89:b0:4b1:99b8:9260 with SMTP id r9-20020a0562140c8900b004b199b89260mr32730612qvr.116.1666715787209;
        Tue, 25 Oct 2022 09:36:27 -0700 (PDT)
Received: from ?IPV6:2603:6000:d605:db00:db8c:7bbd:f449:802d? (2603-6000-d605-db00-db8c-7bbd-f449-802d.res6.spectrum.com. [2603:6000:d605:db00:db8c:7bbd:f449:802d])
        by smtp.gmail.com with ESMTPSA id bm33-20020a05620a19a100b006e42a8e9f9bsm2237252qkb.121.2022.10.25.09.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 09:36:26 -0700 (PDT)
Message-ID: <e7c0f372-a919-e078-6f61-c0013bf34d01@redhat.com>
Date:   Tue, 25 Oct 2022 12:36:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] libtirpc: add missing extern
To:     Rosen Penev <rosenp@gmail.com>, linux-nfs@vger.kernel.org
References: <20220919235954.14011-1-rosenp@gmail.com>
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220919235954.14011-1-rosenp@gmail.com>
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



On 9/19/22 7:59 PM, Rosen Penev wrote:
> Fixes compilation warning.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
Committed...

steved.
> ---
>   src/svc_auth.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/src/svc_auth.c b/src/svc_auth.c
> index ce8bbd8..789d6af 100644
> --- a/src/svc_auth.c
> +++ b/src/svc_auth.c
> @@ -66,6 +66,9 @@ static struct authsvc *Auths = NULL;
>   
>   extern SVCAUTH svc_auth_none;
>   
> +#ifdef AUTHDES_SUPPORT
> +extern enum auth_stat _svcauth_des(struct svc_req *rqst, struct rpc_msg *msg);
> +#endif
>   /*
>    * The call rpc message, msg has been obtained from the wire.  The msg contains
>    * the raw form of credentials and verifiers.  authenticate returns AUTH_OK

