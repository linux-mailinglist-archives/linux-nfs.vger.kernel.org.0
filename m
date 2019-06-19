Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 580F74BA17
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2019 15:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfFSNiK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jun 2019 09:38:10 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7500 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFSNiK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jun 2019 09:38:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0a3ac00000>; Wed, 19 Jun 2019 06:38:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 19 Jun 2019 06:38:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 19 Jun 2019 06:38:09 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Jun
 2019 13:38:07 +0000
Subject: Re: [REGRESSION v5.2-rc] SUNRPC: Declare RPC timers as
 TIMER_DEFERRABLE (431235818bc3)
To:     Anna Schumaker <schumaker.anna@gmail.com>,
        Trond Myklebust <trondmy@hammerspace.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <c54db63b-0d5d-2012-162a-cb08cf32245a@nvidia.com>
 <b2c142996bc25aff51a197db52015bf9222139fe.camel@hammerspace.com>
 <36e34e81-8399-be71-2dd6-399d70057657@nvidia.com>
 <313d971a-96ab-c7f0-34f5-631bb5f39e49@nvidia.com>
 <7d335b53c9878865cef1de83960701c0ece4e611.camel@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <2aee35b5-f0f9-aac3-8957-01ebd4930f3b@nvidia.com>
Date:   Wed, 19 Jun 2019 14:38:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7d335b53c9878865cef1de83960701c0ece4e611.camel@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560951488; bh=Zel5PYiYMkDYLwsNuzJEpvObHIvYkHUd09Lf/adG/yM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Xlz/uZM4adV3CMJ2Q2GjznojRjrjLRj7gzMBcVtIbZ2TZWbmrz+8lRamQIJNNmfev
         z0709eHqvESiXyp2D8fPJYr2AatULJMLW4wsWDSK+pj7yNvp8ith2ew6YGQosz2QH/
         L+CFPjkV9T9ywF38l/hAuxiU05GL8oXoavte3jdiWMAFtzMokXfI+bOcPC6y15K3Qh
         DDjFreMGC8MhMIKpL7rwRMxOr8bDdBDnvOhOf1r1SDN6ybnyNJRKz3A/fbXV2CxySF
         yZKO9IO59VPts0MSoQ2dVZvx3vuxeDieLLY45/Y1ylqPF8Yie/XjX/b/gNgongrOJd
         8MfM79AK0+spQ==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 18/06/2019 21:18, Anna Schumaker wrote:
> 
> On Tue, 2019-06-18 at 10:35 +0100, Jon Hunter wrote:
>> Trond, Anna,
>>
>> On 12/06/2019 15:23, Jon Hunter wrote:
>>> On 05/06/2019 23:01, Trond Myklebust wrote:
>>>
>>> ...
>>>
>>>> I'd be OK with just reverting this patch if it is causing a
>>>> performance
>>>> issue.
>>>>
>>>> Anna?
>>>
>>> Any update on this?
>>
>> I have not seen any update on this. Do you plan to revert this?
>>
>> We are getting ever closer to v5.2 and this problem still persists.
> 
> Hi Jon,
> 
> Sorry it took me so long to see this. I've applied the revert and
> pushed it out to my linux-next branch. I'm planning to send it with
> some other bugfixes this week.
Thanks Anna!

Jon
-- 
nvpublic
