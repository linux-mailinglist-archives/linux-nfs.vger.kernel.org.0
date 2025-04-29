Return-Path: <linux-nfs+bounces-11349-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C41AA0E11
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 16:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F081B6163D
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 14:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8672C17AB;
	Tue, 29 Apr 2025 14:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ebOgjxWJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B7B433CE
	for <linux-nfs@vger.kernel.org>; Tue, 29 Apr 2025 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745935272; cv=none; b=gX4UFE9JbZCniQL0DY31ZU0GP6i7cVqe7Bbq1MnY73aL/DT7S28R5PUW9WzhIEhP5sma/HVATepNG9TNzioq7Ma4AnYuugmKMpQxTNfdiRx44sluI+NgOMLjDo/p/1LEev1Jc5ld/cdqP8Knz8dQ8bJDs0IyZpVF0gURDaNz2EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745935272; c=relaxed/simple;
	bh=qoHV7g6ieBUVn7jgtgwdUQj6HekkEUNVmzoNqWKmGFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iC0grsGHszmziZTUmhMEzRmFQ5HsWkp6+k7GONpf+FaEPuRAHkiS8iC4N4EL3ounbeNWD/YnaMn/tEiLOnkMVBcEPb/mYsHV7TWC27F8iyPosf9SMLrtJ3JUkIrdaOnZGNacX5B3LL4eX6SBPwcL5qllg1jwTQTcqfxaNZzDwD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ebOgjxWJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745935269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FLgNC1f31lWHg+FRxutROm+/y8G9IkKDp7ZXWyClI7g=;
	b=ebOgjxWJwB1WOjTDtzdxknQz4L2Ubg5Bi3kmmG4oX6Ue6J+wS4fsgM8yVQ9/P7tR2UDHt9
	GCIpDmbvcsFmmI2QHZPq2kf2XUcnO9MzgL+LpTFA+tWp0HZNK0iaYBYtvgclqavFOXdKv/
	1TY8oX5cwSEBVkraqOGyixmZ4gMNLBk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-ezTbqvSmNFWBlM0j7wOqzg-1; Tue,
 29 Apr 2025 10:01:06 -0400
X-MC-Unique: ezTbqvSmNFWBlM0j7wOqzg-1
X-Mimecast-MFC-AGG-ID: ezTbqvSmNFWBlM0j7wOqzg_1745935265
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D30B419560B2;
	Tue, 29 Apr 2025 14:01:04 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.76.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD09C30001A2;
	Tue, 29 Apr 2025 14:01:03 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] NFSv4: Ensure test_and_free_stateid callers use
 private memory
Date: Tue, 29 Apr 2025 10:01:01 -0400
Message-ID: <27D8C67C-32A1-41BB-997F-0617F74A9626@redhat.com>
In-Reply-To: <85735CF0-FB7E-4B76-AABA-770D199D435A@redhat.com>
References: <cover.1745430006.git.bcodding@redhat.com>
 <eb9c88aacce78595a079c2f248395af3e823239f.1745430006.git.bcodding@redhat.com>
 <851b8c0884038fd496517cce61ef2c53b41ed8a2.camel@kernel.org>
 <85735CF0-FB7E-4B76-AABA-770D199D435A@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 23 Apr 2025, at 18:04, Benjamin Coddington wrote:

> On 23 Apr 2025, at 16:35, Jeff Layton wrote:
>
>> On Wed, 2025-04-23 at 13:59 -0400, Benjamin Coddington wrote:
>>> A follow-up patch intends to signal the success or failure of FREE_ST=
ATEID
>>> by modifying the nfs4_stateid's type which requires the const qualifi=
er for
>>> the nfs4_stateid to be dropped.  Since it will no longer safe to oper=
ate
>>> directly on shared stateid objects in this path, ensure that callers =
send a
>>> copy.
>>>
>>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>>> ---
>>>  fs/nfs/nfs4proc.c | 12 +++++++-----
>>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>> index 6e95db6c17e9..bfb9e980d662 100644
>>> --- a/fs/nfs/nfs4proc.c
>>> +++ b/fs/nfs/nfs4proc.c
>>> @@ -2990,6 +2990,7 @@ static void nfs41_delegation_recover_stateid(st=
ruct nfs4_state *state)
>>>  static int nfs41_check_expired_locks(struct nfs4_state *state)
>>>  {
>>>  	int status, ret =3D NFS_OK;
>>> +	nfs4_stateid stateid;
>>>  	struct nfs4_lock_state *lsp, *prev =3D NULL;
>>>  	struct nfs_server *server =3D NFS_SERVER(state->inode);
>>>
>>> @@ -3007,9 +3008,9 @@ static int nfs41_check_expired_locks(struct nfs=
4_state *state)
>>>  			nfs4_put_lock_state(prev);
>>>  			prev =3D lsp;
>>>
>>> +			nfs4_stateid_copy(&stateid, &lsp->ls_stateid);
>>>  			status =3D nfs41_test_and_free_expired_stateid(server,
>>> -					&lsp->ls_stateid,
>>> -					cred);
>>> +					&stateid, cred);
>>>  			trace_nfs4_test_lock_stateid(state, lsp, status);
>>>  			if (status =3D=3D -NFS4ERR_EXPIRED ||
>>>  			    status =3D=3D -NFS4ERR_BAD_STATEID) {
>>> @@ -3042,17 +3043,18 @@ static int nfs41_check_expired_locks(struct n=
fs4_state *state)
>>>  static int nfs41_check_open_stateid(struct nfs4_state *state)
>>>  {
>>>  	struct nfs_server *server =3D NFS_SERVER(state->inode);
>>> -	nfs4_stateid *stateid =3D &state->open_stateid;
>>> +	nfs4_stateid stateid;
>>>  	const struct cred *cred =3D state->owner->so_cred;
>>>  	int status;
>>>
>>>  	if (test_bit(NFS_OPEN_STATE, &state->flags) =3D=3D 0)
>>>  		return -NFS4ERR_BAD_STATEID;
>>> -	status =3D nfs41_test_and_free_expired_stateid(server, stateid, cre=
d);
>>> +	nfs4_stateid_copy(&stateid, &state->open_stateid);
>>> +	status =3D nfs41_test_and_free_expired_stateid(server, &stateid, cr=
ed);
>>>  	trace_nfs4_test_open_stateid(state, NULL, status);
>>>  	if (status =3D=3D -NFS4ERR_EXPIRED || status =3D=3D -NFS4ERR_BAD_ST=
ATEID) {
>>>  		nfs_state_clear_open_state_flags(state);
>>> -		stateid->type =3D NFS4_INVALID_STATEID_TYPE;
>>> +		state->open_stateid.type =3D NFS4_INVALID_STATEID_TYPE;
>>>  		return status;
>>>  	}
>>>  	if (nfs_open_stateid_recover_openmode(state))
>>
>> I don't know that you really need to do this. In the cases where you
>> end up setting the type to FREED, you will also return NFS4ERR_EXPIRED=
,
>> which will make the callers set the type to INVALID.
>>
>> There will be a brief window where the type will be set to FREED, but
>> that should be no big deal.
>
> Definitely playing it safe here, I think I have to worry about concurre=
ncy -
> who else might be simultaneously looking at that nfs4_state->open_state=
id.type?
> I really don't want to introduce a regression because we knew we weren'=
t
> modifying that stateid before.
>
> I suppose I can dive into an audit and see if that can actually happen.=


After looking theoretically there shouldn't be a race in either of these =
two
paths since we'll only be here doing reclaim/recovery and operating on th=
e
state sequentially.  State recovery will have drained and blocked paralle=
l
opens.

I'll send just the 2nd patch in another version.

Ben


