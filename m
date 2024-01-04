Return-Path: <linux-nfs+bounces-937-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E408244D8
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 16:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1105F1C21F7C
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 15:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E15241E0;
	Thu,  4 Jan 2024 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gn7O09bt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538F6241E6
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jan 2024 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704381665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6hVbIiW8R+/+s6cJQem1DUkTGjuK+xq7jDipyIXgGCE=;
	b=gn7O09btQ2gJHg0UhBrzK9kXnd971WUI1W1iHv+R2BnseDQDTXaj6FDPHWoeZmPKqHzpj8
	KmxfuzKYYuQOKZ71gGkdELG3sO6SVcoON0YFc3MXD/JCAOeQ+Kf0k7ilWc0It/HpoIMtxU
	4zI+FCeIMV3tgrXbNQIK0mP0kbTknG0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-nfid_uzBN4-_b_7_9-X65w-1; Thu, 04 Jan 2024 10:20:58 -0500
X-MC-Unique: nfid_uzBN4-_b_7_9-X65w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4767285A589;
	Thu,  4 Jan 2024 15:20:58 +0000 (UTC)
Received: from [100.85.132.103] (ovpn-0-5.rdu2.redhat.com [10.22.0.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 53846C15968;
	Thu,  4 Jan 2024 15:20:57 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 1/2] SUNRPC: Fixup v4.1 backchannel request timeouts
Date: Thu, 04 Jan 2024 10:20:55 -0500
Message-ID: <FBF6D528-DD7C-40C3-85DC-8D48B98990A8@redhat.com>
In-Reply-To: <ZZbKRp3oe1lptDvf@tissot.1015granger.net>
References: <e28038fba1243f00b0dd66b7c5296a1e181645ea.1704379780.git.bcodding@redhat.com>
 <ZZbKRp3oe1lptDvf@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 4 Jan 2024, at 10:09, Chuck Lever wrote:

> On Thu, Jan 04, 2024 at 09:58:45AM -0500, Benjamin Coddington wrote:
>> After commit 59464b262ff5 ("SUNRPC: SOFTCONN tasks should time out whe=
n on
>> the sending list"), any 4.1 backchannel tasks placed on the sending qu=
eue
>                       ^^^
>
> "any" ? I found that this problem occurs only when the transport
> write lock is held (ie, when the forechannel is sending a Call).
> If the transport is idle, things work as expected. But OK, maybe
> your reproducer is different than mine.

Any that are _placed on the sending queue_.

> One more comment below.
>
>
>> would immediately return with -ETIMEDOUT since their req timers are ze=
ro.
>>
>> Initialize the backchannel's rpc_rqst timeout parameters from the xprt=
's
>> default timeout settings.
>>
>> Fixes: 59464b262ff5 ("SUNRPC: SOFTCONN tasks should time out when on t=
he sending list")
>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>> ---
>>  net/sunrpc/xprt.c | 23 ++++++++++++++---------
>>  1 file changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
>> index 2364c485540c..6cc9ffac962d 100644
>> --- a/net/sunrpc/xprt.c
>> +++ b/net/sunrpc/xprt.c
>> @@ -651,9 +651,9 @@ static unsigned long xprt_abs_ktime_to_jiffies(kti=
me_t abstime)
>>  		jiffies + nsecs_to_jiffies(-delta);
>>  }
>>
>> -static unsigned long xprt_calc_majortimeo(struct rpc_rqst *req)
>> +static unsigned long xprt_calc_majortimeo(struct rpc_rqst *req,
>> +		const struct rpc_timeout *to)
>>  {
>> -	const struct rpc_timeout *to =3D req->rq_task->tk_client->cl_timeout=
;
>>  	unsigned long majortimeo =3D req->rq_timeout;
>>
>>  	if (to->to_exponential)
>> @@ -665,9 +665,10 @@ static unsigned long xprt_calc_majortimeo(struct =
rpc_rqst *req)
>>  	return majortimeo;
>>  }
>>
>> -static void xprt_reset_majortimeo(struct rpc_rqst *req)
>> +static void xprt_reset_majortimeo(struct rpc_rqst *req,
>> +		const struct rpc_timeout *to)
>>  {
>> -	req->rq_majortimeo +=3D xprt_calc_majortimeo(req);
>> +	req->rq_majortimeo +=3D xprt_calc_majortimeo(req, to);
>>  }
>>
>>  static void xprt_reset_minortimeo(struct rpc_rqst *req)
>> @@ -675,7 +676,8 @@ static void xprt_reset_minortimeo(struct rpc_rqst =
*req)
>>  	req->rq_minortimeo +=3D req->rq_timeout;
>>  }
>>
>> -static void xprt_init_majortimeo(struct rpc_task *task, struct rpc_rq=
st *req)
>> +static void xprt_init_majortimeo(struct rpc_task *task, struct rpc_rq=
st *req,
>> +		const struct rpc_timeout *to)
>>  {
>>  	unsigned long time_init;
>>  	struct rpc_xprt *xprt =3D req->rq_xprt;
>> @@ -684,8 +686,9 @@ static void xprt_init_majortimeo(struct rpc_task *=
task, struct rpc_rqst *req)
>>  		time_init =3D jiffies;
>>  	else
>>  		time_init =3D xprt_abs_ktime_to_jiffies(task->tk_start);
>> -	req->rq_timeout =3D task->tk_client->cl_timeout->to_initval;
>> -	req->rq_majortimeo =3D time_init + xprt_calc_majortimeo(req);
>> +
>> +	req->rq_timeout =3D to->to_initval;
>> +	req->rq_majortimeo =3D time_init + xprt_calc_majortimeo(req, to);
>>  	req->rq_minortimeo =3D time_init + req->rq_timeout;
>>  }
>>
>> @@ -713,7 +716,7 @@ int xprt_adjust_timeout(struct rpc_rqst *req)
>>  	} else {
>>  		req->rq_timeout =3D to->to_initval;
>>  		req->rq_retries =3D 0;
>> -		xprt_reset_majortimeo(req);
>> +		xprt_reset_majortimeo(req, to);
>>  		/* Reset the RTT counters =3D=3D "slow start" */
>>  		spin_lock(&xprt->transport_lock);
>>  		rpc_init_rtt(req->rq_task->tk_client->cl_rtt, to->to_initval);
>> @@ -1886,7 +1889,7 @@ xprt_request_init(struct rpc_task *task)
>>  	req->rq_snd_buf.bvec =3D NULL;
>>  	req->rq_rcv_buf.bvec =3D NULL;
>>  	req->rq_release_snd_buf =3D NULL;
>> -	xprt_init_majortimeo(task, req);
>> +	xprt_init_majortimeo(task, req, task->tk_client->cl_timeout);
>>
>>  	trace_xprt_reserve(req);
>>  }
>> @@ -1996,6 +1999,8 @@ xprt_init_bc_request(struct rpc_rqst *req, struc=
t rpc_task *task)
>>  	 */
>>  	xbufp->len =3D xbufp->head[0].iov_len + xbufp->page_len +
>>  		xbufp->tail[0].iov_len;
>> +
>
> +	/*
> +	 * Backchannel Replies are sent with !RPC_TASK_SOFT and
> +	 * RPC_TASK_NO_RETRANS_TIMEOUT. The major timeout setting
> +	 * affects only how long each Reply waits to be sent when
> +	 * a transport connection cannot be established.
> +	 */

I put this on 2/2 like I said in my earlier response.  I've been trying n=
ot
to make a delta on 1/2 (yes, even though its just a comment) because ther=
e's
a nonzero chance a maintainer is currently testing it to fix 6.7.  I
probably should not have made these two into a series, except that the 2n=
d
depends on the 1st.

If you definitely want it here instead, I will send a v5.  I think we're
probably going to be stuck with a broken 6.7 at this point.

Ben


