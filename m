Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D6160BB9D
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Oct 2022 23:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbiJXVHA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 17:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiJXVGm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 17:06:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBC11A527C
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 12:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666638741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yv1ZKBxll1VKkIe5XkqdABqHWpMZJgKgr04QZBN6qEM=;
        b=OiKDXdMTeF8rfWu75LuYvbjEipdaHRzpjUueAluXHVPkQgWVqxNVVdVpc3/9yLmucjMORN
        zeXlNbyTsVMzufPd9e8vK0Crh7NvRSUEXuVG67ZtgH96bkmnNgcb5h5q1a88bcz85vvTCE
        d9W/q0wgmyV5Y875q59ms90T90BlAsw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-288-kSI3R1teMM2Knb_bLRB3ew-1; Mon, 24 Oct 2022 14:23:54 -0400
X-MC-Unique: kSI3R1teMM2Knb_bLRB3ew-1
Received: by mail-qt1-f200.google.com with SMTP id bz12-20020a05622a1e8c00b0039ae6e887ffso7495223qtb.8
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 11:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yv1ZKBxll1VKkIe5XkqdABqHWpMZJgKgr04QZBN6qEM=;
        b=3kgI9HSK7nFp8nZaeSq4Q4VMl6wLsvXcXQ9Wu2T13AhEt8uMhRTLWMlMq1aojOPykk
         EKmnPYw+urIZIpTQGcSam9ibf8u0XEKBku7THg8jYbrYNaANa/iFiVWeKIWFCpgmxL1t
         j39ow4D2Jo5VBxgF5o7WSQdHzpwo9w4KDz10O+HbKvXIR69Jc1miKlbgL2adbv/wBqwv
         4xF67tn9HAaUbHsw6jkKNpoJkXUAJj9hRVpmk3cGZM5fQBvKin9nmdxs7QBdpU9QODmu
         BnTYNQsuK4xM7+7C48ovZS4niK1LCNHaK7XogrYQaeym7IW41oXfjboX+ykj02xL2RpA
         xvYw==
X-Gm-Message-State: ACrzQf0aSEc7CVCIZD+evnDVJ3DN32pA34f08t/nARijl/KRkWkH1sx1
        RyLMArLMo13dwcdkPsbEhRwUduRrre6S0apqrcYni6MBtg3vbZ2If0Qq5L7QA6OKTxpQ/STK2oN
        TWvbH1TIEuKiUbBL6xmZ8
X-Received: by 2002:a37:5f05:0:b0:6ec:59fe:1ab4 with SMTP id t5-20020a375f05000000b006ec59fe1ab4mr23933017qkb.111.1666635833649;
        Mon, 24 Oct 2022 11:23:53 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM46sdsXx9+H6pd4bCAtq6f1BdZf1x/Cr1gqeeBRsnXrFBP+HhdxDZgwQzkUMSeqIfgs8OvZHw==
X-Received: by 2002:a37:5f05:0:b0:6ec:59fe:1ab4 with SMTP id t5-20020a375f05000000b006ec59fe1ab4mr23933003qkb.111.1666635833368;
        Mon, 24 Oct 2022 11:23:53 -0700 (PDT)
Received: from ?IPV6:2603:6000:d605:db00:db8c:7bbd:f449:802d? (2603-6000-d605-db00-db8c-7bbd-f449-802d.res6.spectrum.com. [2603:6000:d605:db00:db8c:7bbd:f449:802d])
        by smtp.gmail.com with ESMTPSA id l11-20020ac848cb000000b003a29e96c135sm298830qtr.72.2022.10.24.11.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 11:23:52 -0700 (PDT)
Message-ID: <282a3e2f-585b-8f55-fb5b-30bcbdb60155@redhat.com>
Date:   Mon, 24 Oct 2022 14:23:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Invalid free() in blkmapd, core dump
Content-Language: en-US
To:     Benjamin Coddington <bcodding@redhat.com>,
        Andreas Hasenack <andreas@canonical.com>
Cc:     linux-nfs@vger.kernel.org
References: <CANYNYEG=utJ2pe+FtMWh8O+dz63R2wbzOC7ZVrvoqD=U04WL5g@mail.gmail.com>
 <12B9F373-E858-4415-B71D-227FD6D7E4D6@redhat.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <12B9F373-E858-4415-B71D-227FD6D7E4D6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 10/20/22 1:19 PM, Benjamin Coddington wrote:
> Adding Steve D directly to see if he can pick up the original fix.
> 
> Steve, what happened to https://lore.kernel.org/linux-nfs/77a09978-a5aa-ea7f-04b8-a8d398ee325f@huawei.com/  ?
I just committed it... I have no idea how that fell off my radar...

steved.
> 
> Ben
> 
> On 20 Oct 2022, at 10:33, Andreas Hasenack wrote:
> 
>> Hi,
>>
>> this was brought up before in
>> https://www.spinics.net/lists/linux-nfs/msg87598.html
>>
>> We recently got bug reports about the same issue, and it was only
>> yesterday that I finally managed to reproduce it in a VM.
>>
>> My reproduction steps are:
>> - add a scsi device to a vm (not virtio). Maybe works with sata too,
>> but scsi reproduced it
>> - add it to an LVM VG, and create an LV
>> - run blkmapd -f:
>> # blkmapd -f
>> blkmapd: open pipe file /run/rpc_pipefs/nfs/blocklayout failed: No
>> such file or directory
>> double free or corruption (out)
>> Aborted (core dumped)
>>
>> The "No such file or directory" has nothing to do with it. You can
>> "modprobe blocklayoutdriver" to get rid of it, but the invalid free()
>> still happens.
>>
>> in 2.6.1, gdb shows:
>> #9  0x00005555555571e5 in bl_add_disk (filepath=0x7fffffffd480
>> "/dev/dm-2") at device-discovery.c:232
>> 232 free(serial->data);
>> (gdb) l
>> 227 disk->dev = dev;
>> 228 disk->size = size;
>> 229 disk->valid_path = path;
>> 230 }
>> 231 if (serial) {
>> 232 free(serial->data);
>> 233 free(serial);
>> 234 }
>> 235 }
>> 236 return;
>>
>> As lixiaokeng said in that first post, this should be just
>> free(serial). Or use bl_free_scsi_string(), like his suggested patch
>> does.
> 

