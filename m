Return-Path: <linux-nfs+bounces-17451-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE49CF4FFC
	for <lists+linux-nfs@lfdr.de>; Mon, 05 Jan 2026 18:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 429BE3035243
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Jan 2026 17:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6421309DA5;
	Mon,  5 Jan 2026 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oERYNe9F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B185E29DB65
	for <linux-nfs@vger.kernel.org>; Mon,  5 Jan 2026 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767633884; cv=none; b=nleNG0BAOKZu/cdY9pP6zaKbsLhT4GiHSkRzoCofQcIYzQdQY8IdG08kXfwp9ENa/ugoYYn2CCi6+3ZFXCCQ/br4e/Qe3oEsv/QNXb2Wkw5nPnEKs6n/wsyTBLS2/FgnXqhoKrgk5JYuKpR3yVAw7tcN+koytyKX9lJgk7xxZTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767633884; c=relaxed/simple;
	bh=s1s2ErUD4B/BWmbYzfZB1ZhY+z8D4PatJw6k54QSCF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgJ4Wudz17rmgKLeCYQcb3/1mIzKvkByC+TG1arqStdNnaahQ001kmthjRqvacYu/wo200LAL8qZHQYpTZydezF010f58ImExva2aBUt6HOQneekUZ9SOI0NFiyydekIIWdBY2WAFNlIWT5lFFMZdbCwYQ8XGO1aclIcX4471nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oERYNe9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFE5C19421;
	Mon,  5 Jan 2026 17:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767633884;
	bh=s1s2ErUD4B/BWmbYzfZB1ZhY+z8D4PatJw6k54QSCF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oERYNe9FJ0KWO+cGYtW4eEYipB2MP4GPdn8UZEGjW2z1y8/a7Xe52yX8sja3YvbZ6
	 cXMBFtXGCxmAhfhRuqpt1+skdU0MqX0UdDnAQCE5hurKtQlOUOlz97F4mViXLQy6lh
	 sVqu9e/hfz27Flapn42GcTC048mHzUm0yQDL07d8BzKyEqA4pN7PszFVDxkpLtw+hX
	 JLtLGRqXLJoO+24qi4eCsRZhGGjhI0rZQ6tX/QoEelGibTpC71u3/jKOAwBCYWr0lw
	 lF61QpYBPDvWz0cLeXLIu9bml0DXvlx8bHnds8yOVDDs7kksLQo/L4AastMinWSczu
	 +UdUK/I5Cwf7A==
Date: Mon, 5 Jan 2026 12:24:42 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH 4/4] NFS/localio: Cleanup the nfs_local_pgio_done()
 parameters
Message-ID: <aVvz2mPW2qN1e0rA@kernel.org>
References: <cover.1767459435.git.trond.myklebust@hammerspace.com>
 <bf5a9581839ebeebbd3bd004a174fea9afa19dcb.1767459435.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf5a9581839ebeebbd3bd004a174fea9afa19dcb.1767459435.git.trond.myklebust@hammerspace.com>

On Sat, Jan 03, 2026 at 12:15:00PM -0500, Trond Myklebust wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> Remove the redundant 'force' parameter.
> 
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

