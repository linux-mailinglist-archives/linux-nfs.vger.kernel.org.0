Return-Path: <linux-nfs+bounces-6999-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76828998417
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 12:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF0E11F22F08
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 10:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF101A0737;
	Thu, 10 Oct 2024 10:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="WDQYRcpf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B9F47A60;
	Thu, 10 Oct 2024 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728557187; cv=none; b=WeNhWbdjWV6aD2uNfR9YUtqWcnrOYCNyfHiOPvMgq0F/xaF9YUrmoz5NZ5hzAili8tqCzHVFDB29QpErSiw5xf6rvGhM4Mnhsc8WL/pvs9khp1zaBvDuJMUlAic9teLNzBLmcSCkH6jigq+XX2901U692uKnsvdRwXvyT0GGodI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728557187; c=relaxed/simple;
	bh=r9y3AqCg5WMZvS7kWJh0iyuPBPu5wb70lYX5C3oBdtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AF+8hVE52a9KnGti9N0kLf9+OVG6SOYZ3zxvwA6r1qCsLSCXCkjfm5/sFG4jwGnZgSwYSs+5ktoKo3Q4OqvCCFntENNFBdPsfrwEWtCkHTS1Wavxlj9e9l7lTPDKl9gZRzXxdm0sBrnOuddarpQqC6HuuTmcG/mqZo7fXGACgmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=WDQYRcpf; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=J0wXjIsNrPQGXiXr2dT9uUkENmIQgLlLeLiX7T9LCz0=; t=1728557185;
	x=1728989185; b=WDQYRcpfH+gvI+cMdnCmpusv2Pn7yiC6Jo8bCK05SSXPZPVn632HcbH6W2EbF
	saJFUxhQSJJc1CFWqkBblkOZ2UKzh8/NyNRf8Sq/Arb4kUyafuCEmAbSPZl2OGq5Gjql+4c3tRO3o
	7zZtkr4ypVCVoHptw5vSR5iivFH0lKh92Dxsrlt9bn+gFsXuqQCKGekoG2k6siddwfUlDzbEKaw4d
	GmM/n9hrDJ6YGPVuk4GN1E30Z/m0VNNdo8IfLXbgHLtBHgZiSLb9bbUZPHeVI6EjemaOTTFLR7YVe
	UYn56OnEr2Q00TTt5bSlbGhUejkRdDvW3rvhMdpqFCXq4MZbpw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1syqgY-0006SI-IZ; Thu, 10 Oct 2024 12:46:22 +0200
Message-ID: <01a91d65-9984-416f-b8ae-81627eb7994d@leemhuis.info>
Date: Thu, 10 Oct 2024 12:46:19 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Build failure with CONFIG_NFS_LOCALIO=y on Linux
 6.12-rc1
To: Weston Andros Adamson <dros@primarydata.com>,
 Anna Schumaker <anna.schumaker@oracle.com>, NeilBrown <neilb@suse.de>
Cc: regressions@lists.linux.dev, Maximilian Bosch <maximilian@mbosch.me>,
 linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Mike Snitzer <snitzer@kernel.org>
References: <D4OUJRP8YWRM.ATQ7KASTYX5H@mbosch.me>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: en-US, de-DE
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <D4OUJRP8YWRM.ATQ7KASTYX5H@mbosch.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1728557185;1e3385a6;
X-HE-SMSGID: 1syqgY-0006SI-IZ

Hi, Thorsten here, the Linux kernel's regression tracker.

On 06.10.24 18:00, Maximilian Bosch wrote:
> 
> I haven't found an existing report for this problem, but I observed
> that Linux 6.12-rc1 fails to build like this on aarch64-linux with
> CONFIG_NFS_LOCALIO=y:

Thx for the report. FWIW, there is another report with similar symptoms
that looks to be the same issue:
https://bugzilla.kernel.org/show_bug.cgi?id=219370

That reporter bisected the problem to fa4983862e506d ("nfsd: add LOCALIO
support") [v6.12-rc1]. CCing the involved developers.

Ciao, Thorsten

>     /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: warning: -z relro ignored
>     /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: Unexpected GOT/PLT entries detected!
>     /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: Unexpected run-time procedure linkages detected!
>     /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: fs/nfs/localio.o: in function `nfs_local_iocb_alloc':
>     /build/source/build/../fs/nfs/localio.c:290:(.text+0x324): undefined reference to `nfs_to'
>     /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: fs/nfs/localio.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `nfs_to' which may bind externally can not be used when making a shared object; recompile with -fPIC
>     /build/source/build/../fs/nfs/localio.c:290:(.text+0x324): dangerous relocation: unsupported relocation
>     /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: /build/source/build/../fs/nfs/localio.c:290:(.text+0x330): undefined reference to `nfs_to'
>     /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: fs/nfs/localio.o: in function `nfs_local_pgio_release':
>     /build/source/build/../fs/nfs/localio.c:344:(.text+0x47c): undefined reference to `nfs_to'
>     /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: fs/nfs/localio.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `nfs_to' which may bind externally can not be used when making a shared object; recompile with -fPIC
>     /build/source/build/../fs/nfs/localio.c:344:(.text+0x47c): dangerous relocation: unsupported relocation
>     /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: /build/source/build/../fs/nfs/localio.c:344:(.text+0x488): undefined reference to `nfs_to'
>     /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: fs/nfs/localio.o: in function `nfs_local_fsync_work':
>     /build/source/build/../fs/nfs/localio.c:725:(.text+0x838): undefined reference to `nfs_to'
>     /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: fs/nfs/localio.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `nfs_to' which may bind externally can not be used when making a shared object; recompile with -fPIC
>     /build/source/build/../fs/nfs/localio.c:725:(.text+0x838): dangerous relocation: unsupported relocation
>     /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: fs/nfs/localio.o:/build/source/build/../fs/nfs/localio.c:725: more undefined references to `nfs_to' follow
>     /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: fs/nfs/localio.o: in function `nfs_local_disable':
>     /build/source/build/../fs/nfs/localio.c:140:(.text+0xeb4): undefined reference to `nfs_uuid_invalidate_one_client'
>     /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: fs/nfs/localio.o: in function `nfs_local_probe':
>     /build/source/build/../fs/nfs/localio.c:209:(.text+0xfac): undefined reference to `nfs_uuid_begin'
>     /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: /build/source/build/../fs/nfs/localio.c:212:(.text+0x1074): undefined reference to `nfs_uuid_end'
>     /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: fs/nfs/localio.o: in function `nfs_local_open_fh':
>     /build/source/build/../fs/nfs/localio.c:233:(.text+0x12cc): undefined reference to `nfs_open_local_fh'
>     /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: fs/nfs/localio.o: in function `nfs_local_doio':
>     /build/source/build/../fs/nfs/localio.c:600:(.text+0x13c8): undefined reference to `nfs_to'
>     /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: fs/nfs/localio.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `nfs_to' which may bind externally can not be used when making a shared object; recompile with -fPIC
>     /build/source/build/../fs/nfs/localio.c:600:(.text+0x13c8): dangerous relocation: unsupported relocation
>     /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: /build/source/build/../fs/nfs/localio.c:600:(.text+0x13d8): undefined reference to `nfs_to'
>     /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: /build/source/build/../fs/nfs/localio.c:625:(.text+0x150c): undefined reference to `nfs_to'
>     /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: fs/nfs/localio.o: in function `nfs_local_release_commit_data':
>     /build/source/build/../fs/nfs/localio.c:676:(.text+0x18dc): undefined reference to `nfs_to'
>     /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: fs/nfs/localio.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `nfs_to' which may bind externally can not be used when making a shared object; recompile with -fPIC
>     /build/source/build/../fs/nfs/localio.c:676:(.text+0x18dc): dangerous relocation: unsupported relocation
>     /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: /build/source/build/../fs/nfs/localio.c:676:(.text+0x18ec): undefined reference to `nfs_to'
>     make[2]: *** [../scripts/Makefile.vmlinux:34: vmlinux] Error 1
>     make[1]: *** [/build/source/Makefile:1166: vmlinux] Error 2
>     make: *** [../Makefile:224: __sub-make] Error 2
> 
> On x86_64-linux the problem doesn't exist.
> 
> For the build are binutils 2.42 & GCC 13.3 used.
> 
> The workaround was to turn off CONFIG_NFS_LOCALIO.
> 
> With best regards
> 
> Ma27


#regzbot ^introduced: fa4983862e506d
#regzbot dup: https://bugzilla.kernel.org/show_bug.cgi?id=219370


