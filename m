Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A5D320B97
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Feb 2021 16:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhBUPym (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 21 Feb 2021 10:54:42 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:46698 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbhBUPyl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 21 Feb 2021 10:54:41 -0500
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1lDr3S-0004jh-BF; Sun, 21 Feb 2021 15:53:54 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
        by jain.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1lDr3Q-00084t-4Z; Sun, 21 Feb 2021 15:53:54 +0000
Subject: Re: NFS Caching broken in 4.19.37
To:     Bruce Fields <bfields@fieldses.org>
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "940821@bugs.debian.org" <940821@bugs.debian.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
References: <5022bdc4-9f3e-9756-cbca-ada37f88ecc7@cambridgegreys.com>
 <YDFrN0rZAJBbouly@eldamar.lan>
 <af5cebbd-74c9-9345-9fe8-253fb96033f6@cambridgegreys.com>
 <BEBA9809-373A-4172-B4AD-E19D82E56DB1@oracle.com>
 <YDIkH6yVgLoALT6x@eldamar.lan>
 <9305dc03-5557-5e18-e5c9-aaf886a03fff@cambridgegreys.com>
 <20210221143712.GA15975@fieldses.org>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
Message-ID: <f0edfaf5-457d-2334-ee4f-a6bf9d13917b@cambridgegreys.com>
Date:   Sun, 21 Feb 2021 15:53:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210221143712.GA15975@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 21/02/2021 14:37, Bruce Fields wrote:
> On Sun, Feb 21, 2021 at 11:38:51AM +0000, Anton Ivanov wrote:
>> On 21/02/2021 09:13, Salvatore Bonaccorso wrote:
>>> On Sat, Feb 20, 2021 at 08:16:26PM +0000, Chuck Lever wrote:
>>>> Confirming you are varying client-side kernels. Should the Linux
>>>> NFS client maintainers be Cc'd?
>>> Ok, agreed. Let's add them as well. NFS client maintainers any ideas
>>> on how to trackle this?
>> This is not observed with Debian backports 5.10 package
>>
>> uname -a
>> Linux madding 5.10.0-0.bpo.3-amd64 #1 SMP Debian 5.10.13-1~bpo10+1
>> (2021-02-11) x86_64 GNU/Linux
> I'm still unclear: when you say you tested a certain kernel: are you
> varying the client-side kernel version, or the server side, or both at
> once?

Client side. This seems to be an entirely client side issue.

A variety of kernels on the clients starting from 4.9 and up to 5.10 
using 4.19 servers. I have observed it on a 4.9 client versus 4.9 server 
earlier.

4.9 fails, 4.19 fails, 5.2 fails, 5.4 fails, 5.10 works.

At present the server is at 4.19.67 in all tests.

Linux jain 4.19.0-6-amd64 #1 SMP Debian 4.19.67-2+deb10u2 (2019-11-11) 
x86_64 GNU/Linux

I can set-up a couple of alternative servers during the week, but so far 
everything is pointing towards a client fs cache issue, not a server one.

Brgds,

> --b.
>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

