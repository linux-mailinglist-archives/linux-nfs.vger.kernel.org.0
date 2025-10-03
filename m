Return-Path: <linux-nfs+bounces-14975-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A43BB8305
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 23:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FAD44EDE42
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 21:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44E32472AA;
	Fri,  3 Oct 2025 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLxILo6C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF4C264A86
	for <linux-nfs@vger.kernel.org>; Fri,  3 Oct 2025 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759527069; cv=none; b=VxinhPHIdZ2Lcmpas1riI3bKFJ5dn1uGsxFRmw1OCke21u4GbVvIDsC1YTAfyz9EI/Tgjqd+tyuKCzOAvP8j8g8f9vY1O92NR/SWwIzNkJx3e1f4wsKFDLgqn3ba5kjVRcCeunWx2PBRZ+lZstSyH8QtWsGsp7wkIaGiR+ZoI5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759527069; c=relaxed/simple;
	bh=0PJVszA6jnzcHqKAxsh+bsmFFtyk252WJ4lQ3msC4pw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=esXkchO6Z3T0jw+ezodOX64C39ltYg7WYqGFb8P91zI9Mh1fveVzG1miYeWG7+mEPukbZrAxPnB98FnG4MU2EDVqBYehFB1yiH2JWo/mavEGqTp3F+w/mt82BdGoQyK1UhWR/50SS3LaRmns018shVlTobZ6zcK8HxSQnnJZvJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLxILo6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9D1C4CEFA;
	Fri,  3 Oct 2025 21:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759527069;
	bh=0PJVszA6jnzcHqKAxsh+bsmFFtyk252WJ4lQ3msC4pw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JLxILo6CasTEQeXDg1AY1NdR+QIwoiw+/JMnV8iLt1gskhshG2OXD9oUETDjCcU9P
	 8CVnfq7sRkTP3DSU1BFYBD+BbPl5vjMDN/syWC/R+ZLi0BGr8KcRNpo38H6BOuOpO3
	 h/G0UyZyUdS6+oE8TJyA9u+2NmqMwqyzXHvFxDtB6oOz/LZl2BgtsfF5EH/AV9JGt/
	 BAQxqdbniYQRnoGbCW68ZF/ipZ/ZoFFFXiv8lZxhceIgGoQjzfYqJaNAzOS7MA4avC
	 UA5EQFHzsonM/zS0ZEU+C3dC0HSV2creH4Jo82hfA202YkqUCFDpO1JE1h+bD+lA7T
	 G3XIbr2IklwLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB18B39D0CA0;
	Fri,  3 Oct 2025 21:31:01 +0000 (UTC)
Subject: Re: [GIT PULL] <INSERT SUBJECT HERE>
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251003210107.683479-1-anna@kernel.org>
References: <20251003210107.683479-1-anna@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251003210107.683479-1-anna@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.18-1
X-PR-Tracked-Commit-Id: 1f0d4ab0f5326ab6f940482b1941d2209d61285a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 070a542f08acb7e8cf197287f5c44658c715d2d1
Message-Id: <175952706059.82231.16303084259238920364.pr-tracker-bot@kernel.org>
Date: Fri, 03 Oct 2025 21:31:00 +0000
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, torvalds@linux-foundation.org, trond.myklebust@hammerspace.com, anna@kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  3 Oct 2025 17:01:07 -0400:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.18-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/070a542f08acb7e8cf197287f5c44658c715d2d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

