Return-Path: <linux-nfs+bounces-6675-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D4A98856B
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Sep 2024 14:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5748C1C24BCA
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Sep 2024 12:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1066718D621;
	Fri, 27 Sep 2024 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CX7Mm7mb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144AC18C90F
	for <linux-nfs@vger.kernel.org>; Fri, 27 Sep 2024 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727441055; cv=none; b=VYDPn2gOTHBoP4MjXOG6XZVwjLHR5HzMTHmdQ7i1pzt9CK2lpF+77t5usQhiNVmJoFPU7CsfiAP9/IfGeqswzL4mwhhdWo7O+uSNUcYiGsP/uw9fSGkNFq8JbgxwAmBQ+DWfQO60XPB+cYhPdmCsM3s66pfE41x7mZFCsO9tu7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727441055; c=relaxed/simple;
	bh=mOi+QVnVecw+smLdF9Kes4AGgPx9G/MOtBZOC7yoslg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lO4eQATz8XhtjueNcFFci0Xrvh0SAsvtAOhNKeCGuwLTif1wLGjAdyil4ZwCpRbHQX2JNaioPOhhrzVKFoEZaAgP/IExq2qUvxJbkUbryvXqMYnWNZhC4EFY2Vzgu1HCoavC3TOgGYI8d/Avg2OaIkOzXdskF4x6PCQkteQkt6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CX7Mm7mb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727441051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fprYQELYW86um0EMrG5RiK9/nL4dPOc6NN3Oq433snw=;
	b=CX7Mm7mb0ecvIvaDpPRf/rQ1QCnR1jffcUHDF/8ZQyCdzDaDIKe+xvcI0AepAVWy66EG2x
	FnPKdAooknep/k+l7KBq3edpK7VXuQi8aFwEpaX9iseaJjVMVtwNi608d9NdRr4OhtxgOo
	d4CTnfYNTZBSxI79UxzUyEeX7gJE06Q=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-gnt3wwD9NC-DGD1nMR4pUQ-1; Fri,
 27 Sep 2024 08:44:10 -0400
X-MC-Unique: gnt3wwD9NC-DGD1nMR4pUQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21B101903097;
	Fri, 27 Sep 2024 12:44:08 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF77C1954B0E;
	Fri, 27 Sep 2024 12:44:05 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: NeilBrown <neilb@suse.de>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: fix delegation_blocked() to block correctly for at
 least 30 seconds
Date: Fri, 27 Sep 2024 08:44:03 -0400
Message-ID: <565B02C5-8711-4B3D-90E8-08E39D7E337D@redhat.com>
In-Reply-To: <172644946897.17050.6911884875937617912@noble.neil.brown.name>
References: <CACSpFtDNpOMfRt1Msbo4XNaja5_Nuhxd5Vs51UvjCap5Z9-wLg@mail.gmail.com>
 <172644946897.17050.6911884875937617912@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 15 Sep 2024, at 21:17, NeilBrown wrote:

> On Thu, 12 Sep 2024, Olga Kornievskaia wrote:
>
>> I wouldn't discount these operations (at least not rename) from being
>> an operation that can't represent "sharing" of files. An example
>> workload is where a file gets generated, created, written/read over
>> the NFS, but then locally then transferred to another filesystem. I
>> can imagine a pipeline, where then file gets filled up and the
>> generated data moved to be worked on elsewhere and the same file gets
>> filled up again. I think this bug was discovered because of an setup
>> where there was a heavy use of these operations (on various files) and
>> some got blocked causing problems. For such workload, if we are not
>> going to block giving out a delegation do we cause too many
>> cb_recalls?
>
> A pipeline as you describe seem to be a case of serial sharing.
> Different applications use the same file, but only at different times.
> This sort of sharing isn't hurt by delegations.
>
> The sort of sharing the might trigger excessive cb_recalls if
> delegations weren't blocked would almost certainly involve file locking
> and an expectation that two separate applications would sometimes access
> the file concurrently.  When this is happening, neither should get a
> delegation.
>
> The problem you saw was really caused by a delegation being given out
> while the rename was still happening.
> i.e.:
>   - the rename starts
>   - the delegation is detected and broken
>   - the cb_recall is sent.
>   - the client opens the file prior to returning the delegation
>   - the client gets a new delegation as part of this open
>   - the client returns the original delegation
>   - the rename loops around and finds a new delegation which it needs
>     to break.
>
> The should only loop once unless the recall takes more than 30 seconds.
> So I'm a bit perplexed that it blocked lock enough to be noticed.  So
> maybe there is more going on here than I can see.  Or maybe the recall
> is really slow.

When the server's local rename process calls __break_lease(), it only calls
fl_lmpops->lm_break() once and sets FL_UNLOCK_PENDING.  After that it will
sleep and wake to check, but never again call ->lm_break() (which will cause
knfsd to recall the delegation).

The check for leases_conflict() is not stateful.

Ben


