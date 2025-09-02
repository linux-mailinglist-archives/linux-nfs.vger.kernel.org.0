Return-Path: <linux-nfs+bounces-13973-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BEAB4010E
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 14:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5AB87B275F
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 12:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388BD299A84;
	Tue,  2 Sep 2025 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRG9tPP3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7FC235362
	for <linux-nfs@vger.kernel.org>; Tue,  2 Sep 2025 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817033; cv=none; b=BIfS0qBmigxDi65uP9hWe1wKyiFN76Ko2Wf2HuWwLQWD3/4gu7ZUKeABG5Y07Nepzf3JzjVnICpEMy6iySxPeFSVSSHozCteE3IdHNVUZ94mqAXkcAwPOX+E+zARLdCJ+i5UovVIlpNMWPT7dRPkOlkL6A7E8MgLVpntx4ucuDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817033; c=relaxed/simple;
	bh=+WhR+RA6JwR3UGmFAXkMHKFnP9oHmn1Ndv3Efm9U3cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ca+xjJJCwDArbmYoqA8ynyY6ClfEaGMtD3zw3OPmqQpOXykNvk9R7JOWjE0v2d7pAc4FOVnpMzEnyBc+BPoPSgpOpLM6XHNPU/rKfcNtnLxN1Eagfo3AboPzLM9TmPpQ0MN6loFu6u3DLY28+0xvzolwBIkzFSBLgUBKl1xhcbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dRG9tPP3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756817030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XSaidwRfX/g8JExN5uC8H0O0g1Gl4tVmEgdov4ZkSiA=;
	b=dRG9tPP3gZZm8y12faNc52hJPI4+4LSHlr0PAhQsfySYcR1raQreV/EdZ0IR/A+SPsNT8o
	A0z8B+Y2sjnOZmcFqzXszYeto2iTGF5kAzB2Z8W3KG1Ijrzye8nma5T2D0swtg6tZIMK81
	XnnalpUUjSxximP+DUYmDzgJhnpdE5M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-K5tPRAanPciI3pHtU2QcQA-1; Tue,
 02 Sep 2025 08:43:45 -0400
X-MC-Unique: K5tPRAanPciI3pHtU2QcQA-1
X-Mimecast-MFC-AGG-ID: K5tPRAanPciI3pHtU2QcQA_1756817023
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A23AD195E906;
	Tue,  2 Sep 2025 12:43:42 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.76.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B13661800446;
	Tue,  2 Sep 2025 12:43:38 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Li Lingfeng <lilingfeng3@huawei.com>
Cc: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com, neil@brown.name,
 okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com, lilingfeng@huaweicloud.com, zhangjian496@huawei.com
Subject: Re: [PATCH] nfsd: remove long-standing revoked delegations by force
Date: Tue, 02 Sep 2025 08:43:36 -0400
Message-ID: <BF48C6D1-ED2E-4B9C-A833-FF48D9ACC044@redhat.com>
In-Reply-To: <1ece2978-239c-4939-bb16-0c7c64614c66@huawei.com>
References: <20250902022237.1488709-1-lilingfeng3@huawei.com>
 <a103653bc0dd231b897ffcd074c1f15151562502.camel@kernel.org>
 <1ece2978-239c-4939-bb16-0c7c64614c66@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 2 Sep 2025, at 8:10, Li Lingfeng wrote:

> Our expected outcome was that the client would release the abnormal
> delegation via TEST_STATEID/FREE_STATEID upon detecting its invalidity.=

> However, this problematic delegation is no longer present in the
> client's server->delegations list=E2=80=94whether due to client-side ti=
meouts or
> the server-side bug [1].

How does the client timeout TEST_STATEID - are you mounting with 'soft'?

We should find the server-side bug and fix it rather than write code to
paper over it.  I do think the synchronization of state here is a bit
fragile and wish the protocol had a generation, sequence, or marker for
setting SEQ4_STATUS_ bits..

>>
>> Should we instead just administratively evict the client since it's
>> clearly not behaving right in this case?
> Thanks for the suggestion. While administratively evicting the client w=
ould
> certainly resolve the immediate delegation issue, I'm concerned that ap=
proach
> might be a bit heavy-handed.
> The problematic behavior seems isolated to a single delegation. Meanwhi=
le,
> the client itself likely has numerous other open files and active state=
 on
> the server. Forcing a complete client reconnect would tear down all tha=
t
> state, which could cause significant application disruption and be perc=
eived
> as a service outage from the client's perspective.
>
> [1] https://lore.kernel.org/all/de669327-c93a-49e5-a53b-bda9e67d34a2@hu=
awei.com/

^^ in this thread you reference v5.10 - there was a knfsd fix for a
cl_revoked leak "3b816601e279", and there have been 3 or 4 fixes to fix
problems and optimize the client walk of delegations since then.  Jeff
pointed out that there have been fixes in these areas.  Are you finding t=
his
problem still with all those fixes included?

Ben


