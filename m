Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 823F5145BCA
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2020 19:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgAVSyf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jan 2020 13:54:35 -0500
Received: from smtpcmd0641.aruba.it ([62.149.156.41]:42282 "EHLO
        smtpcmd0641.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVSyf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jan 2020 13:54:35 -0500
Received: from [192.168.126.128] ([146.241.70.103])
        by smtpcmd06.ad.aruba.it with bizsmtp
        id tWuY2100x2DhmGq01WuZFw; Wed, 22 Jan 2020 19:54:34 +0100
Subject: Re: [nfs-utils PATCH] locktest: Makefile.am: remove host compiler
 costraint
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Steve Dickson <SteveD@RedHat.com>, linux-nfs@vger.kernel.org
References: <20200115160806.99991-1-giulio.benetti@benettiengineering.com>
 <ae36c91f-bed4-3839-bdd5-fffdcca9bf40@RedHat.com>
 <92111fa0-a808-84da-19b8-823ad6a26a99@benettiengineering.com>
Cc:     Petr Vorel <petr.vorel@gmail.com>
Message-ID: <3857d0ce-ba29-d92e-3e24-9dfc33cfc7f9@benettiengineering.com>
Date:   Wed, 22 Jan 2020 19:54:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <92111fa0-a808-84da-19b8-823ad6a26a99@benettiengineering.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1579719274; bh=jynDtjfuvlBMz/W/QQYUJ/NIrhZckJnLZ3uuWkIsa6w=;
        h=Subject:From:To:Date:MIME-Version:Content-Type;
        b=JHt0dRanKImEU5MtNZZvb96zSlTwH8c3AD43sirE0yG5LKmEp1WRpHMBcolY19pZC
         nvw+aMxFdS+BZv3KwDJfuit/9FiI0obhDQCpqJTLKIBiv7MkFDehJNtmFRJuAX96+Z
         WY98LIhcXEGNuwRZdJwTs+W6k1z5MwpifXQ7uyEt5PSB9kpvkK5GUJyM523XEKPwQ5
         0ywr3a90cBxHJTokzS/RKRBDhMlzmALFVU1cCKwSbgljUkgRwws1I9EIka9qP4EMaR
         LvCD2U1KXy+vI5u80K5SV6cbQ1T38u0p7gQctzyLydbVA8nChUnLaYgVV94pw41aU6
         X0vlRgqE0wsCQ==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Steve, Petr,

On 1/22/20 7:11 PM, Giulio Benetti wrote:
> Hi Steve,
> 
> On 1/22/20 6:56 PM, Steve Dickson wrote:
>>
>>
>> On 1/15/20 11:08 AM, Giulio Benetti wrote:
>>> Currently locktest can be built only for host because CC_FOR_BUILD is
>>> specified as CC, but this leads to build failure when passing CFLAGS not
>>> available on host gcc(i.e. -mlongcalls) and most of all locktest would
>>> be available on target systems the same way as rpcgen etc. So remove CC
>>> and LIBTOOL assignments.
>>>
>>> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
>> Committed... (tag: nfs-utils-2-4-3-rc6)
> 
> I've just setup up a Gentoo to try building nfs-utils, I give a try
> anyway by now, so we should be sure.

Just tried, it builds correctly on latest Gentoo.

Kind regards
-- 
Giulio Benetti
Benetti Engineering sas
