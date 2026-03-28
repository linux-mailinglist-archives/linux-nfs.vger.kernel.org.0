Return-Path: <linux-nfs+bounces-20506-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOhCHJogyGmKhAUAu9opvQ
	(envelope-from <linux-nfs+bounces-20506-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 19:40:26 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAA434FA9B
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 19:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EB21303767D
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 18:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101963A784B;
	Sat, 28 Mar 2026 18:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="ku2cJz4o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286F43A6B6F;
	Sat, 28 Mar 2026 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774723202; cv=none; b=unlGI0NZsQ+gLhsOYSYdTHAp3gjLk1AmvKXkVMOv/Ig3q3Rh53yJD2qsgaciDTXyBac8avbUr2tqCscqUjCz8pw1ijHWYnVDfcsWB1ligql/eFVeCgb9DrWc8kf/PN3dJt1E+BQ5X5izY+0iYBMB5SBW9sswPwOvU96G+zcwpZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774723202; c=relaxed/simple;
	bh=F8k5kBCEuCjdiOh5D8EDn3Kd0pIFrA38w0cbq0FhlzQ=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=HOCpttyoQBzo60nl8GkmxsQNIWJvxUR51oZmLEdKngdjTVsWmAw22HFPsDMjbIlT/HCgPWGu8BlymZ57Bsy6C+adyj0iaCqR6MD7V8uyZfsgikyAKXvx1X3SLOXbOqpWAeggi03CTOzGC9gpFoy6GRkrqHYP3n41AitAYHkIjAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=ku2cJz4o; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Sender:Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description;
	bh=TCGm0nfvvy8Bnnpu5UWLIv7a/i53kn4C96IdqEjuOQc=; b=ku2cJz4o03JZhzhabC4ZS5XbZC
	8fH607SCqVF/YqtrusQ/G5FiG6gH1ajZx6cWgIFhW28kni4tJQct4RMgQn8dGRVZ1RN5Jse7vYmZf
	5d/os5vwEEuzHvfwVrVTc1ieO8ke+ivEj4m7QlAcf7wpkzbK1Jaz14/FR5wwoZKBGcKBiJpKNxIBA
	rwboQIKnYYfrjgvzfIj6gnW9K4GURLcYJODzbaH3GEGOIgChMG037qjdVMrGf+pdJHSj0knj3XJCj
	krzS92CQw5XYUHB4MVUnLZjm1yudidhzLUXsJXW52+cN57wlHUxvXKOdG/xxQS1kHTOJegmhMePBP
	FnrnG4EQ==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99.1)
	id 1w6YZf-00000001nrA-1k06;
	Sat, 28 Mar 2026 15:39:55 -0300
Message-ID: <5ada775e751c32368a012f1d17c5323a@manguebit.com>
From: Paulo Alcantara <pc@manguebit.com>
To: David Howells <dhowells@redhat.com>, Christian Brauner
 <christian@brauner.io>, Matthew Wilcox <willy@infradead.org>, Christoph
 Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, Leon
 Romanovsky <leon@kernel.org>, Steve French <sfrench@samba.org>,
 ChenXiaoSong <chenxiaosong@chenxiaosong.com>, Marc Dionne
 <marc.dionne@auristor.com>, Eric Van Hensbergen <ericvh@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>, Ilya Dryomov
 <idryomov@gmail.com>, Trond Myklebust <trondmy@kernel.org>,
 netfs@lists.linux.dev, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 12/26] iov_iter: Add a segmented queue of bio_vec[]
In-Reply-To: <20260326104544.509518-13-dhowells@redhat.com>
References: <20260326104544.509518-1-dhowells@redhat.com>
 <20260326104544.509518-13-dhowells@redhat.com>
Date: Sat, 28 Mar 2026 15:39:55 -0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: pc@manguebit.org
X-Spamd-Result: default: False [0.34 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[manguebit.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[manguebit.org:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20506-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[manguebit.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pc@manguebit.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email,manguebit.org:dkim,manguebit.org:email,manguebit.com:mid,kernel.dk:email,linux.dev:email]
X-Rspamd-Queue-Id: 2FAA434FA9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

David Howells <dhowells@redhat.com> writes:

> Add the concept of a segmented queue of bio_vec[] arrays.  This allows an
> indefinite quantity of elements to be handled and allows things like
> network filesystems and crypto drivers to glue bits on the ends without
> having to reallocate the array.
>
> The bvecq struct that defines each segment also carries capacity/usage
> information along with flags indicating whether the constituent memory
> regions need freeing or unpinning and the file position of the first
> element in a segment.  The bvecq structs are refcounted to allow a queue to
> be extracted in batches and split between a number of subrequests.
>
> The bvecq can have the bio_vec[] it manages allocated in with it, but this
> is not required.  A flag is provided for if this is the case as comparing
> ->bv to ->__bv is not sufficient to detect this case.
>
> Add an iterator type ITER_BVECQ for it.  This is intended to replace
> ITER_FOLIOQ (and ITER_XARRAY).
>
> Note that the prev pointer is only really needed for iov_iter_revert() and
> could be dispensed with if struct iov_iter contained the head information
> as well as the current point.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Christoph Hellwig <hch@infradead.org>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: linux-block@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  include/linux/bvecq.h      |  46 ++++++
>  include/linux/iov_iter.h   |  63 +++++++-
>  include/linux/uio.h        |  11 ++
>  lib/iov_iter.c             | 288 ++++++++++++++++++++++++++++++++++++-
>  lib/scatterlist.c          |  66 +++++++++
>  lib/tests/kunit_iov_iter.c | 180 +++++++++++++++++++++++
>  6 files changed, 649 insertions(+), 5 deletions(-)
>  create mode 100644 include/linux/bvecq.h

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>

