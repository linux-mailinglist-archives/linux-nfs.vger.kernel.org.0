Return-Path: <linux-nfs+bounces-10372-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9470AA46E02
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 23:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4844E16D082
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 22:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB91269AEA;
	Wed, 26 Feb 2025 22:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OaR0KTYA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C1E269831
	for <linux-nfs@vger.kernel.org>; Wed, 26 Feb 2025 22:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740607328; cv=none; b=eCv+wRBeK+y5ZGbwdA2TqsRL6p3/+QKNgI2dfoT4zBAeTRk552XVU7j2TRdje/hfqJ035/mwPmpki/BzxgpszH9ygfdifiFZs1EsORBm3ToLItCIZlf+55IUxSgaMoazS0xIf+dyUkB8udNgxzctRX6ijUU5KxaxwX5l+XNOINM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740607328; c=relaxed/simple;
	bh=p5epPjMWWNEfnHqX83pP7X4RcsBho4prTB3XhuWpmI8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GMz4iY3YaGhJDDS329i+hNVA0A0YOu26hCaVhnUiZ5Hea0m9zgGYn+tcG9vKKmHAje9H5g+t3rvEH50JFZp2BsG1FCkju1EsWgiHoyxNRk9hAWq49CkqlfLr6eaQqWSiVIcWjzpgtD0M9bMlXCywNAHFaOqgU5F1SRUKRUAAqGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OaR0KTYA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DDDC4CED6;
	Wed, 26 Feb 2025 22:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1740607328;
	bh=p5epPjMWWNEfnHqX83pP7X4RcsBho4prTB3XhuWpmI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OaR0KTYAHvedbhScdD1MKnXCwZN8HR/UB4CG9w1EFxa9RQXBYPX0va8XjlC5iOwtX
	 LN/6IWqMM58WRi9lUqoBuE7WrkJ7bMGULHINgQ0r27m12oYgbOu/tgCFTWa8rz5gw0
	 9Mh2g8XpRS+P7fKT6w6eA7TFzppUF5lrce42syUQ=
Date: Wed, 26 Feb 2025 14:02:07 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Mike Snitzer <snitzer@kernel.org>, Trond Myklebust
 <trond.myklebust@hammerspace.com>, Anna Schumaker
 <anna.schumaker@oracle.com>, linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH for-akpm for-6.14-rcX] NFS: fix nfs_release_folio() to
 not call nfs_wb_folio() from kcompactd
Message-Id: <20250226140207.90cc614ca22db560f19638ca@linux-foundation.org>
In-Reply-To: <Z78sA-7_u5SyuFSw@infradead.org>
References: <20250225003301.25693-1-snitzer@kernel.org>
	<Z78sA-7_u5SyuFSw@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 06:58:11 -0800 Christoph Hellwig <hch@infradead.org> wrote:

> On Mon, Feb 24, 2025 at 07:33:01PM -0500, Mike Snitzer wrote:
> > Add PF_KCOMPACTD flag and current_is_kcompactd() helper to check for
> > it so nfs_release_folio() can skip calling nfs_wb_folio() from
> > kcompactd.
> > 
> > Otherwise NFS can deadlock waiting for kcompactd enduced writeback
> > which recurses back to NFS (which triggers writeback to NFSD via
> > NFS loopback mount on the same host, NFSD blocks waiting for XFS's
> > call to __filemap_get_folio):
> 
> Having a flag for a specific kernel thread feels wrong.

Why do you think this?

We are getting a bit short of space in tsk->flags.  Five PF__HOLE__'s remain.

For this patch and for kswapd I guess we could simply record the
task_struct*'s in a static array, something like

static struct task_struct nice_name[max nodes];

	...

	if (current == nice_name[my node])
		...

It's something we can look at if we start getting really tight on PF_ space.

