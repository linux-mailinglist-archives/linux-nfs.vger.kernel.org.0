Return-Path: <linux-nfs+bounces-12870-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B857AF6683
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jul 2025 02:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF4A4E8099
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jul 2025 00:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485181876;
	Thu,  3 Jul 2025 00:12:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED67136E;
	Thu,  3 Jul 2025 00:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751501533; cv=none; b=ezKhjQftYgLgIy57E0gXIwM9EvO/fGMo8v6ynsFpefLijvX81b/inuQ8ia5G7fublmMkTFbf/nyb2F9LzjXHOPNs0OJknQko47zenu1o2OlBK7cDezrk6zHyA2nEVdv5hYDHYEsbYSzfEnqHv/sY3Jvxx2rONW8ozJ4oTcBJMHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751501533; c=relaxed/simple;
	bh=EzTaJbTBwS6sr+YwdKRlnurveNvCRmdGaQL0dw6JdTs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=BqvH+QB1MaVgS1n2U82imYSwiqNgDirfUjzU07UWWk12JRi2K2vxT+DnttT779BC8APlnQzXl0BEdrtMhRlKpCh6wISVSUQpOEy8lzLMVVvhybcO8lXMagJEbqpKHJUycJIOUKKjIM3Xevu6k+jShNzx24jaWW6P3J5VtJl9LuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uX7Yc-00H9mP-V4;
	Thu, 03 Jul 2025 00:12:07 +0000
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
Cc: "Mike Snitzer" <snitzer@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Jens Axboe" <axboe@kernel.dk>
Subject: Re: need SUNRPC TCP to receive into aligned pages [was: Re: [PATCH
 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE for all IO]
In-reply-to: <110c7644b829ce158680979e6cd358193ea3f52b.camel@kernel.org>
References: <>, <110c7644b829ce158680979e6cd358193ea3f52b.camel@kernel.org>
Date: Thu, 03 Jul 2025 10:12:06 +1000
Message-id: <175150152640.565058.13872428130182626290@noble.neil.brown.name>

On Thu, 12 Jun 2025, Jeff Layton wrote:
> 
> I've been looking over the code today. Basically, I think we need to
> have svc_tcp_recvfrom() receive in phases. At a high level:
> 
> 1/ receive the record marker (just like it does today)

Long ago (IETF 47??) I heard someone talking about a "smart" network
card that would detect UDP packets to port 2049, split the data into the
largest power-of-2 as a final component and the remainder as a header,
and DMA them into memory that way.  This would very often put the data
in page-aligned memory.

We could do the same thing here.
Currently we copy as much as will fit into the "header" and the rest
into the "pages".  We could instead use power-of-2 maths to put some in
the header and a whole number of pages into the "pages".

This would probably work well for NFSv3 and shouldn't make NFSv4 worse
It wouldn't provide a guarantee, but could provide a useful
optimisation.

NeilBrown

