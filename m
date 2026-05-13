Return-Path: <linux-nfs+bounces-21592-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEGZAaUmBGqaEwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21592-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 09:22:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5552652E8BC
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 09:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 55B5F30909D6
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 07:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E783D5C35;
	Wed, 13 May 2026 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="lc+V16PP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B997038F24F;
	Wed, 13 May 2026 07:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778656754; cv=none; b=LbN+uQet1TPuhwxKNgHB9Qp+nQT1IKXdfAqq+q7pEkisFa+64mZcUvNHCPeg5EPMHSYUs2NqV8FyegVtGQFpGCroe1aIYaR830x7ecbfb28Jb5CFvl6BaHpf5NateSfxvMcHH4TsOPDuU1NumFLFMTEjWclDfJnjVbfLgf2Zcnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778656754; c=relaxed/simple;
	bh=5kxVGKfQe8uBn9mf2fs5xsMbfVIyrxVpHyE3jgy1Fd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqId/og6Iyl8w61NTVErOxtBD1TUmBO1eBRiC7E+E0H8iaKGmy0MzpK4P17ME2VoxqLKBiNlrE+uWswN/GS415iPAWYhFn2PeKykf5c4T+MKv3Ij3N4OXZjJm+UrLX3cXgTV1Jk+KFrABwAEylac1J1jGMnWJBBoFRp7BIEzdWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=lc+V16PP; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4gFlFN11Dvz4F7D;
	Wed, 13 May 2026 09:19:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1778656744;
	bh=5kxVGKfQe8uBn9mf2fs5xsMbfVIyrxVpHyE3jgy1Fd8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lc+V16PPveBadlZYCOkbn+9whCItXAenypm5jWaMuYU7tORDmg+YwY5zPurTT826g
	 jwZucYVWPJ58OSCKG5EB/s+sOtZt557mWTPf/W+tAzDMLOJ2JkzNCZp/T4yRhO3aCL
	 xBQo4xOhoMX92Xb7gj0gUndk/51msCjjKG8J5AXgQ7fYPxhWX4gB25Druu3Cl5YmZ7
	 89pWsk5qIo/VgHQJ86tcbBnG86Iq0B0fC/Ul2d9yNAImRzh4Xddvaj2yB1qo4JW6Nc
	 X36eyqMHsdk1wNbOE6bQigDsOLCZincbtgsUTsNUO4k3ovH6Skyiam5KfsoC5Tjz5m
	 Ojl4SVIZ0aKDg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4gFlF40DMQz7wtc;
	Wed, 13 May 2026 09:18:48 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gFlF32Svqz8sZP;
	Wed, 13 May 2026 09:18:47 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 9633961840;
	Wed, 13 May 2026 09:18:46 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <971ecb6c-2687-429f-af86-fc980c2d04f9@leemhuis.info>
Date: Wed, 13 May 2026 09:18:45 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFSv4: clear exception state on successful mkdir retry
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: NeilBrown <neil@brown.name>, =?UTF-8?B?SmFuIMSMw61wYQ==?=
 <jan.cipa@gooddata.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Igor Raits <igor.raits@gmail.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <177745671692.1474915.5018486129724109553@noble.neil.brown.name>
 <20260429104938.1776671-1-igor.raits@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
X-Enigmail-Draft-Status: N11222
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <20260429104938.1776671-1-igor.raits@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177865672697.2026246.4275505350607620547@mxe9fb.netcup.net>
X-NC-CID: ygNZwBd7ph64L/KKoGw8R+beybIRJGKhvAc2Q28ZTMwh6wJ0svQ=
X-Rspamd-Queue-Id: 5552652E8BC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[brown.name,gooddata.com,vger.kernel.org,gmail.com,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21592-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

[top-posting to facilitate processing]

@NFSv4 maintainers, just wondering, did this patch maybe fall through
the cracks? It fixes a regression, that's why it's on my radar. Or was
there some progress and I missed it?

Ciao, Thorsten

On 4/29/26 12:49, Igor Raits wrote:
> After a server returns NFS4ERR_DELAY for an NFSv4 CREATE issued by
> mkdir(2), the client correctly waits and retries.  When the retry
> succeeds, however, mkdir(2) can still surface -EEXIST to userspace
> even though the directory was just created on the server.
> 
> Reproducer (random 16-hex names so collisions are not the cause)
> against an in-kernel Linux nfsd; reproduces under both NFSv4.0 and
> NFSv4.2:
> 
>   N=2000000; base=/var/gdc/export
>   for ((i=1; i<=N; i++)); do
>       d=$base/$(openssl rand -hex 8)
>       mkdir "$d" 2>/dev/null || echo "$(date +%T) failed loop=$i $d"
>       rmdir "$d" 2>/dev/null
>   done
> 
> Failures cluster at the cadence at which the server-side auth/export
> cache refresh path causes nfsd to return NFS4ERR_DELAY for CREATE.
> 
> A wire trace of one failure (the three CREATE RPCs all come from a
> single mkdir(2), generated by the do-while in nfs4_proc_mkdir()):
> 
>   client -> server  CREATE name=...  -> NFS4ERR_DELAY
>   ~100 ms later
>   client -> server  CREATE name=...  -> NFS4_OK         (dir created)
>   ~80 us later
>   client -> server  CREATE name=...  -> NFS4ERR_EXIST   (correct)
> 
> Since commit dd862da61e91 ("nfs: fix incorrect handling of large-number
> NFS errors in nfs4_do_mkdir()"), nfs4_handle_exception() is called only
> when _nfs4_proc_mkdir() returned an error.  That gate breaks retry-state
> hygiene: nfs4_do_handle_exception() resets exception.{delay,recovering,
> retry} to 0 on entry, so calling it on success is what previously
> cleared the retry flag set by the preceding NFS4ERR_DELAY iteration.
> With the gate in place, exception.retry stays at 1 after the successful
> retry, the loop runs once more, and the resulting CREATE for an
> already-created name yields NFS4ERR_EXIST -> -EEXIST to userspace.
> 
> Drop the conditional and call nfs4_handle_exception() unconditionally,
> matching every other do-while in fs/nfs/nfs4proc.c (nfs4_proc_symlink(),
> nfs4_proc_link(), etc.).  The dentry/status separation introduced by
> that commit is preserved.
> 
> Fixes: dd862da61e91 ("nfs: fix incorrect handling of large-number NFS errors in nfs4_do_mkdir()")
> Reported-and-tested-by: Jan Čípa <jan.cipa@gooddata.com>
> Closes: https://lore.kernel.org/linux-nfs/CA+9S74hSp_tJu2Ffe2BPNC2T25gfkhgjjDkdgSsF5c2rnJq_wA@mail.gmail.com/
> Reviewed-by: NeilBrown <neil@brown.name>
> Cc: stable@vger.kernel.org
> Signed-off-by: Igor Raits <igor.raits@gmail.com>
> ---
>  fs/nfs/nfs4proc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index a0885ae55abc..ffd14141ea1d 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -5393,10 +5393,9 @@ static struct dentry *nfs4_proc_mkdir(struct inode *dir, struct dentry *dentry,
>  	do {
>  		alias = _nfs4_proc_mkdir(dir, dentry, sattr, label, &err);
>  		trace_nfs4_mkdir(dir, &dentry->d_name, err);
> +		err = nfs4_handle_exception(NFS_SERVER(dir), err, &exception);
>  		if (err)
> -			alias = ERR_PTR(nfs4_handle_exception(NFS_SERVER(dir),
> -							      err,
> -							      &exception));
> +			alias = ERR_PTR(err);
>  	} while (exception.retry);
>  	nfs4_label_release_security(label);
>  


