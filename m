Return-Path: <linux-nfs+bounces-13438-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CBCB1B9FB
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 20:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FCA862787B
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 18:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E02298CA4;
	Tue,  5 Aug 2025 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpeiWJkf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7944A279351;
	Tue,  5 Aug 2025 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754418290; cv=none; b=uIynPsiTmLstWAEIJNZDMNPfv/yyg3cLbQsxyXifO1bqUQpsJRJQVHuXRLyMJHDXB4N6PYjkM4QO/SZLXqY/ObnxO+VlvVTGEdJUI2Z9TSQe+QFYArkdOAw9Lh7SXOBmgnRkW7MtkgCLbG0g9fYKfpyUMr/JYJC57z8TmczzZzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754418290; c=relaxed/simple;
	bh=wdgBQozZ60WLJYIcMgQbxIcGH6ubWs7rnf10YYOzuJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rWD5dJ2RB0oKfgU0r0TYBGe/UDzvDuef1EQUeCplJvS6mMcvJ0esZ4nWhQw8BBKe9ny0af6gYtagStMOP2ZOypz07mRyM8TOanDdaBJg+Dku570GF7iNrOkDecX+PxBtGGCKoru84Tj2PjpNwxQPuqsOqVRYPXPhRQhj2NlKpHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpeiWJkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB04C4CEF6;
	Tue,  5 Aug 2025 18:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754418290;
	bh=wdgBQozZ60WLJYIcMgQbxIcGH6ubWs7rnf10YYOzuJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BpeiWJkfSQHzmGAthohW2xwN3y7+/wQO9ufan/IUf+y+JWxEUZKdjKlgOsVHiqjJ3
	 w0l7/IAGVDA7tSNHCvKDcqNWVmxF4zteASusRrvGmUbHVy668n/sKPvtDxouJqUcev
	 qnu9Ww5XW/z4llTT1NRl7aMlyiwFuC2tOuhG2Ct0OhqyYvm7rSTSoUZwkoNJ7vZi3T
	 XhKXHVfZEBxlGnQwMalIKah+V/3WSIshJ9LGQRonue4qTu3CRPfP12LC69MXA77mTO
	 fX1Il3zf7FSo1rxXHY9A+an2eglLc5hqzd5OuuruZmFStkh+D8OzSo8yETM+xexVVT
	 xjAWbnAIgv+LA==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	stable@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NFSD: Fix destination buffer size in nfsd4_ssc_setup_dul()
Date: Tue,  5 Aug 2025 14:24:45 -0400
Message-ID: <175441827954.101751.4073328601137228327.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250805175302.29386-2-thorsten.blum@linux.dev>
References: <20250805175302.29386-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 05 Aug 2025 19:53:02 +0200, Thorsten Blum wrote:
> Commit 5304877936c0 ("NFSD: Fix strncpy() fortify warning") replaced
> strncpy(,, sizeof(..)) with strlcpy(,, sizeof(..) - 1), but strlcpy()
> already guaranteed NUL-termination of the destination buffer and
> subtracting one byte potentially truncated the source string.
> 
> The incorrect size was then carried over in commit 72f78ae00a8e ("NFSD:
> move from strlcpy with unused retval to strscpy") when switching from
> strlcpy() to strscpy().
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] NFSD: Fix destination buffer size in nfsd4_ssc_setup_dul()
      commit: 5486ae619bff16a8c885afab7f40b10c69030344

--
Chuck Lever


