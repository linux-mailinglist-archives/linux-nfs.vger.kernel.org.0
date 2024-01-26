Return-Path: <linux-nfs+bounces-1466-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D31783DBDA
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 15:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D73DC282F0A
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 14:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBEC1D524;
	Fri, 26 Jan 2024 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DAMs9mjA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C101CD34
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279228; cv=none; b=uM42Pn8wh43eMml9XLOz8gF2qZGGBeIrtpg7rF8vWG4FnuuvOP/WGpIhcg3gRheAP/qksZL+Ae467lSYSNsixvbervx9dQKYgWAkp12X0poVY8LvqJ+lZSm09s0f8tuumavyADPFwkGl/ohZYiHC0KQj/miJ9XvZnSgYiJAM4W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279228; c=relaxed/simple;
	bh=gTVyxkpH4vXhIsziYO6Wocy6uu3yMzVJ6/DgXFyaJiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RL8H/+6DUTt+PUP1YStgBjNNLDJ+2npLMMHR/WjP2kr3bkvIZ3Uq7Z9UmJaml408k78xnzQ0NkZ0xr/HfmJJ2OxGyZ2yeVXEqyYl7j3f6FsiRyOCx3utm66HWeL/n6HVHx8A3fnKFoppoCwcvwvkjuB3IZpauyz+cSRtD0KVxqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DAMs9mjA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706279224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rSsCV13ZOe2hGwjO6SFR2XhZCTVPoOy2AkliCsr+iPg=;
	b=DAMs9mjAkmrteacQw08DXZzRNEQelZVWBqpSE5XC+3gSSiEvuEVXwR3u7u9NpC5NTpos6J
	PJG3kHLZ4vDguAra9Cnqpz0PhDc2E1dqhQeQWNwhfcIw2UTFrjhsP0if8hk1kmDwwytV4P
	97RNqtT/jaqMqXK3VrHSVMdVRAJiv/k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-Fep_rFMFPVeNyvL32ln0Dg-1; Fri,
 26 Jan 2024 09:27:02 -0500
X-MC-Unique: Fep_rFMFPVeNyvL32ln0Dg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 145911C0BA4F;
	Fri, 26 Jan 2024 14:27:02 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-9.rdu2.redhat.com [10.22.0.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 781ED1121306;
	Fri, 26 Jan 2024 14:27:01 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 07/13] NFSD: Add callback operation lifetime trace
 points
Date: Fri, 26 Jan 2024 09:27:00 -0500
Message-ID: <04CAE4A5-E99B-4BA8-978B-894B28BF31B5@redhat.com>
In-Reply-To: <ZbO92zZkNpRomQqq@tissot.1015granger.net>
References: <170619984210.2833.7173004255003914651.stgit@manet.1015granger.net>
 <170620016455.2833.5426224225062159088.stgit@manet.1015granger.net>
 <86789B68-0271-4AEB-9941-CFDB956E84EE@redhat.com>
 <ZbO92zZkNpRomQqq@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 26 Jan 2024, at 9:12, Chuck Lever wrote:

> On Thu, Jan 25, 2024 at 04:49:17PM -0500, Benjamin Coddington wrote:
>> On 25 Jan 2024, at 11:29, Chuck Lever wrote:
>>
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>
>>> Help observe the flow of callback operations.
>>>
>>> bc_shutdown() records exactly when the backchannel RPC client is
>>> destroyed and cl_cb_client is replaced with NULL.
>>>
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>>  fs/nfsd/nfs4callback.c   |    7 +++++++
>>>  fs/nfsd/trace.h          |   42 ++++++++++++++++++++++++++++++++++++=
++++++
>>>  include/trace/misc/nfs.h |   34 ++++++++++++++++++++++++++++++++++
>>>  3 files changed, 83 insertions(+)
>>>
>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>> index 1c85426830b1..4d5a6370b92c 100644
>>> --- a/fs/nfsd/nfs4callback.c
>>> +++ b/fs/nfsd/nfs4callback.c
>>> @@ -887,6 +887,7 @@ static struct workqueue_struct *callback_wq;
>>>
>>>  static bool nfsd4_queue_cb(struct nfsd4_callback *cb)
>>>  {
>>> +	trace_nfsd_cb_queue(cb->cb_clp, cb);
>>>  	return queue_work(callback_wq, &cb->cb_work);
>>>  }
>>>
>>> @@ -1106,6 +1107,7 @@ static void nfsd41_destroy_cb(struct nfsd4_call=
back *cb)
>>>  {
>>>  	struct nfs4_client *clp =3D cb->cb_clp;
>>>
>>> +	trace_nfsd_cb_destroy(clp, cb);
>>>  	nfsd41_cb_release_slot(cb);
>>>  	if (cb->cb_ops && cb->cb_ops->release)
>>>  		cb->cb_ops->release(cb);
>>> @@ -1220,6 +1222,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_t=
ask *task, struct nfsd4_callback
>>>  	goto out;
>>>  need_restart:
>>>  	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
>>> +		trace_nfsd_cb_restart(clp, cb);
>>>  		task->tk_status =3D 0;
>>>  		cb->cb_need_restart =3D true;
>>
>> I think you want to call the tracepoint /after/ setting cb_need_restar=
t here..
>
> Maybe?
>
> The trace point currently captures the value of cb_need_restart
> before this logic overwrites it. Is that beneficial for
> troubleshooting?

Got it, yes its better the way you have it - and the tracepoint name make=
s
clear we want to restart.

Ben


