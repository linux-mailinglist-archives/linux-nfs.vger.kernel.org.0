Return-Path: <linux-nfs+bounces-12945-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CEBAFD4C0
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 19:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525CB4E05AD
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 17:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4A02E5B04;
	Tue,  8 Jul 2025 17:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKleLkzV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741A72DD5EF
	for <linux-nfs@vger.kernel.org>; Tue,  8 Jul 2025 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994230; cv=none; b=bdenDFLJPomhS6s+eKp0zJRWzaMPtnqYz6zvR50Wd1zZNkk2QM9cLA2wknFeLUJuPmQ4MkmLYyXcMNfng2yDsesIv5+yyaCwOVNJp3gDqwd55IPH+OD4K6IEDbFzqXPOK9osNMRPG4OWPqsyUhSgB3uiarJM/1P5aZutxb9n35I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994230; c=relaxed/simple;
	bh=Seka59zr44q2ghemfm1mzgyjVO8YzxH7v5wf3ly4cus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EopTLCSwTNDQv8VDCulGwMdXBvvzRTge1lzhs8nfZg0U1el5OR/RCwjymLEwpDgHJ6xNPYB6csv8XnM0OEqi9TPDkiM2xWWmw02tZCWZ4nJ7BLoS8PQn8E/KNGLBhDCrSC2qRcwNm8q/2WnckH1FRWbSSFxJenfayPMHF92/OII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eKleLkzV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751994227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Seka59zr44q2ghemfm1mzgyjVO8YzxH7v5wf3ly4cus=;
	b=eKleLkzVJjA/hxTH4/DHflTqFjk+dVxXg9dsxNhXIOtLgD+IyrdJZ4nxvFdxpoV7mRaagy
	1inwqCRp9vmAO+/yFqv5N67Nmo2iwmZBKAlrqfptNew5RR+vMMglggzCKIQ+f/t/okfmCm
	p0DI+O2y54Eou0urTNW0CIT5msRtCOA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-pMUT1J1yPgaIOCd-TsGN1g-1; Tue,
 08 Jul 2025 13:03:45 -0400
X-MC-Unique: pMUT1J1yPgaIOCd-TsGN1g-1
X-Mimecast-MFC-AGG-ID: pMUT1J1yPgaIOCd-TsGN1g_1751994223
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCC9319107EB;
	Tue,  8 Jul 2025 17:03:43 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2500E30001B1;
	Tue,  8 Jul 2025 17:03:41 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Laurence Oberman <loberman@redhat.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, djeffery@redhat.com
Subject: Re: [PATCH 2/2] NFS: Improve nfsiod workqueue detection for
 allocation flags
Date: Tue, 08 Jul 2025 13:03:39 -0400
Message-ID: <E38B4D1E-C7C4-4694-94E7-5318AD47EE1C@redhat.com>
In-Reply-To: <a93e72cfc812a117166c0b20e9cca4e5f8d43393.camel@redhat.com>
References: <cover.1751913604.git.bcodding@redhat.com>
 <a4548815532fb7ad71a4e7c45b3783651c86c51f.1751913604.git.bcodding@redhat.com>
 <a7621e726227260396291e82363d2b82e5f2ad73.camel@kernel.org>
 <59530cbe001f5d02fa007ce642a860a7bade4422.camel@redhat.com>
 <a93e72cfc812a117166c0b20e9cca4e5f8d43393.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 8 Jul 2025, at 12:50, Laurence Oberman wrote:

> Both Ben's patch and Trond's fix the failing write issue so I guess we
> need to decide what the final fix will be.
>
> For both solutions
> Tested-by: Laurence Oberman <loberman@redhat.com>

Thanks Laurence! I think we'll leave these two patches behind.

I'm persuaded by Trond's arguments, and along with not needing to add the=

workqueue helper, I've properly posted that approach here after some mini=
mal
testing:

https://lore.kernel.org/linux-nfs/6892807b15cb401f3015e2acdaf1c2ba2bcae13=
0.1751975813.git.bcodding@redhat.com/T/#u

There's only a difference of a comment, so it should be safe to reply wit=
h
your Tested-by there.

Ben


