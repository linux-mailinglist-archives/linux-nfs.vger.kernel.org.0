Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9197C3CADE0
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jul 2021 22:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhGOU2Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jul 2021 16:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhGOU2Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jul 2021 16:28:24 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649C2C06175F
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jul 2021 13:25:30 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j34so4443592wms.5
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jul 2021 13:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=L9Fz/ldOmbGLHubYtODX86RwZpZXZLHbZGnrwCtk2Fo=;
        b=Ws/Z+Mm1fW2VGYhDvNlf04CQJVMYA0sBvVoXMXhnZ8t+ktmZLFnOeua+EIJYRJ8X0H
         hjHH3db2EaWZGUMOzhoPW2b4nkqkRJb5XfmX+SADtpT1vEs8d5e91Ea4iwde8ZlbSd8K
         9NPHlrbQ3fygyvyWGzZi7n+/kIGLiEhJEASGAf9RmsKgUt91VQ7V+kiUAJU8Fp+uHrft
         SostTB2NdIvfYvvdVz05b5xIYbv+Puw3j0EAfl8xR5NBIWYUGM14g/YFWlcRj0jIr4ee
         vfClfq3M8ojhDk1sRFGKpDxjeWNCrVT701Asxbi7QByv/PfM30PxZfOYVsYI1i7kJiVt
         CHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=L9Fz/ldOmbGLHubYtODX86RwZpZXZLHbZGnrwCtk2Fo=;
        b=pcUdsQUxkkWS1SGWmXo+rtyKRxJvEMpyMVEX7/Z+WyAXwVyM28SooEgvSjYQqpPp2x
         rWoMyXl2W5WMOXqaS8w5uuKPxABIMrmNpjZC8vRqgvJ8u8sjKY98q/wNFYkOjl3OrELX
         jEowtI55VKIorrtEU4nY2XXfJYYGvCSiqrTK75iiulyGI/gN9T1L+BHQ034bTwfzMk33
         JNe4d0cnmiF8XOaZ2mlWJZjrmG/KbMk+I0rVHmFQ5eCa1gJlk07UUrykJ8AhTnwDGckA
         z1UnarGlKk7R/PM7A0rfH46njcbH6Qt5yKKvNLKG+PMc0fwL9cGA9EVvzcB0D3pQlWo0
         vN7w==
X-Gm-Message-State: AOAM531EARoqos9Vz+ZHZRBB8vGrkWpVEpP5MwbJWvqZivqE7bG65ik5
        eMdrPaibJLeRsMc2BlnHHtBwlnWX1s5qzyDf
X-Google-Smtp-Source: ABdhPJzrQTSF5FwjSzds/F6DOpAF+LSKdL2YUwqmrghrmUxwfa8QCBizHpBEf2J+yMCZJxOgZr1Fuw==
X-Received: by 2002:a1c:730d:: with SMTP id d13mr12999255wmb.129.1626380728771;
        Thu, 15 Jul 2021 13:25:28 -0700 (PDT)
Received: from [192.168.0.102] (line103-230.adsl.actcom.co.il. [192.117.103.230])
        by smtp.gmail.com with ESMTPSA id n18sm7311763wrt.89.2021.07.15.13.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 13:25:28 -0700 (PDT)
Subject: Re: nfs4.1 and nconnect - is this supported?
To:     Rick Macklem <rmacklem@uoguelph.ca>,
        linux-nfs <linux-nfs@vger.kernel.org>
References: <9d726e22-8c47-41ac-727b-3a27a9919fc6@vastdata.com>
 <YQXPR0101MB09687CF25C779E1E6ECEFF5ADD129@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
From:   guy keren <guy@vastdata.com>
Message-ID: <9e025239-bff4-3fbe-a167-342e58475b35@vastdata.com>
Date:   Thu, 15 Jul 2021 23:25:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YQXPR0101MB09687CF25C779E1E6ECEFF5ADD129@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 7/15/21 5:43 PM, Rick Macklem wrote:
> guy keren <guy@vastdata.com> wrote:
>> hi,
>>
>> i wonder if the linux client's nfs nconnect feature was designed to
>> support NFS4.1 (or higher) versions? according to our experimentation,
>> the linux client seems to just alternate messages between the multiple
>> RPC/TCP connections, and does not seem to adhere to the NFS 4.1 protocol
>> requirement, that when using multiple connections, the client needs to
>> use BIND_CONN_TO_SESSION when trying to user a 2nd connection with the
>> same NFS4.1 session.
>>
>> was this done on purpose? or is this configuration not supported by
>> linux client's 'nconnect'? or am i missing something?
> Yep, you're missing something.
>
> Snippet from RFC 5661 pg. 43:
>     If the client specifies no state
>     protection (Section 18.35) when the session is created, then when
>     SEQUENCE is transmitted on a different connection, the connection is
>     automatically associated with the fore channel of the session
>     specified in the SEQUENCE operation.
>
> As such, BIND_CONN_TO_SESSION is only required to associate the
> backchannel to the connection.
>
> rick

thanks for pointing this out, rick - i forgot about this feature.


does it mean that 'nconnect' cannot work with MACHCRED or SSV client 
authentication then?

will it work with kerberos (which does authenticate the client machine 
normally, as far as i know)?


thanks,

--guy
