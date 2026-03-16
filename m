Return-Path: <linux-nfs+bounces-20183-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFM0N4AXuGl/YwEAu9opvQ
	(envelope-from <linux-nfs+bounces-20183-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:45:20 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5141629B9CB
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32EF13007F58
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86332D77EA;
	Mon, 16 Mar 2026 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b="DjljLMoq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from seashell.cherry.relay.mailchannels.net (seashell.cherry.relay.mailchannels.net [23.83.223.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FF82D7DC6
	for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773672091; cv=pass; b=V/FSmp65Oh8+hMLv28Uni6aopsdcn3j28B6NkYSWMwm+U0pEgDS4bkSr6OQplIU0SlPM7Rlm6yHPjIm70a4kIvg7aJw2DoHWyB6c9XR+qdF7sDVXZU+CUgu5zVOUq9XlynsLmTlGETIo6XH4UMv9t6bLW/j2aLU7pMazgS843ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773672091; c=relaxed/simple;
	bh=geFsYpuq+Qwr8WBvtmhhszoHCuvc2sPxvSrv5mU7DrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=NnmJQCq2MM9poNKQvHqSDGR4SY5Gt/qtW0ppnVocCMxyHTQfTVuWQfhZuPjs2SNwrgmKkFahfR8EYf9AM3AQPa5l0v4bWuw/QjcpV+EHU5s+yHAcPEEu0bpuls4rHB5eM80JYHifnHm7izeHiWJaKawYroWvaKEpOpeLOvMwHUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org; spf=fail smtp.mailfrom=nrubsig.org; dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b=DjljLMoq; arc=pass smtp.client-ip=23.83.223.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4192176289F
	for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 14:41:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a237.dreamhost.com (100-115-72-50.trex-nlb.outbound.svc.cluster.local [100.115.72.50])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C5A83762A0B
	for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 14:41:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1773672083;
	b=qTedyhpHHCr0g2vKB+A3JxnVrrEsXq+d1b47xAibeO8Se4/bzuOg8qCHnrfQVvsPqd8cnI
	u2KlYIWsZ1sv64F59FlspnGlbhcm3L3V59z7fbgKv7BkcOC2zULAkPdch/BjLtajFRmRHf
	B9N5WHtUMgCGPEk28DZLuVC2twQu5EVCo0H0YN3gAWDexYAstjMpSF/C1KtbJO3qBMECG+
	Z8NPKOQBgkAgyuQ6G/oE+P9iRI/vO1B0Qu3W/NFKdOrNhj0wZw9ScaVNzKtjbp0+oeh7M3
	HKbSymY+L/U6hAZDfNL1bzdMVyCr8b2c5nQ0/AUPaGfGjkkDJS+0bTHSNlgs2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1773672083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=sll9rp2IkhnimugHUsFGghuis5nenM+q1hZ5qoysnCs=;
	b=hMwX9HHsrJprUhn/UvrqO8xztqXLqh/CUIIbYyKBZlrOwxEjC9m62meWe49zzMyExjS9FY
	CerAWqmeSMTGnGLAv6wVwdVVaq6kfGydhkawy2YM2Xe4fz76vw08yMwK53IDIXBzYYoDJu
	ZlJtjurJkCnt5hCe1NS4otJ6DMKcdL1fBcHUOHmI0x8FdZhIGR0l6S/3SlUA4Wa3/jURYq
	BKZtOMVhQYYmdH3o2cl8km+Fdfx5GUapau6KRGJvcQhtNEBzG46ci6LngMtOQr2ofef3II
	KsnNW9M71u7N5ynjIoYtfOFU7ecUafL+ZyJgSKAs6Qd4yJpV2FzmAonnUiOpnA==
ARC-Authentication-Results: i=1;
	rspamd-c9674b64d-jx94n;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=roland.mainz@nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|gisburn@nrubsig.org
X-MailChannels-Auth-Id: dreamhost
X-Befitting-Society: 51b49044099875b6_1773672084004_1856501336
X-MC-Loop-Signature: 1773672084004:1997445480
X-MC-Ingress-Time: 1773672084003
Received: from pdx1-sub0-mail-a237.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.115.72.50 (trex/7.1.5);
	Mon, 16 Mar 2026 14:41:24 +0000
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: gisburn@nrubsig.org)
	by pdx1-sub0-mail-a237.dreamhost.com (Postfix) with ESMTPSA id 4fZHpW4jxWz105F
	for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 07:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nrubsig.org;
	s=dreamhost; t=1773672083;
	bh=sll9rp2IkhnimugHUsFGghuis5nenM+q1hZ5qoysnCs=;
	h=From:Date:Subject:To:Content-Type:Content-Transfer-Encoding;
	b=DjljLMoqY31rmDitU6a0ZVWGBDvX/VlsBJMgHYTF0ZUdyWGWDHANAUfRDSflhXkDT
	 dxmzmPITxr/+8vC9PhHCM1T3mdqetqxZbI9mSEyXiYl0Dd7FcCFu1z7pkderD54SF3
	 WI6jVIiIF1JFvWq2pz8VWmUgi2Nmqd0MeVqk01vqIIhzocN6//bpuYJ7CHRCJpufca
	 Px/1tSSzJ+GatCN0ACmkn9NaGbcV87QUdpMeWxyk5K7OdmBTsTonfFMy1ss0oAwhrs
	 vLjA218jqQ1BFZrhCLkRk4fO6c9G3LG8yuHUjdC7kRzvdMQSQArVPsNRGs2rF1qOMg
	 QdRcJWW6gsRFg==
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439d8df7620so3394805f8f.0
        for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 07:41:23 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzd1fxgcGJlcUY6j5Pd2ZD5JYGoRNZtRosom/fquydz4NTUdrnD
	iozHfsitXtFLDGjU5y+e9u5ceVRNatvhcUcWXE596gJZFsHuSuVYin00YvzOQfBzFsvcccVA26v
	cj/TqKBZd7DPXvwoJCW85q7Oc1h93zjs=
X-Received: by 2002:a5d:4984:0:b0:43a:580:eb02 with SMTP id
 ffacd0b85a97d-43a0580eb61mr19042979f8f.49.1773672081424; Mon, 16 Mar 2026
 07:41:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UdOR8mVr=8pwNP95FnOsOk1w1A2=DcayKk3YnDfS+PzUA@mail.gmail.com>
 <5acaa8e7-0691-4cbd-b501-c26831a7be81@app.fastmail.com>
In-Reply-To: <5acaa8e7-0691-4cbd-b501-c26831a7be81@app.fastmail.com>
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Mon, 16 Mar 2026 15:40:43 +0100
X-Gmail-Original-Message-ID: <CAKAoaQkFfQ0LvnmfMoXD8RJfwhnqOZy2c--wLoANfMdPLyqP2g@mail.gmail.com>
X-Gm-Features: AaiRm52AANkQCwJUVYvm2whs8zEe5zTicxPM7GWpPwuqjLYRpyWmpiw1G9Fufw4
Message-ID: <CAKAoaQkFfQ0LvnmfMoXD8RJfwhnqOZy2c--wLoANfMdPLyqP2g@mail.gmail.com>
Subject: Re: Increase default NFSv4 server size "max_block_size" to 4MB
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[nrubsig.org:s=dreamhost];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20183-lists,linux-nfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,nrubsig.org:dkim,nrubsig.org:email];
	DMARC_NA(0.00)[nrubsig.org];
	DKIM_TRACE(0.00)[nrubsig.org:+];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roland.mainz@nrubsig.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 5141629B9CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 1:39=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
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

Linux 6.17 NFS server:
$ service nfs-server stop
$ printf '%d\n' $((4*1024*1024)) >/proc/fs/nfsd/max_block_size
$ service nfs-server start

Mounting the filesystem with ms-nfs41-client and compiling Cygwin
bash.exe and ms-nfs41-client with Visual Studio etc. works fine...
... and I verified that |FATTR4_MAXREAD| and |FATTR4_MAXWRITE| have
the value |4194304| as expected.

I didn't make any benchmarks yet, but quick observation shows that
cloning a git from a git bundle on the same NFSv4.2 filesystem is up
from 8.1MB/s to 8.8MB/s.

----

Bye,
Roland
--=20
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /=3D=3D\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)

