Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37EA0294B83
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Oct 2020 12:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405065AbgJUKyB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Oct 2020 06:54:01 -0400
Received: from smtpcmd02102.aruba.it ([62.149.158.102]:43899 "EHLO
        smtpcmd02102.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390849AbgJUKyB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Oct 2020 06:54:01 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Oct 2020 06:54:00 EDT
Received: from [192.168.47.129] ([146.241.193.26])
        by Aruba Outgoing Smtp  with ESMTPSA
        id VBdtkaxeu5c8RVBdukFrOR; Wed, 21 Oct 2020 12:46:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1603277217; bh=v3e2wV1UkYodF17J6hrDOS17muhwMZ1jZJu302wpZCk=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=RGBKtYmk8vAS/VLKr/CbveK2KeM8RT9qacVhXatblq3ujcMAqPtX0uyoS3xvs1CWo
         BMyhPBjLYOaA/WFQF3YREMUEDtccdxmR0KyFtRF6+tkpQfz7guBZgukXUj8JGJVHAM
         azlLQ07s9GszjiZTnR5/czlIMxTweVFEy2MCnOUTgheDYzSC3epjdKrTaMS7dUFRbk
         hWWyXyvolbpHjI6iEvuPhDTQGAwVs/FCKIJli2Ln1ErNYveW/3QUEfLjQ2cAbYWYz6
         o2YFnusIg+xViJd+cN8499FRkV4hnJmzE5DwtM2MQukrn9H1Tw9HLYBdz1CfqhSXzc
         C8ov7ofpnMV/g==
Subject: Re: [nfs-utils PATCH] tools: rpcgen: use host instead of cross
 compiler
To:     Bastian Krause <bst@pengutronix.de>, linux-nfs@vger.kernel.org
Cc:     Steve Dickson <steved@redhat.com>, kernel@pengutronix.de
References: <20201021102852.26186-1-bst@pengutronix.de>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Message-ID: <9841877b-3952-ed6c-f3c8-0840a8083a76@benettiengineering.com>
Date:   Wed, 21 Oct 2020 12:46:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201021102852.26186-1-bst@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOJBkQEYCoju7CJlax3+1kZPFZRIsNKMSaLUrlIYGX7PisvVcUNQGdpA2vgCt4NJ4DUl9kSHyqQyjXKToHGwLYTvOpbqiDSwpqKBN+vjdTN3i33boVDb
 oeVMfgcPDGhJYDRZf9gIgRRROMVpew4HBxLih+mUYid0NJIUweGFuLSbPkxU6AmNUQ3oFSTYCqRTWszJBIIgi/ssB7s3QuVsSAwyUKJ6mu3R3tWLwC9zstBQ
 KoOIJgFx2jJseHdENfOevhdRxBLq65BSCBF2tw1s4clKHXbxLRmAoegBauAenkJJ
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Bastian,

On 10/21/20 12:28 PM, Bastian Krause wrote:
> When cross compiling rpcgen is compiled with the cross compiler although
> it is executed during compile time only. This leads to errors like:
> 
>    ../../tools/rpcgen/rpcgen -l -o mount_clnt.c mount.x
>    ../../tools/rpcgen/rpcgen -c -i 0 -o mount_xdr.c mount.x
>    ../../tools/rpcgen/rpcgen -h -o mount.h mount.x
>    /lib/ld-linux-armhf.so.3: No such file or directory
>    /lib/ld-linux-armhf.so.3: No such file or directory
>    /lib/ld-linux-armhf.so.3: No such file or directory

Can you please provide how you reach this situation?

> Since e61775d1 ("rpcgen: bump to latest version") rpcgen is compiled
> with the target compiler, prior to that it was correctly compiled with
> the host compiler. Fix that by using $(CC_FOR_BUILD) as CC explicitly as
> it was before.
> 
> buildroot works around this by compiling a host version first, then a
> target version --with-rpcgen=$(HOST_DIR)/bin/rpcgen [1]. That does not
> look like it is intended by nfs-utils.

I find it correct since rpcgen is also a utility to be installed to 
target, so it should not be explictly built only for target and

> [1] https://git.busybox.net/buildroot/tree/package/nfs-utils/nfs-utils.mk#n25
> 
> Signed-off-by: Bastian Krause <bst@pengutronix.de>
> ---
>   tools/rpcgen/Makefile.am | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/rpcgen/Makefile.am b/tools/rpcgen/Makefile.am
> index 457cd507..f122cd9d 100644
> --- a/tools/rpcgen/Makefile.am
> +++ b/tools/rpcgen/Makefile.am
> @@ -1,5 +1,7 @@
>   CLEANFILES = *~
>   
> +CC=$(CC_FOR_BUILD)
> +

this is what you're forcing to. To cross compile it we need both rpcgen 
for host and target, this way it will be built for target only.

Another option I can suggest is to assign CC_FOR_BUILD to CC on caller 
Makefile only during target building and not during host building and 
this should be automatically deduced by Makefile itself and also 
Makefile then, when calls rpcgen should know which rpcgen to use(the 
host one). That would be one solution IMHO.

What do you think about it?

Best regards
-- 
Giulio Benetti
Benetti Engineering sas
