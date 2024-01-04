Return-Path: <linux-nfs+bounces-931-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB258243EF
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 15:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF4E1C2202B
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 14:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E0F23746;
	Thu,  4 Jan 2024 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfJIaaE5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5BE23748
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jan 2024 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704379048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YrAJiMEjZmBOWseOGv48NIkqtNeAWXDk7qk1Q/c5Ig8=;
	b=FfJIaaE5/afUudpv6iK/rxlZf7fvUz7ObjTZp5OB+dNO2sUXYaOCKSFqc1GlemzEn11ysa
	AiCOdH/sLiGgwXcklakR6V4ZhvuZ15/SyXypTaZNu/cFIZyv12YxPgHhHQFnu4qoLEh6ru
	Eo1tE7DVbo/IglZSZEsHLqEXSrq6hhY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340--T31Nz4_PwK149VAcxm1aA-1; Thu, 04 Jan 2024 09:37:25 -0500
X-MC-Unique: -T31Nz4_PwK149VAcxm1aA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A4B2101A5B3;
	Thu,  4 Jan 2024 14:37:25 +0000 (UTC)
Received: from [100.85.132.103] (ovpn-0-5.rdu2.redhat.com [10.22.0.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BED25190;
	Thu,  4 Jan 2024 14:37:24 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: hangs during fstests testing with TLS
Date: Thu, 04 Jan 2024 09:37:23 -0500
Message-ID: <1317F466-EA4C-41F0-BF3E-E0034396C016@redhat.com>
In-Reply-To: <ZZa9v3FQcwoZ7PCE@tissot.1015granger.net>
References: <117352d5dc94d8f31bc6770e4bbb93a357982a93.camel@kernel.org>
 <ABBA5E37-2E13-4603-A79C-F9B9B8488AE3@redhat.com>
 <D1091C94-9F23-47E9-A9CF-31CCEFE5EF8A@oracle.com>
 <AB421B16-F1FD-414C-A9BE-652D868F03A9@redhat.com>
 <DC58D77B-FC07-4B96-88A8-67F9ECDFD0CE@oracle.com>
 <8C3DFB5D-B967-4D59-BFC5-7B25315DB9AB@redhat.com>
 <ZZa9v3FQcwoZ7PCE@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 4 Jan 2024, at 9:16, Chuck Lever wrote:

> On Thu, Jan 04, 2024 at 07:22:18AM -0500, Benjamin Coddington wrote:
>> On 3 Jan 2024, at 16:46, Chuck Lever III wrote:
>>
>>>> On Jan 3, 2024, at 3:16=E2=80=AFPM, Benjamin Coddington <bcodding@re=
dhat.com> wrote:
>>>>
>>>> On 3 Jan 2024, at 14:12, Chuck Lever III wrote:
>>>>
>>>>>> On Jan 3, 2024, at 1:47=E2=80=AFPM, Benjamin Coddington <bcodding@=
redhat.com> wrote:
>>>>>>
>>>>>> This looks like it started out as the problem I've been sending pa=
tches to
>>>>>> fix on 6.7, latest here:
>>>>>> https://lore.kernel.org/linux-nfs/e28038fba1243f00b0dd66b7c5296a1e=
181645ea.1702496910.git.bcodding@redhat.com/
>>>>>>
>>>>>> .. however whenever I encounter the issue, the client reconnects t=
he
>>>>>> transport again - so I think there might be an additional problem =
here.
>>>>>
>>>>> I'm looking at the same problem as you, Ben. It doesn't seem to be
>>>>> similar to what Jeff reports.
>>>>>
>>>>> But I'm wondering if gerry-rigging the timeouts is the right answer=

>>>>> for backchannel replies. The problem, fundamentally, is that when a=

>>>>> forechannel RPC task holds the transport lock, the backchannel's re=
ply
>>>>> transmit path thinks that means the transport connection is down an=
d
>>>>> triggers a transport disconnect.
>>>>
>>>> Why shouldn't backchannel replies have normal timeout values?
>>>
>>> RPC Replies are "send and forget". The server forechannel sends
>>> its Replies without a timeout. There is no such thing as a
>>> retransmitted RPC Reply (though a reliable transport might
>>> retransmit portions of it, the RPC server itself is not aware of
>>> that).
>>>
>>> And I don't see anything in the client's backchannel path that
>>> makes me think there's a different protocol-level requirement
>>> in the backchannel.
>>
>> Its not strictly a protocol thing, the timeouts are used to decide wha=
t to
>> do with a req or flag the transport state even if the request doesn't =
make
>> it to the wire.  That's why the zero timeout values for this req impro=
perly
>> resets the transport.
>
> I guess I'm harping on this a bit because forechannel v. backchannel
> is already confusing enough. The use of timeouts for RPC Replies is
> just heaping on to that confusion.

Yeah, its super confusing for me too.  Add to this the fact that we do it=

completely different for 4.0 and 4.1, but all the variable names are
similar and/or reversed.

> If we're going to keep an explicit timeout when sending the Reply,
> it should have a little documentation. I suggest adding this to
> xprt_init_bc_request() before the new call to
> xprt_init_majortimeo():
>
> 	/*
> 	 * Backchannel Replies are sent with !RPC_TASK_SOFT and
> 	 * RPC_TASK_NO_RETRANS_TIMEOUT. The major timeout setting
> 	 * affects only how long each Reply waits to be sent when
> 	 * a transport connection cannot be established.
> 	 */
> 	xprt_init_majortimeo(task, req, ...

Ok, I will add that on 2/2 v4 which is getting some basic testing ATM.

Ben


