Return-Path: <linux-nfs+bounces-8230-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8B09DA0A4
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Nov 2024 03:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39F6EB2298E
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Nov 2024 02:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C343FB9C;
	Wed, 27 Nov 2024 02:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUZpKWwB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B0E1BC3F
	for <linux-nfs@vger.kernel.org>; Wed, 27 Nov 2024 02:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732674902; cv=none; b=mUown7K/r7B0h7TTsDfmDRfIvznsHRMW9CgC5uoWZ5n6bptWSiqKI7T7wabjR4gsdBXL1WkGqNjgeII6dDBsl06nTxTtkFZITfWGFRBfcZ3jFI+17zlT+PtpqyENo8/01yjOJAaNf4yjCjTw+MFQURQd4Ii7jX5C6RBk2m6viaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732674902; c=relaxed/simple;
	bh=2STMe3Qk8uKoheETenaLXrSwV+X+yjxCM/aLYcbQw9w=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=VbfoMzzOesvES1WVC8FXE96vLIxgw5rEqMOeLmcFtq0vmdU6+4Wrmg/Twtfxm+SnXE6o+RnRhk2HFS1iGzkeWy28hyF/QGzIH86ZcNwkSv9cp1UvtLSMlCACEbOiKSTP6fgAQVQ6B+2B6MHw9BIkLLfuR/o0TeN5k1nF5LEbnBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUZpKWwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76BBC4CECF;
	Wed, 27 Nov 2024 02:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732674901;
	bh=2STMe3Qk8uKoheETenaLXrSwV+X+yjxCM/aLYcbQw9w=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=cUZpKWwBHlka7bcmy2ODjPzoDivBJ7zeFzoE7DaRUfG8zGF4YDxHn8D6XSZvzFx9N
	 MftNfXnljIJtSZRm2GwZeaL73IYz1XvoEfhPCO/CPvIhDWUyB7kpupugjYcs+PysTE
	 G9K45HWUHgl5Nh857rqy9iM6ehTomiYlprwYq16HtOmax06CGQUReLH4e8w/WYTwl7
	 FC8/9W9nXzvsgNRTwlD0xPOLqHaJsoAdv/E+QQiKNH8Y5UUHKXURfAH/afnBHXpoW1
	 PNNLQ+iDqz3jbqNmqQyMFzueWBWdduyJ18S/7ZLho1LBWNClWCMKlwV1Xxy1h7J5pX
	 ak68078bjqjNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEFE3809A00;
	Wed, 27 Nov 2024 02:35:15 +0000 (UTC)
From: Chen Chen via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 27 Nov 2024 02:35:09 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-nfs@vger.kernel.org, trondmy@kernel.org, jlayton@kernel.org, 
 anna@kernel.org, cel@kernel.org
Message-ID: <20241127-b219535c2-0a662f9e233b@bugzilla.kernel.org>
In-Reply-To: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
References: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
Subject: Re: Possible memory leak on nfsd
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chen Chen added an attachment on Kernel.org Bugzilla:

Created attachment 307285
/proc/meminfo

File: meminfo (text/plain)
Size: 1.53 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=307285
---
/proc/meminfo

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


