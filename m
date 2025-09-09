Return-Path: <linux-nfs+bounces-14150-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6417B506B4
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Sep 2025 22:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90C51BC060E
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Sep 2025 20:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F88F302CAB;
	Tue,  9 Sep 2025 20:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHM+KAYA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A561D799D;
	Tue,  9 Sep 2025 20:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757448451; cv=none; b=bsrDwxBs4ewMT3CUkgkRSvBKXnkIcywSf4vMnXDa7IX2t7lrX8SESXA8cd3HbM2GhOdeHB/tKg9/dDLljI65A0rU9HLucYZ14PfOO8k9JWmbt8RQPgSAkWRyogzSLoS3dJncVgzPANG3P+D/drbGmlKbz+w+GH8yGbekXa3cs9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757448451; c=relaxed/simple;
	bh=epS5AHknA1TDQxK2ngXCDYgIz7XqOiDzYR+ix4ZK1HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/hDPTeB/Bx+gMD2JxS4qRxA1Ds9y5/Zdp5Etr+fdqLsNkbvLyI4JGASh2DWiYmq5CFuPNR3TCsDl1it+/lDGQjI9JJwb2kbBe0A+7YzCD7zLeeozJnDo3NwIl82rvajPePmoRk/SpkFjMmGd6Q/OcsT9VBzNtGr4qW42W9b8Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHM+KAYA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B73C4CEF4;
	Tue,  9 Sep 2025 20:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757448450;
	bh=epS5AHknA1TDQxK2ngXCDYgIz7XqOiDzYR+ix4ZK1HA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kHM+KAYAO09TmsAhHCYmJp+lK+ZubId09WeIucocsmdSPjUi7MQsQkj1M4bAOjVMI
	 2WEzRM/a7QC+mEkdhMdz52RjWYIlMlVV0Ku0FP7PEmeYYA7nNGfeRsxpnUyCIviCl0
	 dgk978r6/wgvW48iBWHMDhsmKx6kUduSaBG67P2OW0z0Rxi/DVFYPwU9Vx1EU3SJTB
	 mI4j8VXDzVIckCk7gpPKPXEiJcyOhcZz5FWLRQVazGpGUhjLHWBRZKrHKIVTotAA8U
	 37umkkNEMYCYwqqZoeX4rMCOCgCCJ9EHP4XrewoNREbt4dZ3NAPOtA0miiFCYG4Vau
	 MoXcTDOT4drHg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: switch the default for NFSD_LEGACY_CLIENT_TRACKING to "n"
Date: Tue,  9 Sep 2025 16:07:27 -0400
Message-ID: <175744843361.7485.6449948434763067920.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250909-nfsd-6-18-v1-1-c87fe3b85ca2@kernel.org>
References: <20250909-nfsd-6-18-v1-1-c87fe3b85ca2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 09 Sep 2025 11:48:08 -0400, Jeff Layton wrote:
> We added this Kconfig option a little over a year ago. Switch the
> default to "n" in preparation for its eventual removal.
> 
> 

Applied to nfsd-testing, thanks!

[1/1] nfsd: switch the default for NFSD_LEGACY_CLIENT_TRACKING to "n"
      commit: 43e40452968af58712e6aa5daa075ef7b3757139

--
Chuck Lever


