Return-Path: <linux-nfs+bounces-16001-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E245AC317C1
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 15:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC39146234E
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 14:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD3F32D425;
	Tue,  4 Nov 2025 14:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RibEbjAR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBB232D7F4
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265736; cv=none; b=IWwfdnvi0yLEvbvHQEYkCu/JjTCmyS+NUzD8r1JzwqfZwyySxJzWuv1AwYjvNpA1FUmt6sKH59DWVVoWR/ddiplVwXvU6VXQ1TZlOpG5NTlrooRf0x0Nx/O2wPNlJLRPPh8ZFWe6TbwYD2Z1gDpsELXRa6WnzLtv9+7gpEx6o7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265736; c=relaxed/simple;
	bh=iXUhisT92YrJePimXAHYv72whd8ix/xWWZ1OR6m3NPE=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:Subject; b=bim0bzM6xfYQyooPaOcW6pAqZuChfAE9yW90OAv24/Mdq5kxddILEHo/ziopS0P7KG4T0ljnymZaslnMfhO5y6DVk6R9y0JvUdDUD/PoxYC4zFeg4i09RmHOzIJtddLIghOTRJeVMCa2LOruLmBzyej85M+SHXPiCVoeBaMDcIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RibEbjAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C149FC4CEF7;
	Tue,  4 Nov 2025 14:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762265735;
	bh=iXUhisT92YrJePimXAHYv72whd8ix/xWWZ1OR6m3NPE=;
	h=From:Date:To:Subject:From;
	b=RibEbjARLuaz9B4vmYDWd9VZ/eEbyHxnIy3avhvrrwPJbKNMd1iUXiVOGrVJsrJw+
	 PRnhxogGxMonz6cUSuc2yMU9B5A8zjOzFQa7FsJAsAQgyGrqpD/omPPcoUs3mX72L5
	 S5Mj48lZJdgRsyh92WXISa4n1+aHq5fvWTK/TZQQzudTxvoMolWQa6R7XPakyaYz2s
	 BhpujBa1jFo9jpsbf4bY7srxWyNE8Wsgy0NjWVWC4ePRUCrQh8yk4ofAUFAFCmEA/x
	 0ftF8VsywdILFiS+ClhjJbrTwO5ETlvviIQ8YOFNrqwSQZHrgPxPOS4Pv7LFtNNPf1
	 F47JU9Z53CDSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EECE0380A975;
	Tue,  4 Nov 2025 14:15:10 +0000 (UTC)
From: Mike-SPC via Bugspray Bot <bugbot@kernel.org>
Date: Tue, 04 Nov 2025 14:15:07 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: anna@kernel.org, linux-nfs@vger.kernel.org, cel@kernel.org, 
 jlayton@kernel.org, trondmy@kernel.org
Message-ID: <20251104-b220745c0-91170b3b3642@bugzilla.kernel.org>
Subject: Compile Error fs/nfsd/nfs4state.o - clamp() low limit slotsize
 greater than high limit total_avail/scale_factor
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Mike-SPC writes via Kernel.org Bugzilla:

Hi there,

with kernel version > 6.1.156 I get the following error by compiling it (make bzImage) on a 32bit platform:

  CALL    scripts/checksyscalls.sh
  CC      fs/nfsd/nfs4state.o
In file included from <command-line>:
In function 'nfsd4_get_drc_mem',
    inlined from 'check_forechannel_attrs' at fs/nfsd/nfs4state.c:3539:16,
    inlined from 'nfsd4_create_session' at fs/nfsd/nfs4state.c:3612:11:
././include/linux/compiler_types.h:375:38: error: call to '__compiletime_assert_587' declared with attribute error: clamp() low limit slotsize greater than high limit total_avail/scale_factor
  375 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                      ^
././include/linux/compiler_types.h:356:4: note: in definition of macro '__compiletime_assert'
  356 |    prefix ## suffix();    \
      |    ^~~~~~
././include/linux/compiler_types.h:375:2: note: in expansion of macro '_compiletime_assert'
  375 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |  ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/minmax.h:188:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
  188 |  BUILD_BUG_ON_MSG(statically_true(ulo > uhi),    \
      |  ^~~~~~~~~~~~~~~~
./include/linux/minmax.h:195:2: note: in expansion of macro '__clamp_once'
  195 |  __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
      |  ^~~~~~~~~~~~
./include/linux/minmax.h:218:36: note: in expansion of macro '__careful_clamp'
  218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
      |                                    ^~~~~~~~~~~~~~~
fs/nfsd/nfs4state.c:1825:10: note: in expansion of macro 'clamp_t'
 1825 |  avail = clamp_t(unsigned long, avail, slotsize,
      |          ^~~~~~~
make[3]: *** [scripts/Makefile.build:250: fs/nfsd/nfs4state.o] Error 1
make[2]: *** [scripts/Makefile.build:503: fs/nfsd] Error 2
make[1]: *** [scripts/Makefile.build:503: fs] Error 2
make: *** [Makefile:2025: .] Error 2



I'm not a coder, so I checked it with OpenAI, which throwed out the following patch:

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1822,8 +1822,12 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca, struct nfsd_net *nn
        */
        scale_factor = max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);

-       avail = clamp_t(unsigned long, avail, slotsize,
-                       total_avail/scale_factor);
+       /* Ensure hi >= lo per "give at least one slot" policy */
+       do {
+               unsigned long hi = total_avail / scale_factor;
+               if (hi < slotsize) hi = slotsize;
+               avail = clamp_t(unsigned long, avail, slotsize, hi);
+       } while (0);
        num = min_t(int, num, avail / slotsize);



After implementing it, I'm able to compile the kernel.
But, as I mentioned before, I'm not a coder, so I cannot test the patch from a programming perspective.

Therefore, it would be nice if a patch could be made available by a human. :)

Thanks in advance - regards,
Michael

View: https://bugzilla.kernel.org/show_bug.cgi?id=220745#c0
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


