Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1524C665FD2
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 16:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjAKP6L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 10:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjAKP5h (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 10:57:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BFDD2D7
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 07:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673452616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KSW8iHMLKKGVo1gy8o3fcpHr9XuMpdh8vLM/sJn8+MQ=;
        b=gC6N0vkUihOq2/ab1OqG7WynCNimZtEV4jDrvHz/3IwvN34uqTbvjzo51IU/nKr+0URDFe
        sjzhfwtVUSq/2uwgbYtZG7ft7/8rxmmNaFgpobHoGe/ernz0N3jfOYDHL5cA/s5UPdQt9L
        cU7YXgrT1Z9BrqLAUkHoqDAaie4BcwU=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-14-z_PWoKCYNlib-sudphndOw-1; Wed, 11 Jan 2023 10:56:55 -0500
X-MC-Unique: z_PWoKCYNlib-sudphndOw-1
Received: by mail-vs1-f70.google.com with SMTP id s62-20020a675e41000000b003cefb1730d9so3102521vsb.0
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 07:56:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KSW8iHMLKKGVo1gy8o3fcpHr9XuMpdh8vLM/sJn8+MQ=;
        b=Mq6jmZ+c9SNJr8aqdnICaX686bwglle99/uQ5bVloImItnB0VOrUlkiYYtQjOrGMtR
         cIeNGXtKD+WPY8HcvfKuSf1dDhD/GZKGXhLByHNembP5A9i/PHBO8NynhWizDTo902mF
         Oij200C7fRuPKi0iBUt+JMXISO3kgLrcxKDW6vP7sA3ozzFkSvQgN+kPyINBQF+Alxfx
         m6QVMLNABOISBojqx7LbRe9P763E7ATIzlUx67VnYGYxE5BkFMEEOK8bTzlj+4ElADyi
         YPsfwROc4sF2OAPfGImzMi5kZPfy4Dyrq1U2cq4SPqQ0j8cgMnKK3ORaUmxe7c+sFDbz
         k1xw==
X-Gm-Message-State: AFqh2kqmFnbCSjQFPtTKAYQpRbUQYYV36DOwk/T+B7wqZ9+Pgby/Tkea
        uoetEW6IMI7zZvZn88rdPf6VkxL05aYKOHBptI5KC+6rAMsundf3xZlUwdOfhbHs8eORvPqReOn
        dS9hfNFbwBLzxdysQFsmiexIHK5h66B9emfLJubQisKiSYqnw5Ol5+p1FrOrLCx4ULQUQnw==
X-Received: by 2002:a1f:1d50:0:b0:3d6:e0d4:2aa9 with SMTP id d77-20020a1f1d50000000b003d6e0d42aa9mr14553124vkd.1.1673452614724;
        Wed, 11 Jan 2023 07:56:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsvpNbZuesoBF1X4sKgnES/OflbxfXq1pgzQbBr8MVTYtAHsrffJjiN1EayIACRL32OguuMrg==
X-Received: by 2002:a1f:1d50:0:b0:3d6:e0d4:2aa9 with SMTP id d77-20020a1f1d50000000b003d6e0d42aa9mr14553097vkd.1.1673452614345;
        Wed, 11 Jan 2023 07:56:54 -0800 (PST)
Received: from [172.31.1.6] ([70.109.130.165])
        by smtp.gmail.com with ESMTPSA id u2-20020a05620a0c4200b006f9f3c0c63csm9295878qki.32.2023.01.11.07.56.53
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 07:56:53 -0800 (PST)
Message-ID: <2f6880c4-26e2-c3cf-bd71-93e7b70a7b7a@redhat.com>
Date:   Wed, 11 Jan 2023 10:56:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] Covscan Scan: Wrong Check of Return Value
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20230104170855.19822-1-steved@redhat.com>
In-Reply-To: <20230104170855.19822-1-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/4/23 12:08 PM, Steve Dickson wrote:
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2151966
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... (tag: nfs-utils-2-6-3-rc6)

steved.
> ---
>   support/export/client.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/support/export/client.c b/support/export/client.c
> index ea4f89d..79164fe 100644
> --- a/support/export/client.c
> +++ b/support/export/client.c
> @@ -699,6 +699,9 @@ check_netgroup(const nfs_client *clp, const struct addrinfo *ai)
>   
>   	/* check whether the IP itself is in the netgroup */
>   	ip = calloc(INET6_ADDRSTRLEN, 1);
> +	if (ip == NULL)
> +		goto out;
> +
>   	if (inet_ntop(ai->ai_family, &(((struct sockaddr_in *)ai->ai_addr)->sin_addr), ip, INET6_ADDRSTRLEN) == ip) {
>   		if (innetgr(netgroup, ip, NULL, NULL)) {
>   			free(hname);

