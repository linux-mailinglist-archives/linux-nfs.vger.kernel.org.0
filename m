Return-Path: <linux-nfs+bounces-16984-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E13CAB794
	for <lists+linux-nfs@lfdr.de>; Sun, 07 Dec 2025 17:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72EB23011196
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Dec 2025 16:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D999260565;
	Sun,  7 Dec 2025 16:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiYXLMR7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328062AD2B;
	Sun,  7 Dec 2025 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765124219; cv=none; b=nnpGxkMfAdFpl15E6B1j+sRdN5lgPWXtJIF/Kd9vCh7Pa/FG4ChQnkqXsJHlHAfyqdrbfaPDRNAg0PWTbPygIo/GAVjKNHAQzv+d78J4tajmhwXavr9gJ4xLXDxrhWvn3mVXDATqcHlqmrl/2o1at3lyKfpKLFcorA3W0c4Hetw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765124219; c=relaxed/simple;
	bh=PCDKyubCibYcNLq4I3Ad/kkSHviLOAiTM1PnnO+i5wA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gw0bQsYm1PX9UQBxI7zI9Ima5wlYUpk7Y2Y5GUJxeV2FY6o+0eVp3IxsvBPd4pMoJrxmqePE7i4qD+148jum0VepiU6d6D4rcV+kkNf4FO5VEiJBuuTJHOaN7exuqFv3Bn2kVvWFOifLTTJP5xDnZmbA0MTf65vC5Ij7sqnoLpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiYXLMR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F59C4CEFB;
	Sun,  7 Dec 2025 16:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765124218;
	bh=PCDKyubCibYcNLq4I3Ad/kkSHviLOAiTM1PnnO+i5wA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jiYXLMR7PKYeaolaHK6OGKgIheroEIDTiEwHBBObhN4FccjkYxq+lQRNtxufPY21r
	 dV1XyuU3YMV82twrqtSGINiG3EslhjAU5qJcH4qZbWV996Xp9Alm0jsWWBpxZ/13SN
	 ICEZWs+OH2vyCD5wf5WgzR4pmfqn99MxGDkr7DWnsJ8lgMHdu06pQpDphU+JsVw3V6
	 y+8ik4hqw4AMaLtizO/UKo53EafTrZf1l8qrlYIjX8SDEaW6UKYRpOdQ1RYvrKxFMV
	 b3UkmVsMF1nBBmbO4pjbQhze6CTBXY2tvOhLf/PAXrlj7kyuAnRFA+FLuFmfK2oSIR
	 zexbPk7+U3Qbw==
From: Chuck Lever <cel@kernel.org>
To: jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	bfields@fieldses.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nfsd: Drop the client reference in client_states_open()
Date: Sun,  7 Dec 2025 11:16:55 -0500
Message-ID: <176512420186.90938.2197009973222126597.b4-ty@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251206073842.196835-1-lihaoxiang@isrc.iscas.ac.cn>
References: <20251206073842.196835-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Sat, 06 Dec 2025 15:38:42 +0800, Haoxiang Li wrote:
> In error path, call drop_client() to drop the reference
> obtained by get_nfsdfs_clp().
> 
> 

Applied to nfsd-testing, thanks!

[1/1] nfsd: Drop the client reference in client_states_open()
      commit: 88861b1c63861c7ee590e579b0b469c413154a6f

--
Chuck Lever


