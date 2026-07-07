Return-Path: <linux-nfs+bounces-23155-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ERnNGGFoTWrozQEAu9opvQ
	(envelope-from <linux-nfs+bounces-23155-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 22:58:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F6571FA98
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 22:58:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="VPLr3q/I";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23155-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23155-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CF36302207B
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2026 20:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8747730B529;
	Tue,  7 Jul 2026 20:58:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB7530C167
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jul 2026 20:57:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783457880; cv=none; b=joCugarC37jcUh5XyKD0aL75fg1eWksCCnTvBm1hkNFu6eNc4gRathGTqdMvcUgKOJq0CcIv9SDO2yWY2A/ZoQ7+YnyqpGIaFEljK8Dnre87PskmGO2wThXKfmdJT9rvdXGzY1MgA2sUt1ugi++bP9Q+S5nWc2cCDY4BfmDzFwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783457880; c=relaxed/simple;
	bh=xV6iiy/Wpt8EZJBE7TNQfGbT5ik0pV2Ngcs1myeR154=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9Tu8M8Jppbc+HkjlOEZE0x/3gx9VDCbbr54Di16j6FvgVBApfc/Om6e28dQrKdLCpjAlJakXDo16LyRLJvihWpx2IQ9UwTiHrTEQksjIC/H2rVuLR6bSssqBa2axQT5XaGdM/QU1xpW0mbVPTzZaUPiYneSYiTTh9dAMLAiw/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VPLr3q/I; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783457878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjCg1gYNBaeHDfpCJ2W4Q2H+lknLDt+n4KBWopvpsSg=;
	b=VPLr3q/IW5lcF1UakGmOM9TBZ83L7gxHTCQ6LboTI85m0zxalj49RIiydm9xf2+PC9ys3U
	Dle74aeVugVNM8Qte3LXYJjvoY0BYzb7y+FKBs44Tk2L9wxyDcfYsMHXM6faZIThnoEMDO
	7+oU3/oBRSfbep2tYTMw5ZhRJvJuQP4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-QDty1wuBO7aD3fgFaYqfSg-1; Tue,
 07 Jul 2026 16:57:55 -0400
X-MC-Unique: QDty1wuBO7aD3fgFaYqfSg-1
X-Mimecast-MFC-AGG-ID: QDty1wuBO7aD3fgFaYqfSg_1783457874
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 184A019541B4;
	Tue,  7 Jul 2026 20:57:54 +0000 (UTC)
Received: from smayhew-thinkpadp1gen4i.remote.csb (unknown [10.22.80.127])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8418E1955F1C;
	Tue,  7 Jul 2026 20:57:53 +0000 (UTC)
Received: from smayhew-thinkpadp1gen4i.remote.csb (localhost [IPv6:::1])
	by smayhew-thinkpadp1gen4i.remote.csb (Postfix) with ESMTP id F26374D4C115;
	Tue, 07 Jul 2026 16:57:52 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: jlayton@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH 2/3] nfs.conf: add no-netlink option to exportd and mountd stanzas
Date: Tue,  7 Jul 2026 16:57:51 -0400
Message-ID: <20260707205752.313031-3-smayhew@redhat.com>
In-Reply-To: <20260707205752.313031-1-smayhew@redhat.com>
References: <20260707205752.313031-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:steved@redhat.com,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23155-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A5F6571FA98

This option was added by commit 60c38383 ("mountd/exportd/exportfs:
add --no-netlink option to disable netlink"), but nfs.conf was not
updated.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 nfs.conf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/nfs.conf b/nfs.conf
index 84cc653f..fa12c592 100644
--- a/nfs.conf
+++ b/nfs.conf
@@ -43,6 +43,8 @@
 # threads=1
 # cache-use-ipaddr=n
 # ttl=1800
+# no-netlink=0
+#
 [mountd]
 # debug="all|auth|call|general|parse"
 # apply-root-cred=n
@@ -55,6 +57,7 @@
 # ha-callout=
 # cache-use-ipaddr=n
 # ttl=1800
+# no-netlink=0
 #
 [nfsdcld]
 # debug=0
-- 
2.55.0


