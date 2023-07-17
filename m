Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9677756F21
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jul 2023 23:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjGQVur (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jul 2023 17:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGQVuq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jul 2023 17:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926EB18D
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 14:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689630599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ccmrDravX+l8BnwK6ZugjyBUfbAn5Q5vDrg1z9gSlUo=;
        b=HOVt5Z5BI+nqwtRi53ogEPR8QHqqWc2cRWbOQaLhE7uw+zw8MJilcNeBjgtc1z5YzXzL16
        81bidKOXoPQd6/vPnxdPU8vKvQZ9hZGjSOyjbczBLt0E2HYvjwxSnsG5o75TcFGUkreDZ7
        T1MRL5V6ID8igz2PdxgUft6q02Bqm4s=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557--HwMt-PpPRax11NOywiPmg-1; Mon, 17 Jul 2023 17:49:58 -0400
X-MC-Unique: -HwMt-PpPRax11NOywiPmg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-765ad67e690so120404685a.1
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 14:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689630598; x=1690235398;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ccmrDravX+l8BnwK6ZugjyBUfbAn5Q5vDrg1z9gSlUo=;
        b=fimqStRLV15GSyfI9buGt4mfE+VWUVS2mTuPSU/Fnmp9dsp9CAFA1qinLqJmIY5X35
         mTxq3nwb0XH/DKGq1RH06G3k3aKkQJ882u/m0dQT1TsAH+oRb8RHoIIcOOonY/paVWiv
         iH9DAv5KbqjJRi7gClgkU+PZlzbrzJoigwIgBWgNroYwC9KZL+A1QXoRikrls7YRAZMf
         rInjzq1/MG/cKdUFhvJh13bJ3OIYmdTuv8o+NfzV40WxHNOjliwmMzq2nq8QAn+Pkhml
         F/Kl0v87NRmBZv+7F3qMhb3kQhs0mY74jz9Ir3Yv8i5xxjh9XJf3NhYcWSGu3tzWwQqA
         JQVA==
X-Gm-Message-State: ABy/qLZAX80ILqJECWf0kUk76B2f9+mLnm+ASEGxiq30HV1dVr7eQr0Q
        zrrVZlvKU1l+85Q21VolXBBxq+SfL4cU4pSEVBngKte5zk3wTjvBI2t1vV0nPwCNtoqM1frFfTj
        t6LOTXCguBnDgtOZT1Al7
X-Received: by 2002:ad4:5de2:0:b0:636:e4f:6b88 with SMTP id jn2-20020ad45de2000000b006360e4f6b88mr14551172qvb.1.1689630598155;
        Mon, 17 Jul 2023 14:49:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFcxdZMpFQNuKsb/uCBhcCKRYz1VF08xdYyYv43Aj4LGTL2/w8t9NpTP9YR5UZQHmOSEjxBQg==
X-Received: by 2002:ad4:5de2:0:b0:636:e4f:6b88 with SMTP id jn2-20020ad45de2000000b006360e4f6b88mr14551163qvb.1.1689630597887;
        Mon, 17 Jul 2023 14:49:57 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.251.231])
        by smtp.gmail.com with ESMTPSA id u12-20020a0cf1cc000000b006360778f314sm177712qvl.105.2023.07.17.14.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 14:49:57 -0700 (PDT)
Message-ID: <31b09cc8-e34c-00b1-dfff-38c806f2c35e@redhat.com>
Date:   Mon, 17 Jul 2023 17:49:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1] nfs(5): Document the new "xprtsec=" mount option
Content-Language: en-US
To:     Chuck Lever <cel@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        kernel-tls-handshake@lists.linux.dev
References: <168935977873.1850.8214830433103692090.stgit@bazille.1015granger.net>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <168935977873.1850.8214830433103692090.stgit@bazille.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 7/14/23 2:36 PM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> More information about RPC-with-TLS and some brief set-up guidance
> are to be provided in a separate man page in Section 7.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Committed... (tag: nfs-utils-2-6-4-rc3)

steved.
> ---
>   utils/mount/nfs.man |   38 +++++++++++++++++++++++++++++++++++++-
>   1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
> index d9f34df36b42..dfc31a5dad26 100644
> --- a/utils/mount/nfs.man
> +++ b/utils/mount/nfs.man
> @@ -574,7 +574,43 @@ The
>   .B sloppy
>   option is an alternative to specifying
>   .BR mount.nfs " -s " option.
> -
> +.TP 1.5i
> +.BI xprtsec= policy
> +Specifies the use of transport layer security to protect NFS network
> +traffic on behalf of this mount point.
> +.I policy
> +can be one of
> +.BR none ,
> +.BR tls ,
> +or
> +.BR mtls .
> +.IP
> +If
> +.B none
> +is specified,
> +transport layer security is forced off, even if the NFS server supports
> +transport layer security.
> +If
> +.B tls
> +is specified, the client uses RPC-with-TLS to provide in-transit
> +confidentiality.
> +If
> +.B mtls
> +is specified, the client uses RPC-with-TLS to authenticate itself and
> +to provide in-transit confidentiality.
> +If either
> +.B tls
> +or
> +.B mtls
> +is specified and the server does not support RPC-with-TLS or peer
> +authentication fails, the mount attempt fails.
> +.IP
> +If the
> +.B xprtsec=
> +option is not specified,
> +the default behavior depends on the kernel version,
> +but is usually equivalent to
> +.BR "xprtsec=none" .
>   .SS "Options for NFS versions 2 and 3 only"
>   Use these options, along with the options in the above subsection,
>   for NFS versions 2 and 3 only.
> 
> 

