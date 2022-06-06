Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D6253EDE9
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jun 2022 20:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiFFS3X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jun 2022 14:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiFFS3V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jun 2022 14:29:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D6AF6BFF5
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 11:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654540158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rUOm5nW2jIzp7hBhCtR8BVpn4Nh4LsKZJd2QYQQqCpI=;
        b=LCVTI7vY4BawdQ5E9hGXa1uvaK0vf364IX70i/eMJzGvKUYdNQO9iDFAW1BMvXeUuabDY5
        AYwW8lz1wfLM+uugmA1y3aGrI/X8+Y6qK5gzI69mCrithTwBc2E6hnovXeafmPUV6Ld7Jb
        56vjdg0KLVO0M8uuaLSuqEVKNgsjyMc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-402-W1RSsp_dMNelWpHGRUIX7w-1; Mon, 06 Jun 2022 14:29:16 -0400
X-MC-Unique: W1RSsp_dMNelWpHGRUIX7w-1
Received: by mail-qk1-f197.google.com with SMTP id q7-20020a05620a0d8700b006a6b5428cb1so3731931qkl.2
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jun 2022 11:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rUOm5nW2jIzp7hBhCtR8BVpn4Nh4LsKZJd2QYQQqCpI=;
        b=x0x5chE1cRJumzXDGEZu7fGWpdjRLD2dymNbWdNWIunyiRo2Hiac2PMrYoYt/Ceikw
         aVSySr+ulmdx5b1MckgG5iJgkSGo/G0uCiMaawn55KRoc3Q3aKuaz/KjNNIGC2uYm0CI
         xWXexDI52yekzo7SAKbDdhbsUCvGHDP0dQ9Hyw8zcd0KxdISOUC8y/DzIsyd1GOtBHW9
         cslADR89wPJLgdRcwArI+OC2iTHMZtAsK2IjANrMXvG93Fh6hSAR1wdTQD8/N4MHNAtX
         mxUNgptiGA8FTaEVsF6Y3/5jRXLx8oKQvtXii6ZRjdnxCH97mD2FHKmLdS7cOZZsOcdo
         sglg==
X-Gm-Message-State: AOAM531v9Vm5cfUl77SBEcAtsIrdBgus7sPviiDcOVKdcVD1HmAq6lBa
        /+lx6CyCckwJO81Q6MStdLUk46sM3KfQKEYF9bDwRkjqPJx3Sq06Xnfuv+bP01wRURoA08gzWBz
        Wky7Ssm+KlDpg2ugdpvnp
X-Received: by 2002:a37:9d86:0:b0:6a6:9631:db0d with SMTP id g128-20020a379d86000000b006a69631db0dmr12970986qke.473.1654540155860;
        Mon, 06 Jun 2022 11:29:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1AIlVMzC4VDnel78BQiLIJDJTurK7gON56NF4QOu/7lUlYBRn3VyXYQZUG2CR3qzVuY2SHg==
X-Received: by 2002:a37:9d86:0:b0:6a6:9631:db0d with SMTP id g128-20020a379d86000000b006a69631db0dmr12970966qke.473.1654540155572;
        Mon, 06 Jun 2022 11:29:15 -0700 (PDT)
Received: from [172.31.1.6] ([71.161.96.106])
        by smtp.gmail.com with ESMTPSA id 21-20020ac84e95000000b002f90a33c78csm11645310qtp.67.2022.06.06.11.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 11:29:15 -0700 (PDT)
Message-ID: <35aabd94-068a-3ef3-c52c-3b30a2bf5c71@redhat.com>
Date:   Mon, 6 Jun 2022 14:29:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: nfs-utils: rpc.svcgssd bug reading /etc/nfs.conf
Content-Language: en-US
To:     marcel@linux-ng.de, linux-nfs@vger.kernel.org
References: <bf4aa2c82bfef19304d7a458a2a8fb28@linux-ng.de>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <bf4aa2c82bfef19304d7a458a2a8fb28@linux-ng.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

On 6/6/22 2:14 PM, marcel@linux-ng.de wrote:
> Hi there,
> 
> please don't hesitate to direct me somewhere else in case this is not the right place to report
> bugs concerning nfs-utils.
> 
> I found a bug in nfs-utils concerning the rpc.svcgssd daemon while I was trying to set the
> principal name in /etc/nfs.conf:
> 
> [svcgssd]
> principal=nfs/myhost.mydomain.de@MYDOMAIN.DE
> 
> However rpc.svcgssd refused to start - complaining about not being able to find the principal in
> the keytab.
> When specified on command line (using the -p option) things worked however.
> 
> So I took a look at the code and found the problem in nfs-utils-2.6.1/utils/gssd/svcgssd.c.
> The problem seems to be here:
> 
> /* We don't need the config anymore */
> conf_cleanup();
> 
> This is called right after parsing the config file(s), but before calling gssd_acquire_cred().
> At the time it is called the variable "principal" does no longer contain the data read from the
> config file.
> 
> Moving conf_cleanup() to the end of the code helps.Could you please set a patch that shows where you moved this call?

> 
> As I first encountered this on Ubuntu 22.04 I also opened a Launchpad bug report:
> s. https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/1977745
Unfortunately I don't get notified when these get open....
https://bugzilla.linux-nfs.org/ would be a better place.

> 
> Maybe someone can fix this for the next release.
Sure... send a patch and we can make it happen!

steved.

> 
> Best regards,
> Marcel
> 

