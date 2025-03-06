Return-Path: <linux-nfs+bounces-10511-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D207EA54E60
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 15:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16FD0164D25
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 14:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AE31422D4;
	Thu,  6 Mar 2025 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoRPwkxg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA42188734
	for <linux-nfs@vger.kernel.org>; Thu,  6 Mar 2025 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741272945; cv=none; b=G2ck1ar8fYwdPS6sDzE8ZLpNkISHFVdU/TFMmrDKdVbRQ/Jb2GC1R3XpAf449Ep16Sh2njjI7zeSgRhym4bSIsbFDtzApuBj4Q0XJCVk4hMKW0kfCmBfTPK6upn2estGrNabjwZbQGwt1aHN+tBavJAfVvCFew7D9aGKs4VC6D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741272945; c=relaxed/simple;
	bh=gQGvafxvI8UeCYwtPFXNwIjWDuaqa7sQQJE1GZxpqlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BdLbQCMh0k1DfHYwdZwtkIGrwt1hwR4PWmG9RdFmKs6oHz57w3w89Fy1/1noVh/ORDxHG0rAvi3PuQeFjLNiR5zY+AVXd1HenJivclRRNY8twDCs0tLCFC6ThhwKi+jj2yc4QxZjT/Ygz3D4zJPwiJaWWfPeYRCFdkLl6uLADp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoRPwkxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86C7C4CEE0;
	Thu,  6 Mar 2025 14:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741272944;
	bh=gQGvafxvI8UeCYwtPFXNwIjWDuaqa7sQQJE1GZxpqlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GoRPwkxgUDIQOnULlQfgMqcf18xx8ppFGXGenpW/pR/ZEObDJZxakdO/uPjbdxGim
	 bOT+7eRcR54gqTS/0IDsgZ2TB+rw58BmGV7lc2/ufLSu4gweXW0dpODzDF1E4v/C/q
	 sT2qAXV3bF0ITsz79mqkHxhJx0uOe9k+vDPtPWnkvACKFyQV1Z7ysYpxRf6w2Q/42g
	 VTVj+0MWPTrHapvolyvfGk/aEXmRnj0dJSXQebB3qw2w91rZ+x/ffsi18SJF4iVo1a
	 zSceOO0mE8i6MgAl/A8yAOdn+NNeJRtQu4rTKQ7G0FAejoT8XCzoNzshu3yzYIZ1FY
	 XwUUFjKCwgz6g==
From: cel@kernel.org
To: jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	tom@talpey.com,
	Dai Ngo <dai.ngo@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	sagi@grimberg.me
Subject: Re: [PATCH V5 0/1] NFSD: offer write delegation for OPEN with OPEN4_SHARE_ACCESS only
Date: Thu,  6 Mar 2025 09:55:40 -0500
Message-ID: <174127290818.49075.5390176010215303643.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <1741212308-13521-1-git-send-email-dai.ngo@oracle.com>
References: <1741212308-13521-1-git-send-email-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Wed, 05 Mar 2025 14:05:07 -0800, Dai Ngo wrote:
> >From RFC8881 does not explicitly state that server must grant write
> delegation to OPEN with OPEN4_SHARE_ACCESS_WRITE only. However there
> are text in the RFC that implies it is up to the server implementation
> to offer write delegation for OPEN with OPEN4_SHARE_ACCESS_WRITE only.
> 
> Section 9.1.2:
> 
> [...]

Applied v5 to nfsd-testing, thanks!

v4 has been reverted.

[1/1] NFSD: Offer write delegation for OPEN with OPEN4_SHARE_ACCESS_WRITE
      commit: 70b39d56ded1c6ae51757b182047153cbb6522d2

--
Chuck Lever


