Return-Path: <linux-nfs+bounces-23140-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HCeFDfwbTWrzvAEAu9opvQ
	(envelope-from <linux-nfs+bounces-23140-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 17:32:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D2271D4D6
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 17:32:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kcqvs8c8;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23140-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23140-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6320E301B80D
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2026 15:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C68B41F7E8;
	Tue,  7 Jul 2026 15:30:30 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A4842F704
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jul 2026 15:30:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438230; cv=none; b=tvWik37X6nn19TlcPr/is4hCqEiSkm9tu5MyQXGt1Qx16Zhw7CQ7ZhaSG+D1MwPYjja6/RWHATBxPWZEpX3jgzh3Csn2KwwrotSK2RndARku8XEZAsAm/YkDcXi8qqlfm413Wy+1IhNN0sg4pDnLzmZuNnZyMkkdNE8vr9LFtMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438230; c=relaxed/simple;
	bh=V1xGZHFVoZ81++yMLSTAMmElWSdiH0/gtCxlky8nfzc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=k/Vh+T6AGcFkodB5wFT+Psh89VRf6xYFhlBxa8PeWDXFQ1tazUbfQsJqqhXlibftiEjl8X8rJ6//pLQ8SuCNgdhb3KOLjsBxuZb9SzjsuJcqlW0/URK//d4R7hpOQjLw6pQ/FG7wZfAJNX+xCmc+xtYDQLy3qJZCsU49Vac2fW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcqvs8c8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480861F00A3A;
	Tue,  7 Jul 2026 15:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783438228;
	bh=/71CJIJj/372HaTJLbHDRVTsJWBpzqi3SyYv6rObtcQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=kcqvs8c8euO6u1bO4SHMtIEwa122VjRxrGdPgzM3JpWmQXUxoOmXXWhXnpbTA2PYK
	 oGLteM9TopSplwCAQnLudeUgVczAG8UGScxlz4EDb2aAaGKNKmpVShbrEyod7Sk6p6
	 5MBJXAdg9fpy0DFY69+br9Y0q16jxplFMTno2uVQ6rGbiFhlMsHsyMCLGM45W9wPBd
	 jwG1TkfyHKdtxc+bUEip17YNrv4uBCb5g1+Lyyv/t7LArBs9a7Qul6fu4FAoWPYOHV
	 c4Zy1P4TOlf/AA+IPI6mjg+0FB7TIAy9EyLSCuZvrd8efzHPWY1sbW8ei6UQt9NPeR
	 dPcdC7Q9+zAdg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 49D99F40068;
	Tue,  7 Jul 2026 11:30:27 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 07 Jul 2026 11:30:27 -0400
X-ME-Sender: <xms:kxtNahCUheIQUzbHWIIGxFbrAA1AKZ7sHXNfqN_9Iap5-7fws0dPVg>
    <xme:kxtNaqU-NbDhItZCwZTDVHK7bzMN88rl16prEnOLcJwCpF9l0Kr4lj2pXlFTsbE6X
    PEJtDNbk96uveuFugjyW4FyC4iVwJn-xFaj8eHlndXCFUwGoeZDn0I>
X-ME-Proxy-Cause: dmFkZTF8CYYJORdah/pa5Kz9GxNUoK9ttE0qEWJenC+/GbU5/i7aUcXsw4pWZgWgvRJg7h
    528Vi08mm13gcgYiLaxhJ3EMoLQ9wuSnFwCMQlXDbznfzDMQuA0oYl5uvyy0hQCwPKqkVa
    ACdQk+RGO+iHxqSVwrM3T85SeqUTtGZTygTaDJuFpzXQ32ojlFyPlQdVyyfDpasrl7v7uz
    cALqTOqjQOd56yc9Fp7Zgo3Sc+bijZfe+uu+oWdHIyKhAZUFgEiuJRV3oAutvOuldb2jAe
    X5sdC1a/Uyaf4M9YkYm9lSDuT9KM92LelzWE3qbySRqpVx6j9m37P+yOxUAn9/XQXCOrW7
    et751n3D+kM1s4Fxcs1pD6Z3Bz9PF4kFu4RxBfNYfCQ7aNW2mMhli13B4NpPAKbnycC1LK
    skhjr0v1i+Ctu1YBGyaf2CYUDBCBkZBSISKddhtQaGshu67reg76jZUN1qKjdDfWFrPCZz
    Z6Gjh4dD/2aOssjAHnmO/SstCULP+jB7Ssyao7LW8XU5Hls7+wgoSaPgPChcYRStCppcXM
    szALqnF77TNES89W58UhEWTQa+gQV7XVui2fYFAXMy9D/Cv2BRYdf5v9kVNDiEcaII+r2U
    rfw/gcQh1CMWzCfk1t97HN6ZZRSPeYNqkf07nzwiPJoqGCgR1RDqEli1ngNw
X-ME-Proxy: <xmx:kxtNaroQ5sPhhSjcG7wyGu5J8EOvDHB5Xxpxf5gg52_kKWogExPo8Q>
    <xmx:kxtNajdJlKw5G14nDIyvLOJ_yhJtBy2fnvD7iBNKOfqjuW32mw7jkg>
    <xmx:kxtNairM35KIDQRAdsyRMgDOZcrMFyPF4Wfwb6BBq_1TXd1TFTODPQ>
    <xmx:kxtNasH3BYzUe7kQpU6vEQVzs37Z9W-ZOEylWvlGDq5xpi-LIpoW_w>
    <xmx:kxtNaqv2-EZxUYsplpzPMkeyV5Beg0YV57JNe_R6HTYGTcoabO_aqll9>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 223E2780ABB; Tue,  7 Jul 2026 11:30:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A6cbh1DIr1pc
Date: Tue, 07 Jul 2026 11:30:06 -0400
From: "Chuck Lever" <cel@kernel.org>
To: tilan@janestreet.com, "Trond Myklebust" <trondmy@kernel.org>
Cc: "Anna Schumaker" <anna@kernel.org>, linux-nfs@vger.kernel.org
Message-Id: <dfe72971-5478-45dd-82c1-0aa2e1156aee@app.fastmail.com>
In-Reply-To: <20260707144357.2920584-1-tilan@janestreet.com>
References: <122c658755fcb4b2d1264a7fd62fa8eda571f67b.camel@kernel.org>
 <20260707144357.2920584-1-tilan@janestreet.com>
Subject: Re: nfs: opening a file with O_WRONLY|O_CREAT flags can result in permission
 denied error
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-23140-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tilan@janestreet.com,m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,janestreet.com:email];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99D2271D4D6



On Tue, Jul 7, 2026, at 10:43 AM, tilan@janestreet.com wrote:
>>> Hello,
>>> 
>>> We recently noticed there is a behavior change w.r.t opening a file 
>>> with the O_WRONLY|O_CREAT flags over the NFSv3 protocol after
>>> upgrading
>>> the kernel from 6.1 LTS to 6.12 LTS. From the packets capturing, it
>>> seems
>>> like the kernel would now issue an additional CREATE rpc call to the
>>> remote NFS server regardless if the target file pre-exists or not.
>>> The CREATE rpc request could return an EACCES error if the client
>>> only has 
>>> the write permission to the pre-existing file but no write permission
>>> on 
>>> the directory containing the pre-existing file. This causes the
>>> openat 
>>> syscall to fail with permission denied error which is not expected.
>>> 
>>> After doing some code tracing, it seems like the new behavior was
>>> introduced as part of 7c6c5249f061 ("NFS: add atomic_open for NFSv3
>>> to
>>> handle O_TRUNC correctly."). We would like to confirm if the current 
>>> behavior that we are observing with the 6.12 kernel is expected given
>>> that the new behavior breaks existing user's application code. We 
>>> currently have a workaround by explicitly remove the O_CREAT flag
>>> when 
>>> opening a pre-existing file for write, but would still prefer not
>>> have
>>> to apply this workaround when upgrading to the newer kernel.
>
>> What server are you using?
>
> The permission error was reproduced against a vendor appliance, running
> the same test against NFSD seems to yield a different result
> (no permission errors) due to differences in behavior from the CREATE 
> RPC implementation.
>
> NFSD behavior
>
>   - CREATE RPC (UNCHECKED mode) returns the filehandle of the 
>     existing file along with the file's attributes
>	  
> Vendor appliance
>
>   - CREATE RPC (UNCHECKED mode) always attempts to create a new
>     file and returns the new filehandle. This explains why we
>     are seeing permission denied error from openat syscall.
>	  
> RFC 1813 states that 
>
>   "UNCHECKED means that the file should be created without checking
>   for the existence of a duplicate file in the same directory. In this
>   case, how.obj_attributes is a sattr3 describing the initial
>   attributes for the file."
>	 
> It seems like the vendor's implementation matches more closely to what
> the "standard" describes, but the behavior might not be what a normal
> user would expect. I guess there is no win-win situation here.

Compare RFC 7530's UNCHECKED4. It says explicitly that if the object
already exists, a non-exclusive create does not recreate it. The
existing object is used and the supplied attributes are applied. RFC
7530 and subsequent RFCs document what UNCHECKED was always meant to
do, and NFSD's NFSv3 behavior is consistent with that.

IMHO the correct interpretation, the one consistent with the rest of
NFSv3, with NFSv4's clarifying text, and with POSIX, is NFSD's, not
the vendor's. UNCHECKED governs error-vs-no-error on a duplicate,
not recreate-vs-reuse.

But to confirm this, look for an RFC 1813 erratum, or WG/implementor-list
guidance, stating that UNCHECKED must replace or re-create a pre-existing
file and return a fresh filehandle. It would also be sensible to check
how Solaris NFSv3 behaves, as it is a reference implementation for
RFC 1813.


-- 
Chuck Lever

