Return-Path: <linux-nfs+bounces-19447-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGs5EuRMo2nW/AQAu9opvQ
	(envelope-from <linux-nfs+bounces-19447-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 21:15:32 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C45D21C8183
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 21:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CAC1930A0DB4
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 20:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C2215E8B;
	Sat, 28 Feb 2026 20:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D4WA+Tza"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413282139C9
	for <linux-nfs@vger.kernel.org>; Sat, 28 Feb 2026 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772308938; cv=none; b=u2Sb81FMJJoacvs9jioBq36ciNxR2vrNTYR2St7hVgSvcdxhI2kSr1yjRvAhg4Da5zQdmrNKUk0WsjPIQoNnywmV7WbVcFBarzJPkYTzw1xwk18sXb6L4MdLZBD/sbiMdEcmt09RhipzVU7uBC4GrCwBw5cQ4QotTlZs+ej9zok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772308938; c=relaxed/simple;
	bh=XvjNHPApBvoxKp7X7UEuNkr3XhH3TVUo+miTo22XOF8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QM1EADU5ffr8SLcuPG2Miah0yZUOxU8w4DcsVUTVcpURU9xd6ir0eahe/wiHuxD9N1c1H+hY4ESBLxTw2PFCS7lw5hfFht5u1ZjXC+54GipVXKbZgYafOgHfMabDnrAAasHXT5/k4bXE76qaoOT+rxSsfunA/NbYen/v+0Cjimg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D4WA+Tza; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae49080364so128585ad.0
        for <linux-nfs@vger.kernel.org>; Sat, 28 Feb 2026 12:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772308936; x=1772913736; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vXs10pSXUN0V44OtAaL0Cx7xxnnSoeqCxL4vnLRCp+0=;
        b=D4WA+Tza1H5DX00uOvqC8A3JmnGVhtUalXoamS//dGDoxPsU97AgZWxHunhjJVxrkX
         n4VD7W9bB2AMV4PUmNdhGH6pqPP2/ihUVfOAtW7sr7f81GB3zWP5Dn02VNr5rnephX5n
         LalDja/FamHurwN8fI+1s1WPtyVn/gm9qbPiExrnFm3nxWmgA8gCMObbSOB5GooCKgit
         kufJYMB0vsYWNgAt1M3ZsBeXkWuOM00qNUY+Cu3Aqhq2MaMa/MVDVAAzuntLkLXGo71i
         TWp4uNLoM/7BeFOU+IRIczMul3NmiiGpxTrXSVgEa1Sy9x4i4Nt1RM1lX74uY4EuIGGA
         U/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772308936; x=1772913736;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vXs10pSXUN0V44OtAaL0Cx7xxnnSoeqCxL4vnLRCp+0=;
        b=qui6dHeuEmD9VwSImvvyJwVJ/YbwTloPIl4WGihCF2ZS2Q5yjuhL55Igen8CxBxZ2O
         +DlyJilUTppQ6tEjPBufJzMM+ILP3dz9x0jwWaCV2UE8GK6DYwHaD3s+8hPramNIePs1
         8kMI0hBYRWdvncuvv6zRPzcDzn7jHNX/dbf15jKuGJY/pU74VNrfYjTiA1waXjD2R6r2
         TzXnyM2bV/ELuV632sIWrdr5XHPmSPe/E8HQzMBYJRYXqY7stGndThZuebfcbj0rKjey
         A4B4fH/NEo6788Uqv/7m+wwcq4gff1vtmBkEjFDK3OjfrIhzfBSLmROT7/IdPYIRVvRY
         Coww==
X-Forwarded-Encrypted: i=1; AJvYcCX9+q8jsm8ofyAX60EbSfB41puf8dJaMuzJ1fcjsJbr5rN5jnDB17GExvonAffSffsKBCK5Wyi0Svg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUiV7dSyIjGpqtg8MTnFNMc2IcmiJyb8B83CqIhAFeWJyeeZBC
	uYDMtvb3JxkwmoJ0tBLPwXFWiRDSQp97NwOmlhNafqSXV3W0higwfM3qX4Eqk/jN+CL9DKcyX9V
	MMFaQVg==
X-Received: from plot6.prod.google.com ([2002:a17:902:8c86:b0:2aa:d604:fb13])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c4b:b0:2aa:d506:d189
 with SMTP id d9443c01a7336-2ae2e496d75mr64410135ad.34.1772308936236; Sat, 28
 Feb 2026 12:02:16 -0800 (PST)
Date: Sat, 28 Feb 2026 20:01:26 +0000
In-Reply-To: <176931125800.30355.7451399373487878151.b4-ty@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <176931125800.30355.7451399373487878151.b4-ty@oracle.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228200214.964918-1-kuniyu@google.com>
Subject: Re: [PATCH v1 0/2] nfsd: Fix cred refcount leak.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: cel@kernel.org
Cc: Dai.Ngo@oracle.com, chuck.lever@oracle.com, jlayton@kernel.org, 
	kuniyu@google.com, linux-nfs@vger.kernel.org, lorenzo@kernel.org, 
	neil@brown.name, okorniev@redhat.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19447-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C45D21C8183
X-Rspamd-Action: no action

Hi Chuck,

From: Chuck Lever <cel@kernel.org>
Date: Sat, 24 Jan 2026 22:21:05 -0500
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> On Sat, 24 Jan 2026 04:18:39 +0000, Kuniyuki Iwashima wrote:
> > get_current_cred() is misused in nfsd_nl_listener_set_doit()
> > and nfsd_nl_threads_set_doit(), leaking the cred refcount.
> > 
> > Patch 1 & 2 fixes the leak in each function.
> > 
> > 
> > Kuniyuki Iwashima (2):
> >   nfsd: Fix cred ref leak in nfsd_nl_threads_set_doit().
> >   nfsd: Fix cred ref leak in nfsd_nl_listener_set_doit().
> > 
> > [...]
> 
> Applied to nfsd-testing, thanks!
> 
> [1/2] nfsd: Fix cred ref leak in nfsd_nl_threads_set_doit().
>       commit: c14b0c3b5966a1e2cf6a7f219c4f4b3fafeb89d0
> [2/2] nfsd: Fix cred ref leak in nfsd_nl_listener_set_doit().
>       commit: 687b9b69fcda9de606e998fd2edccb8a14406e19

While rebasing my local branch, I just noticed both patches
are not in the mainline and I couldn't find both SHA1 in your
tree.

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=c14b0c3b5966a1e2cf6a7f219c4f4b3fafeb89d0

Could you double check ?

Thanks !

