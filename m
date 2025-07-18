Return-Path: <linux-nfs+bounces-13153-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68185B0A635
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 16:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47F3E7ADAEC
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 14:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CA72DAFDD;
	Fri, 18 Jul 2025 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5JKeeZX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C0C189905;
	Fri, 18 Jul 2025 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848501; cv=none; b=JhU1r0sGBNJPRTxHlz3gaxsurr03C4lvrmgl6fd2bTFub5rGIrAX9dpxNUjE2nfYozq0rYUnGfvFc/2ryOZSG1bjoZnQta8JGe7Nt5rdv8NWgDasiV4KcsgyStizc9b4cLlZpMJpuMh0fVZuozHE3Vu2agiiiYwVU3FmkWxNXl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848501; c=relaxed/simple;
	bh=sCBjjY7QqodoG86EUqmrVeqEu70zeo1YRvyYt2qvWdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EuRTmYtqYt4aTbLguKY36KqbNSD6T/ZEnAWKNc/mlZUy1P8cAtLVBunki4P9CMJBH4NSudidXJYFaX0nso4sdXA2bFqPus9W6mFR7BKqEM4Jq+A+NNJHfKPnyIZbSACDNozseMjPPfhujrQgM7sQBsyoPzGXeRZWq0xbcIRBNTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5JKeeZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C43EC4CEEB;
	Fri, 18 Jul 2025 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752848500;
	bh=sCBjjY7QqodoG86EUqmrVeqEu70zeo1YRvyYt2qvWdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R5JKeeZXnKMkJKRBZu0wGhAWp80H45DXTFWxI/X5AEY9IK68WzHjIcT9Q19DFOwrM
	 kL96WmTqk3UNCsfKspEIf33lu0LBUPU1o57091Lb+DtILnXNljhmewVUO+e2mMzpS8
	 kjymR0lc3BHjL8yQro79Z8yfvgiDeblPLu/oDNsX34bB4F6CWww8KwD4Thwfxan5uz
	 Z4FiKmma7FbHxwIS0IMHLdQMrrIjQAnWaVHVqKEH5T8f+i0OEy30mu259Q0fx6Kuwd
	 R0e7/5bFiT3ktpjFESdVt3BNNLkRL0wu5wX5DGO0Pq/Kdf7n9BrjZmUkHOCbcHAENF
	 ytihmdWQielzA==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v2] sunrpc: Change ret code of xdr_stream_decode_opaque_fixed
Date: Fri, 18 Jul 2025 10:21:36 -0400
Message-ID: <175284845618.1668826.1570213345042161150.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250718080958.71913-1-sergeybashirov@gmail.com>
References: <20250718080958.71913-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Fri, 18 Jul 2025 11:09:56 +0300, Sergey Bashirov wrote:
> Since the XDR field is fixed in size, the caller already knows how many
> bytes were decoded, on success. Thus, xdr_stream_decode_opaque_fixed()
> doesn't need to return that value. And, xdr_stream_decode_u32 and _u64
> both return zero on success.
> 
> 

Applied to nfsd-testing, thanks!

[1/1] sunrpc: Change ret code of xdr_stream_decode_opaque_fixed
      commit: 4f48fa0301a4eceee070baa5ca0f0bb470a2a54e

--
Chuck Lever


