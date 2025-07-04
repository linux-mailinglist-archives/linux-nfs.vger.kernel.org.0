Return-Path: <linux-nfs+bounces-12892-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690EAAF898E
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 09:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA3E6E62CB
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 07:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6D527FB29;
	Fri,  4 Jul 2025 07:27:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E91B27F4C7;
	Fri,  4 Jul 2025 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751614041; cv=none; b=BXl97RqJwHFk9mahFQ+j6vgtltcTRVJ3khJbfBtZFrjKdUEJ7ds0lNW0IKwdtB9HK+27EDRimX8w9pETl8wBP2FoHxajVhIWMu160sbBcdNtvqdGYAJu5/AJbl0sdMqnXSDtvjSNi7DXm81P4M8VUfvi6i+v95BgKsw2Wy7pzes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751614041; c=relaxed/simple;
	bh=75akYgfqgs6qlyVaSls04E6YMuaVPNl5AA/1fc/UovQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=VU/sRRiENLO0TXMY0MH1VMxyLHLVmYldcqu63nFuYiykS5t9Fd13vV3pntD2l6TVEKGuneVeUgVXhRaMR44HsL8D1UURViLQvNyYApSwDLD+9fAK5XOhh+LapdPGcPtpnXYtYfXyG0wEwV/1eA17Rhl1Rs6qirJ2zJALDlJPMFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uXaot-001k4N-UR;
	Fri, 04 Jul 2025 07:26:51 +0000
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
Subject: Re: [PATCH RFC 2/2] nfsd: call generic_fadvise after v3 READ, stable
 WRITE or COMMIT
In-reply-to: <175158625070.565058.13878074995107810351@noble.neil.brown.name>
References: <20250703-nfsd-testing-v1-0-cece54f36556@kernel.org>,
 <20250703-nfsd-testing-v1-2-cece54f36556@kernel.org>,
 <175158625070.565058.13878074995107810351@noble.neil.brown.name>
Date: Fri, 04 Jul 2025 17:26:50 +1000
Message-id: <175161401003.565058.4274944923143864883@noble.neil.brown.name>

On Fri, 04 Jul 2025, NeilBrown wrote:
> 
> Otherwise it makes sense for exploring how to optimise IO.
> 
> Reviewed-by: NeilBrown <neil@brown.name>

Actually - I take that back.  generic_fadvise() is the wrong interface.
It is for filesystems to use if the don't have any special requirements,
and for vfs_fadvise() to use if the file system hasn't give a function
to use.

nfsd should be calling vfs_fadvise().

NeilBrown

