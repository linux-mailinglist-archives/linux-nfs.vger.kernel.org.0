Return-Path: <linux-nfs+bounces-13582-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8497EB22EF8
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 19:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3EB3B982C
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 17:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012922FDC31;
	Tue, 12 Aug 2025 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5bu+qM/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17132E8895
	for <linux-nfs@vger.kernel.org>; Tue, 12 Aug 2025 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755019412; cv=none; b=oVsPzEA2p+zP1c0MT3qkxue42ASrbl03nEAMigk9STZihfvwe00/8FVhF4URfMfnlHVVVjCceNZmwLyVJ3303OT3/+JBCHZFXGTexaOmr1b/s6cc68mbUZ/tJ9IGxHGG9LhBltsYmd2DoovxvhDtm+YRaUwPqVrBYsOqe/V8YM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755019412; c=relaxed/simple;
	bh=f7kPaqAgVyKicqSBR3LfyJSRR+lR/XlDtMLC76JJ+ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ony4duxvMdjJI4UKS+7XMfXy7JGkW4aWTTwubsjfdVv7o8hqtTflMTgpNXT+WoNLNlwv1hCnzvhNYCXCqW/rsjsnrc8yHQoyyawXcLhK4NQHf2LAfc9spkGCptknhz7yTgMVKJCl41LO9Icm0zygJnMf6o8VoghcJMlaxcdHwao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5bu+qM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9983C4CEF0;
	Tue, 12 Aug 2025 17:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755019412;
	bh=f7kPaqAgVyKicqSBR3LfyJSRR+lR/XlDtMLC76JJ+ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e5bu+qM/eS60NgV/3K8qAA44UXuuT5Xx+vKySeIbD84naLUgzcBEo2cqDbCznnGi1
	 HLGCqG3GlC8Rfh1JI3wVkbYgF3CUR+nvppd/e0xikqCHjebQOMrvuGtzYgVqoUBxb4
	 mlMb6lk4OClpQjSOPxzdEaSpuqum/B3HYTcgzxj9OPiLF+RVwO/uhJwdRJN9Xs8xGD
	 NvHv8x1abHdVceVWp4jSfoK4tAAGDOPr6mt7ao4AzOI42WSuKe8jzCHI3FU6AKMYfA
	 GHfhZ1fXI/Vlphy6vGpu8joKmMjqwZ6C6s6IEfogFlktKMDzATCG6b7iHD2vzqjnOT
	 GpnAZsISAC1hA==
From: Chuck Lever <cel@kernel.org>
To: jlayton@kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	neil@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: Re: [PATCH v2 1/2] nfsd: nfserr_jukebox in nlm_fopen should lead to a retry
Date: Tue, 12 Aug 2025 13:23:28 -0400
Message-ID: <175501939341.6316.4166895573389973563.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250812160317.25363-1-okorniev@redhat.com>
References: <20250812160317.25363-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 12 Aug 2025 12:03:16 -0400, Olga Kornievskaia wrote:
> When v3 NLM request finds a conflicting delegation, it triggers
> a delegation recall and nfsd_open fails with EAGAIN. nfsd_open
> then translates EAGAIN into nfserr_jukebox. In nlm_fopen, instead
> of returning nlm_failed for when there is a conflicting delegation,
> drop this NLM request so that the client retries. Once delegation
> is recalled and if a local lock is claimed, a retry would lead to
> nfsd returning a nlm_lck_blocked error or a successful nlm lock.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/2] nfsd: nfserr_jukebox in nlm_fopen should lead to a retry
      commit: ee0261077b9ba643eec07a4996b291209e3c5c11
[2/2] lockd: while grace prefer to fail with nlm_lck_denied_grace_period
      commit: c351af6c2e509c9cefeabbf521c6893c1f4a9b86

--
Chuck Lever


