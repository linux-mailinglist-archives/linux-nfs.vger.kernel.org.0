Return-Path: <linux-nfs+bounces-22787-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hac8HxiLOmrj/QcAu9opvQ
	(envelope-from <linux-nfs+bounces-22787-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 15:33:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA2D6B777F
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 15:33:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=b8l+KzVX;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22787-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22787-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 579A730A1221
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 13:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BD024A067;
	Tue, 23 Jun 2026 13:32:28 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B48379EEA
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jun 2026 13:32:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782221548; cv=none; b=KNkIYNQHqsMO3TBQcSGD7bvXwTNzMBj5ckb+OzlAyT2oNcEfwKeQrKY+jMlVJPvACP/iTAzTU10d89JGxZGdm0whPpGMrd6oTYYsx6ij77HafhzFVB2prpavzbUaYfQv+2cyw++/Wsd4ONVF3/5Cr5p+p08qeO7UFr6SrgdZIm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782221548; c=relaxed/simple;
	bh=3Z5wSv34W6T89w9Br25TpGmqScmWH20PNWvaHacDU2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j6y7chmCE56O3h9bTK3YzhtzxdkDgFA+jF0aPbTPunmoo74q6e3Lh6VHK55w6ZzI64JIdQ7cRFFx+/wLfWBxXDoAouah1WA9y9Kf1TB6HNuIRyL1jLMaANZlPiPBl9mOekg98Wto7DdUEdGHV80P7OfSr3r/TIYxs93neOCRSoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=b8l+KzVX; arc=none smtp.client-ip=209.85.210.42
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e6cdd78fe6so2958174a34.2
        for <linux-nfs@vger.kernel.org>; Tue, 23 Jun 2026 06:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1782221546; x=1782826346; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NMi3to/Xc4x9JbndD3K9cP/EvYVF5MSPHv/y7AIcrsY=;
        b=b8l+KzVXYOCPIphulf27QHLp+ETkaVLpuTO3zhY5R/0dP2SFz2mtq5P76d9O1uYKYi
         +lDVeNqrX5Seagyw9wnSWfksn2JTvMo5i0Tx+9kTBIik9K7Va/jeeAcV8adOe9OMMmKx
         naHV77HrK9xLoniQ3wUEGFxnFZ/wJoBIelTAgOMuIabo8VfeXfZga8zvSBS1+wZbpyCF
         mQOhZq9hpoIYR3ydCCPeGVuvl7bac/dexGgjqqMMCIyn0qmi68Tex/HvPimVKfNngvbB
         IYyeNOiNckPdJHJL2AAyzM4ftLbqlX4XZWrp2PsKExPl2Z160ThJURodWGZcgTniroZT
         Z/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782221546; x=1782826346;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMi3to/Xc4x9JbndD3K9cP/EvYVF5MSPHv/y7AIcrsY=;
        b=mwK1qp01wH/lIDL0ntMtn7GPX2hRHBg+udxH8n0oWlvjfkZKXyEYPt03bu14xOCmSN
         qH7tHpy6pnHS/kABYsTSw/i1CT8GFsC1NCPIBqiOU/l5SLISN1gIVK99sNbkrTxny4Ra
         W6uzHqvOBCMEKhZk5CdBKBNSroHaUtvpRWDlkX999R0zTNq8gNpxf6KPBnet0L0WPm24
         YLY1+YPVPzM3rXZBcPRp9yZOMfZ1D6n7TnXWqD0CG38A/t8Vw1JpXnXAw0cwfKfBG5AS
         b/qwyO6Z6yULEhIlxxQsWRhEooZg4PVODPcEqsvV79y/2RlZdFfH/n79CTfTShpQULWG
         wV7g==
X-Forwarded-Encrypted: i=1; AFNElJ988B1+cBkTWjtAKsyvO9LjTkbAAnMI6KW2BaDBEpR5Q09yUzPBmz6xItaXMSosqc8wvV891/eU910=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT1ppCUVzGzYFOgo6owDF2+SeemMNKmOvZCod/gF9OQ0ghce2V
	ekMaSsbvPbjiU7k0bZdcNfjhYn7rFWCi0MatYUetOqFZGbmY/hDmFhJdIOnExO9bJT7gjsKGzC6
	qjPu6
X-Gm-Gg: AfdE7ckMUfwqtdXlD5kJomPjY1CHbgqQebQPpmg8vYPWvG/BzNoyBcaOrpvMTpg6CVC
	aFdYbtitBfdiOUZeACl0xSihc6AR6n8ovpdtMjwLbkiC0F+V3L5vGs87K1pRQtqYD6JIUeLA7+G
	vH2vyDeEePBYOP17azdPWxLJjPAvPC+Fh1hn7Nbv3QOdmFT1VQOtDXYV1eyfaawNkeKHk0XLCGp
	QK01dfAUDQQNdr4kPEL5XyDXssFghqpzInB+6F+FJDAIYK+ZQa084QOyrXFKHXXP/Q8vSzOMcNt
	wualHi2pE5pDMYjfOiQqhjBvuQ66FUzeTBXg5RyWSTtmzz5hib4D4Cu14Jrz9O/6AbSyjPqKX0s
	y8oVdF6uPvJG681i6I2ty6rce4XCZpnXq8J9hiPJ/1dyHImVNComV0CRvU/R4Doo2xJtrU2pfqw
	2X9e3mYKgQW0xZPeQpdeudTPw6ZF6gdw10
X-Received: by 2002:a05:6830:4c04:b0:7e6:f709:a2bb with SMTP id 46e09a7af769-7e979927fa8mr1930353a34.20.1782221546191;
        Tue, 23 Jun 2026 06:32:26 -0700 (PDT)
Received: from [192.168.254.51] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e944007d02sm9517137a34.1.2026.06.23.06.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 06:32:25 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Benjamin Coddington <ben.coddington@hammerspace.com>
Cc: Jeff Layton <jlayton@kernel.org>,
 "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>,
 Piyush Sachdeva <s.piyush1024@gmail.com>,
 linux-nfs <linux-nfs@vger.kernel.org>, Chuck Lever <cel@kernel.org>,
 trondmy <trondmy@kernel.org>, sfrench@samba.org, sprasad@microsoft.com,
 vaibsharma@microsoft.com
Subject: Re: NFS delegations behavior analysis
Date: Tue, 23 Jun 2026 09:32:23 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <E86DDFB0-6E5E-40CC-8DFA-7233793D25E1@hammerspace.com>
In-Reply-To: <4323491E-64A0-4883-8343-5EB569A0D81A@hammerspace.com>
References: <m2qzlx7eye.fsf@gmail.com>
 <0b39c1e01a92f99fe456c76523ec7f3aa5dc1a81.camel@kernel.org>
 <455619640.1622514.1782212671358.JavaMail.zimbra@desy.de>
 <227140ce94ebe4186d02b081489a58f32b878ec4.camel@kernel.org>
 <4323491E-64A0-4883-8343-5EB569A0D81A@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,desy.de,gmail.com,vger.kernel.org,samba.org,microsoft.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22787-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ben.coddington@hammerspace.com,m:jlayton@kernel.org,m:tigran.mkrtchyan@desy.de,m:s.piyush1024@gmail.com,m:linux-nfs@vger.kernel.org,m:cel@kernel.org,m:trondmy@kernel.org,m:sfrench@samba.org,m:sprasad@microsoft.com,m:vaibsharma@microsoft.com,m:spiyush1024@gmail.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,hammerspace.com:dkim,hammerspace.com:mid,hammerspace.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7DA2D6B777F

On 23 Jun 2026, at 9:11, Benjamin Coddington wrote:

> .... er - so with directory delegations, can we simply re-hydrate the dentry
> cache from the directory page mappings if the delegation is still valid?
> Does the directory delegation pin the mapping?  Clearly I need to look at
> the code..

.. right - we don't keep the file attributes in the mappings today.  And,
more to the point - the directory delegation doesn't protect those file
attributes either.  We'd need NOTIFY4_CHANGE_CHILD_ATTRIBUTES implemented.

Ben

