Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC3C7DB5F6
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Oct 2023 10:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjJ3JPw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Oct 2023 05:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjJ3I5p (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Oct 2023 04:57:45 -0400
X-Greylist: delayed 214 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Oct 2023 01:57:42 PDT
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C31694
        for <linux-nfs@vger.kernel.org>; Mon, 30 Oct 2023 01:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1698656260;
        bh=YL3oMrHvLLHmTWBOYlwZjV1439I387W9eHucJaKOZmE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=R2O+DdUaXZZmnPO03V5y57WtldAjq6TxNDZcx2c69zaIaRT7dgL8iZywvy9M7fLCR
         21JDGs5xiQgxjl2Axi7PWwQhCmSFiPa1hIMt54FN6vDT9soQZBwb8Xdz3o2Kvkhart
         f9Euf+F6eaZlrorbyFRWV2EXLT3jSBUHuH29RM7o=
Received: from [192.168.31.137] ([116.128.244.171])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id D828F086; Mon, 30 Oct 2023 16:54:02 +0800
X-QQ-mid: xmsmtpt1698656042tbvnfg6pq
Message-ID: <tencent_4CA081DD6E435CDA2EAB9C826F7899F78C05@qq.com>
X-QQ-XMAILINFO: MuA+oTsEL+6qtO3H4xWQPCso6pV/I/yJkvKbmlvufrMvIKLO9vdahjdohO9J+t
         2BhmIBOfWO2/tauGOmKA0HagbvXagy1Ql+cjmOWLEUJUqjamxnOm3PXltm7836EvTWUaOObks+u6
         ukJD3mzcbtXjlyDLeZWxQpQP3nOamk61cbLG301Fu09yvG9I4gmFoamyQFJFb4W6EcO+YXRlKvAi
         HCVNRenqgGcw/IWXF0bJAuvcOo+BBCWCp4BGqabhXvq63rP2gy10bTE1NH745+OD+P161tQU8l+A
         LjPYnUB4hPoPrMUit5xAtLJ5oL35AvcDTDRXFDpseN90ac8xUBH/0VHYmQGIkU3u7ikzzy8YieAn
         2l3kuv5uaOcvik40weCVd8TKZaDRYmxFAyhdoTzjd4/pwpU+KfEyTQF6nsi/kEsKdEYWBD3KAP+9
         ox/hefgXMiFH8IgdCogqHb88VLrEciI1QyRZjOM9O9E5QRiSoix9XOs+jVy621ggz8WlhDKu1KAD
         Wx12+Y91QvmqVfhW5JD6P2a8JV8M8k4yz9jwglEcsMh+46pAKmoTRTrKnC3Cw1GA+UCbaQpJCKp5
         mdPWDtJlT18R6rF7SmztDVMaBjy51CNT+DsoajJZ0tCUoZbjxxjENf0qOeTu2c8BzNbUpZ6qbpx4
         awL32/3pH28MrzmAATL2bM1P23vJ2FSK46OkjKalWnptr8uczT02eF7UxxgyPFs9e/IlETLe/C4U
         K5+GVo+hfyPISorfj8iXTAzOwW2Bcw3mh9K9t7g7G/a0B6am45tFEwFarPuvi7OREIQ4o9iaBwp+
         8cUbjg099/1ohJm6bBd3s1LSq6fe16pYHDkkzDr6FKeVNhCI0s5evx13VmhfISEhukFQh2BcG8Cm
         ayhaU7Kqpuh563i5iBhM+fNj9gyWh/U/q0uVTverV2YM4cvlHvGTEyqrXkaYjuHTp1uiteWJyaqx
         //oXLTm5Xvc9UJIAz77bYGnvFDH01GU3xPi7QTzFfPmH6HcSA60vpmS+/vi0zHwpc+phVrvjFL4k
         W1HZPx+Pbqd2JbcXWs
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-OQ-MSGID: <5e3bb5bf-b298-4666-b476-a3758c2245f4@foxmail.com>
Date:   Mon, 30 Oct 2023 16:54:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about LTS 4.19 patch "89047634f5ce NFS: Don't interrupt
 file writeout due to fatal errors"
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     trond.myklebust@hammerspace.com, chenxiaosong@kylinos.cn,
        Anna.Schumaker@netapp.com, sashal@kernel.org,
        liuzhengyuan@kylinos.cn, huangjinhui@kylinos.cn,
        liuyun01@kylinos.cn, huhai@kylinos.cn, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <tencent_BEDA418B8BD86995FBF3E92D4F9F5D342C0A@qq.com>
 <2023103055-anaerobic-childhood-c1f1@gregkh>
From:   ChenXiaoSong <chenxiaosongemail@foxmail.com>
In-Reply-To: <2023103055-anaerobic-childhood-c1f1@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2023/10/30 16:43, Greg KH wrote:
> Try it and see, but note, that came from the 4.19.99 release which was
> released years ago, are you sure you are using the most recent 4.19.y
> release?

I use the most recent release 1b540579cf66 Linux 4.19.296.

> If we missed some patches, that should be added on top of the current
> tree, please let us know the git commit ids of them after you have
> tested them that they work properly, and we will gladly apply them.
Merging the entire patchset may not be the best option. Perhaps a better 
choice is to revert this patch. And I would like to see Trond's suggestion.

