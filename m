Return-Path: <linux-nfs+bounces-10017-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE8DA2F3B0
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 17:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8793A513D
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 16:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A652580D6;
	Mon, 10 Feb 2025 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tASG/jzH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548E31CA84
	for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739205278; cv=none; b=LdpBOlmUS7K4mC7PMnr9zqZ/KTCIVmGcwfjvbCNpEcVXqFAB7tysPTi8jB5yOM0InI3XEtTWaa4kV6bi4TNnNAdS6W+PkD/exMGFAdn/qgV5BAV4WdJ2Kp9ZP0qthUVV0PxpHr6D2vVvS8ZyRiRJcl6By+eBRPo2Pu+eo6Ndfug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739205278; c=relaxed/simple;
	bh=IpQivTcAwC2XztAodGfeP+thhRpddEYZ2GJbAqXqL70=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=BE/3r4ZHgTsnk3fjYTEAC7nrE2qNlXV+heDs3OnE6zxaZxGjQxFLiMRBZwG2JrQtoERRVvbCEqWmE+48s5eiDEQK0YApqq/UuOPBhPyuYBPuMeK97ZIbZiUfjSUcsQyOGgeIAIffgmL6YPDm5mYrNF/SgwiF3pZSN/B28tdLgDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tASG/jzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B4EC4CEE6;
	Mon, 10 Feb 2025 16:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739205278;
	bh=IpQivTcAwC2XztAodGfeP+thhRpddEYZ2GJbAqXqL70=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=tASG/jzHF3VZ4S+zkq8XhvT8z3UO69wR9CtCQHBNeZE0KzBl+vAt/tfoGcE2a1oU1
	 xV1iywP/DT7KgSGXqjyEDKchrXZ7uIXR1bSMf4XF6fL8TozaQFYEoncDP55ji9u9lI
	 nRn0geG6PMQKfKdj+daJpR7ftww2sFec36ohiTYm7tFnUwCgxujw9a/Ko1dnsrMBM4
	 mXqjcOd+1o68ZI2+bMz77F4VO+zEcKWpbSduj3IEEg2htdMffqZO4fGJZLM3iroyk9
	 eLb1pfeS8qg3PB756O3EppDnxxYa4A8J/6ScPDgXga0Oe5f910vT9IeFtnZMGYMs4R
	 B2NtTQS5T/c9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B6076380AA66;
	Mon, 10 Feb 2025 16:35:07 +0000 (UTC)
From: Jeff Layton via Bugspray Bot <bugbot@kernel.org>
Date: Mon, 10 Feb 2025 16:35:13 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: anna@kernel.org, aglo@umich.edu, trondmy@kernel.org, cel@kernel.org, 
 linux-nfs@vger.kernel.org, jlayton@kernel.org
Message-ID: <20250210-b219737c10-80a0d6c000db@bugzilla.kernel.org>
In-Reply-To: <20250204-b219737c8-56e36733bccb@bugzilla.kernel.org>
References: <20250204-b219737c8-56e36733bccb@bugzilla.kernel.org>
Subject: Re: warning in nfsd4_cb_done
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Jeff Layton writes via Kernel.org Bugzilla:

(In reply to Chuck Lever from comment #8)
> (In reply to rik.theys from comment #7)
> > Is it possible this patch has not (yet) been sent to stable@vger.kernel.org
> > so it ends up in 6.12.y?
> 
> Commit 1b3e26a5ccbf has been in a publicly released kernel for exactly two
> days (as of this writing). It will take some time before it appears in any
> LTS kernel. For now, if you would like to test the commit, you need to apply
> it manually.

Now that I look, 1b3e26a5ccbf is wrong. The patch on the ml was correct, but the one that got committed is different. It should be:

    status = decode_cb_op_status(xdr, OP_CB_GETATTR, &cb->cb_status);
    if (unlikely(status || cb->cb_status))

If "status" is non-zero, decoding failed (usu. BADXDR), but we also want to bail out and not decode the rest of the call if the decoded cb_status is non-zero. That's not happening here, cb_seq_status has already been checked and is non-zero, so this ends up trying to decode the rest of the CB_GETATTR reply when it doesn't exist.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219737#c10
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


