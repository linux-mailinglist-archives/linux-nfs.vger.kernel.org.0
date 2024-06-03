Return-Path: <linux-nfs+bounces-3526-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E75F98D8255
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2024 14:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E08F1F227E9
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2024 12:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E64D7E586;
	Mon,  3 Jun 2024 12:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODs19576"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83C912BF23
	for <linux-nfs@vger.kernel.org>; Mon,  3 Jun 2024 12:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717418040; cv=none; b=bRzauSrR7ZW/L7WLIJvHO9BD57+E9sBVIA+4Qxlxbdvl3NKOFuAppyGSBl2VtmJaxasTvDO9pGNVD1t0zQ1QEWHWwGamZ5n1ZbTDFOpqQdkoaeqAPPpcy7TyVMhokEY9f/G8BEfqBSrxMrJdtyt6rutXvEii+u7ewoKHePrMimY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717418040; c=relaxed/simple;
	bh=JGWPx2efE9FdgDvarzP3GpXHhAGbkIvfi84JKY3nzCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UayRij5xd/dvj9O8Qkhf2hEyw8vugGoGi0O9DhZZ5jDXBq7fRf/oVrUo+Y5EaxTvY8q8jgpJ/3P8EpBNfXQ//qbumRtUJKC9qWBxbb/UloGhgNtoQwALCxHNUwoym1heN9q+9BnPKPQ3haQq9hyRYauXQ2RrrDfbtNRmumQHKtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ODs19576; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717418037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=enIDZuLC3HMJgO9mcmKVIzo/WacB+zrA4Dq1ABmutW0=;
	b=ODs19576gSuTtUS1yTzfS9T+jgwTjKqwurxfK84V4o4WPBFUhRq3fkeRFhSvywlRmB8Knf
	LBGietb7WD7/GdT4OKQnxgiRc87q9AmT3At4Krx7ZQLWg6azrUKyKIIyDiKsGjh2vRLNpF
	oXLwUtGWtJwxR9yYDwiryihuT+AyBfM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-OPdOL6R9OzemkzP7X3QmHg-1; Mon,
 03 Jun 2024 08:33:54 -0400
X-MC-Unique: OPdOL6R9OzemkzP7X3QmHg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA92B3C025AC;
	Mon,  3 Jun 2024 12:33:53 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-11.rdu2.redhat.com [10.22.0.11])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E1C41C00A8E;
	Mon,  3 Jun 2024 12:33:53 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: cel@kernel.org
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH] SUNRPC: Fix loop termination condition in
 gss_free_in_token_pages()
Date: Mon, 03 Jun 2024 08:33:51 -0400
Message-ID: <21189EC9-21A6-4B67-B72A-02F156DD721D@redhat.com>
In-Reply-To: <20240602221525.4257-1-cel@kernel.org>
References: <20240602221525.4257-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 2 Jun 2024, at 18:15, cel@kernel.org wrote:

> From: Chuck Lever <chuck.lever@oracle.com>
>
> The in_token->pages[] array is not NULL terminated. This results in
> the following KASAN splat:
>
>   KASAN: maybe wild-memory-access in range [0x04a2013400000008-0x04a201340000000f]
>
> Fixes: bafa6b4d95d9 ("SUNRPC: Fix gss_free_in_token_pages()")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Nice.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


