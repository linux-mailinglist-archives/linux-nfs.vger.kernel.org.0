Return-Path: <linux-nfs+bounces-13110-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25799B07763
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 15:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C7350685D
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 13:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21EF1EA7CC;
	Wed, 16 Jul 2025 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccqEtlKq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737F81C5D55;
	Wed, 16 Jul 2025 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673990; cv=none; b=UV6XB8ZC7nOEFXYId8ntIEdVSjXDzjQxkuEJ2UAmAPu3cse5loDo8TzRH+lrP//FbKJHa+outEEBa1rnbrfuqbevuj9zEWkVMFFmxaLjDevfZ0xxmp8RFS/8PtzhWHvZrkeRu587EN6w8kQBFPVMmYxI/rO0lpHVkxcLCENSrE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673990; c=relaxed/simple;
	bh=cjF8GNv4yc2moZNkYpxvhbWC0HFdcj6SQO3SfO89zw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATUkOBLGw9TSNAXSpXdIMm4rL/oKD8UjvYko/qJIIxDy8u2xAvueD5oXEykLcQZ6iaVcoH8Ax7GMljUZPYTzU/SZPMLCJURh9m3jHc1WUfS6x1atx/T91fsWpBx4+3nBQ80jbawlKQlZN59iXA4eMtyGfnQSBrivGCtfeoszItw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccqEtlKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CF7C4CEE7;
	Wed, 16 Jul 2025 13:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752673989;
	bh=cjF8GNv4yc2moZNkYpxvhbWC0HFdcj6SQO3SfO89zw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ccqEtlKqfVKu+QaX5DmB42utD839D/k+sPGU6gwBiBk7rpKWcEruf/TVxMut3Z13G
	 EJg8XvwnEtpoKLzkLCd01PaRCTTuR0B8qjjwPRssGO8mWcKSMEBvBMC6B0PKBSOyvu
	 gQYDdxkPvhi7s8YUR7C2vCL48G4MMa6BgE+0uvsKScH03dye+RlHs7vPted7KqYK6w
	 s5JdsnhvRe6ryPBn1c3Z4BsXsa3Cj14FH2g17t6eIAGHnWwM2e695K3WBoiAj80n4b
	 /PN+p937NgWIE9OQgUGMqlHMWr5JUStPM3r6GHnI9buFKZwvIIIVs2WNh/FbNQ8nhT
	 WcUg2zFMgEwSw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nfsd: don't set the ctime on delegated atime updates
Date: Wed, 16 Jul 2025 09:53:06 -0400
Message-ID: <175267394864.1264654.17745222053108862498.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716-tsfix-v2-1-b834899cf4d0@kernel.org>
References: <20250716-tsfix-v2-1-b834899cf4d0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Wed, 16 Jul 2025 09:34:29 -0400, Jeff Layton wrote:
> Clients will typically precede a DELEGRETURN for a delegation with
> delegated timestamp with a SETATTR to set the timestamps on the server
> to match what the client has.
> 
> knfsd implements this by using the nfsd_setattr() infrastructure, which
> will set ATTR_CTIME on any update that goes to notify_change(). This is
> problematic as it means that the client will get a spurious ctime
> updates when updating the atime.
> 
> [...]

Applied v2 to nfsd-testing, thanks!

[1/1] nfsd: don't set the ctime on delegated atime updates
      commit: c82fd6eaa88b8b0922ee2c77ec1b644418e0768a

--
Chuck Lever


