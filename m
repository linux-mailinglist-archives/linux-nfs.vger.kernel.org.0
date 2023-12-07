Return-Path: <linux-nfs+bounces-385-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B73808BBD
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Dec 2023 16:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C7BCB20F10
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Dec 2023 15:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AF5125C5;
	Thu,  7 Dec 2023 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LExgvIrv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EC510C8
	for <linux-nfs@vger.kernel.org>; Thu,  7 Dec 2023 07:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701962733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=F+UERlAVBNrKhIpPSImkkZ/r+K7X+hTRoCxWoekUWYs=;
	b=LExgvIrvZgA+1Up2cVhDYo3G2Ym73uDj1k9VHj4pjYXRbW7/QUxObQBFZJLjSrTSNfMpmg
	1stdj3YM2Psk7qpI0vrKeL0s0aJSb3zuHjEYkOUGTI8BMJ7qXvzrEhOvjnjhyI5JaLpUnW
	pQn03Ui7v2xJYjVWil1GmicBArJpex8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-fsfq9tK2PH6fCBfkDN1WVw-1; Thu,
 07 Dec 2023 10:25:30 -0500
X-MC-Unique: fsfq9tK2PH6fCBfkDN1WVw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EED103C2865F;
	Thu,  7 Dec 2023 15:25:28 +0000 (UTC)
Received: from [100.85.132.103] (unknown [10.22.48.3])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 86B042166B35;
	Thu,  7 Dec 2023 15:25:28 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: spurious backchannel -ETIMEDOUT and reset on v6.7-rc1
Date: Thu, 07 Dec 2023 10:25:27 -0500
Message-ID: <3B324BE9-874E-487E-B6E4-E83889B30803@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Hey Trond,

I've been noticing slower than usual xfstests, and in the logs:

 "RPC: Could not send backchannel reply error: -110"

Since "59464b262ff5 SUNRPC: SOFTCONN tasks should time out when on the
sending list", some backchannel reqs will immediately reset the connection
if they need to sleep on ->sending in xprt_reserve_xprt.

I don't think we set up rq_timeout and rq_majortimeout for backchannel reqs,
so they immediately fail with -ETIMEDOUT.

I'm hunting around for the best fix, but maybe you've got one I can test.

Ben


