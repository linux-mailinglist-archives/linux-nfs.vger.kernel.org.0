Return-Path: <linux-nfs+bounces-6471-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E01F978944
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 22:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCC91B2541E
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 20:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E621487C1;
	Fri, 13 Sep 2024 20:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bd88/afs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA35BA2E
	for <linux-nfs@vger.kernel.org>; Fri, 13 Sep 2024 20:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726257913; cv=none; b=gPjZ/qunBZsuP9pBE4J7wJPQW9nHmxyontCMp3n8Ld4xYFllxF88IKxBPfNJgIBRIZCdR1vtD3JUN1huUMAbdzmWd6kvHVJVrBs6ncA64Q1dVSBc5erQLocAKEDZ231YhuFT7kVSNpNqYdzqjTU9msVNfpD4o9IXvc0o5UtsvIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726257913; c=relaxed/simple;
	bh=aQMugZ45okZ9GpRErvQO7DWy84+kNT+S4i9VPZNAxdI=;
	h=Date:MIME-Version:Content-Type:From:To:Message-ID:In-Reply-To:
	 References:Subject; b=IsDwnelYmmMjFcUKkjnjsdqU40KwgCMTKMoNBoFx9mcyxE9VNaOFjlSjvi5wCvZojFCkyaYyhhl9rIyjaKf6cBKSdmbOtubk5qfPcAF7i0DrF0qzVYOUkIlfATlITCxGtFrusy5Oz4px9aNd5zJ7YQmyHusXCuZpqz5xj26Mvpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bd88/afs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFE1C4CEC0;
	Fri, 13 Sep 2024 20:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726257913;
	bh=aQMugZ45okZ9GpRErvQO7DWy84+kNT+S4i9VPZNAxdI=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=bd88/afsJvXvKr8hQVkJ0cfK07spe4UoarLi721rU7at96Q7Tl7tSfViBNINNEvZM
	 FgDJ1u/TycTep8c5aC+lEO3c33C5+FFU9arrU1/7VrxePnoaVJuLKAP4Zd3+zCSZyV
	 buacv8gtTChCzIXngtgrpHsLpXM0jg5yGRqkBQpJudJhOQ6NP+igSsZJbYlczs69yI
	 4lJ0+U+q+suKzWQ1Y6H38RkNrYPZwj560KM10jYc0wQAKXa9fywKBfGRNEYUN7YewM
	 rLsLIGaPu8zWSqdQoFDeB2e3dB22XYJ8SThHmln5temlV9MkXuSs0eV33Au7tT3AjM
	 aRfyGfTLALZ2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF463806655;
	Fri, 13 Sep 2024 20:05:15 +0000 (UTC)
Date: Fri, 13 Sep 2024 20:05:11 +0000
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
Message-ID: <20240913-b218735c4-a5b6735857f3@bugzilla.kernel.org>
In-Reply-To: <20240913-b218735c0-12465843fe68@bugzilla.kernel.org>
References: <20240913-b218735c0-12465843fe68@bugzilla.kernel.org>
Subject: Re: NFSD callback operations block everything when clients are
 unresponsive
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

cel writes via Kernel.org Bugzilla:

Commit c1ccfcf1a9bf ("NFSD: Reschedule CB operations when backchannel rpc_clnt is shut down") was reverted from v6.9-rc to prevent an unresponsive client from backing up callbacks from all clients.

In addition, I'm planning to prototype an implementation of OFFLOAD_STATUS for the Linux NFS client so the COPY operations don't hang if the CB_OFFLOAD gets lost.

View: https://bugzilla.kernel.org/show_bug.cgi?id=218735#c4
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


