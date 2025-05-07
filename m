Return-Path: <linux-nfs+bounces-11583-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C702CAAE394
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 16:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6F91BA791F
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 14:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC54213E81;
	Wed,  7 May 2025 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GhWB4OMn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C55E207A27
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629611; cv=none; b=Bn4C2aQf/CmmLdo2QbJu7sa4R4ORHBHN/n2Ah0oSNSFBVCu8qdFTHgLAUGgNv2Kjmquqi7wTFqQyyHqA8Hplqpdivrqj+Jy/HFa/Tt7YiV7qcGKmZQaz7pYE4jxFqw5WTSEvV1k6KW9OU0mfU30XMB1pCNUz59wjHp3TLPtRww8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629611; c=relaxed/simple;
	bh=+uhejmQ1gMmMeByxlXibjiNpk2JF04K7HsRfQn/IaVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a1VB3aBYaQW8zKOG6jJCkqepU4AZc+fFe3VmIWVu9DmZM5T7UQcVFmv6qRnboWzDfI+OpSaOMPF/Qrg00pa+u8r4f+fOrlz6GD7tnfsVP36cjlfIV1CYvsxD0XtYY2OAYozhOBBJ5ZbEoer8Oz5+5TMIrCHcfnfBvbIOnlAV6Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GhWB4OMn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746629607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+uhejmQ1gMmMeByxlXibjiNpk2JF04K7HsRfQn/IaVo=;
	b=GhWB4OMnq69FjYCgaxnrdcSNJd1kqiUEycyeAjRHMhxktszrttLU3uKPg+cZ5oSRunMvIw
	O3YUD+TH37gBgH4jzGD75BiXQseIXFjZAI9Q17bNkLZAA1CWEwTbVEWztWt/3g2VTxdHQd
	eFkoDvxjCaOf5wbc/XxsA4GYbJEqTIc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-p5-F79MBOIC3qRtqYPQbkg-1; Wed,
 07 May 2025 10:53:25 -0400
X-MC-Unique: p5-F79MBOIC3qRtqYPQbkg-1
X-Mimecast-MFC-AGG-ID: p5-F79MBOIC3qRtqYPQbkg_1746629601
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20D7F1956077;
	Wed,  7 May 2025 14:53:21 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.76.2])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 350B919560A7;
	Wed,  7 May 2025 14:53:20 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Scott Mayhew <smayhew@redhat.com>, anna@kernel.org, trondmy@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSv4: Don't check for OPEN feature support in v4.1
Date: Wed, 07 May 2025 10:53:17 -0400
Message-ID: <E0CFFDE3-83C5-436E-9B55-75F45AD17C44@redhat.com>
In-Reply-To: <20250430111229.4114991-1-smayhew@redhat.com>
References: <20250430111229.4114991-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 30 Apr 2025, at 7:12, Scott Mayhew wrote:

> fattr4_open_arguments is a v4.2 recommended attribute, so we shouldn't
> be sending it to v4.1 servers.
>
> Fixes: cb78f9b7d0c0 ("nfs: fix the fetch of FATTR4_OPEN_ARGUMENTS")
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Cc: stable@vger.kernel.org # 6.11+


It would be lovely to have this fixed in v6.15.

Ben


