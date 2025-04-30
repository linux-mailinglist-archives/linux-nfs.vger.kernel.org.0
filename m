Return-Path: <linux-nfs+bounces-11378-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 208ECAA57EC
	for <lists+linux-nfs@lfdr.de>; Thu,  1 May 2025 00:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B99D500F08
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 22:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BB022370D;
	Wed, 30 Apr 2025 22:16:23 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BFC1E5B9D
	for <linux-nfs@vger.kernel.org>; Wed, 30 Apr 2025 22:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746051383; cv=none; b=X5calcxsXh66TKNrDm4LBWXsT1GJ0xdBZeFHc1CN4QiSjeIp38+F0DetZLj3vgAPRg9q3zUctc59rDejY2etN7yp6JmUEawk42C6T7gxd6F677Yu/1A+fPuyLefZHOhnwJ/t6/UXEKgLYJRgs9T2XndChpby47OebIHb+5J9k60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746051383; c=relaxed/simple;
	bh=imS45qgmovMVpYu77dz+tcXDM+gNjmsjY0ymL2cEtL0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=fp1oWqaIUBdDPDt6fykbwcq/of/4IYgGWhnB0G68S2ouYPrSr8UdSqbJhQojZCluQmsVXpM60+w/ejCqsf22T6HEMD9kms/juIUYd+sdABOeD7mbsxbaGV3makezscZo5qFQtDoJGpqvSE8GqoFP55F/W6djoNHCh98+uYy+Mew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uAFj0-006LAC-P8;
	Wed, 30 Apr 2025 22:16:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>,
 "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH 6/6] nfs_localio: protect race between nfs_uuid_put() and
 nfs_close_local_fh()
In-reply-to: <aBKGFyDerAQ1KQL7@kernel.org>
References: <>, <aBKGFyDerAQ1KQL7@kernel.org>
Date: Thu, 01 May 2025 08:16:18 +1000
Message-id: <174605137852.500591.8001268434351161300@noble.neil.brown.name>

On Thu, 01 May 2025, Mike Snitzer wrote:
> FYI, If I remove that WARN_ON I then get this when tearing down NFSD
> within a container:
>=20
> [  295.192357] percpu ref (nfsd_net_free [nfsd]) <=3D 0 (0) after switching=
 to atomic

Thanks.  I'll look into that.
I do hope to make time for some testing next week, but having promised
patches and as time was dragging on (it hasn't been my highest priority)
I thought it would be good to post what I had once I was happy with the
overall approach.

Thanks for testing!
NeilBrown

