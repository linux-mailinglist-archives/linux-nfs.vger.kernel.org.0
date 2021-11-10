Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9B644C8DE
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Nov 2021 20:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhKJTTl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 Nov 2021 14:19:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60254 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232244AbhKJTTl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 Nov 2021 14:19:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636571812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eEK3bFntyAhk4jlFQtjTRa2OHWS62cYlsJwB4p3PlnQ=;
        b=cHNN53NmIWXuAOyeMZ4ynNORP0QQ5swlbdDfl967OTTcezXI0ZO/AK8pU2D6SoV0M0El3+
        YHUM3CTsC32FwI0wVSwQxNabmbuD4tuOBMOrb+HG8JNsa+7AJOy6tdgI22VFeAXLTbtSoJ
        z+eymqZbluD2XjH3aNLz8AbBogRy/dA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-7PvoG6jkP7W9Mj51MBJBAQ-1; Wed, 10 Nov 2021 14:16:51 -0500
X-MC-Unique: 7PvoG6jkP7W9Mj51MBJBAQ-1
Received: by mail-qv1-f69.google.com with SMTP id dz17-20020ad45891000000b003bbb4aba6d7so3584649qvb.12
        for <linux-nfs@vger.kernel.org>; Wed, 10 Nov 2021 11:16:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eEK3bFntyAhk4jlFQtjTRa2OHWS62cYlsJwB4p3PlnQ=;
        b=3d/S+EP086voww17eIy2UD0qNbwoZ8E47xseD7lZMj1CQFpEP8LppFG4VAy8/51n15
         6SBH+lCCQdRmGpbFGqAulRnnQ9XsIg5o5BzbtxTkJ4GHZhj8DCgSagSOtJwn3b9KNEhn
         vvBFSUKKOiw09stgZKSnuDNgTK6JVgztME3NLo8php9uNJylXsZrAvVXfRjHMCOobRXX
         IkcATIavJCuICdUhoKSyX9M6YxhOJFM91Fq5n7KOyIsetIuZAwWClzoUPP8Tjsx0m204
         DUDwM72UgC6upx4b2aaA8nWkIJlBmOKcc5bz5AvlAC1f5yn5ZCgeddWpkJkCKy6Dzv1R
         spEQ==
X-Gm-Message-State: AOAM530FL+DUF1WDilufk61PSHYxvkThfL2g37HIq/2BakOuD6HuaDRa
        jmuRXx0paM5K1+MJe1gs/urx+oe0XQ8IphnJo0Fc5LuEDtxqYuobRfaSsygMAopMSX1plA2/NVa
        zfbjpsAx6OPUp98kz5hb/
X-Received: by 2002:a05:6214:c28:: with SMTP id a8mr1190016qvd.24.1636571811098;
        Wed, 10 Nov 2021 11:16:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwr3fX91ekcBG0j0sbKc2zpwa9RYuybonBnkqbGqNoBYfpRp4DZbDFJq2MT12s2NW2yX5u7Mw==
X-Received: by 2002:a05:6214:c28:: with SMTP id a8mr1189986qvd.24.1636571810882;
        Wed, 10 Nov 2021 11:16:50 -0800 (PST)
Received: from [172.31.1.6] ([70.105.254.54])
        by smtp.gmail.com with ESMTPSA id 66sm332971qkk.92.2021.11.10.11.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 11:16:50 -0800 (PST)
Message-ID: <143423e3-03b2-8b5d-f897-33126edd2594@redhat.com>
Date:   Wed, 10 Nov 2021 14:16:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH nfs-utils] mount: don't bind a socket needlessly.
Content-Language: en-US
To:     NeilBrown <neilb@suse.de>
Cc:     linux-nfs@vger.kernel.org
References: <163582252847.13683.7467712657489228784@noble.neil.brown.name>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <163582252847.13683.7467712657489228784@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

On 11/1/21 23:08, NeilBrown wrote:
> 
> When clnt_ping() calls get_socket(), get_socket() will create a socket,
> call bind() to choose an unused local port, and then connect to the
> given address.
> 
> The "bind()" call is unnecessary and problematic.
> It is unnecessary as the "connect()" call will bind the socket as
> required.
> It is problematic as it requires a completely unused port number, rather
> than just a port number which isn't currently in use for connecting to
> the given remote address.
> If all local ports (net.ipv4.ip_local_port_range) are in use, the bind()
> will fail.  However the connect() call will only fail if all those port
> are in use for connecting to the same address.
> 
> So remove the unnecessary bind() call.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
Committed... (tag: nfs-utils-2-5-5-rc4)

steved.

> ---
>   utils/mount/network.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/utils/mount/network.c b/utils/mount/network.c
> index e803dbbe5a2c..35261171a615 100644
> --- a/utils/mount/network.c
> +++ b/utils/mount/network.c
> @@ -429,10 +429,6 @@ static int get_socket(struct sockaddr_in *saddr, unsigned int p_prot,
>   	if (resvp) {
>   		if (bindresvport(so, &laddr) < 0)
>   			goto err_bindresvport;
> -	} else {
> -		cc = bind(so, SAFE_SOCKADDR(&laddr), namelen);
> -		if (cc < 0)
> -			goto err_bind;
>   	}
>   	if (type == SOCK_STREAM || (conn && type == SOCK_DGRAM)) {
>   		cc = connect_to(so, SAFE_SOCKADDR(saddr), namelen,
> 

