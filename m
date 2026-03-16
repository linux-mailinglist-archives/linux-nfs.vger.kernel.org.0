Return-Path: <linux-nfs+bounces-20228-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ9GCPOTuGnCgAEAu9opvQ
	(envelope-from <linux-nfs+bounces-20228-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Mar 2026 00:36:19 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 809DA2A203A
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Mar 2026 00:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A233C3035A96
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 23:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215B6186A;
	Mon, 16 Mar 2026 23:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="altaj9U9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BF734B434
	for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 23:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773704152; cv=pass; b=I3v2WQvQsaNBAKBXDFp6RTqiI3P3IXNn+5lcIUlGG/XgmQNb+78U6feln1eGbrqjCePCsjFEy8065389guUQV4Aho2/o9AIEtFLmtZ2SlaHCofG7Y5q0If3ssgKxb/AcYjgRrHNEGbzEI/tEW7Y9gtCAiKT4z9UTIQ/Tr/o/Dew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773704152; c=relaxed/simple;
	bh=akdds+26r0Mp2szMBzYxMJ9d3JRKrYxVtSoTjjWvr2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYS6w0medRMvVdeqm3GLcL+qEKNWH3K1qYr2F/aEVWDnNBRpDp9DO3ju4Ht1ka93z8GTL60ewO7iKNabVzBsQognxQiqf0RywU9vXmJano+0XliWmLTDo5FjJcUD0/xhUKrEvuPm9QGKvrVcHpXgFPNR+owFU11QDSQFU8desWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=altaj9U9; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-665634cb208so2765308a12.3
        for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 16:35:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773704149; cv=none;
        d=google.com; s=arc-20240605;
        b=KaJ+7jgSQ6kvR746aqPvGh2igKRGeyVhs6PQAzBvY3KjyGIwkk/ivOGxVNwCQ3rDdm
         cVb1Zto4jFXag6KXR90kA7ioa00oMQ5WS9YHfVtgtWNkgNNrWMw3ByzaSqQiCi3VSP2c
         WgoBITfFZFaG+f4bxtQS6IyGOoRk/v6e0hE5j478/gL5LDJMD5TQtVl8OPlrW5FB7wWc
         u+ChhAmNbJHjIcnigZBtdO2uSWi36i0nb1Q3JCWa5nlnrT9Wk9zfzgLiuqUv6evHqwQy
         rsAylhD/7g7HWl3/mx8rhdaA6wLORaki2gsPm67VvkyIrq6HIU0djWxnMlr3Z/L/04iZ
         CCsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gDnw5u7ykZOKoxVfBOxkESOt2PuapwQmU2YMOnTLTAk=;
        fh=oNxWaH9oxjx2mxCqwOI5NNEIowOj9p0NSEbePPziJpw=;
        b=WYjlXMsBbyn0Id/UsfhQMUPKhQNRfgV2WRv1PmOY1xLVuVtu5kvRBxYJK7R1+BktjH
         /YWdIGGZnHDBD/rL080V3eb23T5x6lGk2ZA/sa6K3F6qInYgucJy8U4pF2Hjaw4zjA7N
         2l8VnZ3+7CetCXZuwX0/ozJJJ350ZGXvbkC0C915KRXCzG1A/mIG/2DBSEf8/ir60RnJ
         9X1N3ZABM3KNCGSFwi4CwPFhpuKk8RPsQw19O30388BE5bneRVz9Ye7uGta0zZJ22Isp
         n7bFuPYOBQHhEZf4HrpxR1RIkW27J+pM2sUAfwJrcu2o73iwqA9Ly9gIuR1Jf46dSimW
         rbgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773704149; x=1774308949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDnw5u7ykZOKoxVfBOxkESOt2PuapwQmU2YMOnTLTAk=;
        b=altaj9U9Dmz/f8LKDq+jiGM0pWpSlf/Hhk7Kvw+DTGY2NdyO3frtohDm1cZ2toAZx8
         a/Sg7tijTJa+hCHXU/5/2ZkELReQDMxqM/V6pOcAn84AQukLVwbZ/QO5LsaPsL33Of/Q
         XA5l5RfGYJDjD/ke1DvIRCczp+SqfJgqkeokgV7ScxyIrpiCJ4xYs4ttvBooaj9ZO0qC
         2fa6K+Ji64YIfuLdw3+O1AdLN6LjQl+ybvwKxma1/itIXpTRSKPd+9yILilKjAxj66fF
         hHdziPSbkp5+G41nuvyt7YRcN1P8bZHkJW1EozZgw+ErTo3r7RlBIHI4ViaEkhZd2zEM
         xjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773704149; x=1774308949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gDnw5u7ykZOKoxVfBOxkESOt2PuapwQmU2YMOnTLTAk=;
        b=OqqbEOlMh28MEj3DNwfpdZKyBSYKPykfX2tGCTpOOTccgrMw5UZvUwSKV780FPMj0W
         8kER/AF59af0mDACoCS2AZTLesV0b7RRlqHFp1YyjaQ3WWJy6aIlc1iSCwpapQ761lAv
         BXhBEpC4NMR9SjgeuaA/OSo1aGfqXa8aEKUzSXJH94QxKK5agspAZy82dyWVYDaOftI2
         n4HpZkWC65pY+WfGwc1lEpgONRVDdFDj2EdskN1Yv+L/1N8vhZrlKFP0wphUun+JPLOF
         22MD9LNCo+XYVbzl7B5r0vYFvW0aPuqdt7ok302QdUaVzyGzq42qwA06KYkxbkIpOXJ9
         /9Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUyC4q/g1Atg2TrlisjQ/fx95+a+oRroYkPm6XpnP2DpJqjToIn4Hhwyphc1P0RJWJOOjcRTY1kIg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySlV7jtW66JIt0YAhuPLLukDXEqQar5TZhG9rjAM2hdX24yJdw
	A7dsP6zrc+OmUTAvVC2AWjgBJlwjAWFd/dp8cY6o0dshqSrqVQOMY0tmOzGwNJAfZW/P4GmBwhh
	8ll6R66Gm9vMgYdq2F2sy+GNlfhKvJ9QH
X-Gm-Gg: ATEYQzxmhpNPSbjl8uVALwZypfp4A9LHKOaVGQht4gKJEWG0MtRsQkvlIV3CWSvh6/+
	UM9dm2t1wzfBWhDZHjUouVpcalQyZX2eutPjZ+vlHPCDnf7/VfatXxMsAcCbi7OSjjL9FgtSb8/
	mmO5oluOHKzE1j0gOqs7QJ/fo8Ae7L4aHB/XH83zLeb2Ye8YC+9Nz+nc2d4jjcYEQ39kq6Wi4LV
	hskoYc26lB1OXnRKoFggPwIFKBW6VONU+lzjRtkSU507mMBzBusYMQVK5C7dHjpWl9VyU0MHdZf
	oB276bfbBlTK2ifvOZRe04Oy+PwC3gK21Ns0Uw==
X-Received: by 2002:a50:cbc9:0:b0:664:d419:6e69 with SMTP id
 4fb4d7f45d1cf-664d419716emr3383482a12.13.1773704148968; Mon, 16 Mar 2026
 16:35:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UdOR8mVr=8pwNP95FnOsOk1w1A2=DcayKk3YnDfS+PzUA@mail.gmail.com>
 <5acaa8e7-0691-4cbd-b501-c26831a7be81@app.fastmail.com>
In-Reply-To: <5acaa8e7-0691-4cbd-b501-c26831a7be81@app.fastmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Mon, 16 Mar 2026 16:35:34 -0700
X-Gm-Features: AaiRm52rCfBU4ApKhYP_77dve_KolFF8Io_TK7wN08F_X_XbArYrtND_6zOkUNg
Message-ID: <CAM5tNy7GG0awNYYJWv0968e5CMoUstr0GcrNwuNKP4x3Yrp3JQ@mail.gmail.com>
Subject: Re: Increase default NFSv4 server size "max_block_size" to 4MB
To: Chuck Lever <cel@kernel.org>
Cc: Cedric Blancher <cedric.blancher@gmail.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-20228-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rickmacklem@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 809DA2A203A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 5:41=E2=80=AFAM Chuck Lever <cel@kernel.org> wrote:
>
>
> On Mon, Mar 16, 2026, at 3:51 AM, Cedric Blancher wrote:
> > As debated a while ago, can the default NFSv4 server size for
> > "max_block_size" be increased to 4MB, please?
>
> There is an administrative setting to raise this limit for
> recent versions of the kernel. Can you report your experience
> when you raise the limit? Hiccups, performance issues, etc? I
> would kind of like this exercise to be data-driven.
>
> What is still unknown to me is which NFS client implementations
> can support 4MB or 8MB. Without client support, an increase in
> the default in NFSD doesn't mean anything. Rick, Anna, Roland?
Although it has not seen much testing, it is possible to do a > 1Mbyte NFSv=
4
mount in FreeBSD.
For a 2Mbyte mount, (the only size > 1Mbyte I've tried) the settings would =
be..
In /boot/loader.conf
kern.maxphys=3D2097152
vfs.maxbcachebuf=3D2097152

and in /etc/sysctl.conf
kern.ipc.maxsockbuf=3D9455616

Then a mount will use 2Mbytes if the server supports it.

I doubt anyone does this, but it works for trivial tests.

Maybe I'll do it during the next bakeathon? rick
ps:It would be really nice if Roland could show up
     (you can attend remotely via tailscale like I do)
     at the next bakeathon.

>
> --
> Chuck Lever
>

