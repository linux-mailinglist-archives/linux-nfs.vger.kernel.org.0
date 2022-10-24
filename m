Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878AF60B7B3
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Oct 2022 21:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiJXTaj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 15:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiJXT2p (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 15:28:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013EEA7ABC
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 11:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666634349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vZozVNRvVQt5X8iZzcuxyit4OFkJ51NIuBTUkymNjEY=;
        b=c7uSUMt3ncvwBpFvh7dLi9Ja9TU2b2kU9lykdn0o/lLFnaHehcwVZGACrm1vh6Gil/dJjN
        WkPQjQ/UxPkfYuZZDY4gb3GzFnuoPvU6pv+MrxN8beRRV5VXsTW10zLOX8OghGW2cmGMo3
        yYLclHNBp9pW09pNKaGyG6EIRILJVWc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-198-vty73XmtNH2pHGJDvDVjtw-1; Mon, 24 Oct 2022 13:48:21 -0400
X-MC-Unique: vty73XmtNH2pHGJDvDVjtw-1
Received: by mail-qt1-f197.google.com with SMTP id a19-20020a05622a02d300b0039a3711179dso7482251qtx.12
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 10:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZozVNRvVQt5X8iZzcuxyit4OFkJ51NIuBTUkymNjEY=;
        b=mZHOJJuzXuDpE2aRYtgrhs/8EzFORFBqWS67noXInCYOIpuQ3l5uEbhN1aAhiEuLfv
         UWVjr566AXDeKFmraHR+J7u2ELF65odxLKjnb1z03cYoK5aOhlRo6yZWxTxU8hgP2L7n
         H8g143dnVajCml+kZt3KVZlWGLMaoVClPN10k6bB7CtUQy9om5xxXA/2u5UZ/4qKb9tD
         NGQ3vxob4ztZvT2hg8LNjYpg5JqQWGGpcG1e6E1Zspu1F7cADhs93yyHMR7CQ5/G3sdj
         CBOlhSmU+6ttA4kUDHdCvKjdqbUlm45fAFTJrGKnXrTiaR/P+U5RqtBkBRzCQOKnXlc7
         M8zg==
X-Gm-Message-State: ACrzQf3e2127wa88u3THcXi3JJVbrH70zGEFAEVMHV+VUI4fECp7FQ62
        pNd74xjeSkX75LADClarEkp+Xq9G797uY07a99jEsSfIU0etTk25t3cbBiFJ2pzqUkGs77BaBSy
        R66ugLssHstWXhpFybto1
X-Received: by 2002:a05:622a:1905:b0:39c:f723:f31 with SMTP id w5-20020a05622a190500b0039cf7230f31mr27010069qtc.54.1666633700769;
        Mon, 24 Oct 2022 10:48:20 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7jcFQqNDnE8yfObwyePzM44sFxP9vwPCOl1rGZx/d2U5dfmvTpFeydgQZhgK3qZIIyCv6rng==
X-Received: by 2002:a05:622a:1905:b0:39c:f723:f31 with SMTP id w5-20020a05622a190500b0039cf7230f31mr27010058qtc.54.1666633700484;
        Mon, 24 Oct 2022 10:48:20 -0700 (PDT)
Received: from ?IPV6:2603:6000:d605:db00:db8c:7bbd:f449:802d? (2603-6000-d605-db00-db8c-7bbd-f449-802d.res6.spectrum.com. [2603:6000:d605:db00:db8c:7bbd:f449:802d])
        by smtp.gmail.com with ESMTPSA id l16-20020a05622a051000b0039ee562799csm282064qtx.59.2022.10.24.10.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 10:48:19 -0700 (PDT)
Message-ID: <05574fc8-7d4a-e68d-2167-cac6f631e105@redhat.com>
Date:   Mon, 24 Oct 2022 13:48:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] [nfs/nfs-utils/libtirpc] bindresvport.c: fix a potential
 resource leakage
Content-Language: en-US
To:     Zhi Li <yieli@redhat.com>, linux-nfs@vger.kernel.org
References: <20221020063309.3674419-1-yieli@redhat.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20221020063309.3674419-1-yieli@redhat.com>
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



On 10/20/22 2:33 AM, Zhi Li wrote:
> Subject:
> [PATCH] [nfs/nfs-utils/libtirpc] bindresvport.c: fix a potential 
> resource leakage
> From:
> Zhi Li <yieli@redhat.com>
> Date:
> 10/20/22, 2:33 AM
> 
> To:
> linux-nfs@vger.kernel.org
> CC:
> steved@redhat.com, Zhi Li <yieli@redhat.com>
> 
> 
> Close the FILE *fp of load_blacklist() in another
> return path to avoid potential resource leakage.
> 
> Fixes:https://bugzilla.redhat.com/show_bug.cgi?id=2135405
> Signed-off-by: Zhi Li<yieli@redhat.com>
Committed...

steved.
> ---
>   src/bindresvport.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/src/bindresvport.c b/src/bindresvport.c
> index 5c0ddcf..efeb1cc 100644
> --- a/src/bindresvport.c
> +++ b/src/bindresvport.c
> @@ -130,6 +130,7 @@ load_blacklist (void)
>   	  if (list == NULL)
>   	    {
>   	      free (buf);
> +	      fclose (fp);
>   	      return;
>   	    }
>   	}
> -- 2.31.1
> 

