Return-Path: <linux-nfs+bounces-9394-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C734DA16EE5
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jan 2025 16:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E281D168358
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jan 2025 15:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D8A1E47A6;
	Mon, 20 Jan 2025 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mnzn7tBd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B392E1E47A4
	for <linux-nfs@vger.kernel.org>; Mon, 20 Jan 2025 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737385189; cv=none; b=B7PSmGFcrCw+pkMhKGDPNgEfT6VxTMuKTxML2onuttWRmxgic2nlt0HYezAN+oYO/gTSgL7WPi7vV9HlRel9nx81MsQ+4eDD00UjJRy4dZP5hW0kkBmYbhNwlDtpPUIbfmz5V8Ju9Eo8+mTL63HUTKSNmpsPFXyobkaBG2fe7wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737385189; c=relaxed/simple;
	bh=BrtkiNpcz6Ajy6fNgXhTGycB3N9hcYn9AoMXzE51big=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:Subject; b=AfhA/3aC5WV/UDf5AEWB6a3lqg/38g1CWkrXuscJyP7lHrFtqe+4bIg353/xdoJgq0T5xB3CSbWqAjMVPLLr6abVk49D9wZ6tw3fK3YM+v5909J05Ho7TwD/GaJw6rUyqAxTv1fgCfX0x3TX6t3g8azcehrjup8t6k/pbd1+eFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mnzn7tBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E39C4CEDD;
	Mon, 20 Jan 2025 14:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737385189;
	bh=BrtkiNpcz6Ajy6fNgXhTGycB3N9hcYn9AoMXzE51big=;
	h=From:Date:To:Subject:From;
	b=Mnzn7tBdlziJJKjlojhVVxhWB9Fh2jZCITGJox1LmpRUpniRhikhIcqxQ1xBOmFyq
	 uQ+s543/d4mWgqsNJXog+XReVehJAgA7AFSioxSAXCDOebIRzIeyUcKDKP1yDvi+hU
	 mQVH5D6Om3iQrxwn0/Rekd4T8gwukt3lzhUj5Ab48f2sF1k9Rsky3xdLR6iPH6F/HS
	 vfifg/1fsDt8nawdxkcWchkyjrOeFUipUbdWD7frxZ74SBflFmWnEIfcuJIIu0tC9D
	 BVCxX940qCXI8ndFTbICwbtJfSxSJReTheewFa8bN1VYWzp5BVdKlLDbey3a19vTjK
	 F5+npo9Gb3kTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 38AAA380AA62;
	Mon, 20 Jan 2025 15:00:14 +0000 (UTC)
From: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Date: Mon, 20 Jan 2025 15:00:10 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: trondmy@kernel.org, cel@kernel.org, linux-nfs@vger.kernel.org, 
 jlayton@kernel.org, anna@kernel.org
Message-ID: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
Subject: NFSD threads hang when destroying a session or client ID
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chuck Lever writes via Kernel.org Bugzilla:

On recent v6.1.y, intermittently, NFSD threads wait forever for NFSv4 callback to shutdown. The wait is in __flush_workqueue(). A server system reboot is necessary to recover.

On new kernels, similar symptoms but the indefinite wait is in the "destroy client" path, waiting for NFSv4 callback shutdown. The wait is on the wait_var_event() in nfsd41_cb_inflight_wait_complete().

In some cases, clients suspend (inactivity). The server converts them to courteous clients. The NFSv4 callback shutdown workqueue item for that client appears to be stuck waiting in rpc_shutdown_client().

Let's collect data under this bug report.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219710#c0
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


