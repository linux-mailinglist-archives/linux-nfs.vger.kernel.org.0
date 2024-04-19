Return-Path: <linux-nfs+bounces-2894-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027D38AAEBC
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Apr 2024 14:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6143DB21E3F
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Apr 2024 12:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A051EB45;
	Fri, 19 Apr 2024 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1X4vRoS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F92BE66
	for <linux-nfs@vger.kernel.org>; Fri, 19 Apr 2024 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713530566; cv=none; b=iwTpznPf/tSSgyG9PosKBMeZeek1buNZOy2qglRV/I/L+fW2pwVh9Z42xnqHneVZ1xVTKpI3J6/knRJlPoCIEKhWjof9tqrMXYsmG4zW0rszEC9L3Gb5tuoyAAdCNzBOfvpOsHrxAKiWlF5S0+UTLQN+i0EFFwQFG16qnhIZUIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713530566; c=relaxed/simple;
	bh=XdyT0PlB+jG+Mpf/fZ7yygYfun2PeHFv1GoK7IDDbjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJoAKh2hki1IQ8BZ0W4jxs/HwFXjRjJ8OtVEENtVzWsG2mrp/Ch2p5IF4AtXeTWEhifK91jZs8JsOB5jYalBFxgUMy02Gt0pgE3LempL+w5IxEqdYzQCOWF9YjbG8eZyZ1ygZRw9nG+jF3Wc3LA/jhuPJHqtkFfNxjnZqkmBcHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g1X4vRoS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713530563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XdyT0PlB+jG+Mpf/fZ7yygYfun2PeHFv1GoK7IDDbjE=;
	b=g1X4vRoSuoFpCbvgIUoQGgnHKIoo/EchsJwnHhZw5RkDcZW2E+l9vQxLWsTOTrmGzRYXXd
	KbLKS8Hi0KCEis3p1x+MU/LNUPPsauUKo3gENgevVMqwXNpTHapr9DWOQNueJuMM64S6LW
	5R6oZgFLvZ8LaLWX2+e6SM5fHicBmhA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-lQgz5HcyMYyOHmd0kQKfuw-1; Fri,
 19 Apr 2024 08:42:41 -0400
X-MC-Unique: lQgz5HcyMYyOHmd0kQKfuw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FF733C3D0DD;
	Fri, 19 Apr 2024 12:42:41 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-6.rdu2.redhat.com [10.22.0.6])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9515A20296D2;
	Fri, 19 Apr 2024 12:42:40 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc: trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] SUNRPC: fix handling expired GSS context
Date: Fri, 19 Apr 2024 08:42:39 -0400
Message-ID: <B4EFE333-F2BD-4D44-9AB7-C659BE32BA59@redhat.com>
In-Reply-To: <20240418141104.95269-1-olga.kornievskaia@gmail.com>
References: <20240418141104.95269-1-olga.kornievskaia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 18 Apr 2024, at 10:11, Olga Kornievskaia wrote:

> From: Olga Kornievskaia <kolga@netapp.com>
>
> In the case where we have received a successful reply to an RPC request,
> but while processing the reply the client in rpc_decode_header() finds
> an expired context, the code ends up propagating the error to the caller
> instead of getting a new context and retrying the request.
>
> To give more details, in rpc_decode_header() we call rpcauth_checkverf()
> will call into the gss and internally will at some point call
> gss_validate() which has a check if the current’s context lifetime
> expired, and it would fail. The reason for the failure gets ‘scrubbed’
> and translated to EACCES so when we get back to rpc_decode_header() we
> just go to “out_verifier” which for that error would get converted to
> “out_garbage” (ie it’s treated as garballed reply) and the next
> action is call_encode. Which (1) doesn’t reencode or re-send (not to
> mention no upcall happens because context expires as that reason just
> not known) and it again fails in the same decoding process. After
> re-trying it 3 times the error is propagated back to the caller
> (ie nfs4_write_done_cb() in the case a failing write).
>
> To fix this, instead we need to look to the case where the server
> decides that context has expired and replies with an RPC auth error.
> In that case, the rpc_decode_header() goes to "out_msg_denied" in that
> we return EKEYREJECTED which in call_decode() is sent to “call_reserve”
> which triggers an upcalls and a re-try of the operation.
>
> The proposed fix is in case of a failed rpc_decode_header() to check
> if credentials were set to be invalid and use that as a proxy for
> deciding that context has expired and then treat is same way as
> receiving an auth error.
>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>
> --- This looks like a day-0 problem and should probably be back
> ported to earlier kernels.

Looks good to me.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


