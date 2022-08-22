Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7244B59C881
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Aug 2022 21:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238431AbiHVTSj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Aug 2022 15:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238477AbiHVTSS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Aug 2022 15:18:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A99F4DB67
        for <linux-nfs@vger.kernel.org>; Mon, 22 Aug 2022 12:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661195828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d0xxsG63RyhPK2d/+JwMUwlWT1G46GJehzvhuE2jB+w=;
        b=EL+I1jmRv6c9KIqItIcZrAQPxOwEjy6tzr93bQOWXpwxytixbvVo3BQJFyl9I3i0h5h42C
        7i+YjvWapwcdNS0vovsfo23cXoL8VhAwro7/VcyHldgeYrelzWNGo7BPga5R5xm/ABcv/I
        ey6dgnw+C0yzSqyjn/8DXD8Z6aFZTVA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-116-J0DD6c_iOWWPPJlFvFSJpg-1; Mon, 22 Aug 2022 15:17:04 -0400
X-MC-Unique: J0DD6c_iOWWPPJlFvFSJpg-1
Received: by mail-qv1-f69.google.com with SMTP id o16-20020a0cecd0000000b0049656c32564so5996105qvq.19
        for <linux-nfs@vger.kernel.org>; Mon, 22 Aug 2022 12:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=d0xxsG63RyhPK2d/+JwMUwlWT1G46GJehzvhuE2jB+w=;
        b=tXJfbl9o6bOnsT8Anb1EGEXsLH6O70TMFFrDpQe2b49uodRkwsFqbhxwTRZ6M3WX+E
         BrigxHuJ0E/BAf30w+LvWgdUQR8NhzTykP7RnfGd8cP44oEzF0hlzPnv4maXCdja817y
         Gq7X24mxQ8npns7XT9Iaph4W9ZKyWjAC4i1R29NHUkupa/hp/FGxnhzA6oNR1ht8KieO
         jqKMMkc4qBoHB986/Jy0NLSQ+UuK4mM6YFZbRvUTnldD4nREQC9bsVyYiSYBNjeDjPRg
         /HTjIIt5kZFt42mtNRCC/YT/jIpycddIiY1cwknesVDetNONvMlYGvkGm3kbRE0J8e2Q
         4DhA==
X-Gm-Message-State: ACgBeo1XEghWqtsSo7CHH6qXywYh9uEJ3J1Wx9kB2ZzmFpxKOK0ma8r7
        dkdaqdjrF3bneXw9uMvts2Nh2nEAj6Hlk6RX+ItkclvhNW+xPX4B5WjjUFS0WOsoerdZ/OW1TCY
        VBGlDmjxRuZ7Un8aH4Zy9
X-Received: by 2002:ad4:4eab:0:b0:47e:cada:d63d with SMTP id ed11-20020ad44eab000000b0047ecadad63dmr17167008qvb.48.1661195824376;
        Mon, 22 Aug 2022 12:17:04 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7x55VntYy3vlcHviExtMqFKKmsacrzb1zvHOq1uhuPCNON2a55Rc3wtCo4oPc0mYrNhvsHXQ==
X-Received: by 2002:ad4:4eab:0:b0:47e:cada:d63d with SMTP id ed11-20020ad44eab000000b0047ecadad63dmr17166996qvb.48.1661195824099;
        Mon, 22 Aug 2022 12:17:04 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.245.220])
        by smtp.gmail.com with ESMTPSA id fb24-20020a05622a481800b003434d1a7a14sm9331001qtb.62.2022.08.22.12.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 12:17:03 -0700 (PDT)
Message-ID: <12ece17b-b2d9-6621-0af7-26a12470bc99@redhat.com>
Date:   Mon, 22 Aug 2022 15:17:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3] nfsrahead: fix linking while static linking
Content-Language: en-US
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Petr Vorel <pvorel@suse.cz>
Cc:     linux-nfs@vger.kernel.org
References: <YvVkftYtIgFhYHKk@pevik>
 <881E6E82-812C-4BD8-849C-4DEE484AE4F0@benettiengineering.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <881E6E82-812C-4BD8-849C-4DEE484AE4F0@benettiengineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 8/11/22 4:36 PM, Giulio Benetti wrote:
> Hi Petr,
> 
>> Il giorno 11 ago 2022, alle ore 22:20, Petr Vorel <pvorel@suse.cz> ha scritto:
>>
>> ﻿Hi,
>>
>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>>
>> nit (not worth of reposting): I'm not a native speaker, but IMHO subject should
>> be without while, e.g. "fix order on static linking"
> 
> Totally, it sounds awful as it is now.
> I ask maintainers if it’s possible to reword like Petr
> pointed.
Will do!

steved.
> 
> Thank you all.
> 
> Best regards
> Giulio
> 
>>
>> Kind regards,
>> Petr
> 

