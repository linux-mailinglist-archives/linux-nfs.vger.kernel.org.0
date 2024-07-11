Return-Path: <linux-nfs+bounces-4827-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAA492EC31
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 18:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 506FC1C23860
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 16:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCF715B12B;
	Thu, 11 Jul 2024 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6J8jPbU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D61716C862
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 16:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713613; cv=none; b=tPYbBQ5maXqWx5itCXd4NjwjOUlJjfosmhoR6TpPZtbUyqMaNxoocT/yM+f5rfUgPNU6qV0TaaDSZ+Gb5v6XVu/BITttxpOpQUdfZBgqS1d0T1C4j1bWeUQLsCk8irqwxd/ijwj4b/8r5t904+KwrkG5TWl/0NIsQES8o++E7oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713613; c=relaxed/simple;
	bh=iBNan4igZOqEHbuqzg7wSGY4RxxK9eAxM67RUrKZb5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QJRZ/ermmEC4KkDCK6zhzFLbnGoetA08XZB5XQcom6Udot0mSqwIqyAjaeX1TFlR2glnGsU0ZwSsjggEGmyWf9O4oQXUdI+hnpLshcto+iUAcXgng6I3XOZswlNDShFOJAlAbK8vXpJ77HFisvKgIUon82PXJ7Sc0gSgYNGFgzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i6J8jPbU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720713611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lJ+EVCONDTjKVvtv9/k+vweQQ+vOMJC4raIjALEeIW0=;
	b=i6J8jPbUdgBGca1rkCN5XnWz/sBUSAE1c7P06cByGQt++wTDMzwV29QvxZuL1imIwm85lW
	NoBP55KVlpviYWtUsnKdXQDY2Q+QAyhfu6Izn7ZfhNe0+LB2+yiMmaWIt75L0JJyM78gVX
	AcTCw8I5XDsPZGDCTU8g8YicPsEAeHw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-tECmJWjHNOebHXW76XDMrQ-1; Thu,
 11 Jul 2024 12:00:06 -0400
X-MC-Unique: tECmJWjHNOebHXW76XDMrQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB6571954B34;
	Thu, 11 Jul 2024 16:00:03 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B795E1955BD4;
	Thu, 11 Jul 2024 16:00:02 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Fixup gss_status tracepoint error output
Date: Thu, 11 Jul 2024 12:00:00 -0400
Message-ID: <057A51C2-DE21-4B66-9901-D360AADA756F@redhat.com>
In-Reply-To: <2799ECE7-E3D9-45E6-9B47-47934B38A284@oracle.com>
References: <27526e921037d6217bdfc6a078c53d37ae9effab.1720711381.git.bcodding@redhat.com>
 <Zo/6G7ANcWEWkd0l@tissot.1015granger.net>
 <C3887ED2-B331-4AC9-A73B-326D7DDAC5FD@redhat.com>
 <2799ECE7-E3D9-45E6-9B47-47934B38A284@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 11 Jul 2024, at 11:52, Chuck Lever III wrote:

>> On Jul 11, 2024, at 11:48 AM, Benjamin Coddington <bcodding@redhat.com> wrote:
>>
>> On 11 Jul 2024, at 11:28, Chuck Lever wrote:
>>
>>> On Thu, Jul 11, 2024 at 11:24:01AM -0400, Benjamin Coddington wrote:
>>>> The GSS routine errors are values, not flags.
>>>
>>> My reading of kernel and user space GSS code is that these are
>>> indeed flags and can be combined. The definitions are found in
>>> include/linux/sunrpc/gss_err.h:
>>>
>>> To wit:
>>>
>>> 116 /*
>>> 117  * Routine errors:
>>> 118  */
>>> 119 #define GSS_S_BAD_MECH (((OM_uint32) 1ul) << GSS_C_ROUTINE_ERROR_OFFSET)
>>> 120 #define GSS_S_BAD_NAME (((OM_uint32) 2ul) << GSS_C_ROUTINE_ERROR_OFFSET)
>>
>> I read this as just values shifted left by a constant.
>>
>> No where in-kernel are they bitwise combined.
>
> The kernel gets GSS status values from user space code too.
>
>
>> I noticed this problem in practice
>> while reading the tracepoint output from corrupted GSS hash routines.
>
> Can you describe the problem?

It was a week ago or so, and I don't have the test setup any longer, but the
tracepoint would not print the actual error returned, rather the bitwise
combination of that error.

Look closer at the values - it makes no sense that these are bits, else
GSS_S_BAD_NAMETYPE is the same as GSS_S_BAD_MECH|GSS_S_BAD_NAME.

Ben


