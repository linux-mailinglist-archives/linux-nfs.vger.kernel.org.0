Return-Path: <linux-nfs+bounces-10310-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F7AA41EEF
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Feb 2025 13:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1FF42109B
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Feb 2025 12:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51842192E7;
	Mon, 24 Feb 2025 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEukm1XV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A4F2192F5
	for <linux-nfs@vger.kernel.org>; Mon, 24 Feb 2025 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399576; cv=none; b=HPhZreAUup3NZ/dW69xNwnBjEMA7cgLpxopEgQOjTbd/EBvKCh5lJh6njPDP/FKBcma1zGFPgW7RhrLB8j+LGJ8jgwqHLUObkfeo2MQuYL7osMnAaPebj4zlkYpYCZD6x08B6uaQ2dWP//0iQiXFu2eoSwoIhAOZZzPGwgXpCn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399576; c=relaxed/simple;
	bh=RfZ/CqPcMCzEGrXz2KCZC2qNFtydHjQ+p/513vpyHUc=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=UZhWrYqH15+momoQ3/Y2kFKu/I8Zf6ujJkvbK+MQJ4SJiY7sKmd9zEqZTZT55Nr2H31k/QGVxq+PSVHtiz1UsZ1Ywyt58xL1Ed8Mde/XwG+Qh42VokGNpSBgh7jzJlo2NDI09ffY9M3oNg4MaHWuuonLyVDpUv8fYelT1K7DlG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEukm1XV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE402C4CED6;
	Mon, 24 Feb 2025 12:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740399576;
	bh=RfZ/CqPcMCzEGrXz2KCZC2qNFtydHjQ+p/513vpyHUc=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=tEukm1XVBguYXlTrEeJwc5hR8wPaqjYoxKPuVkbYibZWUwpR/wduD4eAXmYGQpyTN
	 xD2Uj3svktOtlPwAMceb5DQBaOr5oGZ+Oud46T8ELl2C9SaLsnK2CeX1a0rLLhfJGp
	 urvrK64cuLoQwQGLfOPpYs89qYPSwHuC/MJQrImJOWxXY9uKlhmJvoaucxPuZ9YyPT
	 8m9uREiVe/nQGhBfkQgtBhmW4CX4GMTbxJf9dLCD8m04XD3zJmiTUoWiAT7Dff9kXu
	 xcAn1FBarNMKdws8ZBITuYRWxnhPSg/3KNXXjnc94bOtXcvHRullYjorSWjJIOyiqA
	 P3HC/ExVnppDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 778A6380CEF3;
	Mon, 24 Feb 2025 12:20:08 +0000 (UTC)
From: Jeff Layton via Bugspray Bot <bugbot@kernel.org>
Date: Mon, 24 Feb 2025 12:20:17 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: aglo@umich.edu, anna@kernel.org, jlayton@kernel.org, cel@kernel.org, 
 linux-nfs@vger.kernel.org, trondmy@kernel.org
Message-ID: <20250224-b219737c13-5d66fd356a8d@bugzilla.kernel.org>
In-Reply-To: <20250130-b219737c0-091f27de8b7a@bugzilla.kernel.org>
References: <20250130-b219737c0-091f27de8b7a@bugzilla.kernel.org>
Subject: Re: warning in nfsd4_cb_done
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Jeff Layton writes via Kernel.org Bugzilla:

> rpc-srv/tcp: nfsd: sent 106256 when sending 131204 bytes - shutting down
> socket

This is unrelated to the original bug report.

It means that the kernel tried to send 131204 bytes on the socket, but only 106256  was sent. It was a short send, IOW. Usually that means the TCP buffers are full and couldn't hold the whole message, possibly because the receiver isn't ACKing things quickly enough.

To try and remedy this, the server shuts down the socket. That should be harmless though -- the client should just reestablish it once it notices the socket is down. I wonder if we really even need that printk at all. It doesn't tell the admin anything actionable, especially since it doesn't tell you anything about the peer.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219737#c13
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


