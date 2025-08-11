Return-Path: <linux-nfs+bounces-13556-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD95B20D15
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 17:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297CA3BFABC
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 15:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A6D2DEA7E;
	Mon, 11 Aug 2025 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urCkDSK1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B651F3BAB;
	Mon, 11 Aug 2025 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754924768; cv=none; b=m1zSf4MfZuIRq925xFpqiLEPsfV3lSW7e1pWjF6vfBj4Z5KbXde/vQuCGhWN0qD/9TYpwNbocu7kQhmqg9MSgtqRpi7xbs1cfdrU+urviHzemx9IbK1/w0Kh1H6jFDUdtoecPIBPHSfz6RwEut2/ideZ6tGAixSsiR/JTeu1OOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754924768; c=relaxed/simple;
	bh=rVcTvSVZYWeIyPxnoWYBuGMiB5GAw4RmPAL1bWsUrIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFEBouPvs6VGhHJWWoLVuabPdt3KTcB8efwwIZMA1wmz7z9IHyUnqDbNCVrWXsHBbLLlOggj07rnwVaWBjDEGKIN3z2AYcwybkc1g/hBH+JbXekrFE9rKo2J86Mqg2Uyk80UvMJo9snpZgrofisBlKCXL79+6LXS7/IArd5/eCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urCkDSK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E54C4CEED;
	Mon, 11 Aug 2025 15:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754924768;
	bh=rVcTvSVZYWeIyPxnoWYBuGMiB5GAw4RmPAL1bWsUrIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=urCkDSK1iUlgWuKMejVKvOmQxWletqjphaYWKkwHYfZ/l4Cb3RH/yEZlQivWy7DqS
	 BKMSMLx1pMJ8Twgs/mcffTlL0WZscP/66/xmFRMLq3JxIgmL9BFH4kaouIJB7XLjTd
	 9tQ+kvutTlilVoRri8WHEdU97VPbvPSWl64go79kdzkkhSJx3Idhnu7k92QdC5IXIT
	 6BHRCsRKDMLTB8MlKJX1ZGOe1sIG+Vk5Ndsbq65JgzvYuYrajqLAIUakyDgBn2g5YN
	 6Oa9dXw51kSKDA/ZE9109i95wnPgu0KFwoLUyK69+c/rzLFYW93c066e561hG5ChT9
	 ImOKEUKw+RlWQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] sunrpc: cleanup patches for svc_tcp_sendto() and svc_tcp_sendmsg()
Date: Mon, 11 Aug 2025 11:06:04 -0400
Message-ID: <175492474969.8847.11594952782441124094.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250811-nfsd-testing-v1-0-f9a21bbf238b@kernel.org>
References: <20250811-nfsd-testing-v1-0-f9a21bbf238b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 11 Aug 2025 10:37:06 -0400, Jeff Layton wrote:
> These patches fix a minor annoyance in a pr_notice() and clean up
> svc_tcp_sendmsg() to not require a return pointer. Please consider for
> v6.18.
> 
> 

Applied to nfsd-testing, thanks!

[1/2] sunrpc: fix pr_notice in svc_tcp_sendto() to show correct length
      commit: 0ce84089fb1ab484cafb219355bee967f9d12311
[2/2] sunrpc: eliminate return pointer in svc_tcp_sendmsg()
      commit: 2a8e3cfc134a8e198c25a1680a83bbbbcdc1901d

--
Chuck Lever


