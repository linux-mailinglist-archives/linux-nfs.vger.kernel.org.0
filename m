Return-Path: <linux-nfs+bounces-16041-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 585A2C3474B
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 09:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D392334B211
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 08:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8131A28000F;
	Wed,  5 Nov 2025 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXRbjE1G"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3E525F99B
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331133; cv=none; b=L3+n47RWPBh1zG3yOzUPu0OGBB2neN8FkKyr++S9ia3gpG9vX729jY4R90H49NtNoci/ChdxAJoWZaSeBr2r3XLHgYVkj6Lh8HGd7YnMyWaKuyUxVdF/2D3i7uJ5tWHhVMFmCDNb10+ALIlWlMeSEKbskaXhyXj4UqFbgA99Swo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331133; c=relaxed/simple;
	bh=+PVE+N9Tw9SWJEHMb5RvYHaG0QAcd3jnYWrWPmNHzko=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=mVmVPvoEeLZLMt6FgrKgyiNCeoO2sSPozxLVNI40iRuE+Ktg3bE+xUwQPD1Xd/tTvuRn9hg9SJi2p1VrmV/SUG07qfCYd2rgrx86MQv4u21w2L4PJwILEdSZqaZMop7JMsegghb5BMjvGOoxQ8hYwzbSwzBDpeV9VDDdefoOjAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXRbjE1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C260C4CEF8;
	Wed,  5 Nov 2025 08:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762331133;
	bh=+PVE+N9Tw9SWJEHMb5RvYHaG0QAcd3jnYWrWPmNHzko=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=QXRbjE1G7eRy/Ew08I7q/mx6upoiz9xDid3HXY5fuC3WDmlCs7epvxm3YylnHAUqh
	 IVbc1qAAe/ovZBTT0PPfvz2wgZjJW31gP3sH45tV2zyIjCENNeV1avq+PIuyvw3uIa
	 lRMUOhJfY/89p1MgJeAvLTYM/hapSnB3yFfSmlr8CtH7naYsPO+X6rtYVmL3qNxP7r
	 8S4WP4P7DtGrjYJM3aWgHL0HO+jidU4gh9Kdm4s3jhgCVCZEBSTv5gT1Tm1w/IQw9g
	 hu/ITsrN4PboZl+22FV6MHud/XH8ANrzqdhQIXGs6rNunJDCnc3dDxtwLrhLfpzHi/
	 MtHhH5xTjOgOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EF341380AA60;
	Wed,  5 Nov 2025 08:25:07 +0000 (UTC)
From: Mike-SPC via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 05 Nov 2025 08:25:07 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: trondmy@kernel.org, anna@kernel.org, neilb@ownmail.net, 
 neilb@brown.name, cel@kernel.org, jlayton@kernel.org, 
 linux-nfs@vger.kernel.org
Message-ID: <20251105-b220745c3-74933c7ce30f@bugzilla.kernel.org>
In-Reply-To: <176229484269.1793333.9105827008525809090@noble.neil.brown.name>
References: <176229484269.1793333.9105827008525809090@noble.neil.brown.name>
Subject: Re: Compile Error fs/nfsd/nfs4state.o - clamp() low limit slotsize
 greater than high limit total_avail/scale_factor
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Mike-SPC writes via Kernel.org Bugzilla:

(In reply to Bugspray Bot from comment #2)
> NeilBrown <neilb@ownmail.net> replies to comment #1:
> 
> On Wed, 05 Nov 2025, Chuck Lever wrote:
> > On 11/4/25 9:15 AM, Mike-SPC via Bugspray Bot wrote:
> > > Mike-SPC writes via Kernel.org Bugzilla:
> > > 
> > > Hi there,
> > > 
> > > with kernel version > 6.1.156 I get the following error by compiling it
> > (make bzImage) on a 32bit platform:
> 
> Which platform?  Which compiler?
> 
> I just build nfsd on 6.1.158 for mips (32 bit) with
> 
> $ /opt/cross/bin/mipsel-unknown-linux-gnu-gcc -v
> Using built-in specs.
> COLLECT_GCC=/opt/cross/bin/mipsel-unknown-linux-gnu-gcc
> COLLECT_LTO_WRAPPER=/opt/cross/libexec/gcc/mipsel-unknown-linux-gnu/7.2.0/
> lto-wrapper
> Target: mipsel-unknown-linux-gnu
> Configured with: ../configure --target=mipsel-unknown-linux-gnu
> --prefix=/opt/cross --enable-languages=c --without-headers --with-gnu-ld
> --with-gnu-as --disable-shared --disable-threads --disable-libmudflap
> --disable-libgomp --disable-libssp --disable-libquadmath --disable-libatomic
> Thread model: single
> gcc version 7.2.0 (GCC) 
> 
> and it worked fine.
> 
> Have you found a 6.1.y kernel for which the build doesn't fail?
> 
> There is no way that code could reasonably trigger that warning.
> I suspect a compiler bug/incompatibility.
> If you compiler is GCC earlier than 5.1 or Clang before 11.0.0
> then upgrade your compiler.
> If it is newer, then report the incompatibility to
> stable@vger.kernel.org.
> 
> NeilBrown

Oh - sorry for the missing information.
Platform: i686 (32bit).

Used GCC Version:

$ gcc -v
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/libexec/gcc/i686-pc-linux-gnu/9.3.0/lto-wrapper
Target: i686-pc-linux-gnu
Configured with: ../configure --prefix=/usr --enable-languages=c,c++ --disable-multilib --disable-bootstrap --with-system-zlib
Thread model: posix
gcc version 9.3.0 (GCC)


So it seems to be newer. :)



> 
> 
> > > 
> > >   CALL    scripts/checksyscalls.sh
> > >   CC      fs/nfsd/nfs4state.o
> > > In file included from <command-line>:
> > > In function 'nfsd4_get_drc_mem',
> > >     inlined from 'check_forechannel_attrs' at
> fs/nfsd/nfs4state.c:3539:16,
> > >     inlined from 'nfsd4_create_session' at fs/nfsd/nfs4state.c:3612:11:
> > > ././include/linux/compiler_types.h:375:38: error: call to
> > '__compiletime_assert_587' declared with attribute error: clamp() low limit
> > slotsize greater than high limit total_avail/scale_factor
> > >   375 |  _compiletime_assert(condition, msg, __compiletime_assert_,
> > __COUNTER__)
> > >       |                                      ^
> > > ././include/linux/compiler_types.h:356:4: note: in definition of macro
> > '__compiletime_assert'
> > >   356 |    prefix ## suffix();    \
> > >       |    ^~~~~~
> > > ././include/linux/compiler_types.h:375:2: note: in expansion of macro
> > '_compiletime_assert'
> > >   375 |  _compiletime_assert(condition, msg, __compiletime_assert_,
> > __COUNTER__)
> > >       |  ^~~~~~~~~~~~~~~~~~~
> > > ./include/linux/build_bug.h:39:37: note: in expansion of macro
> > 'compiletime_assert'
> > >    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond),
> > msg)
> > >       |                                     ^~~~~~~~~~~~~~~~~~
> > > ./include/linux/minmax.h:188:2: note: in expansion of macro
> > 'BUILD_BUG_ON_MSG'
> > >   188 |  BUILD_BUG_ON_MSG(statically_true(ulo > uhi),    \
> > >       |  ^~~~~~~~~~~~~~~~
> > > ./include/linux/minmax.h:195:2: note: in expansion of macro
> '__clamp_once'
> > >   195 |  __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_),
> __UNIQUE_ID(l_),
> > __UNIQUE_ID(h_))
> > >       |  ^~~~~~~~~~~~
> > > ./include/linux/minmax.h:218:36: note: in expansion of macro
> > '__careful_clamp'
> > >   218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo,
> > hi)
> > >       |                                    ^~~~~~~~~~~~~~~
> > > fs/nfsd/nfs4state.c:1825:10: note: in expansion of macro 'clamp_t'
> > >  1825 |  avail = clamp_t(unsigned long, avail, slotsize,
> > >       |          ^~~~~~~
> > > make[3]: *** [scripts/Makefile.build:250: fs/nfsd/nfs4state.o] Error 1
> > > make[2]: *** [scripts/Makefile.build:503: fs/nfsd] Error 2
> > > make[1]: *** [scripts/Makefile.build:503: fs] Error 2
> > > make: *** [Makefile:2025: .] Error 2
> > > 
> > > 
> > > 
> > > I'm not a coder, so I checked it with OpenAI, which throwed out the
> > following patch:
> > > 
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -1822,8 +1822,12 @@ static u32 nfsd4_get_drc_mem(struct
> > nfsd4_channel_attrs *ca, struct nfsd_net *nn
> > >         */
> > >         scale_factor = max_t(unsigned int, 8,
> nn->nfsd_serv->sv_nrthreads);
> > > 
> > > -       avail = clamp_t(unsigned long, avail, slotsize,
> > > -                       total_avail/scale_factor);
> > > +       /* Ensure hi >= lo per "give at least one slot" policy */
> > > +       do {
> > > +               unsigned long hi = total_avail / scale_factor;
> > > +               if (hi < slotsize) hi = slotsize;
> > > +               avail = clamp_t(unsigned long, avail, slotsize, hi);
> > > +       } while (0);
> > >         num = min_t(int, num, avail / slotsize);
> > > 
> > > 
> > > 
> > > After implementing it, I'm able to compile the kernel.
> > > But, as I mentioned before, I'm not a coder, so I cannot test the patch
> > from a programming perspective.
> > > 
> > > Therefore, it would be nice if a patch could be made available by a
> human.
> > :)
> > > 
> > > Thanks in advance - regards,
> > > Michael
> > > 
> > > View: https://bugzilla.kernel.org/show_bug.cgi?id=220745#c0
> > > You can reply to this message to join the discussion.
> > 
> > The failing code was introduced by commit 2030ca560c5f ("nfsd: degraded
> > slot-count more gracefully as allocation nears exhaustion.") in v5.4. It
> > is not a backport to v6.1. I don't see any changes to that code until
> > b5fba969a2e4 ("nfsd: remove artificial limits on the session-based
> > DRC"), when it was removed whole-sale.
> > 
> > That means we don't have this code to patch in upstream. If there is a
> > fix to be made in NFSD, we will have to create one-off patches for each
> > of the LTS kernels.
> > 
> > It appears that there have been several clean-ups to clamp_t and friends
> > since v6.1, and they have been mostly backported to v6.1.y. It's hard to
> > say without a bisect whether one of those is the reason for the
> > breakage.
> > 
> > Neil, according to the last touch rule, you're the owner of this code
> > ;-) Do you have any thoughts? I'm not quite sure what the compile-time
> > assertion is complaining about.
> > 
> > 
> > -- 
> > Chuck Lever
> > 
> >
> 
> (via
> https://msgid.link/176229484269.1793333.9105827008525809090@noble.neil.brown.
> name)

View: https://bugzilla.kernel.org/show_bug.cgi?id=220745#c3
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


