Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8F9155AF2
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2020 16:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgBGPpu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Feb 2020 10:45:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23227 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726874AbgBGPpu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 Feb 2020 10:45:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581090348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yw+CbBMXCWkw0oMk1/+CFaufz6sL0jKiX/z5v8tIwHg=;
        b=ftA88nzxxco5AJ0B9FHqwUprVfu62qUfOG1AGSegmfbzHp4Rgu0UnUUkakwXjKURsf3Bud
        cS8ZEgLMvzSQozY9YFEbNCgdlU0mKOvW1ptQC/6WQ+0HcdiM6Gscfylmslt9FjwMC1ftl/
        vmYCLcMMlqkCNNlNV+NPEbTR6Lpr5mA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-gvsvMqXgM_CeUZbPltHvWg-1; Fri, 07 Feb 2020 10:45:40 -0500
X-MC-Unique: gvsvMqXgM_CeUZbPltHvWg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80CE91085933;
        Fri,  7 Feb 2020 15:45:39 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-141.phx2.redhat.com [10.3.117.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECB678ECE3;
        Fri,  7 Feb 2020 15:45:38 +0000 (UTC)
Subject: Re: [nfs-utils PATCH] locktest: Makefile.am: remove host compiler
 costraint
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        linux-nfs@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>
References: <7f15525f-38df-dbfe-f8ac-309dadc54a72@benettiengineering.com>
 <7C724A1B-815A-4315-B969-2EEC9FF62410@benettiengineering.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <2e3d752f-974d-df96-9f09-359a3f5e6535@RedHat.com>
Date:   Fri, 7 Feb 2020 10:45:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7C724A1B-815A-4315-B969-2EEC9FF62410@benettiengineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2/7/20 7:33 AM, Giulio Benetti wrote:
> Kindly ping
Working on it... ;-)=20

Looking to get some manpages in as well as a few other
minor issues...=20

steved.

>=20
> Giulio Benetti
> Inviato da iPhone
>=20
>> Il giorno 27 gen 2020, alle ore 20:51, Giulio Benetti <giulio.benetti@=
benettiengineering.com> ha scritto:
>>
>> =EF=BB=BFOn 1/27/20 8:03 PM, Steve Dickson wrote:
>>>> On 1/27/20 1:58 PM, Giulio Benetti wrote:
>>>> Hi Steve,
>>>>
>>>> On 1/27/20 7:41 PM, Steve Dickson wrote:
>>>>>
>>>>>
>>>>> On 1/22/20 4:55 PM, Giulio Benetti wrote:
>>>>>> On 1/22/20 8:30 PM, Steve Dickson wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 1/22/20 1:54 PM, Giulio Benetti wrote:
>>>>>>>> Hi Steve, Petr,
>>>>>>>>
>>>>>>>> On 1/22/20 7:11 PM, Giulio Benetti wrote:
>>>>>>>>> Hi Steve,
>>>>>>>>>
>>>>>>>>> On 1/22/20 6:56 PM, Steve Dickson wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 1/15/20 11:08 AM, Giulio Benetti wrote:
>>>>>>>>>>> Currently locktest can be built only for host because CC_FOR_=
BUILD is
>>>>>>>>>>> specified as CC, but this leads to build failure when passing=
 CFLAGS not
>>>>>>>>>>> available on host gcc(i.e. -mlongcalls) and most of all lockt=
est would
>>>>>>>>>>> be available on target systems the same way as rpcgen etc. So=
 remove CC
>>>>>>>>>>> and LIBTOOL assignments.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineer=
ing.com>
>>>>>>>>>> Committed... (tag: nfs-utils-2-4-3-rc6)
>>>>>>>>>
>>>>>>>>> I've just setup up a Gentoo to try building nfs-utils, I give a=
 try
>>>>>>>>> anyway by now, so we should be sure.
>>>>>>>>
>>>>>>>> Just tried, it builds correctly on latest Gentoo.
>>>>>>> Good to hear... Thank you for your effort!!!!
>>>>>>
>>>>>> It's a pleasure. Btw, when do you plan to release version 2.4.3?
>>>>>> I have Buildroot patch ready to be sent.
>>>>> Go ahead and send it... I'll make a release after that...
>>>>
>>>> You can already release, I've meant that I have a patch so send to B=
uildroot to bump nfs-utils version :-)
>>> Ok... I'll try to get to it sometime this week.
>>
>> Great, thank you!
>>
>>> steved.
>>
>> --=20
>> Giulio Benetti
>> Benetti Engineering sas
>=20

