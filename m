Return-Path: <linux-nfs+bounces-18352-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAnsEyWHc2krxAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18352-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 15:35:17 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5543D77230
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 15:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07F0F3019048
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 14:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3082BEFE1;
	Fri, 23 Jan 2026 14:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dustymabe.com header.i=@dustymabe.com header.b="4Cw36PLl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oTSNgbqp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307751FE47C
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769178913; cv=none; b=BP75DI3FIdvvlAIROR5naSG4zYuD7crT0NfznAhFyBoBxrPXwmjBMhzQBSJI45XnMiLMvL3+KIZOtwNBuewjLyXm5Xpbv9kv/Kh75utgpA3JvUXo3QF9C8uDO9yVR9wievp0VjkfbxoSwIY8c7XuapyhbKJHGl182gGlgk6NVo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769178913; c=relaxed/simple;
	bh=TAXpCcZ5iwuuK6G+T2Fqfn7PSEvzzDlVcGIQj73CQOY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=joACkIsbjFoFTrP0lcdUFQqA4M1RC99OJcS2xlUHDy33waUIs2aQVH9brRYzCagvU/0atxTA3tbrtbBLTQ9tgdL0MJU/I/yEMtnUGOvCZbKTBpQuwv4ltksObO3ofHFfh3VS15cAjeWsctwPG1GX8RwnhK7Ufu7uAnhv1ZoVLgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dustymabe.com; spf=pass smtp.mailfrom=dustymabe.com; dkim=pass (2048-bit key) header.d=dustymabe.com header.i=@dustymabe.com header.b=4Cw36PLl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oTSNgbqp; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dustymabe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dustymabe.com
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 64500EC02BE
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 09:35:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 23 Jan 2026 09:35:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dustymabe.com;
	 h=cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1769178910; x=1769265310; bh=rtkmUzo6yATAj+XkHxY6v
	xzVr3D9C1QbTXEws5Az7vg=; b=4Cw36PLlg2JNQpdp1I5oQKGGBCxyug860i6p0
	H4f1shNY/YXqkGsmO6luiJzvq1hqLLCcFao9zA4v6hvu5cMbQS4AXNT2eJ8grOFi
	PJBUCrYIrkTYOOl/uV7vQiDP8H/U/sMi93TZ82fmhkfxPficueIlktUQWBAEU1P4
	jU7o47hSUDdXND5+Q9I+kZ4aHmXJL0tlkSGT0LouxurjFpnTMfWAWhYw7/uiQy8C
	+i8Tgy+6QgDFVKka42Qs48VV0aZVLaZJxW4Bi1BBmIOkYXdAZ90/dvzFOaHc44cR
	0xixNQsWD+KkdAb0rMrK9W6gae1JX4K15FIE9dMKF5+aRn/lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769178910; x=1769265310; bh=rtkmUzo6yATAj+XkHxY6vxzVr3D9C1QbTXE
	ws5Az7vg=; b=oTSNgbqppwlIIc6i2YPqsu9OE2rPL0168NOQQy/zmr9GB1hrN2y
	BPKX8r2rdNwVI+JJGtNYQDccHPSORa0u+venuOpeqnMXOLOjUHKNAyV78Y3Mub8I
	Y++5AUXLRbjuK2DUQNvpZTMOz1npASbX5KjvRetcXnQNtEgw9f8ez2qUsOMXydls
	XqJssQhGdkI3/0Gsa1FB9AgRPTNepOE0JvInJKpn/XAs0T+W6MEDxCOJbdb9YVVa
	oRGxAoZuaeTIKGEX3WIBQXzomHdRKH/wFXUaiRu+aE4yXXJOHBsepJnw98OQkjJu
	5ENaRw6ohTyWarZmDdudD+wd6Dd41wTVwPg==
X-ME-Sender: <xms:HodzaQ0J89CpmsaWr1i_EiPnna5pkMa5ix25KWd-4SNmjr1-tTMJuA>
    <xme:HodzaSCdOJZo8OBH7rJosOKokODRf-q_odB_72xxIZGgf8RpqwxO58O_txRg3njVY
    wc_Pdot8lUxtLI1JR0jpCU85eT0XAA4qxrCdEFuYcDz5K3HGfbRRA>
X-ME-Received: <xmr:HodzaegR6OhmtZMVmsdrjok8Wga_INHcpxyiGNZyo1qlddLbtWNl0MDcOSRhNXBgnt4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeelfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffuhhsthihucforggs
    vgcuoeguuhhsthihseguuhhsthihmhgrsggvrdgtohhmqeenucggtffrrghtthgvrhhnpe
    elueetkeehffevveetleeiuedtleevgedvtedvueehleevfedttddujeelveeuhfenucff
    ohhmrghinhepshihshhtvghmugdrihhopdhgihhthhhusgdrtghomhdprhgvughhrghtrd
    gtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    ughushhthiesughushhthihmrggsvgdrtghomhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:Hodzae-QO8VoUBPPdP_oghZ8LP4iCU2yY19evgLXVEOQvRj-eHkkYA>
    <xmx:HodzaS9lDP5waEJzvA9Cz_VoPQmJCFn0ceBIfZeVTP_Gqhmydk8jMw>
    <xmx:HodzafA7LhkUTFxuCTvoxri0D-C87EvR3Cv51Ld_J4gxXoec6G2dwQ>
    <xmx:HodzaawuyLJhGFiJZqejwu-TTf72V7dg4ysewbo4T-VmK9-3-tE1ug>
    <xmx:HodzaSH6gTnRMip10Q0ITBG5Am5nzvqh-f6vbnv7NXJuHXE-tFOKBZF2>
Feedback-ID: i13394474:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 09:35:10 -0500 (EST)
From: Dusty Mabe <dusty@dustymabe.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] systemd: drop Wants=network-online.target for rpc-statd-notify
Date: Fri, 23 Jan 2026 09:35:03 -0500
Message-ID: <20260123143503.1342968-1-dusty@dustymabe.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[dustymabe.com:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[dustymabe.com];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-18352-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dusty@dustymabe.com,linux-nfs@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.962];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[dustymabe.com:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dustymabe.com:email,dustymabe.com:dkim,dustymabe.com:mid,nss-lookup.target:url,network-online.target:url]
X-Rspamd-Queue-Id: 5543D77230
X-Rspamd-Action: no action

Pulling in network-online.target by default is generally discouraged.
From [1]:

> It is strongly recommended not to make use of this target too liberally:
> for example network server software should generally not pull this in
> (since server software generally is happy to accept local connections
> even before any routable network interface is up). Its primary purpose
> is network client software that cannot operate without network.

On systems where nfs-client.target is enabled by default via presets
(this is the case on Fedora today) then nfs-client.target will pull in
rpc-statd-notify.service which will pull in network-online.target. This
is the case even if the user hasn't configured any NFS mounts.

The man page for sm-notify already mentions:

> Notifications are retried if sending fails, the remote does not respond,
> the remote's NSM service is not registered, or if there is a DNS failure
> which prevents the remote's mon_name from being resolved to an address.

So I would think it would be able to cope with a short period of time if
it were to start before Networking were fully online.

Making this change means if you are in an offline scenario (one example
is an install environment) then you won't have to wait for network-online.target
to timeout before the system comes up fully.

We originally discussed this problem over in [2], [3].

[1] https://systemd.io/NETWORK_ONLINE/
[2] https://github.com/coreos/fedora-coreos-config/pull/3530
[3] https://bugzilla.redhat.com/show_bug.cgi?id=2383585

Signed-off-by: Dusty Mabe <dusty@dustymabe.com>
---
 systemd/rpc-statd-notify.service | 1 -
 1 file changed, 1 deletion(-)

diff --git a/systemd/rpc-statd-notify.service b/systemd/rpc-statd-notify.service
index 962f18b2..821d4ea8 100644
--- a/systemd/rpc-statd-notify.service
+++ b/systemd/rpc-statd-notify.service
@@ -2,7 +2,6 @@
 Description=Notify NFS peers of a restart
 Documentation=man:sm-notify(8) man:rpc.statd(8)
 DefaultDependencies=no
-Wants=network-online.target
 After=local-fs.target network-online.target nss-lookup.target
 
 # if we run an nfs server, it needs to be running before we
-- 
2.51.1


