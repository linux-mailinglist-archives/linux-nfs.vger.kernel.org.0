Return-Path: <linux-nfs+bounces-14983-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B85A9BB907C
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Oct 2025 19:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C3154E1E2F
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Oct 2025 17:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1712620FA9C;
	Sat,  4 Oct 2025 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euvQYLXH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1009946C;
	Sat,  4 Oct 2025 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759598417; cv=none; b=RHwiUPzPIpfd+tjFG7xzXvs0pVeh3N02AzR94K0x4gaX7IAqClu/DRlmAPJsCFhz/nPXiqhAlwCZUnbBCm6VpWc4VcZTKrQ3qEZplRbu2Nhwzta45jVkr7vqRQ65cTD8crJgpYAj1ggZlIBf8C8fk/GJTZoVOYzCpkjOQi9lVco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759598417; c=relaxed/simple;
	bh=ooHxtQpn2p7lAP3q3VjQtLAaxo4LSQa7M6HpyUFRWjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HuZoEZLaedglN5L4DieqWhh+UIpY2EKY+CGSARi9Iop9NvgNfqgkPEbjJSQOWpKKCaU9qkk7h9MCVo6JZIzcpYAWBJIwiSlbRm5aaA9kKCO3FibQ+qK1bh553SIQLs3unlMVqII1IpeulNb4uNzHjpLuLoow1evIMItSJkx1mUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euvQYLXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEF8C4CEF1;
	Sat,  4 Oct 2025 17:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759598416;
	bh=ooHxtQpn2p7lAP3q3VjQtLAaxo4LSQa7M6HpyUFRWjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=euvQYLXHs901J1JJQZtQZHFzuceOmcph7u9MRcJWlK4TOhYzbtu1dXXbjaYLnM/SW
	 vM+nWhSLPx/WBipCrXqMayxOugUQM/yspTaX8GXL7LJ4bT1YMXsH+PomRDkVkVnsXU
	 cnhEh5GAP6hbDWQBYVZ/Kzu7RNbIv3afLBGFu/buTvVyYdA9ZXv5tLNx48/cYV7iaU
	 hqjICrGuPVquRdkdxXdMLS2qqwG7oqbh1IIGZlNCukuHh6gIyARbcddQK8OuyFDZ0B
	 PoIeCWGCCA6qHcQbOHlkPWpeYXbp5UvUajM3b7wmsen8Y8ssITpXn7Ykv8pAUVkA6G
	 hGH6DgODElZ7g==
From: Chuck Lever <cel@kernel.org>
To: Christoph Hellwig <hch@infradead.org>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Tom Talpey <tom@talpey.com>,
	Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] NFSD: Impl multiple extents in block/scsi layoutget
Date: Sat,  4 Oct 2025 13:20:12 -0400
Message-ID: <175959837985.2025.4024778494628599093.b4-ty@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003091115.184075-1-sergeybashirov@gmail.com>
References: <20251003091115.184075-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Fri, 03 Oct 2025 12:11:02 +0300, Sergey Bashirov wrote:
> Implement support for multiple extents in the LAYOUTGET response
> for two main reasons.
> 
> First, it avoids unnecessary RPC calls. For files consisting of many
> extents, especially large ones, too many LAYOUTGET requests are observed
> in Wireshark traces.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/4] NFSD/blocklayout: Fix minlength check in proc_layoutget
      commit: b94708d49420881366669b7010269f159a6e1b70
[2/4] NFSD/blocklayout: Extract extent mapping from proc_layoutget
      commit: 88f8b3f8c4fc8c351aaae49d0fec4e7b5e6ad0db
[3/4] NFSD/blocklayout: Introduce layout content structure
      commit: 76fc273123889e9b1629fc9f1ec40465dbda1a73
[4/4] NFSD/blocklayout: Support multiple extents per LAYOUTGET
      commit: 8a3c46f07fb5c3cd6c1cc807d9a22e1531100625

--
Chuck Lever <chuck.lever@oracle.com>

