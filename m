Return-Path: <linux-nfs+bounces-1508-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 841F183E31D
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 21:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76EF1C20ADD
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 20:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35E02260B;
	Fri, 26 Jan 2024 20:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BlonL15R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FD0224CF
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 20:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706299839; cv=none; b=ELtdIaLTAzdp5jTA3cisyr8baFTjstldgiHNWDymWGeyK7fitQOdv1Ko1OtGrcgIwW9UMh0sdpZcVqXwETWuUzdqoU3GmIkqqkoO69OIjnVpWbDuKWGaUbw0ldqDqtjTUiCHuxtr5j6f+U4aws3V7QaixOWPOJ3e4gQZuAAvAVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706299839; c=relaxed/simple;
	bh=d3VXE4acxFSA0cI48sTSdL7XV+h1CFhc7ZTfA/tPLWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LNHmbJOdR6go7xlseriPmwmsTLCf1dNIeQvyRUaIgXfmbYM3gg30yUwboWRHxjOzOlHvoO7LuhYunBwGYBA9axlLxNvOJ4UlPDmyzVzG+ViCEPE/TILS92wBnjwahkruIih1jd+ZplODgrWZWvfc2w46C1PUPtIuKUCm2p6X/rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BlonL15R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706299837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1LPFG6aKjzjxpUdEv6klXk2UNMJAUY116NxMyg8UUQA=;
	b=BlonL15RFJ+yrXxulVcyzMgX5fm9CLZDc1GxeoH1V4K4NPg0auN1Rs0ccpbSmmvGGo6g99
	CqmeuSgcUOUt355bdJXJmx9q4xricr4VLJhlYcv65d2drBAGPfZiWbPyBStjwziZbW8TV9
	2pxX5dsRNY6U7fqFrO+lvxP5UBtWXSY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-WIG8p9JaOEilA9iiSkDcZw-1; Fri,
 26 Jan 2024 15:10:35 -0500
X-MC-Unique: WIG8p9JaOEilA9iiSkDcZw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D446A3C0F379;
	Fri, 26 Jan 2024 20:10:34 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-9.rdu2.redhat.com [10.22.0.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 64765400D288;
	Fri, 26 Jan 2024 20:10:34 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2 00/14] NFSD backchannel fixes
Date: Fri, 26 Jan 2024 15:10:33 -0500
Message-ID: <CC794516-7A7B-4768-99CB-AA8F47B43625@redhat.com>
In-Reply-To: <170629091560.20612.563908774748586696.stgit@manet.1015granger.net>
References: <170629091560.20612.563908774748586696.stgit@manet.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 26 Jan 2024, at 12:45, Chuck Lever wrote:

> The first four patches fix bugs that prevent NFSD's backchannel
> from reliably retransmitting after a client reconnects.
>
> Following that are some new trace points that might be helpful for
> field troubleshooting.
>
> Then there are some minor clean-ups.
>
> Changes since RFC:
> - Replace the msleep with queue_delayed_work
> - Refinements to patch descriptions
>
> ---
>
> Chuck Lever (14):
>       NFSD: Reset cb_seq_status after NFS4ERR_DELAY
>       NFSD: Convert the callback workqueue to use delayed_work
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
>  fs/nfsd/nfs4callback.c   |  94 +++++++++++++++--------
>  fs/nfsd/nfs4state.c      |   1 +
>  fs/nfsd/state.h          |   2 +-
>  fs/nfsd/trace.h          | 162 ++++++++++++++++++++++++++++++++++++++-
>  include/trace/misc/nfs.h |  34 ++++++++
>  net/sunrpc/svc.c         |   1 -
>  net/sunrpc/xprtsock.c    |   9 ---
>  7 files changed, 261 insertions(+), 42 deletions(-)
>
> --
> Chuck Lever

These all make sense, even to me.  For the series:

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


