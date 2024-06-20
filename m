Return-Path: <linux-nfs+bounces-4144-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B76E9106D3
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 15:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D671C21141
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 13:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9821AC782;
	Thu, 20 Jun 2024 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hEdIxAA1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80F38175E
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891591; cv=none; b=FbWe8d6uHXM4F3HwJAeiuieDFW/aNnBPdaoHDVfePCrrIDT+g/sBIvDwmfskW9X4oAiDKl0UYNb2AcLlqkX/QyVgDItNiz3MuvnhAM6xPwvGvmueVjvd9nGBgxZFp4SrBslzHwr2ZxQ3xVpNL4QvHFWXDdFy9HQ4TEuv7WaCfPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891591; c=relaxed/simple;
	bh=pN4xP8LlYgfL5WpLGuyJuICK5AA2RRjgZZSj0OOYzaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PavuhdgenuiXin9ogO/cyOBFNhXHGFjJ6eKdb37HuWCdKyuQ5koX/28MEWbwRBUbmPzIuq+2ov7ymEXRVTsQsIOHBm5aRtUKrf1J8g64w8AKMjHGUdVueEA5KdGpl28kAMMM2xH42MPsg8638crS/7RabTbjagYerMEN1lE/KlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hEdIxAA1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718891588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mjN/bwqUvOOdBskEkuTLXzKUi9IsguQwV1NDkzL9Jls=;
	b=hEdIxAA12IYuA7Xk+8QDt4Jgx20Fj54Rvs57SeRK3z5BCOC3pIRsyT2jDD6YqC+H+Xl6r+
	6vylfNaNt77g+fT4s+GLeANN71e+EMgTQO4AbHb2rortPh1cqC+FSv4L2P0tnr1ghNBrNZ
	PURHAKKfDeVGOJzSu+fJeNDIdHHKeoM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-y3Jcy0wMOfmi2zHIWZwNLg-1; Thu,
 20 Jun 2024 09:53:04 -0400
X-MC-Unique: y3Jcy0wMOfmi2zHIWZwNLg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98B4819560B5;
	Thu, 20 Jun 2024 13:53:03 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67F1B3000602;
	Thu, 20 Jun 2024 13:53:01 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 3/4] nfs/blocklayout: Fix premature PR key
 unregistration
Date: Thu, 20 Jun 2024 09:52:59 -0400
Message-ID: <3859730C-40EC-4818-9058-D74E4153623B@redhat.com>
In-Reply-To: <20240620050614.GE19613@lst.de>
References: <20240619173929.177818-6-cel@kernel.org>
 <20240619173929.177818-9-cel@kernel.org> <20240620050614.GE19613@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 20 Jun 2024, at 1:06, Christoph Hellwig wrote:

> On Wed, Jun 19, 2024 at 01:39:33PM -0400, cel@kernel.org wrote:
>> -	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags) == 0)
>> +	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags) == 0) {
>
> It might be worth to invert this and keep the unavailable handling in
> the branch as that's the exceptional case.   That code is also woefully
> under-documented and could have really used a comment.

The transient device handling in general, or just this bit of it?

>> +		struct pnfs_block_dev *d =
>> +			container_of(node, struct pnfs_block_dev, node);
>> +		if (d->pr_reg)
>> +			if (d->pr_reg(d) < 0)
>> +				goto out_put;
>
> Empty line after variable declarations.  Also is there anything that
> synchronizes the lookups here so that we don't do multiple registrations
> in parallel?

I don't think there is.  Do we get an error if we register twice?

Ben

>> +
>> +	if (d->pr_registered)
>> +		return 0;
>> +
>> +	error = ops->pr_register(bdev, 0, d->pr_key, true);
>> +	if (error) {
>> +		trace_bl_pr_key_reg_err(bdev->bd_disk->disk_name, d->pr_key, error);
>> +		return -error;
>
> ->pr_register returns either negative errnos or positive PR_STS_* values,
> simply inverting the error here isn't doing the right thing.


