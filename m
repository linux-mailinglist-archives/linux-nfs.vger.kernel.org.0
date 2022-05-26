Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3041153528F
	for <lists+linux-nfs@lfdr.de>; Thu, 26 May 2022 19:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348295AbiEZReP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 May 2022 13:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348292AbiEZReO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 May 2022 13:34:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D32C6D849
        for <linux-nfs@vger.kernel.org>; Thu, 26 May 2022 10:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653586452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HfZ8nyPDMe89FBxL5XNerJPxvx96VldW0kScsgrDt38=;
        b=VjIo8/0ICwNOZ+cdhiC6KpIoDUH8wb1JnhYExfu9w9PR7F5j+SOFddyCQ/N5c6XCdb7+Iu
        uRx5URaUJOzuov+Gtkt5tjRf3iVr15oFL6vqpB+NzxeKZUWYWX/oRfCZ9uiZVh9LOLzVs1
        HrJYkE5anXNxejXyGom2laPNi+NVmDQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-wvNwN6EgPSCkf7t0cU-NcQ-1; Thu, 26 May 2022 13:34:08 -0400
X-MC-Unique: wvNwN6EgPSCkf7t0cU-NcQ-1
Received: by mail-qk1-f199.google.com with SMTP id bj2-20020a05620a190200b005084968bb24so1988850qkb.23
        for <linux-nfs@vger.kernel.org>; Thu, 26 May 2022 10:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HfZ8nyPDMe89FBxL5XNerJPxvx96VldW0kScsgrDt38=;
        b=evRGiXRbmqcIt6JzezUSFMEYkESo5SWdfLyX/k2q05lDqqzTqCcxRdM6LjryBtDkxv
         CX46sMSvB5PtjC1SsgzLbPnM9k4dGN+KsPMOvbk4Tg8fAFBaPkGrxp8jztTOdg0ynmE8
         AEAMpTkWOkbZrLR7unw+2IS9D+qTUmWTDIAi6Z65ajbS83t0sz/kSJpvxPBDqV/d7Zj5
         MJl0f5DTL5fYQTxmgN3Kt4F6Rn2rOiPRcFZaouefMZkx2g0uEDdov1CI10YjA7QJGTkz
         YW6F4hsVfSWtltba46uZZMB6pVUu+VJabO3LHQdy+RqJ7hux4QpRXJgrKzikPjEJXrbj
         rRpA==
X-Gm-Message-State: AOAM53318rpiLW8fVI0xdwrv4ZeTNGoLZjk9427Lz9lTld+H+LnEMyQX
        VcUD3AHvX5jP1/oESWjew4JoI09aDumqIFdJYFBDYjhFkF3mfzdOVSZBt8MIzr88yZW7U+v3DC9
        ArEu16hC1RY5STTfnFb6V
X-Received: by 2002:a37:ab01:0:b0:6a3:4bb6:50e8 with SMTP id u1-20020a37ab01000000b006a34bb650e8mr21213746qke.255.1653586448280;
        Thu, 26 May 2022 10:34:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrPw5GmFM9sLa/QByVzUdxPbCAPL8MajCeJNf8B7MFdFEynid31UYFE1CjysV9Sa2b/2gZiA==
X-Received: by 2002:a37:ab01:0:b0:6a3:4bb6:50e8 with SMTP id u1-20020a37ab01000000b006a34bb650e8mr21213737qke.255.1653586448065;
        Thu, 26 May 2022 10:34:08 -0700 (PDT)
Received: from [10.19.60.33] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d2-20020ac85442000000b002f933204688sm1278747qtq.4.2022.05.26.10.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 10:34:07 -0700 (PDT)
Message-ID: <4deae036-d3a7-abc5-446c-8f102c7da455@redhat.com>
Date:   Thu, 26 May 2022 13:34:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 1/2] rpcctl: Use the correct function for setting xprts
 offline and online
Content-Language: en-US
To:     Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
References: <20220519154727.3577715-1-anna@kernel.org>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220519154727.3577715-1-anna@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/19/22 11:47 AM, Anna Schumaker wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> Otherwise the tool will tell us:
>      'Namespace' object has no attribute 'set_state'
> 
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Committed... (tag: nfs-utils-2-6-2-rc5)

steved.
> ---
>   tools/rpcctl/rpcctl.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
> index b8df556b682c..2a69eacd3103 100755
> --- a/tools/rpcctl/rpcctl.py
> +++ b/tools/rpcctl/rpcctl.py
> @@ -142,7 +142,7 @@ class Xprt:
>                   xprt.set_state("offline")
>                   xprt.set_state("remove")
>               else:
> -                args.set_state(args.property)
> +                xprt.set_state(args.property)
>           print(xprt)
>   
>   

