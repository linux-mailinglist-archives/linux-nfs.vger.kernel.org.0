Return-Path: <linux-nfs+bounces-14075-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41811B45AA4
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 16:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5BB77BFB46
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 14:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E53E36CE05;
	Fri,  5 Sep 2025 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kY0qq4BC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8F536CDED
	for <linux-nfs@vger.kernel.org>; Fri,  5 Sep 2025 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082487; cv=none; b=uJBA5r5r9y99pk01fwap6R6jdRrl6Ci0SN/CN0BZITtcIPi5GbwzjEpU5p4wsYt0382ZLdiycip3Ra6CMEfw+yQ0SLtN5LPaCQiFRozhnoFgzUceR9N2nmLVeOhZiNa36fqmuysAENKOGFgGokD8HOwYwa1Pr0uJB9qwi+EjX8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082487; c=relaxed/simple;
	bh=KznMTsQM9VT+8q70Fib3kgIlq5eYrpRP/svdSnKMeFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCe0df7V78McDZneCtGAN/EtD5SLMAif4EEWCNuz7htvDjUpMKIGzYgkHQiulImN3czoZk5n90cgAxdVfWXlNzgbupHmQdvjtD4AuHHZsBhTbY+Bz53VV7uQ/0VK0ngBQfHSESJ4gJjsgyo903HnMt8EtxTLpoEf6dlDuqJrddo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kY0qq4BC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09369C4CEF1;
	Fri,  5 Sep 2025 14:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757082486;
	bh=KznMTsQM9VT+8q70Fib3kgIlq5eYrpRP/svdSnKMeFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kY0qq4BCfWh52GKes9PXKxwNLkPOe1qjYcM9VNQ4Om3cwr7x561n8dwqNj4/0GFSa
	 xU7jfrhX979YbZh7hR60tP5zKcgOb8jMKZuzO0/n0m4xg00YYSpZqSuEe1mnNn3pSw
	 gIIIFvsu/QN9HeuJ1PEUKebcUjYfUf6STy9XCsQegkQXMB/95OlHNH8nN2+03p6JiA
	 o6TVr7RWGQ5+Rgg2HAeLTb3OovnJqh/Q+HkT0N5jktY95HCX8rasxrqUxKOzMERKYj
	 +KmUwhA5SRXU30xSDcAQe7JAN6JFAXQKXRjkZ6GgxUB4Fp6E6JD0bE/zmIP1v1Mtcb
	 YLvXvHGmZRw7A==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH] nfsd: Don't force CRYPTO_LIB_SHA256 to be built-in
Date: Fri,  5 Sep 2025 10:28:03 -0400
Message-ID: <175708247756.6326.2057464886507286853.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250803212130.105700-1-ebiggers@kernel.org>
References: <20250803212130.105700-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Sun, 03 Aug 2025 14:21:30 -0700, Eric Biggers wrote:
> Now that nfsd is accessing SHA-256 via the library API instead of via
> crypto_shash, there is a direct symbol dependency on the SHA-256 code
> and there is no benefit to be gained from forcing it to be built-in.
> Therefore, select CRYPTO_LIB_SHA256 from NFSD (conditional on NFSD_V4)
> instead of from NFSD_V4, so that it can be 'm' if NFSD is 'm'.
> 
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: Don't force CRYPTO_LIB_SHA256 to be built-in
      commit: 9c0d70a41f389ff1f15fd38fa47be5c3dd13c915

--
Chuck Lever


