Return-Path: <linux-nfs+bounces-17244-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A754CCD199A
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 20:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3829830E123F
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 19:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B043D25C802;
	Fri, 19 Dec 2025 19:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIjkUMcS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7B21D5CD4
	for <linux-nfs@vger.kernel.org>; Fri, 19 Dec 2025 19:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766172121; cv=none; b=h99WJKRmCE8GbPJCKYrQJFdDk3US2MP/mo+57DUr1ZNkUtmqzaSIVyHZ62nK+A9JWC+W+HPUHU2cLcbfsNgmAHTVIZ9DohLLTQHqkNz7kbRkxGJ0i7CqI2tHdK3KFJ1T10YTBdNBXLVkVLYF9Te+FOJ8O8rE2EO7a2UfrOXZKok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766172121; c=relaxed/simple;
	bh=+VJ6lMvb69vB4SmKw6ZM10muY97IJ7jT9nTG6e4vuzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RVjJV85F5UXLZvh3obfPxzFMv0TKgrQxBJv/9KsDoEYjbJ8j/e2TjNFqaXKlaCgyKP2bDxqCSgVdkqqQd8IfQyVGx1twdQmMrAqaWCI5bBDgqnaC07EX+XYBvOus3OywQV9DuyaFOE1rap+AIJl3hA1m8ANO52IJQGer6mTIoJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIjkUMcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E453C4CEF1;
	Fri, 19 Dec 2025 19:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766172121;
	bh=+VJ6lMvb69vB4SmKw6ZM10muY97IJ7jT9nTG6e4vuzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eIjkUMcSS3zF9UXiaCuSYcAjSjgC3pSTpAjJMjRTq4NwNFBLOJ3fGqcGOovd9AJaV
	 zs8WYoKNM1lFrfzjdXnz/GOkjD4IPlDfcE+145ZuwUx7HO45yNyHnu2Pt+h77TR7Pq
	 Iuv0p2TPtJECIFBLj4wR+B2kj7TiALHr2OaYKiwSY/KQWhKwkVrmEnhPs2Ilp8qLWa
	 8HrRQkDgCyu1zHhKNCuE4NqXzC9bqZVgEmGsdn9gO6KQb9mY2RmtD7Ux7lT4RCcyKc
	 6hPJNj9myD/3Ub6c6+Vwm3mJZDK5wvO6qU0woDWy8tUvh0s6j+RmLKdkWPF2vFcJTZ
	 mwKM7QIlPhT5w==
From: Chuck Lever <cel@kernel.org>
To: jlayton@kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	neilb@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: Re: [PATCH 1/1] NFSD: fix setting FMODE_NOCMTIME in nfs4_open_delegation
Date: Fri, 19 Dec 2025 14:21:57 -0500
Message-ID: <176617210778.1296905.6680010778342245745.b4-ty@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219175955.4480-1-okorniev@redhat.com>
References: <20251219175955.4480-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Fri, 19 Dec 2025 12:59:55 -0500, Olga Kornievskaia wrote:
> fstests generic/215 and generic/407 were failing because the server
> wasn't updating mtime properly. When deleg attribute support is not
> compiled in and thus no attribute delegation was given, the server
> was skipping updating mtime and ctime because FMODE_NOCMTIME was
> uncoditionally set for the write delegation.
> 
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] NFSD: fix setting FMODE_NOCMTIME in nfs4_open_delegation
      commit: ad8ac894d0d9797f557cbf51c05fd32830887d9c

--
Chuck Lever


