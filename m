Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D222E535291
	for <lists+linux-nfs@lfdr.de>; Thu, 26 May 2022 19:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348292AbiEZRef (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 May 2022 13:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348302AbiEZRee (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 May 2022 13:34:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A0A36D4EB
        for <linux-nfs@vger.kernel.org>; Thu, 26 May 2022 10:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653586472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SAG2juaS3AeK+A2h5zSbwi4DFQSgp7tk4MLOiwPU8Qs=;
        b=ZKrxT8Y79mzq3MnL4AUIaMcE0BdcYOaHCMm+cJ29F9SrZ3o9luLlCyaCnMeVdFnTSz5Kx4
        YSE29oZWYjMk/p+uEKFosJGEqfI1x/Wyb1DN8VDXoVn3GiqOUtXn2PX7LW+kbKxwHSStXC
        gUmwZwXlxIouMKdQ19b5P5r4sWRkSuI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-D_QKEmWkOuizZaT5GVbV7g-1; Thu, 26 May 2022 13:34:26 -0400
X-MC-Unique: D_QKEmWkOuizZaT5GVbV7g-1
Received: by mail-qk1-f197.google.com with SMTP id z8-20020ae9c108000000b006a376d119c6so1996597qki.21
        for <linux-nfs@vger.kernel.org>; Thu, 26 May 2022 10:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SAG2juaS3AeK+A2h5zSbwi4DFQSgp7tk4MLOiwPU8Qs=;
        b=CtaXmYNJ809rHnYOdqh53ZIqAtg1Tj4AptaUwF8dvzpPCm5qiSqpFFNjRtCKp00ga6
         8qkphkGq5WSnFj0fKihs/YopnnGWvQAUj8vxQBSQJPIxBhj+ZkT04lLwbg+gC2/lnC+S
         6JpgIS8tc1wpQaRKyUHNp4cGZEy8/6aZcCijArjJrnzqgO4MoRcIaZitF4UX1N6dnOFt
         c2GmHJ6jU9iaUi3T1jiGmJvjN8rqoQiPJgVoYpmiOjQTyl1CwZ8f1i7cy6MK6MSJ1Bye
         5Stt1uhjbvDstUtUR0/3L4ZXWyeH3gL0e75SXGO9ynRdyD0IyU71Oee9QSNotf2aO8tj
         s0iQ==
X-Gm-Message-State: AOAM533E+L0RdaReEvSRX4AmsbgUKZBlBqJO+m3J06EjSr/3v9dELyLz
        Pt2NUlr3k+xvyOydM5EKsqVX0Nt1m/ZxjkjqUHZpGOV95NGPbOkzYOKoqZDRhLZknXUj1qE6ndo
        54Bd6uWDz+mmsQBIWMuTF
X-Received: by 2002:ac8:7d8e:0:b0:2f9:1176:c24b with SMTP id c14-20020ac87d8e000000b002f91176c24bmr28204824qtd.500.1653586465517;
        Thu, 26 May 2022 10:34:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFU6/iG32uYF2XHscUusgJ/W3YmO8wjrApJ5DsgeL05u0WZ5T4puXHokuNyohEKz4uVMW0ig==
X-Received: by 2002:ac8:7d8e:0:b0:2f9:1176:c24b with SMTP id c14-20020ac87d8e000000b002f91176c24bmr28204797qtd.500.1653586465164;
        Thu, 26 May 2022 10:34:25 -0700 (PDT)
Received: from [10.19.60.33] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o124-20020a37be82000000b006a32c991501sm1490090qkf.12.2022.05.26.10.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 10:34:24 -0700 (PDT)
Message-ID: <0b80e4f7-58ca-177d-be85-b825243aed0e@redhat.com>
Date:   Thu, 26 May 2022 13:34:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/2] rpcctl: Print a message if the user tries to
 modify a main xprt
Content-Language: en-US
To:     Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
References: <20220519154727.3577715-1-anna@kernel.org>
 <20220519154727.3577715-2-anna@kernel.org>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220519154727.3577715-2-anna@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/19/22 11:47 AM, Anna Schumaker wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> 'main' xprts cannot be set offline or removed, so print a helpful error
> message in this case instead of a cryptic 'invalid argument' message.
> 
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Committed... (tag: nfs-utils-2-6-2-rc5)

steved
> ---
>   tools/rpcctl/rpcctl.py | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
> index 2a69eacd3103..d2110ad6de93 100755
> --- a/tools/rpcctl/rpcctl.py
> +++ b/tools/rpcctl/rpcctl.py
> @@ -90,10 +90,18 @@ class Xprt:
>           self.dstaddr = write_addr_file(self.path / "dstaddr", newaddr)
>   
>       def set_state(self, state):
> +        if self.info.get("main_xprt"):
> +            raise Exception(f"Main xprts cannot be set {state}")
>           with open(self.path / "xprt_state", 'w') as f:
>               f.write(state)
>           self.read_state()
>   
> +    def remove(self):
> +        if self.info.get("main_xprt"):
> +            raise Exception("Main xprts cannot be removed")
> +        self.set_state("offline")
> +        self.set_state("remove")
> +
>       def add_command(subparser):
>           parser = subparser.add_parser("xprt", help="Commands for individual xprts")
>           parser.set_defaults(func=Xprt.show, xprt=None)
> @@ -139,8 +147,7 @@ class Xprt:
>               if args.property == "dstaddr":
>                   xprt.set_dstaddr(socket.gethostbyname(args.newaddr[0]))
>               elif args.property == "remove":
> -                xprt.set_state("offline")
> -                xprt.set_state("remove")
> +                xprt.remove()
>               else:
>                   xprt.set_state(args.property)
>           print(xprt)

