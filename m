Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4C65BED04
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Sep 2022 20:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiITStK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Sep 2022 14:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiITStI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Sep 2022 14:49:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46F4719B8
        for <linux-nfs@vger.kernel.org>; Tue, 20 Sep 2022 11:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663699746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9fLjV0tvpYYLhcyJLChfkM4al0lltAwBtMCZ3SX9RXI=;
        b=R1RN0xtGrGcyhoGIabUXIJWmVBXPFfh0uNnK/AZ920Cot/9x7ssqrB2OoxMpvwiUfsHopw
        2G0LqGjFpyK4NRNfBM09hA4MOqRIxvgRgjBzWg904rn/mynWIFsgkTUMuOQuInxV2m/TaQ
        eonQUOUXxNCteQSXzRJX8J9dBeV6Rt4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-375-GgbiBwWwMeay8mioBv8wWQ-1; Tue, 20 Sep 2022 14:49:04 -0400
X-MC-Unique: GgbiBwWwMeay8mioBv8wWQ-1
Received: by mail-qk1-f199.google.com with SMTP id h8-20020a05620a284800b006b5c98f09fbso2644186qkp.21
        for <linux-nfs@vger.kernel.org>; Tue, 20 Sep 2022 11:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9fLjV0tvpYYLhcyJLChfkM4al0lltAwBtMCZ3SX9RXI=;
        b=EGYOs78XPg/f38KnH3b7RgQRd7k8ygByzY06bJHTINaY14nVYx7hcY62lloIeuF/Ol
         gdtClY+c9OnILkRYnxhhhvao+5AdavZH/wqRIwwb+LqmxYZMD+Efg6R4Ka5Qw84qki9G
         Z11Cfnvkh9YSjPdmP0hGBrVbWSm9U4orexDw1FucT6kIbrD9YcMQUflAy4APNgCGIwQw
         yyFARAlCTvC86jV3f9iu5wq3DIlNIxOEHVv7P6c5hUYpOx0rvQ26N4K7tnCGqqCGPoSN
         RI+l0CZ2HKwsb6iGf1sMtyiYMMieqOvSHUqb/oEN6OV71OTBgZMUPkp0Ej5r4V07Sc/A
         Q5rg==
X-Gm-Message-State: ACrzQf3Wg/rbVvm76GoJrpa7ziTDemAeVyliF/MlCQ2Ptq7KkFvVvLxm
        EJfLhMlqMqAZ99kcRwUcXq8Vk3ozkehzXCrhQNHn63kw+9XDDtei3O53wmdofZO0opp37u63iBu
        f7b4cM0VolLFE6yykKbcW
X-Received: by 2002:a05:6214:c89:b0:4ac:c6ba:3f22 with SMTP id r9-20020a0562140c8900b004acc6ba3f22mr20324717qvr.9.1663699743444;
        Tue, 20 Sep 2022 11:49:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6P0UDvd8A5Em+iuq4xg23YNgI25VDfYugpw9VPPoJkBuVYpjK+HZAn9SslsMr4UTulzeKg1Q==
X-Received: by 2002:a05:6214:c89:b0:4ac:c6ba:3f22 with SMTP id r9-20020a0562140c8900b004acc6ba3f22mr20324706qvr.9.1663699743174;
        Tue, 20 Sep 2022 11:49:03 -0700 (PDT)
Received: from [172.31.1.6] ([71.161.93.20])
        by smtp.gmail.com with ESMTPSA id g20-20020a05620a40d400b006b95b0a714esm402123qko.17.2022.09.20.11.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 11:49:02 -0700 (PDT)
Message-ID: <c9521a3b-a83d-765d-6e0b-1bb7c12dc540@redhat.com>
Date:   Tue, 20 Sep 2022 14:49:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 2/2] nfs4_setfacl: update man page about new option
 index
Content-Language: en-US
To:     Pierguido Lambri <plambri@redhat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20220914173115.296058-1-plambri@redhat.com>
 <20220914173115.296058-2-plambri@redhat.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220914173115.296058-2-plambri@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 9/14/22 1:31 PM, Pierguido Lambri wrote:
> The man page now reflects the newly added syntax to handle indexes.
> 
> Signed-off-by: Pierguido Lambri <plambri@redhat.com>
Committed (tag: nfs4-acl-tools-0.4.1-rc3)

steved.
> ---
>   man/man1/nfs4_setfacl.1 | 26 ++++++++++++++------------
>   1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/man/man1/nfs4_setfacl.1 b/man/man1/nfs4_setfacl.1
> index 47ab517..61699ae 100644
> --- a/man/man1/nfs4_setfacl.1
> +++ b/man/man1/nfs4_setfacl.1
> @@ -30,27 +30,21 @@ Refer to the
>   manpage for information about NFSv4 ACL terminology and syntax.
>   .SS COMMANDS
>   .TP
> -.BR "-a " "\fIacl_spec\fP [\fIindex\fP]"
> +.BR "-a " "\fIacl_spec\fP"
>   .RI "add the ACEs from " acl_spec " to " file "'s ACL."
> -ACEs are inserted starting at the
> -.IR index th
> -position (DEFAULT: 1) of
> +ACEs are inserted starting at the default position 1 of
>   .IR file "'s ACL."
>   .\".ns
>   .TP
> -.BR "-A " "\fIacl_file\fP [\fIindex\fP]"
> +.BR "-A " "\fIacl_file\fP "
>   .RI "add the ACEs from the acl_spec in " acl_file " to " file "'s ACL."
> -ACEs are inserted starting at the
> -.IR index th
> -position (DEFAULT: 1) of
> +ACEs are inserted starting at the default position 1 of
>   .IR file "'s ACL."
>   .TP
> -.BI "-x " "acl_spec \fR|\fP index"
> +.BI "-x " "acl_spec \fR"
>   delete ACEs matched from
>   .I acl_spec
> -- or delete the
> -.IR index th
> -ACE - from
> +from
>   .IR file 's
>   ACL.  Note that the ordering of the ACEs in
>   .I acl_spec
> @@ -61,6 +55,10 @@ delete ACEs matched from the acl_spec in
>   .IR acl_file " from " file "'s ACL."
>   Note that the ordering of the ACEs in the acl_spec does not matter.
>   .TP
> +.BI "-i " "\fIindex\fP"
> +.RI "ACEs are inserted or deleted starting at the " index "th position (DEFAULT: 1) of file's ACL.
> +It can be used only with the add or delete action.
> +.TP
>   .BI "-s " acl_spec
>   .RI "set " file "'s ACL to " acl_spec .
>   .TP
> @@ -189,6 +187,10 @@ add the same ACE as above, but using aliases:
>   .br
>   	$ nfs4_setfacl -a A::alice@nfsdomain.org:RX foo
>   .IP - 2
> +add the same ACE as above, at index 2:
> +.br
> +	$ nfs4_setfacl -i 2 -a A::alice@nfsdomain.org:RX foo
> +.IP - 2
>   edit existing ACL in a text editor and set modified ACL on clean save/exit:
>   .br
>   	$ nfs4_setfacl -e foo

