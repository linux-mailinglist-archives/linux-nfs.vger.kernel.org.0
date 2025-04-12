Return-Path: <linux-nfs+bounces-11121-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2C3A86F20
	for <lists+linux-nfs@lfdr.de>; Sat, 12 Apr 2025 21:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 589DF3BD2C5
	for <lists+linux-nfs@lfdr.de>; Sat, 12 Apr 2025 19:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB505347A2;
	Sat, 12 Apr 2025 19:19:10 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594F02907
	for <linux-nfs@vger.kernel.org>; Sat, 12 Apr 2025 19:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744485550; cv=none; b=q/6sj6am9QTbvGxv5xMRKzlS/ryi8H6de40x3TYpWfTOGRtZuBpvM+bMSkhD8DZ9BkxxoEu5N78as+cRv2+gXyV8KcXIa7RlDHCTUVY04PFZhQW9ZdUlQi4jATwocbht4aYibzwh/y6OaSPwCNjevYpr+BeGgn+niPffZdq2/6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744485550; c=relaxed/simple;
	bh=Loog8sTMqNbYJwjl1LC7NlGLaRHwQWxBP3UKDw2xa5Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gqVS8qiZ578LrIyymssDq3ssFFUJ3Z+8xugVo4M3Eqb2DBtuVZraXBc6LRz4dsdDZ1Yx9ImYUjobGMmuO9t/Nd858txmRD0JrtYBtX0truHTVxMHnjLs5aN7VkYlSwvgsBTFQqcgYVm/Cotz899p68bPOhxhk0Hadl5ykLSu5tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b07e9b7.dip0.t-ipconnect.de [91.7.233.183])
	by mail.itouring.de (Postfix) with ESMTPSA id E4545250;
	Sat, 12 Apr 2025 21:19:03 +0200 (CEST)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 9C291601853A9;
	Sat, 12 Apr 2025 21:19:03 +0200 (CEST)
Subject: Re: Async client v4 mount results in unexpected number of extents on
 the server
To: Benjamin Coddington <bcodding@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <848f71b0-7e27-fce1-5e43-2d3c8d4522b4@applied-asynchrony.com>
 <3696A877-3C0E-4F70-9C7E-3FD8B9AD185F@redhat.com>
 <8cb74904-331a-5615-6453-6ce8948236a2@applied-asynchrony.com>
 <85AA0B5B-64BF-4308-8730-D62AF68F23A2@redhat.com>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <f2bc2b85-97ee-e00b-bcfd-14a93349bdee@applied-asynchrony.com>
Date: Sat, 12 Apr 2025 21:19:03 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <85AA0B5B-64BF-4308-8730-D62AF68F23A2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 2025-04-12 19:28, Benjamin Coddington wrote:
> There isn't any guarantee of write processing order for async writes, is
> there?  I also don't think there's any practical impact.  So I'm wondering
> what's the expectation of behavior and what problem you're trying to fix?

This definitely does not happen with regular local page writeback.
As I said before, my expectation that NFS behaves the same way might be
overly pedantic, but then again I'm still curious why this happens and whether
it's a bug or just accidental behaviour. *shrug*
Anway thanks for taking a look.

Holger

