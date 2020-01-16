Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF0F13FABE
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2020 21:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgAPUis (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jan 2020 15:38:48 -0500
Received: from smtpcmd03116.aruba.it ([62.149.158.116]:40873 "EHLO
        smtpcmd03116.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729067AbgAPUis (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jan 2020 15:38:48 -0500
Received: from [192.168.126.128] ([146.241.70.103])
        by smtpcmd03.ad.aruba.it with bizsmtp
        id r8el2100W2DhmGq018elLR; Thu, 16 Jan 2020 21:38:46 +0100
Subject: Re: [nfs-utils PATCH 5/7] rpcgen: rpc_cout: fix potential
 -Wformat-nonliteral warning
To:     Steve Dickson <SteveD@RedHat.com>, linux-nfs@vger.kernel.org
References: <20200103215039.27471-1-giulio.benetti@benettiengineering.com>
 <20200103215039.27471-6-giulio.benetti@benettiengineering.com>
 <dd75fa26-a07a-49fb-ed22-1e60da31c8da@benettiengineering.com>
 <a9f351c6-22e5-35ef-7119-d261ef8d0159@RedHat.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Message-ID: <4950679e-f8d0-c9ce-b08d-62801acd2c12@benettiengineering.com>
Date:   Thu, 16 Jan 2020 21:38:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a9f351c6-22e5-35ef-7119-d261ef8d0159@RedHat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1579207126; bh=IevB3bRWRDA0rsx9q5k3ijwq1srfB6HBdsvujoFDmFU=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=Tu6dItiPAnDww7fko6N9LTSvZjkFEbNg5T+Dv9McnYKbst7OIIHqFYy9RsJQanfnC
         4e2T6PJkAu86o5xIsvjXcE3Yt3Hv6E32g18Mj7IHKBPbtJs3ceo5m0rpznRk7ZRGXg
         luvR0MAxz3KFyQxhfCEocAO297MpYqLsfx/D/o8DnsMVcjYjRWPWq00fL65n7I8MBP
         nY6lcPgwA2AvZYSjMkH5Qb0ONWls/9sBFEZo71hF7lWEJtjp2u4n1aLn9GUwOabvX1
         tNRV7CEL3TiDU5BuNtACd1paSWzMQAKYFXVKUtYlHJNlGTU7plr/+xxgmT5uMxicgt
         3NN7pjcxOe00Q==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 1/16/20 9:07 PM, Steve Dickson wrote:
> 
> 
> On 1/15/20 11:29 AM, Giulio Benetti wrote:
>> Hi Steve,
>>
>> you've missed this patch while applying the series. Can you please commit it?
> It is in...
> 
> commit 6f4568f1f7395f967cc03995dcfb79a1ac5c11cd
> Author: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Date:   Mon Jan 6 14:23:04 2020 -0500
> 
>      rpcgen: rpc_hout: fix potential -Wformat-security warning
>      
>      f_print()'s argument "separator" is not known because it's passed as an
>      argument and with -Wformat-security will cause a useless warning. Let's
>      ignore by adding "#pragma GCC diagnostic ignored/warning" before and
>      after f_print().
>      
>      Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
>      Signed-off-by: Steve Dickson <steved@redhat.com>
> 
> what am I missing?

Ah you've merged them together, now I see:
[5/7] https://patchwork.kernel.org/patch/11317493/
[6/7] https://patchwork.kernel.org/patch/11317489/

I didn't notice it while pull rebasing from upstream, because I have 
another patch similar to that after bumping to latest version of rpcgen.

Sorry for the noise and thank you!
Best regards
-- 
Giulio Benetti
Benetti Engineering sas
