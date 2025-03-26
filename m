Return-Path: <linux-nfs+bounces-10900-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA492A71516
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 11:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A623B5923
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 10:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B291AF0BF;
	Wed, 26 Mar 2025 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEf03s33"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D111AE876
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742985984; cv=none; b=KvwCHp343fsaE4R/0KMHKnqmJujqLyFZj2NyDFYb48IITsc4KFL2oN9tYXU8/QOTgm7WXGuGty3Vxz2jfOyzv9KoMaKbXYEFDYNEqhN2TZsaHg9/a1OBdO1ap01We0kn45V78hz+SlUfWl4iB4N37BzMZbYXs5iZ+BS2YT9nVq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742985984; c=relaxed/simple;
	bh=VHtNYz+2qM173t4y5+stEVBU9fbpF8AZLbMo8mdp1Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRLSQYYqTYn0236aZ/Faw5tVuxi49/ltG929EunzrnnAyzherAF4s0OzrNijb8pmiib6x++JbR21HgSD7FKsxldWuCiuNmYwJTdXbCFycUgRaetEqeRwQYdq5TpQcXfOizCErrRiPrjHNwnylpMuBkqwhdvlS3a7rDoF19JVofY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TEf03s33; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742985981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XRLFUnvWIeQ7sxOhnMKJvEKWxVTuZjEbfCMBR3U22U4=;
	b=TEf03s33+vqIqcmx0HHsNMbubj9FAMEr/tMIdzcUgP2UvvGYNJlv5we6UGll/hghF630yS
	zhelx7p9miFsiAMjexAMqt4jgfGAEto07W4i+Iz2YRLMwx5DCZ11TZ0ylorDQ4MfZQHlE/
	g+xjHpuJMdZXBktDt+xXQ6usPukeeTc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-Ga-1zpRrM3GRNvsCwXtESQ-1; Wed,
 26 Mar 2025 06:46:17 -0400
X-MC-Unique: Ga-1zpRrM3GRNvsCwXtESQ-1
X-Mimecast-MFC-AGG-ID: Ga-1zpRrM3GRNvsCwXtESQ_1742985976
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63D2E1801A07;
	Wed, 26 Mar 2025 10:46:16 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.9])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50B5C180B487;
	Wed, 26 Mar 2025 10:46:15 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: trondmy@kernel.org, linux-nfs@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v3 4/6] NFSv4: Further cleanups to shutdown loops
Date: Wed, 26 Mar 2025 06:46:13 -0400
Message-ID: <9A67321B-E539-4ED2-A7FB-C5DD720604BB@redhat.com>
In-Reply-To: <c882f951c08fc67514357ddd3a47f188fa249e34.camel@kernel.org>
References: <cover.1742941932.git.trond.myklebust@hammerspace.com>
 <668e25098cb97187d084d5fa2916ddd4d2a68e00.1742941932.git.trond.myklebust@hammerspace.com>
 <c882f951c08fc67514357ddd3a47f188fa249e34.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 26 Mar 2025, at 6:13, Jeff Layton wrote:

> On Tue, 2025-03-25 at 18:35 -0400, trondmy@kernel.org wrote:
>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>
>> Replace the tests for the RPC client being shut down with tests for
>> whether the nfs_client is in an error state.
>>
>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>> ---
>>  fs/nfs/nfs4proc.c  | 2 +-
>>  fs/nfs/nfs4state.c | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index 889511650ceb..50be54e0f578 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -9580,7 +9580,7 @@ static void nfs41_sequence_call_done(struct rpc_=
task *task, void *data)
>>  		return;
>>
>>  	trace_nfs4_sequence(clp, task->tk_status);
>> -	if (task->tk_status < 0 && !task->tk_client->cl_shutdown) {
>> +	if (task->tk_status < 0 && clp->cl_cons_state >=3D 0) {
>>  		dprintk("%s ERROR %d\n", __func__, task->tk_status);
>>  		if (refcount_read(&clp->cl_count) =3D=3D 1)
>>  			return;
>> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
>> index 542cdf71229f..f1f7eaa97973 100644
>> --- a/fs/nfs/nfs4state.c
>> +++ b/fs/nfs/nfs4state.c
>> @@ -1198,7 +1198,7 @@ void nfs4_schedule_state_manager(struct nfs_clie=
nt *clp)
>>  	struct rpc_clnt *clnt =3D clp->cl_rpcclient;
>>  	bool swapon =3D false;
>>
>> -	if (clnt->cl_shutdown)
>> +	if (clp->cl_cons_state < 0)
>>  		return;
>>
>>  	set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
>
> One more thing:
>
> Do we need cl_shutdown at all? If we can replace these checks here with=

> a check for cl_cons_state < 0, why not do the same in call_start()?
> -- =

> Jeff Layton <jlayton@kernel.org>

Agree - I don't see why not.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


