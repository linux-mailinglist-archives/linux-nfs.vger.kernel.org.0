Return-Path: <linux-nfs+bounces-12435-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F320AD8A21
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 13:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004EE3BBCF4
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 11:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3B82D5C9C;
	Fri, 13 Jun 2025 11:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WzK77KVZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6252D5C99
	for <linux-nfs@vger.kernel.org>; Fri, 13 Jun 2025 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749813167; cv=none; b=B97tkZTA61GOtgYgCEM6ocwhUBpbHiiYekfTsL3zb+7gLSL1MaQEqi6uF0K1lEqLhlUaVSQELm/Mcufo8D73upnuOrmDpSxwGY9tlNP3KRa3Bm4Lpd/e0ZLYEQhgzTuqKvB5o3JJByo7s+Y3bvc8JQ5R8+fZllafZg734jH1Ay8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749813167; c=relaxed/simple;
	bh=PgNc7QFUovbYhLuEETU7nw9Y12LU5Lx/D7BcnKha1VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBjoc/NsPbkMln956fjhAGrgU1SSo11rwUbmHI1wMk9jqpm85RvWUqmpe4Ee/Zm4LOD9OuZW7KcDh1FEYa/eHSr038SAUEQevAW6MJLWHzcmu5iMeFYIOTKcZ89DxaXtrLY//gYAFU9FLa5yqGHgI1r9PbGwI8e9ejWOlMLQDoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WzK77KVZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749813162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PgNc7QFUovbYhLuEETU7nw9Y12LU5Lx/D7BcnKha1VQ=;
	b=WzK77KVZjJks6T3KF6AlsdKqmH35nQoSrO+7pMvvdhnPyZ5MK8dC4fYliLDW+taLFr+Ryx
	7U+yRj/3iMTueYSOTE3YSR9DdZeFFE0hBrVMYyNzcc1Zk8VQ8MlhlUWNyb821OgRVnzpmE
	8higtbLG5hKEVla7sbuoy4x9xCclPG8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-5BhG2lY5PT-Fyqmt0YI2yw-1; Fri,
 13 Jun 2025 07:12:38 -0400
X-MC-Unique: 5BhG2lY5PT-Fyqmt0YI2yw-1
X-Mimecast-MFC-AGG-ID: 5BhG2lY5PT-Fyqmt0YI2yw_1749813157
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BF441956080;
	Fri, 13 Jun 2025 11:12:37 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.9])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCE5B30044CC;
	Fri, 13 Jun 2025 11:12:36 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Nikhil Jha <njha@janestreet.com>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] sunrpc: fix loop in gss seqno cache
Date: Fri, 13 Jun 2025 07:12:34 -0400
Message-ID: <6C5A0113-E08B-4C5D-B2D2-85FBEADE30F8@redhat.com>
In-Reply-To: <20250611-fix-loop-in-seqno-cache-v1-1-9f9214d60dbf@janestreet.com>
References: <20250611-fix-loop-in-seqno-cache-v1-1-9f9214d60dbf@janestreet.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11 Jun 2025, at 15:46, Nikhil Jha via B4 Relay wrote:

> From: Nikhil Jha <njha@janestreet.com>
>
> There was a silly bug in the initial implementation where a loop
> variable was not incremented. This commit increments the loop variable.
>
> This bug is somewhat tricky to catch because it can only happen on loops
> of two or more. If it is hit, it locks up a kernel thread in an infinite
> loop.
>
> Signed-off-by: Nikhil Jha <njha@janestreet.com>
> Tested-by: Nikhil Jha <njha@janestreet.com>

Fixes: 08d6ee6d8a10 ("sunrpc: implement rfc2203 rpcsec_gss seqnum cache")
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


