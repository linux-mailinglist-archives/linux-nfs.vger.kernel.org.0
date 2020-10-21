Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BF9294BEB
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Oct 2020 13:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439562AbgJULqT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Oct 2020 07:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439424AbgJULqS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Oct 2020 07:46:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB6EC0613CE
        for <linux-nfs@vger.kernel.org>; Wed, 21 Oct 2020 04:46:18 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <bst@pengutronix.de>)
        id 1kVCZN-00066r-7i; Wed, 21 Oct 2020 13:46:17 +0200
Subject: Re: [nfs-utils PATCH] tools: rpcgen: use host instead of cross
 compiler
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        linux-nfs@vger.kernel.org
Cc:     Steve Dickson <steved@redhat.com>, kernel@pengutronix.de
References: <20201021102852.26186-1-bst@pengutronix.de>
 <9841877b-3952-ed6c-f3c8-0840a8083a76@benettiengineering.com>
 <056bd6a6-9630-bda2-e16d-2f8f31c4bedb@pengutronix.de>
 <d420b69b-6ab6-59ef-0be8-79b688cac027@benettiengineering.com>
From:   Bastian Krause <bst@pengutronix.de>
Message-ID: <25f3925e-191e-65cd-12e4-9f07c28395cb@pengutronix.de>
Date:   Wed, 21 Oct 2020 13:46:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <d420b69b-6ab6-59ef-0be8-79b688cac027@benettiengineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: bst@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-nfs@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Giulio,

On 10/21/20 1:42 PM, Giulio Benetti wrote:
> On 10/21/20 1:18 PM, Bastian Krause wrote:
>>
>> Hi Giulio,
>>
>> On 10/21/20 12:46 PM, Giulio Benetti wrote:
>>> On 10/21/20 12:28 PM, Bastian Krause wrote:
>>>> When cross compiling rpcgen is compiled with the cross compiler
>>>> although
>>>> it is executed during compile time only. This leads to errors like:
>>>>
>>>>     ../../tools/rpcgen/rpcgen -l -o mount_clnt.c mount.x
>>>>     ../../tools/rpcgen/rpcgen -c -i 0 -o mount_xdr.c mount.x
>>>>     ../../tools/rpcgen/rpcgen -h -o mount.h mount.x
>>>>     /lib/ld-linux-armhf.so.3: No such file or directory
>>>>     /lib/ld-linux-armhf.so.3: No such file or directory
>>>>     /lib/ld-linux-armhf.so.3: No such file or directory
>>>
>>> Can you please provide how you reach this situation?
>>
>> Sure, see below [1].
> 
> Very difficult to me to reproduce, anyway I've got the point now.
> 
>>>
>>>> Since e61775d1 ("rpcgen: bump to latest version") rpcgen is compiled
>>>> with the target compiler, prior to that it was correctly compiled with
>>>> the host compiler. Fix that by using $(CC_FOR_BUILD) as CC
>>>> explicitly as
>>>> it was before.
>>>>
>>>> buildroot works around this by compiling a host version first, then a
>>>> target version --with-rpcgen=$(HOST_DIR)/bin/rpcgen [1]. That does not
>>>> look like it is intended by nfs-utils.
>>>
>>> I find it correct since rpcgen is also a utility to be installed to
>>> target, so it should not be explictly built only for target and
>>
>> I was not aware of this. Having a host package does not sound so bad
>> now :)
> 
> yes :-)
> 
>>>
>>>> [1]
>>>> https://git.busybox.net/buildroot/tree/package/nfs-utils/nfs-utils.mk#n25
>>>>
>>>>
>>>> Signed-off-by: Bastian Krause <bst@pengutronix.de>
>>>> ---
>>>>    tools/rpcgen/Makefile.am | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/tools/rpcgen/Makefile.am b/tools/rpcgen/Makefile.am
>>>> index 457cd507..f122cd9d 100644
>>>> --- a/tools/rpcgen/Makefile.am
>>>> +++ b/tools/rpcgen/Makefile.am
>>>> @@ -1,5 +1,7 @@
>>>>    CLEANFILES = *~
>>>>    +CC=$(CC_FOR_BUILD)
>>>> +
>>>
>>> this is what you're forcing to. To cross compile it we need both rpcgen
>>> for host and target, this way it will be built for target only.
>>
>> This is obviously wrong then.
>>
>>> Another option I can suggest is to assign CC_FOR_BUILD to CC on caller
>>> Makefile only during target building and not during host building and
>>> this should be automatically deduced by Makefile itself and also
>>> Makefile then, when calls rpcgen should know which rpcgen to use(the
>>> host one). That would be one solution IMHO.
>>>
>>> What do you think about it?
>>
>> I am not sure I understand this. Would this mean rpcgen is compiled
>> twice, once with the host compiler and once with the target compiler?
> 
> Yes, that I think should happen when cross-compiling because:
> - we need host rpcgen for building for target
> - we need target rpcgen to be installed to target

Agreed.

>> Without the need of a dedicated host package? That would be ideal, but I
>> have currently no idea how to achieve this.
> 
> It would be a not so little effort at the moment, so maybe can we keep
> it as is and you use the same work around I've used in Buildroot?

Yes, I'll use that.

> But in the meanwhile feel free to find a solution like this, that way
> when cross-compiling we can remove "--with-rpcgen=" that should be
> implicit.

In case I have some spare time, I'll look into this.

Thanks!

Regards,
Bastian

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
