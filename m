Return-Path: <linux-nfs+bounces-18042-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEA6D38659
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 21:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5EB330463AA
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 20:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3752F0C7F;
	Fri, 16 Jan 2026 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7ng3d1V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3261FECCD
	for <linux-nfs@vger.kernel.org>; Fri, 16 Jan 2026 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768593648; cv=none; b=gaW6ba/LLccPwkfSG1LKJUWHN8rh80PwhrHPGat6vDmdlcfC3RAkEWqFuJOBNXAe7B6lb4FC/AhSSrFOL+GgCcm4rrIq4zGTEvQi+TJuTQXjjvim7eJFtPvhv8m9U36RD2cTELJsAsG2rUEspIQ3W6mEoHXpRVsgcPax/Zettm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768593648; c=relaxed/simple;
	bh=oIff1+l5OhAQ9j4VFtfndFDdcZdV/d2txkO6d4FsX6A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CE0Oqn+v33CLNabQhcy/vOsU4LHELzcFNnOfe71jvmI787Zj8mkXQXTKSN2R2Ao1av3ElPUU+5jrK7N0cctcPRPdDDDU+D8ajfGjDBx0Yf3UdCwq7a9tS689L6UStBjc3AybKkEb+kwhHJwSPX8bFgt3poSKGQ9X/KLi4DJodKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7ng3d1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EE3C19424
	for <linux-nfs@vger.kernel.org>; Fri, 16 Jan 2026 20:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768593648;
	bh=oIff1+l5OhAQ9j4VFtfndFDdcZdV/d2txkO6d4FsX6A=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=j7ng3d1VQX49uxWfMGzCqUwWFzXtd/cBnBu5lmwH2+srTTBFGe3bKOV0hkP9WwnvU
	 u8eySBbakUR7CQpZh+mZd32972qwg8mGnzUXX8JD08lJqmvpcCmZw9SKnfHgKxo9ff
	 ITFPA60rp+4U0V1EFXtX5aLVDP6D+4lfFAdxNILMUgE8OVcw2rhFueUWfG01AU4dKW
	 z3rP1EqszQWjXSufGI01WoHkpAsHLujVzFqcdefQIuX4j2VC/pNWCV4wlD19+IypQO
	 fSaMR3SFE5/NxZlPGe3gVImxFKW98NdPkuww1+k5iKp+loCDzujK7l5Itr/Z+Bbuq9
	 mpp6zcjQpANgw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2E74DF4007A;
	Fri, 16 Jan 2026 15:00:47 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 16 Jan 2026 15:00:47 -0500
X-ME-Sender: <xms:75hqaf2HG_ztY2e0vvBlO0M9XtUq5zLYEZ6xkMp8ecOg7hYO-XLe4w>
    <xme:75hqaY4IsbL1J4celZ7knMvRBpviInSmSf2Uam_wYkFsTlNw9tyy4qV-DK37tL-H9
    qJC5Kk6WE0r7348LvHfzP_HAyBcCUWlF8qC4nBd-CAtVPB5AucbznI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:75hqaWjo-7P8EKnnPEC9ziCjU4Qjko9ZiMBxW01q8wVxZcwoOt3HBQ>
    <xmx:75hqaU-tyYwlOlxuBBAW0Qv6iNhB5SwtgNXH283bX_R1n6YeSwFHFA>
    <xmx:75hqaVpCLlQS65jgWdrHXff15G_Fm9IjWPK4T9voJ1RiIOiMcgGW9w>
    <xmx:75hqab8H3zuyxBKTaKfVIhvaS-mDg_tVNLPraoixHvEimXNpsqmRng>
    <xmx:75hqaRWZlIC-qcQj4hYCOSzzGz7ya3JmSUJjC05gBIv6CF0y5f2boKWz>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 15E4B780070; Fri, 16 Jan 2026 15:00:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ari2zWJUXQbN
Date: Fri, 16 Jan 2026 15:00:15 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Dai Ngo" <dai.ngo@oracle.com>
Cc: "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Message-Id: <a1442149-fdc2-4f66-b73a-499a2e192960@app.fastmail.com>
In-Reply-To: <45f16856-b71d-4844-bf11-fc9aa5c2feed@oracle.com>
References: <45f16856-b71d-4844-bf11-fc9aa5c2feed@oracle.com>
Subject: Re: Bug in nfsd4_block_get_device_info_scsi in nfsd-testing branch
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Jan 16, 2026, at 12:15 PM, Dai Ngo wrote:
> After the entry in the xarray was marked with XA_MARK_0, xa_insert
> will not update the entry when nfsd4_block_get_device_info_scsi is
> called again leaving the entry with XA_MARK_0.
>
> When the server needs to fence the client again, since the entry
> still has XA_MARK_0, it skips the fence operation.

The mark is cleared only when a pr_unregister is done. I didn't think
that an additional GETDEVICEINFO should clear an existing registration.

So, did I misunderstand the API contract?


-- 
Chuck Lever

