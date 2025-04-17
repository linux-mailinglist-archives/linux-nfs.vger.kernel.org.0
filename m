Return-Path: <linux-nfs+bounces-11156-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEABA91CCA
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Apr 2025 14:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99FA178A10
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Apr 2025 12:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEC411CAF;
	Thu, 17 Apr 2025 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJKKUPDJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF4528E37
	for <linux-nfs@vger.kernel.org>; Thu, 17 Apr 2025 12:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744894136; cv=none; b=T9axLWaOqW7rj7HpxKWiKosC+6ntVak79hGzdjpK2pdKNYIjT8KthKxvnGfLBbrlkcN0QOGocCw6qxfxdSgcpu621wbrOIby7djyx3Z3tenrqth7CVs9ZYcC9OxSugwDDOssGFYI9wUFDW+sc6GIsdzcMlGbGxruniocnxT7hKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744894136; c=relaxed/simple;
	bh=OF+xWYvtq8DwTqbmiS1xaxSCtLJkP0UYS7V6sI7D3rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ksYxuuLBQIpFcE7duZWQuDP3Mr+o6Fd8IrWZN4Aj3bq+RvlJHcN8mNNqhLtitpVQTCL5VB6DPM1iMQFpMnA+xBE1yrAE/JEKtbuyufrCq33WuUdaH+BoGldqK11GOPPHfGhEMFY2g5pv9VJCtxDzBNAwUQtxszVLzVHNb1nN3gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJKKUPDJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744894134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OF+xWYvtq8DwTqbmiS1xaxSCtLJkP0UYS7V6sI7D3rY=;
	b=VJKKUPDJEM+ZrgHCawCBBulEcr4uFjkrkpcQ8RmVgb7g/JmB7Q10ewelv02GCojt3Dw4Jx
	d0zOC+xcsfBWth5qe6T20kSsZMhjbMJ/Em6y/LfzUamSRGJxy634p4JBG3EO93YLKAVyTf
	Jpk/dpZKC4wiKWCVWL8Fihgmzg98TgY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-y7TS2U--NeqV2NEZGbHBtg-1; Thu,
 17 Apr 2025 08:48:52 -0400
X-MC-Unique: y7TS2U--NeqV2NEZGbHBtg-1
X-Mimecast-MFC-AGG-ID: y7TS2U--NeqV2NEZGbHBtg_1744894130
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96D751956048;
	Thu, 17 Apr 2025 12:48:50 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.16])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4CC5180176F;
	Thu, 17 Apr 2025 12:48:48 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: allow SC_STATUS_FREEABLE when searching via
 nfs4_lookup_stateid()
Date: Thu, 17 Apr 2025 08:48:46 -0400
Message-ID: <1F8D33B0-6844-4DD6-A673-7EA1F63EDF82@redhat.com>
In-Reply-To: <20250212-nfsd-fixes-v1-1-935e3a4919fc@kernel.org>
References: <20250212-nfsd-fixes-v1-1-935e3a4919fc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 12 Feb 2025, at 11:29, Jeff Layton wrote:

> When a delegation is revoked, it's initially marked with
> SC_STATUS_REVOKED, or SC_STATUS_ADMIN_REVOKED and later, it's marked
> with the SC_STATUS_FREEABLE flag, which denotes that it is waiting for
> s FREE_STATEID call.
>
> nfs4_lookup_stateid() accepts a statusmask that includes the status
> flags that a found stateid is allowed to have. Currently, that mask
> never includes SC_STATUS_FREEABLE, which means that revoked delegations
> are (almost) never found.
>
> Add SC_STATUS_FREEABLE to the always-allowed status flags.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> This fixes the pynfs DELEG8 test.

I want to follow-up this patch with the report that this will fix quite
severe TEST_STATEID/FREE_STATEID storms from NFS clients that can never
satisfy the server's setting SEQ4_STATUS_*_STATE_REVOKED status bits.

Correct accounting on the server's cl_revoked counter is pretty important, I
do wish the protocol had something like a per-client global window of valid
state.

Thanks Jeff (and thanks Olga for the original fix!),

Ben


