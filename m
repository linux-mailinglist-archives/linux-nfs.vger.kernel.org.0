Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5340F2869E4
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Oct 2020 23:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgJGVKd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 17:10:33 -0400
Received: from h-163-233.A498.priv.bahnhof.se ([155.4.163.233]:36456 "EHLO
        mail.kenjo.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727821AbgJGVKd (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 7 Oct 2020 17:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kenjo.org;
         s=mail; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=aptkygkV2bFYuqBVJUvMOHoEXhiq/UfKIPRe1nsUVA0=; b=COLMAKvss2q9+WfftJMxP0VOyh
        PBVv9KCM7cDNa8cIFFdM9FZzOsaFVb1S7mj+U2vDyxWyfXa3UBOELoDl8g1iaqVA/jWbzjqf+KlqS
        mZEmfAd/YJRGjnIg+t29rOkOHPSP7GSSKyUIru9uoqaVE5mS189Rp/SUf+axX/g+Ae78=;
Received: from brix.kenjo.org ([172.16.2.16])
        by mail.kenjo.org with esmtp (Exim 4.89)
        (envelope-from <ken@kenjo.org>)
        id 1kQGhh-0004Se-Um; Wed, 07 Oct 2020 23:10:30 +0200
Subject: Re: nfs home directory and google chrome.
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Patrick Goetz <pgoetz@math.utexas.edu>, linux-nfs@vger.kernel.org
References: <0ba0cd0c-eccd-2362-9958-23cd1fa033df@kenjo.org>
 <5326b6a3-0222-fc1a-6baa-ae2fbdaf209d@math.utexas.edu>
 <923003de-7fcf-abee-07a2-0691b25673d8@kenjo.org>
 <20201006181454.GB32640@fieldses.org>
 <07f3684e-482e-dc73-5c9a-b7c9329fc410@kenjo.org>
 <20201007131037.GA23452@fieldses.org>
From:   Kenneth Johansson <ken@kenjo.org>
Message-ID: <d9c1b90e-a2e4-cb0e-7856-54e89b792ee5@kenjo.org>
Date:   Wed, 7 Oct 2020 23:10:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201007131037.GA23452@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2020-10-07 15:10, J. Bruce Fields wrote:
> On Wed, Oct 07, 2020 at 12:54:50PM +0200, Kenneth Johansson wrote:
>> On 2020-10-06 20:14, J. Bruce Fields wrote:
>>> On Mon, Oct 05, 2020 at 10:07:56PM +0200, Kenneth Johansson wrote:
>>>> On 2020-10-05 18:46, Patrick Goetz wrote:
>>>>> We had a similar problem with Firefox, most notably with Mac OSX
>>>>> users who have NFS-mounted home directories. There's an
>>>>> about:config solution for Firefox; namely set
>>>>>
>>>>>     storage.nfs_filesystem: true
>>>>>
>>>>> This forces a specific network file locking mechanism which makes
>>>>> sqlite behave better. I'm guessing google chrome has something
>>>>> similar.
>>>>>
>>>> Since I have used chrome for years without any problems my guess it
>>>> that its something that changed with nfs in my setup.
>>>>
>>>> I did a strace and the first -EIO I get look like this
>>>>
>>>> fdatasync(94</home/kenjo/.config/google-chrome/Default/Login Data>)
>>>> = -1 EIO (Input/output error)
>>>>
>>>> then the same thing happens for other files like
>>>>
>>>> fdatasync(83</home/kenjo/.config/google-chrome/Default/Web Data>) =
>>>> -1 EIO (Input/output error)
>>>>
>>>> fdatasync(74</home/kenjo/.config/google-chrome/Default/History>) =
>>>> -1 EIO (Input/output error)
>>> Are you using soft mounts?
>>>
>>> (What are your mount options?)
>> auto.home /home autofs rw,relatime,fd=18,pgrp=2682,timeout=300,minproto=5,maxproto=5,indirect,pipe_ino=67621
>> 0 0
>>
>> /home/kenjo nfs4 rw,noatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,acregmin=120,acregmax=120,acdirmin=120,acdirmax=120,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=172.16.2.16,fsc,local_lock=none,addr=172.16.2.6
>> 0 0
>>
>> what I actualy set manually in auto.home is
>>
>> -tcp,fsc,noatime,ac,actimeo=120
> OK, that looks fine.
>
> Maybe I overlooked the obvious: if Chrome holds a lock on that file when
> you suspend, and if you stay in suspend for longer than the NFSv4 lease
> time (default 90 seconds), then the client will lose its lease, hence
> any file locks.  I think these days the client then returns EIO on any
> further IO to that file descriptor.

So I tested by just pulling the network cable for a few minutes and the 
effect is the same. this time the password  database survived but the 
history went bye bye.

History sqlite error 1034, errno 5: disk I/O error, sql: COMMIT

The real problem here is that chrome destroys the database file and do 
not communicate that there is a problem to the end user unless started 
from a terminal and it can't recover ever. If it had just removed the 
file and recreated a new one from the server it would not be a big 
problem. What the user notice is that password handling and form filling 
do work very poorly and the only solution is really  "rm -rf  
~/.config/google-chrome/" to force it to recreate the files.


> Maybe there's some way to turn off that locking as a workaround.
>
> The simplest thing we can do to help might be implementing "courteous
> server" behavior: instead of automatically removing locks after a
> client's lease expires, it can wait until there's an actual lock
> conflict.  That might be enough for your case.
>
> There's been a little planning done and it's not a big project, but I
> don't think it's actually at the top of anyone's todo list right now, so
> I'm not sure when that will get done.
>
> --b.
>
>>
>>> --b.
>>>
>>>>
>>>>
>>>>> On 10/4/20 6:53 AM, Kenneth Johansson wrote:
>>>>>> So I have had for a long time problems with google chrome and
>>>>>> suspend resume causing it to mangle its sqlite database.
>>>>>>
>>>>>> it looks to only happen if I use nfs mounted home directory. I'm
>>>>>> not sure exactly what is happening but lets first see if this
>>>>>> happens to anybody else.
>>>>>>
>>>>>> How to get the error.
>>>>>>
>>>>>> 1. start google from a terminal with "google-chrome"
>>>>>>
>>>>>> 2. suspend the computer
>>>>>>
>>>>>> 3. wait a while. There is some type of minimum time here I do
>>>>>> not know what its is but I basically get the error every time of
>>>>>> I suspend in evening and resume in morning
>>>>>>
>>>>>> 4. look for printout that looks like something like this
>>>>>>
>>>>>> [16789:18181:1004/125852.529750:ERROR:database.cc(1692)]
>>>>>> Passwords sqlite error 1034, errno 5: disk I/O error, sql:
>>>>>> COMMIT
>>>>>> [16789:16829:1004/125852.529744:ERROR:database.cc(1692)] Web
>>>>>> sqlite error 1034, errno 5: disk I/O error, sql: COMMIT
>>>>>> [16789:16829:1004/125852.530261:ERROR:database.cc(1692)] Web
>>>>>> sqlite error 1034, errno 5: disk I/O error, sql: INSERT OR
>>>>>> REPLACE INTO autofill_model_type_state (model_type, value)
>>>>>> VALUES(?,?)
>>>>>> [16789:16789:1004/125852.563571:ERROR:sync_metadata_store_change_list.cc(34)]
>>>>>> Autofill datatype error was encountered: Failed to update
>>>>>> ModelTypeState.
>>>>>> [16789:19002:1004/125902.534103:ERROR:database.cc(1692)] History
>>>>>> sqlite error 1034, errno 5: disk I/O error, sql: COMMIT
>>>>>> [16789:19002:1004/125902.536903:ERROR:database.cc(1692)]
>>>>>> Thumbnail sqlite error 778, errno 5: disk I/O error, sql: COMMIT
>>>>>>
>>>>>>
>>>>>> [16789:19002:1004/130044.120379:ERROR:database.cc(1692)]
>>>>>> Passwords sqlite error 1034, errno 5: disk I/O error, sql:
>>>>>> INSERT OR REPLACE INTO sync_model_metadata (id, model_metadata)
>>>>>> VALUES(1, ?)
>>>>>> [16789:16829:1004/130044.120388:ERROR:database.cc(1692)] Web
>>>>>> sqlite error 1034, errno 5: disk I/O error, sql: INSERT OR
>>>>>> REPLACE INTO autofill_model_type_state (model_type, value)
>>>>>> VALUES(?,?)
>>>>>>
>>>>>>
>>>>>> and so on.  if you use google sync you can also check
>>>>>> "chrome://sync-internals" to see if something is wrong with the
>>>>>> database.
>>>>>>
>>>>>>
>>>>>>
>>>>>>>> This message is from an external sender. Learn more about why this <<
>>>>>>>> matters at https://links.utexas.edu/rtyclf. <<


