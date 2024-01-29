Return-Path: <linux-nfs+bounces-1570-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1487E840CA2
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 17:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19E228C72E
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 16:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081B015699F;
	Mon, 29 Jan 2024 16:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QT8QTCti"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547ED157028
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547588; cv=none; b=G04bsyOfCe18l28K89tIf7ZE/SxfWU85hWdH/L7d7/jQBSMjbvnW2Ng9iQjJTcwU9CTabZeg9gca2o2PFaVRRIoTxNdO/xkYLYHGIjjUb9f6pVtmiIt9ozJjA5U386hekvovZXhQQic+8XFsJ3zqZVcZgcHY8eobqIuLwqBmXno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547588; c=relaxed/simple;
	bh=HNdAx47dFFQ/G2/0oVGCNwabyUK7Ga4m+kOyhpAmjvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sv8Dw2kZgu7zZnfNm/3tyw2EttoWwVZ0ZzrcXmEGj8QNEwIgLU1V90IBZt+vlz69uyKilfI1AYJqBxn9fMz3YhdpnQocrYm33O/MBiWhPcvf5+kZcQh8gkRKV0f6YxhDm8qmwZNSWt2LrHqCLWHHP9u1awwcVj8pqzWVJwtz90o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QT8QTCti; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706547586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQDUUKvTK8zOkwQ8G6lXq76uar0XYKdo4f+/T4ifrR0=;
	b=QT8QTCtiyBgntJZ2KoMWFWfrrnoyHUJERdd+rCT4Ub+A9mMIJSMndsL/HagY8ieeMb6Giz
	EU1jY9JX+3aRn3cKQdkxj7B8Rkx92Th0u43gewE6KALwW41PXADUaxfYpyUGk0mYG6lcNS
	r46pcte+QQNYvkR7na/1OH3ZaKD2swo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-uhan2oCONqqTFR7Jor7SVQ-1; Mon,
 29 Jan 2024 11:59:43 -0500
X-MC-Unique: uhan2oCONqqTFR7Jor7SVQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10B7628B72E2;
	Mon, 29 Jan 2024 16:59:42 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-9.rdu2.redhat.com [10.22.0.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 48F531121306;
	Mon, 29 Jan 2024 16:59:39 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Anna Schumaker <Anna.Schumaker@Netapp.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Alexander Aring <aahringo@redhat.com>
Subject: Re: [PATCH] sunrpc: fix assignment of to_retries in svc_process_bc
Date: Mon, 29 Jan 2024 11:59:37 -0500
Message-ID: <54456569-284D-4294-BD75-6AD3F68BB5A8@redhat.com>
In-Reply-To: <C4D894E0-F9C9-4C31-BA49-05E942FE0A6A@oracle.com>
References: <20240129-nfsd-fixes-v1-1-49a3a45bd750@kernel.org>
 <7E6930D1-14BC-4CBC-9833-531BF6F5D874@redhat.com>
 <C4D894E0-F9C9-4C31-BA49-05E942FE0A6A@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 29 Jan 2024, at 11:55, Chuck Lever III wrote:

>> On Jan 29, 2024, at 11:52=E2=80=AFAM, Benjamin Coddington <bcodding@re=
dhat.com> wrote:
>>
>> On 29 Jan 2024, at 11:43, Jeff Layton wrote:
>>
>>> Alex reported seeing this:
>>>
>>>    [   18.238266] ------------[ cut here ]------------
>>> ...
>>
>> This one got fixed already, just waiting for a maintainer to send it a=
long:
>>
>> https://lore.kernel.org/linux-nfs/20240123053509.3592653-1-samasth.nor=
way.ananda@oracle.com/
>
> Ah. That touches net/sunrpc/svc.c, but it was sent to the client mainta=
iners.
>
> Do you want me to take it through the nfsd tree?

Oh yeah if you like, not sure how you want to sort it between the because=

even though its in svc.c, its a client fix; this code is specific for the=

client's backchannel.

Note the version on this thread misses the 2nd typo.

Ben


