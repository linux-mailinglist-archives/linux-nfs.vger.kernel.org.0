Return-Path: <linux-nfs+bounces-1442-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2033483CF2B
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 23:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D9AAB2184E
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 22:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE9C13AA22;
	Thu, 25 Jan 2024 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6flL4lT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F564131E4F
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 22:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706220575; cv=none; b=jrqxss3MmegSu1XlfbcKSYvg1nky1Y5OiVDrdyg/ISDPraP1J46l+YHi3S5GcLi7SGNbfvQBon8j7NnHroKavrgT87AMBADXUFA5m6cq3Nd1SqreZihZd6w44vUIKdzc+UZQPFQPndXA0cSedW3Z/XKcW9sjMKLaoSiHm+lkg6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706220575; c=relaxed/simple;
	bh=lNFnRJOt+0ADuqEskL/6OB4nWsMNxc9YQkfLCsfWV3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6inicqPUtUIGXJAr0VhJ6lLbtWyFsEarrzeIxeW5X0GujOLXnluQideIuh45rFY3oK+78CQlOlH0bnA5Dmq0EvlEigpQO3xLk2uSOcfkm/Y63E7W38/5Is0lGmAfsiG02Ox/ZrIuJ51J16MyDv6BBH1BC3SZhQDrH+Ax9xTRWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6flL4lT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706220573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bGIdeiRena7NFn+xlwN7108DTM5j8uMoSIKS3E3IcvE=;
	b=d6flL4lT/MrIjiY1Osi93Gm8MUKQAVPzmivfc90Bxv9yWblHxFslEcMl9nzKXCxcDN7u5D
	LtHfgGWfmIxZ5TeGEw15avF5PZyUdkkP2H0RTzotv+Fh7YSscGXQcNHySb6Xzfam0iP4zt
	wrcwfaEeN30pYyEMsimm1j2pCdaoBYs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-PbvUFyIuOZ-pQz1GkI7gnw-1; Thu, 25 Jan 2024 17:09:29 -0500
X-MC-Unique: PbvUFyIuOZ-pQz1GkI7gnw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8286F85A588;
	Thu, 25 Jan 2024 22:09:29 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-9.rdu2.redhat.com [10.22.0.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 17CC32A79;
	Thu, 25 Jan 2024 22:09:28 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 00/13] NFSD backchannel fixes
Date: Thu, 25 Jan 2024 17:09:27 -0500
Message-ID: <0DCE1190-19FA-46BD-822D-6984F0B5B296@redhat.com>
In-Reply-To: <170619984210.2833.7173004255003914651.stgit@manet.1015granger.net>
References: <170619984210.2833.7173004255003914651.stgit@manet.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 25 Jan 2024, at 11:28, Chuck Lever wrote:

> The first three patches fix bugs that prevent NFSD's backchannel
> from reliably retransmitting after a client reconnects. These fixes
> might be appropriate for 6.8-rc.
>
> Following that are some new trace points that might be helpful for
> field troubleshooting.
>
> Then there are some minor clean-ups.
>
> I am still testing this series, and there is one msleep() call that
> needs some thought. Thoughts, comments, opinions, rotten fruit? You
> know the drill.
>
> ---
>
> Chuck Lever (13):
>       NFSD: Reset cb_seq_status after NFS4ERR_DELAY
>       NFSD: Reschedule CB operations when backchannel rpc_clnt is shut down
>       NFSD: Retransmit callbacks after client reconnects
>       NFSD: Add nfsd_seq4_status trace event
>       NFSD: Replace dprintks in nfsd4_cb_sequence_done()
>       NFSD: Rename nfsd_cb_state trace point
>       NFSD: Add callback operation lifetime trace points
>       SUNRPC: Remove EXPORT_SYMBOL_GPL for svc_process_bc()
>       NFSD: Remove unused @reason argument
>       NFSD: Replace comment with lockdep assertion
>       NFSD: Remove BUG_ON in nfsd4_process_cb_update()
>       SUNRPC: Remove stale comments
>       NFSD: Remove redundant cb_seq_status initialization
>
>
>  fs/nfsd/nfs4callback.c   |  81 +++++++++++++-------
>  fs/nfsd/nfs4state.c      |   1 +
>  fs/nfsd/trace.h          | 162 ++++++++++++++++++++++++++++++++++++++-
>  include/trace/misc/nfs.h |  34 ++++++++
>  net/sunrpc/svc.c         |   1 -
>  net/sunrpc/xprtsock.c    |   9 ---
>  6 files changed, 250 insertions(+), 38 deletions(-)


These are great, looking forward to see how 02/13 waits for reconnection.
Seems like a wait_on_bit or wait_on_var triggered from nfsd4_init_conn()
would do, but that's just my wild speculation.

Ben


