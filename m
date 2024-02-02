Return-Path: <linux-nfs+bounces-1714-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A9B84734B
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Feb 2024 16:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ABAC1C228E6
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Feb 2024 15:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5887146919;
	Fri,  2 Feb 2024 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWlU2pR2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664E21474DF
	for <linux-nfs@vger.kernel.org>; Fri,  2 Feb 2024 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888193; cv=none; b=gAzX3ppX+7FgwxRbtkY46OFE8v9XZ/u4OqUw8ASu7jGYHyGfFyDDgo9JPMAixv473mrvGGFEbH24GDrw767WzzaS7yPrNCU3tEGtys/lotRWRszj3B7NW3mqcAYyeGSEtFV5cLS6K6W0qskLknSEL6Z9vFtb7l5tUifXguzHwdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888193; c=relaxed/simple;
	bh=AE+gyeOMkK00Xg79wBgyQK2dem8VEnGptnq7Ftuming=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rtqH5g0fMVg/hhqAocXbxva/ysIEQM3coZ7qyvJZfpR4p1vq5X85Qs2ALglk7XYS3J3TI0Z81SAyuospC4hKFj50hCi2IdjRY44f3T06dcifSpKsz0nYJmhj3YG5zuLFlD+PkYvXF1+7krUVdC5M2aeSoL/WRN5aIivN940ZE9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hWlU2pR2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706888178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cC5a/USws0tkFJo5bD0MXqeSLPysmA7iFBQPVNWV23M=;
	b=hWlU2pR2XFsK85uRLoq9CwPq3TTFH7WH+vO9vw2hqY04lEVIwYr8CVZiepCJz/Toy2fAEV
	4VTWBs2SyiIX7SrHkyOcoSbjHXvMmtfGyvqzOmaGcfQHuZLL4o9TVqVIJ8ctFfjWAOx0S1
	hLplfNdkvJ1onrIeTpASul2MurGJ3gY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-V0ruNxy_MUeDoCjj9-FxmQ-1; Fri, 02 Feb 2024 10:36:14 -0500
X-MC-Unique: V0ruNxy_MUeDoCjj9-FxmQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0746883B835;
	Fri,  2 Feb 2024 15:36:14 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-9.rdu2.redhat.com [10.22.0.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2424D3C2E;
	Fri,  2 Feb 2024 15:36:12 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc: trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSv4.1: add tracepoint to trunked nfs4_exchange_id
 calls
Date: Fri, 02 Feb 2024 10:36:11 -0500
Message-ID: <D23CBB93-3883-4E41-A1E5-848BCB2D477E@redhat.com>
In-Reply-To: <CAN-5tyGDQaaud7emd-Sgx_0E31bLx0k6EgrONSp0SbfoMTwY9A@mail.gmail.com>
References: <20240126190333.13528-1-olga.kornievskaia@gmail.com>
 <1DBC4AE1-E253-454F-9E7E-12DFBA14EBA6@redhat.com>
 <CAN-5tyGDQaaud7emd-Sgx_0E31bLx0k6EgrONSp0SbfoMTwY9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 2 Feb 2024, at 9:42, Olga Kornievskaia wrote:

> On Fri, Feb 2, 2024 at 8:01=E2=80=AFAM Benjamin Coddington <bcodding@re=
dhat.com> wrote:
>>
>> On 26 Jan 2024, at 14:03, Olga Kornievskaia wrote:
>>
>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>
>>> Add a tracepoint to track when the client sends EXCHANGE_ID to test
>>> a new transport for session trunking.
>>>
>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>> ---
>>>  fs/nfs/nfs4proc.c  |  3 +++
>>>  fs/nfs/nfs4trace.h | 30 ++++++++++++++++++++++++++++++
>>>  2 files changed, 33 insertions(+)
>>>
>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>> index 23819a756508..cdda7971c945 100644
>>> --- a/fs/nfs/nfs4proc.c
>>> +++ b/fs/nfs/nfs4proc.c
>>> @@ -8974,6 +8974,9 @@ void nfs4_test_session_trunk(struct rpc_clnt *c=
lnt, struct rpc_xprt *xprt,
>>>               status =3D nfs4_detect_session_trunking(adata->clp,
>>>                               task->tk_msg.rpc_resp, xprt);
>>>
>>> +     trace_nfs4_trunked_exchange_id(adata->clp,
>>> +                     xprt->address_strings[RPC_DISPLAY_ADDR], status=
);
>>> +
>>
>> Any worry about the ambiguity of whether "status" comes from tk_status=
 or
>> from nfs4_detect_session_trunking() here?  The latter can return -EINV=
AL
>> which isn't in show_nfs4_status().
>
> Good catch, I didn't realize there wasn't an EINVAL mapping. I was
> focusing on capturing the fact that exchangeid was happening and ip
> info of the trunking connection that I didn't pay attention to the
> status. I'll send a v2 with EINVAL added to show_nfs4_status.

If you're only interested in tk_status, you could just move the tracepoin=
t.
That would resolve the conditional branch that changes the source of
"status".

Ben


