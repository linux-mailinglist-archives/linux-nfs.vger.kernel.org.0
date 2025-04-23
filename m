Return-Path: <linux-nfs+bounces-11259-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0380CA99B49
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Apr 2025 00:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5E21B683A8
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 22:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8415D1F418D;
	Wed, 23 Apr 2025 22:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTF6EUOR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37911EFF89
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 22:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745446354; cv=none; b=uFOYobhtj8b65XzGQOXn6vOktIYrOLNAmCFFfgjVKY41JwdbFwzVrYi74/VYdCrFOycuWKhZoqGMZoMmrVdAnGTjT+ayCFrrmn/wp4GApyqTgXwnR1j6On8/AOiMliEQyxigzxZD7KnnV3bvn3nMtFwLJt+rWGv+brS5OZfcz48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745446354; c=relaxed/simple;
	bh=EE7avwaugYW5EydaIr9DYGMgsDcuoaFyR5xBpPbTeiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GgY3obqFr3skClVDjXxs35rBVt8obn9niBAuR/M2vt9vJ1L3UB4i9TNqKeiqwy0R2Z8SMzxI4XlFQ+g+PVErqmUB9XY+eI7sz0E2Q8X2s304qKnuoYZY5TGzTkqq+crhGOBLZPB96udS20NrkLSW2e8Nrxru8jIlEGquKLSLCJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DTF6EUOR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745446350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0aaHh2wpA1lG/r2WwHys49n/1rtTJjnyCleJAEnKrtQ=;
	b=DTF6EUORrT4pkvu88UJahAL10o5elRqJ272Ydu/uPSnm/OpJuQekWwp+ZAMpYwH1h7Er2P
	OAvP7n0yi/dDj2M5glb/jdTRfkp5XfmIKhv+Vr7FHjvG/pGR87+6ZszEiJ7ZcT8DWIExwF
	QU9Xwe3+jcfqMfE8gb4Vzs1ATTdFD18=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-EerDZ8HPNOGVf5OKu_jgrg-1; Wed,
 23 Apr 2025 18:12:28 -0400
X-MC-Unique: EerDZ8HPNOGVf5OKu_jgrg-1
X-Mimecast-MFC-AGG-ID: EerDZ8HPNOGVf5OKu_jgrg_1745446347
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDE811800874;
	Wed, 23 Apr 2025 22:12:26 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.16])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE73F180047F;
	Wed, 23 Apr 2025 22:12:25 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFSv4: Allow FREE_STATEID to clean up delegations
Date: Wed, 23 Apr 2025 18:12:23 -0400
Message-ID: <16EB6EFA-01A4-4289-AD40-AEA9DEA501E9@redhat.com>
In-Reply-To: <6fe721ba67cc176f8c9befd13249b08e6b83c704.camel@kernel.org>
References: <cover.1745430006.git.bcodding@redhat.com>
 <e8c113d33be1bf52016b6b747330eec5c17dc948.1745430006.git.bcodding@redhat.com>
 <f768ca3c27d1b0e6934a7ec319fa2ea9d0778b07.camel@kernel.org>
 <FF36159B-E39E-4391-9955-394249FF27F6@redhat.com>
 <6fe721ba67cc176f8c9befd13249b08e6b83c704.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 23 Apr 2025, at 16:37, Jeff Layton wrote:

> On Wed, 2025-04-23 at 15:59 -0400, Benjamin Coddington wrote:
>> On 23 Apr 2025, at 15:41, Jeff Layton wrote:
>>
>>> On Wed, 2025-04-23 at 13:59 -0400, Benjamin Coddington wrote:
>>>> @@ -10612,6 +10610,7 @@ static int nfs41_free_stateid(struct nfs_server *server,
>>>>  	if (IS_ERR(task))
>>>>  		return PTR_ERR(task);
>>>>  	rpc_put_task(task);
>>>> +	stateid->type = NFS4_FREED_STATEID_TYPE;
>>>
>>> Would it be possible to call nfs_delegation_mark_returned() at this
>>> point, and skip all of the type changing?
>>
>> It won't because we can be here with a lock stateid or open
>> stateid.
>>
>
> Ok, I can see why you decided to do it this way, and since we already
> have a REVOKED and INVALID types, adding FREED doesn't seem that bad.
>
> If you do go this route, then I think you also need to add the FREED
> case to the switch in nfs41_test_and_free_expired_stateid().

It's a good idea, it can't hurt, but I think its not possible to end up with
a delegation (or other type) that has a stateid with that type.  We're just
setting that type on the stack copy that we use for the
test_stateid/free_stateid operation, and then its discarded.

Ben


