Return-Path: <linux-nfs+bounces-903-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0785823669
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jan 2024 21:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1141F25D15
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jan 2024 20:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F02A1D530;
	Wed,  3 Jan 2024 20:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALvSUmtd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBADA1D529
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jan 2024 20:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704312992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47Fyyv/nkZfxAQAmcwzBTqt1nlPJHojM0fkLXTOXZko=;
	b=ALvSUmtdM1M7xpxVZREODQt1SyB8bThWK9Oj4QR/OezZ1bqwkK68Pewca/MXyAtw3wkGZo
	OkkNGUQyFqVyAIbOlM57jMHfE1RqHvfnEQFOppjp6tggWk5Rl9g4A5Ji78IqjZVoWJYJNC
	wzWNoQVq01j5W881ufBOcXbd3OvF9L8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-istUxocgPB66pf9NhJp_Bg-1; Wed, 03 Jan 2024 15:16:31 -0500
X-MC-Unique: istUxocgPB66pf9NhJp_Bg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B502A83DE2E;
	Wed,  3 Jan 2024 20:16:30 +0000 (UTC)
Received: from [100.85.132.103] (ovpn-0-5.rdu2.redhat.com [10.22.0.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FB2A2026D66;
	Wed,  3 Jan 2024 20:16:29 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: hangs during fstests testing with TLS
Date: Wed, 03 Jan 2024 15:16:28 -0500
Message-ID: <AB421B16-F1FD-414C-A9BE-652D868F03A9@redhat.com>
In-Reply-To: <D1091C94-9F23-47E9-A9CF-31CCEFE5EF8A@oracle.com>
References: <117352d5dc94d8f31bc6770e4bbb93a357982a93.camel@kernel.org>
 <ABBA5E37-2E13-4603-A79C-F9B9B8488AE3@redhat.com>
 <D1091C94-9F23-47E9-A9CF-31CCEFE5EF8A@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 3 Jan 2024, at 14:12, Chuck Lever III wrote:

>> On Jan 3, 2024, at 1:47=E2=80=AFPM, Benjamin Coddington <bcodding@redh=
at.com> wrote:
>>
>> This looks like it started out as the problem I've been sending patche=
s to
>> fix on 6.7, latest here:
>> https://lore.kernel.org/linux-nfs/e28038fba1243f00b0dd66b7c5296a1e1816=
45ea.1702496910.git.bcodding@redhat.com/
>>
>> .. however whenever I encounter the issue, the client reconnects the
>> transport again - so I think there might be an additional problem here=
=2E
>
> I'm looking at the same problem as you, Ben. It doesn't seem to be
> similar to what Jeff reports.
>
> But I'm wondering if gerry-rigging the timeouts is the right answer
> for backchannel replies. The problem, fundamentally, is that when a
> forechannel RPC task holds the transport lock, the backchannel's reply
> transmit path thinks that means the transport connection is down and
> triggers a transport disconnect.

Why shouldn't backchannel replies have normal timeout values?

> The use of ETIMEDOUT in call_bc_transmit_status() is... not especially
> clear.

Seems like it should mean that the reply couldn't be sent within (what
should be) the timeout values for the client's state management transport=
=2E

I'm glad you're seeing this problem too.  I was worried that something wa=
s
seriously different about my test setup.

Ben


