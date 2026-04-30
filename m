Return-Path: <linux-nfs+bounces-21315-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBYONp+a82kQ5QEAu9opvQ
	(envelope-from <linux-nfs+bounces-21315-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 20:08:31 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD55E4A6B3B
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 20:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B74B93003497
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 18:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B458137F744;
	Thu, 30 Apr 2026 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b="J9owha3p";
	dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b="TmLnwFlT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [134.58.240.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B932C236B
	for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.58.240.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777572504; cv=none; b=gprlu6GKaYeqGLCVi4ouGUVwNSbc2TM53AOq4myZtwK9NNCaaRo3X1UjOYi588BJgSNFNdxh00tLbaeO6CnR1QgYWEeoB/9dCLhvTmguTPP1GzYKUHJNu985r/pNjTXpshwy8vd0w5jFzFBByEw7UcxdP4YPJj6yeA+A0t7o7u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777572504; c=relaxed/simple;
	bh=18ee+QMpTnj58KtH+MGHNSpuKmoTPIiH5gVG3zC4Jkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTZ2NpeWlumsUhVP1vMZFCcQzdiOymzWQbltM5hV3wvdqZvxwlMihD7SAVHHJ9xt9z6bE00sBPLsf0Dj4zL9WF3FT+6tzUI5Z5bLVcml1HAJ1HiwOrMT3PwNBwbTECUM+ZJR/IWuAXEVBH1y8udaxx0ATrNQRVio3S4/L6FtZ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be; spf=pass smtp.mailfrom=esat.kuleuven.be; dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b=J9owha3p; dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b=TmLnwFlT; arc=none smtp.client-ip=134.58.240.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esat.kuleuven.be
X-KULeuven-Envelope-From: rik.theys@esat.kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 402D720092.A61FD
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:140::23])
	by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id 402D720092;
	Thu, 30 Apr 2026 20:08:18 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
	s=kuleuven-cav-1; t=1777572498;
	bh=r3LstTL2I3ca0sVa6oZFmEPtc1C5girXUXo3EerC2b8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=J9owha3pXELkMR6qjwt4aqphdOd4n8dJrm6Fe69sAFytm4tvmZ707LydFzwakthAC
	 DLr37W02YXbaPuFyPA+epqCVKEih3ep35G1kwATdSsG59k+mXiY2dd3sAqUQIM4j6h
	 hcXzwE1zpV7CngM/2ouVqM3BGvHTGbg8Pw11LtS7Y/43Huy6xYXuwch/qvgZuP+VwS
	 FqyXMKICkV+1/+eiw9VgRTQ/qP/NG5c/ol/9pYWraF7mXOzhUjYqQCcJvGV0tne6nr
	 L+si6eyBgmZT8wizCcTv+GIJr0UIyn/pK/jxlnPPgnQ66R6Tol3jYlw+J92yhzkb0B
	 D7pOGKstCwgjw==
Received: from hydrogen.esat.kuleuven.be (hydrogen.esat.kuleuven.be [134.58.56.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPS id 15F07D4CC96DC;
	Thu, 30 Apr 2026 20:08:18 +0200 (CEST)
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=esat.kuleuven.be;
	s=esat20220324; t=1777572498;
	bh=r3LstTL2I3ca0sVa6oZFmEPtc1C5girXUXo3EerC2b8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TmLnwFlTwvGlT81n/1rvKWWCBdLs3gP5Ga8zRUhi42bzxJBpveIGnJcCEbIEqW9n1
	 9XHeYnUZxKyNpRExxFtMuGeRf6oV88cRT7nwrFYwSzF/NQEzekVEfPo6g3X87pl8ac
	 F3hU6PAcNtJOLEYngTRwYHW1ClZGb5Z21mCD/ob6DZpHlwYCvdmN4w/GAKjpNx+k7R
	 stDMnf4ioJFpuBvSDo7HrlhT8G4Y+08u9x+A7J8lDfBRM8j/Q/j6CKoxxUDgW5gI6m
	 Wyfp8LTx1e45/+EzHLwh9dVD4vwCSXtrdlQY0ooAnGvgspGiN5TJDmTVyMvSdep4yb
	 0WyMNhAbf+PqA==
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
Received: from [192.168.1.113] (d54C377C4.access.telenet.be [84.195.119.196])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by hydrogen.esat.kuleuven.be (Postfix) with ESMTPSA id F20E22000B;
	Thu, 30 Apr 2026 20:08:17 +0200 (CEST)
Message-ID: <baa0afef-f004-4ee4-945c-8992c05e7d2a@esat.kuleuven.be>
Date: Thu, 30 Apr 2026 20:08:17 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NFS4ERR_SEQ_MISORDERED errors and NFS client very slow
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Linux Nfs <linux-nfs@vger.kernel.org>
References: <2cb85a89-f896-4504-b1cf-e4494d344ffe@esat.kuleuven.be>
 <CAN-5tyGhC8q=iB_H6JaFZpwpWAqEz5NObVrzZ8m=3OzgLgJnpw@mail.gmail.com>
Content-Language: en-US
From: Rik Theys <Rik.Theys@esat.kuleuven.be>
In-Reply-To: <CAN-5tyGhC8q=iB_H6JaFZpwpWAqEz5NObVrzZ8m=3OzgLgJnpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CD55E4A6B3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[esat.kuleuven.be,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kuleuven.be:s=kuleuven-cav-1,esat.kuleuven.be:s=esat20220324];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21315-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[kuleuven.be:+,esat.kuleuven.be:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Rik.Theys@esat.kuleuven.be,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kuleuven.be:dkim,kuleuven.be:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,esat.kuleuven.be:dkim,esat.kuleuven.be:mid]

Hi,

On 4/30/26 7:29 PM, Olga Kornievskaia wrote:
> On Thu, Apr 30, 2026 at 2:54 AM Rik Theys <Rik.Theys@esat.kuleuven.be> wrote:
>> Hi,
>>
>> We have a Rocky 8 client running Linux 7.0.2 (kernel-ml from elrepo)
>> that is an NFS client to a RHEL10 server.
>>
>> Lately we've noticed that NFS performance is very poor for certain
>> workloads (We saw the same issue on the stock EL8 kernel, 6.18.20 and
>> now 7.0.2). For example cloning git repositories is extremely slow.
>>
>> Looking at the server side there don't seem to be any saturations of the
>> disk or network subsystems.
>>
>> I've taken a network dump between the client and server. In that dump I
>> see that the server frequently responds to requests from the client with
>> NFS4ERR_SEQ_MISORDERED (10063). What could be the cause of these
>> mismatches? Is this always a client issue, or can this be caused by the
>> server?
> This might have been fixed by mentioned patch below. This patch will
> be included in RHEL10.2 release.
>
> If you have the ability to change the kernel on your NFS server I
> would suggest trying some upstream version that has this patch
> included to see if the problem goes away or wait until when RHEL10.2
> comes out and test it.

Thanks for the hint! Note that the client can still access (some) files 
on the server, but it can get really slow.

If I read 
https://lore.kernel.org/linux-nfs/20251010194449.10281-1-okorniev@redhat.com/ 
correctly, I would expect the server to send this response for all requests?

Regards,

Rik

>
> commit 1cff14b7fc7f31363c39d0269563ce75c714f7ae
> Author: NeilBrown <neil@brown.name>
> Date:   Thu Oct 16 09:49:57 2025 -0400
>
>      nfsd: ensure SEQUENCE replay sends a valid reply.
>
>      nfsd4_enc_sequence_replay() uses nfsd4_encode_operation() to encode a
>      new SEQUENCE reply when replaying a request from the slot cache - only
>      ops after the SEQUENCE are replayed from the cache in ->sl_data.
>
>      However it does this in nfsd4_replay_cache_entry() which is called
>      *before* nfsd4_sequence() has filled in reply fields.
>
>      This means that in the replayed SEQUENCE reply:
>       maxslots will be whatever the client sent
>       target_maxslots will be -1 (assuming init to zero, and
>            nfsd4_encode_sequence() subtracts 1)
>       status_flags will be zero
>
>      The incorrect maxslots value, in particular, can cause the client to
>      think the slot table has been reduced in size so it can discard its
>      knowledge of current sequence number of the later slots, though the
>      server has not discarded those slots.  When the client later wants to
>      use a later slot, it can get NFS4ERR_SEQ_MISORDERED from the server.
>
>      This patch moves the setup of the reply into a new helper function and
>      call it *before* nfsd4_replay_cache_entry() is called.  Only one of the
>      updated fields was used after this point - maxslots.  So the
>      nfsd4_sequence struct has been extended to have separate maxslots for
>      the request and the response.
>
>      Reported-by: Olga Kornievskaia <okorniev@redhat.com>
>      Closes: https://lore.kernel.org/linux-nfs/20251010194449.10281-1-okorniev@redhat.com/
>      Tested-by: Olga Kornievskaia <okorniev@redhat.com>
>      Signed-off-by: NeilBrown <neil@brown.name>
>      Reviewed-by: Jeff Layton <jlayton@kernel.org>
>      Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>
>> Should the client not recover?
>>
>> Regards,
>>
>> Rik
>>
>> --
>> Rik Theys
>> System Engineer
>> KU Leuven - Dept. Elektrotechniek (ESAT)
>> Kasteelpark Arenberg 10 bus 2440  - B-3001 Leuven-Heverlee
>> +32(0)16/32.11.07
>> ----------------------------------------------------------------
>> <<Any errors in spelling, tact or fact are transmission errors>>
>>
>>
-- 
Rik Theys
System Engineer
KU Leuven - Dept. Elektrotechniek (ESAT)
Kasteelpark Arenberg 10 bus 2440  - B-3001 Leuven-Heverlee
+32(0)16/32.11.07
----------------------------------------------------------------
<<Any errors in spelling, tact or fact are transmission errors>>


