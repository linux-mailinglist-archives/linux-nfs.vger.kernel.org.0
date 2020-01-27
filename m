Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF8B14AA30
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2020 20:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgA0TDc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jan 2020 14:03:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34210 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725845AbgA0TDc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jan 2020 14:03:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580151810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WeCCHEJN/lpxuTIY8QQCGRWSjEMYHFw/qIJYe/i4e5c=;
        b=gVQUqob2hWFMSMp7aGrs4tJc9imnufI1ULIN/2RKg0gxrs+2rO4bAQAkc85Owj02s4SGpJ
        DFT+4w5f1O5KgWdUBn9uY8oZyGbVd1VPPNzM820XA0z5xNBwW6h4FNMM+UgTnbL0cAcTdk
        mHpgiUlRh5Q00AqVNI5Vpd2CTzvSXuo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-WAHHUTvrNSeU7og-n4WumQ-1; Mon, 27 Jan 2020 14:03:28 -0500
X-MC-Unique: WAHHUTvrNSeU7og-n4WumQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C653C1084449;
        Mon, 27 Jan 2020 19:03:26 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-75.phx2.redhat.com [10.3.117.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C9CC85747;
        Mon, 27 Jan 2020 19:03:26 +0000 (UTC)
Subject: Re: [nfs-utils PATCH] locktest: Makefile.am: remove host compiler
 costraint
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        linux-nfs@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>
References: <20200115160806.99991-1-giulio.benetti@benettiengineering.com>
 <ae36c91f-bed4-3839-bdd5-fffdcca9bf40@RedHat.com>
 <92111fa0-a808-84da-19b8-823ad6a26a99@benettiengineering.com>
 <3857d0ce-ba29-d92e-3e24-9dfc33cfc7f9@benettiengineering.com>
 <b98b367b-3fbb-99d4-b1af-e7e7f6a1728c@RedHat.com>
 <cc7f2ae5-99a7-57ca-5913-7df6a85e08ba@benettiengineering.com>
 <a958026e-4ec1-bdda-ef5c-d73f47f0ea33@RedHat.com>
 <c3431ba6-d141-780a-6399-02850c068a3f@benettiengineering.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <f8de69c7-b20d-d516-162f-4fa325ad65d9@RedHat.com>
Date:   Mon, 27 Jan 2020 14:03:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <c3431ba6-d141-780a-6399-02850c068a3f@benettiengineering.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/27/20 1:58 PM, Giulio Benetti wrote:
> Hi Steve,
> 
> On 1/27/20 7:41 PM, Steve Dickson wrote:
>>
>>
>> On 1/22/20 4:55 PM, Giulio Benetti wrote:
>>> On 1/22/20 8:30 PM, Steve Dickson wrote:
>>>>
>>>>
>>>> On 1/22/20 1:54 PM, Giulio Benetti wrote:
>>>>> Hi Steve, Petr,
>>>>>
>>>>> On 1/22/20 7:11 PM, Giulio Benetti wrote:
>>>>>> Hi Steve,
>>>>>>
>>>>>> On 1/22/20 6:56 PM, Steve Dickson wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 1/15/20 11:08 AM, Giulio Benetti wrote:
>>>>>>>> Currently locktest can be built only for host because CC_FOR_BUILD is
>>>>>>>> specified as CC, but this leads to build failure when passing CFLAGS not
>>>>>>>> available on host gcc(i.e. -mlongcalls) and most of all locktest would
>>>>>>>> be available on target systems the same way as rpcgen etc. So remove CC
>>>>>>>> and LIBTOOL assignments.
>>>>>>>>
>>>>>>>> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
>>>>>>> Committed... (tag: nfs-utils-2-4-3-rc6)
>>>>>>
>>>>>> I've just setup up a Gentoo to try building nfs-utils, I give a try
>>>>>> anyway by now, so we should be sure.
>>>>>
>>>>> Just tried, it builds correctly on latest Gentoo.
>>>> Good to hear... Thank you for your effort!!!!
>>>
>>> It's a pleasure. Btw, when do you plan to release version 2.4.3?
>>> I have Buildroot patch ready to be sent.
>> Go ahead and send it... I'll make a release after that...
> 
> You can already release, I've meant that I have a patch so send to Buildroot to bump nfs-utils version :-)
Ok... I'll try to get to it sometime this week.

steved.

