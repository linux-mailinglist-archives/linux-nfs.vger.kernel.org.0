Return-Path: <linux-nfs+bounces-11258-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F7BA99B31
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Apr 2025 00:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB415A67BF
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 22:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AEA1DE3AD;
	Wed, 23 Apr 2025 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S06mlaei"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E9E38382
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 22:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745445891; cv=none; b=HHNGQDyjlwhz0t9hwjW+HIT/KQJ56oRwk9TOljNO/RZjQP3rqIDiunMjFsJn6I2b8YJgu8qBsyly1SFTC8RgnvlhvIrjTRhBUZRvwTAF/1Y1NU2JEeQAkNtlBkAfpmPrutPBrf3qrKODu49Ct7pkZr0cPSnA2/y/Q4uiZlE3i8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745445891; c=relaxed/simple;
	bh=ZTzZPRskhRw7dzbbXvrQVk4LoTBDh5R28jJi4CKAeRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZWXj1c1Y7JJSm4eK83mDrOGccVi5+HUVuTJ717qftOpp5w++licqvmhGXHIWzaX6TjT/q4x78I3/xQ8V+uI85/EITSUu1m9w/q8WCAjZtuPTkl/iQRNz26Klx6xBOzIB+j0/heF29sCIUW1Y2jqBrM8Ddz4xdDXoBqvYs4Zogo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S06mlaei; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745445888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YR2LOjWFPjkYRy41cuOSzphhCqEgmfWjdM4QYqLZ4YA=;
	b=S06mlaeicCXgEyCFWp+ezPo92TkAMs89CRabpceIeGIAEj5B2JQzv581m1EZrM0hIGoxTK
	gRAa8xEjud5JTZEzM1MXnnFwK0we8VBl0qzmDbVhiB5eTk5ESqITlXwfGNMUvDSeJ/VT+V
	6fNoL0DAk0c6/gDrKStjTEkZFhyjMuI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-I2hYyG4jPmauBJE1MaY5Aw-1; Wed,
 23 Apr 2025 18:04:42 -0400
X-MC-Unique: I2hYyG4jPmauBJE1MaY5Aw-1
X-Mimecast-MFC-AGG-ID: I2hYyG4jPmauBJE1MaY5Aw_1745445881
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 047871955DC5;
	Wed, 23 Apr 2025 22:04:41 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.16])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC552195608D;
	Wed, 23 Apr 2025 22:04:39 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] NFSv4: Ensure test_and_free_stateid callers use
 private memory
Date: Wed, 23 Apr 2025 18:04:37 -0400
Message-ID: <85735CF0-FB7E-4B76-AABA-770D199D435A@redhat.com>
In-Reply-To: <851b8c0884038fd496517cce61ef2c53b41ed8a2.camel@kernel.org>
References: <cover.1745430006.git.bcodding@redhat.com>
 <eb9c88aacce78595a079c2f248395af3e823239f.1745430006.git.bcodding@redhat.com>
 <851b8c0884038fd496517cce61ef2c53b41ed8a2.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 23 Apr 2025, at 16:35, Jeff Layton wrote:

> On Wed, 2025-04-23 at 13:59 -0400, Benjamin Coddington wrote:
>> A follow-up patch intends to signal the success or failure of FREE_STA=
TEID
>> by modifying the nfs4_stateid's type which requires the const qualifie=
r for
>> the nfs4_stateid to be dropped.  Since it will no longer safe to opera=
te
>> directly on shared stateid objects in this path, ensure that callers s=
end a
>> copy.
>>
>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>> ---
>>  fs/nfs/nfs4proc.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index 6e95db6c17e9..bfb9e980d662 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -2990,6 +2990,7 @@ static void nfs41_delegation_recover_stateid(str=
uct nfs4_state *state)
>>  static int nfs41_check_expired_locks(struct nfs4_state *state)
>>  {
>>  	int status, ret =3D NFS_OK;
>> +	nfs4_stateid stateid;
>>  	struct nfs4_lock_state *lsp, *prev =3D NULL;
>>  	struct nfs_server *server =3D NFS_SERVER(state->inode);
>>
>> @@ -3007,9 +3008,9 @@ static int nfs41_check_expired_locks(struct nfs4=
_state *state)
>>  			nfs4_put_lock_state(prev);
>>  			prev =3D lsp;
>>
>> +			nfs4_stateid_copy(&stateid, &lsp->ls_stateid);
>>  			status =3D nfs41_test_and_free_expired_stateid(server,
>> -					&lsp->ls_stateid,
>> -					cred);
>> +					&stateid, cred);
>>  			trace_nfs4_test_lock_stateid(state, lsp, status);
>>  			if (status =3D=3D -NFS4ERR_EXPIRED ||
>>  			    status =3D=3D -NFS4ERR_BAD_STATEID) {
>> @@ -3042,17 +3043,18 @@ static int nfs41_check_expired_locks(struct nf=
s4_state *state)
>>  static int nfs41_check_open_stateid(struct nfs4_state *state)
>>  {
>>  	struct nfs_server *server =3D NFS_SERVER(state->inode);
>> -	nfs4_stateid *stateid =3D &state->open_stateid;
>> +	nfs4_stateid stateid;
>>  	const struct cred *cred =3D state->owner->so_cred;
>>  	int status;
>>
>>  	if (test_bit(NFS_OPEN_STATE, &state->flags) =3D=3D 0)
>>  		return -NFS4ERR_BAD_STATEID;
>> -	status =3D nfs41_test_and_free_expired_stateid(server, stateid, cred=
);
>> +	nfs4_stateid_copy(&stateid, &state->open_stateid);
>> +	status =3D nfs41_test_and_free_expired_stateid(server, &stateid, cre=
d);
>>  	trace_nfs4_test_open_stateid(state, NULL, status);
>>  	if (status =3D=3D -NFS4ERR_EXPIRED || status =3D=3D -NFS4ERR_BAD_STA=
TEID) {
>>  		nfs_state_clear_open_state_flags(state);
>> -		stateid->type =3D NFS4_INVALID_STATEID_TYPE;
>> +		state->open_stateid.type =3D NFS4_INVALID_STATEID_TYPE;
>>  		return status;
>>  	}
>>  	if (nfs_open_stateid_recover_openmode(state))
>
> I don't know that you really need to do this. In the cases where you
> end up setting the type to FREED, you will also return NFS4ERR_EXPIRED,=

> which will make the callers set the type to INVALID.
>
> There will be a brief window where the type will be set to FREED, but
> that should be no big deal.

Definitely playing it safe here, I think I have to worry about concurrenc=
y -
who else might be simultaneously looking at that nfs4_state->open_stateid=
=2Etype?
I really don't want to introduce a regression because we knew we weren't
modifying that stateid before.

I suppose I can dive into an audit and see if that can actually happen.

Thanks for looking at this,

Ben


