Return-Path: <linux-nfs+bounces-6299-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFF696F2F5
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2024 13:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86DDF1C21D90
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2024 11:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B861C9EC2;
	Fri,  6 Sep 2024 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PvZXtmKL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE312233B
	for <linux-nfs@vger.kernel.org>; Fri,  6 Sep 2024 11:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621850; cv=none; b=pCygH9jsOIofSH3GlNTixo+Q7J0Z0Ql1CyneQV8ld5lib9TSG2g/HhBeVGlsTG0U4rmV4wBMAmWyz0RfYPOb54B0mXAVZIoAY8iLgzs9+b4nU9k8Y0I/xVDPtu4H/m78K5N4HdMAqmeo0lNJm5OFat5S0iY+UekCTRzKkmUOSds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621850; c=relaxed/simple;
	bh=quQ02BPzKwGeHMB5/HiXQA1AThxnySxCLemaeN85UCQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aMSGJGc1HpgyMFraXj7rNjEvbDcf9xbPnaf0YGU2Pv1PLEwqtOU7GmNXnWRNFDQ1U07Hk2iulTtOHE1LYMB+eoXXB2sjQYNUj+pRw/KZxUCp4Ffav7RRzBwikvQjwXfMpENbDJNRUsfHjND0Xd2Kdn0eigjBKR9s6sMCj0gaMiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PvZXtmKL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725621848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Sh7NNRzd/yNJ6l4v6+y7Ry9bwNbYl8mvsIbShOjOiw=;
	b=PvZXtmKL5OHx8EjTNXEvuVeUzcfbStZ4q/YL9WOY3DTHVhIezUPE9ZSf4c7KVRsUW5vP1q
	2NNdo00HBkIRQryzqYNiZyq75tya506/Q6C3or7PLekVdTQSO6DMjpsuG+VuYvrLL96ZAX
	tCLG+nCK84Zp26XUQTwKyuhk2m0SjlU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-YoqNuUw4N1KYGO138DZNNQ-1; Fri,
 06 Sep 2024 07:24:05 -0400
X-MC-Unique: YoqNuUw4N1KYGO138DZNNQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 389EB1955F68;
	Fri,  6 Sep 2024 11:24:03 +0000 (UTC)
Received: from [10.45.224.222] (unknown [10.45.224.222])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 096C23000236;
	Fri,  6 Sep 2024 11:23:59 +0000 (UTC)
Date: Fri, 6 Sep 2024 13:23:57 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Tejun Heo <tj@kernel.org>
cc: Mike Snitzer <snitzer@kernel.org>, Eric Biggers <ebiggers@kernel.org>, 
    dm-devel@lists.linux.dev, Alasdair Kergon <agk@redhat.com>, 
    Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, Sami Tolvanen <samitolvanen@google.com>, 
    linux-nfs@vger.kernel.org
Subject: Re: sharing rescuer threads when WQ_MEM_RECLAIM needed? [was: Re:
 dm verity: don't use WQ_MEM_RECLAIM]
In-Reply-To: <ZtpcI-Qv_Q6g0Q6Z@slm.duckdns.org>
Message-ID: <9d380772-6287-b75d-2d4d-e1c9a69ea981@redhat.com>
References: <20240904040444.56070-1-ebiggers@kernel.org> <086a76c4-98da-d9d1-9f2f-6249c3d55fe9@redhat.com> <20240905223555.GA1512@sol.localdomain> <ZtpATbuopBFAzl89@kernel.org> <ZtpcI-Qv_Q6g0Q6Z@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4



On Thu, 5 Sep 2024, Tejun Heo wrote:

> Hello,
> 
> On Thu, Sep 05, 2024 at 07:35:41PM -0400, Mike Snitzer wrote:
> ...
> > > I wonder if there's any way to safely share the rescuer threads.
> > 
> > Oh, I like that idea, yes please! (would be surprised if it exists,
> > but I love being surprised!).  Like Mikulas pointed out, we have had
> > to deal with fundamental deadlocks due to resource sharing in DM.
> > Hence the need for guaranteed forward progress that only
> > WQ_MEM_RECLAIM can provide.

I remember that one of the first thing that I did when I started at Red 
Hat was to remove shared resources from device mapper :) There were shared 
mempools and shared kernel threads.

You can see this piece of code in mm/mempool.c that was a workaround for 
shared mempool bugs:
        /*
         * FIXME: this should be io_schedule().  The timeout is there as a
         * workaround for some DM problems in 2.6.18.
         */
        io_schedule_timeout(5*HZ);

> The most straightforward way to do this would be simply sharing the
> workqueue across the entities that wanna be in the same forward progress
> guarantee domain. It shouldn't be that difficult to make workqueues share a
> rescuer either but may be a bit of an overkill.
> 
> Taking a step back tho, how would you determine which ones can share a
> rescuer? Things which stack on top of each other can't share the rescuer cuz
> higher layer occupying the rescuer and stall lower layers and thus deadlock.
> The rescuers can be shared across independent stacks of dm devices but that
> sounds like that will probably involve some graph walking. Also, is this a
> real problem?
> 
> Thanks.

It would be nice if we could know dependencies of every Linux driver. But 
we are not quite there. We know the dependencies inside device mapper, but 
when you use some non-dm device (like md, loop), we don't have a dependecy 
graph for that.

Mikulas


