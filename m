Return-Path: <linux-nfs+bounces-11370-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33876AA4222
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 07:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8564C4282
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 05:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FAC1D7989;
	Wed, 30 Apr 2025 05:11:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C15EEC2;
	Wed, 30 Apr 2025 05:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745989885; cv=none; b=sww/BWpVh0KOsbxmIyZRQSlvMwmyjbM08f4vrje4v4AX+XKUzA8iXavTPYaOnk1zIHp6duqRsi3xSlPVG//Iw60Kej8SuD5MwHR6tIbJytILj93rE09S9EHXriN5bzheYX+p9X8rPWqCNbtGgAluKIZxC/MiDKmo+OFIOtSzkB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745989885; c=relaxed/simple;
	bh=GKAyAO70P54rBl2U+yYWKNPUj74H/O93+u3SMpe7dZg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=lfvHVNMPki1MghHOM/qaVw0Uhefe/4tnBkgY5Clrbemtq8BLmua/8p5ZVL2VQeQBsRaGBtzh+u8qf4xuM/Su0X03sa1wgoQN8g/EADBL+hXo13eQvwsO1a5cixfvdxQNRUudlLPh++frEQ83RwLvlFGw/SIW0M9dNJRT9DAYH3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1u9zj5-005J4L-MS;
	Wed, 30 Apr 2025 05:11:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: cel@kernel.org
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Anna Schumaker" <anna@kernel.org>,
 linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH v4 00/14] Allocate payload arrays dynamically
In-reply-to: <20250428193702.5186-1-cel@kernel.org>
References: <20250428193702.5186-1-cel@kernel.org>
Date: Wed, 30 Apr 2025 15:11:19 +1000
Message-id: <174598987938.500591.3903811314689386843@noble.neil.brown.name>

On Tue, 29 Apr 2025, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> In order to make RPCSVC_MAXPAYLOAD larger (or variable in size), we
> need to do something clever with the payload arrays embedded in
> struct svc_rqst and elsewhere.
> 
> My preference is to keep these arrays allocated all the time because
> allocating them on demand increases the risk of a memory allocation
> failure during a large I/O. This is a quick-and-dirty approach that
> might be replaced once NFSD is converted to use large folios.
> 
> The downside of this design choice is that it pins a few pages per
> NFSD thread (and that's the current situation already). But note
> that because RPCSVC_MAXPAGES is 259, each array is just over a page
> in size, making the allocation waste quite a bit of memory beyond
> the end of the array due to power-of-2 allocator round up. This gets
> worse as the MAXPAGES value is doubled or quadrupled.

I wonder if we should special-case those 3 extra.
We don't need any for rq_vec and only need 2 (I think) for rq_bvec.

We could use the arrays only for payload and have dedicated
page/vec/bvec for request, reply, read-padding.
Or maybe we could not allow read requests that result in the extra page
due to alignment needs.  Would that be much cost?

Apart from the one issue I noted separately, I think the series looks
good.

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown

