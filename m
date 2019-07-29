Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58A1A786B0
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2019 09:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfG2Huy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jul 2019 03:50:54 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:11694 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726717AbfG2Huy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jul 2019 03:50:54 -0400
X-IronPort-AV: E=Sophos;i="5.64,321,1559491200"; 
   d="scan'208";a="72426416"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Jul 2019 15:50:51 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 9723E4CDE889;
        Mon, 29 Jul 2019 15:50:52 +0800 (CST)
Received: from [10.167.226.33] (10.167.226.33) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Mon, 29 Jul 2019 15:50:54 +0800
Subject: Re: [Problem]testOpenUpgradeLock test failed in nfsv4.0 in 5.2.0-rc7
From:   Su Yanjun <suyj.fnst@cn.fujitsu.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
CC:     <linux-nfs@vger.kernel.org>, <dang@redhat.com>,
        <ffilzlnx@mindspring.com>
References: <a4ff6e56-09d6-1943-8d71-91eaa418bd1e@cn.fujitsu.com>
 <f105f5a8-d38f-a58a-38d1-6b7a4df4dc9d@cn.fujitsu.com>
 <89d5612e-9af6-8f2e-15d8-ff6af29d508a@redhat.com>
 <016101d5359b$c71f06c0$555d1440$@mindspring.com>
 <4d6599c3-2280-e919-b60f-905f86452ac1@cn.fujitsu.com>
 <20190710000855.GE1536@fieldses.org>
 <b5ec42ea-7f50-0920-5794-32c379681225@cn.fujitsu.com>
Message-ID: <b9fa5b22-b2fb-b96f-d943-7ad3f00e16bb@cn.fujitsu.com>
Date:   Mon, 29 Jul 2019 15:49:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <b5ec42ea-7f50-0920-5794-32c379681225@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.33]
X-yoursite-MailScanner-ID: 9723E4CDE889.AC812
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suyj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Any ping?

在 2019/7/12 10:27, Su Yanjun 写道:
>
> 在 2019/7/10 8:08, J. Bruce Fields 写道:
>> On Tue, Jul 09, 2019 at 01:27:31PM +0800, Su Yanjun wrote:
>>> Hi Bruce
>>>
>>> 在 2019/7/8 22:45, Frank Filz 写道:
>>>> Yea, sorry, I totally missed this, but it does look like it's a 
>>>> Kernel nfsd
>>> Any suggestions?
>>>> issue.
>> I don't know.  I'd probably want to check a packet trace first to make
>> completely sure I understand what's happening on the wire.  It may be a
>> couple weeks before I get to this.
>
> We capture the packets in attachment.
>
> Through packet capture analysis, there is a parameter *new lock owner* 
> related.
>
> When locking, if lock->lk_is_new is true (create new lock owner), it 
> will check lock owner's existence.
>
> Below is the execution path.
>
> nfsd4_lock:
>  if(lock->lk_is_new)
>    lstatus = lookup_or_create_lock_state(cstate, open_stp, lock, 
> &lock_stp, &new);
>
> lookup_or_create_lock_state:
>  lo = find_lockowner_str(cl, &lock->lk_new_owner);
>  if(!lo) {
>  ...
>  } else {
>     status = nfserr_bad_seqid;
>  }
>
> find_lockowner_str will check lock owner from  hash table.
>
> In this case unlock doesnot delete existed lock owner from hash table 
> so when lock again it
> returns error.
>
> So my question is
> 1. Does each lock always need new lock owner?
> 2. In this case, unlock doesnot delete lock owner from hash table, is 
> it normal?
>
> Thanks
>
>> --b.
>>
>>>> Frank
>>>>
>>>>> -----Original Message-----
>>>>> From: Daniel Gryniewicz [mailto:dang@redhat.com]
>>>>> Sent: Monday, July 8, 2019 6:49 AM
>>>>> To: Su Yanjun <suyj.fnst@cn.fujitsu.com>; ffilzlnx@mindspring.com
>>>>> Cc: linux-nfs@vger.kernel.org
>>>>> Subject: Re: [Problem]testOpenUpgradeLock test failed in nfsv4.0 in
>>>>> 5.2.0-rc7
>>>>>
>>>>> Is this running knfsd or Ganesha as the server?  If it's Ganesha, the
>>>>> question
>>>>> would be better asked on the Ganesha Devel list
>>>>> devel@lists.nfs-ganesha.org
>>>>>
>>>>> If it's knfsd, than Frank isn't the right person to ask.
>>> We are using the knfsd.
>>>>> Daniel
>>>>>
>>>>> On 7/7/19 10:20 PM, Su Yanjun wrote:
>>>>>> Ang ping?
>>>>>>
>>>>>> 在 2019/7/3 9:34, Su Yanjun 写道:
>>>>>>> Hi Frank
>>>>>>>
>>>>>>> We tested the pynfs of NFSv4.0 on the latest version of the kernel
>>>>>>> (5.2.0-rc7).
>>>>>>> I encountered a problem while testing st_lock.testOpenUpgradeLock.
>>>>>>> The problem is now as follows:
>>>>>>> **************************************************
>>>>>>> LOCK24 st_lock.testOpenUpgradeLock : FAILURE
>>>>>>>             OP_LOCK should return NFS4_OK, instead got
>>>>>>>             NFS4ERR_BAD_SEQID
>>>>>>> **************************************************
>>>>>>> Is this normal?
>>>>>>>
>>>>>>> The case is as follows:
>>>>>>> Def testOpenUpgradeLock(t, env):
>>>>>>>      """Try open, lock, open, downgrade, close
>>>>>>>
>>>>>>>      FLAGS: all lock
>>>>>>>      CODE: LOCK24
>>>>>>>      """
>>>>>>>      c= env.c1
>>>>>>>      C.init_connection()
>>>>>>>      Os = open_sequence(c, t.code, lockowner="lockowner_LOCK24")
>>>>>>>      Os.open(OPEN4_SHARE_ACCESS_READ)
>>>>>>>      Os.lock(READ_LT)
>>>>>>>      Os.open(OPEN4_SHARE_ACCESS_WRITE)
>>>>>>>      Os.unlock()
>>>>>>>      Os.downgrade(OPEN4_SHARE_ACCESS_WRITE)
>>>>>>>      Os.lock(WRITE_LT)
>>>>>>>      Os.close()
>>>>>>>
>>>>>>> After investigation, there was an error in unlock->lock. When
>>>>>>> unlocking, the lockowner of the file was not released, causing an
>>>>>>> error when locking again.
>>>>>>> Will nfs4.0 support 1) open-> 2) lock-> 3) unlock-> 4) lock this
>>>>>>> function?
>>>>>>>
>>>>>>>
>>>>>>>
>>>>
>>


