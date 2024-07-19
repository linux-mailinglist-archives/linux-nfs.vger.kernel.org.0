Return-Path: <linux-nfs+bounces-4991-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA196937706
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jul 2024 13:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 685DD2820EC
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jul 2024 11:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BB383CD5;
	Fri, 19 Jul 2024 11:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKrvOp+t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4972D1C32
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jul 2024 11:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721387545; cv=none; b=K2eywKCkfHlSZINIVE+8Pb+TLO2IYQL6zNdvnjLPGg3ngd6jmtUFeVrSLMunEL0b7oO1KFDZaF2F4OC/6Ay+hDnzQ6p7MGjHBPl60QIFg1WaapFu7nxTkkXVi9eRqgUGgHqX8FZkbsNv/iE8MOeAb8sOdFMaz0SD+D+vsXUc+wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721387545; c=relaxed/simple;
	bh=bskNMZmq/YJXK9ORmuNfLszkSvTHaxLoSMh8l63TZuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nnk88E3l4S0w5ii7WCvsxzbCUDqwvdBZG5lj6gu5z2z0OeOGcWPgfaQ5rtjiuoiIME5w/maaI7E2vtVND//19Q9m7Iov9ZH+2YSe7PC8N/342Way+x9EPy9N+ETSvlPvScJiDoSqk3ElzPn2wA5tc6hSqCOKXcMY3eaK9iyANqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GKrvOp+t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721387542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1sT5FrGa/RGOHVsudxiDMYW7IoA6r8NMWRRnq93RcI0=;
	b=GKrvOp+tRHA9KbRWHYHSJDEZFWtlcZX38JuZfYInnowHT0jyQIw9qBJqNEaWhZsEZPloef
	KQ7l8mmFGCZDODcY+Dz6AAWCdmm4uFLeoa9GApetMpaeA3/U+mW4z4NL8Xlzv0P8iypni9
	FYlkZE+HPqmXl6RflC9RH7LYVGmpLtA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-5IT2sENjNiWpDUlEfyqIEQ-1; Fri,
 19 Jul 2024 07:12:20 -0400
X-MC-Unique: 5IT2sENjNiWpDUlEfyqIEQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26AFD1955F0D;
	Fri, 19 Jul 2024 11:12:19 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB9EA1955F40;
	Fri, 19 Jul 2024 11:12:17 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: 597607025@qq.com
Cc: linux-nfs@vger.kernel.org, Zhang Yaqi <zhangyaqi@kylinos.cn>
Subject: Re: [PATCH V2] tests/nsm_client: Fix nsm_client compile warnings
Date: Fri, 19 Jul 2024 07:12:15 -0400
Message-ID: <6E459796-E160-4BA3-83D3-B123336F3A9E@redhat.com>
In-Reply-To: <tencent_9E711ED0F5A07CEDABFDD0D9856693648609@qq.com>
References: <tencent_9E711ED0F5A07CEDABFDD0D9856693648609@qq.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 18 Jul 2024, at 22:39, 597607025@qq.com wrote:

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
> nsm_client.c: In function bin2hex:
> nsm_client.c:122:16: warning: comparison between signed and unsigned in=
teger expressions [-Wsign-compare]
>
> Signed-off-by: Zhang Yaqi <zhangyaqi@kylinos.cn>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

If you address this patch to the maintainer Steve Dickson, its more likel=
y
to get picked up.

Ben


