Return-Path: <linux-nfs+bounces-12085-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23862ACD030
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 01:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31300176EB4
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jun 2025 23:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F43024DD08;
	Tue,  3 Jun 2025 23:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EifKa0x3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7CE227E95
	for <linux-nfs@vger.kernel.org>; Tue,  3 Jun 2025 23:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748992800; cv=none; b=NzeYb6RLb6KBbqR5dp6ge/TM7murcmQXGh9zL/7tS7bJl+g8vA49IgRpQW/QzdYW8UdT0LHgyo3tWF7a/oPTUwX7LyC3HFTcHBEG2+oe9EkU+LSSYgzoEcimlEDpGY4ShuDr1czOh97MI7noR0TKfORQ+RZAPHpqXkF25VQd0/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748992800; c=relaxed/simple;
	bh=qKmesj/BFrQT69W5F7QG1HfaGRJm4hRwH7j8e1ckVXc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=d551/L12R+3X0qHFM2P8ySfwYfm10rS18Jis+h7ZSvHMFZAATegKwTsmFtIsN+7YxWjyo4JJfdbOWhaegP/oYZUngobgOYBBrnA4tZuTsUJPQfIa3rfV8uKNoo233TfwcPnU2lY+Ehy8XZNzWVPNULAJ9BJZdf11+x25X7Ln4bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EifKa0x3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11D0C4CEF1;
	Tue,  3 Jun 2025 23:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748992800;
	bh=qKmesj/BFrQT69W5F7QG1HfaGRJm4hRwH7j8e1ckVXc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EifKa0x3FYQ4wxdOMd0nvEKqj0PscoOLl9BXThh/zVNsOxeOs5R5TIbYV1gNNEFoi
	 in+3/fX6dty+Ra9u07PbX4tYaQE1g2QGdeX4TO+hFETf0QiMMiidfNX+nCp6QEisT/
	 2y1rv9jhuVMYHig25nQ+09R2OhcDx1oOd8Qo8dSupzV5ubhZlo8Q8vobeCdeE6thO8
	 puAsRaFYPmEErVo8fnTTrFl3HhP+qo36IlovRG2veP+Y3xoLKxsOW4wbl8iLnrD9Us
	 iwUIJGqmCWdoXpaSCJnjEQCg4RsC74Um0NVCB16DBeDvO3O7ZM/ofxiqKjnhl2+hI0
	 /SIwYTFeL8Fsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C2C380DBEE;
	Tue,  3 Jun 2025 23:20:33 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS Client Updates for Linux 6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250603210337.584100-1-anna@kernel.org>
References: <20250603210337.584100-1-anna@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250603210337.584100-1-anna@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.16-1
X-PR-Tracked-Commit-Id: e3e3775392f3f0f3e3044f8c162bf47858e01759
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5abc7438f1e9d62e91ad775cc83c9594c48d2282
Message-Id: <174899283224.1701538.18147684793517797739.pr-tracker-bot@kernel.org>
Date: Tue, 03 Jun 2025 23:20:32 +0000
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, torvalds@linux-foundation.org, anna@kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Tue,  3 Jun 2025 17:03:37 -0400:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.16-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5abc7438f1e9d62e91ad775cc83c9594c48d2282

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

