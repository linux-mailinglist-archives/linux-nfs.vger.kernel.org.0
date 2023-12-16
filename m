Return-Path: <linux-nfs+bounces-672-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 778B68158C6
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Dec 2023 12:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2061B23D24
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Dec 2023 11:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCC518EA4;
	Sat, 16 Dec 2023 11:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dlYDjst1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C90918EA0
	for <linux-nfs@vger.kernel.org>; Sat, 16 Dec 2023 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702725164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kbUn63ehNXbNRm7IvgtOu+OqSRZWaisPevjV5/xPinM=;
	b=dlYDjst1HkEvGE5p6gecTtSfd5xbxLvMDC/ndj4FtQa7AzzTzkxao8yNg2fEQAF2/6gwZ5
	LbE0af6Q28uUxd6Il64yJ+BDeHRaUZIG7xFA0vVnAA23Sosor5W7Vbks8u7ay566GHs7tq
	kYftdwJGUGdTgZJojjr0+hdfG94XYkQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-5gde3lhiNe-FGwnTQsSwTw-1; Sat, 16 Dec 2023 06:12:42 -0500
X-MC-Unique: 5gde3lhiNe-FGwnTQsSwTw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE03C185A780;
	Sat, 16 Dec 2023 11:12:41 +0000 (UTC)
Received: from [100.85.132.103] (ovpn-0-5.rdu2.redhat.com [10.22.0.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CF1B61C060B1;
	Sat, 16 Dec 2023 11:12:40 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, linux-nfs@vger.kernel.org,
 linux-nfs@stwm.de
Subject: Re: [PATCH 1/3 v2] SUNRPC: remove printk when back channel request
 not found
Date: Sat, 16 Dec 2023 06:12:39 -0500
Message-ID: <66BB600A-2C0D-457A-9A13-0F1D7F5E44B7@redhat.com>
In-Reply-To: <1702676837-31320-2-git-send-email-dai.ngo@oracle.com>
References: <1702676837-31320-1-git-send-email-dai.ngo@oracle.com>
 <1702676837-31320-2-git-send-email-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 15 Dec 2023, at 16:47, Dai Ngo wrote:

> If the client interface is down, or there is a network partition between
> the client and server, that prevents the callback request to reach the
> client TCP on the server will keep re-transmitting the callback for about
> ~9 minutes before giving up and closes the connection.
>
> If the connection between the client and the server is re-established
> before the connection is closed and after the callback timed out (9 secs)
> then the re-transmitted callback request will arrive at the client. When
> the server receives the reply of the callback, receive_cb_reply prints the
> "Got unrecognized reply..." message in the system log since the callback
> request was already removed from the server xprt's recv_queue.
>
> Even though this scenario has no effect on the server operation, a
> malicious client can take advantage of this behavior and send thousand
> of callback replies with random XIDs to fill up the server's system log.

I don't think this is a serious risk.  There's plenty of things a malicious
client can do besides try to fill up a system log.

This particular printk has been an excellent indicator of transport or
client issues over the years.  Seeing it in the log on a customer systems
shaves a lot of time off an initial triage of an issue.  Seeing it in my
testing environment immediately notifies me of what might be an otherwise
hard-to-notice problem.

Ben


