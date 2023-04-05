Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B086D83C0
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Apr 2023 18:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjDEQcX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Apr 2023 12:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDEQcW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Apr 2023 12:32:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E4E2710
        for <linux-nfs@vger.kernel.org>; Wed,  5 Apr 2023 09:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680712293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rEXGYlaVJ0QHkFm+8Y5wDm0J0kvyCPdRaHxOeB1cPFQ=;
        b=Py/kBaSJikx1U5YakF6MfYcY1MR5EsuUs64bFruDkA89pZ7jITyIS5vWrNeeneRQHmHS+K
        n55/NNFwr0UxdzIZLGdVFhgG9cxgzpO8u120AmHK8GuX9hJcZbDTNUvG3q6Je26pkZBSEN
        evN9qH7w9SH+OHvvYD3cNCe4f8jL+bY=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-A6l9VrvAM4OjgKKgcMw7pw-1; Wed, 05 Apr 2023 12:31:32 -0400
X-MC-Unique: A6l9VrvAM4OjgKKgcMw7pw-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-74116d760fcso10467241.1
        for <linux-nfs@vger.kernel.org>; Wed, 05 Apr 2023 09:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680712291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEXGYlaVJ0QHkFm+8Y5wDm0J0kvyCPdRaHxOeB1cPFQ=;
        b=BHklPEvzZXe40kAIAXSd7iaf7rdMSuo1CNIKQwGZsMIk5FMpFMFTn5A3fPkUUyVWqw
         ZRTfy1vmzn9hSUZ9bCZ+MGi0qA4PeoGKkJ8GeZWjjprtEwwi3yarDpsZ0JEm/rjSWc+t
         TxJXWSG3hMRjumk7EO3tkx6xPo+o6lEG+KnNLErmr+MEt7BCtpOZvy1dKOwybf0pIVJO
         xm1b44+CJJ3ZXgL2AVzbfm9BHy0JAhJ5ShWflng1pADcVysAQo8S/fgwPCeJMV7VoFzm
         LHXq/Uqg/2199OUIX/DSbiGaeTn9sBnRfttwxah2d+qVc39XKxW1Esghd3WORbOQ6A2K
         Khlw==
X-Gm-Message-State: AAQBX9fajIaCMZstaK2L2R5am8VFq5cTpM+Z6iQx4iC8+AOxFiyvsdYS
        XVQSrIeh5qOV/BFm0fOhIUcb6jxrEH1ZKyTct3fQjX7tjeRyUn7LVARcNyyiPV74Rz0IvKw0j2C
        kbtmHMH7A3/GAybjNeBd1
X-Received: by 2002:a1f:7d05:0:b0:432:4892:94aa with SMTP id y5-20020a1f7d05000000b00432489294aamr1126756vkc.1.1680712291721;
        Wed, 05 Apr 2023 09:31:31 -0700 (PDT)
X-Google-Smtp-Source: AKy350bQlSO0mFddc6d002thUrEMaEBmV31LoR2wnbHst1QHyuQUXPoxYSIfnQFDBM/f7NDAHgcsMw==
X-Received: by 2002:a1f:7d05:0:b0:432:4892:94aa with SMTP id y5-20020a1f7d05000000b00432489294aamr1126727vkc.1.1680712291476;
        Wed, 05 Apr 2023 09:31:31 -0700 (PDT)
Received: from [172.31.1.6] ([70.109.174.217])
        by smtp.gmail.com with ESMTPSA id i7-20020a37b807000000b0074a5ffbecd3sm1117755qkf.49.2023.04.05.09.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 09:31:31 -0700 (PDT)
Message-ID: <2fdcb2bf-e7c6-4b42-0974-b9259ad7800c@redhat.com>
Date:   Wed, 5 Apr 2023 12:31:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH nfs-utils] nfsd.man: fix typo in section on "scope".
Content-Language: en-US
To:     NeilBrown <neilb@suse.de>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <168004150341.8106.13618674008997774396@noble.neil.brown.name>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <168004150341.8106.13618674008997774396@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/28/23 6:11 PM, NeilBrown wrote:
> 
> 
> The missing "-" means that "-S" isn't mentioned at all.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
Committed... (tag: nfs-utils-2-6-3-rc7)

steved.
> ---
>   utils/nfsd/nfsd.man | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/utils/nfsd/nfsd.man b/utils/nfsd/nfsd.man
> index dc05f3623465..6f4fc1df3782 100644
> --- a/utils/nfsd/nfsd.man
> +++ b/utils/nfsd/nfsd.man
> @@ -38,7 +38,7 @@ request on all known network addresses.  This may change in future
>   releases of the Linux Kernel. This option can be used multiple times
>   to listen to more than one interface.
>   .TP
> -.B \S " or " \-\-scope scope
> +.B \-S " or " \-\-scope scope
>   NFSv4.1 and later require the server to report a "scope" which is used
>   by the clients to detect if two connections are to the same server.
>   By default Linux NFSD uses the host name as the scope.

