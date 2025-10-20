Return-Path: <linux-nfs+bounces-15415-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4758EBF2725
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 18:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E99421F16
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 16:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987B028750B;
	Mon, 20 Oct 2025 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5qcyUpD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741F028E5
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977930; cv=none; b=XAgKRKqUmY/U62cqHSK3O2jwIYQKiMTqttz3k1EEyf637bFZIkPvjYtoPoKZX76NMVQEo1RFWLj9ETfTIe0M/0Q+I/UN+atdgc7lux6pgtxeQQEKEvXlVhYZ9KwY4v9tzOJCSVidGRed/E63k327b1UvWfdxrYiD10CcwzfkYu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977930; c=relaxed/simple;
	bh=1124hQWnqj1W5nOxAyXoFkFgGUBsvbPBfuLcDIskvVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kf92RoEdzeAgHd0wa9+dsFsgeKYHyRQu+bj8WNjKtsAq920LFHX4uRiQeWNC7CSQrRa0kiJXSu571cu3hqKIvlfXzAsi0OnJFsDb0GIoyOIqeyEhfPVi4fC1Nbjd2SQhHrYTwWvJtoRTVOBoOOpy9CODacAUcKVbVbL+9iixnS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5qcyUpD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5A8C4CEF9;
	Mon, 20 Oct 2025 16:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760977926;
	bh=1124hQWnqj1W5nOxAyXoFkFgGUBsvbPBfuLcDIskvVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k5qcyUpDcMLZ1h1bZ575rDizjMBUbreBNn8vAbcfSY1PdWCZlhLqWqmlws81Vs/++
	 5zzYY0ACN6goncZVzxYPxXDUgoFMCXUDEORsitdOrH509yuwV/08OW3aNjJF2uEpeH
	 ViOah1tMOM2r8/jcN3aES49gE1x5Efr+rg6l73A7X/n2MGunyddnoWJ0Q1jmRqCyug
	 SHsDpS5BoUAfgxtZ65aD3pOPc/DPsIL8NMEASeJOqPOgmvy/+yOpg0iqTq+y162cVN
	 wFVPBK3yGmRBQlBz+BTOXlmPnlqXrgU7J8bdE+SmABo5nQMx5vCVWl9wFCGVWSIO8B
	 6knHNGcg4UiUA==
Date: Mon, 20 Oct 2025 12:32:05 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v5 2/4] NFSD: Refactor nfsd_vfs_write()
Message-ID: <aPZkBa8LVh60tfdJ@kernel.org>
References: <20251020162546.5066-1-cel@kernel.org>
 <20251020162546.5066-3-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020162546.5066-3-cel@kernel.org>

On Mon, Oct 20, 2025 at 12:25:44PM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Extract the common code that is to be used in the buffered and
> dontcache I/O modes. This common code will also be used as the
> fallback when direct I/O is requested but cannot be used.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Looks good, but please keep it attributed to me.  Feel free to add
Co-developed-by or something to reflect your assist?

Reviewed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>

