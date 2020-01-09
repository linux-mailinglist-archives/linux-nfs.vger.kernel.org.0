Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67E3F135ACE
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2020 15:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731405AbgAIOAw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Jan 2020 09:00:52 -0500
Received: from smtpcmd14161.aruba.it ([62.149.156.161]:48900 "EHLO
        smtpcmd14161.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729572AbgAIOAv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Jan 2020 09:00:51 -0500
Received: from [192.168.159.128] ([212.103.203.10])
        by smtpcmd14.ad.aruba.it with bizsmtp
        id oE0n2101V0DySFo01E0oA7; Thu, 09 Jan 2020 15:00:49 +0100
Subject: Re: [nfs-utils PATCH 0/7] silence some warning in rpcgen
To:     Steve Dickson <SteveD@RedHat.com>, linux-nfs@vger.kernel.org
References: <20200103215039.27471-1-giulio.benetti@benettiengineering.com>
 <11af1233-d6e1-3952-475d-306dc5fefc06@RedHat.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Message-ID: <38aa6cba-91e4-f1ec-7978-45ba4b4cf4ee@benettiengineering.com>
Date:   Thu, 9 Jan 2020 15:00:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <11af1233-d6e1-3952-475d-306dc5fefc06@RedHat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1578578449; bh=hdoFDcZm/tFqOsPmcYU8IUQwMma6jn4xzIfrDlKCGzc=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=Nu8urC7vWoaUkvbwl4lw0Cd+y9XxxS9PeA7ekM4Egqw0nUtIXLImqxBmu4NRuaLSk
         iN+7K9BQEZa5dy7pNNAHN0RDrh0ab7RP8/NzTUAqxfAzheCb6DKYjqy1onBZgiYH9o
         rfTgPISgi+7Jv2DfTKSnkNPkeeoEQpLo2+/O28UwgZVE4N0oECohMhnAuK/LJZ40s4
         /4ybTgb4Sonh4l9AqUFQGIzuYFYx7R+LI5UB1hxBoZTg0d8ISNZopULoBKLyIKd62Z
         6nZxFY3srPWf53vqYZA+FXXd8EdJk3lr2UXfOBAU5mewF7Xhbnuy4IdnXMeTLeorlF
         hPxW2E9Ol7zBQ==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 1/7/20 8:06 PM, Steve Dickson wrote:
> 
> 
> On 1/3/20 4:50 PM, Giulio Benetti wrote:
>> Since I'm trying to bump version of nfs-utils to latest in Buildroot, I've
>> noticed some warning in rpcgen, so I've decided to clean them up by fixing
>> code or #pragma ignoring them. Hope this is useful. Other warnings are
>> still there waiting to be fixed and if you find these patches useful I'm
>> going to complete all warning correction.
>>
>> Giulio Benetti (7):
>>    rpcgen: rpc_cout: silence unused def parameter
>>    rpcgen: rpc_util: add storeval args to prototype
>>    rpcgen: rpc_util: add findval args to prototype
>>    rpcgen: rpc_parse: add get_definition() void argument
>>    rpcgen: rpc_cout: fix potential -Wformat-nonliteral warning
>>    rpcgen: rpc_hout: fix potential -Wformat-security warning
>>    rpcgen: rpc_hout: fix indentation on f_print() argument separator
>>
>>   tools/rpcgen/rpc_cout.c  | 8 ++++----
>>   tools/rpcgen/rpc_hout.c  | 4 +++-
>>   tools/rpcgen/rpc_parse.h | 2 +-
>>   tools/rpcgen/rpc_util.h  | 4 ++--
>>   4 files changed, 10 insertions(+), 8 deletions(-)
>>
> Committed (tag: nfs-utils-2-4-3-rc5)
> 
> I must admit this code is actually being used... I assume they do the right thing...
> 
> The rpcgen we been using is the old one that came out
> of the glibc code at https://github.com/thkukuk/rpcsvc-proto
> 
> I wonder what the difference is....

I can check it and use that one as upstream maybe and update it here in 
nfs-utils if you see that it makes sense.

Best regards
-- 
Giulio Benetti
Benetti Engineering sas

> steved.
> 
