Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E5C507ADD
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Apr 2022 22:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242331AbiDSUXR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Apr 2022 16:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351653AbiDSUXP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Apr 2022 16:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7DDA1D314
        for <linux-nfs@vger.kernel.org>; Tue, 19 Apr 2022 13:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650399631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x60TxS356E2B2gUuvzxm8eN2l8uaRPZiQNrQgrboeHk=;
        b=XpPAv9YH7hm1UKMD4WmWtKkYPFttVzF5cLrWqkitzw+TCPn87Pe0fVPecXfj/IvuzdC8+l
        DgqlF0JjPofK6GFAzNJnAnFyoXg8ti6t1/LKSOJVNgUTMgE5+VmafIbD4wT0GAJRqJTnhU
        lzadmLu7HPWg4YouU9uGdDaxAJyj9NQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-OLujp9YYP3a-z9RkKBapKg-1; Tue, 19 Apr 2022 16:20:29 -0400
X-MC-Unique: OLujp9YYP3a-z9RkKBapKg-1
Received: by mail-qv1-f69.google.com with SMTP id kj4-20020a056214528400b0044399a9bb4cso15293411qvb.15
        for <linux-nfs@vger.kernel.org>; Tue, 19 Apr 2022 13:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x60TxS356E2B2gUuvzxm8eN2l8uaRPZiQNrQgrboeHk=;
        b=U8/pZQ/JZVoeCvgz2R9uUkS79QXSte/S6qbsDx9+wcdRQzpCZXTOXztw2MnqBoYHfw
         fkKSbpAFvklVNmzPnyA3Zmubohu5oYZw6JUjZRTtrD4O0iMRNYA12q8SZScunCMR2hA8
         XSbsWnbugQDgBOrwbjNPg4vivtqJ/0wrRWdY5JQHiholOQ771YJv8jHtO8phXJP35tt+
         in+6U99fLYTPrl+Zi3QPTnVjLoQUaQdQpyhCYwj6Vvodx3Lo6hcdJFuVwP/3tsb5YlUb
         vDvHFuKcT2Hw3kHAxwGZvy3c81t74qJyfumQ6fNNHYN1P7afb4M7JFQzlN75Gq0D3X8B
         AD+w==
X-Gm-Message-State: AOAM533zjYXNJRHTX/3FF3Tdv+Q65MrWew66m10bGEkUXf5Hfwd8gjl8
        etAC8gCNA1xgjidxkffQc1FwFOk1/r00owpdfgEVqUhXF9lDHdGEAI46/oQQ4s9UAT8rZ8uMI3K
        h6hNJwMld3td+k9g7los9
X-Received: by 2002:a05:620a:4085:b0:69e:b1eb:696 with SMTP id f5-20020a05620a408500b0069eb1eb0696mr5289232qko.672.1650399628679;
        Tue, 19 Apr 2022 13:20:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzjzg1cCHCug/7Er0VY1eQXApt+YuwG/+PdIW3TF+r1P0/xx4G2ugP0bjwAbzxxoV4ChxyLg==
X-Received: by 2002:a05:620a:4085:b0:69e:b1eb:696 with SMTP id f5-20020a05620a408500b0069eb1eb0696mr5289222qko.672.1650399628476;
        Tue, 19 Apr 2022 13:20:28 -0700 (PDT)
Received: from [172.31.1.6] ([71.168.80.171])
        by smtp.gmail.com with ESMTPSA id y3-20020a376403000000b0069e899ec3c7sm474530qkb.75.2022.04.19.13.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 13:20:28 -0700 (PDT)
Message-ID: <b5c5de51-327e-ef27-b84e-e1bdffe8f43b@redhat.com>
Date:   Tue, 19 Apr 2022 16:20:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 0/6] nfs-utils: Improving NFS re-exports
Content-Language: en-US
To:     bfields <bfields@fieldses.org>, Richard Weinberger <richard@nod.at>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>, david <david@sigma-star.at>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        david oberhollenzer <david.oberhollenzer@sigma-star.at>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        anna schumaker <anna.schumaker@netapp.com>,
        chris chilvers <chris.chilvers@appsbroker.com>
References: <20220217131531.2890-1-richard@nod.at>
 <20220217163332.GA16497@fieldses.org>
 <1645735662.120362.1646645152190.JavaMail.zimbra@nod.at>
 <20220307222924.GD24816@fieldses.org>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220307222924.GD24816@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/7/22 5:29 PM, bfields wrote:
> On Mon, Mar 07, 2022 at 10:25:52AM +0100, Richard Weinberger wrote:
>> Did you find some cycles to think about which approach you prefer?
> 
> I haven't.  I'll try to take a look in the next couple days.  Thanks for
> the reminder.

Is there any movement on this?? I would be good to have some
for the upcoming Bakeathon... Next week.

steved.

