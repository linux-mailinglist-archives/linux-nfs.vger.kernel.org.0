Return-Path: <linux-nfs+bounces-8238-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DC19DA70A
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Nov 2024 12:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A26166091
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Nov 2024 11:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62AE1F8EFA;
	Wed, 27 Nov 2024 11:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EH8C+l0F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32531F942C
	for <linux-nfs@vger.kernel.org>; Wed, 27 Nov 2024 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732707922; cv=none; b=e8BBmypvGPRT0IbGJYoOanufUPrmnUQcUpY9veUJo/S+Ck4QOrJhWH6t3JeXvo2coVl58B6D+YoeBautlEYMpE8xsOH9WGRF1sbFrT5K6DdINKOOY5MdMKQrQBxyyfrv7vRvsf1u/ds/WN/J4nQaiRqzO1kOT1YsO+RABDdsvd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732707922; c=relaxed/simple;
	bh=KSuKiep5slYUTA2dJuETbQXhix9g0v+vOKn9qOjErus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8IHo6u3yarUCwJu00qoZAfpRHWjaGAgVomgfG7WGpCoQl59+B/VR0HUKmpzjUfING2oubATTmIBu8CCjUVV5Go9MfjsLVT8WLoj+TPfkap3oupS9ggQoQPCBbRX1PK54GmmSHgwiIvHsi+ENuEeb3HJhEIyq2eN2PMnWehNYH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EH8C+l0F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732707919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W5KUzbs/rsqK9vwQ9DKIlZKy9y2NKEbsPhwBSIrqK68=;
	b=EH8C+l0FsrlyY3o/BesoFVa+Uz0Kf3KJvaYM6AKgvrL43HGVUEgG7qIIPCTTKEX8It21UO
	nGxwMPqS73LzhGTFiWGaphsNQHULXS6zixDfm2s1xP3d5Y9elGRWLnTtuTXQCnOc8juwCm
	MqKPymA1EhrxecsEaoWF2xg5Er5BQQc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-FPX3EfjFP529wSmWk5cBTQ-1; Wed,
 27 Nov 2024 06:45:17 -0500
X-MC-Unique: FPX3EfjFP529wSmWk5cBTQ-1
X-Mimecast-MFC-AGG-ID: FPX3EfjFP529wSmWk5cBTQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C76911956048
	for <linux-nfs@vger.kernel.org>; Wed, 27 Nov 2024 11:45:16 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D91F195E485;
	Wed, 27 Nov 2024 11:45:16 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH] libnsm: fix the safer atomic filenames fix
Date: Wed, 27 Nov 2024 06:45:13 -0500
Message-ID: <024BFAE1-2A6B-4F95-A525-E7E306C617F1@redhat.com>
In-Reply-To: <995b5d27-6c34-4c5e-89c7-728da4878c9e@redhat.com>
References: <7463bba8aea785f7614e169e8cdfb3d8f1e1e64a.1732663909.git.bcodding@redhat.com>
 <995b5d27-6c34-4c5e-89c7-728da4878c9e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 27 Nov 2024, at 6:40, Steve Dickson wrote:

> On 11/26/24 6:32 PM, Benjamin Coddington wrote:
>> Commit 9f7a91b51ffc ("libnsm: safer atomic filenames") messed up the length
>> arguement to snprintf() in nsm_make_temp_pathname such that the length is
>> longer than the computed string.  When compiled with "-O
>> -D_FORTIFY_SOURCE=3", __snprintf_chk will fail and abort statd.
>>
>> The fix is to correct the original size calculation, then pull one from the
>> snprintf length for the final "/".
>>
>> Fixes: 9f7a91b51ffc ("libnsm: safer atomic filenames")
>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> Committed...

I just sent a v2 - this version doesn't handle paths without '/'.

Ben


