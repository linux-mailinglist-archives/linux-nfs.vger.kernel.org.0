Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 718E01A324
	for <lists+linux-nfs@lfdr.de>; Fri, 10 May 2019 20:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfEJStS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 May 2019 14:49:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727622AbfEJStS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 10 May 2019 14:49:18 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2049A307D852;
        Fri, 10 May 2019 18:49:18 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-27.phx2.redhat.com [10.3.116.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA1AF1000320;
        Fri, 10 May 2019 18:49:17 +0000 (UTC)
Subject: Re: [PATCH] nfs-utils: nfsidmap fail to build if no --with-pluginpath
 specified
To:     Yongcheng Yang <yongcheng.yang@gmail.com>
Cc:     linux-nfs@vger.kernel.org
References: <20190402091651.17186-1-yongcheng.yang@gmail.com>
 <95e49187-6d99-4168-1bb1-4a3f6f2500ee@RedHat.com>
 <20190417092246.GA5865@yoyang-pc.usersys.redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <6c2d66ec-a098-72d6-42ab-15c3baa06f30@RedHat.com>
Date:   Fri, 10 May 2019 14:49:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417092246.GA5865@yoyang-pc.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 10 May 2019 18:49:18 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/17/19 5:22 AM, Yongcheng Yang wrote:
> Hi SteveD,
> 
> On Tue, Apr 16, 2019 at 10:34:51AM -0400, Steve Dickson wrote:
>> The only way I see a failure is when ./configure --with-pluginpath= 
>> without a path which is wrong... 
>>
>> ./configure --with-pluginpath=/usr/lib/libnfsidmap seems to work
>> just fine
>>
>> I thinking it is better to error out when a path is not given
>> then to gloss over but used a default.
>>
>> steved.
>>
> 
> From what you comments, there should be a plugin path assigned by
> default if the user is not aware of it, correct?
> 
> Surely "./configure --with-pluginpath=/usr/lib/libnfsidmap" can work.
> But I didn't know the specific exact path before.
> 
> I was just using "./configure" without any options and find out that
> it's empty. (Please find my previous full logs)
> 
> Agree with you we should "use a default" one when path is not given.
Change of mind.... I think the patch is good... 

Committed! thanks!!

steved.
> 
> Thanks,
> Yongcheng
> 
