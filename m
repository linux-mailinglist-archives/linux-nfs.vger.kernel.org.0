Return-Path: <linux-nfs+bounces-12142-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 287CDACF696
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 20:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A2F3AEFE7
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 18:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD5C18A6AE;
	Thu,  5 Jun 2025 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYic31+9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF37A17A317
	for <linux-nfs@vger.kernel.org>; Thu,  5 Jun 2025 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749148257; cv=none; b=jEow7XGLkVjMuAJKaqkEPB2NuNW4v8j1YBSefe4RzyzGve9yTe39JzNaW50+R7KIiKFRB0IoNfnt/02Yzn7f+H1LrklAu8uGquW+EZl3d4YRmkSBuSJiBvbQMZh4lb7k/khjAyC3EUuZPHQhvNgeOwE0cBokWeHAVjrNQOyOzAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749148257; c=relaxed/simple;
	bh=s/YuY4hj4Alqj9IG61dyK5CiCRi8cXfzgpTaGrn8lBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hfauwQ2DMImmDAsN5XtZmN//E7urQ4nt1prDPd/dL/ZScBd8wn6vHGOhwmvnvAc55xbjKQOgaoHaZEZ4Zak0gPH8D3GEZiuNQ7eoxuirRTEaT/t4Mk34GTTax2NN5JClgwieQ1GtquRoJX4vrUx+WLXzQvddITk0HRyiB38UuDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aYic31+9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749148254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YJtdc+jRnfYkAGziDfNnb4V5NXkApH0YXwX5d1GvxlU=;
	b=aYic31+9ewRtj0qiWczqebCRs7R5aSRbNi5+nyh9Y84Y/knAmf4oszc4CN+kFA8DnQC3eH
	8aZujX2/WiJL6i9wRrWFGH0d60kSLjfgQp2+N1kOOBtKFpPoUG9ACSpGwAPx97l4FLmx8B
	v4bHcj6w0xgmevNma96uBvCJrlM5HJw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-QEl7K9hnOyuVvxzncTP6rg-1; Thu,
 05 Jun 2025 14:30:51 -0400
X-MC-Unique: QEl7K9hnOyuVvxzncTP6rg-1
X-Mimecast-MFC-AGG-ID: QEl7K9hnOyuVvxzncTP6rg_1749148249
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADA0419560B1;
	Thu,  5 Jun 2025 18:30:49 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D1C830002D1;
	Thu,  5 Jun 2025 18:30:47 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: trondmy@kernel.org, anna@kernel.org, jlayton@kernel.org, neilb@suse.de,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Cleanup/fix initial rq_pages allocation
Date: Thu, 05 Jun 2025 14:30:45 -0400
Message-ID: <52C7396E-E5D5-48BA-82FA-A5B92EECA46A@redhat.com>
In-Reply-To: <272781a5-bbe8-4181-972f-4b76eb93b1ee@oracle.com>
References: <458f45b2b7259c17555dd65aa7cdbbf1a459d5e6.1749131924.git.bcodding@redhat.com>
 <cdb4ce81-c05f-4e60-b351-34d713a51e96@oracle.com>
 <80457CF6-99FE-4EB5-BC07-F4A8D9A8D8D1@redhat.com>
 <272781a5-bbe8-4181-972f-4b76eb93b1ee@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 5 Jun 2025, at 14:08, Chuck Lever wrote:

> On 6/5/25 12:54 PM, Benjamin Coddington wrote:
>> On 5 Jun 2025, at 10:26, Chuck Lever wrote:
>>
>>> This doesn't apply to v6.16-rc1 due to recent changes to use a
>>> dynamically-allocated rq_pages array. This array is allocated in
>>> svc_init_buffer(); the array allocation has to remain.
>>
>> Well, shucks.  I guess I should be paying better attention.
>>
>> Can we drop the bulk allocation in svc_init_buffer if we're just going to
>> try it more robustly in svc_alloc_arg?
>
> Maybe!

Ok, I'll send something.

> I would like to understand the failure a little better. Why is mount
> susceptible to this issue?

For v3, we're starting lockd, and on v4.0 it's the callback thread(s).  It's
pretty easy to reproduce if you bump the cb threads to something insane like
64k.

Customers have a really hard time handling this on autofs, its not
like the system just booted - instead the system will be up for long periods
doing work, then the automount fails requiring manual intervention.

I think the bulk allocator can be pretty sensitive to some conditions which
cause it to bail out and only return a single page.

Ben


