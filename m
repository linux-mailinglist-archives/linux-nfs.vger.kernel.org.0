Return-Path: <linux-nfs+bounces-12923-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C95AFC1BA
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 06:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD251AA7334
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 04:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DC1207A18;
	Tue,  8 Jul 2025 04:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cC7H9O8M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C8943ABC;
	Tue,  8 Jul 2025 04:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751949481; cv=none; b=H3u0I+UW3Ach1DZhmeF0ZedgNYlEuHOBSKOVFdkW5U5m/7nPCembai2TsfkZzji25k+CNVDDoEbEtHkqxQ6RZuax29fBtqSuuM99YNDE1vkMg42QyA+VEkEI3RasxR7B5C6FLcrDHJxJ8MjqbYFfGr/WFV3n/uk45VhU3rNdS3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751949481; c=relaxed/simple;
	bh=8N3WqoTh8R5m03QO9MG0mjw5/nDiTbVs4NZLJYjSrn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxGoTtSUf6oiPklGNiRJUMh/H2nQ7hGA2X6MZigjbwk8kpqKD1pNoBemBkx/+cJKlpim+jfScqmjwvxOwT4T3C4Jylj0LGnhaNws7xk8UEe1dWW+XIVIeSIY191bo0ibgz/7b/qRhEAwi/3hv5v2KMynNOfx/UDt+kNKlEH0eTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cC7H9O8M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEA4C4CEED;
	Tue,  8 Jul 2025 04:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751949480;
	bh=8N3WqoTh8R5m03QO9MG0mjw5/nDiTbVs4NZLJYjSrn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cC7H9O8M604CxiWk4tuxRFao2jCuYY08VKFn3EbKEu0hemwVbSwBI9TYB1rqZXW9c
	 accYZRG+jT2WMVtJnQFJ8BQDEnnP9MFlaHib8pzTFJF2TU82B8JAevvCZhElo/iWcx
	 ItA+2ukVF75Q4w08yk0y818nNl3lmjg+S7ZMUKbVCP7RLAEG1amHG53UuOx0nZgYTc
	 xWgxXx09GgXk318ZntbMbuZGf2mg4UBc1ww5s9j4x2rpvYfAAhc/hqQf0UAHVmF3zm
	 ePslGSvQcn/ga4eMia2zoXCgVdtxB56HC0RNX+02esyMEFWuQcM1r02SNPjg42FVKW
	 s5+Zw/UY1f0hw==
Date: Mon, 7 Jul 2025 18:37:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, djeffery@redhat.com,
	loberman@redhat.com
Subject: Re: [PATCH 1/2] workqueue: Add a helper to identify current workqueue
Message-ID: <aGygp-3mtsLxtGT3@slm.duckdns.org>
References: <cover.1751913604.git.bcodding@redhat.com>
 <baad3adf8ea80b65d83dd196ab715992a0f1b768.1751913604.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baad3adf8ea80b65d83dd196ab715992a0f1b768.1751913604.git.bcodding@redhat.com>

On Mon, Jul 07, 2025 at 02:46:03PM -0400, Benjamin Coddington wrote:
> Introduce a new helper current_workqueue() which returns the current task's
> workqueue pointer or NULL if not a workqueue worker.
> 
> This will allow the NFS client to recognize the case where writeback occurs
> within the nfsiod workqueue or is being submitted directly.  NFS would like
> to change the GFP_ flags for memory allocation to avoid stalls or cycles in
> memory pools based on which context writeback is occurring.  In a following
> patch, this helper detects the case rather than checking the PF_WQ_WORKER
> flag which can be passed along from another workqueue worker.

There's already current_work(). Wouldn't that be enough for identifying
whether the current work item?

Thanks.

-- 
tejun

