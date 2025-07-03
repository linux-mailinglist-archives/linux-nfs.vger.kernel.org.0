Return-Path: <linux-nfs+bounces-12882-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CA0AF8407
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 01:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1406566C72
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jul 2025 23:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC742D4B5B;
	Thu,  3 Jul 2025 23:17:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B85275AEF;
	Thu,  3 Jul 2025 23:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751584621; cv=none; b=UZFyOSA3Ffe0TF05WeEs+9rAnKutVWw6lzLTzVhyLfLOkS9qoEI9euuMFC0SNUti8jeff6CRpGNaKQIosKJXXFW1IOi8E0Kknf+V7FHVTzbsFGl91aplv2IFUwG8aZHT7gvVuHwacLcBWB66KHUTnPSO7635n3aXfQtzwY/Y01s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751584621; c=relaxed/simple;
	bh=f75U+fsFaWBghqHI2kF+1eVpwBrvlSS1bBLtPTWtINg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=UQCPNBrxmTlWypOLrZrzl69S3WjMt1qvSjEdJVAEN4M57lhKtYZ+pyHHO8NDjCjIlRdJ8wUJ8Yf3M5fBkV099OVYZZY/mik6jEwR+UNIuyQ4E84BO21RRdqX3cYeBdNJ+QRneOfLt/NJkFJXuLGsEF5AYdGISDdlgphxRaOvKaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uXTAc-0018BH-UK;
	Thu, 03 Jul 2025 23:16:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Mike Snitzer" <snitzer@kernel.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>
Subject:
 Re: [PATCH RFC 0/2] nfsd: issue POSIX_FADV_DONTNEED after READ/WRITE/COMMIT
In-reply-to: <20250703-nfsd-testing-v1-0-cece54f36556@kernel.org>
References: <20250703-nfsd-testing-v1-0-cece54f36556@kernel.org>
Date: Fri, 04 Jul 2025 09:16:43 +1000
Message-id: <175158460396.565058.1455251307012063937@noble.neil.brown.name>

On Fri, 04 Jul 2025, Jeff Layton wrote:
> Chuck and I were discussing RWF_DONTCACHE and he suggested that this
> might be an alternate approach. My main gripe with DONTCACHE was that it
> kicks off writeback after every WRITE operation. With NFS, we generally
> get a COMMIT operation at some point. Allowing us to batch up writes
> until that point has traditionally been considered better for
> performance.

I wonder if that traditional consideration is justified, give your
subsequent results.  The addition of COMMIT in v3 allowed us to both:
 - delay kicking off writes
 - not wait for writes to complete

I think the second was always primary.  Maybe we didn't consider the
value of the first enough.
Obviously the client caches writes and delays the start of writeback.
Adding another delay on the serve side does not seem to have a clear
justification.  Maybe we *should* kick-off writeback immediately.  There
would still be opportunity for subsequent WRITE requests to be merged
into the writeback queue.

Ideally DONTCACHE should only affect cache usage and the latency of
subsequence READs.  It shouldn't affect WRITE behaviour.

Thanks,
NeilBrown

