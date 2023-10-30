Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FACD7DB5B5
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Oct 2023 10:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjJ3JEs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Oct 2023 05:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjJ3JEr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Oct 2023 05:04:47 -0400
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075438E
        for <linux-nfs@vger.kernel.org>; Mon, 30 Oct 2023 02:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1698656682;
        bh=ZhE+CD+PFFkaMQgkCpRSYAr7MYqynTL7F2DfFOYy3M8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ln0ay/kSqR4Tr9bUvxSpgAsr90rRYLy21aOebqHxYKDnp76GZRzk5RQNXTmDQryhM
         emR4J70jvxru1dLM8i65VtvKhOH510aSlUPN7MfpzWKKR+53GeNdgR0N3nSyqa0vir
         g8j6tkZYgHbRce9R6pFnuIxYBNUrtIe7rzOMDfEw=
Received: from [192.168.31.137] ([116.128.244.171])
        by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
        id 1249027A; Mon, 30 Oct 2023 17:04:36 +0800
X-QQ-mid: xmsmtpt1698656676tuwsmerlk
Message-ID: <tencent_21E20176E2E5AB7C33CB5E67F10D02763508@qq.com>
X-QQ-XMAILINFO: NQe7ZYgbEKZdLmfQpk9WrFYRO4suKXU1l6Ji1+1Js18z/sq4NnYqoS+2nEYhSJ
         VAuBBa/j0vL63GRAK0dg0G4RZVm1sLsBv1xikmFzrKsLPilA7q4aHxIydVT72tTbkSm8uM6T1Xdz
         sWGNoEMHafyL19Nz2iHiv61Qgxcdr6q0kgRr5R6v/nPi8kwsp/0g4jZlTc835LMmIe05e0hagSo8
         fQrSXpCtcOsheoB4lmZsow/cGCqws4f8iVHkztr5ywy5oT8foolLLUDJChO5H8hD7zZgi1tvLBEq
         MkuD29TPW/o5knX9ZGjkuvURn97Vegb0Ps2tJjOvfJDcKUa+h4BQK5w6k9AasM74s9006gdvug2o
         H7WdzAg3UfWlBDNkOlkwhT0pWnY21U8toQX1sCdGshsvEyjBqbkLhMZNCoSj+UbxUup4xTtGUQ2d
         X3EaO9AMDCtGdUGmwDpkO29iE8soG5MgPzqCs/z0KQJPO0Fvlo377YFjvtj6pe4PYd8+AMAW/5fh
         VJhaeYoY6Vk1y42oh/CC3VnLmclUB05lljxvnKlMIJZoqDbHI089chOD8dlfvZU6uxFvb6I1n0Zy
         fdclU4M/K0moPdc4QkZ5WHNQIcTF00LifX0CztHQydw35wb8f3gsQOrIayBbE22JiRDqZTDqmdAv
         Ks+NTVxq6+Xka5yCncf8uhALz2Si79leobCzokpFpDL0hwaQiu+i4aTY4Ko/zo60bYUonqo14v+Q
         6u70LRph3MG/i1GmbztXDQY1vHIapkV9HkQCYQ5OtT3pWrozssLYOYdwaMAR63sifBqHl8v0E0UH
         B01pNmF5KqHmSHdY8cXBzelVqD2poi1itGvuCsgUcTEeax/J6GMN+FlOFUTEDBDfE8kfZ39LtOkY
         MAWCf6rOMVRSIjioVM9kzh9U9CU+YVyQiXcB5CefL50zLkbfSyJHM5UongWBQqpt5LJIww7soKXX
         57OBzi/qAhGOoLVjrh1W4z8FlPS26/HDXz418oAy0v+Zlejs1sQ8xa9q9een1r2RcwB3S5V2Rp/L
         x3uWHaX2NgonuAuYW7b08iULZUu/ajPs4x5dh1SIOcMGwr+cfH
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-OQ-MSGID: <f1d58cf9-0076-47a3-b101-06058d9654c0@foxmail.com>
Date:   Mon, 30 Oct 2023 17:04:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about LTS 4.19 patch "89047634f5ce NFS: Don't interrupt
 file writeout due to fatal errors"
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        trond.myklebust@hammerspace.com
Cc:     chenxiaosong@kylinos.cn, Anna.Schumaker@netapp.com,
        sashal@kernel.org, liuzhengyuan@kylinos.cn, huangjinhui@kylinos.cn,
        liuyun01@kylinos.cn, huhai@kylinos.cn, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <tencent_BEDA418B8BD86995FBF3E92D4F9F5D342C0A@qq.com>
 <2023103055-anaerobic-childhood-c1f1@gregkh>
 <tencent_4CA081DD6E435CDA2EAB9C826F7899F78C05@qq.com>
 <2023103055-saddled-payer-bd26@gregkh>
From:   ChenXiaoSong <chenxiaosongemail@foxmail.com>
In-Reply-To: <2023103055-saddled-payer-bd26@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 2023/10/30 16:58, Greg KH wrote:
> If you just revert that one patch, is the issue resolved?  And what
> about other stable releases that have that change in it?
>
> If this does need to be reverted, please submit a patch that does so and
> we can review it that way.
>
> thanks,
>
> greg k-h


In my opinion, this patch is not for fixing a bug, but is part of a 
refactoring patchset. The 'Fixes:' tag should not be added.


