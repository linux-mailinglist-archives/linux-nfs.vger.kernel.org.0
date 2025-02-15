Return-Path: <linux-nfs+bounces-10140-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C8DA36F7E
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Feb 2025 17:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A401916D38E
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Feb 2025 16:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EF315CD41;
	Sat, 15 Feb 2025 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIay/Ck9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2289D529
	for <linux-nfs@vger.kernel.org>; Sat, 15 Feb 2025 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739637494; cv=none; b=MWSo+uY7+hqo/tzYVTyLqQOnpD3djsjgdGkYeUgmNt4BNSVNEtmXh+HN+iBFSFGDSsF1Sfq/0tS8nXDRA5nDzUWVLWRqn/kwdWcUdjzwE539y0K352XiQaTcXi2CIJoKuH+H6edL9h+z3NFPcXqCqFx0QF9vK2xDYR81pO9JmVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739637494; c=relaxed/simple;
	bh=UOdZzIrawX0Hp2iNiMxmEVaHsHM8dBZpA0h9d2vVfyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmprFk28c5MMuvE8M3Qn3xgDHBHyyxSB+DqPhgRKkWgfXhhPmN8WwSmFJeZv24ZF/xOyG366GfgD6KHDP0Wc2IuWZRAywpNELpXIJ/2RXZiTD44oi0+8LhHzyoxsvX8sf+DnRGX/bPSPh1Z+EetVbng+8FT+sx6IlVdjqqdWL6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIay/Ck9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0077C4CEDF;
	Sat, 15 Feb 2025 16:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739637493;
	bh=UOdZzIrawX0Hp2iNiMxmEVaHsHM8dBZpA0h9d2vVfyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lIay/Ck9UQOVAFBt0q/PndkmD+mGDXGjZSBf5TQa6UWMaRHNxCD22WYMEeEplxUch
	 8jxZCkF2pCe4eImdkhttYUwCedNjLYlXoziLRiBAAnPFRcj23kBdhEqBAMP628rzA/
	 /80/+sIi+uJLpHvmZOsF+vLCbN+AYMTZh0wee9XrMnp6Bo5JymJ5Y3vWWSAE+Ogjjm
	 PqV+UfkqhMYREmAV3CMvD5dMoYcWHOxoWiti83mSI2vgVuxGyy4tY0JenwGg+z3AZ8
	 FSUnagiy3iTOifx+pkv7fXAmhOFGfx5i5y4FHvZith2eoNdc73v1Y02Kc0UkiwRKMh
	 iLV8HyXFJUIHg==
Received: by pali.im (Postfix)
	id 80A02676; Sat, 15 Feb 2025 17:38:00 +0100 (CET)
Date: Sat, 15 Feb 2025 17:38:00 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Mike Snitzer <snitzer@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: nfs compile error nfslocalio.o and localio.o since v6.14-rc1
Message-ID: <20250215163800.v4qdyum6slbzbmts@pali>
References: <20250215120054.mfvr2fzs5426bthx@pali>
 <4c790142-7126-413d-a2f3-bb080bb26ce6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c790142-7126-413d-a2f3-bb080bb26ce6@oracle.com>
User-Agent: NeoMutt/20180716

On Saturday 15 February 2025 11:29:45 Chuck Lever wrote:
> Hi Pali -
> 
> On 2/15/25 7:00 AM, Pali Rohár wrote:
> > Hello, since v6.14-rc1, file nfslocalio.c cannot be compiled with
> > gcc-8.3 and attached .config file. Same problem is with localio.c.
> 
> If the interwebs are correct, gcc-8.3 was released in 2014. ISTR that
> recent releases of the Linux kernel no longer support gcc versions that
> old.

Hello, I know that this is old version, and I specially used it just to
check if everything compiles correctly. And it failed.

Per https://docs.kernel.org/process/changes.html the minimal version of
gcc is 5.1, so I think that compilation with gcc 8.3 should still be
supported.

> It appears to be snagging on kernel-wide utility helpers, not code
> specific to NFS.

It looks like that, but only those two nfs files cause compile errors.
Everything else compiles without problem. So it is quite suspicious and
maybe it could signal that those helper are used incorrectly in nfs
code? I'm not sure, I have not investigated it.

> If that's the case, it might not be possible for us to address this
> breakage.
> 
> Adding Mike, who contributed this code.
> 
> > Error is:
> > 
> > $ make bzImage
> >   CALL    scripts/checksyscalls.sh
> >   DESCEND objtool
> >   INSTALL libsubcmd_headers
> >   CC      fs/nfs_common/nfslocalio.o
> > In file included from ./include/linux/rbtree.h:24,
> >                  from ./include/linux/mm_types.h:11,
> >                  from ./include/linux/mmzone.h:22,
> >                  from ./include/linux/gfp.h:7,
> >                  from ./include/linux/umh.h:4,
> >                  from ./include/linux/kmod.h:9,
> >                  from ./include/linux/module.h:17,
> >                  from fs/nfs_common/nfslocalio.c:7:
> > fs/nfs_common/nfslocalio.c: In function ‘nfs_close_local_fh’:
> > ./include/linux/rcupdate.h:531:9: error: dereferencing pointer to incomplete type ‘struct nfsd_file’
> >   typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
> >          ^
> > ./include/linux/rcupdate.h:650:31: note: in expansion of macro ‘__rcu_access_pointer’
> >  #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
> >                                ^~~~~~~~~~~~~~~~~~~~
> > fs/nfs_common/nfslocalio.c:288:10: note: in expansion of macro ‘rcu_access_pointer’
> >   ro_nf = rcu_access_pointer(nfl->ro_file);
> >           ^~~~~~~~~~~~~~~~~~
> > make[4]: *** [scripts/Makefile.build:207: fs/nfs_common/nfslocalio.o] Error 1
> > make[3]: *** [scripts/Makefile.build:465: fs/nfs_common] Error 2
> > make[2]: *** [scripts/Makefile.build:465: fs] Error 2
> > make[1]: *** [/home/pali/develop/kernel.org/linux/Makefile:1994: .] Error 2
> > make: *** [Makefile:251: __sub-make] Error 2
> > 
> > 
> > $ make fs/nfs/localio.o
> >   CALL    scripts/checksyscalls.sh
> >   DESCEND objtool
> >   INSTALL libsubcmd_headers
> >   CC      fs/nfs/localio.o
> > In file included from ./include/linux/rbtree.h:24,
> >                  from ./include/linux/mm_types.h:11,
> >                  from ./include/linux/mmzone.h:22,
> >                  from ./include/linux/gfp.h:7,
> >                  from ./include/linux/umh.h:4,
> >                  from ./include/linux/kmod.h:9,
> >                  from ./include/linux/module.h:17,
> >                  from fs/nfs/localio.c:11:
> > fs/nfs/localio.c: In function ‘nfs_local_open_fh’:
> > ./include/linux/rcupdate.h:538:9: error: dereferencing pointer to incomplete type ‘struct nfsd_file’
> >   typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
> >          ^
> > ./include/linux/rcupdate.h:686:2: note: in expansion of macro ‘__rcu_dereference_check’
> >   __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
> >   ^~~~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/rcupdate.h:758:28: note: in expansion of macro ‘rcu_dereference_check’
> >  #define rcu_dereference(p) rcu_dereference_check(p, 0)
> >                             ^~~~~~~~~~~~~~~~~~~~~
> > fs/nfs/localio.c:275:7: note: in expansion of macro ‘rcu_dereference’
> >   nf = rcu_dereference(*pnf);
> >        ^~~~~~~~~~~~~~~
> > make[4]: *** [scripts/Makefile.build:207: fs/nfs/localio.o] Error 1
> > make[3]: *** [scripts/Makefile.build:465: fs/nfs] Error 2
> > make[2]: *** [scripts/Makefile.build:465: fs] Error 2
> > make[1]: *** [/home/pali/develop/kernel.org/linux/Makefile:1994: .] Error 2
> > make: *** [Makefile:251: __sub-make] Error 2
> > 
> > 
> > Reproduced from commit 7ff71e6d9239 ("Merge tag 'alpha-fixes-v6.14-rc2'
> > of git://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha").
> 
> 
> -- 
> Chuck Lever

