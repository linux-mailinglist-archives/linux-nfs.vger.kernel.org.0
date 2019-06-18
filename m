Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1296549D7E
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2019 11:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbfFRJgC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jun 2019 05:36:02 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1716 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729220AbfFRJfx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jun 2019 05:35:53 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d08b0770000>; Tue, 18 Jun 2019 02:35:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Jun 2019 02:35:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Jun 2019 02:35:51 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 09:35:50 +0000
Subject: Re: [REGRESSION v5.2-rc] SUNRPC: Declare RPC timers as
 TIMER_DEFERRABLE (431235818bc3)
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <c54db63b-0d5d-2012-162a-cb08cf32245a@nvidia.com>
 <b2c142996bc25aff51a197db52015bf9222139fe.camel@hammerspace.com>
 <36e34e81-8399-be71-2dd6-399d70057657@nvidia.com>
Message-ID: <313d971a-96ab-c7f0-34f5-631bb5f39e49@nvidia.com>
Date:   Tue, 18 Jun 2019 10:35:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <36e34e81-8399-be71-2dd6-399d70057657@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560850551; bh=gmPASSDC4uoc0HbBKNt0VSxSXOUtihxve4bKmdPsrtg=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=dtpV/T+wwkjEmXbO6OK1IliRMihdjFngqZ9ia8G9SXyBcM5124mdqI35QjYIqFJ7F
         FhWV496FEUWtAe+m3cQqKXgGIysM+S5vAw1MPh02UEuttH+lnhIEeIrmNUdi9dyShs
         /HUo2bbWelHPAeabK1lsQZdhUfTHqcAz3Yo6LQuhyyNXoc+b8UEZSIsbJ9kZ7V72/h
         OB7qyShRcDQgVWlfObw8llxmoCVMJbcp+zvRZFnAWFKV+A6XMlw6j8554b84HjW/FT
         UDNPmTDiDczy8VOlwcRVBmRE2+pJW4h44ejobSFcWrP3DKzcvutxstkJaN9rs2cFZi
         jB5WTc1e1XV0g==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond, Anna,

On 12/06/2019 15:23, Jon Hunter wrote:
> 
> On 05/06/2019 23:01, Trond Myklebust wrote:
> 
> ...
> 
>> I'd be OK with just reverting this patch if it is causing a performance
>> issue.
>>
>> Anna?
> 
> Any update on this?

I have not seen any update on this. Do you plan to revert this?

We are getting ever closer to v5.2 and this problem still persists.

Thanks
Jon

-- 
nvpublic
