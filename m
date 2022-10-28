Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6800611A71
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 20:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJ1Stb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 14:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJ1Sta (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 14:49:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFFB244C4E
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 11:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666982910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gXYiQPEWXwdySuWAO+YIQ6A6gdsnnYncg1sDMepmYCs=;
        b=E7fKwBoY8TYWjC+5j9BX/QirZYUDcFINVcdHFP3zxRN1OZqPZnFWD+CiUE6owIIOChg5nl
        Qj52Cl3zWNSGNQMe0rZOFjUwUr3RfY/tl7aVnPlvUgUZqSynjsGYrxlwwCy6N5B6x4uiBW
        NiKaasdbw6vPL8FPCG+MXB5qhs93xrc=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-116-9NOr4dg6PXK84v9o0SGCMw-1; Fri, 28 Oct 2022 14:48:28 -0400
X-MC-Unique: 9NOr4dg6PXK84v9o0SGCMw-1
Received: by mail-vs1-f71.google.com with SMTP id k62-20020a672441000000b003a762e05594so1599231vsk.18
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 11:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gXYiQPEWXwdySuWAO+YIQ6A6gdsnnYncg1sDMepmYCs=;
        b=eCGLjaMHDwrHndVvuMwjn7FN/l5No/10455nsawFHSF9TvcKJ8FoU2EOV+h5yzS3Ci
         2t+xjlVIrR+e1B3hW5JbZNr0qS76xJRjGPl4A/UjoNfK1ZJYLlHL8qj63+2vlQ6RnfHO
         vvqC8TmjKfnMmJRMXqPWeS8IBaUaGchVKnG36tn5bXU2GotFggFG0uKyaBW4puDxGfeJ
         CedWPjpgpAo4LVPRr/Zvpo9nbZ4TauDrs4wwzZdk8ASv4KI+u5fFjQ/S0ZHyck3ldd1m
         vib3OLE1hyoBRdHLu26+1lJ4mmvaJQysBS0Z6qs13ylZXtmn/theMkiVel2AxfoOFeui
         3N4w==
X-Gm-Message-State: ACrzQf2bm0voGcnLBv/Ugq3R8COtoe2AAOh+Ohr0+ngK+nOcj76h03zO
        NVHqekNdEf+UH70EkgJulwJbsOY1lgCn2r3J6U1LiRExNRehCeihV26kJDbyVPPnEbsFlgDdFOm
        XmDu9H8ETFcCgEpDWTEvI
X-Received: by 2002:a05:6214:d69:b0:4bb:693e:6e82 with SMTP id 9-20020a0562140d6900b004bb693e6e82mr733256qvs.48.1666981216916;
        Fri, 28 Oct 2022 11:20:16 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6IiqC5T7n+F6qOvLWxdZzfF0aT4KALWuvXONB/YcnfSzMQOjbQY8RArrerrK1QFvPywy5WIw==
X-Received: by 2002:a05:6214:d69:b0:4bb:693e:6e82 with SMTP id 9-20020a0562140d6900b004bb693e6e82mr733237qvs.48.1666981216694;
        Fri, 28 Oct 2022 11:20:16 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.255.216])
        by smtp.gmail.com with ESMTPSA id k25-20020ac84759000000b0039bfe8acff6sm2737095qtp.58.2022.10.28.11.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 11:20:16 -0700 (PDT)
Message-ID: <5fb73a5a-3840-3bd4-6b9b-ef6c9203f383@redhat.com>
Date:   Fri, 28 Oct 2022 14:20:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH V2] [nfs/nfs-utils/libtirpc] clnt_raw.c: fix a possible
 null pointer dereference
Content-Language: en-US
To:     Zhi Li <yieli@redhat.com>, linux-nfs@vger.kernel.org
References: <20221028091033.278199-1-yieli@redhat.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20221028091033.278199-1-yieli@redhat.com>
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



On 10/28/22 5:10 AM, Zhi Li wrote:
> Since clntraw_private could be dereferenced before
> allocated, protect it by checking its value in advance.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2138317
> Signed-off-by: Zhi Li <yieli@redhat.com>
Committed...

steved.
> ---
>   src/clnt_raw.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/src/clnt_raw.c b/src/clnt_raw.c
> index 31f9d0c..03f839d 100644
> --- a/src/clnt_raw.c
> +++ b/src/clnt_raw.c
> @@ -142,7 +142,7 @@ clnt_raw_call(h, proc, xargs, argsp, xresults, resultsp, timeout)
>   	struct timeval timeout;
>   {
>   	struct clntraw_private *clp = clntraw_private;
> -	XDR *xdrs = &clp->xdr_stream;
> +	XDR *xdrs;
>   	struct rpc_msg msg;
>   	enum clnt_stat status;
>   	struct rpc_err error;
> @@ -154,6 +154,7 @@ clnt_raw_call(h, proc, xargs, argsp, xresults, resultsp, timeout)
>   		mutex_unlock(&clntraw_lock);
>   		return (RPC_FAILED);
>   	}
> +	xdrs = &clp->xdr_stream;
>   	mutex_unlock(&clntraw_lock);
>   
>   call_again:
> @@ -245,7 +246,7 @@ clnt_raw_freeres(cl, xdr_res, res_ptr)
>   	void *res_ptr;
>   {
>   	struct clntraw_private *clp = clntraw_private;
> -	XDR *xdrs = &clp->xdr_stream;
> +	XDR *xdrs;
>   	bool_t rval;
>   
>   	mutex_lock(&clntraw_lock);
> @@ -254,6 +255,7 @@ clnt_raw_freeres(cl, xdr_res, res_ptr)
>   		mutex_unlock(&clntraw_lock);
>   		return (rval);
>   	}
> +	xdrs = &clp->xdr_stream;
>   	mutex_unlock(&clntraw_lock);
>   	xdrs->x_op = XDR_FREE;
>   	return ((*xdr_res)(xdrs, res_ptr));

