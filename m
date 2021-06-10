Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B243A32A4
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jun 2021 20:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFJSDp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Jun 2021 14:03:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36079 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229823AbhFJSDp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Jun 2021 14:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623348108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DkO5Xo5sotZqdxeApByW/uqlUadZNG7IqItYU3oRdL4=;
        b=UVZfol05Yj8NJXbqyF9Ugt6rnTmkaCKX2LxnXHHXJNGcpYvQcLrGvL5vUTnkVNqc3nTRjs
        iqWnk62BmNA9i8wXFDf2Fa+prbz0ZUPQWLrBdvPKmvOUVLEH9r7/g0daLmtT4VBOFcZNQs
        AhZ2CL2Dx9f0EKvJu1JzbDLgkEgugJs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-iTy5AxLMPBGfNBvDmnjNYw-1; Thu, 10 Jun 2021 14:01:47 -0400
X-MC-Unique: iTy5AxLMPBGfNBvDmnjNYw-1
Received: by mail-qt1-f200.google.com with SMTP id i24-20020ac876580000b02902458afcb6faso329455qtr.23
        for <linux-nfs@vger.kernel.org>; Thu, 10 Jun 2021 11:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DkO5Xo5sotZqdxeApByW/uqlUadZNG7IqItYU3oRdL4=;
        b=PvzpdifcDjduePvASE4OYOLD8069UZeQQC0YOwqro2wbGrtQt3s/bJ1CCNlBrRxCUg
         Cvvh4pduPEBD0IcjDSxIjS3kKHHmxi1ESD05lcsf8lWuF0RXKQCxWZxCE57JkSaBLejt
         +kFbOrnapcIoTuwLwHIiEnbQWAkU8PrptWyr8L9t1ckPt/LOGReYDTbaLy3ceroQUMU7
         TPScJ9r+wC/bhS/kyHNBC86RSkQyFGxdWvUnFg3+IW0GeV0tRhEzdKOnSfkTk0i+53Bw
         /JK8VQ/uARq7+y9J/N17BP/+YIqTSCZMK+yaklMzzR3TWvDgX9tHW4QpU77aO5Iq2alK
         rq1Q==
X-Gm-Message-State: AOAM533OURDfNha/GcLo0zW8W275IckZMQbb9AAgo9gN1bq2qwrrp94n
        qHQUe+P84jJLXaCbQJfnXjMod6Hjv244AbNAWZJKY3Yurg4LaJCVKGxx7InNuwLZTg6UH1/8rU2
        yGR51mcUbOp8KvcmlrMcUtRYc+vCkagDz0w28+n7KAykO30Op19+av4r6uaO7Tzo4PwBv1A==
X-Received: by 2002:ac8:7615:: with SMTP id t21mr31706qtq.140.1623348106538;
        Thu, 10 Jun 2021 11:01:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMkwD/7dpOU8OljqpAwZNUYEmzyBb39kEeKktxc3Sx5wBeiAta2nHWCQOoFwDAzmJwbdeR3g==
X-Received: by 2002:ac8:7615:: with SMTP id t21mr31528qtq.140.1623348104661;
        Thu, 10 Jun 2021 11:01:44 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([71.161.93.112])
        by smtp.gmail.com with ESMTPSA id 200sm2738785qkk.12.2021.06.10.11.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 11:01:44 -0700 (PDT)
Subject: Re: [PATCH] nfs(5): Correct the spelling of "kernel_source"
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
References: <162317182289.1639.2985340972351210574.stgit@oracle-100.nfsv4.dev>
From:   Steve Dickson <steved@redhat.com>
Message-ID: <4fe4b5c7-b172-d893-18fd-224c24b2a6cf@redhat.com>
Date:   Thu, 10 Jun 2021 14:04:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <162317182289.1639.2985340972351210574.stgit@oracle-100.nfsv4.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 6/8/21 1:03 PM, Chuck Lever wrote:
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Committed (tag: nfs-utils-2-5-4-rc7

steved.
> ---
>   utils/mount/nfs.man |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
> index 19fe22fb5411..5682b5592a66 100644
> --- a/utils/mount/nfs.man
> +++ b/utils/mount/nfs.man
> @@ -552,7 +552,7 @@ detailed discussion of these trade-offs.
>   .BR fsc " / " nofsc
>   Enable/Disables the cache of (read-only) data pages to the local disk
>   using the FS-Cache facility. See cachefilesd(8)
> -and <kernel_soruce>/Documentation/filesystems/caching
> +and <kernel_source>/Documentation/filesystems/caching
>   for detail on how to configure the FS-Cache facility.
>   Default value is nofsc.
>   .SS "Options for NFS versions 2 and 3 only"
> 
> 

