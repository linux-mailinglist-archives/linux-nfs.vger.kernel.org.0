Return-Path: <linux-nfs+bounces-9577-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EC5A1B7A7
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 15:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042C516B818
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 14:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F2D11CBA;
	Fri, 24 Jan 2025 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVJdtiv6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BDB101C8
	for <linux-nfs@vger.kernel.org>; Fri, 24 Jan 2025 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737728128; cv=none; b=Z+lgevxLlaYJfdKdF/2C2PjbAiErwakcO+51SFCX3VBcyGDjOjkm+3qA6Hk/Voc1zZE61xBHzU29bwmblb24tBd+A7vcbXPaJRvuuSYY3X5c5EKrdZWJGTPwJ701Lc8VKDQVaLRS7d8H33hb0Os0/3mvuPoEyvSmKQ9n1wPZQJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737728128; c=relaxed/simple;
	bh=sx+sSkN3GNdxxxuQIKHrc1Qx8zmeYDcXH3ZOn+B3HlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SAxykgjTfBLNV0kCnl+jPg9E9PTo4bUDlwdnDXbATtC7P5rAUgmmnUHENe+osLooTJQWSwrjtnZ3c+AliGC+gE82u/g5c3MmIzybhW9eEieAEvbecxWF/izy4f0ISdDlC3vGKnCJ8ytDGkxc7nsLc4N+Ip+KKaENim9+LH/4cM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVJdtiv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F19C4CEE5;
	Fri, 24 Jan 2025 14:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737728127;
	bh=sx+sSkN3GNdxxxuQIKHrc1Qx8zmeYDcXH3ZOn+B3HlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aVJdtiv67To+QR3P5wZKC9SEYIlFaPxC2uCqsV6DgouV2a+FFcjwl5Cqct6s5+lYv
	 yXrmMg4Gw0+JZk+uSaIYXHeqNwu73IT/78MkBJknSpFrYitvSlbt8AqPQAxVng0Bk3
	 ZxPZgS5+Fkpj9rDYbNNHtgWs540qK6EjGDhp+j2YjCYaXvb3SMsV6j6McDIvxgLF4R
	 rz3auOI03lEDmshKKIkNfOSeASoTry0shJDZkF5rSsuKRVLCFph+UOz1RJRFCpKJ/Z
	 INS6/Qiknk1n+Q/fhFjtUFr3MDKsEXi7wj5p2iwoWRadBK6uNHa2SHedmT72BVnjvR
	 tKYWeiHmFMkuQ==
From: cel@kernel.org
To: jlayton@kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	neilb@suse.de,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: Re: [PATCH 1/1] nfsd: adjust WARN_ON_ONCE in revoke_delegation
Date: Fri, 24 Jan 2025 09:15:23 -0500
Message-ID: <173772809785.17077.10419496420093915725.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250123193831.87330-1-okorniev@redhat.com>
References: <20250123193831.87330-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 23 Jan 2025 14:38:31 -0500, Olga Kornievskaia wrote:
> A WARN_ON_ONCE() is added to revoke delegations to make sure that the
> state has been marked for revocation. However, that's only true for 4.1+
> stateids. For 4.0 stateids, in unhash_delegation_locked() the sc_status
> is set to SC_STATUS_CLOSED. Modify the check to reflect it, otherwise
> a WARN_ON_ONCE is erronously triggered.
> 
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: adjust WARN_ON_ONCE in revoke_delegation
      commit: 82956213af9f2e299bf5842d80c9640c55b42c98

--
Chuck Lever


