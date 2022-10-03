Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D995F332A
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Oct 2022 18:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiJCQPJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Oct 2022 12:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJCQPC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Oct 2022 12:15:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1371D255
        for <linux-nfs@vger.kernel.org>; Mon,  3 Oct 2022 09:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664813685;
        bh=106Rct0nCWe56VNi2CaCwE4UOD/Oi6SXl68YkjOlsRE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=h178UyKm0+LAVhnKgXGqiRU1nZXgkgEWzlMaSXIq0WnNR4poRhOyjKOUG+iyMvq73
         nvbeWz9evQaFAPjZSHsNljYWPq7JFIP2pBBTGkAFf6N/fcGyFWR1yTGO14VDuSsgCj
         ys+flIi4F3tMkya7pbbrVWYrjFMny3vknSah8IcI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.99.12] ([212.126.164.126]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFKGZ-1oPl1Q0c2b-00FnvB; Mon, 03
 Oct 2022 18:14:45 +0200
Message-ID: <7133e21b-0fcf-bfa5-3639-056f23b6d55f@gmx.ch>
Date:   Mon, 3 Oct 2022 18:14:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: nfs4.1+: workaround for defunct clientaddr?
Content-Language: de-CH, en-US
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
References: <39bf58c7-47d9-744b-6d26-d672aa713024@gmx.ch>
 <8cd63730f7b5f3e2aa3bde98587de0c6a42b384b.camel@kernel.org>
 <8550c032-2ef8-4ddb-19a0-307777bd9645@gmx.ch>
 <c163b299164cd9abe21325a947c9efe908a04331.camel@kernel.org>
 <e3842fe7-da95-98e2-b0e8-fa3aede673cc@gmx.ch>
 <CAN-5tyEj97UO-K=ZcgkhzNr2H3wTd5tq8u+TdPj19-syc81=rw@mail.gmail.com>
From:   Manfred Schwarb <manfred99@gmx.ch>
In-Reply-To: <CAN-5tyEj97UO-K=ZcgkhzNr2H3wTd5tq8u+TdPj19-syc81=rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G8Nzg1L3SMcWR4w+Wqa64RURrPSWL5W9FNUqf726hEEnh5Z4YW7
 Ikgei8QF1ZOmAERAwflVfRsBlEbp6sr2MNe+TwNW1Dkp4wK74BWK989Ly69ewYZh/qCl/II
 WHNHsb8fV8OXXgGI9y/Uk7ekHxru3dWzvThTHwoVzZinnjRnQ2GgIMVydVbxGYG6X2jH+i5
 bRm7NRR1kS9On9HYgXlKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q+XT/opiXxk=:MpR4001C/4gBrHahOZdsgE
 qDv81RcvXlkLzjUwgsHtOUfVMBTweXXgipEtXIeRpbQ5vUmwhWpCkbXMLaLVJl7sVadktOVKj
 Azl+wDEctyvCmTbNi6/PON6S0Vsl9ha+/nsDMo+NfN6A4I4fsb2WkUYl/+lLaT/05PIqRxO0h
 wTklKhxyywGqO1JdlTKyX6+fqMcbLH9Pj1oGnQ6KAG7wnj7a/FaJWKwlYd1Jw5zcT12YgXv8L
 +0Tv7RdsgCudc2NwkQKJGmwBgnJvIFoUPBczoWqP6GXmTHrv5vqkUsLcMlj0faQVcsUFuUR0r
 xK8Jud+84Y2S+ko8YEZWz+sMgbNqYxOaMxhPoKWvEJirDBMyFMHfZqQyQM/a+Rs0QZcG0kbvQ
 3N3uC+jOnYScWQjoKjsBHFQpJF6gB14V8Hl2msEs+yF+k79IuJQyKSo73kt5uxtx0EY9HSTB1
 kTADrWE3tedu32VjJo3NJl+KXrfKstMIU1u1B/44Y6oDET/8KkzMQZH4qnzaJ9ay0VEyWbgud
 JTTzsxNnyC+xOr1xZcfT8gYVJRwm6xLZulxApWqxivZaoW0gvnqwKa279O23JfgGLbpurlxWy
 TumPBoto5bwfonv/fhADpBv0rSxOfsDfGnSULODPzOP3RA4qQBmWRJdEezwIe+qpalfVSfbb2
 hH8Th2MJktNPKdLzsBYvL1tMkpg/oMf94Rlyb4CrmTnaCwehDJh8uL/tqBDGHEePeMvfnP4/p
 BjOH47vxqN5NYjcfsEI0l1uddiFgk0mxlVOW1cZX7rGKaEC7YlyHM2V3a6TQqISO5R7trw4Ml
 aZkVCS7UHHMQjz6S52LRBryTm7hdYnHHye2QfCS6xD+jJqWtDwGa43QafQDUJTO+idytvJVE2
 1xd+3Wc5ZHyNVFywSqKqOjT0DpkwptTrN25Jfrhpxc0c9G5wcqAgbzl9WYT0vxNo4jpBopsva
 RR7DLP7A54cdNfsHimWiH+/a1AiqH5l8lfGSqMvKVMilxgvCj1qsg3NxOMKH/nZgyQb5DDVhu
 du+irdBDlHMoq2pc7r6v7/ABXuxlii4247n6O7BheAupDaz6KlhrwzyVLCA8BCBRRiLTDFqAB
 SFbdFZzJgUDKOlAiZcwOZciP9iJsiKk4s67EU5K127Szd6ntotf0OvFjnFGrHA5R0UJwMy2jO
 6vBIVJAlcOv28I16sikdgnoXQf
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Am 03.10.22 um 16:18 schrieb Olga Kornievskaia:
>  Hi Manfred,
>
> What's the purpose of segregating your connections? You don't want
> your backup traffic "interfering" with your regular operation.
> However, the assumption is that between 2 NICs the backup traffic and
> regular traffic could co-exists, correct? In that case why not use
> session trunking?  What you are correctly experiencing is that with
> 4.1+ the 2nd mount discovers that in the 2nd mount it's the same
> server the client is talking to (even if it's thru a different IPs)
> and the client will drop the new connection.
>

I did not know that I'm supposed to want this ;-)  Sounds interesting.
I searched for "replica" and "discovertrunking" but did not find anything.
I'm on Linux 5.14 / nfs-kernel-server-2.1.1. Did you mean "nconnect"
or is my Linux installation simply too old? Probably. 2.1.1 is 5 years old=
.
I'm on openSUSE Leap 15.4, on idea why they ship such old userspace compon=
ents.


> For session trunking, you can configure your linux server (I'm
> assuming it is, if not that might be a problem) to support session
> trunking (by using replica=3D<> option). Then you can also add
> "discovertrunking" option to your mount command and then the client
> will discover the 2 available paths to the server. You wouldn't need 2
> mounts and you'd have both NICs available to serve your combined
> regular and backup traffic. This would be the solution to utilize both
> of the NICs (network paths) you have available between the client and
> the server.
>
>
> On Mon, Oct 3, 2022 at 9:27 AM Manfred Schwarb <manfred99@gmx.ch> wrote:
>>
>> Am 03.10.22 um 14:26 schrieb Jeff Layton:
>>> On Mon, 2022-10-03 at 13:55 +0200, Manfred Schwarb wrote:
>>>> Am 03.10.22 um 13:39 schrieb Jeff Layton:
>>>>> On Sun, 2022-10-02 at 14:35 +0200, Manfred Schwarb wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I have 2 boxes connected with 2 network cards each, one
>>>>>> crossover connection and one connection via LAN.
>>>>>> I want to use the crossover connection for backup,
>>>>>> so I want to be able to select exactly this wire when
>>>>>> doing my NFS backup transfers. Everything interconnected via NFS4.1
>>>>>> and automount.
>>>>>>
>>>>>> Now the thing is, if there is an already existing connection
>>>>>> via LAN, I am not able to select the crossover connection,
>>>>>> there is some session reuse against my will.
>>>>>>
>>>>>> automount config:
>>>>>> /net/192.168.99.1  -fstype=3Dnfs4,nfsvers=3D4,minorversion=3D1,clie=
ntaddr=3D192.168.99.100   /  192.168.99.1:/
>>>>>> /net2/192.168.98.1 -fstype=3Dnfs4,nfsvers=3D4,minorversion=3D1,clie=
ntaddr=3D192.168.98.100   /  192.168.98.1:/
>>>>>>
>>>>>> mount -l:
>>>>>> 192.168.99.1:/data on /net/192.168.99.1/data type nfs4 (...,clienta=
ddr=3D192.168.99.100,addr=3D192.168.99.1)
>>>>>> 192.168.99.1:/data on /net2/192.168.98.1/data type nfs4 (...,client=
addr=3D192.168.99.100,addr=3D192.168.99.1)
>>>>>>
>>>>>> As you see, both connections are on "192.168.99.1:/data", and the b=
ackup runs
>>>>>> over the same wire as all user communication, which is not desired.
>>>>>> This even happens if I explicitly set some clientaddr=3D option.
>>>>>>
>>>>>> Now I found two workarounds:
>>>>>> - downgrade to NFS 4.0, clientaddr seems to work with it
>>>>>> - choose different NFS versions, i.e. one connection with
>>>>>>   minorversion=3D1 and the other with minorversion=3D2
>>>>>>
>>>>>> Both possibilities seem a bit lame to me.
>>>>>> Are there some other (recommended) variants which do what I want?
>>>>>>
>>>>>> It seems different minor versions result in different "nfs4_unique_=
id" values,
>>>>>> and therefore no session sharing occurs. But why do different netwo=
rk
>>>>>> interfaces (via explicitly set clientaddr=3D by user) not result in=
 different
>>>>>> "nfs4_unique_id" values?
>>>>>>
>>>>>> Thanks for any comments and advice,
>>>>>> Manfred
>>>>>
>>>>> That sounds like a bug. We probably need to compare the clientaddr
>>>>> values in nfs_compare_super or nfs_compare_mount_options so that it
>>>>> doesn't match if the clientaddrs are different.
>>>>>
>>>
>>>
>>> Actually, I take it back, clientaddr is specifically advertised as bei=
ng
>>> for NFSv4.0 only. The workaround for you is "nosharecache", which will
>>> force the mount under /net2 to get a new superblock altogether.
>>
>> But clientaddr is silently accepted on NFS4.1+, and seemingly silently =
does nothing.
>>
>> The point is, RFC5661 explicitely tells
>> "NFS minor version 1 is deemed superior to NFS minor version 0 with no =
loss of functionality".
>>
>> So this behavior comes as a surprise.
>>
>>>
>>>>> As a workaround, you can probably mount the second mount with
>>>>> -o nosharecache and get what you want.
>>>>
>>>> Indeed, nosharecache works. But the man page has some scary words for=
 it:
>>>>   "This is considered a data risk".
>>>>
>>>
>>> Yeah, it does sound scary but it's not a huge issue unless you're doin=
g
>>> I/O to the same files at the same time via both mounts. With
>>> "sharecache" (the default) you get better cache coherency in that
>>> situation since the inode and its pagecache are the same.
>>>
>>
>> So I guess this is equivalent to the minorversion=3D1/minorversion=3D2 =
trick
>> cache coherency wise then?
>>
>>
>>> With "nosharecache" you need to be more careful to flush caches, etc. =
if
>>> you are doing reads and writes to the same files via different paths. =
If
>>> you need careful coordination there, then you probably want to use fil=
e
>>> locking.
>>
>> Thanks for these explanations, it is appreciated!
>> Manfred
>>
>>> --
>>> Jeff Layton <jlayton@kernel.org>
>>

