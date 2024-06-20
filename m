Return-Path: <linux-nfs+bounces-4162-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C0B910AD1
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 17:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51E41F229E5
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 15:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876E81CAAD;
	Thu, 20 Jun 2024 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6KfGigB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB9A1AF6BE
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899137; cv=none; b=Uz7jIrnNrGyDIrpwFhOb5n++lZ9dEhQZq1nHoU9COixNtsrUwDLYHuhWOzt3BLB1rqDd/LAqVYNhXyxDTRbiYjxiNxerECY/3J//7gg4TFCvioAOWsgavYY4+ueXh9GJZgflce98qvhj/IRHfrWlOPbNUnkpZ08PYzOwuqFbli8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899137; c=relaxed/simple;
	bh=JKV1mZD6tyWbX6HizeRVPELHd8TVFRLrx6TJeVFdD5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORA6hfADCNt78Y7VaxqJrXVuOSY1Fz2RfaVD8ru3UTXYF6RMREVqxvZv+IlcFnO1FHueEcoFgaBOXG3ksqA4LE8HdAJMFn2pPDRa/kUXm+7UtM0bEyuBc5J55pTm9rwzobtIp5tTQso8kuBbTjAyF8Z75beDX+JdBi0U/LI7Gt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f6KfGigB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718899134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1+P80Y9N553B6ACtpm9llDBAfgrYnPr75f0ktRgGVy4=;
	b=f6KfGigBYP8BozSWJ0NVvvr+cBwuJDzOeklYR/zYsjfAjTW18sYFkpGM6tRx2R91gnf4lM
	TGUtzXr0L4VyVbgSNpu2/N2OYsFiPhJZEjjGSW6EAd+n8oMBCpaRPqUJpcZfNnxjp9Nxpj
	fU7C6BdJdXNrNmCSutcXgyk+iKnh3DI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-9J0uaYwDO9aoClI4Z-p0Ow-1; Thu,
 20 Jun 2024 11:58:53 -0400
X-MC-Unique: 9J0uaYwDO9aoClI4Z-p0Ow-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 975DF19560BB;
	Thu, 20 Jun 2024 15:58:52 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E2651955F2D;
	Thu, 20 Jun 2024 15:58:51 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, cel@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] nfs/blocklayout: Fix premature PR key
 unregistration
Date: Thu, 20 Jun 2024 11:58:49 -0400
Message-ID: <4A3E7287-D401-465D-A0CA-E9313402E823@redhat.com>
In-Reply-To: <ZnRPVlI3zVMP7Mh8@tissot.1015granger.net>
References: <20240619173929.177818-6-cel@kernel.org>
 <20240619173929.177818-9-cel@kernel.org> <20240620050614.GE19613@lst.de>
 <3859730C-40EC-4818-9058-D74E4153623B@redhat.com>
 <20240620141519.GB20135@lst.de>
 <DC39D637-E108-4D24-808F-7AEF29440263@redhat.com>
 <ZnRPVlI3zVMP7Mh8@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 20 Jun 2024, at 11:48, Chuck Lever wrote:

> On Thu, Jun 20, 2024 at 11:45:02AM -0400, Benjamin Coddington wrote:
>> On 20 Jun 2024, at 10:15, Christoph Hellwig wrote:
>>
>>> On Thu, Jun 20, 2024 at 09:52:59AM -0400, Benjamin Coddington wrote:
>>>> On 20 Jun 2024, at 1:06, Christoph Hellwig wrote:
>>>>
>>>>> On Wed, Jun 19, 2024 at 01:39:33PM -0400, cel@kernel.org wrote:
>>>>>> -	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags) == 0)
>>>>>> +	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags) == 0) {
>>>>>
>>>>> It might be worth to invert this and keep the unavailable handling in
>>>>> the branch as that's the exceptional case.   That code is also woefully
>>>>> under-documented and could have really used a comment.
>>>>
>>>> The transient device handling in general, or just this bit of it?
>>>
>>> Basically the code behind this NFS_DEVICEID_UNAVAILABLE check here.
>>
>> How about..
>
> Let's leave this as a separate patch. IMO this is dealing with an
> entirely orthogonal issue.

Agree - just wanted feedback on what's appropriate for comments in here.  I
can send something after your work.

Ben


