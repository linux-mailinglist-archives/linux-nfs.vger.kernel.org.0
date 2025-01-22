Return-Path: <linux-nfs+bounces-9490-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAF2A199F7
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 21:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF563A75A7
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 20:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664D01C1753;
	Wed, 22 Jan 2025 20:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBYuiMi8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A831AF0BB
	for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 20:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737578684; cv=none; b=qcNlvNxDKIRxd/Ft9HdYOm6NroqgL5mYvUP/KA+y3o9xXnYSxjxz9RUWLrMeIFFbGhF7v+BLMHipczOVR9pnDlipFLsQYsgig5cTBznciOLLxoXZcbCH1rUjT7lddIqEeOry9evAURlKg8l/fo7NVHB9gqq0KeGD4VOYk8ATqek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737578684; c=relaxed/simple;
	bh=lkmsDYG+WWC8uNZtWauC8pN6eJeRrhrXAbsACy86Bqw=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=qQ9SeDARnY/DWm8uVD8fAjvdapXtP7BJDC5kz5bTgUgNmU3a/w7OxT5Q9MvXgKiQis6A1DaBzgKnG1ZKxIYdMaHpxJNtcjgOzM+dybK7WVHba7iYDSSWVEpwyGqQg5hujBs5cGPGgVeMHuAYdYMzGJkuIsCIKGjNWGBxBKFnlAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBYuiMi8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A22DC4CED2;
	Wed, 22 Jan 2025 20:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737578683;
	bh=lkmsDYG+WWC8uNZtWauC8pN6eJeRrhrXAbsACy86Bqw=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=TBYuiMi8UyOpbpDIUjThplDlabcXrvIo0mJgVyjEazwaPLQ2EJnBhQGMglqGLCBn0
	 Rc4s+p4agrM++6sHGd06K1ePE3EEG1BCvs7G0xdHoQlxHPjddeZaj2TK+h3I1TPXHd
	 jAM81m4CBLw1GSQlOBgx1I6Q63m6/duf+FgS5wgXvl7f8ZLfOXhyOy+fejo7tT74oI
	 ntPiKLV1IQjH1exMvrRvrbKLuBtXl4X1Wvlo5gUPbn9dIGUpSakeVd6hMCrXK5bmvq
	 LM8hApJ1ygEi4Kx4O4RU9NECeRVNaw2E7zN0SO5Wn/NEEiJTQwFM2rhiMzXDtwxbN4
	 4RG0EleBJiHAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 37ED3380AA62;
	Wed, 22 Jan 2025 20:45:09 +0000 (UTC)
From: JJ Jordan via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 20:45:21 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: anna@kernel.org, chuck.lever@oracle.com, cel@kernel.org, 
 trondmy@kernel.org, jlayton@kernel.org, linux-nfs@vger.kernel.org, 
 linux-mm@kvack.org
Message-ID: <20250122-b219535c17-623ab187a515@bugzilla.kernel.org>
In-Reply-To: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
References: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
Subject: Re: Possible memory leak on nfsd
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

JJ Jordan added an attachment on Kernel.org Bugzilla:

Created attachment 307525
Logs and traces from Jan-18 pt1

Here are the traces from two NFS crashes that occurred this past weekend.
Both occurred in the AM (US time) on Jan 18, a few hours apart from one
another.

I followed the instructions I found on the various threads.
There was no output to `rpcdebug -m rpc -c`, not sure what I did wrong
there. The syslog ought to contain the output of sysrq-trigger, however.

The output from trace-cmd captures several days' worth of logs in either
case, but not from system boot.

The syslogs I have cut from ~one hour before the incident until it finished
shutting down prior to reboot. I have removed the output of other services.

Both are VMs on GCE running the 6.1.119 kernel from Debian bookworm (6.1.0-28)
~60Gi memory, 16 CPUs.

File: nfs-traces-250118-pt1.tar.bz2 (application/octet-stream)
Size: 4.61 MiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=307525
---
Logs and traces from Jan-18 pt1

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


