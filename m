Return-Path: <linux-nfs+bounces-21994-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SORqOxgwFmqQiwcAu9opvQ
	(envelope-from <linux-nfs+bounces-21994-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 01:43:20 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DF45DD9AA
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 01:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A4B1306B7F5
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 23:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EAF3C98BF;
	Tue, 26 May 2026 23:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGEdP1Al"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACF63D34A5;
	Tue, 26 May 2026 23:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779838909; cv=none; b=phRhN2Bli2OhrHuG5TQ7R2b7Hj+7iWQhnM1zLchRKYL3rVuplGyiz3K5xVya3jxm5lCc8u4xfUb5xOvmRS8PDa40UgltQ8pejtAScQSjIYdX5R/lEI4qEHfy7eTRoe2bJelRFp2efGiGnzXtmAGAJEdJ8BVOHR3pXrFlZVQEfcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779838909; c=relaxed/simple;
	bh=wAVwAsNj5ehNg31RlsJxMBbkglJxKQC6kPweYJ0362A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=vCrvI49GjA3CCSLXLOlFMNpWLzv4cW3OZ0i+LhrAVoeN74C1i5GFF54fWixiDFij+BSVXooIJDblTIJQ7RMuTY4d31cNCPo9tmugSzK+Uev+Jh76tHlqdvsRC8G+z1HDEtM4ZZc5JnaZ2AbxJCf+jNy+CbVUUxS8a3r/HNYq0Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGEdP1Al; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D409A1F000E9;
	Tue, 26 May 2026 23:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779838907;
	bh=XD3AJFIuXudh50oRh+KKEDtp5Bb3FLj3WnzxbuPqaI4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=kGEdP1AlP040WkzVh5bV26ZjKZFSWSKF7/UkCGj2GIZ9a4+zlChM/7LEYYNsMuCKO
	 hJ9kGKFjDrjydWPj/UwPovgy+QdLGbqXgXYTW7Us0JpDPZAPVV3u8RRt1IaaCbnfxD
	 Hh8WiVk9Usa0PWCKqTUYPiO2evv/6BtwS+CemB9VE7gSeOyeHdEzxoskmn2+qfNP8/
	 QrGaTO/XIOsivQmFsgcVtVH6BeeiQsaGmd/nd3SGRnSBiOiWqkgysuKAnz7zzINGSJ
	 mZnbgPlxF3BuHt6z1ts5ljo2IQ3CdrLEwpNA48wlus9I9LYGODMjJF+h/DBcvdWDva
	 qOZMlAg1YO4Aw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A2E380CEEC;
	Tue, 26 May 2026 23:41:54 +0000 (UTC)
Subject: Re: [GIT PULL] More NFSD fixes for 7.1-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260526194642.108872-1-cel@kernel.org>
References: <20260526194642.108872-1-cel@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260526194642.108872-1-cel@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-7.1-2
X-PR-Tracked-Commit-Id: 0b474240327cebeff08ad429e8ed3cfc6c8ee816
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb3f4b7426cfd2b79d65b7d37155480b32259a11
Message-Id: <177983891342.4014102.6693190537712993076.pr-tracker-bot@kernel.org>
Date: Tue, 26 May 2026 23:41:53 +0000
To: Chuck Lever <cel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21994-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 72DF45DD9AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pull request you sent on Tue, 26 May 2026 15:46:42 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-7.1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb3f4b7426cfd2b79d65b7d37155480b32259a11

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

