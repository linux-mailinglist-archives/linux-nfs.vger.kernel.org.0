Return-Path: <linux-nfs+bounces-4981-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46680934BEB
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jul 2024 12:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C4A284EF7
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jul 2024 10:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2C786126;
	Thu, 18 Jul 2024 10:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdttaL03"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B881B86FB
	for <linux-nfs@vger.kernel.org>; Thu, 18 Jul 2024 10:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721299689; cv=none; b=sM/3k14sp2nWjF2SSmgo9w0Htn7VkI72i2ZIYBShEderIsX4cQfuVaS4aJhwAuklKA/TF5jRU5OLO98LyjUPuZ1pdR3i+wZ8r8P1wtNPULTaQSN7WIHDn2dC4z9YAWlRT6DLh10Uupw8wRUG/VC7QinFGQTpQ6t0r3R2MOYq91s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721299689; c=relaxed/simple;
	bh=ojzkwTIUUwO9v7JfLeSoU8JH8lMBQ+k8lXb5gusisNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NX8kva7yb6Z7uI8zlCBbeITbqqNzySIaflF+UgM7fwZ8ukISqK+ioICxZg/59QX7USGXrGDU+q8pPo5WZLOtun9ktLO9fCMqqxa2sNjaYep/+DvMgmIpGtbf3JbxnJMwstMO2dvSUI/4JwUGC7l31Z9VyWqL4JFKu/roQB8Zfcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HdttaL03; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721299686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u4NuiXEUgdaXD1M4eHmkRK/2Av04iqsZBf7UZ/jDUek=;
	b=HdttaL03/kCl2ka5arIpB/DMDoZGtxER4EbYndiaad/jZuGdXjLkLZ1LHiMQxiliqi7S1l
	J7ErU7p7GsTuS9yp140D8yVO2if4P3O4vkkYgYMhA08vHW4xjGS6bJd+1TY2I8UILV45VQ
	3yPRgqMt33ZtuGbo+59jFe22p19u3to=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-7C4ecw5LMfm9XWfvJpEPcg-1; Thu,
 18 Jul 2024 06:48:02 -0400
X-MC-Unique: 7C4ecw5LMfm9XWfvJpEPcg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D1C01955D4D;
	Thu, 18 Jul 2024 10:48:01 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.5])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1EABA1955D42;
	Thu, 18 Jul 2024 10:47:59 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: 597607025@qq.com
Cc: linux-nfs@vger.kernel.org, Zhang Yaqi <zhangyaqi@kylinos.cn>
Subject: Re: [PATCH] tests/nsm_client: Fix nsm_client compile warnings
Date: Thu, 18 Jul 2024 06:47:57 -0400
Message-ID: <0EE7BA23-445C-4DCA-967B-589DD641876C@redhat.com>
In-Reply-To: <tencent_DB960C1E4E3B7A2A549B3D95DF223BDAEC06@qq.com>
References: <tencent_DB960C1E4E3B7A2A549B3D95DF223BDAEC06@qq.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 16 Jul 2024, at 22:26, 597607025@qq.com wrote:

> From: Zhang Yaqi <zhangyaqi@kylinos.cn>
>
> when  compiling after make
> cd tests/nsm_client
> make nsm_client
> then it shows:
>
> nsm_client.c: In function hex2bin:
> nsm_client.c:104:24: warning: comparison between signed and unsigned in=
teger expressions [-Wsign-compare]
>   for (i =3D 0; *src && i < dstlen; i++) {
>                         ^
> nsm_client.c: In function bin2hex:
> nsm_client.c:122:16: warning: comparison between signed and unsigned in=
teger expressions [-Wsign-compare]
>   for (i =3D 0; i < srclen; i++)
>
> Signed-off-by: Zhang Yaqi <zhangyaqi@kylinos.cn>

Why not just to make the types match, rather than cast?

Ben


