Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD8B82DA5
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 10:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfHFIY4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Aug 2019 04:24:56 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:14075 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728918AbfHFIY4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Aug 2019 04:24:56 -0400
X-IronPort-AV: E=Sophos;i="5.64,352,1559491200"; 
   d="scan'208";a="73061681"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 06 Aug 2019 16:24:53 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 9A2784CDFCCD;
        Tue,  6 Aug 2019 16:24:55 +0800 (CST)
Received: from [10.167.226.33] (10.167.226.33) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Tue, 6 Aug 2019 16:24:56 +0800
Subject: Re: [Problem]testOpenUpgradeLock test failed in nfsv4.0 in 5.2.0-rc7
From:   Su Yanjun <suyj.fnst@cn.fujitsu.com>
To:     <ffilzlnx@mindspring.com>
CC:     <linux-nfs@vger.kernel.org>, <dang@redhat.com>,
        <bfields@fieldses.org>, <calum.mackay@oracle.com>
References: <a4ff6e56-09d6-1943-8d71-91eaa418bd1e@cn.fujitsu.com>
 <f105f5a8-d38f-a58a-38d1-6b7a4df4dc9d@cn.fujitsu.com>
 <89d5612e-9af6-8f2e-15d8-ff6af29d508a@redhat.com>
 <016101d5359b$c71f06c0$555d1440$@mindspring.com>
 <4d6599c3-2280-e919-b60f-905f86452ac1@cn.fujitsu.com>
Message-ID: <399e7072-4aba-5018-66cb-052af8ba6ba7@cn.fujitsu.com>
Date:   Tue, 6 Aug 2019 16:23:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4d6599c3-2280-e919-b60f-905f86452ac1@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.33]
X-yoursite-MailScanner-ID: 9A2784CDFCCD.AFB09
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suyj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi, Frank

We modified the case according to Calum Mackay's suggestion (set the 
parameter lk_is_new in the second lock to FALSE)

and the test result passed.

But we don't know if this modification violates the test intent.

Can you tell us your test intent?

Because our email system has some problem  so i copy Calum Mackay's 
reply here.

From: Calum Mackay @ 2019-07-29 13:12 UTC (permalink / raw)
   To: Su Yanjun, J. Bruce Fields; +Cc: calum.mackay, linux-nfs, dang, 
ffilzlnx

hi, I don't think you would expect an unlock to delete the lock owner:
the client may want to do further locking with this lock owner (without
the lk_is_new bit set).

The server would delete the LO when the client sends a
RELEASE_LOCKOWNER, or when the lease is expired, if it doesn't.

cheers,
calum.

在 2019/7/9 13:27, Su Yanjun 写道:
> Hi Bruce
>
> 在 2019/7/8 22:45, Frank Filz 写道:
>> Yea, sorry, I totally missed this, but it does look like it's a 
>> Kernel nfsd
> Any suggestions?
>> issue.
>>
>> Frank
>>
>>> -----Original Message-----
>>> From: Daniel Gryniewicz [mailto:dang@redhat.com]
>>> Sent: Monday, July 8, 2019 6:49 AM
>>> To: Su Yanjun <suyj.fnst@cn.fujitsu.com>; ffilzlnx@mindspring.com
>>> Cc: linux-nfs@vger.kernel.org
>>> Subject: Re: [Problem]testOpenUpgradeLock test failed in nfsv4.0 in
>>> 5.2.0-rc7
>>>
>>> Is this running knfsd or Ganesha as the server?  If it's Ganesha, the
>>> question
>>> would be better asked on the Ganesha Devel list
>>> devel@lists.nfs-ganesha.org
>>>
>>> If it's knfsd, than Frank isn't the right person to ask.
> We are using the knfsd.
>>>
>>> Daniel
>>>
>>> On 7/7/19 10:20 PM, Su Yanjun wrote:
>>>> Ang ping?
>>>>
>>>> 在 2019/7/3 9:34, Su Yanjun 写道:
>>>>> Hi Frank
>>>>>
>>>>> We tested the pynfs of NFSv4.0 on the latest version of the kernel
>>>>> (5.2.0-rc7).
>>>>> I encountered a problem while testing st_lock.testOpenUpgradeLock.
>>>>> The problem is now as follows:
>>>>> **************************************************
>>>>> LOCK24 st_lock.testOpenUpgradeLock : FAILURE
>>>>>             OP_LOCK should return NFS4_OK, instead got
>>>>>             NFS4ERR_BAD_SEQID
>>>>> **************************************************
>>>>> Is this normal?
>>>>>
>>>>> The case is as follows:
>>>>> Def testOpenUpgradeLock(t, env):
>>>>>      """Try open, lock, open, downgrade, close
>>>>>
>>>>>      FLAGS: all lock
>>>>>      CODE: LOCK24
>>>>>      """
>>>>>      c= env.c1
>>>>>      C.init_connection()
>>>>>      Os = open_sequence(c, t.code, lockowner="lockowner_LOCK24")
>>>>>      Os.open(OPEN4_SHARE_ACCESS_READ)
>>>>>      Os.lock(READ_LT)
>>>>>      Os.open(OPEN4_SHARE_ACCESS_WRITE)
>>>>>      Os.unlock()
>>>>>      Os.downgrade(OPEN4_SHARE_ACCESS_WRITE)
>>>>>      Os.lock(WRITE_LT)
>>>>>      Os.close()
>>>>>
>>>>> After investigation, there was an error in unlock->lock. When
>>>>> unlocking, the lockowner of the file was not released, causing an
>>>>> error when locking again.
>>>>> Will nfs4.0 support 1) open-> 2) lock-> 3) unlock-> 4) lock this
>>>>> function?
>>>>>
>>>>>
>>>>>
>>>>
>>
>>
>
>


