Return-Path: <linux-nfs+bounces-12135-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E37ACF224
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 16:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 234953B0E6F
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 14:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D01184524;
	Thu,  5 Jun 2025 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLhkwcZ8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFE525634;
	Thu,  5 Jun 2025 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749134085; cv=none; b=rUDqDAlJJ7w0TWhztvPU1RtH8AfZESKpoIwhLWIzTXaHVqSWnrSI17B+DEGiYamX7B1Di7lWuL4yokk076W8JsUDJiH1LGoso8whd4AFPMfqmGczT4BYpfPebLrEeYXnLHpr+4/A8kPETnfQ3EGyBfoz7oV6fTKmTjY0who7cZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749134085; c=relaxed/simple;
	bh=UXmv0BtkTPnHSCYNAzTQpRvTryyou6NzEQoj+hS9hFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cWb7/8DHWVROkrE2C/jGFxHXdWBKekSiJfpCgpQfhjhcLurVCS8Yt+P2ZWei8S38BwrScxAj6/RWR3p8OE0fTgnwVsiQc51PaiR7hAXC3n2upo7yACKY+IcNnsw9RfMBfIwucLyI/eak8+0/+O/zu1YPz9FyWnqglnDD/mVwAac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLhkwcZ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9939AC4CEE7;
	Thu,  5 Jun 2025 14:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749134084;
	bh=UXmv0BtkTPnHSCYNAzTQpRvTryyou6NzEQoj+hS9hFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rLhkwcZ8ZaZlmzYeCSRoa2Tee6nqhlQT1P9iBUWglKFC1ADGyknn0NKuukf0NCaan
	 tGcpZDmw1xq8wu5z9MmRA7TP22AEWGogmPKzF8040eMCk/zJ67P2z4QssrXVBabHuS
	 yjTgXLeAZ4tGIVTmrt9gsU0yhBGkHAahfTpqNQWLJkLMtuc+/0eEhtZn5drH/uqBMK
	 olE0AFaNB+gJtNHkovOMVbLJBnLbli9K4RWnCICUTT1731oKi0++HbrAOgMHHevS7i
	 bdAhi4ad8oLFzkgTu4gFolh5PndbYZKnbREAo5H+mwSYWE/qIuzdKlglN88Pk85WEu
	 t/jy/kNwDCfdw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	lei lu <llfamsec@gmail.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: handle get_client_locked() failure in nfsd4_setclientid_confirm()
Date: Thu,  5 Jun 2025 10:34:40 -0400
Message-ID: <174913396272.1334876.9083690750451022812.b4-ty@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604-testing-v1-1-e28a8e161e4f@kernel.org>
References: <20250604-testing-v1-1-e28a8e161e4f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Wed, 04 Jun 2025 12:01:10 -0400, Jeff Layton wrote:
> Lei Lu recently reported that nfsd4_setclientid_confirm() did not check
> the return value from get_client_locked(). a SETCLIENTID_CONFIRM could
> race with a confirmed client expiring and fail to get a reference. That
> could later lead to a UAF.
> 
> Fix this by getting a reference early in the case where there is an
> extant confirmed client. If that fails then treat it as if there were no
> confirmed client found at all.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: handle get_client_locked() failure in nfsd4_setclientid_confirm()
      commit: 2de843e11f5d16b31742259f2d3929b681a2de32

--
Chuck Lever


