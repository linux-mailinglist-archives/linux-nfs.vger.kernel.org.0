Return-Path: <linux-nfs+bounces-11705-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B61AB6012
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 02:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056BA46674A
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 00:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D1C1FDD;
	Wed, 14 May 2025 00:11:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFE0A944;
	Wed, 14 May 2025 00:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747181477; cv=none; b=Y5HssZRY5DkTacSzfH1tTdjendLKJbBRdSElhR5ep1/UYQbpDc9jLnNmQQV1U2tN9mzpOIYN1Uv6bCD6MXjnmk0HvqjkGJG3MBthkv2y3dkawJdPFE1SqBhiKFPnsZjExLpYkLcFuO8xICzDIkyYNHreRP+APxobKWAKSi72d+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747181477; c=relaxed/simple;
	bh=VqUm4TstL6nXAbd3sVP5z9BlPJ81SGVRjNYACkqa+OU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=I+57E4uIDoVcmkJJjcMs4zYznHcCS8ZFjcffzSCfn+1OLp05CMjxsQvXKMVBL1svZOfJbBC8D6vWL8iLzOpd/+KbVYcOEkRLe5WUatwfeTEejOkiLdJ0QFbHo4CMRt3v31UKL2wT51AgWC921b4ku+6CC5R8dUPBFF8We8Rml88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uEziB-003KyG-Sr;
	Wed, 14 May 2025 00:11:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: =?utf-8?q?Aur=C3=A9lien?= Couderc <aurelien.couderc2002@gmail.com>
Cc: "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-rdma@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Subject:
 Re: [PATCH v5 19/19] SUNRPC: Bump the maximum payload size for the server
In-reply-to:
 <CA+1jF5rpxD8NSMxzURWEF+RsgwhVXsr5pmDs_zDYe5nfJk0V2g@mail.gmail.com>
References:
 <>, <CA+1jF5rpxD8NSMxzURWEF+RsgwhVXsr5pmDs_zDYe5nfJk0V2g@mail.gmail.com>
Date: Wed, 14 May 2025 10:11:02 +1000
Message-id: <174718146265.62796.10462247854805820807@noble.neil.brown.name>

On Tue, 13 May 2025, Aurélien Couderc wrote:
> On Mon, May 12, 2025 at 8:09 PM Chuck Lever <cel@kernel.org> wrote:
> >
> > On 5/12/25 12:44 PM, Aurélien Couderc wrote:
> > > Could this patch series - minus the change to the default of 1MB - be
> > > promoted to Linux 6.6 LongTermSupport, please?
> >
> > It has to be merged upstream first.
> >
> > But, new features are generally not backported to stable. At this time,
> > this feature is intended only for future kernels.
> 
> 1. I could argue that this patch series - minus the change to the
> default of 1MB - is a "necessary cleanup", removing half broken buffer
> size limits
> 2. The patch series makes  /proc/fs/nfsd/max_block_size usable
> 
> IMO this qualifies the patch series for stable@

I'm curious - why do you want it in stable?
If you just want the functionality you can apply the patches yourself,
or ask your kernel vendor to do that for you.  What do you gain by
having us submit them to stable@?

Thanks,
NeilBrown

