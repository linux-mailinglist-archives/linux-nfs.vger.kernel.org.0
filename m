Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B0C768544
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jul 2023 14:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjG3M1t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 30 Jul 2023 08:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjG3M1t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 30 Jul 2023 08:27:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE6F1725
        for <linux-nfs@vger.kernel.org>; Sun, 30 Jul 2023 05:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690720019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qXxQsQEagc5rGOAZHUrZUKYRAS23kZoJ3Sp9AQLcKBo=;
        b=beKcIqRmiAZTcNVACqF//+2o8zh1QPMJz3iP2EdgpXp/ciWepSlz1VNCxbBTBzuet3YIa6
        CsCFedramINn5Ug7i1m/QUl/sAAhJ/rDVLPzhQ8jH4KzHBC+FeADO0JQB+1UkEFj1/DZx2
        0SI2dssqlSrnEGs8mXVCN4w0+KOglIQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-rOG36H_MMBGYS09EU4G0DA-1; Sun, 30 Jul 2023 08:26:57 -0400
X-MC-Unique: rOG36H_MMBGYS09EU4G0DA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-767a1ad2175so93369285a.0
        for <linux-nfs@vger.kernel.org>; Sun, 30 Jul 2023 05:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690720017; x=1691324817;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qXxQsQEagc5rGOAZHUrZUKYRAS23kZoJ3Sp9AQLcKBo=;
        b=h30GZmS5yaXZSGrZ6xz/maqOLbyGtTPaqZCKpf7krFuUlesZn10obhgcD5vqNnlWUU
         Cm5FXNJzb/DgXRwpGfkihH1MXBvzI7EKSnjo6SInELDwI8IRHRFEvP9r3wH/ViMfsNze
         atb1i9o/k9vBMzuyoyWbThna05fx3b9eMhokwVtY6T3o9zZsg30KKGZEj014l6P3iTZg
         deCoEpeYsvyTa+Q2Q2m4ZcP6/VhxmT8i0c++ZqEHCu4f+sbcapAzm9Q9B7R55v2QTWbl
         RL1zyqEozEYoOQs1s0mj4Lins2wPrBOrr8Oaomot4SwkZV6b7RCZIgJnnZyye/VmEEBM
         0/gQ==
X-Gm-Message-State: ABy/qLaX4Pf+Qnh+HadMO2bJ4r+74axHchcSWgGvvGwfNQN81+vFz00C
        SuEPvs39VYwg71Gb4KSuIp6zRj6LxRZd2OvQfCdSDB+F0qQXT75rvUcqx6CnXN3wyVbjD0VV51/
        nGUieDmUYGrppuiUZewzi
X-Received: by 2002:a05:622a:1816:b0:403:ebbe:c79d with SMTP id t22-20020a05622a181600b00403ebbec79dmr6641418qtc.2.1690720016934;
        Sun, 30 Jul 2023 05:26:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEe7MBz0NpGHTFTJYJXNA4kwjo0Af3GS7ImT9cqbTooHQONnjOAxrEhJGiOYM4AVRzXpNMgqQ==
X-Received: by 2002:a05:622a:1816:b0:403:ebbe:c79d with SMTP id t22-20020a05622a181600b00403ebbec79dmr6641399qtc.2.1690720016632;
        Sun, 30 Jul 2023 05:26:56 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.251.231])
        by smtp.gmail.com with ESMTPSA id g13-20020ac8070d000000b00400aa16bf38sm2627322qth.82.2023.07.30.05.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 05:26:42 -0700 (PDT)
Message-ID: <6dd3118d-c21c-0588-1f35-460f2d8aa4c6@redhat.com>
Date:   Sun, 30 Jul 2023 08:26:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
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
I think I got it right... I also added a couple .IP
to make the section a bit more readable...

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

