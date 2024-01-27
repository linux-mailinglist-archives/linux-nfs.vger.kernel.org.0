Return-Path: <linux-nfs+bounces-1514-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D5D83ED21
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jan 2024 14:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18F7282AF2
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jan 2024 13:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5185219FD;
	Sat, 27 Jan 2024 13:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cl1nsFTa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138E78831
	for <linux-nfs@vger.kernel.org>; Sat, 27 Jan 2024 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706360525; cv=none; b=uoI8zSXGm9mfTHPYVPFcVYH8u1bt6QXZa9HB3yx9BQvHEAqtfo09lk6mYdsaRoIeBxJ28g3rrm7Hhj7WYVGtppWpNHjB6gEXj5w5stoJru7Z2juU2cHOoLiJv1+MO3erc+leZzoQPT2P7ec57sbnIHCcMfEZtIfbFBOgBsfZclc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706360525; c=relaxed/simple;
	bh=wgQo6asVQI2KQE2CnoDM96QiPcHzE1ciD47Q4xrh8lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZugHHdrwKWa6f4ufOtzKuMph72bCTIjMSaEYqIr2xp67okIEVVoq97HxtpUhhvmh2Rndxlq3Q8BU+myBFl3Wukyd9bfvDgxrYrmTB/JT85a9dbhwBhRPAN1OnV5BFJNDOhv0MpNl1+3YgL/cp5U3PH18MWriNEIeDlkTuvf0wB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cl1nsFTa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706360523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9gATf9xPopVZLoNxw5u/a3GxAMBOLJc2RYWZVMpCujY=;
	b=cl1nsFTa8iawXcJwPvL3O3W/3SB49MDePM4i25W6DmFo3hjRqGwqPikWUr346n85a5nIXc
	uZ59SdbXNPPZDba++X93lcmChseRCLEme1JuciSUCL67Q4WrIGldzav8cnZrjH27nIupTO
	T1FZIs3fzU7jncJQiGf/YBMqT6Cupfw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-SYuYHxvjOOeeZAFOH3UmSw-1; Sat,
 27 Jan 2024 08:01:58 -0500
X-MC-Unique: SYuYHxvjOOeeZAFOH3UmSw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71785299E748;
	Sat, 27 Jan 2024 13:01:58 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-9.rdu2.redhat.com [10.22.0.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E665492BE3;
	Sat, 27 Jan 2024 13:01:57 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jorge Mora <jmora1300@gmail.com>
Cc: linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com,
 anna@kernel.org
Subject: Re: [PATCH] NFSv4.2: fix listxattr maximum XDR buffer size
Date: Sat, 27 Jan 2024 08:01:56 -0500
Message-ID: <2D2732BC-19AD-4010-9CB9-DA4C3BBBC31C@redhat.com>
In-Reply-To: <CAG7w-ioC8VkBFWqcaCw1S7YM-riNQKNUeu2-oUB4CpaimzB=7g@mail.gmail.com>
References: <20240125145128.12945-1-mora@netapp.com>
 <FE38CC90-A3BE-40CF-9365-557CA706376E@redhat.com>
 <CAG7w-ioC8VkBFWqcaCw1S7YM-riNQKNUeu2-oUB4CpaimzB=7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 26 Jan 2024, at 15:37, Jorge Mora wrote:

> Thanks Ben,
>
> Do you want me to resubmit the patch using XDR_QUALEN? Something like this?
>
>  static inline u32 nfs42_listxattr_xdrsize(u32 buflen)
>  {
> -       return ((buflen / (XATTR_USER_PREFIX_LEN + 2)) * 8) + 4;
> +       u32 size = 8 * buflen / (XATTR_USER_PREFIX_LEN + 2) + 4;
> +
> +       return XDR_QUADLEN(size) << 2;

I just thought I'd mention it since it's used all over.  I think your
version is just fine.

Ben


