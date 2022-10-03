Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143FD5F3133
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Oct 2022 15:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiJCNZl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Oct 2022 09:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiJCNZP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Oct 2022 09:25:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA4D205D0
        for <linux-nfs@vger.kernel.org>; Mon,  3 Oct 2022 06:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664803496;
        bh=bJ0KfBG1IMZSzm3eGCdJShyzO6MjfktMVcXhGqXnQTE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=bCoW7ZsLb0a3cUVSthOtWUzzsajdh3Gb03tVpu3hEoxMpgNGvs/s/iYBoQ9+rV3hf
         quluXxXUSapeOhwpnrHn1/K6r7vBwloB5gT/+j8gLxy38sb55bcdCsDsxQwhH0iuMH
         CVOPzhuAroWXaAC/rQy07lgFhQHDnPPWbvswpZCw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.99.12] ([212.126.164.126]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeCpR-1pFEUR0J55-00bKet; Mon, 03
 Oct 2022 15:24:56 +0200
Message-ID: <e3842fe7-da95-98e2-b0e8-fa3aede673cc@gmx.ch>
Date:   Mon, 3 Oct 2022 15:24:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: nfs4.1+: workaround for defunct clientaddr?
Content-Language: de-CH, en-US
To:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
References: <39bf58c7-47d9-744b-6d26-d672aa713024@gmx.ch>
 <8cd63730f7b5f3e2aa3bde98587de0c6a42b384b.camel@kernel.org>
 <8550c032-2ef8-4ddb-19a0-307777bd9645@gmx.ch>
 <c163b299164cd9abe21325a947c9efe908a04331.camel@kernel.org>
From:   Manfred Schwarb <manfred99@gmx.ch>
In-Reply-To: <c163b299164cd9abe21325a947c9efe908a04331.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WxAXcg5bvT8I4KIA+qvCddklHHNslnoHRGuTbuQcPiAKUykbfKo
 aqTsv+ZJBiVsc9z9xGUHm0n8MhVgM/th8pJZeTVtfh21TkHAxQljTbgWstsbrbcSFZQ6l7z
 Ao1Ky6NALVzWSxRoseZ30ID6z16gLW9zNkY9kB4014g9JIzqjN8QY1Hofddd3x3McJGLxIu
 6uF4ihsqP3KsDvSTRlhdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2+IjFz1rTv0=:iaKzLq9u004F9/CI1RAefS
 Y7O2Le4m53rEbLZjSFGS7tRBmcpfcc1fqHCJAlTtmedJWFAfnKhjH70w02CphAYXDzIA3Z6d+
 YmkE0LAmlmRCO5GqJlwmMdDNQ9w7ELX3AB7RObwFglSFfbGplWnRtsTO97gD3dZgMIOvPIzes
 uTFFpQaAXsZ/ErCFDEBhORTEWE+REtYXEuVuKJv8Ip8Df18PSlvWit+ewTnq7fBtbf5YJbs4r
 7a/jg4Mri8LEWdwyBJCQQLXo0+oYvQxxtgr8QDqRKJ133XzsH+djf3OCQ2Y1v+uoJoxvfvxph
 JjohoAVoGvewK3E1godk0vhN+4YeR71v5gr+sLRY8iCjnWZMDofrWDm58KyhCDQjG9T6yiIyq
 VKA+Gtbiw2T9BfxPoaoh1hhid2QPJbKi3x/WX+bWQQlx5sUhisGrXjZQgIO5QUuLS8jgbrjQ8
 YCVMTTvMzffqVGWrzztMHCJpsg4bijV45YBICDeFkkwhNxy3LFxkDmfUWwHn9HHdvBH4gCI6/
 jQkYmNTLrNIJyf+K0M1GOestMoZ2Y8EV4sNXnc4T+WCRnBIdrWQDd5ZePA/G530gnIFG4djaP
 wf0xWsiuHsfLqb5IDUeVK9E4g9CoiWuLyFHNxrqzhEieUZOiHwqCMJO4Fy7AJh3mFWobho56H
 4idCh1TrKg95vYyp65ymyDtP/WGpEgtJbBaSlyigYabSTadymHU+LlM2ELvpwgkR26H/O+pAf
 vJhaO+E2Sj3fzmqVlQJycvNGqRAb9zy1cDa6b/v/VPakvorzK25MgRJJSeGkrGLbkc8pnGQ0H
 GEMivQOwowz6t98m1bgBtqs7eNgSVXNy7e34QsZXTCU85F6gx8z27fZVPk3GYsAIY68HKz8J8
 NuXf4mxi0sgBTO97c7CxL6qSrmR+J+oc8sYgf9QknBdpjCvUVoAf9mqCoqGCUS2xxnI9nAQz7
 dF9zOhbbUHAwZJ2ovHSZp1Ns032UryJct3HdwJB0tp2YELjjgZhWZd1XOefexCtjS+1IxyxtN
 793a1EylHkpnIQZY/OQpR9e4xb+KBZCnvbhNf/XSJSQb1MIKdu5ylAsVgQmP0hJuL/zrQYWAR
 n1jOXBgSYCA6oAEtJHNjTamNmf4vPtTXq/gAqtrvBRiwz1aoNBimcAmSGASQtV+0nrSrTwBik
 tRLzIvkmLrMVLIllru3Pz76oDQ
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Am 03.10.22 um 14:26 schrieb Jeff Layton:
> On Mon, 2022-10-03 at 13:55 +0200, Manfred Schwarb wrote:
>> Am 03.10.22 um 13:39 schrieb Jeff Layton:
>>> On Sun, 2022-10-02 at 14:35 +0200, Manfred Schwarb wrote:
>>>> Hi,
>>>>
>>>> I have 2 boxes connected with 2 network cards each, one
>>>> crossover connection and one connection via LAN.
>>>> I want to use the crossover connection for backup,
>>>> so I want to be able to select exactly this wire when
>>>> doing my NFS backup transfers. Everything interconnected via NFS4.1
>>>> and automount.
>>>>
>>>> Now the thing is, if there is an already existing connection
>>>> via LAN, I am not able to select the crossover connection,
>>>> there is some session reuse against my will.
>>>>
>>>> automount config:
>>>> /net/192.168.99.1  -fstype=3Dnfs4,nfsvers=3D4,minorversion=3D1,client=
addr=3D192.168.99.100   /  192.168.99.1:/
>>>> /net2/192.168.98.1 -fstype=3Dnfs4,nfsvers=3D4,minorversion=3D1,client=
addr=3D192.168.98.100   /  192.168.98.1:/
>>>>
>>>> mount -l:
>>>> 192.168.99.1:/data on /net/192.168.99.1/data type nfs4 (...,clientadd=
r=3D192.168.99.100,addr=3D192.168.99.1)
>>>> 192.168.99.1:/data on /net2/192.168.98.1/data type nfs4 (...,clientad=
dr=3D192.168.99.100,addr=3D192.168.99.1)
>>>>
>>>> As you see, both connections are on "192.168.99.1:/data", and the bac=
kup runs
>>>> over the same wire as all user communication, which is not desired.
>>>> This even happens if I explicitly set some clientaddr=3D option.
>>>>
>>>> Now I found two workarounds:
>>>> - downgrade to NFS 4.0, clientaddr seems to work with it
>>>> - choose different NFS versions, i.e. one connection with
>>>>   minorversion=3D1 and the other with minorversion=3D2
>>>>
>>>> Both possibilities seem a bit lame to me.
>>>> Are there some other (recommended) variants which do what I want?
>>>>
>>>> It seems different minor versions result in different "nfs4_unique_id=
" values,
>>>> and therefore no session sharing occurs. But why do different network
>>>> interfaces (via explicitly set clientaddr=3D by user) not result in d=
ifferent
>>>> "nfs4_unique_id" values?
>>>>
>>>> Thanks for any comments and advice,
>>>> Manfred
>>>
>>> That sounds like a bug. We probably need to compare the clientaddr
>>> values in nfs_compare_super or nfs_compare_mount_options so that it
>>> doesn't match if the clientaddrs are different.
>>>
>
>
> Actually, I take it back, clientaddr is specifically advertised as being
> for NFSv4.0 only. The workaround for you is "nosharecache", which will
> force the mount under /net2 to get a new superblock altogether.

But clientaddr is silently accepted on NFS4.1+, and seemingly silently doe=
s nothing.

The point is, RFC5661 explicitely tells
"NFS minor version 1 is deemed superior to NFS minor version 0 with no los=
s of functionality".

So this behavior comes as a surprise.

>
>>> As a workaround, you can probably mount the second mount with
>>> -o nosharecache and get what you want.
>>
>> Indeed, nosharecache works. But the man page has some scary words for i=
t:
>>   "This is considered a data risk".
>>
>
> Yeah, it does sound scary but it's not a huge issue unless you're doing
> I/O to the same files at the same time via both mounts. With
> "sharecache" (the default) you get better cache coherency in that
> situation since the inode and its pagecache are the same.
>

So I guess this is equivalent to the minorversion=3D1/minorversion=3D2 tri=
ck
cache coherency wise then?


> With "nosharecache" you need to be more careful to flush caches, etc. if
> you are doing reads and writes to the same files via different paths. If
> you need careful coordination there, then you probably want to use file
> locking.

Thanks for these explanations, it is appreciated!
Manfred

> --
> Jeff Layton <jlayton@kernel.org>

