Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668524A5DA8
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Feb 2022 14:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238850AbiBANs4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Feb 2022 08:48:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43348 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230213AbiBANsz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Feb 2022 08:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643723335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qHxA8Ztlr+njVWx4fYlSuxpSovLTqQAv3qnz4YBfOAs=;
        b=LuHSBI/DdIPXtwoxCJgmVNVgTivNmW7hsLBrthbC1rzBNtiLTN4CwB1fkWAe5q6/i0oGF+
        /oD/qWBZGCq22x3kedOYjloWVsuv8LXFli8ehd8ksuX13SIJXz+4sRH/+nZCJTIk06FiMg
        jMPpjlsaQeZfcz/bgBXXZ7+KaFSLT9Q=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-71CboiuJOCeUnJVobRSPKw-1; Tue, 01 Feb 2022 08:48:53 -0500
X-MC-Unique: 71CboiuJOCeUnJVobRSPKw-1
Received: by mail-qk1-f197.google.com with SMTP id i26-20020a05620a075a00b0047ec29823c0so12111052qki.6
        for <linux-nfs@vger.kernel.org>; Tue, 01 Feb 2022 05:48:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qHxA8Ztlr+njVWx4fYlSuxpSovLTqQAv3qnz4YBfOAs=;
        b=8MBPrfO8Cdad9MPJ1ni+cXDKAR4s3pIr6HJoQ3rz1DayKPhSwl7eZT3+e3gCkuOL/w
         priIux4/cUgKQ/iz/SeULDX3kz2LhqvgR08CAnPmbpdN9opOVokgA34wjWELE+ql1ybH
         HCKoFLVvcWVKdBsfX0Mt+1xjK0Pugk9KMqcn8yAC5OlHMWUgvzEV7MmgJOMLc+mcs0lF
         /HXafIhJI6l1+KoV/WQTJex5jNN78YniI7ADLz1ofN/BfbWRMlxzrnb4LnDBc7qTsWtT
         PzXgaA5rNMbOYm3M4DwcBP6Vu7UA//hfwZlUkdHZRBwI2MKJWBFozmjH8JmCmcss4Mr4
         vxhw==
X-Gm-Message-State: AOAM53192/hM58XDpJnS5+Q6wKsnSoFw9Plmi1LAZ0shGt2uuCn2WlOb
        aQ4jt/hIeFvsxnazMXkyHF98ZDeLBVAtBmGCHH01hmwGOa9YdalzgeumY9zrMuYXFd0J3AKBO/1
        fpNoha/A7dfXDXkPGD2vW
X-Received: by 2002:a05:6214:2424:: with SMTP id gy4mr23031100qvb.125.1643723333346;
        Tue, 01 Feb 2022 05:48:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzx8YFpjqiNILhmpGGea1Batx0cBYB+hSyntYqVOjKSF6PbPA6lmqZkRdMl3R2fFcJ3tnpd2A==
X-Received: by 2002:a05:6214:2424:: with SMTP id gy4mr23031079qvb.125.1643723333113;
        Tue, 01 Feb 2022 05:48:53 -0800 (PST)
Received: from [10.19.60.33] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q22sm1339037qtw.52.2022.02.01.05.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 05:48:52 -0800 (PST)
Message-ID: <9585fff5-5e8e-da40-1ace-32eac137c88e@redhat.com>
Date:   Tue, 1 Feb 2022 08:48:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] rpcbind: fix double free in init_transport
Content-Language: en-US
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     libtirpc-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org
References: <20220129004417.GA10610@altlinux.org>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220129004417.GA10610@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/28/22 19:44, Dmitry V. Levin wrote:
> $ rpcbind -h 127.0.0.1
> free(): double free detected in tcache 2
> Aborted
> 
> Fixes: a6889bba949b ("Removed resource leaks from src/rpcbind.c")
> Resolves: https://sourceforge.net/p/rpcbind/bugs/6/
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
Committed... (tag: rpcbind-1_2_7-rc1)

steved.
> ---
>   src/rpcbind.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/src/rpcbind.c b/src/rpcbind.c
> index 25d8a90..ecebe97 100644
> --- a/src/rpcbind.c
> +++ b/src/rpcbind.c
> @@ -552,8 +552,10 @@ init_transport(struct netconfig *nconf)
>   				syslog(LOG_ERR, "cannot bind %s on %s: %m",
>   					(hosts[nhostsbak] == NULL) ? "*" :
>   					hosts[nhostsbak], nconf->nc_netid);
> -				if (res != NULL)
> +				if (res != NULL) {
>   					freeaddrinfo(res);
> +					res = NULL;
> +				}
>   				continue;
>   			} else
>   				checkbind++;

