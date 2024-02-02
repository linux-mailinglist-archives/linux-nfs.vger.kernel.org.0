Return-Path: <linux-nfs+bounces-1717-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD47847573
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Feb 2024 17:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1847128E945
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Feb 2024 16:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976041487D0;
	Fri,  2 Feb 2024 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVDp0+P9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06AD14A087
	for <linux-nfs@vger.kernel.org>; Fri,  2 Feb 2024 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892998; cv=none; b=qc5DXhO3lVVS5A+MT8lvL8pZK9bBdcz2GGmHY8i8/mMudA2PgQg5Vef98bZYevjrmzChVFvzKTVMViXAqB+UdkayF3NlFO7lq9q6meHGXuH8VKw20uVRqH9XGbzRqvXCc4KoW2HIaQNZGUsOXkW5BL4CAy10vIqVoM7yvFDNrEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892998; c=relaxed/simple;
	bh=qAy7oy/rBtfH0kIaSVLKtqNpx65vjTZQ4/wydRBryao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CfT5Knxk7RB4HZMCngHei83t0hXx4ZTlLbe03Nlp1MBRnP64mF6BebCMI6soY4fDew9wAAx3rv9nis7JjRxAUc6/Mc9zRLhnmaWgyGa7qJ+9xhR89YICiYnd2oYeiqy+P6Zhb9JB27D5r0h3WL3fTN2vXGdZ0NRuVzX685s8rIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVDp0+P9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706892995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+jkz0nzktSIYMtPuf/VgPym7a8PKkPvDVbCO1I6Ot0=;
	b=AVDp0+P98KD/wGkI9njYgeMKHvOZ98/9j0Y4WSkLwJnKUIT3EKO4o8jgXxHrUTFM9s315j
	RE210DSlPISE76GJmw75EcH6izg3fgka045OJDd9XLxmKLVICOhCiegje9roKA+EAPdL6r
	tsnJMjeWEp3LBiKaUp1cNSjhGD9nwe4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-4ff1_x12NqWdFP5Q4hRgGQ-1; Fri,
 02 Feb 2024 11:56:32 -0500
X-MC-Unique: 4ff1_x12NqWdFP5Q4hRgGQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E586D3C025D0;
	Fri,  2 Feb 2024 16:56:31 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-9.rdu2.redhat.com [10.22.0.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 17A2A1121306;
	Fri,  2 Feb 2024 16:56:30 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc: trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSv4.1: add tracepoint to trunked nfs4_exchange_id
 calls
Date: Fri, 02 Feb 2024 11:56:29 -0500
Message-ID: <A60265EE-8564-4772-A035-916F88C82107@redhat.com>
In-Reply-To: <CAN-5tyHjkWsJPteVvLh83X3YTsvvS8vDfHBny-LMaAVbx0ww1g@mail.gmail.com>
References: <20240126190333.13528-1-olga.kornievskaia@gmail.com>
 <1DBC4AE1-E253-454F-9E7E-12DFBA14EBA6@redhat.com>
 <CAN-5tyGDQaaud7emd-Sgx_0E31bLx0k6EgrONSp0SbfoMTwY9A@mail.gmail.com>
 <D23CBB93-3883-4E41-A1E5-848BCB2D477E@redhat.com>
 <CAN-5tyHjkWsJPteVvLh83X3YTsvvS8vDfHBny-LMaAVbx0ww1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 2 Feb 2024, at 11:47, Olga Kornievskaia wrote:

> On Fri, Feb 2, 2024 at 10:36 AM Benjamin Coddington <bcodding@redhat.com>
> wrote:
>
>> On 2 Feb 2024, at 9:42, Olga Kornievskaia wrote:
>>
>>> On Fri, Feb 2, 2024 at 8:01 AM Benjamin Coddington <bcodding@redhat.com>
>> wrote:
>>>>
>>>> On 26 Jan 2024, at 14:03, Olga Kornievskaia wrote:
>>>>
>>>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>>>
>>>>> Add a tracepoint to track when the client sends EXCHANGE_ID to test
>>>>> a new transport for session trunking.
>>>>>
>>>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>>>> ---
>>>>>  fs/nfs/nfs4proc.c  |  3 +++
>>>>>  fs/nfs/nfs4trace.h | 30 ++++++++++++++++++++++++++++++
>>>>>  2 files changed, 33 insertions(+)
>>>>>
>>>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>>>> index 23819a756508..cdda7971c945 100644
>>>>> --- a/fs/nfs/nfs4proc.c
>>>>> +++ b/fs/nfs/nfs4proc.c
>>>>> @@ -8974,6 +8974,9 @@ void nfs4_test_session_trunk(struct rpc_clnt
>> *clnt, struct rpc_xprt *xprt,
>>>>>               status = nfs4_detect_session_trunking(adata->clp,
>>>>>                               task->tk_msg.rpc_resp, xprt);
>>>>>
>>>>> +     trace_nfs4_trunked_exchange_id(adata->clp,
>>>>> +                     xprt->address_strings[RPC_DISPLAY_ADDR], status);
>>>>> +
>>>>
>>>> Any worry about the ambiguity of whether "status" comes from tk_status
>> or
>>>> from nfs4_detect_session_trunking() here?  The latter can return -EINVAL
>>>> which isn't in show_nfs4_status().
>>>
>>> Good catch, I didn't realize there wasn't an EINVAL mapping. I was
>>> focusing on capturing the fact that exchangeid was happening and ip
>>> info of the trunking connection that I didn't pay attention to the
>>> status. I'll send a v2 with EINVAL added to show_nfs4_status.
>>
>> If you're only interested in tk_status, you could just move the tracepoint.
>> That would resolve the conditional branch that changes the source of
>> "status".
>>
>
> We are not interested in tk_status that can be gotten from the
> nfs4_xdr_status tracepoint. We are interested in the results of the
> trunking decision.

Gotcha, ok, I understand now.  Tucking into the conditional or moving it into
nfs4_detect_session_trunking() would make that clearer, but no big objection
from me.

If the task returns an error, this tracepoint will still be called with
tk_status instead of any result from the trunking decision.

Ben


