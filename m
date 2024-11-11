Return-Path: <linux-nfs+bounces-7881-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 537BE9C4953
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 23:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7DD1F238CE
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 22:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3EF156F5E;
	Mon, 11 Nov 2024 22:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dimebar.com header.i=@dimebar.com header.b="g34y6U/s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NfjWUALO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FB48468
	for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731365412; cv=none; b=W/VbzTOqOV5buAEYCdjjXQzEDE39IS7mQC7Ndv/FCGZgu5hYDb5Y1Bl25LfFH67y+eDxq4rnT1HpkT6USzjhRizGd5TJWxWufuLQyqXh19gXCJ1fa3AgMO+3extJVt6cbLcYfYELDvOdYNKjso/wzO3Cn13xOmhgA2ssnBzb4Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731365412; c=relaxed/simple;
	bh=K+Wo7HOhlHz/l1/p6b6lmDl3lsVLZtlcjkkqebao0yE=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=gg791d4OcRFF+85rYIqWvsg4+FSHXUuM+3E6X4Fw78IY1vRruNPvaQHqSE1i+/KWQ39eTdxwcYTZBhQF3OBIFluLY8aeDQ+AgALdlKPgdd6BUExezgbOyNuhecVfjB1QeI9VAd/550FpVu94dVgL/dB5cqs38Nk0WyYPyaBdhPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dimebar.com; spf=none smtp.mailfrom=dimebar.com; dkim=pass (2048-bit key) header.d=dimebar.com header.i=@dimebar.com header.b=g34y6U/s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NfjWUALO; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dimebar.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dimebar.com
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 76B7825401D9
	for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 17:50:08 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-10.internal (MEProxy); Mon, 11 Nov 2024 17:50:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dimebar.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1731365408; x=1731451808; bh=K+Wo7HOhlH
	z/l1/p6b6lmDl3lsVLZtlcjkkqebao0yE=; b=g34y6U/sBsExnOtg3mcGZtzeEk
	GjQvN2qWvw9Y2od+qUJ/CLeTCkFfH+1Nm87hlS8w/9dvbkVfafbMpwekMCQrIa6l
	uWvKhdypi2pn/XPnIWj/kMe8JfI3xIpnpTQDJujFzS4UZtovspVCCBHPdNEsn8kc
	DnoVhBUFHxzribLSRZiTXxB/jHKYCF6KaULLQn0iGRqYNgjxyqjanE/P7tvtqDVz
	7rKjzj1vqDdXvQcNHBogvJ9CN1CvODMB0yURZjAyrmYF+sJAP3nQb6YmpYn+Knv1
	S1BnxuLtPNP+LYBZawyEyCD+Uf3eRxO/qLVEWiuZ8O1R3c2IKZvT6tUmwZng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731365408; x=1731451808; bh=K+Wo7HOhlHz/l1/p6b6lmDl3lsVLZtlcjkk
	qebao0yE=; b=NfjWUALOvj1R+7ZCwyAga0yS5MMNTGCBHIiQxfg6kAogze+jpT7
	f0FO5XtxEL2r6cqt9dx74/B4AlXLGIwmd096mZXgrjmK4jZqYmkQprvxIpaSsRwX
	EKJJVal+D+mwPUt7gUBbfQ5AA7F7xSpNxDfEhxzZn/4LBABF69Nf+Nlvw7O5HVi+
	9jcahJKBgd+gdejNmtB1d+us/3D1Rq/HylOln/t8fp+CJtcIUSfzqV9wMoc6jG3V
	zNjawmXHbfYDtBmLuGABP8lcvvBMdMnVA4r6vjPwIzRZozLHzU8E90bd1wobxOfb
	wOsvMf3iuglofjr0W0fbye4Da7Bk0nIom0A==
X-ME-Sender: <xms:IIoyZyPuSRISuT0pWywEUy-LWrzHjYqaCZj04haSl4u9Gpod9skF4A>
    <xme:IIoyZw_zp1-H-A_QbDYimg6Aq59rAYNiYMim2n2C1eVi7IBpCdkwup0VtSQl8e_IM
    TGMYKnSkasmwzyB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggfffhvf
    fkufgtgfesthejredtredttdenucfhrhhomhepfdfrhhhilhhiphcutfhofihlrghnughs
    fdcuoehlihhnuhigqdhnfhhsseguihhmvggsrghrrdgtohhmqeenucggtffrrghtthgvrh
    hnpeeiieeuleeggfduteffffdtudekveevgefggfefheejudfgueeguddvgefgudethfen
    ucffohhmrghinheptghomhdrnhgvfienucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehlihhnuhigqdhnfhhsseguihhmvggsrghrrdgtohhmpdhn
    sggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuh
    igqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:IIoyZ5RPFqoquYinWSgVu7DWhgjvRtl4BhDUv_WYy9u0ysSJXkj5fQ>
    <xmx:IIoyZytGUnB1NOPVxGC_zy1vkoU9Jisn0OHnyxwqroJpIthR3InpGQ>
    <xmx:IIoyZ6dG-vPTxNcKiDqulNnMlmdccZfcmiX2dOCAu9gS4VauvPDPFQ>
    <xmx:IIoyZ2275DHua6ELheIyHJ4zG_4TXvedhEUk0eMk8yX-9LbYwBglOQ>
    <xmx:IIoyZ8rYi4YqzPwFoUq3I8S7iExd4Kx6YiyaTDyXd6YN0D7vqdxRKG4J>
Feedback-ID: id0b949ab:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0EA9618A0068; Mon, 11 Nov 2024 17:50:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 11 Nov 2024 22:49:47 +0000
From: "Philip Rowlands" <linux-nfs@dimebar.com>
To: linux-nfs@vger.kernel.org
Message-Id: <6296a7d4-64de-4df0-893e-8895e8ec36d0@app.fastmail.com>
Subject: Insecure hostname in nsm_make_temp_pathname
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

If a host dies after nsm_make_temp_pathname but before rename(temp, path) we may be left with paths resembling .../server.example.com.new

Some clever person has registered and installed a wildcard DNS record for *.com.new.

$ host server.example.com.new
server.example.com.new has address 104.21.68.132
server.example.com.new has address 172.67.195.202

You can see where this is going...

Our firewall scanners tripped on outbound access to this address, port 111, I assume due to NSM reboot notifications.

Suggested workarounds include:
* explicitly skip over paths matching the expect tempname pattern in nsm_load_dir()
* use a different tmp suffix than .new, e.g. one which won't work in DNS

Steps to reproduce:

# cat /var/lib/nfs/statd/sm/server.example.com.new
0100007f 000186b5 00000003 00000010 89ae3382e989d91800000000dc00ed000000ffff 1.2.3.4 my-client-name
# sm-notify -d -f -n
sm-notify: Version 2.7.1 starting
sm-notify: Retired record for mon_name server.example.com.new
sm-notify: Added host server.example.com.new to notify list
sm-notify: Initializing NSM state
sm-notify: Failed to open /proc/sys/fs/nfs/nsm_local_state: No such file or directory
sm-notify: Effective UID, GID: 29, 29
sm-notify: Sending PMAP_GETPORT for 100024, 1, udp
sm-notify: Added host server.example.com.new to notify list
sm-notify: Host server.example.com.new due in 2 seconds
sm-notify: Sending PMAP_GETPORT for 100024, 1, udp
# etc.

tcpdump shows the outbound traffic:
22:42:31.940208 IP 192.168.0.131.819 > 172.67.195.202.sunrpc: UDP, length 56
22:42:33.942440 IP 192.168.0.131.819 > 172.67.195.202.sunrpc: UDP, length 56
22:42:37.946903 IP 192.168.0.131.819 > 172.67.195.202.sunrpc: UDP, length 56

The client statd was artificially placed for the purposes of showing the problem, but I hope it's close enough to make sense.


Cheers,
Phil

