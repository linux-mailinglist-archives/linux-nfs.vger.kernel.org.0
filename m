Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D601D284061
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Oct 2020 22:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbgJEUIA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Oct 2020 16:08:00 -0400
Received: from h-163-233.A498.priv.bahnhof.se ([155.4.163.233]:35962 "EHLO
        mail.kenjo.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729424AbgJEUIA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 5 Oct 2020 16:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kenjo.org;
         s=mail; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DixqxRQLxSCTSdnJbTouAu2cyaF96G8OgDIM1c7ZTnU=; b=mXnjZJy8e+J7e2wI/plZjVyRr/
        jNeqdG3ADN+5AVlW6gyAEa1j0nZHx7+YjRo/JmSFLG2C+y3OThxc7W+maVE4i7Cozln8LY5LSWKuS
        pjkK35l4lcM0BFQRMKfX4JmudOaUkgk6fLTjo+Y6pEZBWBwARbUcpx71mVn42ny6Vg80=;
Received: from brix.kenjo.org ([172.16.2.16])
        by mail.kenjo.org with esmtp (Exim 4.89)
        (envelope-from <ken@kenjo.org>)
        id 1kPWm4-0005Z2-4K; Mon, 05 Oct 2020 22:07:56 +0200
Subject: Re: nfs home directory and google chrome.
To:     Patrick Goetz <pgoetz@math.utexas.edu>, linux-nfs@vger.kernel.org
References: <0ba0cd0c-eccd-2362-9958-23cd1fa033df@kenjo.org>
 <5326b6a3-0222-fc1a-6baa-ae2fbdaf209d@math.utexas.edu>
From:   Kenneth Johansson <ken@kenjo.org>
Message-ID: <923003de-7fcf-abee-07a2-0691b25673d8@kenjo.org>
Date:   Mon, 5 Oct 2020 22:07:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <5326b6a3-0222-fc1a-6baa-ae2fbdaf209d@math.utexas.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2020-10-05 18:46, Patrick Goetz wrote:
> We had a similar problem with Firefox, most notably with Mac OSX users 
> who have NFS-mounted home directories. There's an about:config 
> solution for Firefox; namely set
>
>    storage.nfs_filesystem: true
>
> This forces a specific network file locking mechanism which makes 
> sqlite behave better. I'm guessing google chrome has something similar.
>
Since I have used chrome for years without any problems my guess it that 
its something that changed with nfs in my setup.

I did a strace and the first -EIO I get look like this

fdatasync(94</home/kenjo/.config/google-chrome/Default/Login Data>) = -1 
EIO (Input/output error)

then the same thing happens for other files like

fdatasync(83</home/kenjo/.config/google-chrome/Default/Web Data>) = -1 
EIO (Input/output error)

fdatasync(74</home/kenjo/.config/google-chrome/Default/History>) = -1 
EIO (Input/output error)




> On 10/4/20 6:53 AM, Kenneth Johansson wrote:
>> So I have had for a long time problems with google chrome and suspend 
>> resume causing it to mangle its sqlite database.
>>
>> it looks to only happen if I use nfs mounted home directory. I'm not 
>> sure exactly what is happening but lets first see if this happens to 
>> anybody else.
>>
>> How to get the error.
>>
>> 1. start google from a terminal with "google-chrome"
>>
>> 2. suspend the computer
>>
>> 3. wait a while. There is some type of minimum time here I do not 
>> know what its is but I basically get the error every time of I 
>> suspend in evening and resume in morning
>>
>> 4. look for printout that looks like something like this
>>
>> [16789:18181:1004/125852.529750:ERROR:database.cc(1692)] Passwords 
>> sqlite error 1034, errno 5: disk I/O error, sql: COMMIT
>> [16789:16829:1004/125852.529744:ERROR:database.cc(1692)] Web sqlite 
>> error 1034, errno 5: disk I/O error, sql: COMMIT
>> [16789:16829:1004/125852.530261:ERROR:database.cc(1692)] Web sqlite 
>> error 1034, errno 5: disk I/O error, sql: INSERT OR REPLACE INTO 
>> autofill_model_type_state (model_type, value) VALUES(?,?)
>> [16789:16789:1004/125852.563571:ERROR:sync_metadata_store_change_list.cc(34)] 
>> Autofill datatype error was encountered: Failed to update 
>> ModelTypeState.
>> [16789:19002:1004/125902.534103:ERROR:database.cc(1692)] History 
>> sqlite error 1034, errno 5: disk I/O error, sql: COMMIT
>> [16789:19002:1004/125902.536903:ERROR:database.cc(1692)] Thumbnail 
>> sqlite error 778, errno 5: disk I/O error, sql: COMMIT
>>
>>
>> [16789:19002:1004/130044.120379:ERROR:database.cc(1692)] Passwords 
>> sqlite error 1034, errno 5: disk I/O error, sql: INSERT OR REPLACE 
>> INTO sync_model_metadata (id, model_metadata) VALUES(1, ?)
>> [16789:16829:1004/130044.120388:ERROR:database.cc(1692)] Web sqlite 
>> error 1034, errno 5: disk I/O error, sql: INSERT OR REPLACE INTO 
>> autofill_model_type_state (model_type, value) VALUES(?,?)
>>
>>
>> and so on.  if you use google sync you can also check 
>> "chrome://sync-internals" to see if something is wrong with the 
>> database.
>>
>>
>>
>>>> This message is from an external sender. Learn more about why this <<
>>>> matters at https://links.utexas.edu/rtyclf. <<


