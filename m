Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A968A583FA0
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jul 2022 15:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239032AbiG1NJw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jul 2022 09:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236726AbiG1NJv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jul 2022 09:09:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D671A52DEB
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 06:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659013789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9WAz2z1ZWSFTFT87+v1uYvkxpw6D+ANPygQKYfwIa1g=;
        b=BW4DC4xGZumg2/B48O5psEsniF8v0ChZIYIzykxD/cimtdgCBSDDOz+6fcfyUH0VAOkk90
        WwfPNMoR2zPHxiB3AkoJ0vPYy+d0si0l3GFKq6fv4WrxJh12U1nR35zopcuZcGL72cuoEj
        njYviGYU6FD+iLWeSfFgdT5yERirUZo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-488-O0QA_xUNMdqy0mDljC2RuQ-1; Thu, 28 Jul 2022 09:09:48 -0400
X-MC-Unique: O0QA_xUNMdqy0mDljC2RuQ-1
Received: by mail-qk1-f197.google.com with SMTP id m8-20020a05620a24c800b006b5d8eb23efso1425470qkn.10
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 06:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9WAz2z1ZWSFTFT87+v1uYvkxpw6D+ANPygQKYfwIa1g=;
        b=kIT5C9UvKdUHDKi47o5W02dmDiYebBb76Dg5R54sMk7+pdJDnzZuETJ/L0SCmm4VRD
         Cndxr6VGcx6kajYKoCwdSXJQGr5flPwyxSRDVcXwACazSsVUlhMMyG+tQkfTc2sdz/Vu
         uqp1mEQEp7imrsr45DAKc9OfnW4JLpLEJIq+jRb20vByl04TsXtbnWrAeVgYK+N5JJtJ
         s/79JMQQ0e32njJqpyAM6qHOtiTX9VR7w9IELNrKuEvFW9ZFa0oNHejltzwg3BAqPHxv
         Qud7e1Q90puQbeTjl4HMqt4PVOzthBWtIivKsbBday+HH4LFRiGZSYyiUA6QTCPEfeP+
         FA+w==
X-Gm-Message-State: AJIora8/mMa70h7D/Fg79taJoPzRbRqWYCga4XTGhr9ixLYXQB9lDbUR
        b3jWA6kSFeRe6BFBlhIhmJDaij19Tm2WKJoCkuoOF7lJcszTUuT/qmT4jJmeO8EnoflyHiwKkKT
        raXkx/K+qQHWEFqQMVDQ+
X-Received: by 2002:a0c:9082:0:b0:474:2b:147 with SMTP id p2-20020a0c9082000000b00474002b0147mr22877418qvp.61.1659013787278;
        Thu, 28 Jul 2022 06:09:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1srNzQ3pOmqX73HRwTrBHH4+FpXyJLIiv6WQhGAYGBxnUuy+ANh1qSrLnq7+YTSL2o0MGooOQ==
X-Received: by 2002:a0c:9082:0:b0:474:2b:147 with SMTP id p2-20020a0c9082000000b00474002b0147mr22877374qvp.61.1659013786733;
        Thu, 28 Jul 2022 06:09:46 -0700 (PDT)
Received: from [172.31.1.6] ([70.109.154.36])
        by smtp.gmail.com with ESMTPSA id 7-20020a370b07000000b006b5fe1c376fsm462352qkl.131.2022.07.28.06.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 06:09:46 -0700 (PDT)
Message-ID: <e7f8ce36-93bc-50f5-1abf-5db5ec2e193e@redhat.com>
Date:   Thu, 28 Jul 2022 09:09:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] rpc-statd.service: Stop rpcbind and rpc.stat in an exit
 race
Content-Language: en-US
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20220727172441.6524-1-steved@redhat.com>
 <E4C11B71-CBAC-4F1B-B4FF-270FD0EDADA9@redhat.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <E4C11B71-CBAC-4F1B-B4FF-270FD0EDADA9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey!

On 7/28/22 7:15 AM, Benjamin Coddington wrote:
> On 27 Jul 2022, at 13:24, Steve Dickson wrote:
> 
>> From: Benjamin Coddington <bcodding@redhat.com>
>>
>> When `systemctl stop rpcbind.socket` is run, the dependency means
>> that systemd first sends SIGTERM to rpcbind, then sigterm to rpc.statd.
>>
>> On SIGTERM, rpcbind tears down /var/run/rpcbind.sock.  However,
>> rpc-statd on SIGTERM attempts to unregister from rpcbind
>>
>> systemd needs to wait for rpc.statd to exit before sending
>> SIGTERM to rpcbind
>>
>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2100395
>> Signed-off-by: Steve Dickson <steved@redhat.com>
>> ---
>>   systemd/rpc-statd.service | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/systemd/rpc-statd.service b/systemd/rpc-statd.service
>> index 095629f2..392750da 100644
>> --- a/systemd/rpc-statd.service
>> +++ b/systemd/rpc-statd.service
>> @@ -5,7 +5,7 @@ Conflicts=umount.target
>>   Requires=nss-lookup.target rpcbind.socket
>>   Wants=network-online.target
>>   Wants=rpc-statd-notify.service
>> -After=network-online.target nss-lookup.target rpcbind.socket
>> +After=network-online.target nss-lookup.target rpcbind.service
>>
>>   PartOf=nfs-utils.service
>>   IgnoreOnIsolate=yes
>> -- 
>> 2.34.1
> 
> Hey Steve - thanks for patchifying this -  I should have sent a proper
> patch, but the reason I didn't is that I didn't understand why we have the
> rpcbind.socket unit, and why that unit isn't sufficient to enforce the
> ordering.
The whole idea be the rpcbind.socket unit was the Fedora or systemd
people did not want daemons running when the are not needed.
So they came up with "on-demand" daemons, meaning a daemon
would be started when a process connect to the socket.

> 
> I don't remember the history.  Will changing the After= here create a
> problem where rpcbind.service is up, but the socket isn't there yet, and
> then rpc.statd comes up and can't find the socket?
I don't think so... That After= line, in rpc-statd.service,
was a result of a bug fix I did for bz1419351 (commit 09e5c6c2a3).
Why I used rpcbind.socket instead of rpcbind.service is not
clear, since rpcbind.service Requires rpcbind.socket.

So I'm thinking this is a valid bug fix... Thanks
for doing the debugging!!!

steved.

