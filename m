Return-Path: <linux-nfs+bounces-9430-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75728A181F1
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2025 17:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC179167135
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2025 16:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E0A1F4724;
	Tue, 21 Jan 2025 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CD4DfXQw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB011F4715
	for <linux-nfs@vger.kernel.org>; Tue, 21 Jan 2025 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737476685; cv=none; b=eyW8EIFzR7uwTtP4a/dhy/UeArXJqJjBWxmWnUJLPgWnHo/MP85DYwUuF030zHxU0SxvhUqeR2VjJYc6uHzgdZ0qxKjvw+FQPyk2NXT3ENNPl2ADB6wH2vbOA7JDeSEEJvQZTDBTOBfcY0vRYTFCCi2UYcSA5n4hhhyi0uneVi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737476685; c=relaxed/simple;
	bh=Qd8iz1RcEfL28XBhemSIQAWF9rsRsYXAU2bGiFGB83I=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=bNK0Arx96DbRw2PmrSb4p8YM5p1AXmRxIEyumHGHamOBWa5jTGYAI4VCqepephosMzxYI/1dLHTivhHwZVAW1Y4giAhfXY7dCHMAHS+2DcGh5Nmv5C8y3O9abLQ9mKYJgiWCWKIoLNJWuotStmksAZ5hYh5F8Y1+kzBNy93dabk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CD4DfXQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC7FC4CEDF;
	Tue, 21 Jan 2025 16:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737476684;
	bh=Qd8iz1RcEfL28XBhemSIQAWF9rsRsYXAU2bGiFGB83I=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=CD4DfXQwB+wI9M43Pufldi/z5EpLySHdrHMtMaaL55MkRzRPZpbgJWvVOzwZysgOD
	 qQvB85zFnUbhrKGaqte3LkPUADlND21hO0jfIC1sRZsIvORQjQ7kX0Q0Z4UtHVGjQ9
	 lXqncaRQ8lFUF3KCbRHMGTySubGr94SLsLbrCt/VykABbYOITv9NgqhYW36LC2Mamz
	 9zhuucYb/d6wvWidae38WBn/5rB+TPYQIQbcnvsLIi7JNpj3MH+4mmBfHmASR6c9EP
	 IUAVzi+63u1Xbmr3knYKzeVzzoQMh6eqbqHevTjgsVNnvoX73NLCKhsCKhqFVXvcl9
	 UFRLqVA0rtyDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A0E3380AA75;
	Tue, 21 Jan 2025 16:25:08 +0000 (UTC)
From: Baptiste PELLEGRIN via Bugspray Bot <bugbot@kernel.org>
Date: Tue, 21 Jan 2025 16:25:12 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: anna@kernel.org, chuck.lever@oracle.com, carnil@debian.org, 
 linux-nfs@vger.kernel.org, cel@kernel.org, herzog@phys.ethz.ch, 
 trondmy@kernel.org, harald.dunkel@aixigo.com, jlayton@kernel.org, 
 benoit.gschwind@minesparis.psl.eu, baptiste.pellegrin@ac-grenoble.fr
Message-ID: <20250121-b219710c8-a588c580949d@bugzilla.kernel.org>
In-Reply-To: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
References: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
Subject: Re: NFSD threads hang when destroying a session or client ID
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Baptiste PELLEGRIN writes via Kernel.org Bugzilla:

Hello.

My clients are all v4.2 using Debian stable kernel 6.1.0-29-amd64 (= 6.1.123-1).

If you suspect one of my client doing "wrong things" checking my server trace. Give me the IP and I can give you back the client syslog.

In my case, one point seems important. The hang occur almost exactly one time per week. But not always the same day in the week (depending on when I reboot the server). The greater is the server uptime, the greater is the probability to see some "unrecognized reply" messages in syslog.

I always see one or two "unrecognized reply" message around 120 seconds before the hang message.

So it may something that happen on client or server weekly jobs ?
Or maybe some memory leak or cache corruption ?
Or something related to expired Kerberos cache file ?
Or expired NFS session ?
...

It seems also that the number of nfsd_cb_recall_any callback message increase with the server uptime. This seems in favor of the memory leak hypothesis.

Regards,

Baptiste.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219710#c8
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


