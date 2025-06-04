Return-Path: <linux-nfs+bounces-12112-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85319ACE54F
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 21:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4683416B955
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 19:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CE91FECAF;
	Wed,  4 Jun 2025 19:42:47 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478891F0E26
	for <linux-nfs@vger.kernel.org>; Wed,  4 Jun 2025 19:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749066167; cv=none; b=ogGlREmCYEfU9B0Chr/FR1RwGu+7czlltAcnsci1OtDRKh46VVX1xdIIzAxX4/vpLjlkBQ8hTNUpu1lXTbbqqSGRW/1d3EZo4bej9n0pZSQqAqOm9x/6x6q1uVPn+llTh1UCjZ3LVMPqGvp+CIe7BuG0hXTj6QnM1DY4PyVwDF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749066167; c=relaxed/simple;
	bh=MnW5+kOJ9y0lLZVV2Wtj3+1xNY+Wi1MANEU2n8JLuf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHRG4T/WQIeQE/dEcvcHoWxxcEKlT8cgIIw1dpYeZA5Af+TjCm0+ftLr0oV+q3jqrOhmuCg5idT9CjWeTAmHkSxMR/FNGI5YxGlU7OUb4wi3Il13EXHncVnqX0rP7496RY96NLynzXF68YQhtHMstrUKSmqhBD7aug4YdPjx7ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6A92422877;
	Wed,  4 Jun 2025 19:42:43 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 196EA1369A;
	Wed,  4 Jun 2025 19:42:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JIcKBbOhQGgkYQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 04 Jun 2025 19:42:43 +0000
Date: Wed, 4 Jun 2025 21:42:41 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Steve Dickson <steved@redhat.com>
Cc: ltp@lists.linux.it, linux-nfs@vger.kernel.org,
	"Ricardo B. Marliere" <rbm@suse.com>,
	Avinesh Kumar <akumar@suse.de>
Subject: Re: [RFC] rpcbind: detect support of remote calls
Message-ID: <20250604194241.GA1159049@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250602133741.GA324895@pevik>
 <bc6adca9-a7c0-4545-b32b-640994d135cb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc6adca9-a7c0-4545-b32b-640994d135cb@redhat.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6A92422877
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Score: -4.00

Hi Steve,

> Hey!

> On 6/2/25 9:37 AM, Petr Vorel wrote:
> > Hi Steve,

> > Ricardo found that TI-RPC rpc_pmap_rmtcall [1] tirpc_rpcb_rmtcall [2] tests are
> > failing when they use rpcbind *without* --enable-rmtcalls (the default since
> > 2018, see 2e9c289 ("rpcbind: Disable remote calls by default") [3]).

> > TL;DR: Is there a way to detect missing support from rpcbind? Because we cannot
> > blindly expect that timeout means disabled remote calls (it could be also
> > caused by regression). Other option is just to disable these tests by default
> > (detection is preferred).
> No there is not a way, that I know of, to see if remote calls
> are or are not enabled since it is a compile time flag.

How about rpcbind to print version via new -v or -V command line option.
Then compiled options could be printed as part of the output.

Nobody needed to know rpcbind version, therefore I'm not sure if testing justify
it, but that would be an easy way to provide the info.

> I really don't know what to say... In Fedora we disabled rmtcalls
> which broke NIS and in RHEL we left it enable which drives
> SELinux (and a few customers) nuts.

Thanks for info, I fully understand the chosen solution.

Kind regards,
Petr

> There is no clear answer... IMHO.

> steved.



> > # export PATH="/opt/ltp/testcases/bin:$PATH"
> > # rpc_test.sh -s tirpc_svc_4 -c tirpc_rpcb_rmtcall
> > ...
> > tirpc_rpcb_rmtcall 10.0.0.2 536875000
> > rpc_test 1 TFAIL: tirpc_rpcb_rmtcall 10.0.0.2 536875000 failed unexpectedly

> > As the name of the test suggests they are using pmap_rmtcall() and rpcb_rmtcall().
> > A bit debug info.

> > Modified rpc_test.sh to use strace:

> > +++ b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
> > @@ -87,6 +87,8 @@ do_test()
> >   		done
> >   	fi
> > +	echo "$CLIENT $(tst_ipaddr) $PROGNUMNOSVC $CLIENT_EXTRA_OPTS" # FIXME: debug
> > +	EXPECT_RHOST_PASS strace -o /tmp/a $CLIENT $(tst_ipaddr) $PROGNUMNOSVC $CLIENT_EXTRA_OPTS
> >   	EXPECT_RHOST_PASS $CLIENT $(tst_ipaddr) $PROGNUMNOSVC $CLIENT_EXTRA_OPTS
> >   }

> > I see the test timeouts (full strace output below):

> > # rpc_test.sh -s tirpc_svc_4 -c tirpc_rpcb_rmtcall
> > ...
> > sendto(5, "h=\r}\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\4\0\0\0\5\0\0\0\0\0\0\0\0"..., 60, 0, {sa_family=AF_INET, sin_port=htons(111), sin_addr=inet_addr("10.0.0.2")}, 16) = 60
> > poll([{fd=5, events=POLLIN}], 1, 1000)  = 0 (Timeout)

> > Using rpcbind 1.2.7-1.2 (from Tumbleweed), output when run with debug mode:

> > # /usr/sbin/rpcbind -w -f -d
> > rpcbind: PMAPPROC_DUMP

> > rpcbind: RPCB_UNSET request for (536875000, 1, ) :
> > rpcbind: RPCB_UNSET: succeeded
> > rpcbind: RPCB_SET request for (536875000, 1, udp, 0.0.0.0.223.168) :
> > rpcbind: RPCB_SET: succeeded
> > rpcbind: RPCB_GETADDR req for (100000, 2, tcp) from 127.0.0.1.3.98:
> > mergeaddr: contact uaddr = 127.0.0.1.0.111
> > addrmerge(caller, 0.0.0.0.0.111, 127.0.0.1.0.111, tcp
> > addrmerge: hint 127.0.0.1.0.111
> > addrmerge: returning 127.0.0.1.0.111
> > mergeaddr: uaddr = 0.0.0.0.0.111, merged uaddr = 127.0.0.1.0.111
> > rpcbind: getaddr: 127.0.0.1.0.111
> > rpcbind: PMAPPROC_DUMP

> > rpcbind: RPCB_GETADDR req for (536875000, 1, udp) from 10.0.0.1.3.105:
> > mergeaddr: contact uaddr = 10.0.0.2.0.111
> > addrmerge(caller, 0.0.0.0.223.168, 10.0.0.2.0.111, udp
> > addrmerge: hint 10.0.0.2.0.111
> > addrmerge: returning 10.0.0.2.223.168
> > mergeaddr: uaddr = 0.0.0.0.223.168, merged uaddr = 10.0.0.2.223.168
> > rpcbind: getaddr: 10.0.0.2.223.168
> > rpcbind: RPCBPROC_BCAST

> > rpcbind: rpcb_indirect callit req for (536875000, 1, 1, udp) from 10.0.0.1.3.105 :
> > rpcbind: found at uaddr 0.0.0.0.223.168

> > addrmerge(caller, 0.0.0.0.223.168, NULL, udp
> > addrmerge: hint 127.0.0.1.0.111
> > addrmerge: returning 127.0.0.1.223.168
> > addrmerge(caller, 0.0.0.0.223.168, NULL, udp
> > addrmerge: hint 10.0.0.1.3.105
> > addrmerge: returning 192.168.122.43.223.168
> > rpcbind: merged uaddr 192.168.122.43.223.168

> > rpcbind: RPCB_UNSET request for (536875000, 1, ) :
> > rpcbind: Suppression RPC_UNSET(map_unset)
> > rpcbind: rbl->rpcb_map.r_owner=superuser
> > rpcbind: owner=superuser
> > rpcbind: RPCB_UNSET: succeeded

> > Obviously, if I compile rpcbind with --enable-rmtcalls and run it, both tests work:

> > $ ./autogen.sh && ./configure --enable-debug --enable-warmstarts --enable-rmtcalls --with-rpcuser=rpc --with-nss-modules="files usrfiles"
> > $ make -j`nproc`
> > # ./rpcbind -w -d -f

> > # rpc_test.sh -s tirpc_svc_4 -c tirpc_rpcb_rmtcall
> > ...
> > rpc_test 1 TINFO: using libtirpc: yes
> > tirpc_rpcb_rmtcall 10.0.0.2 536875000
> > rpc_test 1 TPASS: tirpc_rpcb_rmtcall 10.0.0.2 536875000 passed as expected

> > # rpc_test.sh -s rpc_svc_1 -c rpc_pmap_rmtcall
> > ...
> > rpc_pmap_rmtcall 10.0.0.2 536875000
> > rpc_test 1 TPASS: rpc_pmap_rmtcall 10.0.0.2 536875000 passed as expected


> > And the rpcbind outpt contains also:

> > rpcbind: rpcbproc_callit_com:  original XID 683f1705, new XID f68e200
> > rpcbind: my_svc_run:  polled on forwarding fd 7, netid udp - calling handle_reply

> > Also, wouldn't it be worth mention --enable-rmtcalls in functions' man pages?
> > (Or have I overlooked that in man?)

> > Thanks for any hint.

> > Kind regards,
> > Petr

> > [1] https://github.com/linux-test-project/ltp/tree/master/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/rpc_pmap_rmtcall.c
> > [2] https://github.com/linux-test-project/ltp/tree/master/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall.c
> > [3] https://git.linux-nfs.org/?p=steved/rpcbind.git;a=commitdiff;h=2e9c289246c647e25649914bdb0d9400c66f486e

> > Full strace on rpcbind compiled without --enable-rmtcalls (the default, thus
> > how it's shipped to the new distros):

> > # rpc_test.sh -s tirpc_svc_4 -c tirpc_rpcb_rmtcall

> > execve("/opt/ltp/testcases/bin/tirpc_rpcb_rmtcall", ["tirpc_rpcb_rmtcall", "10.0.0.2", "536875000"], 0x7ffee8701b10 /* 228 vars */) = 0
> > ...
> > openat(AT_FDCWD, "/etc/services", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 5
> > ...
> > openat(AT_FDCWD, "/usr/etc/services", O_RDONLY|O_CLOEXEC) = 5
> > fstat(5, {st_mode=S_IFREG|0644, st_size=868338, ...}) = 0
> > read(5, "#\n# Network services, Internet s"..., 4096) = 4096
> > read(5, "[Jon_Postel]\ndaytime            "..., 4096) = 4096
> > read(5, "gs          44/udp       # MPM F"..., 4096) = 4096
> > read(5, "emote Job Service \nnetrjs-2     "..., 4096) = 4096
> > read(5, "Jon_Postel]\nhostname           1"..., 4096) = 4096
> > close(5)                                = 0
> > socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP) = 5
> > getsockname(5, {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("0.0.0.0")}, [128 => 16]) = 0
> > getsockopt(5, SOL_SOCKET, SO_TYPE, [2], [4]) = 0
> > openat(AT_FDCWD, "/etc/bindresvport.blacklist", O_RDONLY) = 6
> > fstat(6, {st_mode=S_IFREG|0644, st_size=415, ...}) = 0
> > read(6, "#\n# This file contains a list of"..., 4096) = 415
> > read(6, "", 4096)                       = 0
> > close(6)                                = 0
> > getsockname(5, {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("0.0.0.0")}, [128 => 16]) = 0
> > getpid()                                = 28530
> > bind(5, {sa_family=AF_INET, sin_port=htons(722), sin_addr=inet_addr("0.0.0.0")}, 16) = 0
> > rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
> > rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> > getsockname(5, {sa_family=AF_INET, sin_port=htons(722), sin_addr=inet_addr("0.0.0.0")}, [128 => 16]) = 0
> > getsockopt(5, SOL_SOCKET, SO_TYPE, [2], [4]) = 0
> > gettimeofday({tv_sec=1748867467, tv_usec=890549}, NULL) = 0
> > getpid()                                = 28530
> > setsockopt(5, SOL_IP, IP_RECVERR, [1], 4) = 0
> > ioctl(5, FIONBIO, [1])                  = 0
> > ...
> > rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
> > sendto(5, "h0`M\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\4\0\0\0\3\0\0\0\0\0\0\0\0"..., 88, 0, {sa_family=AF_INET, sin_port=htons(111), sin_addr=inet_addr("10.0.0.2")}, 16) = 88
> > poll([{fd=5, events=POLLIN}], 1, 15000) = 1 ([{fd=5, revents=POLLIN}])
> > recvfrom(5, "h0`M\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\02010.0"..., 8800, 0, NULL, NULL) = 44
> > rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> > rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
> > rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> > rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
> > close(5)                                = 0
> > rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> > socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP) = 5
> > getsockname(5, {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("0.0.0.0")}, [128 => 16]) = 0
> > getsockopt(5, SOL_SOCKET, SO_TYPE, [2], [4]) = 0
> > getsockname(5, {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("0.0.0.0")}, [128 => 16]) = 0
> > getpid()                                = 28530
> > bind(5, {sa_family=AF_INET, sin_port=htons(722), sin_addr=inet_addr("0.0.0.0")}, 16) = 0
> > rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
> > rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> > getsockname(5, {sa_family=AF_INET, sin_port=htons(722), sin_addr=inet_addr("0.0.0.0")}, [128 => 16]) = 0
> > getsockopt(5, SOL_SOCKET, SO_TYPE, [2], [4]) = 0
> > gettimeofday({tv_sec=1748867467, tv_usec=892984}, NULL) = 0
> > getpid()                                = 28530
> > setsockopt(5, SOL_IP, IP_RECVERR, [1], 4) = 0
> > ioctl(5, FIONBIO, [1])                  = 0
> > ...
> > sendto(5, "h0V\302\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\4\0\0\0\5\0\0\0\0\0\0\0\0"..., 60, 0, {sa_family=AF_INET, sin_port=htons(111), sin_addr=inet_addr("10.0.0.2")}, 16) = 60
> > poll([{fd=5, events=POLLIN}], 1, 1000)  = 0 (Timeout)
> > rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> > rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
> > close(5)                                = 0
> > rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> > fstat(1, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
> > write(1, "1\n", 2)                      = 2
> > exit_group(1)                           = ?
> > +++ exited with 1 +++



