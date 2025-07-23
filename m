Return-Path: <linux-nfs+bounces-13202-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FD4B0E80B
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 03:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3570B7B27DF
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 01:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365368615A;
	Wed, 23 Jul 2025 01:28:20 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C59EAD7;
	Wed, 23 Jul 2025 01:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753234100; cv=none; b=P4wfb/m28cF7utFGIb2qcjgdUYjpg6i5II/rRxboQcZ4rm09T5rUvuJYuzxvgzTOiV/LYEKiNEkNxsSXtT73mRWmA/1aFRRpe5fmkdrLmpU9UKPY53zVx9F1SeZJaDjYw5yJ3+JMVb7fcX7AREh1blbKvLadE3L3iPnwJsvc8k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753234100; c=relaxed/simple;
	bh=IzwYL1jV3SEQxdePQxArLBmBzWHE4zmljEAePfyqnfs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=oyoamHLclCN9MMNg1pdAXTqASVjwtsnT4NN7LJqEJ+EbxYo3AtyCyodD1v8GURV5DFgNkF6QuVuSBnetDlq3XJvbgkNAOcZtcKYn6LvEWmzvyv5AHX66BWWpBBhTzIB8C3OzdJ98d88WG8XRZk3YH05engU/O6/NfOS5z07pQe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ueOH8-0032wf-VE;
	Wed, 23 Jul 2025 01:28:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Christoph Hellwig" <hch@infradead.org>,
 "Sergey Bashirov" <sergeybashirov@gmail.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] NFSD: Rework encoding and decoding of nfsd4_deviceid
In-reply-to: <05e851b2-a569-4311-b95b-e1ac94d4db5c@oracle.com>
References: <>, <05e851b2-a569-4311-b95b-e1ac94d4db5c@oracle.com>
Date: Wed, 23 Jul 2025 11:28:07 +1000
Message-id: <175323408768.2234665.8262591875626168370@noble.neil.brown.name>

On Wed, 23 Jul 2025, Chuck Lever wrote:
> On 7/22/25 1:36 AM, Christoph Hellwig wrote:
> > On Mon, Jul 21, 2025 at 05:48:55PM +0300, Sergey Bashirov wrote:
> >> Compilers may optimize the layout of C structures,
> > 
> > By interpreting the standard in the most hostile way: yes.
> > In practice: no.
> 
> Earnest question: Is NFSD/XDR properly insulated against the "randomize
> structure layout" option?
> 
> 
> > Just about every file system on-disk format and every network wire
> > protocol depends on the compiler not "optimizing" properly padded
> > C structures.
> It's an intrinsic assumption that is not documented in the code or
> anywhere else. IMO that is a latent banana peel.

We could document it in the code with __no_randomize_layout after the
structure definition.

But currently the only structures that are randomized in Linux are those
which are entirely function pointers, and those marked
__randomize_layout.

(See documentation for "RANDSTRUCT_FULL")

> 
> While not urgent, this is a defensive change and it improves code
> portability amongst compilers and languages (eg, Rust).
> 

I'm neither for nor against the change.  I would be interested to know
how much it changes the code side (if at all).

NeilBrown

