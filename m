Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5CCB14588F
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2020 16:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgAVPYY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jan 2020 10:24:24 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40434 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725802AbgAVPYY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jan 2020 10:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579706663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p2PdKnVWhblkqCyfNLUjHrEaTYiP6hp3ap+JAXEg36s=;
        b=N8HCV5JuTF4amatb51bbOMBXEmncOyh1rLscLr/9714Uax0St9NBO0yf51IkZp9Tkq2LDc
        jOqIkvRiymBo/xyQLxmK4IOX9ypDHLOpqU4dGZLxVlkNv497Ad/SoTqOqfAWwEIXu/HQ6c
        IaAaQydprWCRFZ35ZuQnbX9xgr0wUuU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428--IW-CnW8P1qazW83UGvZUA-1; Wed, 22 Jan 2020 10:24:21 -0500
X-MC-Unique: -IW-CnW8P1qazW83UGvZUA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C68F0102CE29;
        Wed, 22 Jan 2020 15:24:19 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (madhat.boston.devel.redhat.com [10.19.60.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D2415C1BB;
        Wed, 22 Jan 2020 15:24:19 +0000 (UTC)
Subject: Re: [nfs-utils PATCH] locktest: Makefile.am: remove host compiler
 costraint
To:     Petr Vorel <petr.vorel@gmail.com>
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        linux-nfs@vger.kernel.org, Mike Frysinger <vapier@gentoo.org>
References: <20200115160806.99991-1-giulio.benetti@benettiengineering.com>
 <20200119191047.GB11432@dell5510>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <6606c604-61ef-a3fa-8ced-1d9dfb822f64@RedHat.com>
Date:   Wed, 22 Jan 2020 10:24:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200119191047.GB11432@dell5510>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Petr,

On 1/19/20 2:10 PM, Petr Vorel wrote:
> Hi,
> 
>> Currently locktest can be built only for host because CC_FOR_BUILD is
>> specified as CC, but this leads to build failure when passing CFLAGS not
>> available on host gcc(i.e. -mlongcalls) and most of all locktest would
>> be available on target systems the same way as rpcgen etc. So remove CC
>> and LIBTOOL assignments.
> 
>> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
> Tested-by: Petr Vorel <petr.vorel@gmail.com>
> NOTE: as I understand it's a compilation issue of a tool, so I didn't run
> rpcgen, I just test various compilation variants for buildroot.
Just to be clear... Giulio's patch, removing CC and LIBTOOL from the
locktest/Makefile.am does allows your cross build to succeed, correct?

steved.

> 
> Kind regards,
> Petr
> 
>> ---
>>  tools/locktest/Makefile.am | 3 ---
>>  1 file changed, 3 deletions(-)
> 
>> diff --git a/tools/locktest/Makefile.am b/tools/locktest/Makefile.am
>> index 3156815d..e8914655 100644
>> --- a/tools/locktest/Makefile.am
>> +++ b/tools/locktest/Makefile.am
>> @@ -1,8 +1,5 @@
>>  ## Process this file with automake to produce Makefile.in
> 
>> -CC=$(CC_FOR_BUILD)
>> -LIBTOOL = @LIBTOOL@ --tag=CC
>> -
>>  noinst_PROGRAMS = testlk
>>  testlk_SOURCES = testlk.c
>>  testlk_CFLAGS=$(CFLAGS_FOR_BUILD)
> 

