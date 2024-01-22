Return-Path: <linux-nfs+bounces-1276-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28A3837756
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 00:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B810284D10
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 23:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A60B38FB3;
	Mon, 22 Jan 2024 23:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5OVfnjK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E914538DC6
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jan 2024 23:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964615; cv=none; b=DQ+w/et9UIKdSbm3BhS/B9n0fR1aL3q55yYW2/4otrGzkfgu12TzgCaPCk3Jt3mAjXEoxF7FRsuVToEUpvN+kyr3A/zUYq8eUziqubuGT86Qort/xM8LvIQ3cmWnhTM+QuJOHZGixLWWX+22iU1XZDThrYmMxQY8NGPddx+Ucyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964615; c=relaxed/simple;
	bh=D7oB7Ju59jM0UhFrfXqBpm/Fulrq3txETNQlBZAHVDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3rHwfNpflzaxVsbJ79G1hauX5/HjSfvUHSGx7ucgIHJAnP5sbW+jyt2ykoqcJlsPQTx9pUqJQwPH7EDRv74LNjBNeX+AAffFCCIuRSQiDwbmC+JK80GHmTLKncDt2+A2yFlnRr/uHtoOhhNMQDar2fXli5rph98QieKoYUShK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b5OVfnjK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705964612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFLjuxJcHQJGHiLqwQwqUIvLjW4EOdpxCNhu3PfJiI0=;
	b=b5OVfnjK5DAZkNjYDMs/WVqp+598w8FtrwBXPWXbFrv0ax950gUKWOlSpTsHKDyiu8Fblj
	QCSqgzSp8tGy7xl09IGHjasJhNdtUPQ77xRPDsBjaFruVpa1fYvYqfLJfxCi9GlSOqGJoj
	M4aDnYBm0GlNA3brPr7lS2nTj5NmIDU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-7UHfoOBUPWyLwfd5WHVIfA-1; Mon, 22 Jan 2024 18:03:29 -0500
X-MC-Unique: 7UHfoOBUPWyLwfd5WHVIfA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBAE6185A781;
	Mon, 22 Jan 2024 23:03:28 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-9.rdu2.redhat.com [10.22.0.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 58D2F5012;
	Mon, 22 Jan 2024 23:03:28 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: samasth.norway.ananda@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [External] : Re: [PATCH 1/1] NFSv4.1: Assign retries to
 timeout.to_retries instead of timeout.to_initval
Date: Mon, 22 Jan 2024 18:03:27 -0500
Message-ID: <8DCCEB9D-5504-4DD4-A042-61C99D22A462@redhat.com>
In-Reply-To: <Za7x2aYNRqc3nIbl@tissot.1015granger.net>
References: <20240122172353.2859254-1-samasth.norway.ananda@oracle.com>
 <995F0BB9-C709-4C3A-92F3-5EB9710A47F5@redhat.com>
 <bdd760d9-9900-43ef-8000-0e9ce0aa8b3e@oracle.com>
 <8B835117-498D-484E-B1DE-912FBBBCC74E@redhat.com>
 <Za7x2aYNRqc3nIbl@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 22 Jan 2024, at 17:53, Chuck Lever wrote:

> On Mon, Jan 22, 2024 at 05:46:56PM -0500, Benjamin Coddington wrote:
>> On 22 Jan 2024, at 17:44, samasth.norway.ananda@oracle.com wrote:
>>
>>> On 1/22/24 2:41 PM, Benjamin Coddington wrote:
>>>> On 22 Jan 2024, at 12:23, Samasth Norway Ananda wrote:
>>>>
>>>>> In the else block we are assigning the req->rq_xprt->timeout->to_re=
tries
>>>>> value to timeout.to_initval, whereas it should have been assigned t=
o
>>>>> timeout.to_retries instead.
>>>>>
>>>>> Fixes: 57331a59ac0d (=E2=80=9CNFSv4.1: Use the nfs_client's rpc tim=
eouts for backchannel")
>>>>> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.=
com>
>>>>> ---
>>>>> Hi,
>>>>>
>>>>> I came across the patch 57331a59ac0d (=E2=80=9CNFSv4.1: Use the nfs=
_client's rpc
>>>>> timeouts for backchannel") which assigns value to same variable in =
the
>>>>> else block.  Can I please get your input on the patch?
>>>>
>>>> Oh yes, this a good fix.  Usually the maintainers won't pick up a pa=
tch
>>>> that's only sent to the list, rather the patch should be addressed t=
o them
>>>> directly and copied to the list.  Can you re-send this patch to:
>>>>
>>>> Trond Myklebust <trond.myklebust@hammerspace.com>,Anna Schumaker <an=
na@kernel.org>
>>>>
>>>> and copy linux-nfs@vger.kernel.org?  You can also add my:
>>>>
>>>> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
>>>
>>> Sure, I will do that. Thanks for the review.
>>
>> Can you also fixup the block above the hunk you posted?  Its backwards=
 there too!
>
> It's backwards in a different way.

Its an artifact of my text editing..

> And should you set to_maxval in both places as well?

IIRC it does not need to be set there.

Ben


