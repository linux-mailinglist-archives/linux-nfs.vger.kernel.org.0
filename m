Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3887B200F
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Sep 2023 16:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjI1OsC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Sep 2023 10:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjI1Orp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Sep 2023 10:47:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457A0F9
        for <linux-nfs@vger.kernel.org>; Thu, 28 Sep 2023 07:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695912419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0hbvk4o3avpxGDjLrXgDvTKc4dWZRYQ5diOhhw3jPCw=;
        b=E/0S6TdivExRM6r9Xyr93ABB4pHuaXUliab+QdCB6Qf7QYcmHL6bZDCFNqNekXaV1rRpgk
        MQOJgDn91XzQ3GIueUsHO6QiS849E1t7PXnaWCiN3WLA4641PecHpvWK+WV56AqYGBkT4y
        Z0iQlqTfQSV2NFALZFauHhabPwgkZkc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-EUj2Wy3mNqClrittC5iAKQ-1; Thu, 28 Sep 2023 10:46:58 -0400
X-MC-Unique: EUj2Wy3mNqClrittC5iAKQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-77585a78884so5409285a.1
        for <linux-nfs@vger.kernel.org>; Thu, 28 Sep 2023 07:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695912416; x=1696517216;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0hbvk4o3avpxGDjLrXgDvTKc4dWZRYQ5diOhhw3jPCw=;
        b=XOcHh3WzLU3QR42DpYYWyhhkERRbLTrH3QkaG2CwceCc0V8gz26eCU0pg7+9P8ryRk
         5MwgVtGP0tpCKLZZ2+AWAK9HQIVjvb9GAvIP+TGOMtN/7aff3MCzaKLlibzY+1oa37Qg
         8okX3RndV9ebH41AQcJVmk1GDW43H+wzS2BcnK7bCgkfK1VR7C52QpJt5vEoYNx3lOxN
         7L6bq371WghtI/xvVriQwEPJW+ZGwFw0q9amgskY+kCmOwDK2NFCLynXGnUXtwlk/d96
         Czt+hWPF98o43vcq4XySdQq8iSurhH+/EGHsib56Z0qJshrQYjUQoItNCpCtEx7Wpgkp
         ftOw==
X-Gm-Message-State: AOJu0YxDgR6H7DIA5Edsj6wRqLNnnp6I/oAqS1UuYB0yt4o7jOSygsD9
        I3aTl72SkteObCXPioGbuyWeYuaSOz37IadUDTd4jThhZp/gihhHuue8wFu4CHMroKsz1iKoQ2T
        yxIGBo5//4XttvZySdJMm
X-Received: by 2002:a05:620a:46a4:b0:773:ad1f:3d5b with SMTP id bq36-20020a05620a46a400b00773ad1f3d5bmr1597185qkb.0.1695912416633;
        Thu, 28 Sep 2023 07:46:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWCkxL/9YDoI5EBVu3APxN7+sneVdELgfyECV4jgMY3wdVoHPpyJ01cJfkKyjAx0p8d1XEAA==
X-Received: by 2002:a05:620a:46a4:b0:773:ad1f:3d5b with SMTP id bq36-20020a05620a46a400b00773ad1f3d5bmr1597161qkb.0.1695912416340;
        Thu, 28 Sep 2023 07:46:56 -0700 (PDT)
Received: from [10.19.60.48] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d6-20020a05620a140600b0076db5b792basm3307133qkj.75.2023.09.28.07.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 07:46:55 -0700 (PDT)
Message-ID: <05fd0443-0792-e42d-6a6d-1d7b8cb6fe03@redhat.com>
Date:   Thu, 28 Sep 2023 10:46:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Oct 2023 Bakeathon in Westford, Ma
From:   Steve Dickson <steved@redhat.com>
To:     NFSv4 <nfsv4@ietf.org>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <85232631-be2a-8536-95ba-0d40cb66b53b@redhat.com>
Content-Language: en-US
In-Reply-To: <85232631-be2a-8536-95ba-0d40cb66b53b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

Bakeathon is a little over a week out... I would
like to get an idea of who will be traveling
and who will be remote... The sign up sheet
is here [1]... and the event sight is here [2]

Please let us know as soon as you can!

steved.

[1] 
https://docs.google.com/spreadsheets/d/1_Fj9uO5KDaGFWo_XR4O7Lp97godzJLVumOUoB8UAAEs/edit#gid=0

[2] http://www.nfsv4bat.org/Events/2023/Oct/BAT/index.html

On 8/18/23 4:50 PM, Steve Dickson wrote:
> Red Hat is pleased to announce that it is hosting the an NFSv4
> Bakeathon Oct 09-13 at our Westford, MA office as well as
> remote access...
> 
> Details and registration info are here:
> 
> http://www.nfsv4bat.org/Events/2023/Oct/BAT/index.html
> 
> I have rooms blocked of at two different hotels
> Hampton Inn and Residence Inn Details are on again
> on the the BAT website,
> 
> When registering please replying to
> bakeathon-contact@googlegroups.com supplying
>     * Company Name
>     * How engineers are coming
> 
> I hope to see you in October!!!
> 
> steved.

