Return-Path: <linux-nfs+bounces-8942-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7829A03F19
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 13:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1253A291A
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 12:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD301E47C8;
	Tue,  7 Jan 2025 12:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ey7PsJaK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC071E5734
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jan 2025 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736252941; cv=none; b=XWsB2UmSes4W11Xn6a19MedDssI8Y6BKwLla9eszkZeH8IEGAWxK9wMhPGJf4qwTuLIRzCN33mqAInD9dd0oaBJ8e6bFMoFq82xF9UcTvtMVXyCJTVAK6/cHF9/r43mHKeuZFdR3kQrw0uSH4MNTsMyKXSX6aE8Q7o2i+ckglVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736252941; c=relaxed/simple;
	bh=Rwx2AMNZS3z9pA81sWKOGZIvqSuHtdeRl2a5ymi0Rqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFe5IPVAlurry8JyvkEJwI4GqnQRQBu9o1dz0SUEKxzLXT30qxF2wLxzDvNAAG/p/+ug97So+Ktk9Nai0ZERUbdq9y5me/K2cngZsRGMt4lRPIxzLm+CEWU8q6Bhu4Shz5i2L8nFWGW+eKMtSfqRMi7svHw7FrCySmLLoN3moqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ey7PsJaK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736252938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9JESRW03B/cQUSo9+G3m7F0GBoDry0YwUnhEcSHFro=;
	b=ey7PsJaKSUIQNzoF/h5fwqshchYM6zWnTLk/yGY7LJM2890bvjP6SJvwHLyDCzLBlh63o2
	/Vkv07lGZYsK9kvZGLtLuWnlCNsjj1GdzmzEKjcvb0/n/zGEPrl8b2VPx5U/mzroznQ5XW
	4NKaj8VsVFG33maPijbgg56LQ8OEsOE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-V1ow7iy3OaGmKzbMa7QkLA-1; Tue,
 07 Jan 2025 07:28:55 -0500
X-MC-Unique: V1ow7iy3OaGmKzbMa7QkLA-1
X-Mimecast-MFC-AGG-ID: V1ow7iy3OaGmKzbMa7QkLA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFA2019560A2;
	Tue,  7 Jan 2025 12:28:53 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.76.8])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D0E01955F43;
	Tue,  7 Jan 2025 12:28:51 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Boris Pismenny <borisp@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 Vakul Garg <vakul.garg@nxp.com>
Subject: Re: [PATCH] tls: Fix tls_sw_sendmsg error handling
Date: Tue, 07 Jan 2025 07:28:46 -0500
Message-ID: <27F02B22-1673-4833-B83E-D2BA5E793004@redhat.com>
In-Reply-To: <20250106183633.0ddb7cb0@kernel.org>
References: <9594185559881679d81f071b181a10eb07cd079f.1736004079.git.bcodding@redhat.com>
 <20250106183633.0ddb7cb0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 6 Jan 2025, at 21:36, Jakub Kicinski wrote:

> On Sat,  4 Jan 2025 10:29:45 -0500 Benjamin Coddington wrote:
>> We've noticed that NFS can hang when using RPC over TLS on an unstable=

>> connection, and investigation shows that the RPC layer is stuck in a t=
ight
>> loop attempting to transmit, but forever getting -EBADMSG back from th=
e
>> underlying network.  The loop begins when tcp_sendmsg_locked() returns=

>> -EPIPE to tls_tx_records(), but that error is converted to -EBADMSG wh=
en
>> calling the socket's error reporting handler.
>>
>> Instead of converting errors from tcp_sendmsg_locked(), let's pass the=
m
>> along in this path.  The RPC layer handles -EPIPE by reconnecting the
>> transport, which prevents the endless attempts to transmit on a broken=

>> connection.
>
> LGTM, only question in my mind is whether we should send this to stable=
=2E
> Any preference?

Yes, I think it can go, though not a strong preference.  This code well
predates RPC over TLS which landed on v6.5.  I haven't investigated other=

users - they may not have the same problem since RPC over TLS has very
precise error handling, so it perhaps it makes sense to show the Fixes bu=
t
limit how far back we go for RPC.

Fixes: a42055e8d2c3 ("net/tls: Add support for async encryption of record=
s for performance")
Cc: <stable@vger.kernel.org> # 6.5.x

Thanks for the look Jakub.
Ben


