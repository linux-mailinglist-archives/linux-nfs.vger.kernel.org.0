Return-Path: <linux-nfs+bounces-13641-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEBBB26886
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Aug 2025 16:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B4005E796B
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Aug 2025 13:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ADF2FAC11;
	Thu, 14 Aug 2025 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RNXnqdIY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FAB3002D8
	for <linux-nfs@vger.kernel.org>; Thu, 14 Aug 2025 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179909; cv=none; b=CPjxe+O9l0jifZXIFwYogUJA9fqsVdu0oBQv+uSdkmUJoPXdopEInw7/+WebOrz29XcdDNfSzNkHOqsUqTC/SIzxWc2HxDlpMe0RGJB0Gef9NBL0lRDshnBpHBJf4/bJkh+1qY7zfiyo1/jeU8AYGljsWrlzT0dHpJ51mbVxWv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179909; c=relaxed/simple;
	bh=sSOFJuCWYYiK+YXIXDLuJyjRlD1/GyMURt7Sv0N6h+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nTnJaC9hT0oFkRKvMBs1zwZLlpJgSPcQ+mMyNKqfZ6bi/XzwrhJL33FaVmytL7hG28gYmHj6pRSIEbH/ZV+snyhL/Ak0LRSekqja5cxLUYnvxoaS8Ye7baSIFvNIgIlZU4i3z8RMicVOQFVkI/aIhrN1KpjxpH/eggkS5k0BqmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RNXnqdIY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755179906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cgpGla/B109kvRwEAs1an2xOE9xA/sCFYTKkztkpR1k=;
	b=RNXnqdIY5b+DcLsprQbODpSxqbSHdRzlt8jadiQ3/e3y7tIyR6QW/FhpANnJreD4pQG0mq
	6GykMdkvFSsnV2OXPuBPCsjWKlp8nN6qCEyVFAylHQp5q87ZWeE11P15vSEFsR3AtoUQ5E
	QH00mXv2f2BqmwhkxRutkf8lsI9VcA0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-4Yy1aqxeOGym0my7f1tQ0w-1; Thu,
 14 Aug 2025 09:58:20 -0400
X-MC-Unique: 4Yy1aqxeOGym0my7f1tQ0w-1
X-Mimecast-MFC-AGG-ID: 4Yy1aqxeOGym0my7f1tQ0w_1755179899
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AFA64180034A;
	Thu, 14 Aug 2025 13:58:19 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.8])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D75718003FC;
	Thu, 14 Aug 2025 13:58:18 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 "J . Bruce Fields" <bfields@fieldses.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFSv4.1: fix mount hang after CREATE_SESSION failure
Date: Thu, 14 Aug 2025 09:58:16 -0400
Message-ID: <60F16D3A-C453-49F6-91AC-955C0E727E4A@redhat.com>
In-Reply-To: <20250813090047.92365-3-ailiop@suse.com>
References: <20250813090047.92365-1-ailiop@suse.com>
 <20250813090047.92365-3-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 13 Aug 2025, at 5:00, Anthony Iliopoulos wrote:

> When client initialization goes through server trunking discovery, it
> schedules the state manager and then sleeps waiting for nfs_client
> initialization completion.
>
> The state manager can fail during state recovery, and specifically in
> lease establishment as nfs41_init_clientid() will bail out in case of
> errors returned from nfs4_proc_create_session(), without ever marking
> the client ready. The session creation can fail for a variety of reasons
> e.g. during backchannel parameter negotiation, with status -EINVAL.
>
> The error status will propagate all the way to the nfs4_state_manager
> but the client status will not be marked, and thus the mount process
> will remain blocked waiting.
>
> Fix it by adding -EINVAL error handling to nfs4_state_manager().

Looks correct, but consider reducing the scope of this change by handling
the error within nfs41_init_clientid() instead of modifying all the possible
paths that might return -EINVAL from the state manager.  IMO a comment about
-EINVAL probably resulting from improper negotiation would be nice as well.

Ben


