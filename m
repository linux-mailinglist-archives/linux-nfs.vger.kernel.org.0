Return-Path: <linux-nfs+bounces-14789-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDC9BAA486
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 20:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C16E3C81A1
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 18:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A8C238D3A;
	Mon, 29 Sep 2025 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iP5bMPyN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D2122FDE8;
	Mon, 29 Sep 2025 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759170269; cv=none; b=QElby705sulKYNsQIgEjcl6pk2uc+qq4EEAVN8xih21649z2SqM2ZEcOgAoj0ReMM9ZJuNMgihuqrcPMDqKHjriqIuoeiM/IpUu0uqyIs+KI3WdwEnhHgFdt6po0nMptlKjO5OAyezQjb+opfOZ0/q9TwLmtJp9FY+vGJNoZsoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759170269; c=relaxed/simple;
	bh=XaGxOq5j8ZKSYlQEZ2I2M1BuULdSDA+cGNvkojl5y6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U5ziCKne+mz/COSCww7tC9DkQn2IJ0+qb0rm3IpTANnDczd4zzc1mJNDzKGxKUtin0+hIgxImKmUApJCIq6m6Crl0GkQucXNE+mbXiPlj9k9wf+GWXWonwGqewJKBAMycowLQzsvsGHw4BxmSR691I7hde37hG2csnQMf/3F1Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iP5bMPyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A730C4CEF4;
	Mon, 29 Sep 2025 18:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759170269;
	bh=XaGxOq5j8ZKSYlQEZ2I2M1BuULdSDA+cGNvkojl5y6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iP5bMPyNb2hT6OrqdTjU+ST0mdEBmLouopjOrzw4tXCAInWip+yWRzrCpGs39WH1q
	 gbWvY0KqUMpH9TcJE/U4GlB5kzT18wgtN4L1ootKhX2CS+Kd/ngKgz3A8FyfRsxDka
	 gpJ8BhUnXbPS5z4IbQiaZH5YH6G0+XDJOdii5JGqS59yBeW6AKnZcS7D5mdc6wP/O3
	 BavvI/4zQSUDcgOGH4vBRmMD6IqQ/sqIw/cAW/4UKcOT4in6OaRwUbNowN1lzCM/C8
	 Gk+d7STiIb91XfptZq9HPqAAg280FprZ2XKfU5aV3nTVgZLKNj7rQ3lF8y2VXWvKq7
	 hJ1eC8F2g52aQ==
From: Chuck Lever <cel@kernel.org>
To: Matvey Kovalev <matvey.kovalev@ispras.ru>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] nfsd: delete unreachable confusing code in nfs4_open_delegation()
Date: Mon, 29 Sep 2025 14:24:25 -0400
Message-ID: <175917024706.10236.7663377717231174356.b4-ty@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929173522.935-1-matvey.kovalev@ispras.ru>
References: <20250929173522.935-1-matvey.kovalev@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 29 Sep 2025 20:35:20 +0300, Matvey Kovalev wrote:
> op_delegate_type is assigned OPEN_DELEGATE_NONE just before the if-block
> where condition specifies it not be equal to OPEN_DELEGATE_NONE. Compiler
> treats the block as unreachable and optimizes it out from the resulting
> executable.
> 
> In that aspect commit d08d32e6e5c0 ("nfsd4: return delegation immediately
> if lease fails") notably makes no difference.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: delete unreachable confusing code in nfs4_open_delegation()
      commit: c4a007c2d1fd7d96fbc3bd4fb45fbbc748d41789

--
Chuck Lever


