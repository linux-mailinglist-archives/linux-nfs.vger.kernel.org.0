Return-Path: <linux-nfs+bounces-23227-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hGAxCq78T2oyrgIAu9opvQ
	(envelope-from <linux-nfs+bounces-23227-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 21:55:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E22F73536B
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 21:55:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cml4UFqz;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23227-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23227-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D1A43014951
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 19:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16CC305E19;
	Thu,  9 Jul 2026 19:55:23 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8331244999A
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jul 2026 19:55:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783626923; cv=none; b=A6/cg3YOEtplwphIv6yegr0WL93kxGLp1LyNXGOgyX7mLjYPjWrZ+kFDSF00USyWQPK7dajDCeMPFtQvw+YhYFbl5BOXhMdWvOPKvFPkNBn/zjSWZ+KsBxOL2GOV284hw3mEnoLIvHFQAOxE2B2unF+Yan6MI1kDnki4FWL2R0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783626923; c=relaxed/simple;
	bh=vB5ef3CjicVSgwCtd2eOHHL/izaG/8hSIjg8oe+70LI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rVmv9zUT7buG0FsmOY2v5+Hf5uz/Np9Jy86lhsNR117gGPvxMOcPy9Vfp+1faJHdVhrLVLE7QaVGlUj11gdu40Ekgy2u+6ZizJPqgVw6AJwqQoQYMzLRgozBZ2RwTt+SI+QtQePr6AAb9qvGWItdAECkaZtdbez9Qb955PFdT2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cml4UFqz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B191F000E9;
	Thu,  9 Jul 2026 19:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783626921;
	bh=QehIRXfaSslViHGlxa/4fwubHddtIj1CC3xCGbWWv8c=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=cml4UFqzGRAXz5ucwGyvdnk9q6YyOosAl5cZvO05yOjJUOOs/xnB8NfIubeWdXqmn
	 ICXVwWfDRCqtYznM6zS3jajKLEG51ISWaPKCuSIFvR3oQyof2XvB6Gi5makY+os4FS
	 jwSwp+fLTk+Mxxd/5+X0JyrxYh+Wane5gi2S8EhUA5oQDO6f2/aLcdI1N+jI3QDwKV
	 /Q4N3w8n8VTWcUykUraxiwtQqOKNiux4xzkWOZ5Al5OMaNu+BVbGwgSkprbDVl26Sv
	 3pBKtyJgezti5chd/af8BebadE40lLq/aDm2AzvbtcisW9RnTFC8JdhcbcS4aQofn1
	 n2Sd6rjtkVA3Q==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 897E3F4007A;
	Thu,  9 Jul 2026 15:55:20 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 09 Jul 2026 15:55:20 -0400
X-ME-Sender: <xms:qPxPanJKvcGeyYcYFq7HszucV6iN0Bc-4XHhYZWs6-VllOED1QVy0g>
    <xme:qPxPal_yIedE-tkd9UctRp3PgpTjLTQliv7BLw0SjCktYT3RDKtPvUWj2ddrsjy3Q
    w8P6i5NS5SWcO3cn1CDkTvRDuPCe-dtHIMjKkWs_Lc2ZxVyzwHH0g>
X-ME-Proxy-Cause: dmFkZTGpxNdCv2SyuiG5PkycyXZZbK/ZHIg1XenU8iRecF0Zhpqk2ES2xEgACHxmW+FxfI
    UXmEDLcm+OE6Lydr7PFxRdsd6J1nDSKvAGUg/TClZJLbCRToStCIDUpH+TiN6kgAgkPyPi
    zBJ+oqSZNLaTN2SIpzs0AyiP5+CpVRzcKB+Fikzl1cDfAoYkjqPMQEPAopBlS4o/RMoiB4
    NgtPMPIGoFwuk7fKdbCafzjBC79QzS3KNfp7FiB7RWvWIFiqSNvLDE7Az6gNOrmiLVDbbf
    7dIBCBLI8YD/zyvUXzieiagCVU/EBOCXB8pO5hvb6fgYtOKEmlc4yxPEClUjKecLORVUU5
    ogutnj+OgH9lHc3414BQKAGXar17+Ajl35ISSsSYmiE6zx1UDIbWsqvJ113sOdGyCfLQ3E
    OCPl3N/DR0hs/v9IRrtlae69eRAJFFspnVzkMXZPDzjh1o08sm6rR/p6t6n5EysZ0WkjVP
    lsksoM354joLpAYBYYAVaFQ0iR0/S+2pgZZ8DWCEdiEjalAungu7oSnAxFapuUqn+nbHl1
    DBix3Loeuo9R4HNDNOhHRviqdacn1AGtFR6ygmDi70zbw3SKYSMZtFqj5WkjI1pG+3UOXp
    sPYZYPZipSk6JGZhT0Ofm/xckClgF8UqwINSbmHgTNvKQZN9dCiUaPu1TwHg
X-ME-Proxy: <xmx:qPxParAUP4h0LhK-Icp0pPwUeLra9v0xvyovMY0NQNJkr1M54v7P7w>
    <xmx:qPxPaiNdYfAFugdnbWo6LfZz9TVHDKRgK_hU_kfUcPJ3E7xpnT2esQ>
    <xmx:qPxPakzuGlHTP58DISYTMNG4lJoF8hXQiLLrSSCYdrWJhZIKK1fbFw>
    <xmx:qPxPaiUe7aKDocczVG6nrQRjWfZKrx7xj9-Hcdl0vzY60l2RIz0BaA>
    <xmx:qPxPamNvAbzzlKeOXS6hpGps_IWMAZb3bl6gNBspfy3J4Q0i7weNJuDL>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 676C3780AB8; Thu,  9 Jul 2026 15:55:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Amiak35LOpZN
Date: Thu, 09 Jul 2026 15:55:00 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, sashiko-bot <sashiko-bot@kernel.org>
Message-Id: <2b2a1ec1-e2dd-4e87-b812-08fe17a993bd@app.fastmail.com>
In-Reply-To: <62b35e8e3073f16c7ffc514fc30f23c788d25486.camel@kernel.org>
References: <20260709-cel-v4-0-1d519d9be0cb@kernel.org>
 <20260709-cel-v4-9-1d519d9be0cb@kernel.org>
 <62b35e8e3073f16c7ffc514fc30f23c788d25486.camel@kernel.org>
Subject: Re: [PATCH v4 9/9] NFSD: Release the export reference when reaping open
 stateids
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23227-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,app.fastmail.com:mid,sashiko.dev:url];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E22F73536B



On Thu, Jul 9, 2026, at 2:40 PM, Jeff Layton wrote:
> On Thu, 2026-07-09 at 13:40 -0400, Chuck Lever wrote:
>> nfs4_put_stid() releases the svc_export tracked in
>> nfs4_stid.sc_export, but free_ol_stateid_reaplist() frees open and
>> lock stateids by calling ->sc_free() directly, bypassing that path.
>> An open stateid takes an sc_export reference in nfs4_open() and a
>> lock stateid takes its own in init_lock_stateid(); both reach
>> free_ol_stateid_reaplist() through their normal teardown, the open
>> stateid via release_open_stateid() and the lock stateid via
>> nfsd4_release_lockowner(), each through put_ol_stateid_locked().
>> The reference is therefore never dropped, pinning the export and
>> blocking unmount for the lifetime of the stateid.
>> 
>> Release sc_export in free_ol_stateid_reaplist() the way
>> nfs4_put_stid() does. ->sc_free() runs once per stateid, and a
>> stateid reaches free_ol_stateid_reaplist() or nfs4_put_stid() but
>> never both, so the reference is dropped exactly once. Revoked
>> stateids reach this path with sc_export already cleared by
>> drop_stid_export(), so they are skipped rather than double-freed.
>> 
>> nfs4_put_stid() itself read sc_export before acquiring cl_lock.
>> drop_stid_export() clears that field and releases the reference
>> under cl_lock, so a concurrent revocation could drop the export in
>> the window between the read and the final put, releasing the same
>> reference twice. Read sc_export while cl_lock is held so the two
>> paths serialize and the reference is released exactly once.
>> 
>> Fixes: ba0cde5dc81d ("NFSD: Track svc_export in nfs4_stid")
>> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
>> Closes: https://sashiko.dev/#/patchset/20260707-cel-v3-0-7c0cc16fd54f@kernel.org?part=9
>> Signed-off-by: Chuck Lever <cel@kernel.org>
>> ---
>>  fs/nfsd/nfs4state.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>> 
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 20556b8f186a..e988dfebf75e 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c

>> @@ -1753,9 +1756,12 @@ free_ol_stateid_reaplist(struct list_head *reaplist)
>>  				       st_locks);
>>  		list_del(&stp->st_locks);
>>  		fp = stp->st_stid.sc_file;
>> +		exp = stp->st_stid.sc_export;
>>  		stp->st_stid.sc_free(&stp->st_stid);
>>  		if (fp)
>>  			put_nfs4_file(fp);
>> +		if (exp)
>> +			exp_put(exp);
>
> nit: nfs4_put_stid() does this in the reverse order. It doesn't
> actually matter, but it looks a bit weird if you want to fix it up
> before merging.
>
>>  	}
>>  }
>>  
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Swap applied, series pushed to nfsd-testing. Thanks for your review!


-- 
Chuck Lever

