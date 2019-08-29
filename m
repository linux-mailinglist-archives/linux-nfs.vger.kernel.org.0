Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1551CA1F33
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2019 17:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfH2PbE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 29 Aug 2019 11:31:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727374AbfH2PbE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 29 Aug 2019 11:31:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 03EF0C059B7A;
        Thu, 29 Aug 2019 15:31:04 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-112-84.rdu2.redhat.com [10.10.112.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C124D19C4F;
        Thu, 29 Aug 2019 15:31:01 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "kbuild test robot" <lkp@intel.com>
Cc:     kbuild-all@01.org, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] freezer,NFS: add an unsafe schedule_timeout_interruptable
 freezable helper for NFS
Date:   Thu, 29 Aug 2019 11:30:59 -0400
Message-ID: <3BADDECB-E1BB-4970-89C1-11AE4A27EF19@redhat.com>
In-Reply-To: <201908291805.HOQuJYMY%lkp@intel.com>
References: <9cf306ec17800f909f44a3889f52c6818b56bdbb.1566992889.git.bcodding@redhat.com>
 <201908291805.HOQuJYMY%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 29 Aug 2019 15:31:04 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks robot!

I'll send a v2 that works with !CONFIG_FREEZER.

Ben

On 29 Aug 2019, at 7:02, kbuild test robot wrote:

> Hi Benjamin,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3-rc6 next-20190828]
> [if your patch is applied to the wrong git tree, please drop us a note 
> to help improve the system]
>
> url:    
> https://github.com/0day-ci/linux/commits/Benjamin-Coddington/freezer-NFS-add-an-unsafe-schedule_timeout_interruptable-freezable-helper-for-NFS/20190829-161623
> config: x86_64-randconfig-f004-201934 (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-11) 7.4.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    fs/nfs/nfs4proc.c: In function 'nfs4_delay_interruptible':
>>> fs/nfs/nfs4proc.c:418:2: error: implicit declaration of function 
>>> 'freezable_schedule_timeout_interruptible_unsafe'; did you mean 
>>> 'freezable_schedule_timeout_interruptible'? 
>>> [-Werror=implicit-function-declaration]
>      freezable_schedule_timeout_interruptible_unsafe(nfs4_update_delay(timeout));
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      freezable_schedule_timeout_interruptible
>    cc1: some warnings being treated as errors
>
> vim +418 fs/nfs/nfs4proc.c
>
>    413	
>    414	static int nfs4_delay_interruptible(long *timeout)
>    415	{
>    416		might_sleep();
>    417	
>> 418		freezable_schedule_timeout_interruptible_unsafe(nfs4_update_delay(timeout));
>    419		if (!signal_pending(current))
>    420			return 0;
>    421		return __fatal_signal_pending(current) ? -EINTR :-ERESTARTSYS;
>    422	}
>    423	
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology 
> Center
> https://lists.01.org/pipermail/kbuild-all                   Intel 
> Corporation
