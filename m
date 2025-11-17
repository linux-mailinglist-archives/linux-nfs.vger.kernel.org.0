Return-Path: <linux-nfs+bounces-16447-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DBFC647FC
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 14:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 065E64EFB0F
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 13:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3145F336ED6;
	Mon, 17 Nov 2025 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAmzihsp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A99336ECB;
	Mon, 17 Nov 2025 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763387374; cv=none; b=F0zO4mRw7WNmYad4RNQp1YNwhf0qXfYhck6bIcxx2+fScVTaxWlH8bB0yR5QGgSWSqG6JqRvgemJiRnxPv40aWpjK3MBAhcWrgWzX7JAMp19KNnqJkj2RFl9aoYIH3676H2YLlk4DD8IIdD5vVDH5VeMlb3fpFp7ECYXKfjC9E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763387374; c=relaxed/simple;
	bh=bfn9Sd+jXceYJB8fpwsyLT5HEI1erXmgZqmQuFDjS24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MLKHadRQLTM4xk507JHEgfB/Rpjqp5X4scEn5lEea/FPi5+UCJDYH94waq6+Z/U6OlWIG8RhXuceBI93M3RP9gzUZNZhJdMKwShGL371k4A7n3F+Ed17mrm0uNYNNzPcAeA1hBsyaigdbcHgIqg37x14ZsBGUm07QcTbvEraosA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAmzihsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF20C4AF0C;
	Mon, 17 Nov 2025 13:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763387373;
	bh=bfn9Sd+jXceYJB8fpwsyLT5HEI1erXmgZqmQuFDjS24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nAmzihsp5OmtW82ED85KlE+nM9z5CsynSlC1XxORmEnm20tuYXOm1xTRnCd/MgRhj
	 2JggoabVgUOzScONMDh3vjqSo0DGa1OQ3tpNpFs5KptjHMaU6k26hIXW8oNP7VkiFu
	 KpP4jQkctNbk6Iv+9JK8lh/PUdrk9RGoKfp6Nkob9A+FfPt20wgCmTXLaw7naHfPWP
	 68qz9QzbWH8N1YxTsaaQKpwJfk+85UnrVZhJ5c/wpea1V9KpMBrjAtmon0FaDQ1Ary
	 3CZnzGotgoYsfbkjMee473el3MAeXqSSLkY0rWeZxAzVW7ZPoXK1wNtympz4iO31/T
	 KvFZZPL8A+VMQ==
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] nfsd: Mark variable __maybe_unused to avoid W=1 build break
Date: Mon, 17 Nov 2025 08:49:29 -0500
Message-ID: <176338731878.4204.10224670039692915729.b4-ty@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251113083131.2239677-1-andriy.shevchenko@linux.intel.com>
References: <20251113083131.2239677-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 13 Nov 2025 09:31:31 +0100, Andy Shevchenko wrote:
> Clang is not happy about set but (in some cases) unused variable:
> 
> fs/nfsd/export.c:1027:17: error: variable 'inode' set but not used [-Werror,-Wunused-but-set-variable]
> 
> since it's used as a parameter to dprintk() which might be configured
> a no-op. To avoid uglifying code with the specific ifdeffery just mark
> the variable __maybe_unused.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: Mark variable __maybe_unused to avoid W=1 build break
      commit: 56e9f88b25abf08de6f2b1bfbbb2ddc4e6622d1e

--
Chuck Lever


