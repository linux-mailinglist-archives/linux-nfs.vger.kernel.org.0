Return-Path: <linux-nfs+bounces-13638-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D6AB267E3
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Aug 2025 15:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449321B657A6
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Aug 2025 13:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C067B309DAD;
	Thu, 14 Aug 2025 13:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1iuO4A5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0347D15D3
	for <linux-nfs@vger.kernel.org>; Thu, 14 Aug 2025 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178304; cv=none; b=iUlqS76erm+UiW4jnmQXxuuIPAKDQvlDMWs4p1gISrwC44L+oiHrwKqNf7upOE7Wg00vXTlYcl8NwCzd7/bW3gHjXqlm8wxUkoawtTjEO0Xoo0Y4USzkwIXnu/gNpgdro72nkggBx5weVCeIAKGjbko9SH4wkgFYueUgxhWLhwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178304; c=relaxed/simple;
	bh=I9O88fkwMozSYRbHLHC30fwNaXQzqb6bfN3mwo14tKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1B4OwfmN10fKWIslC4dhaf7Q5rCxEuE5jzMSwSF4EmSqP56YgA1+QA/oWRz5YabDcPLT3+UXOtdzqz6ZB4WRY0cmQdMz7yvLjT8t4GNpx0XGP4S/MlxmhrNwT4Qv7ZKx1PETRfNRZXyCSRDVbMqc+tUnUItvVRfgVDXk/wixkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W1iuO4A5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755178301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I9O88fkwMozSYRbHLHC30fwNaXQzqb6bfN3mwo14tKw=;
	b=W1iuO4A5TKFD6Gd9XeYo4dkCf38wKEHLRAGMgK+fXEZgcMFZokM66YD8K6PmMfzk3VadKe
	Cl8P3SGeeU395zVIZAx2hAL59XXZnf4PBvEIFuHKSA8QK5MS5lkiP9nL9x+dfhkRB04lAn
	v1hd4dObGPgkXTuwgKyzHyB98/ecndw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-fVoemncoM4qmFqgOm73_-g-1; Thu,
 14 Aug 2025 09:31:37 -0400
X-MC-Unique: fVoemncoM4qmFqgOm73_-g-1
X-Mimecast-MFC-AGG-ID: fVoemncoM4qmFqgOm73_-g_1755178296
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0BFE1955BF1;
	Thu, 14 Aug 2025 13:31:35 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.8])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8AADE19A4C99;
	Thu, 14 Aug 2025 13:31:34 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 "J . Bruce Fields" <bfields@fieldses.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] NFSv4.1: fix backchannel max_resp_sz verification
 check
Date: Thu, 14 Aug 2025 09:31:32 -0400
Message-ID: <5EA445D9-D203-439E-ADCA-56D4C126ABFB@redhat.com>
In-Reply-To: <20250813090047.92365-2-ailiop@suse.com>
References: <20250813090047.92365-1-ailiop@suse.com>
 <20250813090047.92365-2-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 13 Aug 2025, at 5:00, Anthony Iliopoulos wrote:

> When the client max_resp_sz is larger than what the server encodes in
> its reply, the nfs4_verify_back_channel_attrs() check fails and this
> causes nfs4_proc_create_session() to fail, in cases where the client
> page size is larger than that of the server and the server does not want
> to negotiate upwards.
>
> While this is not a problem with the linux nfs server that will reflect
> the proposed value in its reply irrespective of the local page size,
> other nfs server implementations may insist on their own max_resp_sz
> value, which could be smaller.
>
> Fix this by accepting smaller max_resp_sz values from the server, as
> this does not violate the protocol. The server is allowed to decrease
> but not increase proposed the size, and as such values smaller than the
> client-proposed ones are valid.
>
> Fixes: 43c2e885be25 ("nfs4: fix channel attribute sanity-checks")
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


