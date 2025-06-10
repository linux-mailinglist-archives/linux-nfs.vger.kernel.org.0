Return-Path: <linux-nfs+bounces-12247-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B91AD379C
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 14:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50FB69E21B3
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 12:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557E329A9E1;
	Tue, 10 Jun 2025 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcRrXaqf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D6429A324
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 12:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559652; cv=none; b=QsiV0zLN9SF7PqbLXOIinYmihGp0GfWmY52S8jAPqHdpmKpYa4dqEHf2/TtNe40docj3VaZTak6yxwQhG9E7BjvhkX7oxnp3hwRUfJrHEA/8+f/4cjCUBw5AYNhfQmYI+a4toYelAk/j6RYneXPgboCa1eBJq+Le2e8UrNLj2e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559652; c=relaxed/simple;
	bh=b77tZn9qWfCDh0WqMB4A2NcqX0syX1GowClCnW7c9ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FxTGPDKDqS7EN28M5vRCcaNgZScwE60zysfvy8VYyzZwY2K5GmBy3/hIwj5GTHNVajWGsaCIBJQ8jEdvOGlrjAPbvrPZe6Gx1Ra1YDNuTCD4cSyyHOVwNZXXPAzmW09gadKBJGfojvZeasz/RxS93P0rJypuGPKKmkWa7Wxm6Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GcRrXaqf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749559649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b77tZn9qWfCDh0WqMB4A2NcqX0syX1GowClCnW7c9ZI=;
	b=GcRrXaqfd4bdoO+HZrOUhXa3PnSDxneWD7uUvUtpiBu8oMcOV8m/o5PndObG3U6GL7Ghco
	17aD1TsieHPmTvytaERpa+SQJJGJJc83v7sQPKKeGrBMTxwCHwtOqeBD98otS1FaWGPD1n
	zVDnkikq/ZMPZ+10JcSOloBGL6QSFZI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-LzrXtCmPPiemggo2Z0IOgQ-1; Tue,
 10 Jun 2025 08:47:27 -0400
X-MC-Unique: LzrXtCmPPiemggo2Z0IOgQ-1
X-Mimecast-MFC-AGG-ID: LzrXtCmPPiemggo2Z0IOgQ_1749559646
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6427C1800291;
	Tue, 10 Jun 2025 12:47:26 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.9])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7899C19560AB;
	Tue, 10 Jun 2025 12:47:25 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Cc: linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>
Subject: Re: [PATCH] pnfs: add pnfs_ds_connect trace point
Date: Tue, 10 Jun 2025 08:47:23 -0400
Message-ID: <F3C7A0A4-E8DB-406A-89FF-C44CA9201D44@redhat.com>
In-Reply-To: <20250610093451.835089-1-tigran.mkrtchyan@desy.de>
References: <20250610093451.835089-1-tigran.mkrtchyan@desy.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 10 Jun 2025, at 5:34, Tigran Mkrtchyan wrote:

> this trace point aims expose pnfs ds connect status

This tracepoint aims to expose pNFS DS connect status?

>
> Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>


Logic looks correct,

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


