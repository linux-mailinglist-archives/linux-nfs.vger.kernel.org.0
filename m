Return-Path: <linux-nfs+bounces-6878-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 941CE991666
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 13:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66DD1C21F40
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 11:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5611494AC;
	Sat,  5 Oct 2024 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akGlq3y+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A07AF9FE
	for <linux-nfs@vger.kernel.org>; Sat,  5 Oct 2024 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728127404; cv=none; b=kdwfpC14n2uDNTePbmIeyQrFDtKwHQ2fdD8TqquTRWpg8OyqUbNmS4nR/FPqxFmWBdtgi0N9/eAQEL8gbw3L5+7j3v8A0OhN+X1W//O14/grbGiBVmilaoPOZlWqKfKXQU6VxMAMCcpTk2m0acqyhclh/cCOTcE1P7Bt1lCDo1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728127404; c=relaxed/simple;
	bh=lN9U2HbHxNih1QCsAKBoh0TRQzK0knF+SA0azU7fCiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLFgzXX8+0F1xXT/BeSzabWrJQfRHunpvu/chRTuXr0ERWzKaQSFcegvPKNNVGKg6wWK7O1cHh/htBu4r+/MPQglO9qebmRw8vMCyQ8sFMmTouXohaz8tq5TqW4Aj6nEC3dwaQzwrGfGHzduLfSuGI8xVb3SGsbLxKaWXHV8QrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=akGlq3y+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728127401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lN9U2HbHxNih1QCsAKBoh0TRQzK0knF+SA0azU7fCiY=;
	b=akGlq3y+LsBtJpon36s+mwLaNrbKi9lMYD4E9EHCLB9dLWPfNPf3iovc5DriO7RxHStNa/
	Khp02Pi52hxmLbU6c2J62B9m1LVV5z7a69nL/ZjkxoYavneR2s1voguWXVSfn1q8VDfzoW
	xzPOYMsJUQJD08LzlTv65F3P86WZecE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-awxbDy41PvuMg0VVBU3qRQ-1; Sat,
 05 Oct 2024 07:23:19 -0400
X-MC-Unique: awxbDy41PvuMg0VVBU3qRQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99E781954B0B;
	Sat,  5 Oct 2024 11:23:18 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.10])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 726621956088;
	Sat,  5 Oct 2024 11:23:17 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, linux-nfs@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/1] nfsd: fix possible badness in FREE_STATEID
Date: Sat, 05 Oct 2024 07:23:14 -0400
Message-ID: <099ED42E-0541-4DFE-9055-516E8361F832@redhat.com>
In-Reply-To: <20241004220403.50034-1-okorniev@redhat.com>
References: <20241004220403.50034-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 4 Oct 2024, at 18:04, Olga Kornievskaia wrote:

> When multiple FREE_STATEIDs are sent for the same delegation stateid,
> it can lead to a possible either use-after-tree or counter refcount
> underflow errors.
>
> In nfsd4_free_stateid() under the client lock we find a delegation
> stateid, however the code drops the lock before calling nfs4_put_stid(),
> that allows another FREE_STATE to find the stateid again. The first one
> will proceed to then free the stateid which leads to either
> use-after-free or decrementing already zerod counter.
>
> CC: stable@vger.kernel.org
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


