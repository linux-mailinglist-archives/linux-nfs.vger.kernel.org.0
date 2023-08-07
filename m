Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F103772137
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Aug 2023 13:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjHGLT7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Aug 2023 07:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjHGLTj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Aug 2023 07:19:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585D02129
        for <linux-nfs@vger.kernel.org>; Mon,  7 Aug 2023 04:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691406977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=itL9UTWMGbiLz7ibQgaGwnEq3TqUBI6Vhy5bhSTOv24=;
        b=KzuVPxKKc0UWzUmcBwfyYrgjio0GjEJtuUSvuz0ACSAMoZA85r9oxqcMZsXUtr0h+0zcQU
        jfQQ7eBTBKDdyk5h6N3sTFCjz3k1HaIoQlLf49vvfAOA6BoJliAOZVl2gLCcldNlmt0Az8
        4sQTKO6HMSBZRKfbpk0NKOyuKioENio=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-CwQo1srjOKKbjYn-ipi3Sw-1; Mon, 07 Aug 2023 07:16:16 -0400
X-MC-Unique: CwQo1srjOKKbjYn-ipi3Sw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76cb292df12so142957885a.0
        for <linux-nfs@vger.kernel.org>; Mon, 07 Aug 2023 04:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691406975; x=1692011775;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itL9UTWMGbiLz7ibQgaGwnEq3TqUBI6Vhy5bhSTOv24=;
        b=LovDex1SM0U3/U+vObaWCmuSCL9oZEGBIWqPD7Xtg5wnitYMtb1rhIkhblRcng1Ey4
         65Hxijya8nFhAMWZ3txi+a9LNBjF62xWyD67uCHKO6oGQYaNP9Az+tIY6Y8/pnwIdvI0
         Ygjnco3EM9kFIH1PU53Ys1wpnCetLF/4Ow4jbulD725BQQgTBDlVsIA5Bm6LlH8RoXrC
         9pwZvHTGvpwjxgZEbuCZKgXG4YZmO0qam5VA4Yj4eD5sRtNK8sVHE0j/JeaxXu8hSdru
         1Qn+QmYmdAgiPT9WMj01y20+1xK+8J0ESclYLi2/xZwAL02bzxh1GBnk4v5dnP7YZ3fX
         SiIQ==
X-Gm-Message-State: AOJu0Ywp+8e9HpJDdgP1UQuY/QhQj1QVuB7WIepbtlKsPX3oyyG4lPml
        ZG6jVZHjlZ//gjOkVCSzCwSq/ngPl556rkJNc4P5JMiDkgvFrNhS/sEH8rWYDuaiCmCwFy6ZO1Y
        joE4N/pKSFYtcqxgeWzph8V5DaE1T
X-Received: by 2002:a05:620a:1789:b0:76c:ea67:38cd with SMTP id ay9-20020a05620a178900b0076cea6738cdmr13271221qkb.4.1691406975207;
        Mon, 07 Aug 2023 04:16:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU887L/1IKOiRb3sM4u3i7pqyVMK46xRpf98Vc6e83SuJr3sWqKTGH4ND93aTP72dfJ2en0Q==
X-Received: by 2002:a05:620a:1789:b0:76c:ea67:38cd with SMTP id ay9-20020a05620a178900b0076cea6738cdmr13271209qkb.4.1691406974991;
        Mon, 07 Aug 2023 04:16:14 -0700 (PDT)
Received: from [172.31.1.12] ([71.161.93.223])
        by smtp.gmail.com with ESMTPSA id 16-20020a05620a071000b00765ab6d3e81sm2508642qkc.122.2023.08.07.04.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 04:16:14 -0700 (PDT)
Message-ID: <f9ac4cc1-8548-c4d7-ece8-214933a56808@redhat.com>
Date:   Mon, 7 Aug 2023 07:16:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Libtirpc-devel] [PATCH 2/2] rpcb_clnt.c: Eliminate double frees
 in delete_cache()
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
To:     Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20230801144209.557175-1-steved@redhat.com>
 <20230801144209.557175-2-steved@redhat.com>
In-Reply-To: <20230801144209.557175-2-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 8/1/23 10:42 AM, Steve Dickson wrote:
> From: Herb Wartens <wartens2@llnl.gov>
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2224666
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... (tag: libtirpc-1-3-4-rc2)

steved
> ---
>   src/rpcb_clnt.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/src/rpcb_clnt.c b/src/rpcb_clnt.c
> index c0a9e12..68fe69a 100644
> --- a/src/rpcb_clnt.c
> +++ b/src/rpcb_clnt.c
> @@ -262,12 +262,15 @@ delete_cache(addr)
>   	for (cptr = front; cptr != NULL; cptr = cptr->ac_next) {
>   		if (!memcmp(cptr->ac_taddr->buf, addr->buf, addr->len)) {
>   			/* Unlink from cache. We'll destroy it after releasing the mutex. */
> -			if (cptr->ac_uaddr)
> +			if (cptr->ac_uaddr) {
>   				free(cptr->ac_uaddr);
> -			if (prevptr)
> +				cptr->ac_uaddr = NULL;
> +			}
> +			if (prevptr) {
>   				prevptr->ac_next = cptr->ac_next;
> -			else
> +			} else {
>   				front = cptr->ac_next;
> +			}
>   			cachesize--;
>   			break;
>   		}

