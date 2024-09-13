Return-Path: <linux-nfs+bounces-6467-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CF5978940
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 22:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF571F241FB
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 20:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D052BA2E;
	Fri, 13 Sep 2024 20:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hv0vaUjh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE094126F2A
	for <linux-nfs@vger.kernel.org>; Fri, 13 Sep 2024 20:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726257908; cv=none; b=Nr7hYQ0gk5+S/eFSW3ciKVuYeLQsxolfrv/Pmr6HI7p8DeYZHME8VVhrs/IYgxiALAcTMRU1jYLie8cZZd5FBTg6MTwjQU9Qq+/fEajdo6dAU5+JwaMgg2lGt51XuLlQUYpQ8qUZXlnrUozk1kJYiSbBuLDeH3iwZUjei2Bjpfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726257908; c=relaxed/simple;
	bh=UoMDALmY6sfH81d7EA4zvzdFQrMJbrrbxPnSG9D1oAI=;
	h=Date:MIME-Version:Content-Type:From:To:Message-ID:Subject; b=Sl6NOhC9PY6uC3pdqnbfxPjPkvJQ/GuPmOg/H2fO5CVi9z4su1ugtFC++rTiH1ldXdQlsQ+9/iKw2mkAeG1oKf1d1ghY2TRS5biHIEYxgA6/OHMA9HpUw9FNZJEhDiF0DDodB1gEZEJ6qjF8QXqcAzwtBPbtL/VSSFdwxbeHT+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hv0vaUjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EB4C4CEC0;
	Fri, 13 Sep 2024 20:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726257907;
	bh=UoMDALmY6sfH81d7EA4zvzdFQrMJbrrbxPnSG9D1oAI=;
	h=Date:From:To:Subject:From;
	b=hv0vaUjhcZcKu0hxdONibxx2LBoa1UhVBu18ZbRJoa6f6V/PePWnHI0Y+2IHcO1hG
	 yGEX1axfbC6g3gNIViCw4JTr1dAxT/a2UVqaHuFh/pImPz+l6Rml3ePb/k9eAsG3Fb
	 I2MKPsqGqwBSl/Nk6YXi5hLTmf0KXJvW/bA2GXtm7401wN1Ls0ukS9xqqN1bxbuXz2
	 0bxYlNb8ZNraSQ2HkoU5G68qZVmmlODH/AcMvljwcCCTpPXG/3NvoS8zX5H2HJLqB/
	 xWvU3KGjnyiZGlpFG/R8AdB7HuIj3X95esy/1gO0ihGIDk9vvtnwd6tBzVRKoLWAyd
	 Bs5mr5qR9+xZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F3D633806655;
	Fri, 13 Sep 2024 20:05:09 +0000 (UTC)
Date: Fri, 13 Sep 2024 20:05:07 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From: Bugspray Bot <bugbot@kernel.org>
To: trondmy@kernel.org, cel@kernel.org, jlayton@kernel.org, 
 linux-nfs@vger.kernel.org, anna@kernel.org
Message-ID: <20240913-b218735c0-12465843fe68@bugzilla.kernel.org>
Subject: NFSD callback operations block everything when clients are
 unresponsive
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

cel writes via Kernel.org Bugzilla:

Several reporters note that after commit c1ccfcf1a9bf ("NFSD: Reschedule CB operations when backchannel rpc_clnt is shut down"), NFSD's callback work queue is blocked when one of the clients is unresponsive.

We know that NFSD's callback_wq is single-threaded (ordered), and that there is only one WQ for all of the NFS server's clients.

What blocks callback operations is the retry loop in nfsd4_run_cb_work(). It was added to ensure that CB_OFFLOAD operations are delivered reliably, but it causes head-of-queue blocking when any NFS client becomes unresponsive when a callback operation is pending.

We've partially addressed this by giving each lease its own callback_wq.

However it's clear that retrying callback operations from within the callback WQ is going to be problematic to some extent. The solution is to hoist the responsibility for retrying higher up into the individual implementations of the callback operations (CB_RECALL, CB_NOTIFY_LOCK, CB_OFFLOAD, and so on), since each of these operations has their own needs in terms of recourse when a callback operation cannot be sent.

View: https://bugzilla.kernel.org/show_bug.cgi?id=218735#c0
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


