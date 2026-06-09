Return-Path: <linux-nfs+bounces-22395-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lqtmCqzlJ2o44QIAu9opvQ
	(envelope-from <linux-nfs+bounces-22395-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 12:06:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA2365EB5E
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 12:06:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=leemhuis.info header.s=key2 header.b=Hmtsl0zj;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22395-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22395-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF567302D5CF
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 10:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790493DF018;
	Tue,  9 Jun 2026 10:05:14 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3702E7396;
	Tue,  9 Jun 2026 10:05:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999514; cv=none; b=GMGXw73fUGJmEyJBhdeW0hcSX1RHhqH8w2QFrswLTsGFDV/tRxQDUNsy0VZxPNmQa+F1fpf8FfDK1DcwQu49+L4qHnxXT0zDGZg4yMp6x10Nbo8/aOtgktdwZ8Fv6HaFYXsmZB6l9HwChHFdvJ6xRF8kpz3BePAE/zH8CxT4Ks4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999514; c=relaxed/simple;
	bh=QFWyBeqeXsXODEh72YQTER2tbPIg1Y7V0Lk+AAPpN5k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=n6ij6oam/0b1pJd7csYbfvKYFxDxqSpOUCtzyT9LJST4Is+O/Qrq7ET4xK4G0qqqRrDO9yZAx7/hi2RGdPxaEfR9oXnkzfDH0rYi2+2+j+6LIt0/gOTxTF1luNv6Xk6QG8qWxZUBCmlqkzrfcKumBamUO7Cm4zFWsoJtTj5l7HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Hmtsl0zj; arc=none smtp.client-ip=188.68.61.103
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4gZPfY4nJlz8CSR;
	Tue,  9 Jun 2026 12:05:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1780999509;
	bh=QFWyBeqeXsXODEh72YQTER2tbPIg1Y7V0Lk+AAPpN5k=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Hmtsl0zjZJ04zsZoHoHnHUpdL3e1xT+qdq+SxPxaAOnrfmRgAilEQH6v5oKEFPsQN
	 n1B0qnqDxuE5Emq4OfBYs7VyGlRAsK/BNeaPWjx0lVk6TMxwQcEIMfdAEqO5EWqAu+
	 KqVQotgz1ju+Hhj9hMU7jvZGzmzRCwaVHh6iy/YHe9JJwRFPODKRdB1fk0WYsPh7iu
	 Na9vKAfnGRwMQoXhu8zCmPheVlePzUMBA2hLwfe9/Rao2SGxtfj9hIRvpd6vPtUYEH
	 5rnRW/cfmUuXjldLgrSz45mgAC3qC0yi30AxegOBhatuT77KaHBp2Z9PMqwOUiBIDO
	 6qxKc5VqL6SQA==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4gZPfY447dz8Bgj;
	Tue,  9 Jun 2026 12:05:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4gZPfX4HwNz8t4T;
	Tue,  9 Jun 2026 12:05:08 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id C18135F96B;
	Tue,  9 Jun 2026 12:05:07 +0200 (CEST)
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <5cbf8431-e3c4-41d9-afcd-fb121dc12395@leemhuis.info>
Date: Tue, 9 Jun 2026 12:05:06 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFSv4: clear exception state on successful mkdir retry
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: Trond Myklebust <trondmy@kernel.org>, NeilBrown <neil@brown.name>,
 Anna Schumaker <anna@kernel.org>, Igor Raits <igor.raits@gmail.com>
Cc: =?UTF-8?B?SmFuIMSMw61wYQ==?= <jan.cipa@gooddata.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <177745671692.1474915.5018486129724109553@noble.neil.brown.name>
 <20260429104938.1776671-1-igor.raits@gmail.com>
 <971ecb6c-2687-429f-af86-fc980c2d04f9@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <971ecb6c-2687-429f-af86-fc980c2d04f9@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <178099950819.2754868.10331645572987338434@mxe9fb.netcup.net>
X-NC-CID: hk1XyinkLA2SwZHbK5SCpGsD7vDqiQfNWsmxs+25BdLmQbHAp7Y=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22395-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:neil@brown.name,m:anna@kernel.org,m:igor.raits@gmail.com,m:jan.cipa@gooddata.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:regressions@lists.linux.dev,m:igorraits@gmail.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[leemhuis.info:dkim,leemhuis.info:mid,leemhuis.info:from_mime,vger.kernel.org:from_smtp,gooddata.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FREEMAIL_TO(0.00)[kernel.org,brown.name,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[leemhuis.info];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[regressions@leemhuis.info,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BEA2365EB5E

On 5/13/26 09:18, Thorsten Leemhuis wrote:
> [top-posting to facilitate processing]
> 
> @NFSv4 maintainers, just wondering, did this patch maybe fall through
> the cracks? It fixes a regression, that's why it's on my radar. Or was
> there some progress and I missed it?

Still no progress afaics. Feels like I'm missing something obvious or
like I'm totally of track.

Igor, Neil, is that the case? Or are you also waiting for the fix to
make progress?

Ciao, Thorsten

> On 4/29/26 12:49, Igor Raits wrote:
>> After a server returns NFS4ERR_DELAY for an NFSv4 CREATE issued by
>> mkdir(2), the client correctly waits and retries.  When the retry
>> succeeds, however, mkdir(2) can still surface -EEXIST to userspace
>> even though the directory was just created on the server.
>>
>> Reproducer (random 16-hex names so collisions are not the cause)
>> against an in-kernel Linux nfsd; reproduces under both NFSv4.0 and
>> NFSv4.2:
>>
>>   N=2000000; base=/var/gdc/export
>>   for ((i=1; i<=N; i++)); do
>>       d=$base/$(openssl rand -hex 8)
>>       mkdir "$d" 2>/dev/null || echo "$(date +%T) failed loop=$i $d"
>>       rmdir "$d" 2>/dev/null
>>   done
>>
>> Failures cluster at the cadence at which the server-side auth/export
>> cache refresh path causes nfsd to return NFS4ERR_DELAY for CREATE.
>>
>> A wire trace of one failure (the three CREATE RPCs all come from a
>> single mkdir(2), generated by the do-while in nfs4_proc_mkdir()):
>>
>>   client -> server  CREATE name=...  -> NFS4ERR_DELAY
>>   ~100 ms later
>>   client -> server  CREATE name=...  -> NFS4_OK         (dir created)
>>   ~80 us later
>>   client -> server  CREATE name=...  -> NFS4ERR_EXIST   (correct)
>>
>> Since commit dd862da61e91 ("nfs: fix incorrect handling of large-number
>> NFS errors in nfs4_do_mkdir()"), nfs4_handle_exception() is called only
>> when _nfs4_proc_mkdir() returned an error.  That gate breaks retry-state
>> hygiene: nfs4_do_handle_exception() resets exception.{delay,recovering,
>> retry} to 0 on entry, so calling it on success is what previously
>> cleared the retry flag set by the preceding NFS4ERR_DELAY iteration.
>> With the gate in place, exception.retry stays at 1 after the successful
>> retry, the loop runs once more, and the resulting CREATE for an
>> already-created name yields NFS4ERR_EXIST -> -EEXIST to userspace.
>>
>> Drop the conditional and call nfs4_handle_exception() unconditionally,
>> matching every other do-while in fs/nfs/nfs4proc.c (nfs4_proc_symlink(),
>> nfs4_proc_link(), etc.).  The dentry/status separation introduced by
>> that commit is preserved.
>>
>> Fixes: dd862da61e91 ("nfs: fix incorrect handling of large-number NFS errors in nfs4_do_mkdir()")
>> Reported-and-tested-by: Jan Čípa <jan.cipa@gooddata.com>
>> Closes: https://lore.kernel.org/linux-nfs/CA+9S74hSp_tJu2Ffe2BPNC2T25gfkhgjjDkdgSsF5c2rnJq_wA@mail.gmail.com/
>> Reviewed-by: NeilBrown <neil@brown.name>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Igor Raits <igor.raits@gmail.com>
>> ---
>>  fs/nfs/nfs4proc.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index a0885ae55abc..ffd14141ea1d 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -5393,10 +5393,9 @@ static struct dentry *nfs4_proc_mkdir(struct inode *dir, struct dentry *dentry,
>>  	do {
>>  		alias = _nfs4_proc_mkdir(dir, dentry, sattr, label, &err);
>>  		trace_nfs4_mkdir(dir, &dentry->d_name, err);
>> +		err = nfs4_handle_exception(NFS_SERVER(dir), err, &exception);
>>  		if (err)
>> -			alias = ERR_PTR(nfs4_handle_exception(NFS_SERVER(dir),
>> -							      err,
>> -							      &exception));
>> +			alias = ERR_PTR(err);
>>  	} while (exception.retry);
>>  	nfs4_label_release_security(label);
>>  
> 


