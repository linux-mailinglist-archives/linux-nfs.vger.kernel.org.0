Return-Path: <linux-nfs+bounces-924-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F355782419D
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 13:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1E0282AFD
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 12:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDE222310;
	Thu,  4 Jan 2024 12:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fI0+sBFd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AE722301
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jan 2024 12:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704370942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iiBMkZq2XMy0qt4hr0cDRU/ATU0snhiihOeJjiralw0=;
	b=fI0+sBFdggr1z0WHquVoNuH3g90OMpj4k0+kyK/NJbxZcrxM3owQA5m9MKYQX0TXUd9oLr
	YYn4WBs7B8iwSe9ZpM2EhEgr6EIG7zh+RzmHf7MtS3ZEmooKVfbytZQRXgMe4QKnDt22Ft
	TPgOWJEPp1zSfR2kkoXYxfTiLxBbKG0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-U6PTA6rqP7aFtCqNjfjk1w-1; Thu, 04 Jan 2024 07:22:21 -0500
X-MC-Unique: U6PTA6rqP7aFtCqNjfjk1w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9E2D848528;
	Thu,  4 Jan 2024 12:22:20 +0000 (UTC)
Received: from [100.85.132.103] (ovpn-0-5.rdu2.redhat.com [10.22.0.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1786E1C060AF;
	Thu,  4 Jan 2024 12:22:19 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: hangs during fstests testing with TLS
Date: Thu, 04 Jan 2024 07:22:18 -0500
Message-ID: <8C3DFB5D-B967-4D59-BFC5-7B25315DB9AB@redhat.com>
In-Reply-To: <DC58D77B-FC07-4B96-88A8-67F9ECDFD0CE@oracle.com>
References: <117352d5dc94d8f31bc6770e4bbb93a357982a93.camel@kernel.org>
 <ABBA5E37-2E13-4603-A79C-F9B9B8488AE3@redhat.com>
 <D1091C94-9F23-47E9-A9CF-31CCEFE5EF8A@oracle.com>
 <AB421B16-F1FD-414C-A9BE-652D868F03A9@redhat.com>
 <DC58D77B-FC07-4B96-88A8-67F9ECDFD0CE@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 3 Jan 2024, at 16:46, Chuck Lever III wrote:

>> On Jan 3, 2024, at 3:16=E2=80=AFPM, Benjamin Coddington <bcodding@redh=
at.com> wrote:
>>
>> On 3 Jan 2024, at 14:12, Chuck Lever III wrote:
>>
>>>> On Jan 3, 2024, at 1:47=E2=80=AFPM, Benjamin Coddington <bcodding@re=
dhat.com> wrote:
>>>>
>>>> This looks like it started out as the problem I've been sending patc=
hes to
>>>> fix on 6.7, latest here:
>>>> https://lore.kernel.org/linux-nfs/e28038fba1243f00b0dd66b7c5296a1e18=
1645ea.1702496910.git.bcodding@redhat.com/
>>>>
>>>> .. however whenever I encounter the issue, the client reconnects the=

>>>> transport again - so I think there might be an additional problem he=
re.
>>>
>>> I'm looking at the same problem as you, Ben. It doesn't seem to be
>>> similar to what Jeff reports.
>>>
>>> But I'm wondering if gerry-rigging the timeouts is the right answer
>>> for backchannel replies. The problem, fundamentally, is that when a
>>> forechannel RPC task holds the transport lock, the backchannel's repl=
y
>>> transmit path thinks that means the transport connection is down and
>>> triggers a transport disconnect.
>>
>> Why shouldn't backchannel replies have normal timeout values?
>
> RPC Replies are "send and forget". The server forechannel sends
> its Replies without a timeout. There is no such thing as a
> retransmitted RPC Reply (though a reliable transport might
> retransmit portions of it, the RPC server itself is not aware of
> that).
>
> And I don't see anything in the client's backchannel path that
> makes me think there's a different protocol-level requirement
> in the backchannel.

Its not strictly a protocol thing, the timeouts are used to decide what t=
o
do with a req or flag the transport state even if the request doesn't mak=
e
it to the wire.  That's why the zero timeout values for this req improper=
ly
resets the transport.

Ben


