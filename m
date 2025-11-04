Return-Path: <linux-nfs+bounces-16002-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE1EC31A1A
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 15:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF8B24FA8FB
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 14:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE3B1C5F10;
	Tue,  4 Nov 2025 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrC6P1yX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B4B32E75E
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267812; cv=none; b=Lts2n50HbGeRYHt/ZN6xd/+zmwqBIxBviqn81lboqeL9LxrswEsFkE3CmQmtXl9a/Jphlc/arMzB82EEwz4XpkU6FtK4jVqaj49OLDt6df68+2hmd90Jl/J1ChJoxORMJJX320vdQR3Gxtvrr0pi8dOq25WHBGKFt+3hPSSKH1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267812; c=relaxed/simple;
	bh=NA8k//stz/ktiNDM5Q257GQzNDqkRp6fxIgpQ0ygFaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=SA7x2Snro+B3YhTt5WZODgQ1wFV2viHzWiKReoeZC8dyl5s9B5OiQibLliIzHzfaPiCbYHbEgFwCvNF6cbej/qjTErDPhGPR2holYEX1nDzxYxwgGHOdrEOnSjNS1YQhkSXlOF3vwuU53PL/0sxcs0BMqLngNcQTdL996+Q8WIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrC6P1yX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A59C116C6;
	Tue,  4 Nov 2025 14:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762267811;
	bh=NA8k//stz/ktiNDM5Q257GQzNDqkRp6fxIgpQ0ygFaA=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=VrC6P1yXk5Y5DAcmIPaPCtjjg9UXr40vExAUQK12/lD2efqmXiViiSe5k2brCxSwV
	 GAmEdx5H0O7OuYAPVfrQwsp2vtQbqW4MQVyFK5z7srlrrS1BskK68VpzjTQ4UrC4gs
	 H4kiB4Xi7fVg5/puQyB8EZDTrCDOlNdQ5+oCSDcLZqZzpcrfiiwg+BuLP9pH8dbTwl
	 xlFhXnxtKFdBEJ/I/RxM4vslXT3IgJqzu8ND23T3rQP8aXvRb471KuczGW1hdjpR/h
	 jHVRThCp9UOLPPN0CwxRHdqRMCVzBLP3nZNOE8xdlkdO5K9H5M0cUMQZvrRIgwyOg7
	 z60tLXrNxaaQQ==
Message-ID: <9308c03f-e906-4de1-87b9-f9d90b0461b4@kernel.org>
Date: Tue, 4 Nov 2025 09:50:10 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Compile Error fs/nfsd/nfs4state.o - clamp() low limit slotsize
 greater than high limit total_avail/scale_factor
To: jlayton@kernel.org, neilb@brown.name
References: <20251104-b220745c0-91170b3b3642@bugzilla.kernel.org>
Content-Language: en-US
Cc: linux-nfs@vger.kernel.org, anna@kernel.org, trondmy@kernel.org,
 Mike-SPC via Bugspray Bot <bugbot@kernel.org>
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <20251104-b220745c0-91170b3b3642@bugzilla.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 9:15 AM, Mike-SPC via Bugspray Bot wrote:
> Mike-SPC writes via Kernel.org Bugzilla:
> 
> Hi there,
> 
> with kernel version > 6.1.156 I get the following error by compiling it (make bzImage) on a 32bit platform:
> 
>   CALL    scripts/checksyscalls.sh
>   CC      fs/nfsd/nfs4state.o
> In file included from <command-line>:
> In function 'nfsd4_get_drc_mem',
>     inlined from 'check_forechannel_attrs' at fs/nfsd/nfs4state.c:3539:16,
>     inlined from 'nfsd4_create_session' at fs/nfsd/nfs4state.c:3612:11:
> ././include/linux/compiler_types.h:375:38: error: call to '__compiletime_assert_587' declared with attribute error: clamp() low limit slotsize greater than high limit total_avail/scale_factor
>   375 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |                                      ^
> ././include/linux/compiler_types.h:356:4: note: in definition of macro '__compiletime_assert'
>   356 |    prefix ## suffix();    \
>       |    ^~~~~~
> ././include/linux/compiler_types.h:375:2: note: in expansion of macro '_compiletime_assert'
>   375 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |  ^~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>       |                                     ^~~~~~~~~~~~~~~~~~
> ./include/linux/minmax.h:188:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>   188 |  BUILD_BUG_ON_MSG(statically_true(ulo > uhi),    \
>       |  ^~~~~~~~~~~~~~~~
> ./include/linux/minmax.h:195:2: note: in expansion of macro '__clamp_once'
>   195 |  __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
>       |  ^~~~~~~~~~~~
> ./include/linux/minmax.h:218:36: note: in expansion of macro '__careful_clamp'
>   218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
>       |                                    ^~~~~~~~~~~~~~~
> fs/nfsd/nfs4state.c:1825:10: note: in expansion of macro 'clamp_t'
>  1825 |  avail = clamp_t(unsigned long, avail, slotsize,
>       |          ^~~~~~~
> make[3]: *** [scripts/Makefile.build:250: fs/nfsd/nfs4state.o] Error 1
> make[2]: *** [scripts/Makefile.build:503: fs/nfsd] Error 2
> make[1]: *** [scripts/Makefile.build:503: fs] Error 2
> make: *** [Makefile:2025: .] Error 2
> 
> 
> 
> I'm not a coder, so I checked it with OpenAI, which throwed out the following patch:
> 
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1822,8 +1822,12 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca, struct nfsd_net *nn
>         */
>         scale_factor = max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
> 
> -       avail = clamp_t(unsigned long, avail, slotsize,
> -                       total_avail/scale_factor);
> +       /* Ensure hi >= lo per "give at least one slot" policy */
> +       do {
> +               unsigned long hi = total_avail / scale_factor;
> +               if (hi < slotsize) hi = slotsize;
> +               avail = clamp_t(unsigned long, avail, slotsize, hi);
> +       } while (0);
>         num = min_t(int, num, avail / slotsize);
> 
> 
> 
> After implementing it, I'm able to compile the kernel.
> But, as I mentioned before, I'm not a coder, so I cannot test the patch from a programming perspective.
> 
> Therefore, it would be nice if a patch could be made available by a human. :)
> 
> Thanks in advance - regards,
> Michael
> 
> View: https://bugzilla.kernel.org/show_bug.cgi?id=220745#c0
> You can reply to this message to join the discussion.

The failing code was introduced by commit 2030ca560c5f ("nfsd: degraded
slot-count more gracefully as allocation nears exhaustion.") in v5.4. It
is not a backport to v6.1. I don't see any changes to that code until
b5fba969a2e4 ("nfsd: remove artificial limits on the session-based
DRC"), when it was removed whole-sale.

That means we don't have this code to patch in upstream. If there is a
fix to be made in NFSD, we will have to create one-off patches for each
of the LTS kernels.

It appears that there have been several clean-ups to clamp_t and friends
since v6.1, and they have been mostly backported to v6.1.y. It's hard to
say without a bisect whether one of those is the reason for the
breakage.

Neil, according to the last touch rule, you're the owner of this code
;-) Do you have any thoughts? I'm not quite sure what the compile-time
assertion is complaining about.


-- 
Chuck Lever

