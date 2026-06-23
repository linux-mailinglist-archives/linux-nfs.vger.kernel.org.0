Return-Path: <linux-nfs+bounces-22786-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AtiJON2KOmrB/QcAu9opvQ
	(envelope-from <linux-nfs+bounces-22786-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 15:32:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 368716B7768
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 15:32:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=dneg-com.20251104.gappssmtp.com header.s=20251104 header.b=XkkL8nyP;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22786-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22786-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C7B0301E59D
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 13:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21632D46B3;
	Tue, 23 Jun 2026 13:31:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64A5378D6B
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jun 2026 13:31:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782221502; cv=pass; b=CnVQlWQ1jqBXeXmrG3Uqe23Q+ESzb5H9aTuYgQGIO4/8e2TosfruEOdA8AvYyMWrxx9Wjx7aTyDg1xbTXGRHB44CdF5xrSS3i74iDv1fhdtcU4cbILwxjsQ210mLN2uoc+6u+mfZ3BOlsyrkUIXlxdyymu0V43wIOUQFVD7milE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782221502; c=relaxed/simple;
	bh=P4IRKO5QV4Oaq5HPm/kLCLRVEINjZQLw056CVSCEl4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6zLqnUjXQuvtU8KL8+HljkV0fxi0galGxnB1w4p+EdZSNM/FxeGyU0E1JklqHHAFaCwb/pUdKYxbrhmPSZ2HLbUhi/gnUSvDViZCJLXIoNEO/Yu7nR3nqMSQsizEmzf5vzNnmOXNRVLcaUoAY1ZDUJSqXf0NOHK4LuNu+GfEH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brahma.io; spf=pass smtp.mailfrom=dneg.com; dkim=pass (2048-bit key) header.d=dneg-com.20251104.gappssmtp.com header.i=@dneg-com.20251104.gappssmtp.com header.b=XkkL8nyP; arc=pass smtp.client-ip=209.85.208.44
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6977dc206afso6441898a12.1
        for <linux-nfs@vger.kernel.org>; Tue, 23 Jun 2026 06:31:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782221499; cv=none;
        d=google.com; s=arc-20240605;
        b=N7/s1gxXEw4DMT/8kf7cYUVzREafMXFe2KrIjGKX6lStNK39S4pgn5T0kKRakjw604
         pN1a1Ki12iV1uZE9fVdNMQP6MiJFPmVtKc2cq9X7BfsOSL6kSS7oSil7TTnjWaRR3dzd
         x7fC3KR7YPDsw7qPXY2rdKyfbdLBCZ86VRnuNn4EXaSyEroYtifswX2hmD+ImaS/65tE
         E2SJjbs68R0TZ/mrCGCgQoTPeeuue5WZe9qP7anS+XP7QtUzsxFjdBQ/XAxzwhT2QIt9
         7CtdYPCRqoG/Dh4ZRPRs0+cADeZkCJp7ngERc6V4w3C4VdZj8SMq//5uolOlLDxXC1C2
         Pawg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rWsR9IWQsmiss6kPXlK/KQY8KGGTNufH443BWrS8OmY=;
        fh=q1eIJyLygjwIEXLSfH+E0GO4cTHV00h4Z6tjQfqjpAs=;
        b=gRxGsVISo7QqFUhhesMPW8Vdc+eJP9seco6NnI6aRT9KU9y2QMld1TRCE2eB1Dw5D/
         gKnvWud4gUpF6CCT2wTJfs7KhF4gri0rV2k4qlFiag4KwUBvuNFGvPNBsExF1PE9MlOb
         5A0AqcRTyjib6xBUHinDq/Wmqdi8prkFpUTeIc+0wot7V5PriGi+Dk5ePeNzwsU5+Uyo
         +D0xpw4PBLiBA9bYPekXvZe7STaXstHYDjuyCxYqriSTGNWOr6//Uyd+nj1mm2tGXoZK
         I8iPOlt/lQQKpsy6iz31wmDN+TxYewB+loSDqiCK5fJIJP0hqePoUrlNEd6dKGTHuqBe
         yM8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg-com.20251104.gappssmtp.com; s=20251104; t=1782221499; x=1782826299; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rWsR9IWQsmiss6kPXlK/KQY8KGGTNufH443BWrS8OmY=;
        b=XkkL8nyPPpJDyr8B4NKd+5aaXkmYlQ5NhmpVHrRzIUxOAuIHc4aGpgCRrzy1jOkfbn
         rX8HSYPXaYppbNfMW67RXHy7pYwTK4CQFPosk0NexygaCaVO+cD7gnfN5fBXg0EUNvRR
         X9+G3yxkqfweP7pmRmQF4gPC7JRtVnSkNKlAZd5uIhJNMzkcrDCab4qkSqf/DP4Bi0s5
         GDldT5NTtmvIK247WfAC0dlBILaGvxu0ouqXCp8T/+CdGpufV61v+nueZ+OIuQllsujl
         a1MVx4M0E2qCsYpY4EZWYsLMi0g9p32l7lls/h2ul3C1W9yWGzSFfvCUfA1LpnFi5Sa1
         ZeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782221499; x=1782826299;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWsR9IWQsmiss6kPXlK/KQY8KGGTNufH443BWrS8OmY=;
        b=NzCw6PdZ1C3d926KL8WLaRvubjO36UnyLsYrLiwNx7MqwlmJDqsHha/vMQhhzTqZFV
         icFieVbkSkYIlvjasttL1JBMvakdnsWDRi+Fx1rtog6vOnyNi3F90unOXFf57k0taCUi
         LTANDcztOUWOQx6YViXVOQb5ABDd2KG/JWuyoQwXExS/OOg9/4sTtOvdYbcHZl4vewKY
         cHgJ2YgW/DAcT3JAphilAu9V8CFH80r9GczS2aKEBL0bhF+0+xuA4+/Rd4JvginiqkTX
         Pgt+ate7Poaaz2lcxN9FQgEibZqqggvN3zko6wlZ9+wx5R60lqGtilZjsSmYu+/B91+C
         M1ig==
X-Forwarded-Encrypted: i=1; AFNElJ8levMDEPmybVzjMa++pW08gJ1CJrLI2Z2Epcqi062ApQYynyxqiwKRzpj7Fy9QQjFRlsu6f3Ny6xM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3O0sFoJz03vX8EZ4e1pw3wzmHz+k6IOZc4Ep2NABflllC07sM
	5VWLIoC9/BAZk3FGrHvCwGtxeNb7Qr4qy8yz7FAyTWxCYLPKVI4AuYlBj6dnNdWjl6l51GK8YPF
	ynylAVlPl6UUY20zqrl9kNQwctO9yBuHr2K6TZrGF4Q==
X-Gm-Gg: AfdE7cmpjDJIjk3gScMhBbMq6Y9etVIfCLkWX5KWAFYkjKDKsKF235aGHlqLwnAQeP8
	Fczs+JYqT216R5TJ+w0vOeeI0atNR/CO0ixjLPeuxoyS77Pq9QeXI+7OfRzmElRZY7jNQz9nLTx
	axRbPOmcPnAR2Y5g887yVKUjH+9p3osM2x4W9BtsMcu41B7zHQkqRNuOn1ioAu7EZrEbgSnf+n2
	3WTx+2sHDz3LnRy55JEAFXY284KK0JaeM6J/69GyYBpKswHNBTk8CbDCJecH9xI0FQGS7Y=
X-Received: by 2002:a17:907:a605:b0:c10:1ca4:d99d with SMTP id
 a640c23a62f3a-c108f9fe3e8mr156312966b.45.1782221498985; Tue, 23 Jun 2026
 06:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <m2qzlx7eye.fsf@gmail.com> <0b39c1e01a92f99fe456c76523ec7f3aa5dc1a81.camel@kernel.org>
 <455619640.1622514.1782212671358.JavaMail.zimbra@desy.de> <227140ce94ebe4186d02b081489a58f32b878ec4.camel@kernel.org>
 <4323491E-64A0-4883-8343-5EB569A0D81A@hammerspace.com>
In-Reply-To: <4323491E-64A0-4883-8343-5EB569A0D81A@hammerspace.com>
From: Daire Byrne <daire@brahma.io>
Date: Tue, 23 Jun 2026 14:31:02 +0100
X-Gm-Features: AVVi8Cd-jksuzkH6efNsuaWQwA1GknuYrTac-HlEMugeTutQL3MKasQC8jpOapY
Message-ID: <CAPt2mGPFoW5h7J2V8sCGnU7cQ9Xjx4ddc_sq8pPi4rPZy+J6bQ@mail.gmail.com>
Subject: Re: NFS delegations behavior analysis
To: Benjamin Coddington <ben.coddington@hammerspace.com>
Cc: Jeff Layton <jlayton@kernel.org>, "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>, 
	Piyush Sachdeva <s.piyush1024@gmail.com>, linux-nfs <linux-nfs@vger.kernel.org>, 
	Chuck Lever <cel@kernel.org>, trondmy <trondmy@kernel.org>, sfrench@samba.org, 
	sprasad@microsoft.com, vaibsharma@microsoft.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[dneg-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22786-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[brahma.io];
	FORGED_SENDER(0.00)[daire@brahma.io,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ben.coddington@hammerspace.com,m:jlayton@kernel.org,m:tigran.mkrtchyan@desy.de,m:s.piyush1024@gmail.com,m:linux-nfs@vger.kernel.org,m:cel@kernel.org,m:trondmy@kernel.org,m:sfrench@samba.org,m:sprasad@microsoft.com,m:vaibsharma@microsoft.com,m:spiyush1024@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,desy.de,gmail.com,vger.kernel.org,samba.org,microsoft.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daire@brahma.io,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[dneg-com.20251104.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp,dneg-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 368716B7768

On Tue, 23 Jun 2026 at 14:12, Benjamin Coddington
<ben.coddington@hammerspace.com> wrote:
>
> On 23 Jun 2026, at 7:10, Jeff Layton wrote:
>
> > I think Ben did the latest pass of trying to tune the heuristics here.
> > Any thoughts on how we could do this better (and whether there are
> > particular ls-ish workloads that we don't want to regress)?
>
> I haven't (shame) thought about READDIR in the context of directory
> delegations.
>
> But during my time at Red Hat we worked hard to optimize some readdir
> problems and I learned that almost any change we made ended up making
> someone's workload regress.  We also found that our performance benchmarks
> rarely matched the most common real-world workloads.  We made the mistake of
> trying to improve the benchmark which resulted in performance regressions
> for real-world users.
>
> Jeff, you've already touched on the core issue regarding fixing this with
> bulk GETATTR calls - the kernel doesn't know what syscall pattern the
> userspace process is going to use next.  The `ls -l` command and `find` and
> friends have complex history and branching logic, they do different lookup
> and getattr patterns based on their own goals, and NFS cannot optimize for
> any one case.
>
> I think the last time we discussed additional improvements there were some
> ideas about teaching the readdir code to respond to fadvise flags, but then
> you'd also need to teach the utilities how to use them as well, and those
> utilities try to be filesystem-agnostic.
>
> Its a tough problem, and sometimes the simplest thing might be to just use
> more directories on NFS.
>
> **coffee!**
>
> .... er - so with directory delegations, can we simply re-hydrate the dentry
> cache from the directory page mappings if the delegation is still valid?
> Does the directory delegation pin the mapping?  Clearly I need to look at
> the code..
>
> Ben
>

I have also long hoped for a way to cache or speed up "negative"
lookups using something akin to directory delegations.

So if you have your software (e.g. PYTHONPATH) on an NFS share, then
negative lookups are a huge scalability problem. It would be nice if a
client that got the directory contents could also serve negative
lookups until the server told it that something had changed.

But as has been explained to me multiple times before, there is no
mechanism to say that a client "has the complete cache of directory
contents". But I will forever live in hope!

This kind of path search walking is also something that is unlikely to
ever trigger readdirplus as it does a file and then tries the same
file in another directory etc etc.

Daire

