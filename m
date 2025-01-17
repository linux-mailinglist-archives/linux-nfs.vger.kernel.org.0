Return-Path: <linux-nfs+bounces-9348-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F65A15607
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2025 18:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45BEA188196A
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2025 17:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C62B15748F;
	Fri, 17 Jan 2025 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLm9rr/c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4701D86324
	for <linux-nfs@vger.kernel.org>; Fri, 17 Jan 2025 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136426; cv=none; b=ixm/f0zw7oDKgBNjibPbOQPV0L9k7vSbEVEChBFIVKUg6rk89MeaCq/ionjKJfbTS4UX4X6AluDELecoMCzB0ezK6khEL4Xc4HJCZ+tk6drDFho7wHxy125byrB2q2HqduhFxFzBpuXZNzPkxyzKtROHx/4hux43SyZ8RZROHAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136426; c=relaxed/simple;
	bh=NH5brvUUlggHqQkaSsEgZYLzpoFJ+c1V5Bi5exENQvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RKaVw5rI5Q0md+adl80sUmZf244G1/c5E6s4tQCQF9uY3UxtGU70DmHE6KuExFwdzdYzwgU1vvcBbbE6Pj0D5AANpYepH4GuJc7BWx6YnZ0HH2Lq4r1VtlL4RubwmVxZwccK/JawpDYSJUnRkjZNTQgwh1NooqXYHiEofj722tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLm9rr/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1931EC4CEDD;
	Fri, 17 Jan 2025 17:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737136425;
	bh=NH5brvUUlggHqQkaSsEgZYLzpoFJ+c1V5Bi5exENQvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OLm9rr/crWFT+KZiqw6RUPXkGOVAQA3jDhcyoXN3zrdKVHyZQ5vOlXJ5youBn1su8
	 kkesgX28pGZmc6yKcFzk2IMuw0acotbSER8XTyoyWLSsITSxlXD9XJs3JF4oWZLzOX
	 rZ9bUqrGkk9Rpgy7EvAq7GBe7Ue+wEj77ALPpjfUt5My52waPW70gpAuwINtMVGqVi
	 eZMNJzI3Nl3BhG5+bgwkhvOl80Pr2pRl4lGbChLjFNMR/JVjRmO1XLZWnkJ6xhBwHx
	 n9O/NKxj39TcssQlK4U4KcCHFeCZ9w7/to4XCZgYdnAFx5PqQuQvqost8834pycPQG
	 ycN+MEyV6I/0w==
From: cel@kernel.org
To: jlayton@kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	neilb@suse.de,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: Re: [PATCH 1/1] nfsd: fix management of listener transports
Date: Fri, 17 Jan 2025 12:53:41 -0500
Message-ID: <173713633873.3184.12583625316992411660.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250117163258.52885-1-okorniev@redhat.com>
References: <20250117163258.52885-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Fri, 17 Jan 2025 11:32:58 -0500, Olga Kornievskaia wrote:
> Currently, when no active threads are running, a root user using nfsdctl
> command can try to remove a particular listener from the list of previously
> added ones, then start the server by increasing the number of threads,
> it leads to the following problem:
> 
> [...]

Applied to nfsd-testing, thanks!

This looks much better to me!

[1/1] nfsd: fix management of listener transports
      commit: ea27619ed650d8f62cb9d4a9f3c6e8132e8f24fd

--
Chuck Lever


