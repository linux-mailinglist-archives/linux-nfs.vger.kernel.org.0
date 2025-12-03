Return-Path: <linux-nfs+bounces-16895-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE97CA1EB9
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Dec 2025 00:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D179E30076A3
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Dec 2025 23:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CE92D480E;
	Wed,  3 Dec 2025 23:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhMNzwKi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062712E8DFC;
	Wed,  3 Dec 2025 23:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764803965; cv=none; b=cuNvqiOdnq8XrrUCIPjXsMtiXKhhxblk1V78cNyO1/+QvZ+i61zUyvPm6PSaW/SGGfbvhagR4QxMneBH14/Mrj5VsvWs16De4wx6B9KZrqU2Ts47AiCXD9CijA6qurMIfvtvaiFdiVhXBfDuDGDP5gu7J1jS16b43YL13Jt0RDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764803965; c=relaxed/simple;
	bh=9JMe3anAk+JGBqMfs4fJuF5ElnBPpLX0K7LZ0ITkNGc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UqHtAoNeOunypfe1VM0lnWc1vwFoCdm/ZM2Oej4kG87og+wY3ClO9ZGZZLg+9ZP8dPkU3hG7H1KX29eZv9TPl9jrbBre3o0VqZmxoCCgCkhpmJx+bPMRivA/tzlgUT/MgnNIMiJOTyfdyEHNdrMMm5w8/QHIo8brmTdZPTc6Yjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhMNzwKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F05C4CEF5;
	Wed,  3 Dec 2025 23:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764803964;
	bh=9JMe3anAk+JGBqMfs4fJuF5ElnBPpLX0K7LZ0ITkNGc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=qhMNzwKiw3xmAUH0fADkWv6gS+BzUeq+Fk0ehbDxoo2pieTwVWkOBMHgp9PTTHuBF
	 wWdJodkePsePyGd6mV2cYlaJa3wdd6cJuKhqhoX9HAMoh3pmlFzO0RP+yg6CA/aW1H
	 WWIlMqIlDbNF7dj05yOFzbxtLAqzBAcr3AeaVX6QofLZkMwAuEHM834xW1DUU1f45E
	 EvtPoxWLfcipw7tno3K43qd5Rb8WJEZ50fzrDouBNGgLzEIDU37FBKWGDpF4cjKAPp
	 6AEBA81uLRdSjHhqeREBDy5bXvxLbSZYzUkBXdFTamMkfJZ24uzF3ut5QErcVZWLlc
	 LG9GVuG/Zx4Gg==
Message-ID: <2130c40a31e71d7d602f17d6e564bcf1482d704d.camel@kernel.org>
Subject: Re: [PATCH 2/5] NFS: Request a directory delegation on ACCESS,
 CREATE, and UNLINK
From: Trond Myklebust <trondmy@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>, Anna Schumaker <anna@kernel.org>, 
	linux-nfs@vger.kernel.org
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Date: Wed, 03 Dec 2025 18:19:22 -0500
In-Reply-To: <d3da8a0e-4bb3-4a47-9804-2d0f3c452a84@nvidia.com>
References: <20251104150645.719865-1-anna@kernel.org>
	 <20251104150645.719865-3-anna@kernel.org>
	 <4f5da6d9-ee72-4045-8fe1-c5eacedb4660@nvidia.com>
	 <bfe61da1-3b52-49a4-844d-6f39d7ca4e9d@nvidia.com>
	 <ba1a5563fd66738156a372eed016986952f11fd5.camel@kernel.org>
	 <d3da8a0e-4bb3-4a47-9804-2d0f3c452a84@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-03 at 21:06 +0000, Jon Hunter wrote:
> Hi Trond,
>=20
<snip>
>=20
> Yes that does appear to fix it thanks!

Thanks for testing! I'm pushing that fix out to the linux-next branch.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

