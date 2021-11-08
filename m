Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147CB449AAA
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Nov 2021 18:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238586AbhKHRWh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Nov 2021 12:22:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51166 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229966AbhKHRWg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Nov 2021 12:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636391991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KMAhcwb1oF8s+7mfW1ptwp/i1fLNBnc5KLZGHl0R0Fk=;
        b=eCoglUyfOg9lSHRpal7/VxrAeL5sXuACtGESzpR8oJkmK26vwCv857IRxOSCj1rzvQrk1T
        81w8TaFL3itheewh8MXbZV1pniYO3gBA0bqP1QZH/oXwcmoqh/EoRVgSSoqVwQR2gvgx1B
        rf8jn4Ah0Pp3i0EusZUjhi9kDWLXcZs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-gXqs3B-JPs-CAmYL4czW7A-1; Mon, 08 Nov 2021 12:19:50 -0500
X-MC-Unique: gXqs3B-JPs-CAmYL4czW7A-1
Received: by mail-qt1-f197.google.com with SMTP id c2-20020a05622a024200b002acaee74c29so11169167qtx.16
        for <linux-nfs@vger.kernel.org>; Mon, 08 Nov 2021 09:19:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=KMAhcwb1oF8s+7mfW1ptwp/i1fLNBnc5KLZGHl0R0Fk=;
        b=sxAC/TbD0+vGRrxFsAfG2F5Use2xSd9VTNKzmW2ZATvyRvU/79syhJT/KoG5XCiGAx
         vs3pC0XmoKagOwqbtynbgohf2SjrxE7PQ6fi5NLmA9qFWcsUtxSrEK2JOO3bPKZ7JTFl
         2lIetBaKRhaYd/ro3iOzUJIVMQsCozFlReQS0xl4XyFvFW+xopJ+/eSC3yYYDApbjxOs
         +xaI3Uby+96ZKzfhOE8quUweWjLLkX1E5lCF0pcdMbzD/biyEp3s2R1Kp2ihj5je5Dqi
         KSst5lPE37zVLdWYVnygIyfrD2THiKQK39WwUPtlrWV3PZ/7ogE/D4spgbcRqDvFHaPP
         Ibxg==
X-Gm-Message-State: AOAM533x+OmYe+vfN+u2y5iGaIcGXSwJEBREzuPZbGQLaqRtuDUjiAqd
        2tbYPa8PaiXV262OdkSjjKBBvWLEtObgrGJFpAp8IAa0NJNwAF2HZ5RrornUwqn6YpTkNjDBlgk
        nIQKH5CucfIz5/KntrTbg
X-Received: by 2002:a05:6214:27e3:: with SMTP id jt3mr921897qvb.44.1636391989553;
        Mon, 08 Nov 2021 09:19:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwkBr/reJa8fjgyJl78AxcCCCSWYrkXOQDKk86cKg2eeWm7Pi99rHKWXdzcPm960aFJuywQIg==
X-Received: by 2002:a05:6214:27e3:: with SMTP id jt3mr921876qvb.44.1636391989316;
        Mon, 08 Nov 2021 09:19:49 -0800 (PST)
Received: from [172.31.1.6] ([71.161.195.179])
        by smtp.gmail.com with ESMTPSA id y8sm10438823qko.36.2021.11.08.09.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 09:19:49 -0800 (PST)
Message-ID: <c753a360-2ad1-0dc9-074a-a6a3460386dc@redhat.com>
Date:   Mon, 8 Nov 2021 12:19:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v5 9/9] rpcctl: Add installation to the Makefile
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
To:     schumaker.anna@gmail.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
References: <20211028183519.160772-1-Anna.Schumaker@Netapp.com>
 <20211028183519.160772-10-Anna.Schumaker@Netapp.com>
 <f9e404ec-4e7f-3673-73a5-0df1bd8cf52d@redhat.com>
In-Reply-To: <f9e404ec-4e7f-3673-73a5-0df1bd8cf52d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/8/21 12:15, Steve Dickson wrote:
> Hello,
> 
> On 10/28/21 14:35, schumaker.anna@gmail.com wrote:
>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>
>> And create a shell script that launches the python program from the
>> $(libdir)
>>
>> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>> ---
>>   configure.ac             |  1 +
>>   tools/Makefile.am        |  2 +-
>>   tools/rpcctl/Makefile.am | 20 ++++++++++++++++++++
>>   tools/rpcctl/rpcctl      |  5 +++++
>>   4 files changed, 27 insertions(+), 1 deletion(-)
>>   create mode 100644 tools/rpcctl/Makefile.am
>>   create mode 100644 tools/rpcctl/rpcctl
>>
>> diff --git a/configure.ac b/configure.ac
>> index 93626d62be40..dcd3be0c8a8b 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -737,6 +737,7 @@ AC_CONFIG_FILES([
>>       tools/rpcgen/Makefile
>>       tools/mountstats/Makefile
>>       tools/nfs-iostat/Makefile
>> +    tools/rpcctl/Makefile
>>       tools/nfsdclnts/Makefile
>>       tools/nfsconf/Makefile
>>       tools/nfsdclddb/Makefile
>> diff --git a/tools/Makefile.am b/tools/Makefile.am
>> index 9b4b0803db39..c3feabbec681 100644
>> --- a/tools/Makefile.am
>> +++ b/tools/Makefile.am
>> @@ -12,6 +12,6 @@ if CONFIG_NFSDCLD
>>   OPTDIRS += nfsdclddb
>>   endif
>> -SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat nfsdclnts 
>> $(OPTDIRS)
>> +SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat rpcctl 
>> nfsdclnts $(OPTDIRS)
>>   MAINTAINERCLEANFILES = Makefile.in
>> diff --git a/tools/rpcctl/Makefile.am b/tools/rpcctl/Makefile.am
>> new file mode 100644
>> index 000000000000..f4237dbc89e5
>> --- /dev/null
>> +++ b/tools/rpcctl/Makefile.am
>> @@ -0,0 +1,20 @@
>> +## Process this file with automake to produce Makefile.in
>> +PYTHON_FILES =  rpcctl.py client.py switch.py sysfs.py xprt.py
>> +tooldir = $(DESTDIR)$(libdir)/rpcctl
>> +
>> +man8_MANS = rpcctl.man
>> +
>> +all-local: $(PYTHON_FILES)
>> +
>> +install-data-hook:
>> +    mkdir -p $(tooldir)
>> +    for f in $(PYTHON_FILES) ; do \
>> +        $(INSTALL) -m 644 $$f $(tooldir)/$$f ; \
>> +    done
>> +    chmod +x $(tooldir)/rpcctl.py
>> +    $(INSTALL) -m 755 rpcctl $(DESTDIR)$(sbindir)/rpcctl
>> +    sed -i "s|LIBDIR=.|LIBDIR=$(tooldir)|" $(DESTDIR)$(sbindir)/rpcctl
> A couple issues here....
> 
> * Changing a file after installed breaks rpm process since it
>    changes the checksum of the file so the process thinks it is
>    an undeclared file.
> 
> * Why is the $(sbindir)/rpcctl wrapper even needed?
>    Why not simply put the code that is in $(tooldir)/rpcctl.py
>    in the /usr/sbin/rpcctl?
> 
> * It appears the proper place to put .py modules is
>    under /usr/lib/python-<ver>/rpcctl not /usr/lib64/rpcctl
Correction: under /usr/lib/python-<ver>/site-packages/
> 
> Finally when I manually set  LIBDIR=/usr/lib64/rpcctl in
> the /usr/sbin/rpcctl wrapper all I got was
> # rpcctl --help
> ERROR: sysfs is not mounted
> 
> So I know it was seeing sys.py module but not seeing
> /sys/kernel/sunrpc/ which does exist.
> 
> # ls /sys/kernel/sunrpc/
> ./  ../  rpc-clients/  xprt-switches/
> 
> So my suggestion is get rid of that wrapper
> and look under /usr/lib/python-<ver>/rpcctl
The same correction here... under
/usr/lib/python-<ver>/site-packages/rpcctl

steved.
> for the .py modules.
> 
> steved.
> 
>> +
>> +
>> +
>> +MAINTAINERCLEANFILES=Makefile.in
>> diff --git a/tools/rpcctl/rpcctl b/tools/rpcctl/rpcctl
>> new file mode 100644
>> index 000000000000..4cc35e1ea3f9
>> --- /dev/null
>> +++ b/tools/rpcctl/rpcctl
>> @@ -0,0 +1,5 @@
>> +#!/bin/bash
>> +LIBDIR=.
>> +PYTHON3=/usr/bin/python
>> +
>> +exec $PYTHON3 $LIBDIR/rpcctl.py $*
>>

