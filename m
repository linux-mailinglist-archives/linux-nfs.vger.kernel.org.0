Return-Path: <linux-nfs+bounces-8153-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C59EA9D3E2A
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 15:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AB83281F4F
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 14:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385741D7E50;
	Wed, 20 Nov 2024 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcruR5rI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A601C4605
	for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114123; cv=none; b=mV3mn90fipGWHjpYTzKNatJ3ssU8KEitJIK++/QZgmqnhLoaSgYLKBIPx5T2mfVoXmRD23h5lRGHzRERsficyrSNgIXOK4CqnLMFQNnOLflzx56VXjbrZ++e8J9UYfdeUB28hqDvuQF+rxr76vi3gXa4PmF+dBm6fdTf7af+GSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114123; c=relaxed/simple;
	bh=I+hQZKjreKxwjowErKOlxiY+/i3CXi46MiDFLl4fAkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ti0QA9VSgzAseD8iRuvtDo9X5EqwFoEuK6crREcS4IMUTWuIeJboHTyWALx64RGwePj4AwdtAH1YDmf7Ahm6Yt6lUlBo3GWjy9oXs5iUXvQIs6lqwXZxkboT1K68qHuP/cJ/+Gr9N7t0j9WLjGPvBrbttrk2dmMrmPlZ1fQguEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GcruR5rI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732114120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rmjF4dSb4R7tFvbYuuUCRFHsMqe91P3IOmmuwpAZ6Ds=;
	b=GcruR5rI8RlEVGuT2UDAKhNjOB7c+/ty3CNfXs9ADmMiugsnfTPa1sad8pYBKq3ZB+fKwk
	xiuxmUf4ZXhJcQxADAn+ZciJoel6steP/+q9uRiXIuIFUO/CHiJ87rImh0u0rAKl+XHxbn
	+oo05I0Sk3aCoA8tOnm1xMx7e2lIIhk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-BGs_kDyJN8Wwk8VtwBDmXw-1; Wed,
 20 Nov 2024 09:48:36 -0500
X-MC-Unique: BGs_kDyJN8Wwk8VtwBDmXw-1
X-Mimecast-MFC-AGG-ID: BGs_kDyJN8Wwk8VtwBDmXw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4B831956057;
	Wed, 20 Nov 2024 14:48:35 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0487F195DF81;
	Wed, 20 Nov 2024 14:48:34 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: Steve Dickson <steved@redhat.com>,
 Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH V2] nfs(5): Update rsize/wsize options
Date: Wed, 20 Nov 2024 09:48:32 -0500
Message-ID: <CD3179D3-2A80-4611-8370-E5DEAD776D61@redhat.com>
In-Reply-To: <CALXu0UddnDfi1sF6W5Ca8a9Zzjxad3JNgCQXkmpVuoJyBPLGhw@mail.gmail.com>
References: <20241119165942.213409-1-steved@redhat.com>
 <CALXu0UddnDfi1sF6W5Ca8a9Zzjxad3JNgCQXkmpVuoJyBPLGhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 20 Nov 2024, at 2:57, Cedric Blancher wrote:

> On Tue, 19 Nov 2024 at 18:07, Steve Dickson <steved@redhat.com> wrote:
>>
>> From: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
>>
>> The rsize/wsize values are not multiples of 1024 but multiples of the
>> system's page size or powers of 2 if < system's page size as defined
>> in fs/nfs/internal.h:nfs_io_size().
>>
>> Signed-off-by: Steve Dickson <steved@redhat.com>
>
> REJECT. As discussed, this is the WRONG approach.

I am astounded that this response keeps appearing, we must have some
fundamental inability to understand each other.

> The pagesize is not not easily determinable (/bin/pagesize not even being
> part of the default install), and the page size is flexible on many
> architectures.  rsize/wsize depending on the page size makes this option
> non portable across platforms, or even same platforms with different
> default pagesize settings.

Why do you need to determine the page size to set this option?  You are
incorrect when stating that rsize/wsize depends on the page size.

As I explained before, one does not need to know the page size to set this
mount option.  The kernel takes the desired size and rounds down to the
current system's page size.

> In real life, this can prevent puppet from working for NFS root, if
> NFS root needs rsize/wsize, and someone switches the default page
> size.

What does "prevent puppet from working" mean?
Please show a real example of this problem that requires a kernel fix.

> I thought the correct fix would be to fix the NFS client to count in
> kbytes as documented, and round up/down to the pagesize.

What problem are we fixing?  Currently, the only non-hypothetical issue is
that the man page is incorrect.

Ben


