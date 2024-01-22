Return-Path: <linux-nfs+bounces-1271-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32826837671
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 23:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFCFB283A6E
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 22:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6C4FC14;
	Mon, 22 Jan 2024 22:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ju6fNpgd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069CAFC10
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jan 2024 22:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705963285; cv=none; b=PuFBt+XdqdurPvlsmPMkl6QlpzEwXNZUBXDO+eMm+lYVNepayVPcGrkCj8vtrLExZudzXxWkHHqmBMzkFHsodUlAdbQjWizh2hVOIIlMHjZ0oCnSoHMhN9vmSZvVvqz93WaBu1esIF9VzhG5nRoycgzPDAQGyZ0367fNk9iQ2ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705963285; c=relaxed/simple;
	bh=3j6GqGjdcVOdaKJA0dBzQfKAJjOTVWmREQGj6P72nBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=swLhQnkKyhRXKzhah4R4imFRJgapqsbpC+LdnbpdqdqxcsagjY8CRa9+ZJkaGxBkNqvIMTzPUOd58QwZGcYSZKMsQmazuRRqWk5D4KGp7EIrrSlFbFbJdS3sTqCQ9VK279nLr7oVsAdP6Gva4vGXCbEC6eu9Gvp1ZvXv39Izj6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ju6fNpgd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705963282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K/2PdJgSTx2uUSt20DAeZ0+0dOQapF/NLseso94+mY0=;
	b=Ju6fNpgdLw4IXb9TguaHlWdp4pLTVoJLzSy2eqlEcxOaUMKl+uQpmAIFW3JbMUV70I5ix+
	qN59E+oHT/Hy0KvVxJltNilXw2kZCu9xjP4qvu50bfL6EAo/YDXmioXNaMPzrcrIfXDUkb
	+9XIqelNZBNiA7SC9Jhr+/jt+VErKxk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-KHOIm_EWOXKHLv-7Jky7pA-1; Mon,
 22 Jan 2024 17:41:21 -0500
X-MC-Unique: KHOIm_EWOXKHLv-7Jky7pA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D75201C03D83;
	Mon, 22 Jan 2024 22:41:20 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-9.rdu2.redhat.com [10.22.0.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 455B11C060AF;
	Mon, 22 Jan 2024 22:41:20 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Cc: chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH  1/1] NFSv4.1: Assign retries to timeout.to_retries
 instead of timeout.to_initval
Date: Mon, 22 Jan 2024 17:41:18 -0500
Message-ID: <995F0BB9-C709-4C3A-92F3-5EB9710A47F5@redhat.com>
In-Reply-To: <20240122172353.2859254-1-samasth.norway.ananda@oracle.com>
References: <20240122172353.2859254-1-samasth.norway.ananda@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 22 Jan 2024, at 12:23, Samasth Norway Ananda wrote:

> In the else block we are assigning the req->rq_xprt->timeout->to_retries
> value to timeout.to_initval, whereas it should have been assigned to
> timeout.to_retries instead.
>
> Fixes: 57331a59ac0d (“NFSv4.1: Use the nfs_client's rpc timeouts for backchannel")
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> ---
> Hi,
>
> I came across the patch 57331a59ac0d (“NFSv4.1: Use the nfs_client's rpc
> timeouts for backchannel") which assigns value to same variable in the
> else block.  Can I please get your input on the patch?

Oh yes, this a good fix.  Usually the maintainers won't pick up a patch
that's only sent to the list, rather the patch should be addressed to them
directly and copied to the list.  Can you re-send this patch to:

Trond Myklebust <trond.myklebust@hammerspace.com>,Anna Schumaker <anna@kernel.org>

and copy linux-nfs@vger.kernel.org?  You can also add my:

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


