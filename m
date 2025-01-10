Return-Path: <linux-nfs+bounces-9107-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E7BA097CD
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 17:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710991663D8
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 16:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B46212B3F;
	Fri, 10 Jan 2025 16:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lf2NJqYx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01FB210F6D
	for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2025 16:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736527785; cv=none; b=K01MBMm2v49GzmU+mRTaCr+pdmdLBAoX0jYpacCf6yquZ9/jKxemWD41qniV3d7rGSIALAVHFKeJsbrq1H0s0C3y1EFnM3hZLsS8X68+aZl1KSM4RYMXm0TcgXdc/rwGERXXsXyYDdaSY8bOcVhKaNbo+FQxuz5SApBL5JxE6jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736527785; c=relaxed/simple;
	bh=aGHTA4XuS3ZwP3k2RJVthAWPozrMWdWjm/9oYySGJR4=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=NllbbiJ2mlQDpang9f5eRepByrZxL8tzyg40bZp/9pAqtIqw6sqz/EfCILj0qxTjXivmaESHhN+cSvt3ATtX/lqieUQFaQO1NnHYvDs7wjBtLjhasC0tGta3FUBOGm6eVKa1Ode7tei/LQurSnQyga8RusWwP5Fj1ijlHogOS3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lf2NJqYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCC6C4CED6;
	Fri, 10 Jan 2025 16:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736527785;
	bh=aGHTA4XuS3ZwP3k2RJVthAWPozrMWdWjm/9oYySGJR4=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=lf2NJqYxbzPS32/me+bZYH7JFQtgnry6cVGOAqNRxxtF6chg0c9byJONhwx2n7bol
	 mYr/J31gKLfK9Wr9r2kCdKQfYAJVg1AnPA06IrdECI3U3y1yyYyaIfxcWV9ZYkoLrq
	 uCVQKQC9HZwJValQED25ePZ+DI1G/5fSUYMqxeCWfmk4tCO56tTrsZ/VaJrq5KluOH
	 xfYE7Zl5t3DZLU81VA/Hu56U8d94Qj0zjkn0LJZasmxLY8P18s9Ex4+xptxs2kn3Bu
	 JQHnslWmz9fWuO5AP0GX+ot9Lm+f2SAA3oENqUawzAh7CTjGlChXtXUib2r0lHsY09
	 4Z6PVsqdSN2SQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3C61D380AA55;
	Fri, 10 Jan 2025 16:50:08 +0000 (UTC)
From: Chen Chen via Bugspray Bot <bugbot@kernel.org>
Date: Fri, 10 Jan 2025 16:50:19 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: anna@kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 chuck.lever@oracle.com, jlayton@kernel.org, cel@kernel.org, 
 trondmy@kernel.org
Message-ID: <20250110-b219535c15-7cebc629b312@bugzilla.kernel.org>
In-Reply-To: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
References: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
Subject: Re: Possible memory leak on nfsd
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chen Chen writes via Kernel.org Bugzilla:

Sorry for my rudeness in my previous discussion.

After switching to 6.12.4, the server stayed stable for 30 days. So whatever caused the memleak should have been resolved between 6.1.119 to 6.12.

You might want to close this bug if backport is not worthwhile.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219535#c15
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


