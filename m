Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3F5578C6A
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2019 15:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfG2NNQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jul 2019 09:13:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60004 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388007AbfG2NNP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jul 2019 09:13:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6TCuWxi051475;
        Mon, 29 Jul 2019 13:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc : subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=gAHBWgHOnFG1h0lPnHsXqzUw14HHskyzWOjyAGzAelE=;
 b=jmL9fmHXvIDJtk6BQzI5zFCJSL88lbJdmZOIfvovDMe49imOYdiTKucf2uy/YDvJUMQb
 j6YcI5OjUdMRoej6GTM7H9bAYlWJx9sh7qYcmjMqzRaHEjXE+yU6iuw4NVlSwDoudcA/
 s1nc0pbMVgtqFyvt5pW0Og6sWsscVnSEak14knfNVt7xrNFUwiTba7PBFA2MMlG0P96U
 tL37ohmEi7rJ70jiqkRQhTVM0r9xC6IIurd0SjNKBPGtVRQL9dYxlp1WRWCv/QPsKTFs
 ZRLsP22zHEUyTvp8JEgvNDqfvv38yIkd3xncAyx7SekkwUprXrjUenclKOkBrFc74+Ka 7w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2u0ejp7857-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jul 2019 13:12:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6TDCZ1L157510;
        Mon, 29 Jul 2019 13:12:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2u0bqtfamr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jul 2019 13:12:50 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6TDCldh004307;
        Mon, 29 Jul 2019 13:12:47 GMT
Received: from mbp2018.cdmnet.org (/82.27.120.181)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Jul 2019 06:12:47 -0700
Cc:     calum.mackay@oracle.com, linux-nfs@vger.kernel.org,
        dang@redhat.com, ffilzlnx@mindspring.com
Subject: Re: [Problem]testOpenUpgradeLock test failed in nfsv4.0 in 5.2.0-rc7
To:     Su Yanjun <suyj.fnst@cn.fujitsu.com>,
        "J. Bruce Fields" <bfields@fieldses.org>
References: <a4ff6e56-09d6-1943-8d71-91eaa418bd1e@cn.fujitsu.com>
 <f105f5a8-d38f-a58a-38d1-6b7a4df4dc9d@cn.fujitsu.com>
 <89d5612e-9af6-8f2e-15d8-ff6af29d508a@redhat.com>
 <016101d5359b$c71f06c0$555d1440$@mindspring.com>
 <4d6599c3-2280-e919-b60f-905f86452ac1@cn.fujitsu.com>
 <20190710000855.GE1536@fieldses.org>
 <b5ec42ea-7f50-0920-5794-32c379681225@cn.fujitsu.com>
 <b9fa5b22-b2fb-b96f-d943-7ad3f00e16bb@cn.fujitsu.com>
From:   Calum Mackay <calum.mackay@oracle.com>
Organization: Oracle
Message-ID: <66672c03-081f-80a3-94ef-6327079cd7d8@oracle.com>
Date:   Mon, 29 Jul 2019 14:12:44 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:70.0)
 Gecko/20100101 Thunderbird/70.0a1
MIME-Version: 1.0
In-Reply-To: <b9fa5b22-b2fb-b96f-d943-7ad3f00e16bb@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9332 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907290153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9332 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907290152
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

hi, I don't think you would expect an unlock to delete the lock owner: 
the client may want to do further locking with this lock owner (without 
the lk_is_new bit set).

The server would delete the LO when the client sends a 
RELEASE_LOCKOWNER, or when the lease is expired, if it doesn't.

cheers,
calum.

On 29/07/2019 8:49 am, Su Yanjun wrote:
> Any ping?
> 
> 在 2019/7/12 10:27, Su Yanjun 写道:
>>
>> 在 2019/7/10 8:08, J. Bruce Fields 写道:
>>> On Tue, Jul 09, 2019 at 01:27:31PM +0800, Su Yanjun wrote:
>>>> Hi Bruce
>>>>
>>>> 在 2019/7/8 22:45, Frank Filz 写道:
>>>>> Yea, sorry, I totally missed this, but it does look like it's a 
>>>>> Kernel nfsd
>>>> Any suggestions?
>>>>> issue.
>>> I don't know.  I'd probably want to check a packet trace first to make
>>> completely sure I understand what's happening on the wire.  It may be a
>>> couple weeks before I get to this.
>>
>> We capture the packets in attachment.
>>
>> Through packet capture analysis, there is a parameter *new lock owner* 
>> related.
>>
>> When locking, if lock->lk_is_new is true (create new lock owner), it 
>> will check lock owner's existence.
>>
>> Below is the execution path.
>>
>> nfsd4_lock:
>>  if(lock->lk_is_new)
>>    lstatus = lookup_or_create_lock_state(cstate, open_stp, lock, 
>> &lock_stp, &new);
>>
>> lookup_or_create_lock_state:
>>  lo = find_lockowner_str(cl, &lock->lk_new_owner);
>>  if(!lo) {
>>  ...
>>  } else {
>>     status = nfserr_bad_seqid;
>>  }
>>
>> find_lockowner_str will check lock owner from  hash table.
>>
>> In this case unlock doesnot delete existed lock owner from hash table 
>> so when lock again it
>> returns error.
>>
>> So my question is
>> 1. Does each lock always need new lock owner?
>> 2. In this case, unlock doesnot delete lock owner from hash table, is 
>> it normal?
>>
>> Thanks
>>
>>> --b.
>>>
>>>>> Frank
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Daniel Gryniewicz [mailto:dang@redhat.com]
>>>>>> Sent: Monday, July 8, 2019 6:49 AM
>>>>>> To: Su Yanjun <suyj.fnst@cn.fujitsu.com>; ffilzlnx@mindspring.com
>>>>>> Cc: linux-nfs@vger.kernel.org
>>>>>> Subject: Re: [Problem]testOpenUpgradeLock test failed in nfsv4.0 in
>>>>>> 5.2.0-rc7
>>>>>>
>>>>>> Is this running knfsd or Ganesha as the server?  If it's Ganesha, the
>>>>>> question
>>>>>> would be better asked on the Ganesha Devel list
>>>>>> devel@lists.nfs-ganesha.org
>>>>>>
>>>>>> If it's knfsd, than Frank isn't the right person to ask.
>>>> We are using the knfsd.
>>>>>> Daniel
>>>>>>
>>>>>> On 7/7/19 10:20 PM, Su Yanjun wrote:
>>>>>>> Ang ping?
>>>>>>>
>>>>>>> 在 2019/7/3 9:34, Su Yanjun 写道:
>>>>>>>> Hi Frank
>>>>>>>>
>>>>>>>> We tested the pynfs of NFSv4.0 on the latest version of the kernel
>>>>>>>> (5.2.0-rc7).
>>>>>>>> I encountered a problem while testing st_lock.testOpenUpgradeLock.
>>>>>>>> The problem is now as follows:
>>>>>>>> **************************************************
>>>>>>>> LOCK24 st_lock.testOpenUpgradeLock : FAILURE
>>>>>>>>             OP_LOCK should return NFS4_OK, instead got
>>>>>>>>             NFS4ERR_BAD_SEQID
>>>>>>>> **************************************************
>>>>>>>> Is this normal?
>>>>>>>>
>>>>>>>> The case is as follows:
>>>>>>>> Def testOpenUpgradeLock(t, env):
>>>>>>>>      """Try open, lock, open, downgrade, close
>>>>>>>>
>>>>>>>>      FLAGS: all lock
>>>>>>>>      CODE: LOCK24
>>>>>>>>      """
>>>>>>>>      c= env.c1
>>>>>>>>      C.init_connection()
>>>>>>>>      Os = open_sequence(c, t.code, lockowner="lockowner_LOCK24")
>>>>>>>>      Os.open(OPEN4_SHARE_ACCESS_READ)
>>>>>>>>      Os.lock(READ_LT)
>>>>>>>>      Os.open(OPEN4_SHARE_ACCESS_WRITE)
>>>>>>>>      Os.unlock()
>>>>>>>>      Os.downgrade(OPEN4_SHARE_ACCESS_WRITE)
>>>>>>>>      Os.lock(WRITE_LT)
>>>>>>>>      Os.close()
>>>>>>>>
>>>>>>>> After investigation, there was an error in unlock->lock. When
>>>>>>>> unlocking, the lockowner of the file was not released, causing an
>>>>>>>> error when locking again.
>>>>>>>> Will nfs4.0 support 1) open-> 2) lock-> 3) unlock-> 4) lock this
>>>>>>>> function?
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>
>>>
> 
> 

-- 
Calum Mackay
Linux Kernel Engineering
Oracle Linux and Virtualisation
