Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8C21557D1
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2020 13:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgBGMdk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Feb 2020 07:33:40 -0500
Received: from smtpcmd03116.aruba.it ([62.149.158.116]:47007 "EHLO
        smtpcmd03116.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgBGMdk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 Feb 2020 07:33:40 -0500
Received: from [192.168.2.40] ([146.241.70.103])
        by smtpcmd03.ad.aruba.it with bizsmtp
        id zoZc2101X2DhmGq01oZcwP; Fri, 07 Feb 2020 13:33:37 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [nfs-utils PATCH] locktest: Makefile.am: remove host compiler costraint
Date:   Fri, 7 Feb 2020 13:33:36 +0100
Message-Id: <7C724A1B-815A-4315-B969-2EEC9FF62410@benettiengineering.com>
References: <7f15525f-38df-dbfe-f8ac-309dadc54a72@benettiengineering.com>
Cc:     Petr Vorel <petr.vorel@gmail.com>
In-Reply-To: <7f15525f-38df-dbfe-f8ac-309dadc54a72@benettiengineering.com>
To:     Steve Dickson <SteveD@redhat.com>, linux-nfs@vger.kernel.org
X-Mailer: iPhone Mail (17D50)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1581078817; bh=70i00jZ04L0ViJpx9B/YB+E71y46n33OpcOpeBcJMYI=;
        h=Content-Type:From:Mime-Version:Subject:Date:To;
        b=Er8JhK1MLWJXUUh+cvQ3+bqOqzX3Iy+aK1TVjukwMaYf1mDKzkK7KYyOQoQ9URv3R
         DNzfcus+4fdHZD/vxTOn4xKQJZ09CR36FaTbymzMWTLFZMI3okvF4P8bkkJyfQKAN3
         Tgd7BajUOd3kX736HiYOQvxs580DhO1nCQfkzHu8C9qFpVNmR9jm7MM/a1F/KXyQPQ
         X+r3m3wOicvzvjjC6o/b/I6ExfGraRfp2jTp6BlWz2tAJy7iiAfq3vu9u0wa0fBLet
         nedtrG+3Wlv0zHcWIM3zgrjlL0f2DP8wIVX7MwTYm00oMMlB66S6v+hCoqZ9Usocb8
         9gTsHbpUTWACA==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Kindly ping

Giulio Benetti
Inviato da iPhone

> Il giorno 27 gen 2020, alle ore 20:51, Giulio Benetti <giulio.benetti@bene=
ttiengineering.com> ha scritto:
>=20
> =EF=BB=BFOn 1/27/20 8:03 PM, Steve Dickson wrote:
>>> On 1/27/20 1:58 PM, Giulio Benetti wrote:
>>> Hi Steve,
>>>=20
>>> On 1/27/20 7:41 PM, Steve Dickson wrote:
>>>>=20
>>>>=20
>>>> On 1/22/20 4:55 PM, Giulio Benetti wrote:
>>>>> On 1/22/20 8:30 PM, Steve Dickson wrote:
>>>>>>=20
>>>>>>=20
>>>>>> On 1/22/20 1:54 PM, Giulio Benetti wrote:
>>>>>>> Hi Steve, Petr,
>>>>>>>=20
>>>>>>> On 1/22/20 7:11 PM, Giulio Benetti wrote:
>>>>>>>> Hi Steve,
>>>>>>>>=20
>>>>>>>> On 1/22/20 6:56 PM, Steve Dickson wrote:
>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>> On 1/15/20 11:08 AM, Giulio Benetti wrote:
>>>>>>>>>> Currently locktest can be built only for host because CC_FOR_BUIL=
D is
>>>>>>>>>> specified as CC, but this leads to build failure when passing CFL=
AGS not
>>>>>>>>>> available on host gcc(i.e. -mlongcalls) and most of all locktest w=
ould
>>>>>>>>>> be available on target systems the same way as rpcgen etc. So rem=
ove CC
>>>>>>>>>> and LIBTOOL assignments.
>>>>>>>>>>=20
>>>>>>>>>> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.=
com>
>>>>>>>>> Committed... (tag: nfs-utils-2-4-3-rc6)
>>>>>>>>=20
>>>>>>>> I've just setup up a Gentoo to try building nfs-utils, I give a try=

>>>>>>>> anyway by now, so we should be sure.
>>>>>>>=20
>>>>>>> Just tried, it builds correctly on latest Gentoo.
>>>>>> Good to hear... Thank you for your effort!!!!
>>>>>=20
>>>>> It's a pleasure. Btw, when do you plan to release version 2.4.3?
>>>>> I have Buildroot patch ready to be sent.
>>>> Go ahead and send it... I'll make a release after that...
>>>=20
>>> You can already release, I've meant that I have a patch so send to Build=
root to bump nfs-utils version :-)
>> Ok... I'll try to get to it sometime this week.
>=20
> Great, thank you!
>=20
>> steved.
>=20
> --=20
> Giulio Benetti
> Benetti Engineering sas

