Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6699932B74E
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Mar 2021 12:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343616AbhCCK5c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 05:57:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41295 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1383252AbhCBVOx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Mar 2021 16:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614719566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MJFBFypqOeC5W5r93vrrnPxnYBNhjWxaEjostAtwu6g=;
        b=Ecjr+xg4Kk4+zgPlctMDKCYTkbkSgq6Q0wdXXsrmRlPnR4GWpST4dfpngl9LogJiM1C4Gj
        qG/nG/kMXLrIh/XfcKDpUhhaxfYApVIO3WZer1uIFbRNx1Nw4IvhWASEJ9zvM2RwNZ9vNh
        hwDaK5oRvAaCxoq/9RhUBa/QOS7/Hc8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462--YbYqjOrNqymk54zcNBDlA-1; Tue, 02 Mar 2021 16:12:44 -0500
X-MC-Unique: -YbYqjOrNqymk54zcNBDlA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F1BF195D57C
        for <linux-nfs@vger.kernel.org>; Tue,  2 Mar 2021 21:12:43 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A644E1F44C;
        Tue,  2 Mar 2021 21:12:39 +0000 (UTC)
Subject: Re: gssd: set $HOME to prevent recursion when home dirs are on
 kerberized NFS mount revisted
To:     David Wysochanski <dwysocha@redhat.com>,
        Jacob Shivers <jshivers@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
References: <CALe0_74eB89Koni0i14aB=2CSitzg1WkRihe7KZGDJ5OoPSahw@mail.gmail.com>
 <ff7d4adc-2d4a-d5cc-fa0a-1f808b571fad@RedHat.com>
 <CALe0_75aeott7xJn0FxSMSANx0AwsxLtjNLC6YZycuE7yN+mGA@mail.gmail.com>
 <CALe0_74mGBcaNZ_RFZJUzWhG6=4YiP9c9_qBn7RwK0RdjXoa_Q@mail.gmail.com>
 <CALF+zOndUvphHGvvUmJwRaGE8-E6c8zdiGja0WBX1JKt9BCudg@mail.gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <c9c28736-8b27-9a68-72ed-d5fc156047df@RedHat.com>
Date:   Tue, 2 Mar 2021 16:14:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CALF+zOndUvphHGvvUmJwRaGE8-E6c8zdiGja0WBX1JKt9BCudg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/1/21 1:54 PM, David Wysochanski wrote:
> I was talking to Jake and I think he will submit this again without
> attachments so it's a little easier to review.
Thank you!

steved.
> 
> On Mon, Mar 1, 2021 at 12:07 PM Jacob Shivers <jshivers@redhat.com> wrote:
>>
>> Patches that include a '-H' flag and man page entry.
>>
>> The default is to maintain behavior since
>> 2f682f25c642fcfe7c511d04bc9d67e732282348, but passing '-H' avoids
>> $HOME being set to '/'.
>> Also included a patch for /etc/nfs.conf to add 'set-home=1'. Setting
>> it to false is equivalent to passing '-H' to rpc.gssd.
>>
>> Regards,
>>
>> Jacob Shivers
>>
>> On Mon, Jan 4, 2021 at 11:00 AM Jacob Shivers <jshivers@redhat.com> wrote:
>>>
>>> Hello,
>>>
>>> I completely missed this so please excuse the delay.
>>>
>>>> On 11/23/20 1:17 PM, Jacob Shivers wrote:
>>>>> Commit 2f682f25c642fcfe7c511d04bc9d67e732282348 changed existing
>>>>> behavior to avoid a deadlock for users using Kerberized NFS home dirs.
>>>>>
>>>>> However, this also prevents users leveraging their own k5identity
>>>>> files under their home directory and instead rpc.gssd uses a
>>>>> system-wide /.k5identity file. For users expecting to use their own
>>>>> k5identity file this is certainly unexpected.
>>>> So how is the deadlock not happening when ~/.k5identity is on a NFS
>>>> home directory? What am I missing?
>>> They are not using NFS for home directories. They are accessing
>>> systems with a local fs backing the /home
>>>
>>>>> Below is some pseudo code that was proposed and would just add a flag
>>>>> allowing for the behavior prior to
>>>>> 2f682f25c642fcfe7c511d04bc9d67e732282348:
>>>>>
>>>>> /* psudo code snippet starts here */
>>>>>         /*
>>>>>          * Some krb5 routines try to scrape info out of files in the user's
>>>>>          * home directory. This can easily deadlock when that homedir is on a
>>>>> -        * kerberized NFS mount. By setting $HOME unconditionally to "/", we
>>>>> +        * kerberized NFS mount. Some users may not have $HOME on NFS.
>>>>> +        * By default setting $HOME unconditionally to "/", we
>>>>>          * prevent this behavior in routines that use $HOME in preference to
>>>>>          * the results of getpw*.
>>>>> +        * Users who have $HOME on krb5-NFS should set
>>>>> `--home-not-kerberized` in argv
>>>>> +        * Users who have $HOME on krb5-NFS but want to use their
>>>>> $HOME anyway should set NFS_HOME_ACCESSIBLE=TRUE
>>>>>          */
>>>>> +       if (argv == '--home-not-kerberized') ||
>>>>> (getenv("NFS_HOME_ACCESSIBLE") == 'TRUE') {
>>>>> +               log.debug('Not masking $HOME, this breaks on Kerberized $HOME');
>>>>> +       }
>>>>> +       else {
>>>>> +               log.debug('Assuming $HOME requires Kerberos, use
>>>>> `--home-not-kerberized` to change this behavior');
>>>>>         if (setenv("HOME", "/", 1)) {
>>>>>                 printerr(1, "Unable to set $HOME: %s\n", strerror(errn));
>>>>>                 exit(1);
>>>>>         }
>>>>> +       }
>>>>> /* psudo code snippet ends here */
>>>> In general I'm pretty reluctant to add flags but what is needed
>>>> to do so is a company single letter flag '-H' and a man page
>>>> entry describing the flag.
>>> Ok.
>>>
>>>>>
>>>>> While acknowledging the use of this flag for Kerberized NFS home dirs
>>>>> is undesirable and would cause a deadlock, there should be no issue
>>>>> for users not using Kerberized NFS home dirs.
>>>> What apps are you using that is seeing this problem?
>>> It is just when accessing the Kerberized NFS share. Other Kerberos
>>> aware services/applications check for the existence of ~/.k5identify
>>> before reading /var/kerberos/krb5/user/${EUID}/client.keytab. rpc.gssd
>>> no longer does this and the intent of the patch would be to add
>>> granularity to choose the behavior or rpc.gssd with respect to
>>> scanning for a k5identity file.
>>>
>>> If any additional information is required, please inform me.
>>>
>>> Thanks,
>>>
>>> Jacob Shivers
> 

