Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620155F5ACE
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Oct 2022 22:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiJEUG7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Oct 2022 16:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiJEUG6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Oct 2022 16:06:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C8B75FCD
        for <linux-nfs@vger.kernel.org>; Wed,  5 Oct 2022 13:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665000416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SzE8/j0UXp9xlIPt4zMBYr8Vk5fcxB28USyqw8rYZGU=;
        b=G4RNMHEpBdPA8JxKNLkdp3XekQMAxmseZLe+fBHQs7LhAeROjT9Izq0LsjEpnVj9RSbj2b
        Fyi0aIy96UL/89L6T9nzjfDG1h+NPv34p+BlumTcg7+qTohwCZjlCsGE9G3LQQf7DDZ60a
        JdN2cnsK50r9ZvvmVldp2luALEJTK4I=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-316-0-jy36V9NIKiRW8bg4qRQA-1; Wed, 05 Oct 2022 16:06:55 -0400
X-MC-Unique: 0-jy36V9NIKiRW8bg4qRQA-1
Received: by mail-qk1-f198.google.com with SMTP id n13-20020a05620a294d00b006cf933c40feso15249736qkp.20
        for <linux-nfs@vger.kernel.org>; Wed, 05 Oct 2022 13:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SzE8/j0UXp9xlIPt4zMBYr8Vk5fcxB28USyqw8rYZGU=;
        b=dcJRBVhm7XI6QKKeqDlPuuZA9rzTq8sI6GhmKW+qSmFXgftG6CTnio59ysuXKqBWWR
         /KRNhZNxTcJ3IW/2K1BnLynq17ZsadWgv16x9dz5D+6fn/HmZRvKUDrkvxlNwV0v8j3j
         VJlim8KgngQ9IXzNRdm8U+xFY+3VIItQhuSV+Cc5XiAs95tJoqo/xK8TXhZdhqTxa6g3
         rzqCeT1+TRWhnvf8walyn+ZH17rJYHW1OPkd/brjsYkKgV78czOYEcMWsre+07GabxCK
         afstVMnT2poJtp0n+q8fAlO/I4TZ3PW8o8XTzSYIDvRo/WWP3Nl5jrtwo34eNtJMt1w7
         FU8Q==
X-Gm-Message-State: ACrzQf3/gx7Q44zFpgh7X+h9thf2B/U/c+7awpIVrShi7+LwPg9tSQTO
        25946smkIuhgUxg1C1KfOii87mid2cEfz1XT9c+wQbGFZ9PLVLFlkecbe6QDulxY2HQkRz9lEEx
        OqlHGTvHcDMv0BgzaWEGegBIUPbaNZFnaZwb2rD00ymrJjOKYt8YtltnA+s9QxB4n1I4P1g==
X-Received: by 2002:ac8:5741:0:b0:35b:b52b:ca9e with SMTP id 1-20020ac85741000000b0035bb52bca9emr927100qtx.653.1665000413348;
        Wed, 05 Oct 2022 13:06:53 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4VoTBR6KsWb+sC4KlpnZUWZA/9HFCIOD8omwuwR6orssm8iqMrGsWbgFjzWAVWFYvbFiTrsQ==
X-Received: by 2002:ac8:5741:0:b0:35b:b52b:ca9e with SMTP id 1-20020ac85741000000b0035bb52bca9emr927076qtx.653.1665000412966;
        Wed, 05 Oct 2022 13:06:52 -0700 (PDT)
Received: from [172.31.1.6] ([70.109.137.95])
        by smtp.gmail.com with ESMTPSA id i13-20020a05622a08cd00b00393c2067ca6sm436673qte.16.2022.10.05.13.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 13:06:52 -0700 (PDT)
Message-ID: <54369970-c543-8912-dae4-79bed31806ec@redhat.com>
Date:   Wed, 5 Oct 2022 16:06:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: Bakeaton: Reminder... One week away.
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <c15eeb0c-60be-fcdb-b464-a8f98553baec@redhat.com>
In-Reply-To: <c15eeb0c-60be-fcdb-b464-a8f98553baec@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Just a quick note...

Face masks are optional in Red Hat facilities, but
there are masks and hand sanitizers at the door
and through out the facility.

steved.

On 10/3/22 2:05 PM, Steve Dickson wrote:
> Hello,
> 
> We are one week out before the start
> of the fall bakeathon at the Red Hat
> Westford office. *Mon Oct 10 to Fri Oct 14*
> The details are here [1].
> 
> We also have virtual access to the BAT testing
> network using a WireGuard VPN. To get that
> set up please contact: bakeathon-contact@googlegroups.com
> 
> We will also be trying having talks every day at 2pm EST.
> The sign up sheet is here [2]. If you are interested in
> some topic please let us know. These talks are open to
> everyone, whether you are testing or not.
> 
> I hope to see you... one way or the other!
> 
> steved.
> 
> [1] http://www.nfsv4bat.org/Events/2022/Oct/BAT/index.html
> [2] 
> https://docs.google.com/spreadsheets/d/1Uu689KQ1LdalfsH6WYaHh8uiiI743KIeEt6MKeAVIJU/edit#gid=1920779269
> 
> 
> 

