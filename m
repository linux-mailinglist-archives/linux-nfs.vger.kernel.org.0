Return-Path: <linux-nfs+bounces-12862-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C43AF63DC
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jul 2025 23:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298951C44002
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jul 2025 21:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B152376FF;
	Wed,  2 Jul 2025 21:22:16 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68AF2367DA
	for <linux-nfs@vger.kernel.org>; Wed,  2 Jul 2025 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751491335; cv=none; b=bKWnwuR0QzpuflsQLQXiISsoBEqgfD7tsCSF5CB2AUHgBDQL+s1GcIEb2zKE1Kxp99+jApy5q9FdC0fjGCiOthxh5DWJPEBx3/r39n9SgY2ZqEZyv6E1SUl80P4wQcWBLmR1erhTZZAenA3TZn+UjGjkP9HHVe83bBWa/TOKr8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751491335; c=relaxed/simple;
	bh=n1kX3MvTuDncf1WSZtpg1O1LZp2wVPdPz8Ri6mBLPDY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=FRGaZQYI41D4mMPHPGvkAK+3lkRtNzquuWjog2/6XN20n6iXvnfBFW3XCv0Ac1d+dkcRiLaq7pnm/SF2yMW1rkuvLKR+mDXXP9pZYkUF+Me38JUL45Hmo9qlOc01ARMwy/SkBkG97dPuO0Ao8fhprBU6GOpxmi7Kj8nUZYhlAUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uX4u1-00H2T3-Lq;
	Wed, 02 Jul 2025 21:22:01 +0000
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
Cc: linux-nfs@vger.kernel.org, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Li Lingfeng" <lilingfeng3@huawei.com>
Subject: Re: [PATCH RFT v2] nfsd: provide locking for v4_end_grace
In-reply-to: <2ed77c1d-787c-4abf-96c2-72821e73d565@oracle.com>
References: <175136659151.565058.6474755472267609432@noble.neil.brown.name>,
 <2ed77c1d-787c-4abf-96c2-72821e73d565@oracle.com>
Date: Thu, 03 Jul 2025 07:22:01 +1000
Message-id: <175149132125.565058.15666202434202898775@noble.neil.brown.name>

On Wed, 02 Jul 2025, Chuck Lever wrote:
> Hi Neil, handful of nits below.
> 
> > 
> > [[ 
> >  v2 - disable laundromat_work while _init is running as well as while
> >  _exit is running.  Don't depend on ->nfsd_serv, test
> >  ->client_tracking_ops instead.
> > ]]
> 
> Do you want the patch change history to appear in the commit log?
> Asking because that is not usual practice.

Not really.  I'll send something new, likely tomorrow morning.
What do you think is the best way to handle backporting?  Should I
submit the version that doesn't use disable_delayed_work(), then add a
patch which changes to use that instead of a flag ?

Thanks,
NeilBrown

