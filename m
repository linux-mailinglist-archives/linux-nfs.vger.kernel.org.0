Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 231D813FB58
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2020 22:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388922AbgAPVWN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jan 2020 16:22:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33716 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388911AbgAPVWM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jan 2020 16:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579209731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rCVpWwYPTytsc1tRkXeIFDxOc0V4pstXJDXOztwTUvk=;
        b=DhZXG4weZcQcnXcxaYobAcrdBw1NtPX6yTgoGVpkryT70MavonLrDIoMhWo/0yZLgigsko
        QMWTRSb2eE3fqtA/qHFLzFb20+lZQaISL8trfqY0SAJrSG/a+Dh4O5ZjdeAyD5gfm33+/Y
        sC6Yvplbb1RstmI4SRy2IJj0VN5ytc0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-Cy1-tYiRMXuNim286EG0Ag-1; Thu, 16 Jan 2020 16:22:05 -0500
X-MC-Unique: Cy1-tYiRMXuNim286EG0Ag-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A217A800D4E;
        Thu, 16 Jan 2020 21:22:04 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-35.phx2.redhat.com [10.3.117.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21C595C545;
        Thu, 16 Jan 2020 21:22:04 +0000 (UTC)
Subject: Re: [nfs-utils RESENT PATCH 1/1] locktes/rpcgen: tweak how we
 override compiler settings
To:     Petr Vorel <petr.vorel@gmail.com>
Cc:     linux-nfs@vger.kernel.org, Mike Frysinger <vapier@gentoo.org>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
References: <20200105120502.765426-1-petr.vorel@gmail.com>
 <fb4dd073-856a-7807-eb71-f594e58732cb@RedHat.com>
 <bda9e61c-1a06-5ab3-339f-c38e9a68fb73@RedHat.com>
 <20200114183603.GA24556@dell5510>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <db2c8006-5520-e34e-b759-42783f965d1c@RedHat.com>
Date:   Thu, 16 Jan 2020 16:22:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114183603.GA24556@dell5510>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/14/20 1:36 PM, Petr Vorel wrote:
> Hi Steve,
> 
>> Actually try this one... the one that works! ;-) 
> 
>> diff --git a/tools/locktest/Makefile.am b/tools/locktest/Makefile.am
>> index 3156815..d5cf8da 100644
>> --- a/tools/locktest/Makefile.am
>> +++ b/tools/locktest/Makefile.am
>> @@ -1,12 +1,11 @@
>>  ## Process this file with automake to produce Makefile.in
> 
>>  CC=$(CC_FOR_BUILD)
>> -LIBTOOL = @LIBTOOL@ --tag=CC
>> +AM_CFLAGS=$(CFLAGS_FOR_BUILD)
>> +AM_CPPFLAGS=$(CPPFLAGS_FOR_BUILD)
>> +AM_LDFLAGS=$(LDFLAGS_FOR_BUILD)
> 
>>  noinst_PROGRAMS = testlk
>>  testlk_SOURCES = testlk.c
>> -testlk_CFLAGS=$(CFLAGS_FOR_BUILD)
>> -testlk_CPPFLAGS=$(CPPFLAGS_FOR_BUILD)
>> -testlk_LDFLAGS=$(LDFLAGS_FOR_BUILD)
> 
>>  MAINTAINERCLEANFILES = Makefile.in
>> diff --git a/tools/rpcgen/Makefile.am b/tools/rpcgen/Makefile.am
>> index 8a9ec89..84cafb2 100644
>> --- a/tools/rpcgen/Makefile.am
>> +++ b/tools/rpcgen/Makefile.am
>> @@ -1,7 +1,9 @@
>>  ## Process this file with automake to produce Makefile.in
> 
>>  CC=$(CC_FOR_BUILD)
>> -LIBTOOL = @LIBTOOL@ --tag=CC
>> +AM_CFLAGS=$(CFLAGS_FOR_BUILD) ${TIRPC_CFLAGS}
>> +AM_CPPFLAGS=$(CPPFLAGS_FOR_BUILD)
>> +AM_LDFLAGS=$(LDFLAGS_FOR_BUILD)
> 
>>  noinst_PROGRAMS = rpcgen
>>  rpcgen_SOURCES = rpc_clntout.c rpc_cout.c rpc_hout.c rpc_main.c \
>> @@ -9,11 +11,6 @@ rpcgen_SOURCES = rpc_clntout.c rpc_cout.c rpc_hout.c rpc_main.c \
>>                  rpc_util.c rpc_sample.c rpc_output.h rpc_parse.h \
>>                  rpc_scan.h rpc_util.h
> 
>> -rpcgen_CFLAGS=$(CFLAGS_FOR_BUILD)
>> -rpcgen_CPPLAGS=$(CPPFLAGS_FOR_BUILD)
>> -rpcgen_LDFLAGS=$(LDFLAGS_FOR_BUILD)
>> -rpcgen_LDADD=$(LIBTIRPC)
>> -
>>  MAINTAINERCLEANFILES = Makefile.in
> 
>>  EXTRA_DIST = rpcgen.new.1
> 
> IMHO this one don't work for cross-compilation, tested on buildroot:
> 
> PATH="/br-test-pkg/br-arm-full-static/host/bin:/br-test-pkg/br-arm-full-static/host/sbin:/.common/bin/suse:/.local/bin:/.gem/ruby/2.2.0/bin:/bin/:~/.local/bin/:/.common/bin/:~/.vim/bin/:/usr/sbin/:/sbin/:/home/pevik/.common/bin/suse:/home/pevik/bin/:~/.local/bin/:/home/pevik/.common/bin/:~/.vim/bin/:/usr/sbin/:/sbin/:/bin:/usr/local/bin:/usr/bin:/bin:/usr/lib/mit/bin:/usr/lib/mit/sbin:/usr/X11R6/bin"  /usr/bin/make -j9  -C /br-test-pkg/br-arm-full-static/build/nfs-utils-1.3.4/
> make[1]: Entering directory '/br-test-pkg/br-arm-full-static/build/nfs-utils-1.3.4'
> Making all in tools
> make[2]: Entering directory '/br-test-pkg/br-arm-full-static/build/nfs-utils-1.3.4/tools'
> Making all in locktest
> make[3]: Entering directory '/br-test-pkg/br-arm-full-static/build/nfs-utils-1.3.4/tools/locktest'
> /usr/bin/gcc -DHAVE_CONFIG_H -I. -I../../support/include  -I/br-test-pkg/br-arm-full-static/host/include -D_GNU_SOURCE -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE -O2 -I/br-test-pkg/br-arm-full-static/host/include -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64  -Os   -static -c -o testlk.o testlk.c
> /bin/sh ../../libtool --tag=CC  --tag=CC   --mode=link /usr/bin/gcc -O2 -I/br-test-pkg/br-arm-full-static/host/include -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64  -Os   -static -L/br-test-pkg/br-arm-full-static/host/lib -Wl,-rpath,/br-test-pkg/br-arm-full-static/host/lib -static -o testlk testlk.o  
> libtool: link: /usr/bin/gcc -O2 -I/br-test-pkg/br-arm-full-static/host/include -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -Os -static -Wl,-rpath -Wl,/br-test-pkg/br-arm-full-static/host/lib -static -o testlk testlk.o  -L/br-test-pkg/br-arm-full-static/host/lib
> /usr/lib64/gcc/x86_64-suse-linux/9/../../../../x86_64-suse-linux/bin/ld: cannot find -lc
Who/how is -lc getting specified? Maybe the problem is how $(LDFLAGS_FOR_BUILD) is being set? 

Note... Giulio's patch is doing something similar
https://lore.kernel.org/linux-nfs/20200115160806.99991-1-giulio.benetti@benettiengineering.com/T/#u

Does something like that as well as setting the AM_XXX help the your cross-compile?

steved.


> collect2: error: ld returned 1 exit status
> make[3]: *** [Makefile:417: testlk] Error 1
> make[3]: Leaving directory '/br-test-pkg/br-arm-full-static/build/nfs-utils-1.3.4/tools/locktest'
> make[2]: *** [Makefile:429: all-recursive] Error 1
> make[2]: Leaving directory '/br-test-pkg/br-arm-full-static/build/nfs-utils-1.3.4/tools'
> make[1]: *** [Makefile:469: all-recursive] Error 1
> make[1]: Leaving directory '/br-test-pkg/br-arm-full-static/build/nfs-utils-1.3.4'
> make: *** [package/pkg-generic.mk:260: /br-test-pkg/br-arm-full-static/build/nfs-utils-1.3.4/.stamp_built] Error 2
> 
> I can send you more debug info, but IMHO Mike's patch is really needed.
> 
> Kind regards,
> Petr
> 

