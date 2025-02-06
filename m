Return-Path: <linux-nfs+bounces-9910-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A73EBA2B170
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 19:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C21D1659EA
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 18:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C000197A76;
	Thu,  6 Feb 2025 18:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKCu6l9+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83A823956F;
	Thu,  6 Feb 2025 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738867264; cv=none; b=jiC2//E8cCzx5wgUfgnmx9Qpbl+hreSOwtzdHJ2qweOT3cter/wHCEMX18HkRNmE9GOx4mMVl3JvYjBYnZapQ4DOdwtfxLM+gm4Vp+Mcq1pjCc+t1Q16rQcj6spKXvUG7vMe8Au4cQ4VGxtRcT9eju16pn6gkutO8hDoaM+QsA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738867264; c=relaxed/simple;
	bh=emVKTAzwmxUz3Qb3XlAdo/xUrgGCZ7mWxQ/cr6rY+R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2tXHzba4pI/pNW0Qm/khFS1V36nmRawiCsq4mnvaLZ2vP7Akw0k2PFbRf/Ew9a0pe4RdA94NVf1eRZDmovznNOPfkGn+lABQZGksOwbzSN4JPL1j1tl75XP2FoMvg9ZdUiE8Q/9CRJUFm0SdGxnMgtgFLGhwOubHIb7s2OgCcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKCu6l9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639BFC4CEDD;
	Thu,  6 Feb 2025 18:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738867264;
	bh=emVKTAzwmxUz3Qb3XlAdo/xUrgGCZ7mWxQ/cr6rY+R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KKCu6l9+MwD68V2HrkG1XFErNdBH0A2pkUiXudj2ij+8BwkCJ8lO2KYLVZEq0+eIJ
	 1cb27sV8kr8KasLPI4CFVkJvN7Vbkya+MLIGY0mGgHPlevGPmFEHyxgcb+GjcV5YQ1
	 qpY+DoQvMbzNHKdE+2ujELprh1J4uNxE5Y1c17ZTb1T/fMhcAhtf58niH6+MgnosAC
	 BNV+B1hM/RdpRFXD55IF2T5PBqoM/KrZtmXxE2L9cuybVoXKnQHLlUSh+DNpKf6pbB
	 fJiva7CONYh1xxTLTUg74eOnyXWW4D4NgMY+VZbkLsymzuXBhv8+mz93hp67SZyMhy
	 KzXnQvTcG851w==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+e34ad04f27991521104c@syzkaller.appspotmail.com
Subject: Re: [PATCH] nfsd: don't ignore the return code of svc_proc_register()
Date: Thu,  6 Feb 2025 13:41:00 -0500
Message-ID: <173886723523.80292.10168370789662544077.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250206-nfsd-fixes-v1-1-c6647b92ca6f@kernel.org>
References: <20250206-nfsd-fixes-v1-1-c6647b92ca6f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 06 Feb 2025 13:12:13 -0500, Jeff Layton wrote:
> Currently, nfsd_proc_stat_init() ignores the return value of
> svc_proc_register(). If the procfile creation fails, then the kernel
> will WARN when it tries to remove the entry later.
> 
> Fix nfsd_proc_stat_init() to return the same type of pointer as
> svc_proc_register(), and fix up nfsd_net_init() to check that and fail
> the nfsd_net construction if it occurs.
> 
> [...]

Applied to nfsd-testing, thanks!

Added Cc: stable # v6.9

[1/1] nfsd: don't ignore the return code of svc_proc_register()
      commit: 312aef1c1520c10cf035e27c0b0229bea71f0c68

--
Chuck Lever


