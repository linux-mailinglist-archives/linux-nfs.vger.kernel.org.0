Return-Path: <linux-nfs+bounces-13143-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA4DB099D6
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 04:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03953B41CB
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 02:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D301A2C27;
	Fri, 18 Jul 2025 02:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFgzBi80"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AEC3597A
	for <linux-nfs@vger.kernel.org>; Fri, 18 Jul 2025 02:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752806264; cv=none; b=e+1driVuHiQ6IAT6/Dx9CPq/KxL1VvrM5jUskr6YDNyOF6GgQjc9I/Blpw2Hw8iayMrTud+Bz/wFerO9e+BUb+2zITBFy23qOKYHtcv6i3uVdV6SOfpYKF7ep1l+1hjrt4Vu1Xuumnv0sychqTwHGdonFgGYePiStzZJ5bTeQc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752806264; c=relaxed/simple;
	bh=m3d1GZcWZNdj5bZFvlhEULNHbsKLyde+TI00rV5GObg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfmLlqqhu92CBWz7QCNhpUvpbTSWaubpb6NBauiRa/yiPmVSWv8YBNLD3LiKQ7kKY2TowCZSCwhm8yngYj/qTCx3lL/nlKM5m55f9bFBXG1aSZRl4xYWpaWzYfEyMQmFeF0XMlXVdnzITtiCPzBP1GzXfqPKlX2BjhUc1wml8GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFgzBi80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF504C4CEE3;
	Fri, 18 Jul 2025 02:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752806263;
	bh=m3d1GZcWZNdj5bZFvlhEULNHbsKLyde+TI00rV5GObg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eFgzBi80D3MjzNgk3Gy5RHCKQSfouDZImcjdCbMOMkoQ1FiQtMguxRexeV3jOQCsh
	 5MnB2FgHRSXkqtcrQXPAkOGNi0m6byKu7HDtL2xGBYHnRegBOL8kdb4C1D6356Rse0
	 YBYEHaBz44gQ8ruqCGuIwiPuAgPO4jcohiEPRqWEegxHJ3zRSKdbVbEhrc3v2s6/ut
	 +H/nWHpnNdvRlIjEPJgSxIYZ0nmd5OscGgp9FkGbn0TiBpqM4+Pi1wG/r88klUT6uy
	 rgRgq2/DzZ5Gh/GgMNmD4TMnuPDnkJFdRSrxjja4vJYM3YU17VmjrLhdcZl0kbHvhY
	 x2/RE78gEpGGw==
Date: Thu, 17 Jul 2025 22:37:42 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] nfsd: discard nfsd_file_get_local()
Message-ID: <aHmzdhX1jTOvSCcK@kernel.org>
References: <20250718012831.2187613-1-neil@brown.name>
 <20250718012831.2187613-3-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718012831.2187613-3-neil@brown.name>

On Fri, Jul 18, 2025 at 11:26:15AM +1000, NeilBrown wrote:
> This interface was deprecated by
> 
> Commit e6f7e1487ab5 ("nfs_localio: simplify interface to nfsd for getting nfsd_file")
> 
> and is now unused. So let's remove it.
> 
> Signed-off-by: NeilBrown <neil@brown.name>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

