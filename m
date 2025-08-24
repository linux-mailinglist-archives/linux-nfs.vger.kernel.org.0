Return-Path: <linux-nfs+bounces-13880-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A66B33122
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Aug 2025 17:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200C01896CC3
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Aug 2025 15:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC712A935;
	Sun, 24 Aug 2025 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TeKbaE21"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-10697.protonmail.ch (mail-10697.protonmail.ch [79.135.106.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAE01FB3
	for <linux-nfs@vger.kernel.org>; Sun, 24 Aug 2025 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756048891; cv=none; b=ptCt0eByZswzBIPUHQ1Rkusrzux1Bj0kM0sGPe3gcRJhFrobO+MXpLoE3O2Suw1KeqJ1IVo5ICPezce2c4KOTb0iq0MLBQKH/u3XIQYPVw9JnJ6tEeg7L1gTgme/S32RMGJIlHxPw4PKMt9W8HFwuyYmu8PXpcLDTDKi06Z+q+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756048891; c=relaxed/simple;
	bh=idLR8m8lIuuCvDvvmHzEkoud+YvqiCcPFvbe39vhnRg=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fhQ+rcmH79wz6Iqsz+CxBiZX+AYImpFSs+K2QFHb7IuujincB+DXbu6A5HuR7Z/rvsgO6MXGREk6UP9alDo1idRrZsUMieWLF309wTbsP7b7q/n/ptYth8S/GyZmStU0RjmF0wlbF1rWjVXLaU1D//ZqujhwlCT+v4PXGtoYxoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=TeKbaE21; arc=none smtp.client-ip=79.135.106.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1756048880; x=1756308080;
	bh=uWm/pmVhm/PcQGkZn4bM6I/xxipkQHd1Qdmr7p5a0U0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=TeKbaE21MOwzQLDTJ6sf5yxK1B2pU9Eniru9MZk6Gg7C6e897Ti/FLHZrofLzMUsd
	 UWqalvjT65IHmOxs907t1qnFKAcy+ED8CZn6gckb4+KeSyRVG9ZktBqVSgM1qqEzd2
	 IV2xsM4pQVKthgZQySxiP0t7w9h5Njq0hXh0mtQ4OqW0dBh1ZueojRzjp607Ex4PdR
	 HIE9ocqtPt+H+vCWfS7WIQOyTB92QQDIOsy4XMinGXWPXfXt9lLm84WBYCai+T0LbF
	 KN0I6dtKxnWpinqlqDpXie8ZJO+9GTQkscfPiqRNJQO3OmjKUbqFIMGOPWYg6GkUEm
	 thT8c2nNlAH8g==
Date: Sun, 24 Aug 2025 15:21:17 +0000
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
From: John <therealgraysky@proton.me>
Cc: "steved@redhat.com" <steved@redhat.com>
Subject: [PATCH] fix cleanup_lockfiles function linkage in exportd
Message-ID: <nflkbymsZf-JPtqHSc_evn9hseuYTvvgOCi606D0q7qJmzqBgiTg17wPCbWZLOnSEPoc7gftHIdaFz-bJm-5nI1-QFGSHYBe1trF6yMyAsI=@proton.me>
Feedback-ID: 47473199:user:proton
X-Pm-Message-ID: 6844f6be056543f63f4ef2a56cd935922758ecf3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From d18643a9fe0e612e823d07cb75d36b4641033f09 Mon Sep 17 00:00:00 2001
From: John Audia <therealgraysky@proton.me>
Date: Sun, 24 Aug 2025 11:00:44 -0400
Subject: [PATCH] fix cleanup_lockfiles function linkage in exportd

The cleanup_lockfiles function in utils/exportd/exportd.c was declared
as 'inline void' without a proper function prototype, causing linker
errors during the build process:

  exportd.c:(.text+0x5a): undefined reference to `cleanup_lockfiles'
  exportd.c:(.text.startup+0x317): undefined reference to `cleanup_lockfile=
s'

This occurred because:
1. The inline keyword prevented the compiler from generating a callable
   function symbol in some build configurations
2. The function lacked a proper prototype declaration, triggering
   -Werror=3Dmissing-prototypes

The fix changes the function to:
- Remove the 'inline' keyword to ensure symbol generation
- Add a proper static function prototype
- Make the function 'static' since it's only used within exportd.c

This resolves both the linking error and the missing prototype warning,
allowing exportd to build successfully in OpenWrt's cross-compilation
environment.
---
 utils/exportd/exportd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/utils/exportd/exportd.c b/utils/exportd/exportd.c
index a2e370ac506f..956e4d732f00 100644
--- a/utils/exportd/exportd.c
+++ b/utils/exportd/exportd.c
@@ -51,9 +51,10 @@ static char shortopts[] =3D "d:fghs:t:liT:";
 /*
  * Signal handlers.
  */
+static void cleanup_lockfiles(void);
 inline static void set_signals(void);
=20
-inline void
+static void
 cleanup_lockfiles (void)
 {
 =09unlink(etab.lockfn);
--=20
2.50.1



