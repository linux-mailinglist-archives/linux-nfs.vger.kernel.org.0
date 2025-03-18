Return-Path: <linux-nfs+bounces-10658-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5DAA67CB7
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Mar 2025 20:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78EE3A5843
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Mar 2025 19:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D89212B34;
	Tue, 18 Mar 2025 19:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoYBKe/0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E9A1D63CD
	for <linux-nfs@vger.kernel.org>; Tue, 18 Mar 2025 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324736; cv=none; b=tQ2k1V0swlOTFVX7SbGQQmxQ1KNFlKFUgsum4Kbhg7Q/i6lHf1V/T0qPQ3gJ3FJ5vyMagtopOztslkzRQJx0ECUacuqBQPV9iWX5dO/emDHctAtxgWwkyDwgizVTGEPdMLjiRFkyM1qu49S0OgKcufl39ntKM1cZhMefOUEKaCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324736; c=relaxed/simple;
	bh=CC8fwkuAKmYWIa0a4EC8EUNi1nRgxq5hSct8Sf9cHmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Id2PH1mAyuOFTc60ZY90MojnUetxLqoaSwaHVHpswOATDZnT9DF+/mcaCxlHoKhRPoPptsfDx7Pqa2LhwBg0bOKyNU9Xk8f1janipdQDTYRMJhZdu/jP4gfAtli4+0dPagrQf63HsDNAiU1RWhjo5efxPe+A8S5EjvHZYq7muvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoYBKe/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1619EC4CEDD;
	Tue, 18 Mar 2025 19:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742324735;
	bh=CC8fwkuAKmYWIa0a4EC8EUNi1nRgxq5hSct8Sf9cHmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VoYBKe/0ttwglrw+5GydlGegBU+80neVQHvJMF27OTtUzI+WpJvG0T7HGbsaLnLeX
	 9D+hHCsn5ZCussqoiI0+uwPe+oyg1+o2cwl3bKh5F9an7mVLQH7RAh+zrKymWsLhk8
	 7eHZFOM+tRibd/Ecsk17vcmnSg/dA17fU+mbLTYRUYHaiLF86an+BXCveigwLoaYeC
	 bR4DRktu/PrgBQuyeMs8oN+v3INGyMattBE62lG7Y77X5HzAHIsUtNe8kx/ewMG+i8
	 mI4YqgHhMX5BTj4cEUI5hJzif7Qnj2JtnVB99MnZUtRTqQnpU20THuHYJ8ED76vHyH
	 ly3gLH/7EWSIQ==
Received: by pali.im (Postfix)
	id 30FD7A4E; Tue, 18 Mar 2025 20:05:20 +0100 (CET)
Date: Tue, 18 Mar 2025 20:05:20 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Mike Snitzer <snitzer@redhat.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: nfs compile error nfslocalio.o and localio.o since v6.14-rc1
Message-ID: <20250318190520.efwb45jarbyacnw4@pali>
References: <20250215120054.mfvr2fzs5426bthx@pali>
 <4c790142-7126-413d-a2f3-bb080bb26ce6@oracle.com>
 <20250215163800.v4qdyum6slbzbmts@pali>
 <a8e12721-721e-41d1-9192-940c01e7f0f0@oracle.com>
 <20250215165100.jlibe46qwwdfgau5@pali>
 <20250223182746.do2irr7uxpwhjycd@pali>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250223182746.do2irr7uxpwhjycd@pali>
User-Agent: NeoMutt/20180716

PING?

On Sunday 23 February 2025 19:27:46 Pali Rohár wrote:
> Mike, have you looked at this issue?
> 
> On Saturday 15 February 2025 17:51:00 Pali Rohár wrote:
> > On Saturday 15 February 2025 11:41:25 Chuck Lever wrote:
> > > On 2/15/25 11:38 AM, Pali Rohár wrote:
> > > > On Saturday 15 February 2025 11:29:45 Chuck Lever wrote:
> > > >> Hi Pali -
> > > >>
> > > >> On 2/15/25 7:00 AM, Pali Rohár wrote:
> > > >>> Hello, since v6.14-rc1, file nfslocalio.c cannot be compiled with
> > > >>> gcc-8.3 and attached .config file. Same problem is with localio.c.
> > > >>
> > > >> If the interwebs are correct, gcc-8.3 was released in 2014. ISTR that
> > > >> recent releases of the Linux kernel no longer support gcc versions that
> > > >> old.
> > > > 
> > > > Hello, I know that this is old version, and I specially used it just to
> > > > check if everything compiles correctly. And it failed.
> > > > 
> > > > Per https://docs.kernel.org/process/changes.html the minimal version of
> > > > gcc is 5.1, so I think that compilation with gcc 8.3 should still be
> > > > supported.
> > > > 
> > > >> It appears to be snagging on kernel-wide utility helpers, not code
> > > >> specific to NFS.
> > > > 
> > > > It looks like that, but only those two nfs files cause compile errors.
> > > > Everything else compiles without problem. So it is quite suspicious and
> > > > maybe it could signal that those helper are used incorrectly in nfs
> > > > code? I'm not sure, I have not investigated it.
> > > 
> > > A bisect would be helpful.
> > > 
> > > Also, what is the CPU platform architecture? x86_64?
> > 
> > Yes, it is x86_64, I hope that all details/configuration is in the
> > .config file. I took generic gcc 8.3 version which was distributed by
> > some debian version. So nothing special.
> > 
> > > 
> > > >> If that's the case, it might not be possible for us to address this
> > > >> breakage.
> > > >>
> > > >> Adding Mike, who contributed this code.
> > > >>
> > > >>> Error is:
> > > >>>
> > > >>> $ make bzImage
> > > >>>   CALL    scripts/checksyscalls.sh
> > > >>>   DESCEND objtool
> > > >>>   INSTALL libsubcmd_headers
> > > >>>   CC      fs/nfs_common/nfslocalio.o
> > > >>> In file included from ./include/linux/rbtree.h:24,
> > > >>>                  from ./include/linux/mm_types.h:11,
> > > >>>                  from ./include/linux/mmzone.h:22,
> > > >>>                  from ./include/linux/gfp.h:7,
> > > >>>                  from ./include/linux/umh.h:4,
> > > >>>                  from ./include/linux/kmod.h:9,
> > > >>>                  from ./include/linux/module.h:17,
> > > >>>                  from fs/nfs_common/nfslocalio.c:7:
> > > >>> fs/nfs_common/nfslocalio.c: In function ‘nfs_close_local_fh’:
> > > >>> ./include/linux/rcupdate.h:531:9: error: dereferencing pointer to incomplete type ‘struct nfsd_file’
> > > >>>   typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
> > > >>>          ^
> > > >>> ./include/linux/rcupdate.h:650:31: note: in expansion of macro ‘__rcu_access_pointer’
> > > >>>  #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
> > > >>>                                ^~~~~~~~~~~~~~~~~~~~
> > > >>> fs/nfs_common/nfslocalio.c:288:10: note: in expansion of macro ‘rcu_access_pointer’
> > > >>>   ro_nf = rcu_access_pointer(nfl->ro_file);
> > > >>>           ^~~~~~~~~~~~~~~~~~
> > > >>> make[4]: *** [scripts/Makefile.build:207: fs/nfs_common/nfslocalio.o] Error 1
> > > >>> make[3]: *** [scripts/Makefile.build:465: fs/nfs_common] Error 2
> > > >>> make[2]: *** [scripts/Makefile.build:465: fs] Error 2
> > > >>> make[1]: *** [/home/pali/develop/kernel.org/linux/Makefile:1994: .] Error 2
> > > >>> make: *** [Makefile:251: __sub-make] Error 2
> > > >>>
> > > >>>
> > > >>> $ make fs/nfs/localio.o
> > > >>>   CALL    scripts/checksyscalls.sh
> > > >>>   DESCEND objtool
> > > >>>   INSTALL libsubcmd_headers
> > > >>>   CC      fs/nfs/localio.o
> > > >>> In file included from ./include/linux/rbtree.h:24,
> > > >>>                  from ./include/linux/mm_types.h:11,
> > > >>>                  from ./include/linux/mmzone.h:22,
> > > >>>                  from ./include/linux/gfp.h:7,
> > > >>>                  from ./include/linux/umh.h:4,
> > > >>>                  from ./include/linux/kmod.h:9,
> > > >>>                  from ./include/linux/module.h:17,
> > > >>>                  from fs/nfs/localio.c:11:
> > > >>> fs/nfs/localio.c: In function ‘nfs_local_open_fh’:
> > > >>> ./include/linux/rcupdate.h:538:9: error: dereferencing pointer to incomplete type ‘struct nfsd_file’
> > > >>>   typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
> > > >>>          ^
> > > >>> ./include/linux/rcupdate.h:686:2: note: in expansion of macro ‘__rcu_dereference_check’
> > > >>>   __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
> > > >>>   ^~~~~~~~~~~~~~~~~~~~~~~
> > > >>> ./include/linux/rcupdate.h:758:28: note: in expansion of macro ‘rcu_dereference_check’
> > > >>>  #define rcu_dereference(p) rcu_dereference_check(p, 0)
> > > >>>                             ^~~~~~~~~~~~~~~~~~~~~
> > > >>> fs/nfs/localio.c:275:7: note: in expansion of macro ‘rcu_dereference’
> > > >>>   nf = rcu_dereference(*pnf);
> > > >>>        ^~~~~~~~~~~~~~~
> > > >>> make[4]: *** [scripts/Makefile.build:207: fs/nfs/localio.o] Error 1
> > > >>> make[3]: *** [scripts/Makefile.build:465: fs/nfs] Error 2
> > > >>> make[2]: *** [scripts/Makefile.build:465: fs] Error 2
> > > >>> make[1]: *** [/home/pali/develop/kernel.org/linux/Makefile:1994: .] Error 2
> > > >>> make: *** [Makefile:251: __sub-make] Error 2
> > > >>>
> > > >>>
> > > >>> Reproduced from commit 7ff71e6d9239 ("Merge tag 'alpha-fixes-v6.14-rc2'
> > > >>> of git://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha").
> > > >>
> > > >>
> > > >> -- 
> > > >> Chuck Lever
> > > 
> > > 
> > > -- 
> > > Chuck Lever

