Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12C26A51E7
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Sep 2019 10:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbfIBIhY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Sep 2019 04:37:24 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:39773 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729780AbfIBIhX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Sep 2019 04:37:23 -0400
X-IronPort-AV: E=Sophos;i="5.64,457,1559491200"; 
   d="scan'208";a="74694167"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 02 Sep 2019 16:37:21 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id EF1ED4CE0C9C;
        Mon,  2 Sep 2019 16:37:20 +0800 (CST)
Received: from [10.167.226.33] (10.167.226.33) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Mon, 2 Sep 2019 16:37:25 +0800
Subject: Re: NFS issues about aio and dio test
To:     "J. Bruce Fields" <bfields@fieldses.org>
CC:     <linux-nfs@vger.kernel.org>, <cuiyue-fnst@cn.fujitsu.com>
References: <975395cc-62f2-843f-cc71-82339b2869cd@cn.fujitsu.com>
 <65ea4ea2-548f-1546-059a-af901bba2e87@cn.fujitsu.com>
 <20190828172849.GA29148@fieldses.org>
From:   Su Yanjun <suyj.fnst@cn.fujitsu.com>
Message-ID: <25e5e2a0-c95a-acd7-04da-d48e8400efe3@cn.fujitsu.com>
Date:   Mon, 2 Sep 2019 16:37:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190828172849.GA29148@fieldses.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.33]
X-yoursite-MailScanner-ID: EF1ED4CE0C9C.ADE0B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suyj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


在 2019/8/29 1:28, J. Bruce Fields 写道:
> On Mon, Aug 26, 2019 at 08:37:41AM +0800, Su Yanjun wrote:
>> Any ping?
>>
>> 在 2019/8/6 14:08, Su Yanjun 写道:
>>> Hi,
>>>
>>> When I tested xfstests generic/465 with NFS, there was something
>>> unexpected.
>>>
>>> When memory of NFS server was 10G, test passed.
>>> But when memory of NFS server was 4G, test failed.
>>>
>>> Fail message was as below.
>>>      non-aio dio test
>>>      encounter an error: block 4 offset 0, content 62
>>>      aio-dio test
>>>      encounter an error: block 1 offset 0, content 62
>>>
>>> All of the NFS versions(v3 v4.0 v4.1 v4.2) have  this problem.
>>> Maybe something is wrong about NFS's I/O operation.
>>>
>>> Thanks in advance.
> Off the top of my head it doesn't look familiar.
>
> What kernel version are you running on client and server?
client:4.18
server:4.18 (latest version:5.3.0-rc6+ also has this problem)
>
> Did this test previously pass on an older kernel (so, was this a recent
> regression?)
This test previously passed on 3.10 kernel.
> Have you looked at generic/465 to see what exactly is happening here?

generic/465 tests for  aio and dio function.

The memory usage is very low for th test case.

Not quite like a memory problem.

>
> --b.
>
Thanks in advance.

su



