Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4C6B428C2
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2019 16:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406333AbfFLOXp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Jun 2019 10:23:45 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14351 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfFLOXp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Jun 2019 10:23:45 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d010aed0001>; Wed, 12 Jun 2019 07:23:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 12 Jun 2019 07:23:44 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 12 Jun 2019 07:23:44 -0700
Received: from [10.21.132.143] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 12 Jun
 2019 14:23:42 +0000
Subject: Re: [REGRESSION v5.2-rc] SUNRPC: Declare RPC timers as
 TIMER_DEFERRABLE (431235818bc3)
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <c54db63b-0d5d-2012-162a-cb08cf32245a@nvidia.com>
 <b2c142996bc25aff51a197db52015bf9222139fe.camel@hammerspace.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <36e34e81-8399-be71-2dd6-399d70057657@nvidia.com>
Date:   Wed, 12 Jun 2019 15:23:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <b2c142996bc25aff51a197db52015bf9222139fe.camel@hammerspace.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560349421; bh=N5MzEerQSEvD2TnbxfmlJKEEgNNcq60nOgCTwn1HUfY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jKAjTw51G219XqRyB0ZJa7GBqFnXZ9/IObybwBeg3h50DbhSjH6ZrIk4o1BaspG6L
         i16DYLhk2AZyasU+tAEDGlAHlmBEp39qus6gMP8gii6WR7p9+6AMtzs5F2zqkSCYZm
         qS3kmVRviJz0g2HUoJHrsSAOIpXJQ9OMtSSFX4j/PkS2Sj5bFOBcQ4VRZqt3WlLIHR
         NRvjAOXTSa3BHWDZ22CKSB0Yd5W6YDGTD9E0GV8QTM6sLh8fYahOb4AoaSsq4N4cTc
         s7cq32cGYC5BlkIok1SnSAbS/4+aETpMRp8+dQ05HODpeyjwJCG8YlbDn2fFw4TZqf
         K4s34cT0zT0nw==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 05/06/2019 23:01, Trond Myklebust wrote:

...

> I'd be OK with just reverting this patch if it is causing a performance
> issue.
> 
> Anna?

Any update on this?

Thanks
Jon

-- 
nvpublic
