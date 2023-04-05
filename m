Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C096D83B4
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Apr 2023 18:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjDEQaW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Apr 2023 12:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjDEQaW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Apr 2023 12:30:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDA9198D
        for <linux-nfs@vger.kernel.org>; Wed,  5 Apr 2023 09:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680712172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tiwstiz5Bxsyz38AhpAovsAETKktM98Jr1+qfgXml7U=;
        b=V8M7QZo5hJQyoLUHyegq+JFIM1qfazyYnqMNX4f5Lur4XZOcuLf8rf23zJbQ1NRjjZzzlC
        Uv77fk7eI3Y6Il2Ni8XBsS6cWlRYIuUNG1ZgFCBw6niOr4P9AzHE+62aVgsjkYGhMLmSik
        T48m0Wq+8cG1urw5K6NKbIgMFxGJhjQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-Ca3Qy3a7P-aedxD1YGM81A-1; Wed, 05 Apr 2023 12:29:31 -0400
X-MC-Unique: Ca3Qy3a7P-aedxD1YGM81A-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-5e11d438c1aso577956d6.1
        for <linux-nfs@vger.kernel.org>; Wed, 05 Apr 2023 09:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680712170; x=1683304170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tiwstiz5Bxsyz38AhpAovsAETKktM98Jr1+qfgXml7U=;
        b=0KwQzODa7PwhuKUUPeTw9MIHnRaEbF1HeN/PQTs4595dWag3dbvgnlBdVNfV3V1hPI
         cKDEqsQEFEYnguayvRZ2XZR2tknvrhbQ8s2lKBqeOXbPtisMWtdj3SfuHZIXm9j+EtX/
         hEmQCFblGU5R1HMxXzyzj71WxbWBriJKYJwbfnPcA7WRADvknIoOscunWkIewO2A+e9Z
         85BwuppocrX4T72YUT1O/xXEicUxvvoyv+zJiHoPisNDmoUrh3OoQzn6UGkDk0irTU/d
         BJDERbsTmF02sY57vJv5utXVqx0Sbq3C5XCvOg8paF5lIVhFtbGKbaRGheyRcrUtHkCl
         Zr2g==
X-Gm-Message-State: AAQBX9eHkBrbAxxEUBA2Cgj8jtpFALGZzw6zxdvndfpbvXmGlHFhm+ZW
        S9I0EUiPHCk0mMnjTKojUpoIZs8ytmd8Mk/ymj4EJlekvHXlVJrM4d9wm+M27yrdv4yKNUGYDd1
        VonTJm5C5vOUBcJ1kOpaw9iq5CAFm
X-Received: by 2002:a05:6214:29ce:b0:5e0:84a9:2927 with SMTP id gh14-20020a05621429ce00b005e084a92927mr4435383qvb.4.1680712170334;
        Wed, 05 Apr 2023 09:29:30 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yj1HRJbxHpe+tfPhRIvLOYQVCW5cv0kGTGYimwRsTPzgzbclDRHhNc/XF8Q7rf8WmdE4OL5w==
X-Received: by 2002:a05:6214:29ce:b0:5e0:84a9:2927 with SMTP id gh14-20020a05621429ce00b005e084a92927mr4435338qvb.4.1680712169907;
        Wed, 05 Apr 2023 09:29:29 -0700 (PDT)
Received: from [172.31.1.6] ([70.109.174.217])
        by smtp.gmail.com with ESMTPSA id oj10-20020a056214440a00b005e3c45c5cbdsm2528068qvb.96.2023.04.05.09.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 09:29:29 -0700 (PDT)
Message-ID: <5be04541-fda5-cfc1-1f19-ffd5f7b6ba6d@redhat.com>
Date:   Wed, 5 Apr 2023 12:29:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH nfs-utils v2] nfsmount.conf: Fix typo of the attribute
 name
Content-Language: en-US
To:     Yongcheng Yang <yongcheng.yang@gmail.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20230314063004.3660-1-yongcheng.yang@gmail.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20230314063004.3660-1-yongcheng.yang@gmail.com>
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



On 3/14/23 2:30 AM, Yongcheng Yang wrote:
> Signed-off-by: Yongcheng Yang <yongcheng.yang@gmail.com>
Committed... (tag: nfs-utils-2-6-3-rc7)

steved.
> ---
>   utils/mount/nfsmount.conf | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/utils/mount/nfsmount.conf b/utils/mount/nfsmount.conf
> index 342063f7..c498eb80 100644
> --- a/utils/mount/nfsmount.conf
> +++ b/utils/mount/nfsmount.conf
> @@ -59,13 +59,13 @@
>   # acregmin=30
>   #
>   # The Maximum time (in seconds) file attributes are cached
> -# acregmin=60
> +# acregmax=60
>   #
>   # The minimum time (in seconds) directory attributes are cached
> -# acregmin=30
> +# acdirmin=30
>   #
>   # The Maximum time (in seconds) directory attributes are cached
> -# acregmin=60
> +# acdirmax=60
>   #
>   # Enable Access  Control  Lists
>   # Acl=False

