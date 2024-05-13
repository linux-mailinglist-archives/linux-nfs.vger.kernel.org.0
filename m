Return-Path: <linux-nfs+bounces-3247-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1673B8C3F92
	for <lists+linux-nfs@lfdr.de>; Mon, 13 May 2024 13:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9540CB23AD0
	for <lists+linux-nfs@lfdr.de>; Mon, 13 May 2024 11:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5689514A60A;
	Mon, 13 May 2024 11:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P612eqpy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46581C683
	for <linux-nfs@vger.kernel.org>; Mon, 13 May 2024 11:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715598793; cv=none; b=EYiZA51jpwoz4fz/hdvxGunL8UiZiC4vJLVn4NUYlPCFCigtj4x4xYtYdWP9wuRcvwz1ifTc0St8z5hnPxnZdJyfh6iY9rrUjeOFa20DNKShEP81k+OT7eYBC5EAwwq44Qn2OjBAxaKDza1uLrGNttuo2ubs15mFKcY+JDo8Z8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715598793; c=relaxed/simple;
	bh=MtkAdlTzPe4w4GFZ9dglhtqUVrNpWBnXSJupVCU1auA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGCVfqYf1s+tx2mGCoEOVSxlkU1yIMDCsYZbi62ox8hmOfQjUt4gps1e58osKg6nYQ/9jrckQ66PY+TKkEUA1J5YHQdzrn9PUSpM6QSkRdPCJlDRsWMD9P/Jja1++x9W8AEdFE1ILAeStk+JqfAb44aAH6PDKwNjIXJne9CfyV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P612eqpy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715598790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MtkAdlTzPe4w4GFZ9dglhtqUVrNpWBnXSJupVCU1auA=;
	b=P612eqpym8hEQXDmDmPPPs6BLCHhJqrOrfiPr63yQ21txhpqdiMHfgVVxCjTxCkiXTf4wD
	WWnDrQDM/7Vimy1e876tFCKYX3iYh3zdQM9yV5Wb2imTq8Boh3ZhkcSvfemO6nkz1OkmLc
	7jlNibTJ1o1+Wn8rMa2fgFqo9VUCxjA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-jU2s4o6RP2eHZ1wIgiQoxA-1; Mon,
 13 May 2024 07:13:07 -0400
X-MC-Unique: jU2s4o6RP2eHZ1wIgiQoxA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4490729AA2C2;
	Mon, 13 May 2024 11:13:07 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 737C040C6EB7;
	Mon, 13 May 2024 11:13:06 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc: trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] pNFS: rework pnfs_generic_pg_check_layout to check IO
 range
Date: Mon, 13 May 2024 07:13:05 -0400
Message-ID: <F70BF3E8-1D3C-4DA7-BFDC-69E19B856E0B@redhat.com>
In-Reply-To: <20240510190743.52605-1-olga.kornievskaia@gmail.com>
References: <20240510190743.52605-1-olga.kornievskaia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 10 May 2024, at 15:07, Olga Kornievskaia wrote:

> From: Olga Kornievskaia <kolga@netapp.com>
>
> All callers of pnfs_generic_pg_check_layout() also want to do a call to
> check that the layout's range covers the IO range. Merge the functionality
> of the pnfs_generic_pg_check_range() into that of
> pnfs_generic_pg_check_layout().
>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>

Looks good - thanks for the extra hack.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


