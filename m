Return-Path: <linux-nfs+bounces-16122-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A70C3A9DC
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 12:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F480428409
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 11:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478302F1FDF;
	Thu,  6 Nov 2025 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCb84ppd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A2E2EFD8F
	for <linux-nfs@vger.kernel.org>; Thu,  6 Nov 2025 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428635; cv=none; b=vAfGldquuxQM9N+xTr5FHojXrE7HiOojQgV0FK86mew7JlvThzuzJqRgN3CbW9sBpZRa7Ywf2RQmjLLZme4uO4uw5VikGtWp82oV1S+eieMSJ4+HOJJORXxReXU+uxkv2UpLTqyf+EAtOZNQBfwfhuufF67iRedz0XS+Eq+ARC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428635; c=relaxed/simple;
	bh=zfY0UTV58hLF/qI2sJ/3FuiK3vIruODsTsKvCxLjKXI=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=dszsNnA/68D0zEseNWOLr4YNR6a6qPpFBMQtl2BeXQFI25YIDPEVlegmVTPTu/k7gCSVsr6QyBCVkH79RwDe13jIj2vCxHvnKpNgJG8SnmM7BNiTKX442vEFWOjU2ZwJW9Ev1lri5tN99yCEIbLUhNQtt9KSg2Arf0gIZFykzOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCb84ppd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969E1C4CEF7;
	Thu,  6 Nov 2025 11:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762428634;
	bh=zfY0UTV58hLF/qI2sJ/3FuiK3vIruODsTsKvCxLjKXI=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=lCb84ppdKHsaG4wVZa4VYlJo9pr/DHm64f9J/eXP1k3WnF0sn/A9TVLxeyqlFCDbl
	 dXcPPhhnQ7TwO7WCEl7IYkHMl5ciqHs+vbBZhUr8oly4LKrUN+4kguN9F3AqtDKLzt
	 CDbP+b/SjgIrtyYi2Tcd8sdueI19NrfxZsxdMHFqgCLnvfaQz0bDQbxovzKLoaNEHj
	 cIat9r4Vdsrmotf3pEi5VQY02TF52m/Z3WYi6SKZSlHSuVntEtluPq7bcotwlVTjKn
	 mOep6sXA+rsb6POeU/VePZbE9il5huprEXrsJrU7YNJno6ySR7Fm3FOLyycsCkxEx2
	 uEQhGKKwJSsAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B229739B167B;
	Thu,  6 Nov 2025 11:30:08 +0000 (UTC)
From: Mike-SPC via Bugspray Bot <bugbot@kernel.org>
Date: Thu, 06 Nov 2025 11:30:10 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: cel@kernel.org, jlayton@kernel.org, neilb@ownmail.net, 
 trondmy@kernel.org, linux-nfs@vger.kernel.org, anna@kernel.org, 
 neilb@brown.name
Message-ID: <20251106-b220745c6-0a65ef0b5697@bugzilla.kernel.org>
In-Reply-To: <ab235dbe-7949-4208-a21a-2cdd50347152@kernel.org>
References: <ab235dbe-7949-4208-a21a-2cdd50347152@kernel.org>
Subject: Re: Compile Error fs/nfsd/nfs4state.o - clamp() low limit slotsize
 greater than high limit total_avail/scale_factor
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Mike-SPC writes via Kernel.org Bugzilla:

(In reply to Bugspray Bot from comment #5)
> Chuck Lever <cel@kernel.org> replies to comment #4:
> 
> On 11/5/25 7:25 AM, Mike-SPC via Bugspray Bot wrote:
> > Mike-SPC writes via Kernel.org Bugzilla:
> > 
> >> Have you found a 6.1.y kernel for which the build doesn't fail?
> > 
> > Yes. Compiling Version 6.1.155 works without problems.
> > Versions >= 6.1.156 aren't.
> 
> My analysis yesterday suggests that, because the nfs4state.c code hasn't
> changed, it's probably something elsewhere that introduced this problem.
> As we can't reproduce the issue, can you use "git bisect" between
> v6.1.155 and v6.1.156 to find the culprit commit?
> 
> (via https://msgid.link/ab235dbe-7949-4208-a21a-2cdd50347152@kernel.org)


Yes, your analysis is right (thanks for it).
After some investigation, the issue appears to be caused by changes introduced in
include/linux/minmax.h.

I verified this by replacing minmax.h in 6.1.156 with the version from 6.1.155,
and the kernel then compiles successfully.

The relevant section in the 6.1.156 changelog (https://cdn.kernel.org/pub/linux/kernel/v6.x/ChangeLog-6.1.156) shows several modifications to minmax.h (notably around __clamp_once() and the use of
BUILD_BUG_ON_MSG(statically_true(ulo > uhi), ...)), which seem to trigger a compile-time assertion when building NFSD.

Replacing the updated header with the previous one resolves the issue, so this appears
to be a regression introduced by the new clamp() logic.

Could you please advise who is the right person or mailing list to report this issue to
(minmax.h maintainers, kernel core, or stable tree)?

Regards,
Michael

View: https://bugzilla.kernel.org/show_bug.cgi?id=220745#c6
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


