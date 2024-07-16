Return-Path: <linux-nfs+bounces-4956-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F276932FFA
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2024 20:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBDBE1F22794
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2024 18:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF431865A;
	Tue, 16 Jul 2024 18:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/ULtfG1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDDB18059
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jul 2024 18:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154680; cv=none; b=uj4IPYWypRMF/MNJM6ASGD8/jKD3Pf6+84uayNjkvgpoxA1fw6JE0UQYGnkHvPVN64DWTEFXrLIeVDFpxmcJieIoR8AbcHwcrLn2mb5ugrCJgo/mT/5CysMWlpUpefQB4J0qPR8JnC/SVGqlBkrdRGF681ol+lK69GGgNHrmY7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154680; c=relaxed/simple;
	bh=gr+fZb6dXYqD9ZudNb8HGzxxKek75rE0t3yObXHmkDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6CSFEsW4NyBOjONXTjphnHicqtitUoSklZ43H1zSvDS+6RNFtugBgMdwjPZ3pnGET0G4c2aG6O1QicFGbJL2VQflBOpMqCMnuGlhdDrc4urF468fQ+iublYb9eWIjjHvu1IPEXqBLiBFjNzOnH6SCYWiXxx+wUhkfLEt1rl3n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K/ULtfG1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721154677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ims0/z4jYM8mlGV4fSqmUamDmtj7VNDrWWTKX17nNZM=;
	b=K/ULtfG1AmPjOTqBFDhETw1ksL5tWaidUVLEYkLOUILV7ZwvPXr8ommW+8h78fuWDhMTQN
	UO7Ah/7mko+2/VJbsVYZoeCxnzFHlwZ4OA1PQK5rybfMqvs/PvbIdynW1fsP7BShGz/jlb
	ni4jt4988aNJZfoxMbK8SzQSoxMfveE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-3-LQ26cUMvq6jkrVbUHHFA-1; Tue,
 16 Jul 2024 14:31:15 -0400
X-MC-Unique: 3-LQ26cUMvq6jkrVbUHHFA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 887861955D48;
	Tue, 16 Jul 2024 18:31:14 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.8])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5C7B1955D4D;
	Tue, 16 Jul 2024 18:31:13 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: anna@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Fix a race to wake a sync task
Date: Tue, 16 Jul 2024 14:31:11 -0400
Message-ID: <665C64EF-0064-4323-A80A-C09E564BB702@redhat.com>
In-Reply-To: <ec46c3fd5521611241a6da493e22f2676d4d134a.camel@hammerspace.com>
References: <4c1c7cd404173b9888464a2d7e2a430cc7e18737.1720792415.git.bcodding@redhat.com>
 <2525dfa8b9a5539a51109584bf643dcbdcc5f1a0.camel@hammerspace.com>
 <0DFB851E-CEC5-45DC-8C61-CEE6D6DCC9FD@redhat.com>
 <b8b9fa14bce200fc65545b4c380ece3275e13677.camel@hammerspace.com>
 <58D7782A-5CA2-4D2E-9817-28878EAECF02@redhat.com>
 <ec46c3fd5521611241a6da493e22f2676d4d134a.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 16 Jul 2024, at 12:32, Trond Myklebust wrote:
> So let's just replace rpc_clear_queued() with a call to
> clear_bit_unlocked(). That still ends up being less expensive than the
> full memory barrier, doesn't it?

Yes.  But unless you really want to go this direction, I'll keep testing
your first suggestion to use smp_mb__after_atomic().  That should do the
same thing but also allow us to skip the memory barrier for async tasks.

Ben


