Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48211495238
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jan 2022 17:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376947AbiATQS1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jan 2022 11:18:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42156 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233059AbiATQS0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jan 2022 11:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642695506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lexm+TU7HNYjbB6SlxvtSrjEELnJ73rIfJVCT/0o2R0=;
        b=P2Q5W19LAKLUXk5Wm31+V7iVhmFJFxqLg7j3gupzCnsgN/Z8KMSlGjPsSYHJObGZkGasX6
        1j2i4itxxQpnzT8q+H0fgUpeKbnhfCUGVUgDr/uhbMxxV7jO+lRKih+oB+Qp54TveFSKke
        SU2yUELnBHXWmcpWbIKaKZofir6iUX8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-318-l5_eo6GZPguLiHrRFSm6eg-1; Thu, 20 Jan 2022 11:18:24 -0500
X-MC-Unique: l5_eo6GZPguLiHrRFSm6eg-1
Received: by mail-qk1-f198.google.com with SMTP id w8-20020a05620a148800b004798ef3e7d6so4466358qkj.11
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jan 2022 08:18:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Lexm+TU7HNYjbB6SlxvtSrjEELnJ73rIfJVCT/0o2R0=;
        b=HzkO4V51xpC4vW/NdViM1xN5XQAilBeX/w0DhbILepopj5zI4CDRfHxi3iBQeF4+g5
         Ji7qbx06IQcbNc+la4VtFw0INh400wUyUZBe7tetHQAbgNKwMrr7yG3Gy5IdvcpTcImP
         Xn4FacDB0NjBzibHOQrWBJ7ZV7ZiQZ8LZQQk5qFTi/X067PDzrxU7NSKPryd7X9SreDS
         oK6Bf1mPyhLPMwd8buKJEQF82HDqkLipKTfT3gfCzM6APS2BzfWrIx5xa8ukzLETLbm7
         do28tjWrEk1jnzaecKlN+d0hn/NMSmcYpqcxw8vDsLayDBvqmFK/bhWKrzT44rQ11f6C
         d2VQ==
X-Gm-Message-State: AOAM533PHm8P0My1E6MAWERecSQFIUlnoO8BI9jJwpYhfx7WVzW/Lidt
        EskrNoZ/d6hoadXVwJ6vGi2OzfEi4zDHtxNVDeh4Y1dAg5MN4IcoNt5cD9y3fHTleHNqOcHOtD9
        iCwOEEiJWbQdwDXo5sap4
X-Received: by 2002:ac8:574e:: with SMTP id 14mr14430583qtx.626.1642695504410;
        Thu, 20 Jan 2022 08:18:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnYX+nEY4W17sHRYXgPR6SIxdEkgHrXwddrQIpQW4y3SuZ4xk0R5OOVS1kHNgGr0q/N7TT5w==
X-Received: by 2002:ac8:574e:: with SMTP id 14mr14430551qtx.626.1642695504111;
        Thu, 20 Jan 2022 08:18:24 -0800 (PST)
Received: from [172.31.1.6] ([70.109.152.127])
        by smtp.gmail.com with ESMTPSA id m14sm1604501qtx.44.2022.01.20.08.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 08:18:23 -0800 (PST)
Message-ID: <77220ad7-b31b-a3ba-fb3e-4c0f203f22cf@redhat.com>
Date:   Thu, 20 Jan 2022 11:18:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/1] manpage: remove the no longer supported value "vers2"
Content-Language: en-US
To:     Yongcheng Yang <yoyang@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
        Yongcheng Yang <yongcheng.yang@gmail.com>
References: <20220117031356.13361-1-yoyang@redhat.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220117031356.13361-1-yoyang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/16/22 22:13, Yongcheng Yang wrote:
> From: Yongcheng Yang <yongcheng.yang@gmail.com>
> 
> Signed-off-by: Yongcheng Yang <yongcheng.yang@gmail.com>
Committed.

steved.

> ---
> 
> Hi SteveD,
> 
> We have removed the ability to enable NFS v2 and there is no default value
> "vers2" (in file nfs.conf) anymore. But some man pages are still mentioning
> this word.
> 
> Thanks,
> Yongcheng
> 
>   systemd/nfs.conf.man    | 1 -
>   utils/mountd/mountd.man | 3 +--
>   utils/nfsd/nfsd.man     | 2 --
>   3 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
> index 4436a38a..be487a11 100644
> --- a/systemd/nfs.conf.man
> +++ b/systemd/nfs.conf.man
> @@ -171,7 +171,6 @@ Recognized values:
>   .BR lease-time ,
>   .BR udp ,
>   .BR tcp ,
> -.BR vers2 ,
>   .BR vers3 ,
>   .BR vers4 ,
>   .BR vers4.0 ,
> diff --git a/utils/mountd/mountd.man b/utils/mountd/mountd.man
> index 77e6299a..a206a3e2 100644
> --- a/utils/mountd/mountd.man
> +++ b/utils/mountd/mountd.man
> @@ -286,10 +286,9 @@ The values recognized in the
>   section include
>   .BR TCP ,
>   .BR UDP ,
> -.BR vers2 ,
>   .BR vers3 ", and"
>   .B vers4
> -which each have same same meaning as given by
> +which each have the same meaning as given by
>   .BR rpc.nfsd (8).
>   
>   .SH TCP_WRAPPERS SUPPORT
> diff --git a/utils/nfsd/nfsd.man b/utils/nfsd/nfsd.man
> index 716f538b..634b8a63 100644
> --- a/utils/nfsd/nfsd.man
> +++ b/utils/nfsd/nfsd.man
> @@ -156,8 +156,6 @@ Enable (with "on" or "yes" etc) or disable ("off", "no") UDP support.
>   .B TCP
>   Enable or disable TCP support.
>   .TP
> -.B vers2
> -.TP
>   .B vers3
>   .TP
>   .B vers4

