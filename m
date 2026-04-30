Return-Path: <linux-nfs+bounces-21297-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGX+BERZ82lfzwEAu9opvQ
	(envelope-from <linux-nfs+bounces-21297-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 15:29:40 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C95A34A373A
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 15:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE4F9301B918
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 13:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF7B426684;
	Thu, 30 Apr 2026 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="aEa5u0Aj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D440D423A8C
	for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 13:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777555680; cv=none; b=fhK3cJUomombQ5EJSXgzlmid2CRo/rTge4SjzgPfKHwfzTTPhP2jej+5kStCamOF3GfIqUSQwpBP8G2wmerS8bioGs6xBOoCSUsSxDPYVfB+ObyVYSbkl4f40UT7kOWkI7X6vS8XpRPXayzjDzlmcA37lW4/kcTytm6FLDPu9Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777555680; c=relaxed/simple;
	bh=ml+LeI3821LF4ypyRlAo2jtuuh29aSwBucmbeqR27gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nf3RcRcQaKTE69m+NcCkXJ2ASHBGIJjJEDNRb3sdmnjrxmMVEY9+fiDn49hW98xrEHJ98f/TVWXeMPo91KafUTn6YTcXSWrkoriynGqFnWahz+uzYWOuGUf5yL6d21FfTp6UHsANYRQX/EZZVHbVald/uTv7Yl5hBpp+NZ6k/ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=aEa5u0Aj; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammerspace.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so835788a34.2
        for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 06:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1777555677; x=1778160477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyOMENDhhKn1drXUY5FEfpalnnqfQd9/9Hk+P1Dg6SI=;
        b=aEa5u0AjxdVJh0i+9nvrVuZZp0YA3+RjLii2CJvAS/6SSHAYlMC74E/wmPKCXVtxVM
         isqjpdGh6R04M4IE/B0G5FuFWxnn/svR5iT/bnhKyx5KcuUARKR5ad/PPA4ohAAAQO52
         U6yF8E6alSCmJDMODgRuAvnwKgq/tamTyCcsPHsLcaTvrARlTwBhiLAmy1aSB9XfQGqA
         he/mQvl8s7dNdJ+gtyWXF9s54wOFBtzZmxPllH0sm4Dax4PiFLVK44TkTd2sNOEP948A
         KW8c8eKt/VDEfzFnSvoWeaAEQgwI8elIrTRkx5Q35SeyK+8hg68m4F8U0eoHJtojxaCv
         dwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777555677; x=1778160477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nyOMENDhhKn1drXUY5FEfpalnnqfQd9/9Hk+P1Dg6SI=;
        b=FRh351Qr6vJm2b/rGQSYDTp6wRaWYXedhL4LjmkXU39RNRJq/YUEWPJ3RDDsT1YCMW
         9/BVdOfBZCUU2QK9Jm7nLK+JWxB4p4ITOo1X6D1kBT8V5+sswq5J8iBr34waiE4nR/do
         9Lyn8bdgohhh5sHtLQiuYcQOiJKZv5GRW4LJY6TfNREwqdz4/t1uhMrY5jGh5jEeV87i
         s/jbhHiw1naXhnDtM/Cul0XPFTxke+rei6716MYDbMQFJzSZzVfiiqqrU4iEoVOeWmRh
         /n2Bm7Z4pIC69u4uzhRBJOTjO0JUMGxfaHSC56BXUKLcxd6rYGeHKCL9u8UUPUMYevfi
         pt+Q==
X-Gm-Message-State: AOJu0YySehyCVmKIPRZqqI2LhsIGmFQrBLCFByEDuNiqMH9ljdwuDUoW
	Hwr46N6X9mgFx9JceDyddrsPdB0HS3ijU2rHS0CMllSLKxFYctuUkpLA/fAdqhEQR8zRY4hMTaK
	sRRX1
X-Gm-Gg: AeBDiev4oyMcBqpARGQtsqry21F8BzLuZsE0EOTXaQu+HPKL4nFDtn5SX0ZQ3BCP/KL
	9C8JKs7vhCVdO+k6CN4npH76cyWiq1uyeV+KLhoq0HT74rfrRwargziU26ndjhOw7RiNbmlPnN9
	z1reASC/NT1CxQ8Myp92YBnLYnt/UV5qK6W9FRtcumfAzo6GyDu9Hu7AxWjJ4m8krsSafeFo83H
	2alpW6r6buFwOWZeu3QTHb9MemR5K0odzATZ+ZDYQSx2/B/SQxGLux8l8Z2+niLfEfAZOrUGnSg
	axUGWec1BwzzpiCIzE6Y+5IOnMUl4A/LvO6bTBwmRpkfOKHfjxduSF9AheAriyNgFhuSFQahggX
	WIxdhhSPX2JrzTRZaH12QPmT9TqLzM932LTXV9KaPtgasNuSTBOYBfrshgJLg7OwYe9cn+Nqz+g
	pzNv+6vLZnslobzAy01Ze1AqTwSCA/XqjT51L/NrOE2YW++4+UqPBXtOwpes/CQHCXHV4TX0Nto
	DpFSnS81nU9d/maMVU=
X-Received: by 2002:a05:6820:217:b0:681:b070:3dc6 with SMTP id 006d021491bc7-6967a49ff98mr1617272eaf.10.1777555677238;
        Thu, 30 Apr 2026 06:27:57 -0700 (PDT)
Received: from [192.168.254.51] (72-0-139-202.static.firstlight.net. [72.0.139.202])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6966b93d58csm3164874eaf.0.2026.04.30.06.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 06:27:56 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Rik Theys <Rik.Theys@esat.kuleuven.be>
Cc: Linux Nfs <linux-nfs@vger.kernel.org>
Subject: Re: NFS4ERR_SEQ_MISORDERED errors and NFS client very slow
Date: Thu, 30 Apr 2026 09:27:55 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <CB5BA5C0-15AA-49D0-96B9-2017F6617903@hammerspace.com>
In-Reply-To: <2cb85a89-f896-4504-b1cf-e4494d344ffe@esat.kuleuven.be>
References: <2cb85a89-f896-4504-b1cf-e4494d344ffe@esat.kuleuven.be>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C95A34A373A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-21297-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 30 Apr 2026, at 2:53, Rik Theys wrote:

> Hi,
>
> We have a Rocky 8 client running Linux 7.0.2 (kernel-ml from elrepo) th=
at is an NFS client to a RHEL10 server.
>
> Lately we've noticed that NFS performance is very poor for certain work=
loads (We saw the same issue on the stock EL8 kernel, 6.18.20 and now 7.0=
=2E2). For example cloning git repositories is extremely slow.
>
> Looking at the server side there don't seem to be any saturations of th=
e disk or network subsystems.
>
> I've taken a network dump between the client and server. In that dump I=
 see that the server frequently responds to requests from the client with=
 NFS4ERR_SEQ_MISORDERED (10063). What could be the cause of these mismatc=
hes? Is this always a client issue, or can this be caused by the server?

This is something you shouldn't normally see and probably indicates a bug=
 or
serious problem.  From the client side you'd only expect this if you're
doing a lot of task signaling so that the userland processes abandon RPCs=
=2E

A packet capture is the best way to determine if the server is mis-report=
ing
the sequencing problem, or if the client's sequencing is incorrect.  Give=
n
your description of the symptoms I'd also check to make sure your underly=
ing
network isn't doing something totally nuts like duplicating packets.

Ben

