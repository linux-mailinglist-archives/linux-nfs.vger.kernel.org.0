Return-Path: <linux-nfs+bounces-5525-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D449795A1F2
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 17:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DB15B2288A
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 15:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95D214D28E;
	Wed, 21 Aug 2024 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMYU0x1q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFB714F138
	for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255084; cv=none; b=kIH8w4pzaDzTqjxj+d9Ej6acJFtB5NAA+jPjQs+ty2WPBqf+jgwae8Y9FB1JllCL9TRMV97lySS/sgW/YNTDg4bK8Uj4+7WoC59Cju6aATxQjr6xzqy4EdVs25DC0l7prkrkPzkeq5CI8vlCY4qL+07zbBu8NW3OsjuaVnibuUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255084; c=relaxed/simple;
	bh=rurQBwGxLpj2WymIA71KzG1DofWdq83pEQdb33jxloc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AnvOQzY0WOXXKnGw7UepNcf7eZ8saVVCKlRb2mv5+fQ9WHpSzpvoiE4ifWPF1EACyS9vd2IvDDgxvnbh8GdG34P8UUcEBbo+1Iw41ToGKZR3IGaal8FAYpmB/sPNKhrVwSqJXGDXKf/ZNCKnCXSOiDRuOe9/yyGdrf5KkixfUWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bMYU0x1q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724255081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rurQBwGxLpj2WymIA71KzG1DofWdq83pEQdb33jxloc=;
	b=bMYU0x1qeC/A3Xm1r/xicYfXVsrgSpquk6Adl2XbPXMZSB8TKz6URwHxY23y86eYae6zEq
	unA5gdbODMqC20Ac04SKOhC7nx3nIuGk5lZWjNNdj/D4NyQ8DkU4i7EQNEuDYFAcVbC+mL
	qDgTr830x7X+6GDp79thW48pgxxL3lY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-e02Es0PnOK-NzjB8Wam-tA-1; Wed,
 21 Aug 2024 11:44:40 -0400
X-MC-Unique: e02Es0PnOK-NzjB8Wam-tA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 100741955D45;
	Wed, 21 Aug 2024 15:44:39 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.5])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64EBD1955DD6;
	Wed, 21 Aug 2024 15:44:37 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Lance Shelton <lance.shelton@hammerspace.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nfs: fix bitmap decoder to handle a 3rd word
Date: Wed, 21 Aug 2024 11:44:35 -0400
Message-ID: <358BF534-D6F3-4C05-9490-BC5B1C7B963A@redhat.com>
In-Reply-To: <20240821-nfs-6-11-v2-1-44478efe1650@kernel.org>
References: <20240821-nfs-6-11-v2-1-44478efe1650@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 21 Aug 2024, at 8:28, Jeff Layton wrote:

> It only decodes the first two words at this point. Have it decode the
> third word as well. Without this, the client doesn't send delegated
> timestamps in the CB_GETATTR response.
>
> With this change we also need to expand the on-stack bitmap in
> decode_recallany_args to 3 elements, in case the server sends a larger
> bitmap than expected.
>
> Fixes: 43df7110f4a9 ("NFSv4: Add CB_GETATTR support for delegated attributes")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


