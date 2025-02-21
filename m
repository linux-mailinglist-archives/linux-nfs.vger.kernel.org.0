Return-Path: <linux-nfs+bounces-10258-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A22BA3F795
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 15:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E7E86129A
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 14:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C04720FA91;
	Fri, 21 Feb 2025 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jX5XWatN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC6220FA8B
	for <linux-nfs@vger.kernel.org>; Fri, 21 Feb 2025 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149076; cv=none; b=b8PBxTos96zV6zkVVk0dHKH6dPjw6Xkq5MNs2AHI9uIctaPxDPVpmeCU25sYdRuRH+QBCBsQPyw6zMYAp5vunL3pGP5KZLAVwB/R2JjNa/NztH0kyLcOb3yy4+uZsLqw075FVSul8rVPFobRZj+CJKr13i0gvQRXOoWCgp9zIiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149076; c=relaxed/simple;
	bh=M0xuBZfWsNsCkEoTj4ufqceOkpNbJt4SDCa0W1HQ5VM=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=E4jAFE9lTF5ZAjsIUrKzyvAs0hnSTwjkY7hg9y8lATmBnYGT0NDH8QDT2E2Nh4pMAUQsLoP1O1tXqyL6H8prnF4t5jMJ02tp6Ohqrq6l66Y6KMRPQGPuYdxmrf6TQpLc1nlsj+eg2nUSy529vAySA3Z+r25ueGBzR3KwAN6i0Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jX5XWatN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1300C4CED6;
	Fri, 21 Feb 2025 14:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740149075;
	bh=M0xuBZfWsNsCkEoTj4ufqceOkpNbJt4SDCa0W1HQ5VM=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=jX5XWatNB14RoUElaj9vUJH1c5Pbs237iOnfjXxg0MvUtLZKYIzN1zMEcqRXlcEx8
	 yzZXCIiEKOUNA7E6gbPHMHDrEm+naQkAt/09Fi2k/p8/AaaTCVOw88EPXnZhd5ibPi
	 irEzG0wYRRsPMCH3GU1rovd9DVaoxGfRspVA8PBhste60mn1lBa8+Y9bg4DGehBnUY
	 SbQoVRBQokRZyfJVoZ71PMKzaMr8b/loJHo1G5Qg3zoDyg87Ikvu5nd1vPf/FpH3oc
	 NTjhEJsTpwCRbi33R9UTbBgUA0MQXOlvaxR6Mg8NR9pqnAqWKQJYmnSYqXdSW6SjYF
	 5LE1zOUXfDWJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B2D8E380CEEE;
	Fri, 21 Feb 2025 14:45:07 +0000 (UTC)
From: Jeff Layton via Bugspray Bot <bugbot@kernel.org>
Date: Fri, 21 Feb 2025 14:45:36 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: benoit.gschwind@minesparis.psl.eu, anna@kernel.org, jlayton@kernel.org, 
 baptiste.pellegrin@ac-grenoble.fr, chuck.lever@oracle.com, 
 linux-nfs@vger.kernel.org, herzog@phys.ethz.ch, cel@kernel.org, 
 tom@talpey.com, trondmy@kernel.org, carnil@debian.org, 
 harald.dunkel@aixigo.com
Message-ID: <20250221-b219710c33-2928276ceb7d@bugzilla.kernel.org>
In-Reply-To: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
References: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
Subject: Re: NFSD threads hang when destroying a session or client ID
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Jeff Layton writes via Kernel.org Bugzilla:

(In reply to Bugspray Bot from comment #31)
> Created attachment 307692 [details]
> x2

That warning is probably the bug that 4990d098433d fixes. That patch just went into -rc3 and hasn't trickled out to stable kernels yet. It is related to callbacks, but is unrelated to this BZ.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219710#c33
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


