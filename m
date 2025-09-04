Return-Path: <linux-nfs+bounces-14043-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71029B44421
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 19:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87BA1C841AC
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 17:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E150E3009D2;
	Thu,  4 Sep 2025 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqRSshLy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D039F2D3731
	for <linux-nfs@vger.kernel.org>; Thu,  4 Sep 2025 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005934; cv=none; b=WcfIAK10/OcFHWByvnMVaO2l7lae78koh8D0Z6xezFPqcT3cxKFOvJnUX9BJZuI+aAnDIfBp63caGuzIdBrU3Voozr7o1orY4DWTvF3Gj03G64L/hIz/QQu5OePusZNfyUGeyTHE/Je+xokFyiFm3XueCRZyCzU4AkAHJb4dUlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005934; c=relaxed/simple;
	bh=hNGOAt2sdFMacfB+YqaN0v6NRnNfpg7edxcrE3mQ1bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+otcpJwHcPFhL730aTTY4d/yy52r6NRA+MQRVMy37yJhcHvY24R5/knMkTxAXqiY2+NJbXBPvGKWoFbfLJS4xwo0KmmAXp1c4QCtzz8IKbWuLnDU/jPScULdJKV1fgeGFpW69ygXRGiRO+2JjeAEyJfJZwl9SOcEgo4vrM48Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LqRSshLy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757005931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iVE1gztVzTOEAZ4nOEi25d+Y2YZBbzsETV2L+O/pa2s=;
	b=LqRSshLyT5sssvOksEb3YrixYepHJGC/+wSmnvsVoNYEXKp8ewCJWxTNpx3/PJA9Ok385c
	cXEghEuBIE88j9hcstPcVxs/Hb8CW0TDb7+gGJVvrvu+IZqGDQaU1dBHjbyNVZSTdjU8cN
	09cQrTC27LFrMMH+LnAla9iioHU2uPw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-bxMavntQNUO0HpscUzGDDg-1; Thu,
 04 Sep 2025 13:12:06 -0400
X-MC-Unique: bxMavntQNUO0HpscUzGDDg-1
X-Mimecast-MFC-AGG-ID: bxMavntQNUO0HpscUzGDDg_1757005925
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AD2A19540FE;
	Thu,  4 Sep 2025 17:12:05 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2AF13002D27;
	Thu,  4 Sep 2025 17:12:04 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 04C7A42EE67; Thu, 04 Sep 2025 13:12:03 -0400 (EDT)
Date: Thu, 4 Sep 2025 13:12:02 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: Justin Worrell <jworrell@gmail.com>
Cc: linux-nfs@vger.kernel.org, trondmy@hammerspace.com, okorniev@redhat.com
Subject: Re: [PATCH v2 0/1] call xs_sock_process_cmsg for all cmsg
Message-ID: <aLnIYv3VcdKKvOEj@aion>
References: <aLirFyirQpRRW3qr@aion>
 <20250904143302.34217-1-jworrell@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250904143302.34217-1-jworrell@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, 04 Sep 2025, Justin Worrell wrote:

> My initial attempt to submit this patch was not formatted correctly. The =
only change in v2 is me trying to use git send-email correctly. Thanks for =
being patient with me.=20

The v2 patch is good from a formatting standpoint (i.e. it applies with
'git am') but you're missing a few things:

- You need a patch description (I thought what you had in v1 was fine). See
  https://docs.kernel.org/process/submitting-patches.html#describe-your-cha=
nges
- You need a Signed-off-by: line.  See
  https://docs.kernel.org/process/submitting-patches.html#developer-s-certi=
ficate-of-origin-1-1

You should probably also add:
Fixes: cc5d59081fa2 ("sunrpc: fix client side handling of tls alerts")

You can also add:
Reviewed-and-tested-by: Scott Mayhew <smayhew@redhat.com>

>=20
> xs_sock_recv_cmsg was failing to call xs_sock_process_cmsg for any cmsg t=
ype other than TLS_RECORD_TYPE_ALERT (TLS_RECORD_TYPE_DATA, and other value=
s not handled.) Based on my reading of the previous commit (cc5d5908: sunrp=
c: fix client side handling of tls alerts), it looks like only iov_iter_rev=
ert should be conditional on TLS_RECORD_TYPE_ALERT (but that other cmsg typ=
es should still call xs_sock_process_cmsg). On my machine, I was unable to =
connect (over mtls) to an NFS share hosted on FreeBSD. With this patch appl=
ied, I am able to mount the share again.
>=20
> Based on analysis by Olga Kornievskaia, while this patch does allow Linux=
 to mount FreeBSD exports over (m)tls -- it does not seem to fully correct =
all underlying issues. I think I=E2=80=99m a bit over my head to analyze th=
e protocol for deeper issues than what I found (which was just thinking thr=
ough functional differences between the old and new code, and throwing stuf=
f at the wall till it runs.)
>=20

Olga's main concern was why were seeing so many tls_contenttype
tracepoints fire where the type was HANDSHAKE.  I think I can explain
why.

Prior to cc5d59081fa2, we'd read in those HANDSHAKE records via a
handful of sock_recvmsg() calls, and then we'd discard them (because we
only have handling for DATA and ALERT records).  But we also had a bug
in our handling of ALERT records that could lead to kernel panics.

cc5d59081fa2 addressed the kernel panics by setting up a separate 2-byte
buffer to read in ALERT records.  But we're also receiving those
HANDSHAKE records using that 2-byte buffer.  That means a lot more
sock_recvmsg()... and a lot more tls_get_record_type() (which fires the
tls_contenttype tracepoint) calls.

Now couple that with the bug that you identified - that we're no longer
tossing those HANDSHAKE messages to the side.  Instead we treat them as
a if they have RPC data.  We manage to find what looks like a RPC
fragment header, so then we check what we think is the call direction
field.  It happens to be four-bytes of zeros, so we think it's an RPC
call (i.e we think the the server is sending us an RPC call).  Because
the transport isn't for the backchannel, the client closes the socket.
The client keeps retrying the mount, so rinse and repeat a whole bunch
of times until the mount eventually fails, and that's a lot of HANDSHAKE
tracepoints firing.  At least that's what I'm seeing in my environment.

Your patch fixes the issue by ensuring that we call
xs_sock_process_cmsg() for all records, so now we're discarding those
HANDSHAKE records again.  We see more HANDSHAKE tracepoints firing, but
the number of them makes sense to me.  When I look at a packet capture
after I perform a mount of my freebsd server, I see that the server sent
2 New Session Ticket messages.  Each one has a decrypted payload that is
233 bytes in length.  If we're pulling that in using a two-byte buffer,
we need to call sock_recvmsg() 117 times.  Each time we're actually
firing the tls_contenttype tracepoint twice, because we call
tls_get_record_type() (which calls the tracepoint) twice - once in
xs_sock_recv_cmsg() and again in xs_sock_process_cmsg().  So we should
see 234 HANDSHAKE tracepoints.  Now double that, because there were 2
New Session Messages, for a total of 468 HANDSHAKE tracepoints... and
that's exactly what I see:

[root@rawhide ~]# echo 1 >/sys/kernel/debug/tracing/events/handshake/enable
[root@rawhide ~]# mount -o v4.2,xprtsec=3Dtls 10.6.54.203:/ /mnt/t
[root@rawhide ~]# grep -c HANDSHAKE /sys/kernel/debug/tracing/trace
468

We should probably pull in those HANDSHAKE records more efficiently
(maybe pivot back to reading the data into the msghdr->msg_iter when we
detect we have a HANDSHAKE record?).  At any rate, I think that should
be done separately, since your patch fixes a clear bug.

-Scott


> Obviously it is up to the community and maintainers if stands alone as st=
ep in the right direction, or if a full root cause needs to be found and co=
rrected before proceeding with any changes. =20
>=20
> Justin Worrell (1):
>   call xs_sock_process_cmsg for all cmsg
>=20
>  net/sunrpc/xprtsock.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> --=20
> 2.51.0
>=20


