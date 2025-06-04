Return-Path: <linux-nfs+bounces-12114-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286F8ACE57E
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 22:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEBF33A8D98
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 20:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291B41940A1;
	Wed,  4 Jun 2025 20:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmNNetK2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA96111BF
	for <linux-nfs@vger.kernel.org>; Wed,  4 Jun 2025 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749067564; cv=none; b=rD72RuABmXngO5magkEGEAn3ocHrtD9dV0Dbp43XkZgWBCCPh4u4TkXW/BSdUf2/2iQXeC2YHlr5MZIGaR+E60A7oXIieSvDIhBjejLcbpCFeN61iM0XY+8mJ3jiMh+DOijK2EebgMsjFJZYzXy6GWM4B1AsE28bQlcxLkmPRHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749067564; c=relaxed/simple;
	bh=RylqUxfiPyzIiMpeIr20pjN1HKA8v38kVSMoLlZVjoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9bJ/lLje4rcEAk9L9udLn6ZFLPbjpRLEqDWCiuqN3YwLA6a0tDEB7bSJNjJAZ8DTuNR2VB3sar68d3/006oo6g3HL39PQ68Mzd5hC1ViF85p8Xut9qpGzGSGwp+KfF3Q/tPl7RHEGDfdHnFJVcAkU8FTi/pglw9eGDW+eYVAfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hmNNetK2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749067550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XHV0cDOgBg5ogcUU9mk7828v98sokJupoWg1rauZhI=;
	b=hmNNetK2/SNsv+5qRy3/ic2ANztwlgzSy70MlSnan9aJxE8vCxFrX59q1IEANrr+I1CcbR
	n1+ubgdMnNJ+25wKke+nI4ufI7r95F7IWMy40FrOsKqDjuk9/HlW9B8z9gNrzPZWwZ96yM
	46ssSNyBoFghEc+ZwO3Qqfm0yqT7oJ4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-IV1bt-3uOpSaQIK-gHhV4A-1; Wed, 04 Jun 2025 16:05:49 -0400
X-MC-Unique: IV1bt-3uOpSaQIK-gHhV4A-1
X-Mimecast-MFC-AGG-ID: IV1bt-3uOpSaQIK-gHhV4A_1749067549
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c760637fe5so46999485a.0
        for <linux-nfs@vger.kernel.org>; Wed, 04 Jun 2025 13:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749067549; x=1749672349;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8XHV0cDOgBg5ogcUU9mk7828v98sokJupoWg1rauZhI=;
        b=Z/sCLNFPhFqTp8WGnySc0mZWD+J3vUjzNuRL+noFX1YQmzPtN6J9iqtgtGiurabuvs
         7TzlHviCR16+tz3v4N2rpAH3KBQItC74ueLGP3YLn4gEVosNRRab0AoByCc3LUT0wUOg
         VjDdtDAFQix0NxtvnqTzzTWRh+WHq1qy09dhUuc3fxitMTTkqgT8gclh5LtCcdv0tE0Y
         ylYhKzibYFTdXSGNS+3qIgaZAvXassKeUeKqpIGSp7I2IsvwLLeBvlHLyHQYcsPi5UPU
         GZfVJl2HDBTRuKzmrSJABQQyBoxy2oF28WDDS9/nSvv5vTyWIkw+hoYd2shwTOqXZLUC
         K6VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKVpH8gjlEP5JifvY/TqdqsqhiUlzo6heqIr61iUdivkdr0R9cgZCQQifNpCJo7guhMUpULPUDwjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys8+NebiQYk3BaUbgOpxpdaKx/xDN7W7fsmIIhRULTeXDJpGhN
	iyjXJapNHcyx9mP6+mO7IxHCaksf8AxGtfeByi//FDuWz2TSmbIUsv4pmJkLeYdyGaLnjgnhwAh
	T9erp23Q5fDYk3185YDtgNRfYp7CEDONkKvyYnQwaXe5bu7WlWGlWmKLukUbC5A==
X-Gm-Gg: ASbGncsB+cl2E+Swnp5jkFeQU20buBfFWYLQu9q7Is2PBk2W3G9wWsoy5rV0gWlqa4T
	+DKAosEhnkjfEHaT2cl3kFAfetRWqMZ4uNFpNPeGI3LsfqfRNUKA56UPAX3YAnPI+rOSRMUu8t1
	Ab78MWhY0S4n5rck52+DDbwb90l4T1pNA6TZ/Q3PEpdZ4Mz/9/FQeO5ugD7RY3mFwgSCEo8Jjq7
	LGibv95NRpEnd77Rz7nSIOZOtLzwbhiGaGjsYgyeVpuP5Z6CUgk/vPDPOw0y7DNkDkKiDD8B1GY
	9p78/AnzrgI=
X-Received: by 2002:a05:620a:8809:b0:7d0:a1db:9d7a with SMTP id af79cd13be357-7d2198cd0camr696996285a.40.1749067548714;
        Wed, 04 Jun 2025 13:05:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKsEIPGpq1PbZE4O+fEKmN8unHmkeiLXm+Gb5zjfAEcyXQkzLvosyCAhjVj/P9G0pPvACzIA==
X-Received: by 2002:a05:620a:8809:b0:7d0:a1db:9d7a with SMTP id af79cd13be357-7d2198cd0camr696992385a.40.1749067548295;
        Wed, 04 Jun 2025 13:05:48 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.242.209])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a1bb27fsm1088524885a.116.2025.06.04.13.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 13:05:47 -0700 (PDT)
Message-ID: <96107ae9-4b95-4ce3-b163-d91251ae9439@redhat.com>
Date: Wed, 4 Jun 2025 16:05:46 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] rpcbind: detect support of remote calls
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, linux-nfs@vger.kernel.org,
 "Ricardo B. Marliere" <rbm@suse.com>, Avinesh Kumar <akumar@suse.de>
References: <20250602133741.GA324895@pevik>
 <bc6adca9-a7c0-4545-b32b-640994d135cb@redhat.com>
 <20250604194241.GA1159049@pevik>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250604194241.GA1159049@pevik>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/4/25 3:42 PM, Petr Vorel wrote:
> Hi Steve,
> 
>> Hey!
> 
>> On 6/2/25 9:37 AM, Petr Vorel wrote:
>>> Hi Steve,
> 
>>> Ricardo found that TI-RPC rpc_pmap_rmtcall [1] tirpc_rpcb_rmtcall [2] tests are
>>> failing when they use rpcbind *without* --enable-rmtcalls (the default since
>>> 2018, see 2e9c289 ("rpcbind: Disable remote calls by default") [3]).
> 
>>> TL;DR: Is there a way to detect missing support from rpcbind? Because we cannot
>>> blindly expect that timeout means disabled remote calls (it could be also
>>> caused by regression). Other option is just to disable these tests by default
>>> (detection is preferred).
>> No there is not a way, that I know of, to see if remote calls
>> are or are not enabled since it is a compile time flag.
> 
> How about rpcbind to print version via new -v or -V command line option.
> Then compiled options could be printed as part of the output.
That is not a bad idea... It could be a bit messy since they're
close to 20 different ifdefs...

> 
> Nobody needed to know rpcbind version, therefore I'm not sure if testing justify
> it, but that would be an easy way to provide the info.
No testing would be needed... as long as rpcbind does not
drop core with the -v option :-) also there would be a
manpage up date... but it would not be very invasive.

> 
>> I really don't know what to say... In Fedora we disabled rmtcalls
>> which broke NIS and in RHEL we left it enable which drives
>> SELinux (and a few customers) nuts.
> 
> Thanks for info, I fully understand the chosen solution.
I wish other people would!!! 8-)

steved.

> 
> Kind regards,
> Petr
> 
>> There is no clear answer... IMHO.
> 
>> steved.
> 
> 
> 
>>> # export PATH="/opt/ltp/testcases/bin:$PATH"
>>> # rpc_test.sh -s tirpc_svc_4 -c tirpc_rpcb_rmtcall
>>> ...
>>> tirpc_rpcb_rmtcall 10.0.0.2 536875000
>>> rpc_test 1 TFAIL: tirpc_rpcb_rmtcall 10.0.0.2 536875000 failed unexpectedly
> 
>>> As the name of the test suggests they are using pmap_rmtcall() and rpcb_rmtcall().
>>> A bit debug info.
> 
>>> Modified rpc_test.sh to use strace:
> 
>>> +++ b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
>>> @@ -87,6 +87,8 @@ do_test()
>>>    		done
>>>    	fi
>>> +	echo "$CLIENT $(tst_ipaddr) $PROGNUMNOSVC $CLIENT_EXTRA_OPTS" # FIXME: debug
>>> +	EXPECT_RHOST_PASS strace -o /tmp/a $CLIENT $(tst_ipaddr) $PROGNUMNOSVC $CLIENT_EXTRA_OPTS
>>>    	EXPECT_RHOST_PASS $CLIENT $(tst_ipaddr) $PROGNUMNOSVC $CLIENT_EXTRA_OPTS
>>>    }
> 
>>> I see the test timeouts (full strace output below):
> 
>>> # rpc_test.sh -s tirpc_svc_4 -c tirpc_rpcb_rmtcall
>>> ...
>>> sendto(5, "h=\r}\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\4\0\0\0\5\0\0\0\0\0\0\0\0"..., 60, 0, {sa_family=AF_INET, sin_port=htons(111), sin_addr=inet_addr("10.0.0.2")}, 16) = 60
>>> poll([{fd=5, events=POLLIN}], 1, 1000)  = 0 (Timeout)
> 
>>> Using rpcbind 1.2.7-1.2 (from Tumbleweed), output when run with debug mode:
> 
>>> # /usr/sbin/rpcbind -w -f -d
>>> rpcbind: PMAPPROC_DUMP
> 
>>> rpcbind: RPCB_UNSET request for (536875000, 1, ) :
>>> rpcbind: RPCB_UNSET: succeeded
>>> rpcbind: RPCB_SET request for (536875000, 1, udp, 0.0.0.0.223.168) :
>>> rpcbind: RPCB_SET: succeeded
>>> rpcbind: RPCB_GETADDR req for (100000, 2, tcp) from 127.0.0.1.3.98:
>>> mergeaddr: contact uaddr = 127.0.0.1.0.111
>>> addrmerge(caller, 0.0.0.0.0.111, 127.0.0.1.0.111, tcp
>>> addrmerge: hint 127.0.0.1.0.111
>>> addrmerge: returning 127.0.0.1.0.111
>>> mergeaddr: uaddr = 0.0.0.0.0.111, merged uaddr = 127.0.0.1.0.111
>>> rpcbind: getaddr: 127.0.0.1.0.111
>>> rpcbind: PMAPPROC_DUMP
> 
>>> rpcbind: RPCB_GETADDR req for (536875000, 1, udp) from 10.0.0.1.3.105:
>>> mergeaddr: contact uaddr = 10.0.0.2.0.111
>>> addrmerge(caller, 0.0.0.0.223.168, 10.0.0.2.0.111, udp
>>> addrmerge: hint 10.0.0.2.0.111
>>> addrmerge: returning 10.0.0.2.223.168
>>> mergeaddr: uaddr = 0.0.0.0.223.168, merged uaddr = 10.0.0.2.223.168
>>> rpcbind: getaddr: 10.0.0.2.223.168
>>> rpcbind: RPCBPROC_BCAST
> 
>>> rpcbind: rpcb_indirect callit req for (536875000, 1, 1, udp) from 10.0.0.1.3.105 :
>>> rpcbind: found at uaddr 0.0.0.0.223.168
> 
>>> addrmerge(caller, 0.0.0.0.223.168, NULL, udp
>>> addrmerge: hint 127.0.0.1.0.111
>>> addrmerge: returning 127.0.0.1.223.168
>>> addrmerge(caller, 0.0.0.0.223.168, NULL, udp
>>> addrmerge: hint 10.0.0.1.3.105
>>> addrmerge: returning 192.168.122.43.223.168
>>> rpcbind: merged uaddr 192.168.122.43.223.168
> 
>>> rpcbind: RPCB_UNSET request for (536875000, 1, ) :
>>> rpcbind: Suppression RPC_UNSET(map_unset)
>>> rpcbind: rbl->rpcb_map.r_owner=superuser
>>> rpcbind: owner=superuser
>>> rpcbind: RPCB_UNSET: succeeded
> 
>>> Obviously, if I compile rpcbind with --enable-rmtcalls and run it, both tests work:
> 
>>> $ ./autogen.sh && ./configure --enable-debug --enable-warmstarts --enable-rmtcalls --with-rpcuser=rpc --with-nss-modules="files usrfiles"
>>> $ make -j`nproc`
>>> # ./rpcbind -w -d -f
> 
>>> # rpc_test.sh -s tirpc_svc_4 -c tirpc_rpcb_rmtcall
>>> ...
>>> rpc_test 1 TINFO: using libtirpc: yes
>>> tirpc_rpcb_rmtcall 10.0.0.2 536875000
>>> rpc_test 1 TPASS: tirpc_rpcb_rmtcall 10.0.0.2 536875000 passed as expected
> 
>>> # rpc_test.sh -s rpc_svc_1 -c rpc_pmap_rmtcall
>>> ...
>>> rpc_pmap_rmtcall 10.0.0.2 536875000
>>> rpc_test 1 TPASS: rpc_pmap_rmtcall 10.0.0.2 536875000 passed as expected
> 
> 
>>> And the rpcbind outpt contains also:
> 
>>> rpcbind: rpcbproc_callit_com:  original XID 683f1705, new XID f68e200
>>> rpcbind: my_svc_run:  polled on forwarding fd 7, netid udp - calling handle_reply
> 
>>> Also, wouldn't it be worth mention --enable-rmtcalls in functions' man pages?
>>> (Or have I overlooked that in man?)
> 
>>> Thanks for any hint.
> 
>>> Kind regards,
>>> Petr
> 
>>> [1] https://github.com/linux-test-project/ltp/tree/master/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/rpc_pmap_rmtcall.c
>>> [2] https://github.com/linux-test-project/ltp/tree/master/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall.c
>>> [3] https://git.linux-nfs.org/?p=steved/rpcbind.git;a=commitdiff;h=2e9c289246c647e25649914bdb0d9400c66f486e
> 
>>> Full strace on rpcbind compiled without --enable-rmtcalls (the default, thus
>>> how it's shipped to the new distros):
> 
>>> # rpc_test.sh -s tirpc_svc_4 -c tirpc_rpcb_rmtcall
> 
>>> execve("/opt/ltp/testcases/bin/tirpc_rpcb_rmtcall", ["tirpc_rpcb_rmtcall", "10.0.0.2", "536875000"], 0x7ffee8701b10 /* 228 vars */) = 0
>>> ...
>>> openat(AT_FDCWD, "/etc/services", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
>>> openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 5
>>> ...
>>> openat(AT_FDCWD, "/usr/etc/services", O_RDONLY|O_CLOEXEC) = 5
>>> fstat(5, {st_mode=S_IFREG|0644, st_size=868338, ...}) = 0
>>> read(5, "#\n# Network services, Internet s"..., 4096) = 4096
>>> read(5, "[Jon_Postel]\ndaytime            "..., 4096) = 4096
>>> read(5, "gs          44/udp       # MPM F"..., 4096) = 4096
>>> read(5, "emote Job Service \nnetrjs-2     "..., 4096) = 4096
>>> read(5, "Jon_Postel]\nhostname           1"..., 4096) = 4096
>>> close(5)                                = 0
>>> socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP) = 5
>>> getsockname(5, {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("0.0.0.0")}, [128 => 16]) = 0
>>> getsockopt(5, SOL_SOCKET, SO_TYPE, [2], [4]) = 0
>>> openat(AT_FDCWD, "/etc/bindresvport.blacklist", O_RDONLY) = 6
>>> fstat(6, {st_mode=S_IFREG|0644, st_size=415, ...}) = 0
>>> read(6, "#\n# This file contains a list of"..., 4096) = 415
>>> read(6, "", 4096)                       = 0
>>> close(6)                                = 0
>>> getsockname(5, {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("0.0.0.0")}, [128 => 16]) = 0
>>> getpid()                                = 28530
>>> bind(5, {sa_family=AF_INET, sin_port=htons(722), sin_addr=inet_addr("0.0.0.0")}, 16) = 0
>>> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
>>> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
>>> getsockname(5, {sa_family=AF_INET, sin_port=htons(722), sin_addr=inet_addr("0.0.0.0")}, [128 => 16]) = 0
>>> getsockopt(5, SOL_SOCKET, SO_TYPE, [2], [4]) = 0
>>> gettimeofday({tv_sec=1748867467, tv_usec=890549}, NULL) = 0
>>> getpid()                                = 28530
>>> setsockopt(5, SOL_IP, IP_RECVERR, [1], 4) = 0
>>> ioctl(5, FIONBIO, [1])                  = 0
>>> ...
>>> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
>>> sendto(5, "h0`M\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\4\0\0\0\3\0\0\0\0\0\0\0\0"..., 88, 0, {sa_family=AF_INET, sin_port=htons(111), sin_addr=inet_addr("10.0.0.2")}, 16) = 88
>>> poll([{fd=5, events=POLLIN}], 1, 15000) = 1 ([{fd=5, revents=POLLIN}])
>>> recvfrom(5, "h0`M\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\02010.0"..., 8800, 0, NULL, NULL) = 44
>>> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
>>> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
>>> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
>>> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
>>> close(5)                                = 0
>>> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
>>> socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP) = 5
>>> getsockname(5, {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("0.0.0.0")}, [128 => 16]) = 0
>>> getsockopt(5, SOL_SOCKET, SO_TYPE, [2], [4]) = 0
>>> getsockname(5, {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("0.0.0.0")}, [128 => 16]) = 0
>>> getpid()                                = 28530
>>> bind(5, {sa_family=AF_INET, sin_port=htons(722), sin_addr=inet_addr("0.0.0.0")}, 16) = 0
>>> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
>>> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
>>> getsockname(5, {sa_family=AF_INET, sin_port=htons(722), sin_addr=inet_addr("0.0.0.0")}, [128 => 16]) = 0
>>> getsockopt(5, SOL_SOCKET, SO_TYPE, [2], [4]) = 0
>>> gettimeofday({tv_sec=1748867467, tv_usec=892984}, NULL) = 0
>>> getpid()                                = 28530
>>> setsockopt(5, SOL_IP, IP_RECVERR, [1], 4) = 0
>>> ioctl(5, FIONBIO, [1])                  = 0
>>> ...
>>> sendto(5, "h0V\302\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\4\0\0\0\5\0\0\0\0\0\0\0\0"..., 60, 0, {sa_family=AF_INET, sin_port=htons(111), sin_addr=inet_addr("10.0.0.2")}, 16) = 60
>>> poll([{fd=5, events=POLLIN}], 1, 1000)  = 0 (Timeout)
>>> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
>>> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
>>> close(5)                                = 0
>>> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
>>> fstat(1, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
>>> write(1, "1\n", 2)                      = 2
>>> exit_group(1)                           = ?
>>> +++ exited with 1 +++
> 
> 


