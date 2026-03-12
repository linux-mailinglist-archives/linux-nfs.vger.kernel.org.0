Return-Path: <linux-nfs+bounces-20077-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKiNAVwYs2mDSAAAu9opvQ
	(envelope-from <linux-nfs+bounces-20077-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 20:47:40 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 121AF2784CB
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 20:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 50BE63035955
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 19:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0164B3B27DB;
	Thu, 12 Mar 2026 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEJPKViT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31FD38D690
	for <linux-nfs@vger.kernel.org>; Thu, 12 Mar 2026 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773344667; cv=none; b=WZSB3jGEHoImMouJ2FR/Mz2l8DCgyI9wY/HF6YY0sVgqNYri9HXmeAhsi600LWxERkk+6+1deiOQRXFOH7z6uOG0xPX93TwW+1KlNDLSLtfie/V95WqlR6LS2/eUxFQVIv0d0DngmCNkuHs09fYguzUMSmyqHbSSy1k2fsvFSTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773344667; c=relaxed/simple;
	bh=ZiLAtNSR0g+8i/l5h1mazlKcZjK8KdzYbnaF+9/M1IQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MBSCcAPDvQOXocZeDB29psMwUZGgle6rcg5zuWk6R3rxnd5EDEmYhmXSTUQZwJPmHDks1c32aeKzAuODYX0OJQAyBKPeOFhm0uczIxQ98+oMQs9FFGhVRv7ga35q6QebSkMa0lJb80/Bmdzdna24A1sRgQLODz+guBZJLlQ1iIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEJPKViT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB50C4CEF7;
	Thu, 12 Mar 2026 19:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773344667;
	bh=ZiLAtNSR0g+8i/l5h1mazlKcZjK8KdzYbnaF+9/M1IQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uEJPKViTpF6o5R5kwKbERtpXUJJ2UBk8w7d8LX83bj9DOai/gOZPNbJW10/7956xJ
	 Q7h8FWvtcF3B1qby01EVI46tPV2s3Bz8CFoZZ5Zy9QO/pBhDCNt+4Y1liy6Q+0sWIA
	 RhvR0T4ViFid12nqykwT9Ixxp//lnetrvxeOYWFQ+LQPKrwesbJRSChDSQds00wyv0
	 hdfIt+rx42qkg80LKW07pmITFL/7V1SPUigGx2bDOpr9gcMsxOcNwrnE9xLQYIonQf
	 hQjDvBj21yVLhA3ag2MRehQ6EY31iNqSNddkpEuF4ZDfv3vIwPuZ/TmLfY8qennXQD
	 P0YgndCdBZ76w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 030133808200;
	Thu, 12 Mar 2026 19:44:24 +0000 (UTC)
Subject: Re: [GIT PULL] Please Pull NFS CLient Bugfixes for Linux 7.0-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260312174340.310766-1-anna@kernel.org>
References: <20260312174340.310766-1-anna@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260312174340.310766-1-anna@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-7.0-2
X-PR-Tracked-Commit-Id: 4529e0015432977af3ecc3b9f940fc2a1ef1b265
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8004279c41adf3238ba71931219205cd1f59343b
Message-Id: <177334466260.523191.9942352966327984529.pr-tracker-bot@kernel.org>
Date: Thu, 12 Mar 2026 19:44:22 +0000
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, torvalds@linux-foundation.org, anna@kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20077-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-nfs@vger.kernel.org]
X-Rspamd-Queue-Id: 121AF2784CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pull request you sent on Thu, 12 Mar 2026 13:43:40 -0400:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-7.0-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8004279c41adf3238ba71931219205cd1f59343b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

