Return-Path: <linux-nfs+bounces-22784-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m7R+AiKGOmoF/AcAu9opvQ
	(envelope-from <linux-nfs+bounces-22784-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 15:12:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E616E6B7587
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 15:12:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=EBFlO8Ss;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22784-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22784-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54AFB30786F6
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 13:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836412DEA8F;
	Tue, 23 Jun 2026 13:11:50 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9862D9ED1
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jun 2026 13:11:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782220310; cv=none; b=K9i/Sg/nV2ZdnkSLRl6mIUvhj6wQdpATef6GcnmpJoxAvgpBpvj/7xjesTuPnbEYzpmXNYKMejXOGfhs1xPyOCbv5YH/LdWYtijsmfj9fb905A7c1JD7PjqL0hlCQl3+yM07s/SmGp6cjR5PJbSsgwkg9QJYiZ0rICUg46AjkR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782220310; c=relaxed/simple;
	bh=1vGJlRO5Ord2UGc0J+/G4MGpqOhphPvC5SZh2GrB09s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HIV4+O14OCfk2jFxqQ+wi44jeBaORl09qm1GCMGgcDX4Y5FPlDbFvF3qPsEhbCuYuKnZhjPL50D39slPAGjtUgEvCHG/SVjUHwSEoh52JfVrzRm2M6Ts5hMQQg5Z4c1/9yKpiWf4Wbeheg+BM3DXeEyXCfM7nvOLlUzr9BJ2TMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=EBFlO8Ss; arc=none smtp.client-ip=209.85.160.49
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-441b5b4af7aso2921221fac.3
        for <linux-nfs@vger.kernel.org>; Tue, 23 Jun 2026 06:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1782220307; x=1782825107; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bF0w1y7sC+afMhbrOSXkkMvCRCN37Sc4v0oxltPccEA=;
        b=EBFlO8Ss/QTZIJqgEj25VuxWqCxRn7ViTC1bp+U9/EW+b6Zuo1I+AEMaNwePgZh2V/
         9Dy1BG42brzMTczWo3ooa/PmojXMzVZmvrQDvgjvuChMDJ1VvHzIKWNtCxhxJg30yzgB
         KeM+3Z1NG9pTz5jRU26dt2ghW8DDGADSMkxbEjBUDPGdmHxftoMbKxUM9ZKH9ivrbvdP
         lc2fu2e4pt2BqBsee0F1fTx7IET6sWN/Jz7V1K425Qv7Fz1MZb1znx2BWqAXmxR1DHC8
         kdO8+C497S3GRScTvWqxPom9vKdBjCUlfg7vx+Snjgvad8Lxv7BWMir9J9WCb91frt97
         jP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782220307; x=1782825107;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bF0w1y7sC+afMhbrOSXkkMvCRCN37Sc4v0oxltPccEA=;
        b=myYKrqismmnQXXlPz3K7/3Hy1liJEKItkpmsmNAq8OgpbGWsxPvoTyUD3biw/ltqqn
         xI06YSDX6kvJihxGN8VYwEjwfY48b4YUpwf/o9nXoAIpUjT5CSa+9MKwPEuo6GgyeKUP
         B8kRuDWeqIjbN2BejElu/1dzSm4Yp6WrL0L4FApMDNe22uOiH6kRgTye6hXXsAbCjNpt
         SW2ZCYSKW5M1u2yMGziFX6W4iXOKeAAFxCm370FIhz/q6be9d82t/0FrlaEukJUO43/1
         lR2Z7A0dLupAQ6ksavjF+6Kk0/Su2RuboEn+Guh/IvlxiX5ojwuRzmOVF/uzoGeoi3y0
         sJyg==
X-Forwarded-Encrypted: i=1; AFNElJ/x2+OhBU174LbUN10/sI0feK/UjQ1/ph4t62WVvfTaLzLY8Nd3/ew0QQWupsqkmTXdd0hHM0T6Pt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcanekxMcQvWCb04akeuEL2tzz0t4bR3DQAMfva+oBuKnEd1uf
	1v8TFazxoJeayvVUakTuyzRoQbdszPRdvpxFEEqP/3uCPgN+1nxnq5yMOzOJ5wOwPIU=
X-Gm-Gg: AfdE7clSHXvboCuQ1X94EDvmAA9JFFcHnOFGczqVhNbdeNhzZ8j727azQ7hMSQ54PDh
	5rgpeDqr4eoqLs4eIJJnS8WHAwGoyi/dMcpN4XEXAkdkgzx2TdzJJ5n63j29Bfps+VvjqyYPVld
	qCUFmcjgZfRRLkw+1DxGoa3njrho0iS8OZUbiUqXk+16lp7lTbIIUY8TTxvax7EGJTCC12KHsf0
	b5k65Q/m7TbywbxCslhaAxKVlfkyTBLPbzNjR9rhis1QKr2jqLdgTDq60eZgU/jIEi1WT5IMAQD
	SbxOePZxI+tPI+54uE/PTSby0kahON7J7U8hgpGSZDA+pLQ+BBWeIHFSYpFbBa6E+FiHTJ3rEO7
	gxTMbykJDd2uCVeS8GnTXOOfevU/3rracl6ZBSyrkTRxwK+bXAEzbXhOJ0X8faDJ7q3RqTOWd2x
	MZA5hfnGBzCJSkN/FNCbIl08N2cbWVxMoRxN4d55zTtws=
X-Received: by 2002:a05:6871:2b25:b0:446:e309:b1b0 with SMTP id 586e51a60fabf-447b5ab1993mr1626553fac.2.1782220307534;
        Tue, 23 Jun 2026 06:11:47 -0700 (PDT)
Received: from [192.168.254.51] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472f0eb8adsm7979787fac.18.2026.06.23.06.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 06:11:45 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>,
 Benjamin Coddington <ben.coddington@hammerspace.com>,
 Piyush Sachdeva <s.piyush1024@gmail.com>,
 linux-nfs <linux-nfs@vger.kernel.org>, Chuck Lever <cel@kernel.org>,
 trondmy <trondmy@kernel.org>, sfrench@samba.org, sprasad@microsoft.com,
 vaibsharma@microsoft.com
Subject: Re: NFS delegations behavior analysis
Date: Tue, 23 Jun 2026 09:11:43 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <4323491E-64A0-4883-8343-5EB569A0D81A@hammerspace.com>
In-Reply-To: <227140ce94ebe4186d02b081489a58f32b878ec4.camel@kernel.org>
References: <m2qzlx7eye.fsf@gmail.com>
 <0b39c1e01a92f99fe456c76523ec7f3aa5dc1a81.camel@kernel.org>
 <455619640.1622514.1782212671358.JavaMail.zimbra@desy.de>
 <227140ce94ebe4186d02b081489a58f32b878ec4.camel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[desy.de,hammerspace.com,gmail.com,vger.kernel.org,kernel.org,samba.org,microsoft.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22784-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:tigran.mkrtchyan@desy.de,m:ben.coddington@hammerspace.com,m:s.piyush1024@gmail.com,m:linux-nfs@vger.kernel.org,m:cel@kernel.org,m:trondmy@kernel.org,m:sfrench@samba.org,m:sprasad@microsoft.com,m:vaibsharma@microsoft.com,m:spiyush1024@gmail.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: E616E6B7587

On 23 Jun 2026, at 7:10, Jeff Layton wrote:

> I think Ben did the latest pass of trying to tune the heuristics here.
> Any thoughts on how we could do this better (and whether there are
> particular ls-ish workloads that we don't want to regress)?

I haven't (shame) thought about READDIR in the context of directory
delegations.

But during my time at Red Hat we worked hard to optimize some readdir
problems and I learned that almost any change we made ended up making
someone's workload regress.  We also found that our performance benchmarks
rarely matched the most common real-world workloads.  We made the mistake of
trying to improve the benchmark which resulted in performance regressions
for real-world users.

Jeff, you've already touched on the core issue regarding fixing this with
bulk GETATTR calls - the kernel doesn't know what syscall pattern the
userspace process is going to use next.  The `ls -l` command and `find` and
friends have complex history and branching logic, they do different lookup
and getattr patterns based on their own goals, and NFS cannot optimize for
any one case.

I think the last time we discussed additional improvements there were some
ideas about teaching the readdir code to respond to fadvise flags, but then
you'd also need to teach the utilities how to use them as well, and those
utilities try to be filesystem-agnostic.

Its a tough problem, and sometimes the simplest thing might be to just use
more directories on NFS.

**coffee!**

.... er - so with directory delegations, can we simply re-hydrate the dentry
cache from the directory page mappings if the delegation is still valid?
Does the directory delegation pin the mapping?  Clearly I need to look at
the code..

Ben

