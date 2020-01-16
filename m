Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A66E13FB9F
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2020 22:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgAPVe4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jan 2020 16:34:56 -0500
Received: from smtpcmd03116.aruba.it ([62.149.158.116]:56089 "EHLO
        smtpcmd03116.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbgAPVez (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jan 2020 16:34:55 -0500
Received: from [192.168.126.128] ([146.241.70.103])
        by smtpcmd03.ad.aruba.it with bizsmtp
        id r9as2100Z2DhmGq019atWq; Thu, 16 Jan 2020 22:34:53 +0100
Subject: Re: [nfs-utils RESENT PATCH 1/1] locktes/rpcgen: tweak how we
 override compiler settings
To:     Steve Dickson <SteveD@RedHat.com>,
        Petr Vorel <petr.vorel@gmail.com>
Cc:     linux-nfs@vger.kernel.org, Mike Frysinger <vapier@gentoo.org>
References: <20200105120502.765426-1-petr.vorel@gmail.com>
 <fb4dd073-856a-7807-eb71-f594e58732cb@RedHat.com>
 <bda9e61c-1a06-5ab3-339f-c38e9a68fb73@RedHat.com>
 <20200114183603.GA24556@dell5510>
 <db2c8006-5520-e34e-b759-42783f965d1c@RedHat.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Message-ID: <5149cf4e-7d78-2cbd-99e4-a4cb66822308@benettiengineering.com>
Date:   Thu, 16 Jan 2020 22:34:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <db2c8006-5520-e34e-b759-42783f965d1c@RedHat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1579210493; bh=RyBCpy9qg4lAZICuIeHfVC8piRyCIXIU8o9f8qaTrRk=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=kNaShwDX2JigRp6g+wPt0po/YDtNIKChUek6DpYSlKFWlMBrGnAVOkmmMLGGbuv6l
         avAs9j0WVvPM3etEiiX9dEvbKMstRH7h29tFnBeNWRXhCC7p9owOBHhBhuEO+JBiGF
         FisCRFoYot1WOaQY7V2Xf8tKIY5/Ojk0xp6N5n3oZynMtXXNVc7HNCxl44/lSx6VEb
         +lIaa7XG5v+UUCwmaIE72JlPthVrUH+G4WgjwdQTnVqaLE6EM0G1rxxqDuhQ6chCCl
         KgcVZys7JXWREqlWNNvyxrCjUKW7U23BCPMe6sZ43yHyhwA3BH530+y9bbkUCkBy7F
         emXANdilbmSDg==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Steve, Petr,

On 1/16/20 10:22 PM, Steve Dickson wrote:
> 
> 
> On 1/14/20 1:36 PM, Petr Vorel wrote:
>> Hi Steve,
>>
>>> Actually try this one... the one that works! ;-)
>>
>>> diff --git a/tools/locktest/Makefile.am b/tools/locktest/Makefile.am
>>> index 3156815..d5cf8da 100644
>>> --- a/tools/locktest/Makefile.am
>>> +++ b/tools/locktest/Makefile.am
>>> @@ -1,12 +1,11 @@
>>>   ## Process this file with automake to produce Makefile.in
>>
>>>   CC=$(CC_FOR_BUILD)
>>> -LIBTOOL = @LIBTOOL@ --tag=CC
>>> +AM_CFLAGS=$(CFLAGS_FOR_BUILD)
>>> +AM_CPPFLAGS=$(CPPFLAGS_FOR_BUILD)
>>> +AM_LDFLAGS=$(LDFLAGS_FOR_BUILD)
>>
>>>   noinst_PROGRAMS = testlk
>>>   testlk_SOURCES = testlk.c
>>> -testlk_CFLAGS=$(CFLAGS_FOR_BUILD)
>>> -testlk_CPPFLAGS=$(CPPFLAGS_FOR_BUILD)
>>> -testlk_LDFLAGS=$(LDFLAGS_FOR_BUILD)
>>
>>>   MAINTAINERCLEANFILES = Makefile.in
>>> diff --git a/tools/rpcgen/Makefile.am b/tools/rpcgen/Makefile.am
>>> index 8a9ec89..84cafb2 100644
>>> --- a/tools/rpcgen/Makefile.am
>>> +++ b/tools/rpcgen/Makefile.am
>>> @@ -1,7 +1,9 @@
>>>   ## Process this file with automake to produce Makefile.in
>>
>>>   CC=$(CC_FOR_BUILD)
>>> -LIBTOOL = @LIBTOOL@ --tag=CC
>>> +AM_CFLAGS=$(CFLAGS_FOR_BUILD) ${TIRPC_CFLAGS}
>>> +AM_CPPFLAGS=$(CPPFLAGS_FOR_BUILD)
>>> +AM_LDFLAGS=$(LDFLAGS_FOR_BUILD)
>>
>>>   noinst_PROGRAMS = rpcgen
>>>   rpcgen_SOURCES = rpc_clntout.c rpc_cout.c rpc_hout.c rpc_main.c \
>>> @@ -9,11 +11,6 @@ rpcgen_SOURCES = rpc_clntout.c rpc_cout.c rpc_hout.c rpc_main.c \
>>>                   rpc_util.c rpc_sample.c rpc_output.h rpc_parse.h \
>>>                   rpc_scan.h rpc_util.h
>>
>>> -rpcgen_CFLAGS=$(CFLAGS_FOR_BUILD)
>>> -rpcgen_CPPLAGS=$(CPPFLAGS_FOR_BUILD)
>>> -rpcgen_LDFLAGS=$(LDFLAGS_FOR_BUILD)
>>> -rpcgen_LDADD=$(LIBTIRPC)
>>> -
>>>   MAINTAINERCLEANFILES = Makefile.in
>>
>>>   EXTRA_DIST = rpcgen.new.1
>>
>> IMHO this one don't work for cross-compilation, tested on buildroot:
>>
>> PATH="/br-test-pkg/br-arm-full-static/host/bin:/br-test-pkg/br-arm-full-static/host/sbin:/.common/bin/suse:/.local/bin:/.gem/ruby/2.2.0/bin:/bin/:~/.local/bin/:/.common/bin/:~/.vim/bin/:/usr/sbin/:/sbin/:/home/pevik/.common/bin/suse:/home/pevik/bin/:~/.local/bin/:/home/pevik/.common/bin/:~/.vim/bin/:/usr/sbin/:/sbin/:/bin:/usr/local/bin:/usr/bin:/bin:/usr/lib/mit/bin:/usr/lib/mit/sbin:/usr/X11R6/bin"  /usr/bin/make -j9  -C /br-test-pkg/br-arm-full-static/build/nfs-utils-1.3.4/
>> make[1]: Entering directory '/br-test-pkg/br-arm-full-static/build/nfs-utils-1.3.4'
>> Making all in tools
>> make[2]: Entering directory '/br-test-pkg/br-arm-full-static/build/nfs-utils-1.3.4/tools'
>> Making all in locktest
>> make[3]: Entering directory '/br-test-pkg/br-arm-full-static/build/nfs-utils-1.3.4/tools/locktest'
>> /usr/bin/gcc -DHAVE_CONFIG_H -I. -I../../support/include  -I/br-test-pkg/br-arm-full-static/host/include -D_GNU_SOURCE -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE -O2 -I/br-test-pkg/br-arm-full-static/host/include -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64  -Os   -static -c -o testlk.o testlk.c
>> /bin/sh ../../libtool --tag=CC  --tag=CC   --mode=link /usr/bin/gcc -O2 -I/br-test-pkg/br-arm-full-static/host/include -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64  -Os   -static -L/br-test-pkg/br-arm-full-static/host/lib -Wl,-rpath,/br-test-pkg/br-arm-full-static/host/lib -static -o testlk testlk.o
>> libtool: link: /usr/bin/gcc -O2 -I/br-test-pkg/br-arm-full-static/host/include -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -Os -static -Wl,-rpath -Wl,/br-test-pkg/br-arm-full-static/host/lib -static -o testlk testlk.o  -L/br-test-pkg/br-arm-full-static/host/lib
>> /usr/lib64/gcc/x86_64-suse-linux/9/../../../../x86_64-suse-linux/bin/ld: cannot find -lc
> Who/how is -lc getting specified? Maybe the problem is how $(LDFLAGS_FOR_BUILD) is being set?
> 
> Note... Giulio's patch is doing something similar
> https://lore.kernel.org/linux-nfs/20200115160806.99991-1-giulio.benetti@benettiengineering.com/T/#u
> 
> Does something like that as well as setting the AM_XXX help the your cross-compile?

IMHO tools/* utility must be built with cross-compiler too, not with 
/usr/bin/gcc. Buildroot provide host-nfs-utils for that, especially for 
rpcgen.

Please take a look at my WIP patch for bumping nfs-utils to latest in 
Buildroot:
https://github.com/giuliobenetti/buildroot/commit/12671eb21d62a5474dc476381015069382775668

and please note this line:
--with-rpcgen=$(HOST_DIR)/bin/rpcgen

that means that nfs-utils must use already host-nfs-utils/rpcgen instead 
of internal one to generate rpcs. This is why tools/* is not needed as 
host to build target. Indeed host-nfs-utils is built when nfs-utils is 
built. At least I understand this.

Can you Petr confirm that?
Because at this point the patch you're pointing is not needed.

Best regards
-- 
Giulio Benetti
Benetti Engineering sas

> steved.
> 
> 
>> collect2: error: ld returned 1 exit status
>> make[3]: *** [Makefile:417: testlk] Error 1
>> make[3]: Leaving directory '/br-test-pkg/br-arm-full-static/build/nfs-utils-1.3.4/tools/locktest'
>> make[2]: *** [Makefile:429: all-recursive] Error 1
>> make[2]: Leaving directory '/br-test-pkg/br-arm-full-static/build/nfs-utils-1.3.4/tools'
>> make[1]: *** [Makefile:469: all-recursive] Error 1
>> make[1]: Leaving directory '/br-test-pkg/br-arm-full-static/build/nfs-utils-1.3.4'
>> make: *** [package/pkg-generic.mk:260: /br-test-pkg/br-arm-full-static/build/nfs-utils-1.3.4/.stamp_built] Error 2
>>
>> I can send you more debug info, but IMHO Mike's patch is really needed.
>>
>> Kind regards,
>> Petr
>>
> 

