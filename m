Return-Path: <linux-nfs+bounces-688-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4BA816F74
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 14:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B3A288578
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 13:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3CD1D127;
	Mon, 18 Dec 2023 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0vldkpF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C40A129EFE
	for <linux-nfs@vger.kernel.org>; Mon, 18 Dec 2023 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702903720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+TgMET3w1UKIfo/0V2Q8ZS1OHhs+AYgiEmfnLmvv9o=;
	b=X0vldkpFHq4gdX27A/YDYSKRWaW7v23lrCSrC6UN1Uw4p7r2Ixsf8aALxRgtGZXH5pZ6Cf
	0vLdLqBHQeXBCV7kRqYOp17ZcHxS6oEP1XoyzCtqLLtEb41UTNy87q3anDk9deT0a57Gab
	yb6sYBsJo8WRvHXxvychGN6MKMiioeI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-WdIf2DrgMOy2i4iG7a9WTA-1; Mon,
 18 Dec 2023 07:48:39 -0500
X-MC-Unique: WdIf2DrgMOy2i4iG7a9WTA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7E4A38562CE;
	Mon, 18 Dec 2023 12:48:38 +0000 (UTC)
Received: from [100.85.132.103] (ovpn-0-5.rdu2.redhat.com [10.22.0.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B95C2492BF0;
	Mon, 18 Dec 2023 12:48:37 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>, linux-nfs@stwm.de
Subject: Re: [PATCH 1/3 v2] SUNRPC: remove printk when back channel request
 not found
Date: Mon, 18 Dec 2023 07:48:36 -0500
Message-ID: <689A6114-B5B2-47DF-A0D6-6901D8F52CBE@redhat.com>
In-Reply-To: <A958C4F7-7DA4-4BA2-BAA5-9552388F5498@oracle.com>
References: <1702676837-31320-1-git-send-email-dai.ngo@oracle.com>
 <1702676837-31320-2-git-send-email-dai.ngo@oracle.com>
 <66BB600A-2C0D-457A-9A13-0F1D7F5E44B7@redhat.com>
 <A958C4F7-7DA4-4BA2-BAA5-9552388F5498@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 16 Dec 2023, at 11:39, Chuck Lever III wrote:

>> On Dec 16, 2023, at 6:12 AM, Benjamin Coddington <bcodding@redhat.com> wrote:
>>
>> On 15 Dec 2023, at 16:47, Dai Ngo wrote:
>>
>>> If the client interface is down, or there is a network partition between
>>> the client and server, that prevents the callback request to reach the
>>> client TCP on the server will keep re-transmitting the callback for about
>>> ~9 minutes before giving up and closes the connection.
>>>
>>> If the connection between the client and the server is re-established
>>> before the connection is closed and after the callback timed out (9 secs)
>>> then the re-transmitted callback request will arrive at the client. When
>>> the server receives the reply of the callback, receive_cb_reply prints the
>>> "Got unrecognized reply..." message in the system log since the callback
>>> request was already removed from the server xprt's recv_queue.
>>>
>>> Even though this scenario has no effect on the server operation, a
>>> malicious client can take advantage of this behavior and send thousand
>>> of callback replies with random XIDs to fill up the server's system log.
>>
>> I don't think this is a serious risk.  There's plenty of things a malicious
>> client can do besides try to fill up a system log.
>
> It's a general policy to remove printk's that can be triggered via
> the network. On the client side (xprt_lookup_rqst) we have a dprintk
> and a trace point. There's no unconditional log message there.

Ok, fair.

>> This particular printk has been an excellent indicator of transport or
>> client issues over the years.
>
> The problem is it can also be triggered by malicious behavior as well
> as unrelated issues (like a network partition). It's got a pretty low
> signal-to-noise ratio IMO; it's somewhat alarming and non-actionable
> for server administrators.

I have never seen a case with a malicious NFS client, and I'm also sure if I
were to run a malicious client I couldn't think of a better way of raising
my hand to say so.

I've seen a lot of misbehaving middle-boxes, or incorrectly setup split
routing, or migrated-across-the-network clients..

>> Seeing it in the log on a customer systems
>> shaves a lot of time off an initial triage of an issue.  Seeing it in my
>> testing environment immediately notifies me of what might be an otherwise
>> hard-to-notice problem.
>
> Can you give some details?

I don't immediately have more details at hand beyond what I've already said
- when a customer says they're seeing this message and NFS is slow or
failing in some way, its a big short cut to finding the problem.

> It would be OK with me to replace the unconditional warning with a
> trace point.

Of course, but that tracepoint would have to be enabled in order to see that
a significant disruption in the client-server conversation was occuring.

That's all I have for this patch -- just giving some feedback.

Ben


