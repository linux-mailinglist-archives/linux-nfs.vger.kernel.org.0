Return-Path: <linux-nfs+bounces-1727-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E448847FF8
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Feb 2024 04:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7C0289C4E
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Feb 2024 03:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA529F9D3;
	Sat,  3 Feb 2024 03:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W97jy4qS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB54F9C1
	for <linux-nfs@vger.kernel.org>; Sat,  3 Feb 2024 03:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706932516; cv=none; b=OFGEDJe/A6s7/WiFP9CYhFkrhrm0uTtFtVLBTHblS6MyAUd5e1WtPLVEqxpUF4V4ppkoFMcVg4YoTT/8PMzeG1CXFpmOAbsmULcfxiqzrdpEYxtZMHwsZMAJ2Fs8MOI/OyjXBzvj5tt5p6w1ro4Mf39mWb9qummCUp72BR6/Ve8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706932516; c=relaxed/simple;
	bh=RgZ4aM662QhXjyVR/VedR15vahMbzRw8exgMbg1HrMw=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=nlOY/JsheCvtGZwtmVG+2Spd0wDLrcSsOE6pwjFauyAfFPgKUsROJ+iwZvYHHGXuYNwGbkljlV3/OfdnxhwlRQ0C7QUhccZyibE0SRY6OgXx1Fg7vbLf/evkXzunA2xELjF/Kv9pLsq7spHtkGWDIoYBCaD2woHnbhBGDYsDzlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W97jy4qS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE641C433C7;
	Sat,  3 Feb 2024 03:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706932516;
	bh=RgZ4aM662QhXjyVR/VedR15vahMbzRw8exgMbg1HrMw=;
	h=Subject:From:To:Cc:Date:From;
	b=W97jy4qSu+uTromZCxnqOMZApmmkGEEDUwwuPRi4gd1l+SoKkey62122TVH8Eo4O+
	 YznXfHk/Rz2rIcQH7PQnNvSYyeWg67E+ttY7GBs33Se+RK2eqeBB7ByVkoOB/5IKtX
	 7lgOv/Znqmc7GaWI99BgWEL5RBTjfOGUZklMgQ3THun0JA5A+9IBpktB3JsGpkBzME
	 6YIEs0Y9GiguxaJKwflu6YR3hmf9A8J4qPxcge3GycJ5Mu6kVV+k6qMx0WIm5wU1t/
	 7jnULLE7jBm9TCoIOVh6e+0uznWQ01Dxx6QoQ+eddNg4lYBGcEJCXRMyz/p+u2Jr6V
	 cSnQnTkOM4szQ==
Subject: [PATCH v2 0/4] RELEASE_LOCKOWNER fixes for v5.15.y
From: Chuck Lever <cel@kernel.org>
To: neilb@suse.de
Cc: linux-nfs@vger.kernel.org
Date: Fri, 02 Feb 2024 22:55:14 -0500
Message-ID: 
 <170693220850.20619.2532987152854323295.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Neil -

Series updated to include "nfsd4: add refcount for
nfsd4_blocked_lock". "nfsd: don't call locks_release_private() twice
concurrently" will be applied automatically when it is subsequently
merged in v6.9.

Test server kernel was built with KASAN enabled. The series passes
pynfs, (x)fstests on NFSv4.0, and the git regression suite on
NFSv4.0 with no crashes, KASAN splats, or memory leaks detected.

---

Chuck Lever (2):
      NFSD: Modernize nfsd4_release_lockowner()
      NFSD: Add documenting comment for nfsd4_release_lockowner()

NeilBrown (1):
      nfsd: fix RELEASE_LOCKOWNER

Vasily Averin (1):
      nfsd4: add refcount for nfsd4_blocked_lock


 fs/nfsd/nfs4state.c | 90 +++++++++++++++++++++++++++++----------------
 fs/nfsd/state.h     |  1 +
 2 files changed, 59 insertions(+), 32 deletions(-)

--
Chuck Lever


