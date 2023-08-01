Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E19B76B693
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Aug 2023 16:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjHAOCF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Aug 2023 10:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjHAOCD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Aug 2023 10:02:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EC0115
        for <linux-nfs@vger.kernel.org>; Tue,  1 Aug 2023 07:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690898478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DF+njAny3wsNOML4M55BTFjHT9hZNobHn09pQS3woNw=;
        b=cUCTaJiHPnWTTfSYCVW0zu2b7tCiKH9VQwUfzogxazYPivkMQL1GVhxMcxQF738iEWIvAS
        jmBaXj2Qx1bkWgTfZjo7k+c4tlcB9pKPeJwhdtI6vpFckfkQBZ0whS/LSeT9n/htfitBhg
        u88LwYn6sJXzwiwNUCtCmEK58DTTDNg=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-DtBUB7LrOiiukst6_hZZcw-1; Tue, 01 Aug 2023 10:01:16 -0400
X-MC-Unique: DtBUB7LrOiiukst6_hZZcw-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1a9e3f67989so1758755fac.1
        for <linux-nfs@vger.kernel.org>; Tue, 01 Aug 2023 07:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690898468; x=1691503268;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DF+njAny3wsNOML4M55BTFjHT9hZNobHn09pQS3woNw=;
        b=ItWPCfsZwdEuSl/cw7/9WZC8smVFdYzpaqOpkAiBDyKMhX+yZ476x0Ki+udRsmpuZJ
         eAcpoO/KVxTyfinQvACTHlMWq2BWP8c4fchmT7BbpgkEFqu1PU/1jUgRqlgK0Q2f5b9K
         hkAtnoW2zHfbAJ58gc3iAb/bQAEQdD4esNOxFSWc6kZUYNhkCMXkMBjhY0EZXzto5Awc
         HwhbOfS+ziHyZrOBDlwRdQYJccTtzesr7OL4dKqo/60+kidPVRc/0kfm2iszAdHVJrQM
         bTEit1gaxmwI6yTXG2EIZOLXgNuTi5Jq/P2Y+jb5zKBD6geT2sUnsKPTlztKyDJDViu/
         6FQw==
X-Gm-Message-State: ABy/qLZzM0hEEBudcQlkJ81r5ktuJhLZt0Ado0v005DjBzsKjyrNBKug
        h8JQZZhZbVODNEtvd2NbpqgEf9Yz+JDH0jp7jni78pOut5U4IMpeAyPznRNl4NyXwyw8dvbmP9s
        HRwrQa3JlwB5LCHNF/tA1VNsj1s+4
X-Received: by 2002:a05:6359:206:b0:134:c407:6823 with SMTP id ej6-20020a056359020600b00134c4076823mr4007002rwb.0.1690898468532;
        Tue, 01 Aug 2023 07:01:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF7pd+mMo1Q0DmKa8oMxN0WcrTo7NYgJ5krQtCuw9C1k+Qu7eczFXin4k+VXZ55O/adFaYTEg==
X-Received: by 2002:a05:6359:206:b0:134:c407:6823 with SMTP id ej6-20020a056359020600b00134c4076823mr4006983rwb.0.1690898468189;
        Tue, 01 Aug 2023 07:01:08 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.251.231])
        by smtp.gmail.com with ESMTPSA id p4-20020a0c8c84000000b0063cfb3fbb7esm4668903qvb.16.2023.08.01.07.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 07:01:07 -0700 (PDT)
Message-ID: <30aabd24-2b5f-5f5f-9bdd-0c505cd37b6d@redhat.com>
Date:   Tue, 1 Aug 2023 10:01:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Double-Free and Memory Leak Found In libtirpc
Content-Language: en-US
To:     "Wartens, Herb" <wartens2@llnl.gov>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <E931E05A-A78D-4802-9877-B04E9F610817@llnl.gov>
 <968E8957-2AF6-4901-84B0-92EDB5791131@llnl.gov>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <968E8957-2AF6-4901-84B0-92EDB5791131@llnl.gov>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 7/27/23 5:48 PM, Wartens, Herb wrote:
> 
> Just to be clear...
> These patches were not made for the upstream branch (might not apply as cleanly as expected). I applied and tested them against libtirpc-1.1.4-8.el8. I have not gone through the trouble of verifying/testing them against upstream sources. Was just asked to mail these patches here by RH in the bug. Hopefully this is still helpful.
Thank you! I'm looking into them now...

steved.
> 
> -Herb
> 
> 
>> On Jul 27, 2023, at 9:08 AM, Wartens, Herb <wartens2@llnl.gov> wrote:
>>
>> Hello All,
>> We have opened up two separate RedHat bugs for these issues. I added patches to those bugs, but was asked to send the patches here as well since the patches might need to go upstream first.
>>
>> 1) https://bugzilla.redhat.com/show_bug.cgi?id=2224666
>>
>> We have an application called HPSS that heavily uses libtirpc. When we updated to RHEL8.8 our application started crashing all of a sudden. We believe the change that introduced this problem was 2112116:
>>
>> 2022-08-03 Steve Dickson mailto:steved@redhat.com 1.1.4-8
>> - rpcb_clnt.c add mechanism to try v2 protocol first (bz 2107650)
>> - Multithreaded cleanup (bz 2112116)
>>
>> 252     for (cptr = front; cptr != NULL; cptr = cptr->ac_next) {
>> 253         if (!memcmp(cptr->ac_taddr->buf, addr->buf, addr->len)) {
>> 254             /* Unlink from cache. We'll destroy it after releasing the mutex. */
>> 255             if (cptr->ac_uaddr)
>> 256                 free(cptr->ac_uaddr);
>> 257             if (prevptr)
>> 258                 prevptr->ac_next = cptr->ac_next;
>> 259             else
>> 260                 front = cptr->ac_next;
>> 261             cachesize--;
>> 262             break;
>> 263         }
>> 264         prevptr = cptr;
>> 265     }
>> 266
>> 267     mutex_unlock(&rpcbaddr_cache_lock);
>> 268     destroy_addr(cptr);
>>
>> so we have free'd cptr->ac_uaddr. I believe after that free probably safer to set cptr->ac_uaddr to NULL.
>> Note that destroy_addr() will also try to free it.
>>
>> 2) https://bugzilla.redhat.com/show_bug.cgi?id=2225226
>>
>> While inspecting the changes between the versions of libtirpc in question, I noticed a memory leak as well.
>>
>> /*
>> + * Destroys a cached address entry structure.
>> + *
>> + */
>> +static void
>> +destroy_addr(addr)
>> +       struct address_cache *addr;
>> +{
>> +       if (addr == NULL)
>> +               return;
>> +       if(addr->ac_host != NULL)
>> +               free(addr->ac_host);
>> +       if(addr->ac_netid != NULL)
>> +               free(addr->ac_netid);
>> +       if(addr->ac_uaddr != NULL)
>> +               free(addr->ac_uaddr);
>> +       if(addr->ac_taddr != NULL) {
>> +               if(addr->ac_taddr->buf != NULL)
>> +                       free(addr->ac_taddr->buf);
>> +       }
>> +       free(addr);
>> +}
>>
>> Pretty clear that addr->ac_taddr never was properly free’d. I also verified that with valgrind.
>>
>> I am happy to add more detail, but hopefully others on this list can access the bugs in question. If not let me know and I can add more detail here if needed. Thanks.
>>
>> -Herb
>>
>> <libtirpc-1.1.4-LLNL-memleak.patch><libtirpc-1.1.4-LLNL-crash.patch>
> 

