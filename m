Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25278416366
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Sep 2021 18:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhIWQg4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Sep 2021 12:36:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51214 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhIWQg4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Sep 2021 12:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632414924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LLsIfC9OswKSu9k2vikU+XEHuXdovlnAyhBlNDzt49Y=;
        b=UXqYwhqBAW0MITTmLi7I21zDzyxlseI3r1sB1d2usZOOEytiJ+k46MuggbNkHbRghcSKk8
        L4bV142Mt1nTW9XcQ4OmwweQhCW+kmdtWLVL8LgpFaQY5b58vpg6G5aqFO+SIFYL0sPsBL
        R6dE+7kecpse5EbTEWYCKUKqz8mN98c=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-uGyjiWPHNhG01jYsFEPohg-1; Thu, 23 Sep 2021 12:35:23 -0400
X-MC-Unique: uGyjiWPHNhG01jYsFEPohg-1
Received: by mail-qk1-f198.google.com with SMTP id m6-20020a05620a24c600b004338e8a5a3cso19813089qkn.10
        for <linux-nfs@vger.kernel.org>; Thu, 23 Sep 2021 09:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LLsIfC9OswKSu9k2vikU+XEHuXdovlnAyhBlNDzt49Y=;
        b=wc3M2cVfYQ9BuuT/J+OjSWeKzOlKQADUNYrEXuPLLF7c2+gmTxvxiGQEQhbZI7JiAP
         voAyJEhtVLO85aEI9ryJHD7JSI7pWnpQMuanuAnA9daS39CcYufxws8/5LkgKLc5aEkY
         DQUGo6wCXrjodmp0qA1BLQBpIfVpe0aDQ7KzMNIqJQG/8LRWhSCOt9krK91s5UOFYT1N
         bGeEQOqk5kzY7PqTxuJhf9qZnoUMIukjgfoE6nvdnQghMH9YfXMLA24bLNc+VYYInGlL
         oQS6MclTzhHz9M98dfz/9wNTBWEBXAFMkBBVJ7fnLectD0RSLhSrxB6pfarkUkMOB/t0
         VcSQ==
X-Gm-Message-State: AOAM533WBHPeDFAxcrU+MU0tdLOl+lKA2zPx1bB5yQrGzairBbNfjLtP
        Zf9t5oHui6k5uReEDHatZkFdcPLs05BXJO8zm7BvrByC3oE1bc9WG7eaPC+7BZxXKbwJ2HoV1OB
        51yRCNMcZmTrs0tjLNODA/XyAl3u4Y4gyTWh4tZp0+YqUF0UZM3nt9wQ81MhrwTrpJ93htA==
X-Received: by 2002:a05:622a:142:: with SMTP id v2mr5754261qtw.322.1632414922749;
        Thu, 23 Sep 2021 09:35:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCrbEb/WpusXE4SCBW6ql/l+fg4rbSH2wHJY2Bh6oykA9lLm4ZWsrSvNZEvlFtqahC8iJAYg==
X-Received: by 2002:a05:622a:142:: with SMTP id v2mr5754173qtw.322.1632414921570;
        Thu, 23 Sep 2021 09:35:21 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([70.105.255.190])
        by smtp.gmail.com with ESMTPSA id u13sm3700349qtg.29.2021.09.23.09.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 09:35:21 -0700 (PDT)
Subject: Re: [PATCH] [man]: adding new mount option max_connect
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
References: <20210827183719.41057-1-olga.kornievskaia@gmail.com>
 <20210827183719.41057-3-olga.kornievskaia@gmail.com>
From:   Steve Dickson <steved@redhat.com>
Message-ID: <66ea2cef-6680-88cb-d809-4fd2fb6c0227@redhat.com>
Date:   Thu, 23 Sep 2021 12:35:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210827183719.41057-3-olga.kornievskaia@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 8/27/21 2:37 PM, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
> 
> When client discovers trunkable servers, instead of dropping newly
> created trunkable connections, add this connection to the existing
> RPC client.
> 
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Committed.... (tag: nfs-utils-2-5-5-rc3)

steved.

> ---
>   utils/mount/nfs.man | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
> index f1b76936..57a693fd 100644
> --- a/utils/mount/nfs.man
> +++ b/utils/mount/nfs.man
> @@ -416,6 +416,19 @@ Note that the
>   option may also be used by some pNFS drivers to decide how many
>   connections to set up to the data servers.
>   .TP 1.5i
> +.BR max_connect= n
> +While
> +.BR nconnect
> +option sets a limit on the number of connections that can be established
> +to a given server IP,
> +.BR max_connect
> +option allows the user to specify maximum number of connections to different
> +server IPs that belong to the same NFSv4.1+ server (session trunkable
> +connections) up to a limit of 16. When client discovers that it established
> +a client ID to an already existing server, instead of dropping the newly
> +created network transport, the client will add this new connection to the
> +list of available transports for that RPC client.
> +.TP 1.5i
>   .BR rdirplus " / " nordirplus
>   Selects whether to use NFS v3 or v4 READDIRPLUS requests.
>   If this option is not specified, the NFS client uses READDIRPLUS requests
> 

