Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25771145C74
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2020 20:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgAVTab (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jan 2020 14:30:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22983 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725928AbgAVTaa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jan 2020 14:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579721430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PKIvzidHkvLkFli+nfNYyacg+K2SLk8ng+fZqIAg/CA=;
        b=F4HMt8uD78gkgYA8s1Nf53kXS1leh/zPo/2mYL2IQRs2aDBMPeqtmSWYJeItNSdV2tSE6c
        JbXnbgJaBdOKDXwbV7JPvdSvgG7A2gzyqJu9B1w8sPAZdgDD5Xm9GM6wiobpxDghDE3j4H
        90MXHEDBnm2oeClIlWQ9lcBTnLd4aUY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-cpekKac5Pxed3v_yIL82eg-1; Wed, 22 Jan 2020 14:30:26 -0500
X-MC-Unique: cpekKac5Pxed3v_yIL82eg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 811B610120A0;
        Wed, 22 Jan 2020 19:30:25 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-118-49.phx2.redhat.com [10.3.118.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26DBF5C28D;
        Wed, 22 Jan 2020 19:30:25 +0000 (UTC)
Subject: Re: [nfs-utils PATCH] locktest: Makefile.am: remove host compiler
 costraint
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        linux-nfs@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>
References: <20200115160806.99991-1-giulio.benetti@benettiengineering.com>
 <ae36c91f-bed4-3839-bdd5-fffdcca9bf40@RedHat.com>
 <92111fa0-a808-84da-19b8-823ad6a26a99@benettiengineering.com>
 <3857d0ce-ba29-d92e-3e24-9dfc33cfc7f9@benettiengineering.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <b98b367b-3fbb-99d4-b1af-e7e7f6a1728c@RedHat.com>
Date:   Wed, 22 Jan 2020 14:30:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <3857d0ce-ba29-d92e-3e24-9dfc33cfc7f9@benettiengineering.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/22/20 1:54 PM, Giulio Benetti wrote:
> Hi Steve, Petr,
> 
> On 1/22/20 7:11 PM, Giulio Benetti wrote:
>> Hi Steve,
>>
>> On 1/22/20 6:56 PM, Steve Dickson wrote:
>>>
>>>
>>> On 1/15/20 11:08 AM, Giulio Benetti wrote:
>>>> Currently locktest can be built only for host because CC_FOR_BUILD is
>>>> specified as CC, but this leads to build failure when passing CFLAGS not
>>>> available on host gcc(i.e. -mlongcalls) and most of all locktest would
>>>> be available on target systems the same way as rpcgen etc. So remove CC
>>>> and LIBTOOL assignments.
>>>>
>>>> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
>>> Committed... (tag: nfs-utils-2-4-3-rc6)
>>
>> I've just setup up a Gentoo to try building nfs-utils, I give a try
>> anyway by now, so we should be sure.
> 
> Just tried, it builds correctly on latest Gentoo.
Good to hear... Thank you for your effort!!!!

steved.

