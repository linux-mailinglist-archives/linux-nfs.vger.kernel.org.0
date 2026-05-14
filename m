Return-Path: <linux-nfs+bounces-21628-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBLpJ3pSBmqnigIAu9opvQ
	(envelope-from <linux-nfs+bounces-21628-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 00:53:46 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45445547951
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 00:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA32D3008996
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 22:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAF03A75A7;
	Thu, 14 May 2026 22:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b="XGzF3PlF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtpo63.interia.pl (smtpo63.interia.pl [217.74.67.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720AB3A6B76
	for <linux-nfs@vger.kernel.org>; Thu, 14 May 2026 22:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.74.67.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778799223; cv=none; b=asr1/zAzAibWMAgejZq9Irma2E4gbE03E+Li9Rrf4w9C2WIeSbWtVwdjzjuxFSN1FhscMXzRtUvB3Os2HlqTVRSlmPg5auW2zvU8JCNckPSaJx0fVUYrimrBnkY25urFIL2TbOVeMN3Eh8XFgTeBp7cZLYp/FjaULch+CIWNNh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778799223; c=relaxed/simple;
	bh=8otikSoXFPdpLfOTfF3VMUvjp/Z2zSChNUkhA3oXku0=;
	h=Date:From:Subject:To:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=HTQflor5VGdMHOcjGP+KUiWWOKoqKWtgp+Mbj5gr1f28WPF5xojfxakLJkCtKndQhH3TcNjGGvZj9xTQokUfchp18oxJ7sW4FaQVYlpwBPiGKICdmd/6GFiTg0HT8QaT8Af8Fmz6Ti24g6SgYOypf5ob/4RNUJ09CsiplFqE1xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=interia.pl; spf=pass smtp.mailfrom=interia.pl; dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b=XGzF3PlF; arc=none smtp.client-ip=217.74.67.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=interia.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=interia.pl
Date: Fri, 15 May 2026 00:52:21 +0200
From: vermaden <vermaden@interia.pl>
Subject: Re: Increase FreeBSD NFSv4 nfsd buffer size? Re: Increase default
 NFSv4 server size "max_block_size" to 4MB
To: Rick Macklem <rick.macklem@gmail.com>, Cedric Blancher
	<cedric.blancher@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	"freebsd-hackers@freebsd.org" <freebsd-hackers@freebsd.org>
X-Mailer: interia.pl/pf09
In-Reply-To: 
	<CAM5tNy4zgRBFAmwWCApAYvTHuhVtnkQRdhG1xpjekUnhdtsA2Q@mail.gmail.com>
References: 
	<CALXu0UdOR8mVr=8pwNP95FnOsOk1w1A2=DcayKk3YnDfS+PzUA@mail.gmail.com>
	<5acaa8e7-0691-4cbd-b501-c26831a7be81@app.fastmail.com>
	<CAM5tNy7GG0awNYYJWv0968e5CMoUstr0GcrNwuNKP4x3Yrp3JQ@mail.gmail.com>
	<CALXu0UckL3YYXVLz5Qn0shoZ+TU8uOxRy2FCpL5mAhLniinJyg@mail.gmail.com>
	<CAM5tNy76P-1Q2EhJ4zXUtc=EwRYgke8ZqJEYvM=sRyY77rxHLA@mail.gmail.com>
	<CALXu0Ucq2Wwyuu3BUzv0i6_2UNBPDRVzXVgH4O056PoZOzEgRA@mail.gmail.com>
	<CAM5tNy7Crx-MHAO1DKwdWJdwLQX=kWrPFPke1-uLbZ4DYPnTcg@mail.gmail.com>
	<CAM5tNy4zgRBFAmwWCApAYvTHuhVtnkQRdhG1xpjekUnhdtsA2Q@mail.gmail.com>
Message-Id: <ylbouteyvryomeedhmin@fdeb>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl; s=dk;
	t=1778799144; bh=rdf2eefdCeZp7mxJtfOsFl1hWcutTEyWdbPuvtCFOIc=;
	h=Date:From:Subject:To:Message-Id:MIME-Version:Content-Type;
	b=XGzF3PlF4OGArDmJFyRI/bBiiP/+1J2++yeQT7oROTqZsN79I6lkGeTpJB/+jiatX
	 +Jr39dlWFrroqvY2nlSZtoI2nZPfSmwf/5oe0GloJQDmq1o73hBn3rVY/452Ex0kxq
	 Cn2LlLVDx9VawaFJ60uWjsAmQCIZxh7cgnRIRSHA=
X-Rspamd-Queue-Id: 45445547951
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[interia.pl,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[interia.pl:s=dk];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[interia.pl];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21628-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,interia.pl:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vermaden@interia.pl,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DKIM_TRACE(0.00)[interia.pl:+];
	RCPT_COUNT_THREE(0.00)[4];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action


> To enable it, put this line in /etc/rc.conf:
> nfs_server_maxio=4194304
> and this line in /etc/sysctl.conf:
> kern.ipc.maxsockbuf=18892800 (or larger)
> 
> rick

An idea ... if 'nfs_server_maxio' already sets the 'vfs.nfsd.srvmaxio' maybe it should automatically also set 'kern.ipc.maxsockbuf' to 4*nfs_server_maxio first?

I mean ... if someone wants to just use /etc/rc.conf for this - that seams reasonable ... and if someone uses /etc/sysctl.conf file instead - he will have both of them there anyway and will not use 'nfs_server_maxio' option:

    vfs.nfsd.srvmaxio=ASD
    kern.ipc.maxsockbuf=8*ASD

Regards,
vermaden





