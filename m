Return-Path: <linux-nfs+bounces-11104-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F153A85BE3
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Apr 2025 13:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD3B1BA1FE1
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Apr 2025 11:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5523929DB65;
	Fri, 11 Apr 2025 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y4n/NGiZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10952980D4
	for <linux-nfs@vger.kernel.org>; Fri, 11 Apr 2025 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744371245; cv=none; b=i3JBWo/tEL2cTP5zzI6Yxsu4+mcROODv1K1V09xFnVdXfTEDum8fikQD8TlvgP+h2KU8AbLcqp2e1Q/MjFg0v01DSvKnyQ0q2gHtgdBOC87R/PLH62KZO7AJ62nSQc03e2p9PQcM3gXMG669FkWCcVlSNIW0ZJy4IG5PwMSQbIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744371245; c=relaxed/simple;
	bh=fqfbV9Vc1Er1kBXFhbcYcMwOxwBWBpYCkgE+t6I7iCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDHpzkDYlgjC/bXMDvBdap/IJWII3x6x0Mm5pIQoZUp0DvmYE+KKGvTFzhfg14qAOb/7ympPNIVUWyv5WfN4+dKDc3Rq7VtE1ycqBEy28atGHvvF92GDkO6hSSvnLRafFB+cFs8vqusyKfQ1thuk1MD2iQMuDHTAcBSNlvHy/oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y4n/NGiZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744371241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fqfbV9Vc1Er1kBXFhbcYcMwOxwBWBpYCkgE+t6I7iCQ=;
	b=Y4n/NGiZoWUCUxGG8ZL0kJDg8HDErInfkCrkmU8rVAVscTSEr0j5Dw4tShJPE9Q0ZUBbN8
	2DrC28VJs+sSAfnJ0uM5xDQ+ruAtHK0IjGT0iCOrkTnqslHHyi9ZqFNsw/pR9cT6HOS/iK
	2w5TSL1gaJmjlwMAEhyUgJ1EiBlwack=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-PNn_ELYGOS68OnU-1vgxbg-1; Fri,
 11 Apr 2025 07:33:57 -0400
X-MC-Unique: PNn_ELYGOS68OnU-1vgxbg-1
X-Mimecast-MFC-AGG-ID: PNn_ELYGOS68OnU-1vgxbg_1744371236
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 004FD1955BC9;
	Fri, 11 Apr 2025 11:33:56 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C4C2180175D;
	Fri, 11 Apr 2025 11:33:52 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: Re: [PATCH] nfs: direct: drop useless initializer in
 nfs_direct_write_completion()
Date: Fri, 11 Apr 2025 07:04:35 -0400
Message-ID: <60AFA87D-5FE2-4E0D-9949-FDDE144E2A1E@redhat.com>
In-Reply-To: <416219f5-7983-484b-b5a7-5fb7da9561f7@omp.ru>
References: <416219f5-7983-484b-b5a7-5fb7da9561f7@omp.ru>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 8 Apr 2025, at 16:53, Sergey Shtylyov wrote:

> In nfs_direct_write_completion(), the local variable req isn't used outside
> the *while* loop and is assigned to right at the start of that loop's body,
> so its initializer appears useless -- drop it; then move the declaration to
> the loop body (which happens to have a pointless empty line anyway)...
>
> Found by Linux Verification Center (linuxtesting.org) with the Svace static
> analysis tool.
>
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


