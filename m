Return-Path: <linux-nfs+bounces-15416-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F9CBF2749
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 18:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B272B188152B
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 16:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0DB28E5;
	Mon, 20 Oct 2025 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/HbfBqc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8457B18859B
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978021; cv=none; b=nTIKygB3BUyW4e1SLh76jCYHQh986y5KUtAJV8M5KiBsIAWTmGo8SGEAF+st7BhTWy1nN6bn/3fdUfzLVLMmUlKQqCYY9VlVGc+qyONjLhVbPlR3OIqbTfga/t0l4dbBOfab2sxfqgHzVWaEIT/LB4WW6ukwNg0bSijlh7JONX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978021; c=relaxed/simple;
	bh=OlBAqKJC4DKf3XgUmkxMgIzmDZ5N6FTxp/5HpUFhMOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nI8xkOajofBMc+7a93fk33Eo00lDvtsFJ03H8AxvV6D5heZFEimvrl4/MgfUiiuZOwTFS3IugiGyFZ92DriTnH1gaFiqcoWzSBH2RiLMZB3AJlhilvLg4ODmSsh6ubNMdALS+LiIUQn/SY2ocg5QMzbydsEYhA4PtfpoZXYiLL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/HbfBqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0641C4CEF9;
	Mon, 20 Oct 2025 16:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760978020;
	bh=OlBAqKJC4DKf3XgUmkxMgIzmDZ5N6FTxp/5HpUFhMOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m/HbfBqcm54/pkesQR8SzjnytKB7JWwN06McN2pML/wkNbgjsUbyGtynhzrhUx4IB
	 RNyXj4767+y+/xalbqjINPG+OfmeEsBZZOn6KGnd9uSvPW8oMABY6+dM45lUQdDSGZ
	 2XehHzuJXdxOesWOkxUUsHQcgR2AqRl+/IFyD/YzdEF9RejobttzQFhg1of359pJ49
	 bxAegy95dEd9Uv7KpOTzo25BIxUJ3pNdTHDp1mxaOlOU4BFl0F/M1lHjUzfkl3JMVz
	 Qoej5Z8QaLepIlfs4ODm+s7FBT34lgN9YSmyOokW46ztHqo347hYBDPYaCpYxN9k2P
	 zUOPZBNSqDPKQ==
Date: Mon, 20 Oct 2025 12:33:38 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v5 0/4] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aPZkYqyFZ4SGnMbF@kernel.org>
References: <20251020162546.5066-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020162546.5066-1-cel@kernel.org>

On Mon, Oct 20, 2025 at 12:25:42PM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Following on https://lore.kernel.org/linux-nfs/aPAci7O_XK1ljaum@kernel.org/
> this series includes all patches needed to make NFSD Direct WRITE
> work, plus an experimental follow-on patch.
> 
> Mike, just send along any responses to review comments as patch
> snippets and I will apply them as needed.
> 
> Changes since v4:
> * Split out refactoring nfsd_buffered_write() into a separate patch
> * Expand patch description of 1/4
> * Don't set IOCB_SYNC flag

Sure thing.  Just a bit concerned about removing IOCB_SYNC in that
we're altering stable_how to be NFS_FILE_SYNC.

Mike

