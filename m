Return-Path: <linux-nfs+bounces-11108-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D41A85F0E
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Apr 2025 15:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD313B01A0
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Apr 2025 13:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C871A317D;
	Fri, 11 Apr 2025 13:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jbna7hdv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3571C8629
	for <linux-nfs@vger.kernel.org>; Fri, 11 Apr 2025 13:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744378178; cv=none; b=rz6rfNBXr0/kfnanmHjhOEekXXlL4kIB8BRPqB8Oa4+CMu45LZz2yGYd3zpmamvZ9UGS7FVmPQDVy/mVTpAjOBqG/v3DSfl1xbZp8IlzM8SBcydJv+GsWhWPW8ifIQZBOeq3cZFQNC7o+Gw9Sb3+TcbXFMQH0mjCnEAHvUct1Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744378178; c=relaxed/simple;
	bh=5JokcmpHTTlexsyQexUD1xcpIZhwJr1NKHDc4G6vxgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iPdrT36SmI1wlj1AeVku9QwG7LMdLydEMWepWW411ekBg1krV7ZbYQ37rHvpK/mqWzV9sG0EFfwwaGwhRGKGdeC/0Cx+ec4AHiFepypW3lsc3oio4pZh8MN2VAu5Ceb9RIpQAt+cuo2zyAMVugSQnN3HaZrxRJaFBSsvPVonQYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jbna7hdv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744378175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5JokcmpHTTlexsyQexUD1xcpIZhwJr1NKHDc4G6vxgg=;
	b=Jbna7hdvpf6XUUE0s732TM/g9qd/6G+qmqyrKfI16nZWd8HFLWLIzN5Rb5sV19gBI68zVO
	C3blpuXYNRX7m6F3zDK0L5iwjPRVsGzLBIMkBpdgREzIpwEoItyMZk6UdQuaD55QJm+7sA
	itBInCeNLwHqq/FaU9P6K4LVfdcfauk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-x-q7NTukPkW4SVJuUNAqIg-1; Fri,
 11 Apr 2025 09:29:33 -0400
X-MC-Unique: x-q7NTukPkW4SVJuUNAqIg-1
X-Mimecast-MFC-AGG-ID: x-q7NTukPkW4SVJuUNAqIg_1744378172
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48797180AF52;
	Fri, 11 Apr 2025 13:29:32 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CBCA1809B64;
	Fri, 11 Apr 2025 13:29:31 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: =?utf-8?q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: Async client v4 mount results in unexpected number of extents on
 the server
Date: Fri, 11 Apr 2025 09:29:29 -0400
Message-ID: <3696A877-3C0E-4F70-9C7E-3FD8B9AD185F@redhat.com>
In-Reply-To: <848f71b0-7e27-fce1-5e43-2d3c8d4522b4@applied-asynchrony.com>
References: <848f71b0-7e27-fce1-5e43-2d3c8d4522b4@applied-asynchrony.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 10 Apr 2025, at 8:55, Holger Hoffstätte wrote:
> ...
> Does this behaviour seem familiar to anybody?
>
> I realize this is "not a bug" (all data is safe and sound etc.) but
> somehow it seems that various layers are not working together as one
> might expect. It's possible that my expectation is wrong. :)

My first impression is that the writes are being processed out-of-order on
the server, so XFS is using a range of allocation sizes while growing the
file extents.

Ben


