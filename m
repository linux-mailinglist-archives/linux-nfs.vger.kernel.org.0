Return-Path: <linux-nfs+bounces-6419-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351299773B5
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 23:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67DCC1C23D49
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 21:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7E018BB80;
	Thu, 12 Sep 2024 21:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGLV3+Kn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159832C80
	for <linux-nfs@vger.kernel.org>; Thu, 12 Sep 2024 21:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726177305; cv=none; b=njoP+czo6OCkl6XwJrHMvy37xlw2VMJaEK1PMw0dDJOxp4KPk8nf9lqaMVYHQO+28I0UEijYdQsDjvtWcNocmddOow2TF0zx2z+Jw5OzaaDP2VCqjRJsDPP623yLH/PeFMImVPabyqHfIrQUhMd6ZRLeDj77tTlZKAIId2gkjxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726177305; c=relaxed/simple;
	bh=U63yejE5I0mFt6nXACDpNwkKNsi/eK3ce5zMwVEbTGQ=;
	h=Date:MIME-Version:Content-Type:From:To:Message-ID:Subject; b=rpoRpE8chrxqDm80+ede/tmoasc3vKQ9ekhsT2pmF0cHmSnyLQlZUgegVgfwX3OTC21iV5b0oGxg+20lIzK7KNXcwL1TvQ8NmkIQc+q4NVCuJDdr+YsBGIwEvN1JTFDMDB0bISJVzMe6Xc5TJQn4brC8qxaM5ZuMWSozq9Io6Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGLV3+Kn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DFDC4CEC3;
	Thu, 12 Sep 2024 21:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726177304;
	bh=U63yejE5I0mFt6nXACDpNwkKNsi/eK3ce5zMwVEbTGQ=;
	h=Date:From:To:Subject:From;
	b=TGLV3+KnQ8sIG+bs9oEBkvvFdOc6OvbrxpA5dyChtxmjtUysSbqED0jlhJNhcF+er
	 qzmRMfvHRN/UzxKElhHzNFy1vtQDVewyKEfZytkjpFaIJyQJ5Wa8yRbKKi9X4wAQ82
	 aEiJP7yper6JFxk2iJCzrGR2I3TZjl56N4F+g1Mj/+0Hd6l18OOu2zq6pWxtzBqHuP
	 2ftiwDEXfOATetimcBcYdatx8PtgjzWBuPpkcpgAMBzsiLUp4ZYqHPSws1xnm/fR82
	 UE+ZiXlO6n4n61YHROarkbTLVoFZvR47fq28qkIA4ey1Fjq+5acQgbSJ4qMw7Q3RzN
	 MkB9k4BrPzL0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBB7C3806654;
	Thu, 12 Sep 2024 21:41:46 +0000 (UTC)
Date: Thu, 12 Sep 2024 21:41:44 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From: Bugspray Bot <bugbot@kernel.org>
To: anna@kernel.org, linux-nfs@vger.kernel.org, jlayton@kernel.org, 
 trondmy@kernel.org, cel@kernel.org
Message-ID: <20240912-b219268c0-341707066a14@bugzilla.kernel.org>
Subject: New bug in the File System/NFSD component
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

mricon writes via Kernel.org Bugzilla:

Hello:

Please ignore, testing mailing list integration with the new "File System/NFSD" bugzilla component.

-K

View: https://bugzilla.kernel.org/show_bug.cgi?id=219268#c0
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


