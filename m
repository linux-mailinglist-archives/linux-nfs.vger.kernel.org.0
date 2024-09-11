Return-Path: <linux-nfs+bounces-6386-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC4C97559A
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Sep 2024 16:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B953288865
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Sep 2024 14:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8771A4E68;
	Wed, 11 Sep 2024 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBAYkM0h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5671A4B68
	for <linux-nfs@vger.kernel.org>; Wed, 11 Sep 2024 14:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065318; cv=none; b=MXtOlzWFKR+AyH7obnju9Fut2fev71JS6OZ8L+BEsquh/wI9huqX22tK+pqz5bLBdxlZaDmoiXkrwYLHjI5cxbzLOnHjjA6AviQGrFuQzZMW7QnIsgDNfM9k1WNWfXOnlwhkUmb+wjQtjRssRkUxySuRVjNIT19TlFS3chjzhUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065318; c=relaxed/simple;
	bh=39AD5qFCsU9CbuXaIPKWe/LVc2eFnFlhvMlHthgSWng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwUfpWVnwL8vhfUKtfD9OnD+cPpjH2Ww2/GcfPsHDIKz+XwRdW8O5zRNVylrkhmiW2bMRNfkHyt5J6Dlb69UgQUEd1P3XLkcvWExRuCduMF7PaeKxUv6BQNV+06O7LpC5K+lKufeEDVEP3rT+7UdpBmCSirkoN9W+OJfNMccqHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RBAYkM0h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726065316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dh33ZKSGjx1D9816tyr+OFwA7oLHb2kyr45366fT73I=;
	b=RBAYkM0htPmbXLGW+IyiRnu6PiziY5Kex4zf5gnrQMQcAP5fqZEl7UnkJwNCvLxbv5OzwC
	AZaXyNwtn1d6IUJTpQ65UVFLE2zx4jyfb3Exuqd9sx/uxFeeUu42ia/RN85T+hYFjpu/bh
	1SjDTFfMBoDqtBT1CKvHkgnyAzDA7HY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-auuMbs2wO1C7KRfm9GGt6w-1; Wed,
 11 Sep 2024 10:35:13 -0400
X-MC-Unique: auuMbs2wO1C7KRfm9GGt6w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86B7A1944AA6;
	Wed, 11 Sep 2024 14:35:10 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.7])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4070130001A1;
	Wed, 11 Sep 2024 14:35:07 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Aring <aahringo@redhat.com>, linux-nfs@vger.kernel.org,
 ocfs2-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 teigland@redhat.com, rpeterso@redhat.com, agruenba@redhat.com,
 trond.myklebust@hammerspace.com, anna@kernel.org, chuck.lever@oracle.com
Subject: Re: [PATCH 1/7] lockd: introduce safe async lock op
Date: Wed, 11 Sep 2024 10:35:04 -0400
Message-ID: <09892CFB-42BB-49FD-8D29-012C58721327@redhat.com>
In-Reply-To: <00b44eb3ce8ebdd76bfd81d653967d5e85910e11.camel@kernel.org>
References: <20230823213352.1971009-1-aahringo@redhat.com>
 <20230823213352.1971009-2-aahringo@redhat.com>
 <B38733D3-6F54-42DF-BD5B-716F0200314F@redhat.com>
 <1490adc3ae3f82968c6112bb6f9df3c3f2229b04.camel@kernel.org>
 <C158604C-DD07-49C9-8C7B-A9807CD71473@redhat.com>
 <00b44eb3ce8ebdd76bfd81d653967d5e85910e11.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11 Sep 2024, at 9:24, Jeff Layton wrote:

> On Tue, 2024-09-10 at 12:56 -0400, Benjamin Coddington wrote:
>> On 10 Sep 2024, at 11:45, Jeff Layton wrote:
>>
>>> Good catch. Yeah, I think that probably should have been an &&
>>> condition. IOW:
>>>
>>> 	if (nlmsvc_file_file(file)->f_op->lock &&
>>>             !export_op_support_safe_async_lock(inode->i_sb->s_export_op,
>>>
>>
>> Ah Jeff, thanks for confirming - there's been a bunch of changes in there that
>> made me uncertain.  I can send a patch for this, I'd like to rename
>> export_op_support_safe_async_lock to something like fs_can_defer_lock
>> (suggestions) and put the test in there.
>
> Actually, I take it back. The only callers that set
> export_op_support_safe_async_lock have ->lock as non-NULL, so that
> won't change anything, in practice.

*nod*

In trying to conjoin the export flag test with the f_op->lock test, I'm just
making a huge mess of layering violations.  The changes for NFSD are terrible.

Seems like we want an FOP_ flag for this, I might ask for one.  Wouldn't
other users like FUSE be interested?

Ben


