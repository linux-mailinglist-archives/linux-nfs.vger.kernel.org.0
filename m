Return-Path: <linux-nfs+bounces-859-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F375821BAF
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jan 2024 13:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5F6282CBE
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jan 2024 12:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC5CF9DA;
	Tue,  2 Jan 2024 12:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQUGF7Kl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E66AF505
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jan 2024 12:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704198780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHxpMl7RDbETrERTXnhnaCC4nYMHBRO8LgTCdUl7ypU=;
	b=CQUGF7KlclpXzeXkZPtSJV6Ta2f4Wy1DtINyV4cErM83DU8oBPzRKbG8ZCFU8hwA24j0dS
	RbTyDEH4zZfkiG9Sus/fbmc/zcydiymtVb/1lJqgWkZFnCjGsc2iPJ2bMadqcd7qJEWkfw
	SnT49x1CF2BwWAGEeflmkrFwKjyf/3Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-2JJY42rrOWKMMqv9dgT_qw-1; Tue, 02 Jan 2024 07:32:57 -0500
X-MC-Unique: 2JJY42rrOWKMMqv9dgT_qw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC21A85A58F;
	Tue,  2 Jan 2024 12:32:56 +0000 (UTC)
Received: from [100.85.132.103] (ovpn-0-5.rdu2.redhat.com [10.22.0.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 89A6B51D5;
	Tue,  2 Jan 2024 12:32:55 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-nfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Anna Schumaker <anna@kernel.org>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rpc_pipefs: Replace one label in bl_resolve_deviceid()
Date: Tue, 02 Jan 2024 07:32:54 -0500
Message-ID: <8032551C-BB6C-43AE-B9A3-125B9E5D6D36@redhat.com>
In-Reply-To: <bbf26021-798a-41a7-840e-62c8d383bb93@web.de>
References: <bbf26021-798a-41a7-840e-62c8d383bb93@web.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 29 Dec 2023, at 7:45, Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 29 Dec 2023 13:18:56 +0100
>
> The kfree() function was called in one case by
> the bl_resolve_deviceid() function during error handling
> even if the passed data structure member contained a null pointer.
> This issue was detected by using the Coccinelle software.
>
> Thus use an other label.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


