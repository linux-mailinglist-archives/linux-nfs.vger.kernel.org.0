Return-Path: <linux-nfs+bounces-379-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A34807B4F
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 23:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25741F21097
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 22:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD7E56382;
	Wed,  6 Dec 2023 22:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="Kcegv2Pw"
X-Original-To: linux-nfs@vger.kernel.org
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Dec 2023 14:25:48 PST
Received: from smtpcmd14162.aruba.it (smtpcmd14162.aruba.it [62.149.156.162])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5615DD5B
	for <linux-nfs@vger.kernel.org>; Wed,  6 Dec 2023 14:25:48 -0800 (PST)
Received: from [192.168.50.162] ([84.33.84.190])
	by Aruba Outgoing Smtp  with ESMTPSA
	id B0JvrZw72ieE0B0JvrnP99; Wed, 06 Dec 2023 23:24:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1701901483; bh=4M2E+69iWkg4AEIKfqQkLlrSOoItSkVIaGgXqhBBgvc=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=Kcegv2PwxFogA/LV96quUYX+SRXj1anKB0bEamvlSc8pmijeV4UOZeX+l3awzKPSP
	 +8V4Zz10/t1hYomZbsgN46kPAKdi/rMDU25SRuNW1g22VgBV07Y47qzfeXGzbxaRNh
	 q4Is/AL9GWjQt9aKnvMvh5b2QZVEh+J0HS6gTnvHfaOkztxXUUZDRL/LTGJX0RTwzg
	 l0MwN5663G3EJseE9akSsGmClgsw9kcpBHeC2nSp2yXRKUG0XQe01VgbsI3r/0omjv
	 jcYiLXEdFMzIHMxYQIAw4RGR+YXaRfRkzmwsfAX6ipKs7sm+f3OItspMDkP2gMPCgd
	 i4+AmH5k2MqgQ==
Message-ID: <3c07e0a6-b797-410c-9cf3-bc5e49a5ca10@benettiengineering.com>
Date: Wed, 6 Dec 2023 23:24:43 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] support/backend_sqlite.c: Add missing <sys/syscall.h>
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
Cc: linux-nfs@vger.kernel.org, Petr Vorel <petr.vorel@gmail.com>,
 Steve Dickson <steved@redhat.com>
References: <20231205223543.31443-1-pvorel@suse.cz>
 <20231205223543.31443-2-pvorel@suse.cz>
 <be8ead05-1ebd-45c8-84e7-78b6b0e7202b@benettiengineering.com>
 <20231206194220.GA159824@pevik>
From: Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <20231206194220.GA159824@pevik>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfItIl09b4kUeq+s3AaOJmSghZFOgt8ZsfiYSCLA2iswVeAsNKonVdUzyUWU4GCA+SXNb9MP7MTG64tTIAmqKiOvSU5ISmGe7Uct0Huq8gaFNzroh0s1A
 ngihevR4+yrFTUToWELPSmfKmJ548kwf17ntwvfj3tBPjZ0RfMGB1jwfBW1mn3JqlRVrG8YuSF1rghGBJrfRjz4sFuhlChj/Y2HVotniD93o37R5Dy/e+L3y
 VEYVnLCCwVA1GHVUPMgjFDUZA2xSdCRZLn+lPMM3iR9TSgT7LuYHSP/t/SuXoULPsVI3naJlN220vHU/Y5/cvA==

Hi Petr,

On 06/12/23 20:42, Petr Vorel wrote:
> Hi Giulio,
> 
>> Hi Petr,
>> On 05/12/23 23:35, Petr Vorel wrote:
>>> From: Petr Vorel<petr.vorel@gmail.com>
>>> This fixes build on systems which actually needs getrandom()
>>> (to get SYS_getrandom).
>>> Fixes: f92fd6ca ("support/backend_sqlite.c: Add getrandom() fallback")
>>> Fixes:http://autobuild.buildroot.net/results/c5fde6099a8b228a8bdc3154d1e47dfa192e94ed/
>>> Reported-by: Giulio Benetti<giulio.benetti@benettiengineering.com>
>>> Signed-off-by: Petr Vorel<pvorel@suse.cz>
>> thank you for fixing. I've tested this and the other patch with
>> Buildroot's test-pkg and built fine for many toolchain/arch/libc
>> combinations.
> Thank you for extensive testing! I test only the basic 6 tests (the default
> test-pkg).  I suppose you run test-pkg also with -a (these 45 arch
> combinations).

Exactly, I've only found a build failure on util-linux's libmount while 
building for sh4+uclibc with bootlin toolchain. See defconfig and log here:
https://pastebin.com/8rxgxvvQ
So that's not due to nfs-utils.

>> Reviewed-by: Giulio Benetti<giulio.benetti@benettiengineering.com>
> Maybe you can add your Tested-by: ?

Sure, good idea.

After running Buildroot utils/test-pkg under Buildroot official docker
using this and previous patch everything built fine except on sh4+uclibc
where util-linux libmount fails(see above). These are the results:
```
br-user@giulio-Ubuntu-HP:/home/giuliobenetti/git/upstream/buildroot$ 
./utils/test-pkg -p nfs-utils -d test-nfs-utils/ -a
                              arm-aarch64 [ 1/45]: OK
                    bootlin-aarch64-glibc [ 2/45]: OK
                bootlin-arcle-hs38-uclibc [ 3/45]: OK
                     bootlin-armv5-uclibc [ 4/45]: OK
                      bootlin-armv7-glibc [ 5/45]: OK
                    bootlin-armv7m-uclibc [ 6/45]: SKIPPED
                       bootlin-armv7-musl [ 7/45]: OK
                 bootlin-m68k-5208-uclibc [ 8/45]: SKIPPED
                bootlin-m68k-68040-uclibc [ 9/45]: OK
              bootlin-microblazeel-uclibc [10/45]: OK
                 bootlin-mipsel32r6-glibc [11/45]: OK
                    bootlin-mipsel-uclibc [12/45]: OK
                      bootlin-nios2-glibc [13/45]: OK
                  bootlin-openrisc-uclibc [14/45]: OK
         bootlin-powerpc64le-power8-glibc [15/45]: OK
            bootlin-powerpc-e500mc-uclibc [16/45]: OK
                    bootlin-riscv32-glibc [17/45]: OK
                    bootlin-riscv64-glibc [18/45]: OK
                     bootlin-riscv64-musl [19/45]: OK
                  bootlin-s390x-z13-glibc [20/45]: OK
                       bootlin-sh4-uclibc [21/45]: FAILED
                    bootlin-sparc64-glibc [22/45]: OK
                     bootlin-sparc-uclibc [23/45]: OK
                     bootlin-x86-64-glibc [24/45]: OK
                      bootlin-x86-64-musl [25/45]: OK
                    bootlin-x86-64-uclibc [26/45]: OK
                    bootlin-xtensa-uclibc [27/45]: OK
                             br-arm-basic [28/45]: OK
                     br-arm-full-nothread [29/45]: SKIPPED
                       br-arm-full-static [30/45]: OK
                    br-i386-pentium4-full [31/45]: OK
                 br-i386-pentium-mmx-musl [32/45]: OK
                       br-mips64-n64-full [33/45]: OK
                  br-mips64r6-el-hf-glibc [34/45]: OK
                br-powerpc-603e-basic-cpp [35/45]: OK
                br-powerpc64-power7-glibc [36/45]: OK
                        linaro-aarch64-be [37/45]: OK
                           linaro-aarch64 [38/45]: OK
                               linaro-arm [39/45]: OK
                      sourcery-arm-armv4t [40/45]: SKIPPED
                             sourcery-arm [41/45]: SKIPPED
                      sourcery-arm-thumb2 [42/45]: SKIPPED
                          sourcery-mips64 [43/45]: OK
                            sourcery-mips [44/45]: OK
                           sourcery-nios2 [45/45]: OK
45 builds, 6 skipped, 1 build failed, 0 legal-info failed, 0 show-info 
failed
```

So:
Tested-by: Giulio Benetti <giulio.benetti@benettiengineering.com>

Kind regards
-- 
Giulio Benetti
CEO&CTO@Benetti Engineering sas

