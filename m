Return-Path: <linux-nfs+bounces-8877-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 642729FFB1E
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 16:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FDAE16263F
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 15:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39ABC79D2;
	Thu,  2 Jan 2025 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L42fhhzO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981964C9A
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jan 2025 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735832840; cv=none; b=CVtweWb0Hw3Tsw0WfKGhoS4LVdoxBxfY8Uwgv1MkLYe0kZY9l4ilUEJ2X3Uw5nbCCpNvACaDK6sJ6bg6lH2IPPg8wpGGEAdUCATzmlUrErmyLHLlXyPpgxy0W3k8CIjAfmEZLGFdAkPCM/GxpOwJdKhs3VS1f8kBEsqVDfeqzO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735832840; c=relaxed/simple;
	bh=Oegk7Gp/UTX1cQi/LwjDP5HPjBHMcV6NHu/kAiuB+ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ArKwr918LJ3fM69vS10cmcNBV7lCD2jU3Qk83ovWilYqvAESpI+U5BCboKfGqIvib2x4HHxEUEwhKeX3t+NrcMjmrKl9lXpwwaPu1esqERXiDuQxyBUPn7SyCJOR4bGMm2gkUoEm7m4nSVFbniWq7fUPYrkYQH8dPP9NE64ZLyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L42fhhzO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735832837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oegk7Gp/UTX1cQi/LwjDP5HPjBHMcV6NHu/kAiuB+ns=;
	b=L42fhhzOrRrgS42At+fNMcPPR/i1OpiaT2X9NZdREkWp2o1/GgC/pL+TsSRain50Q5VmvD
	NhFH515D8g7hq2bMNWwFNqcgiGTnE6M0Yi9iyw7oLDi7d1hzxpK9Teg1J/cO+QVW+Hkozt
	GBfVhPG0XAi3zRYVsRzN8v3vvI5Cocs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-phTmnevzPjiayMqmh_UMLw-1; Thu,
 02 Jan 2025 10:47:15 -0500
X-MC-Unique: phTmnevzPjiayMqmh_UMLw-1
X-Mimecast-MFC-AGG-ID: phTmnevzPjiayMqmh_UMLw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44D8E19560AB;
	Thu,  2 Jan 2025 15:47:14 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.76.8])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E81D3000197;
	Thu,  2 Jan 2025 15:47:13 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Yongcheng Yang <yongcheng.yang@gmail.com>
Cc: Steve Dickson <steved@redhat.com>,
 Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsdctl: manpage fix a few typos
Date: Thu, 02 Jan 2025 10:47:11 -0500
Message-ID: <8E7C7E4E-D1D5-437F-BF19-6C1031B3B792@redhat.com>
In-Reply-To: <20241230094407.442310-1-yongcheng.yang@gmail.com>
References: <20241230094407.442310-1-yongcheng.yang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 30 Dec 2024, at 4:43, Yongcheng Yang wrote:

> Signed-off-by: Yongcheng Yang <yongcheng.yang@gmail.com>

Looking good.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


