Return-Path: <linux-nfs+bounces-10524-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E46F0A56A15
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Mar 2025 15:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653FC16BF14
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Mar 2025 14:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE24719D8A8;
	Fri,  7 Mar 2025 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqBZ+s38"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB7D13A86C
	for <linux-nfs@vger.kernel.org>; Fri,  7 Mar 2025 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356812; cv=none; b=WwFcQsxGfoOE4Bv9Z4lmxiPNdeBBynPD1RDnvvG7HqLWjWs3FmV1dj4A5e4KnGeZJ4KeSyGLHYQkZsvUzQjXAlQy1znlfb+I+7XktDyTG5A5dI6z01lbblQOavsCgx2Gw6Wmm1JkydWpbvfacvcMIKXITJgIsJl+zL6O9tADWbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356812; c=relaxed/simple;
	bh=Hh98Gk/odMidP8+Iberl8pyyioYz/itN4RQGgE4ar1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X7lpgvU3zAfPVAz/Xtq6Hhcxsq3zJAXxHGeZs4D/zhMiIBZCr16yQIE2G1bdr1r0MeriW66yk8x/LjfQrJwvPALAYGIq3WfyKrcwojp3fVlu9mwxRgp4Ijcl/74myLqS2qLr70E6fjpOYDGpgGf6esZ/p6+L/u3Efkj+W0Qozi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqBZ+s38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A16AC4CEE5;
	Fri,  7 Mar 2025 14:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741356811;
	bh=Hh98Gk/odMidP8+Iberl8pyyioYz/itN4RQGgE4ar1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hqBZ+s38n1GimHulDiNRRCHqA830/S8bwtmgJGS7GTeRXIgReGwfsHy3aKDkcRwY0
	 TSQJIItQiz0BTBJBZiVPbqj8XfxcQDGCAkBAGmj3hwW4Cv+S0TdtQGG+TpOVCLdWEH
	 wBs8tAkLVH5yV7Yfc2rhgq1oDRBVWvp3Z5jKA9Y+4lxfEk3QCbSyCrAy85dXqZQS1d
	 cX0UEvWwfZweIV0UzLhZaznJghqBFlVd4xZbCk9x2jUMoxSK1SIIjYVLYDA/2a4VQE
	 bduIgGnld8XvNbO/e6fP/Bk0tMEsmuKjGNSLzylMIfCDib/oOPgB3mk5Ecdzx4UWnt
	 MvX+L9ixiUTLw==
From: cel@kernel.org
To: jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	tom@talpey.com,
	Dai Ngo <dai.ngo@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	sagi@grimberg.me
Subject: Re: [PATCH V6 0/1] NFSD: offer write delegation for OPEN with OPEN4_SHARE_ACCESS only
Date: Fri,  7 Mar 2025 09:13:27 -0500
Message-ID: <174135677618.96767.8322310281432443677.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <1741289493-15305-1-git-send-email-dai.ngo@oracle.com>
References: <1741289493-15305-1-git-send-email-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 06 Mar 2025 11:31:32 -0800, Dai Ngo wrote:
> >From RFC8881 does not explicitly state that server must grant write
> delegation to OPEN with OPEN4_SHARE_ACCESS_WRITE only. However there
> are text in the RFC that implies it is up to the server implementation
> to offer write delegation for OPEN with OPEN4_SHARE_ACCESS_WRITE only.
> 
> Section 9.1.2:
> 
> [...]

Applied to nfsd-testing, thanks!

V5 reverted, v6 applied.

[1/1] NFSD: Offer write delegation for OPEN with OPEN4_SHARE_ACCESS_WRITE
      commit: ae73ee9fefa9e1d6c0e274c74d2ccf9d5e6ed2e5

--
Chuck Lever


