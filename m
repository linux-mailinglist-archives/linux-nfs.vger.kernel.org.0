Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7616B671D
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Mar 2023 15:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjCLOVp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Mar 2023 10:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCLOVo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Mar 2023 10:21:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C04843467
        for <linux-nfs@vger.kernel.org>; Sun, 12 Mar 2023 07:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678630855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xir/1f3GHMF+vv5bS5OnNiWbi2iULwhDmfeu6xjdQmw=;
        b=WGHjg0p4DsLobM/HzqbcHAatfOHZ0kVrlqWG1Nu6g49BqxbCu6K6dqkLDOkA9tRavyG8zn
        V7gL6VUhvkqF/1max+ue5cyJWjKwh/Cl3Zu0+gqGrmEnE+LCpoxMNd0pny4IRIRZBVIHEQ
        vMyeZauui5jrr2fj1SOjAKlHC9qKKNQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-tt2PYBxqNzKomMEIgyeaSg-1; Sun, 12 Mar 2023 10:20:53 -0400
X-MC-Unique: tt2PYBxqNzKomMEIgyeaSg-1
Received: by mail-qv1-f70.google.com with SMTP id pv11-20020ad4548b000000b0056e96f4fd64so5723515qvb.15
        for <linux-nfs@vger.kernel.org>; Sun, 12 Mar 2023 07:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678630853;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xir/1f3GHMF+vv5bS5OnNiWbi2iULwhDmfeu6xjdQmw=;
        b=NxtMOUMElJvoEpsuhrofVeFKXEU1Q21sNFYmO2VRuqNgqDHA36ah8itA9XtkakLPcJ
         rrkWHGLW6id+ZGvPR+wnu49usL45YyqcG7Nz0nogaUUVR457Xv2uWX6m0JCxmb8GZNUm
         bavMnxWPTE1phxtD+bLnrc4kheNGGrOD9ql4KeaghD0laveTFyi8/TUFOiadEaGafeO2
         DNVcRLIFhdbdo06DsQPR9AsIePV34dQasxY6f48VMT6tLxyaxfskhnE6GMtJi4SKAP9i
         RHC2WZxw79XF+5CE9mjZXmePbA1OUJVpIyDRzHWx7dnqgrUlAV8pvU9s7X3EWY4W7iGF
         n+Cg==
X-Gm-Message-State: AO0yUKVHHiM9k1kD0wg11KhyqMqc5lbV/WM1TiMWg8mTX5ZgMPlNq+L+
        PA6HG9fooF4LjQbqfBnlYf8oyYfOCaOUYp1zeW865gz5kvnSpPOBudUvLzVU2HxNXxllr6f5rP9
        +ggZHpBg8YXvSy5HrJR5V
X-Received: by 2002:a05:6214:20aa:b0:571:eeb7:6bab with SMTP id 10-20020a05621420aa00b00571eeb76babmr14941960qvd.5.1678630853338;
        Sun, 12 Mar 2023 07:20:53 -0700 (PDT)
X-Google-Smtp-Source: AK7set+Oap2GcscmFkxgcungcMVrO6Y3jR0P2YwxWaXyvLsaJKYQkMcRPTCNDc1pdohGTGys0uF/bQ==
X-Received: by 2002:a05:6214:20aa:b0:571:eeb7:6bab with SMTP id 10-20020a05621420aa00b00571eeb76babmr14941932qvd.5.1678630853088;
        Sun, 12 Mar 2023 07:20:53 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.245.81])
        by smtp.gmail.com with ESMTPSA id s124-20020a37a982000000b0074583bda590sm210316qke.10.2023.03.12.07.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 07:20:52 -0700 (PDT)
Message-ID: <ecfe32fc-f547-ca7f-dc07-018af4d23f39@redhat.com>
Date:   Sun, 12 Mar 2023 10:20:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: mountd: Possible bug in next_mnt()
Content-Language: en-US
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        chris chilvers <chris.chilvers@appsbroker.com>
References: <1497292229.221220.1678287959937.JavaMail.zimbra@nod.at>
 <655a8ee6-dd94-effd-738a-9ce8db8ebed7@redhat.com>
 <156604342.233758.1678553565027.JavaMail.zimbra@nod.at>
 <31643f88-26ec-515c-d1d6-fad951248a8c@redhat.com>
 <1826031117.236924.1678628160815.JavaMail.zimbra@nod.at>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <1826031117.236924.1678628160815.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/12/23 9:36 AM, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> On 3/11/23 11:52 AM, Richard Weinberger wrote:
>>> ----- Ursprüngliche Mail -----
>>>>> next_mnt() finds submounts below a given path p.
>>>>> While investigating into an issue in my crossmount patches for nfs-utils I
>>>>> noticed
>>>>> that it does not work when fsid=root, rootdir=/some/path/ and then "/" is being
>>>>> exported.
>>>>> In this case next_mnt() is asked to find submounts of "/" but returns none.
>>>> I'm not clear as what you are saying... "rootdir=/some/path/" is not an
>>>> export option.
>>>
>>> Sorry for being imprecise.
>>> rootdir= is an nfs.conf exports option.Point. But I still need the patch in the
>>> correct
>> format with the Signed-off-by...
> 
> Well, the goal of my mail was not sending a ready-to-apply patch.
> It was a question. To me next_mnt() looks wrong but I'm not sure whether
> the current handling of "/" is desired for some special case I'm not aware of.
> 
> I'll happily send a patch after we agree that next_mnt() is wrong.
I'm still trying to reproduce problem... I have

/etc/nfs.conf: rootdir=/export

/etc/exports:
/home *(rw,sec=sys:krb5:krb5i:krb5p)
/tmp *(rw,fsid=666,all_squash)
/ *(rw,fsid=root,all_squash)

I'm not seeing the problem... Where does the crossmount come in?

steved.

