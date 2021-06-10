Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5F73A32A3
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jun 2021 20:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFJSDO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Jun 2021 14:03:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229823AbhFJSDO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Jun 2021 14:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623348077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fc80/VrIIVFd9lCt77CmjeO9NlkkTPPzREilH7/fpv8=;
        b=CsDA4ljFu3gj9LvaFhLXY0/+UCFMOAsk+vO3M683+cFkVlmWhLeXB3/rC2FZT7mu+oQbT7
        b/VHHwDf+dsmDr9QMDvmfVXXAbI1+gtSg/O3t/JE3qocRb31mPjKioOu9FQoRW8ETtM5bP
        uNQfJrR43LZQ4Y9YaHcLhA5sADy95v4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-HDlRH-Y2NI6b2V7n8vDoZg-1; Thu, 10 Jun 2021 14:01:16 -0400
X-MC-Unique: HDlRH-Y2NI6b2V7n8vDoZg-1
Received: by mail-qk1-f200.google.com with SMTP id v1-20020a372f010000b02903aa9be319adso10066596qkh.11
        for <linux-nfs@vger.kernel.org>; Thu, 10 Jun 2021 11:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fc80/VrIIVFd9lCt77CmjeO9NlkkTPPzREilH7/fpv8=;
        b=oAsdGJ/s/SPDxh3M98CH5dD9vM05w+LPy92KyHbfTpU5xZuveMo+/wOWbmOK0LPkXu
         V9KJGB4fD9MO5N3zJH3mpKCVi2oaDGnwFaXX08QH3Rh9/6wkWpFeDNrlHdfqM7BFQ6cU
         D9n2vjyxq2vaf1AVEbPDP8nGevyJYUXoymgXNOjBhYlx2Da1o36GSFBboq1ueEpJMCKC
         nqpn5aoqQ6BsK8EfpaEeFd+ZMiKc4Ex3HGhk3eJ5/D90m6n5Ocmwl1FhHOfybZBZ3pmF
         5VifU0bqug9+g640AvcrvYNdqfj0L/HLYOHcQYFxXdmkIdYOvsMMtXxXFuRVroPZRUDe
         98cw==
X-Gm-Message-State: AOAM531QNvDxgBcrsY1ET5CA2h4tQ+qn9QeQ9ZpoE/0l03nlHYgQQ4os
        FM6LeIcsOKSZlAGXgPtl8JoOcDUrv+fwpyjlCFMJmXUkIi609f7NeD06JuivkKRnvPwwdxyaUcj
        YygvZXI8NTJ7Fxt2EUu6/wLuYPBmyA4WFAY0CiYjs6MYrR93C3GF0cjfbw+MOCuKko9ed9w==
X-Received: by 2002:ac8:7d0c:: with SMTP id g12mr18836qtb.248.1623348075751;
        Thu, 10 Jun 2021 11:01:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEUUBUWZNocUQdeUc9MHB5W3WdL6F2BIl4N+O3ajJBQ9jwegqYYVB1+y8Z7B3S2NZwInhqvg==
X-Received: by 2002:ac8:7d0c:: with SMTP id g12mr18795qtb.248.1623348075477;
        Thu, 10 Jun 2021 11:01:15 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([71.161.93.112])
        by smtp.gmail.com with ESMTPSA id s133sm2715523qke.97.2021.06.10.11.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 11:01:15 -0700 (PDT)
Subject: Re: [PATCH] nfs(5): Fix missing mentions of "rdma6" netid
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
References: <162317221773.1999.16160807270651134948.stgit@oracle-100.nfsv4.dev>
From:   Steve Dickson <steved@redhat.com>
Message-ID: <29051308-1932-cea1-3057-f84af2d59009@redhat.com>
Date:   Thu, 10 Jun 2021 14:04:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <162317221773.1999.16160807270651134948.stgit@oracle-100.nfsv4.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 6/8/21 1:10 PM, Chuck Lever wrote:
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   utils/mount/nfs.man |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
Committed (tag: nfs-utils-2-5-4-rc7

steved.
> 
> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
> index 5682b5592a66..f98cb47dbf99 100644
> --- a/utils/mount/nfs.man
> +++ b/utils/mount/nfs.man
> @@ -564,7 +564,7 @@ The
>   .I netid
>   determines the transport that is used to communicate with the NFS
>   server.  Available options are
> -.BR udp ", " udp6 ", "tcp ", " tcp6 ", and " rdma .
> +.BR udp ", " udp6 ", "tcp ", " tcp6 ", " rdma ", and " rdma6 .
>   Those which end in
>   .B 6
>   use IPv6 addresses and are only available if support for TI-RPC is
> @@ -812,7 +812,7 @@ The
>   .I netid
>   determines the transport that is used to communicate with the NFS
>   server.  Supported options are
> -.BR tcp ", " tcp6 ", and " rdma .
> +.BR tcp ", " tcp6 ", " rdma ", and " rdma6 .
>   .B tcp6
>   use IPv6 addresses and is only available if support for TI-RPC is
>   built in. Both others use IPv4 addresses.
> 
> 

