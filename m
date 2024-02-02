Return-Path: <linux-nfs+bounces-1720-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5906784775A
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Feb 2024 19:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7590F1C241F3
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Feb 2024 18:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1665E1509AC;
	Fri,  2 Feb 2024 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eq0Ojiqh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB3D14D450
	for <linux-nfs@vger.kernel.org>; Fri,  2 Feb 2024 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898266; cv=none; b=PI0PBa6zyIqUX7g95NQfxPEdbdjwUzV1RmY20L5JvlzLl/9AVEob+1OzGAIlctJB/GqRSzseFQWVe7C7prDSp+PyEkXSgX/0EvfJoXijvNRwKrq81O0XgRtB8yCggOy6xOsZx2qYcPietTwqlW9TyXsfMXFgxmSpXiU2eESYTlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898266; c=relaxed/simple;
	bh=KQn8Tn76EL2MshSgWcIK+OTuxDm0RXThefFkvj9O0io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GFdWHH/+/o6fGBf/e3q6duomkEIHjRHJKugMX23QE9+Njzfz0pEuuFnNuinhwA2C+9bC/gBV8kSXccRvraBwcqu+Q1EskD7fQBys3CO8Ig4FMg74Y/KwXllMtEa87tbP3ZZKUyt8ZGXYM6tnS6L69atGop8uNookA2IQZv5nfz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eq0Ojiqh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706898263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=feVeQ+BthqvBVRexr7Ptzw7f7sClj9kkQO54/I4aDn0=;
	b=Eq0OjiqhVzeOZFMO9KmikUlVrwq3r2e0yWYMor7Ni0EYIzivmGs0is9KF/SLb80dtx0pjZ
	vWyguDI8gtxB4ObAkUywINq8TvjtmSTZJUxMZ9H4vXNHtG+bp4otCKZjOYopha1YF9aYjL
	Y2fLaq0KWmTrcf4CIBK/Z+bHQcwUCCU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-7DXDT3HJOfihVi9hEMM8bA-1; Fri,
 02 Feb 2024 13:24:17 -0500
X-MC-Unique: 7DXDT3HJOfihVi9hEMM8bA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FCC11C05AB5;
	Fri,  2 Feb 2024 18:24:17 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-9.rdu2.redhat.com [10.22.0.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A6EB91121306;
	Fri,  2 Feb 2024 18:24:16 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc: trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSv4.1: add tracepoint to trunked nfs4_exchange_id
 calls
Date: Fri, 02 Feb 2024 13:24:15 -0500
Message-ID: <A124DBD9-38ED-4A4D-A2F8-C3296CA1E641@redhat.com>
In-Reply-To: <CAN-5tyEgFnr=NK=mqikC27ixyyORUp5igwtVKDUHs8G2=7bbmA@mail.gmail.com>
References: <20240126190333.13528-1-olga.kornievskaia@gmail.com>
 <1DBC4AE1-E253-454F-9E7E-12DFBA14EBA6@redhat.com>
 <CAN-5tyGDQaaud7emd-Sgx_0E31bLx0k6EgrONSp0SbfoMTwY9A@mail.gmail.com>
 <D23CBB93-3883-4E41-A1E5-848BCB2D477E@redhat.com>
 <CAN-5tyHjkWsJPteVvLh83X3YTsvvS8vDfHBny-LMaAVbx0ww1g@mail.gmail.com>
 <A60265EE-8564-4772-A035-916F88C82107@redhat.com>
 <CAN-5tyGj_UcFLNkmqqc2bZD218r=Rvxj83_c69T7p9WNi_943Q@mail.gmail.com>
 <CAN-5tyEgFnr=NK=mqikC27ixyyORUp5igwtVKDUHs8G2=7bbmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 2 Feb 2024, at 12:45, Olga Kornievskaia wrote:

> On Fri, Feb 2, 2024 at 12:05=E2=80=AFPM Olga Kornievskaia <
> olga.kornievskaia@gmail.com> wrote:
>
>>
>>
>> On Fri, Feb 2, 2024 at 11:56=E2=80=AFAM Benjamin Coddington <bcodding@=
redhat.com>
>> wrote:
>>
>>> On 2 Feb 2024, at 11:47, Olga Kornievskaia wrote:
>>>
>>>> On Fri, Feb 2, 2024 at 10:36=E2=80=AFAM Benjamin Coddington <
>>> bcodding@redhat.com>
>>>> wrote:
>>>>
>>>>> On 2 Feb 2024, at 9:42, Olga Kornievskaia wrote:
>>>>>
>>>>>> On Fri, Feb 2, 2024 at 8:01=E2=80=AFAM Benjamin Coddington <
>>> bcodding@redhat.com>
>>>>> wrote:
>>>>>>>
>>>>>>> On 26 Jan 2024, at 14:03, Olga Kornievskaia wrote:
>>>>>>>
>>>>>>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>>>>>>
>>>>>>>> Add a tracepoint to track when the client sends EXCHANGE_ID to t=
est
>>>>>>>> a new transport for session trunking.
>>>>>>>>
>>>>>>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>>>>>>> ---
>>>>>>>>  fs/nfs/nfs4proc.c  |  3 +++
>>>>>>>>  fs/nfs/nfs4trace.h | 30 ++++++++++++++++++++++++++++++
>>>>>>>>  2 files changed, 33 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>>>>>>> index 23819a756508..cdda7971c945 100644
>>>>>>>> --- a/fs/nfs/nfs4proc.c
>>>>>>>> +++ b/fs/nfs/nfs4proc.c
>>>>>>>> @@ -8974,6 +8974,9 @@ void nfs4_test_session_trunk(struct rpc_cl=
nt
>>>>> *clnt, struct rpc_xprt *xprt,
>>>>>>>>               status =3D nfs4_detect_session_trunking(adata->clp=
,
>>>>>>>>                               task->tk_msg.rpc_resp, xprt);
>>>>>>>>
>>>>>>>> +     trace_nfs4_trunked_exchange_id(adata->clp,
>>>>>>>> +                     xprt->address_strings[RPC_DISPLAY_ADDR],
>>> status);
>>>>>>>> +
>>>>>>>
>>>>>>> Any worry about the ambiguity of whether "status" comes from
>>> tk_status
>>>>> or
>>>>>>> from nfs4_detect_session_trunking() here?  The latter can return
>>> -EINVAL
>>>>>>> which isn't in show_nfs4_status().
>>>>>>
>>>>>> Good catch, I didn't realize there wasn't an EINVAL mapping. I was=

>>>>>> focusing on capturing the fact that exchangeid was happening and i=
p
>>>>>> info of the trunking connection that I didn't pay attention to the=

>>>>>> status. I'll send a v2 with EINVAL added to show_nfs4_status.
>>>>>
>>>>> If you're only interested in tk_status, you could just move the
>>> tracepoint.
>>>>> That would resolve the conditional branch that changes the source o=
f
>>>>> "status".
>>>>>
>>>>
>>>> We are not interested in tk_status that can be gotten from the
>>>> nfs4_xdr_status tracepoint. We are interested in the results of the
>>>> trunking decision.
>>>
>>> Gotcha, ok, I understand now.  Tucking into the conditional or moving=
 it
>>> into
>>> nfs4_detect_session_trunking() would make that clearer, but no big
>>> objection
>>> from me.
>>>
>>> If the task returns an error, this tracepoint will still be called wi=
th
>>> tk_status instead of any result from the trunking decision.
>>>
>>
>> :) I'll send a v3. though I don't see my v2 posted but i did send it
>> already.
>>
>
> Well looks like I'm not longer able to submit patches because of someth=
ing
> new fancy policies. I have used the same gitemail from mac as v1 and no=
w my
> emails are rejected. I use Mac's git sendmail command.
>
> Ben, how do you submit to your patches, do you use Mac git's or submit
> through something else? Thank you for the help.

I use git send-email from linux and I relay through redhat.com's smtp
servers, which are generally well-trusted.

Your v2 made it to me and the archives:
https://lore.kernel.org/linux-nfs/20240202145432.95487-1-olga.kornievskai=
a@gmail.com/T/#u


Ben


