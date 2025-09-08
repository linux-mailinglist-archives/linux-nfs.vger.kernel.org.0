Return-Path: <linux-nfs+bounces-14126-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6BDB491C8
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Sep 2025 16:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B09D3A6EEC
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Sep 2025 14:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0393B30DED7;
	Mon,  8 Sep 2025 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1zsVBC2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12632F3C28;
	Mon,  8 Sep 2025 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342175; cv=none; b=LT4AZ2I/lJPkJZ197FwSWJPNTQg/TBi4UhnRgCTbFQT3mv5D8d1uqH60cU/JQOZfQadmZykyfOoOtaX6EptLm6oyGMkvIMRX9PWX8T5Ema8T52JSruqwpOlHDyZybCsSh2/ZH0xtNZeaz7FPFqopRcPolotPHRQUuv9g1FsZSBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342175; c=relaxed/simple;
	bh=btnHVkiRan10dxTSK9/SzvkzfNKgVwsddkJxfTQ/PU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QVEq6G6S69mbF1p84moX6glt1UkmgjYK8g28gp0nywZlM+RMp1/mfbpOFhEZzN9kJZ58Wy5UzSKlwLsjmMwUKRNvuYAQmG3RJfAH4fZ1p3Ch4T+HzWRsIWdrRRI67Axdrvh9WkfCnm79L0Wzi1wdLkd5l645flZQyqHtF8yxjaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1zsVBC2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3250C4CEF1;
	Mon,  8 Sep 2025 14:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757342175;
	bh=btnHVkiRan10dxTSK9/SzvkzfNKgVwsddkJxfTQ/PU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e1zsVBC2n/Jq15EzbFhyzxqnE0xJjMgCZhJlSQxqOSqWS32epORk/cHBslauHb9qU
	 fkCZV8qyW+nLtrUg3DmenzouMBDmJQiXBwA42yhCQrtKqIbuxIW8aL4jqesjl1Y1Lr
	 cey00lheQgkMWrxWFw1C6zb/mQJsCLdwn3wbWXaLJj2go69B6thcfMQzZKYUh+eODx
	 li1ApeGmiM0mFm4JURJCpEbGqfVzkObJUljgWZT+Q4d4F1RaCPJxKVbjUhcLZu0xrB
	 9WyhZ0peJ2OYaWYxIVGfofX0HCyVCdbqwNjLROgDHRIx3TApjV4ohe3wUSZZJStmyZ
	 MJNKliazy8vqQ==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: Re: [PATCH] NFSD: Allow layoutcommit during grace period
Date: Mon,  8 Sep 2025 10:36:07 -0400
Message-ID: <175734214900.12169.4500772338504347394.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250904154927.3278-1-sergeybashirov@gmail.com>
References: <20250904154927.3278-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 04 Sep 2025 18:48:44 +0300, Sergey Bashirov wrote:
> If the loca_reclaim field is set to TRUE, this indicates that the client
> is attempting to commit changes to a layout after the restart of the
> metadata server during the metadata server's recovery grace period. This
> type of request may be necessary when the client has uncommitted writes
> to provisionally allocated byte-ranges of a file that were sent to the
> storage devices before the restart of the metadata server. See RFC 8881,
> section 18.42.3.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] NFSD: Allow layoutcommit during grace period
      commit: ad996d67c7798b41c44203e40c535c3c4d97168a

--
Chuck Lever


