Return-Path: <linux-nfs+bounces-6973-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473DD996737
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 12:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049502858A8
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 10:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEE9158DB1;
	Wed,  9 Oct 2024 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KX560Hkl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04BB18D650
	for <linux-nfs@vger.kernel.org>; Wed,  9 Oct 2024 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728469575; cv=none; b=iWbLVbLgs4JTlmhibWqFeFGHqPsIaFXRstm0XLaFIhekTACPj6Z8yHINESRcVV4eisHxDxRJ4PC5iMTwe7X0VR62VyU3MzjrfTl3Vqi4h8fYeKTqW0lJUsnqoqRK+vBFV/Jv0fDvfHJXnH3+0/Ss4w4La3SOM8m2/oyEDFCsSPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728469575; c=relaxed/simple;
	bh=tdmvAC6jy4k6xbmOBIQPeDFDSxF4CQPxrX8+QDKTgCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYSiIMlgeXFGO0PHLYlOXceA4uNpHi9naKbifTN8lhwT+8e3yG96/3zMFuJLTlMT+W0FR+YQcn3ZxcwI8kOmqgGel8P6uRqmP1YuARG0tVXhx9xKXOjXx1qXLEKvht/XJMpSd6Bmfk4lWMJAqkDKAe1ZmOn2fWM9XeTcqC7lQJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KX560Hkl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728469572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+bAqRh+9TQwUTklmmkSlDcjLgkUZzuyNoiVkMsvCcu4=;
	b=KX560HklaB1/57Z2Exn7o9iJyBkS6jPXxYo+A0FZDipa/iVUk3ZcZHpBBItZ74AkFHmlK2
	xV/Wqyt4bkSk6905Jsy7LzQBNwEhJGTBP7PCQJ5aB2Oa2H337xdvFusRfbgzHNBwxwjiFk
	LGWIbR6vmkstQMUc5/DF5zWW1jMIWcI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-R2pUWn98M5CQmsBDiJQnAA-1; Wed,
 09 Oct 2024 06:26:11 -0400
X-MC-Unique: R2pUWn98M5CQmsBDiJQnAA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2E2619560A2;
	Wed,  9 Oct 2024 10:26:09 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D69F719560A2;
	Wed,  9 Oct 2024 10:26:08 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: NeilBrown <neilb@suse.de>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH] sunrpc: handle -ENOTCONN in xs_tcp_setup_socket()
Date: Wed, 09 Oct 2024 06:26:06 -0400
Message-ID: <CB9F2E14-F4E8-46B7-9AE1-669C1DCC605A@redhat.com>
In-Reply-To: <172845168634.444407.8582369591049332159@noble.neil.brown.name>
References: <172845168634.444407.8582369591049332159@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 9 Oct 2024, at 1:28, NeilBrown wrote:

> xs_tcp_finish_connecting() can return -ENOTCONN but the switch statemen=
t
> in xs_tcp_setup_socket() treats that as an unhandled error.
>
> If we treat it as a known error it would propagate back to
> call_connect_status() which does handle that error code.  This appears
> to be the intention of the commit (given below) which added -ENOTCONN a=
s
> a return status for xs_tcp_finish_connecting().
>
> So add -ENOTCONN to the switch statement as an error to pass through to=

> the caller.
>
> Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1231050
> Link: https://access.redhat.com/discussions/3434091
> Fixes: 01d37c428ae0 ("SUNRPC: xprt_connect() don't abort the task if th=
e transport isn't bound")
> Signed-off-by: NeilBrown <neilb@suse.de>

Thanks!  We should have chased this down ages ago..

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


