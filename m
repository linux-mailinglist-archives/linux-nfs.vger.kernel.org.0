Return-Path: <linux-nfs+bounces-7295-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2629A4817
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 22:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD46F1C22319
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 20:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05578208D8A;
	Fri, 18 Oct 2024 20:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8N3LvTk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFC32071FB;
	Fri, 18 Oct 2024 20:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283570; cv=none; b=b0gAHYYVEXpqQZYWLzuaLfcosk7PFI6nzpZBINZRZYD3Y0aMFFfCNMsQJpo/OXRffyOaHq9RMEpu0w350zs5yrwEAECm7mNP5VWZbP7+VdhXDg7miG6qjUcCsGVNUJR1Tw264/KYfUZ/NA7wHPx3nMJEe3W3hza7evrTki9KOZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283570; c=relaxed/simple;
	bh=/8iGQEwctRbj5LryMm16Z9kbZqOisZbj5aZS1YOqAT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m32eYNStgycuaCDZbP2XiSKDhw7J6ZU3bnxfzUn8iY7fVbtrJiZfXbO0TSQx8eiwr1Y59tixbaPvvdL4tLyq72o2IFlcYRgEMhCf+Os426ToTebeUJMphJwdTougcwq9APeJtemiXWVsPp/ENAiETCcUxyyZ6dwEN+1n6VvRvB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8N3LvTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92025C4CEC5;
	Fri, 18 Oct 2024 20:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729283570;
	bh=/8iGQEwctRbj5LryMm16Z9kbZqOisZbj5aZS1YOqAT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I8N3LvTkwCgzIRROb62/aBr3XKu/xKXmK8RP3tOnyFYWrVZZt23JaMvF14Y+IhuOr
	 mYh+dkS9DCusPhkTRCuPFPvNTFScKyghXc0qfR9prTHFgNGGACxSqP9rCdT3OHaBOB
	 cooJXJyRyMcFhLj5TxruTBl8Y9/ObJkoVwS3Y/evNHm7gDcYclQajjUA9qT4/nvc0r
	 UTIEf+kdrhgYnsgF5TjdP4lZEieuyrOznrshN3ZwKh5Bp0ppMgNIwtloXK7YcbXRQJ
	 Ga60K+00ycHWai04Np6/oFSw9yyephW5Bmc9kpF4lHuXDskZk4O46LQ3/A2uAUOphl
	 lStTSVhmYEsSA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olga Kornievskaia <aglo@umich.edu>
Subject: Re: [PATCH 0/3] nfsd: fix final setattr on delegated timestamps
Date: Fri, 18 Oct 2024 16:32:40 -0400
Message-ID: <172928353196.235979.12559359835670760311.b4-ty@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018-delstid-v1-0-c6021b75ff3e@kernel.org>
References: <20241018-delstid-v1-0-c6021b75ff3e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1222; i=chuck.lever@oracle.com; h=from:subject:message-id; bh=HoB1+4k0Mz470vdco9+MxfcZbzkY2wnDFRSI7g9Zdzo=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnEsXpiS3y8xkbFY1xgsf6DYDoniHKpPGI3HvSI 4qvHkNBYlyJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZxLF6QAKCRAzarMzb2Z/ lxOcD/9ZP/INhvdYHOxCCQaFQvxOWOUjP8kohdfU4jR6FdhYVdxc4M4sD0s/nTKDrqcmz3asMKB 6pLyEyNPSD5DCEAQE/h+ejGhD6yvb1SkSW18Lzqd1qfXhDEhhlsEfxAcMA/yAW75Lj6tYj/mqgk iv0TaW8Po2AFE3CnThDz+tusbEF7C0Nvt5LLQwhccD02AbsngEbUYCvVmGQQJ/K292cpnxToi5B /gCJXwAwKdKZf756E7mE9HHpPB/NFjP9UZCxx9XvcGgE6jxzoEb3PVOHZu34Nf7KkvC8ns1gqS2 H3hXJ9R7OnOi6UIPaO17AFeKEqhKaPR14va/ERSIelCiadY9rv/Z1LJWox4e2ti6UK0zenRiDDG hHZc4P0WzQ0jDAnlkvT0NPPVhjnwUDFNKkS5615jkeGNw1lRpb7LTvI1lo8N9TLue09EnGrd/63 IIlgVoDtlTGpYc9eBSU5hyiovLU/mm4644gpNm8jzPj1Idu4d279DnDNmUjOTacjYSpg0+ZXr5t NY2fquK2ywP/YvMa5wfmlgvau0w8hze5cDLyzDVor1K98jnb5qcCzVidAwoH/JacEg0IQwfq2hx rQmEBi6ebiLvTAlG++bLoueTObkNoQnoJEu3lENfIellFnwXXP1Pir6aioeYe9MYR6VPc+gF6AU 1NJKhX
 GxP6d87qA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Fri, 18 Oct 2024 14:44:58 -0400, Jeff Layton wrote:                                              
> Olga reported seeing a NFS4ERR_INVAL return on the final SETATTR before
> a DELEGRETURN to set the timestamps. The first patch fixes that by
> simply ensuring they are declared writeable. The second patch fixes a
> related bug in the stateid handling in that same SETATTR. The last patch
> adds a new tracepoint that I found useful for tracking this down.
> 
> It might be best to squash the first two patches into this one:
> 
> [...]                                                                        

Applied to nfsd-next for v6.13, thanks!                                                                

[1/3] nfsd: add TIME_DELEG_ACCESS and TIME_DELEG_MODIFY to writeable attrs
      (no commit info)
[2/3] nfsd: allow SETATTR to provide a READ deleg for updating time_access
      (no commit info)
[3/3] nfsd: new tracepoint for after op_func in compound processing
      commit: ba6b3220066fdbd38063230cfc7951b728f15464                                                                      

--                                                                              
Chuck Lever


