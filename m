Return-Path: <linux-nfs+bounces-18700-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DVkGn47g2ngjwMAu9opvQ
	(envelope-from <linux-nfs+bounces-18700-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 13:28:46 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA01E5CA7
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 13:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7503F30065F8
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 12:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D9E3EDAC5;
	Wed,  4 Feb 2026 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G70RzMiE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91355332EB3
	for <linux-nfs@vger.kernel.org>; Wed,  4 Feb 2026 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770208124; cv=none; b=kRyWm5rFFKs9TNsWsP1KFlu+bH4z58ly7hxjjMC5G41MQOMsN52oo9Hn2rC0rgNqxNyM6roHnGWGG0Uoxb7BoYKbEd/d7aTjWHMcZLWFy76VAxbngXPxJpQm9a1I+RYi0nCpX37zUdeysWCn2nSR72BKpfuKKl1Le5jbsdeKDjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770208124; c=relaxed/simple;
	bh=i8AUGvBvkTzhwqZHQHuhPo+dTr0+tIQKV2gLZxA02qk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uONMZi9lQPGPHIZMslnsgN1bSwi5F9X5ToJ2ZunA4Tqz1Ft1SwHJK7QLI8mjRceg/xFZiB1XBGo2qMXQKDR+6NCHo0QBwlE1/52WFZiISWVt++Y4drcpKwJgiyezK5CV/cmFOf1Qh/r0jQlQObb0QiNuzz/snJJqyWwYU1dNjmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G70RzMiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3B4C19422;
	Wed,  4 Feb 2026 12:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770208124;
	bh=i8AUGvBvkTzhwqZHQHuhPo+dTr0+tIQKV2gLZxA02qk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G70RzMiEsD1ffu/ynAb3RGGtbRq3N6IbpgmaGwRrw+1YPfdSs0oVbQJYrGgOo8AQB
	 MJqL3FfJQBnIm08hYq2KP59ozOrGHxaSpYyEczp6D/ZlNdD9UkBc+3/x8ZozpM0S02
	 6tPzdi4nTfujGgAd2WGfbnVBai5p/R5XhHXiuDUFUyLZpjtj5UqaoARe6c6QxmEg3V
	 A7B5+XeqznGJlCiCUGVxxetO1OFjfxk2u5yOlgU0QSgZoR/YdVr6AMYzxTnjMZ4RkS
	 z+Ua/IqgtTZbVr28v2TEDGGQKk7iY6vVzhVbUoIwrctRHnUoZpQi6v7Xfo3Oj1Kc7I
	 stRjxpREamNOA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 04 Feb 2026 07:28:28 -0500
Subject: [PATCH nfs-utils 3/3] nfsdctl: remove unneeded newlines from
 xlog() format strings
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-minthreads-v1-3-9f348608f884@kernel.org>
References: <20260204-minthreads-v1-0-9f348608f884@kernel.org>
In-Reply-To: <20260204-minthreads-v1-0-9f348608f884@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Ben Coddington <bcodding@hammerspace.com>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1707; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=i8AUGvBvkTzhwqZHQHuhPo+dTr0+tIQKV2gLZxA02qk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpgzt5wnG9olKP/3TVaMpGx3QITcae94p0UYfuj
 +YHWJCwY+WJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaYM7eQAKCRAADmhBGVaC
 FXDED/0apV4NK3bLeXLaYgKk94ntGpbBSq/3R7WoTEcUF9vHC6DYah1of1jV0tYxGQ6LFIZEC8W
 Rh/3ieZYOHUVGuXpxX6mv4hbPWaKv9z/Gada69lT7WlYI2Nf9U+2wMlMIq5fS5y4ziPe1noBcWU
 V05g4Qp5kWQOTRmOEoPLY0akb5oZfkxyuKs7T2DcUd0OAocDAU1CxgIuLC8dNx8YvkZv+IQ/r/7
 DiuGu9LTMe1ftchnIQoHBMlUtqAvjfOtC2XWCY2vxTIs98NFxid6wGpoAn/ioHWBZZJi0N+QxVr
 85pqwCmRh9OTlLM0YAjMgZ6Er+Xl6Bjto/ZMFC0FsNaXN7o9a2CkMNHSswTxNyo2s269HC7HXPs
 edXouYn3glTJUphAEB96i1KTTP3JMIpCuBJrNY3nm2yE4IgT65IjQiR0JMh5sWuJu6E20mKUtEi
 eRSEA/TpGOGlDJDWT5PyNsBZ2gBlIbMjDmGVKlJjfDS7iw0X1sBVi0mHprsWfE18c8btFX5YHO+
 4+EOaqI6gT+GcCsGy5dIplm0dpYFZ4H+bCGCjvtIlJpN1aJrvDoJ6Imd5czHNT5OBHn3V+s9Cyg
 UodEMTztlyCTdzrzsgcmfWiJI5G+iwo2yv11aXS+dnLETPratsJ5Eot9FzkUkVN09SVUYNTOjZj
 SeLWcAk5EpWu5JA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18700-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0FA01E5CA7
X-Rspamd-Action: no action

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 utils/nfsdctl/nfsdctl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 68c93039f3440a73285fd3f1e8b1131c1c945efb..250b6f6d962d33986a2a7d809f001ad3dca52da2 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -1528,14 +1528,14 @@ static int lockd_config_doit(struct nl_sock *sock, int cmd, int grace, int tcppo
 
 	cb = nl_cb_alloc(NL_CB_CUSTOM);
 	if (!cb) {
-		xlog(L_ERROR, "failed to allocate netlink callbacks\n");
+		xlog(L_ERROR, "failed to allocate netlink callbacks");
 		ret = 1;
 		goto out;
 	}
 
 	ret = nl_send_auto(sock, msg);
 	if (ret < 0) {
-		xlog(L_ERROR, "send failed (%d)!\n", ret);
+		xlog(L_ERROR, "send failed (%d)!", ret);
 		goto out_cb;
 	}
 
@@ -1548,7 +1548,7 @@ static int lockd_config_doit(struct nl_sock *sock, int cmd, int grace, int tcppo
 	while (ret > 0)
 		nl_recvmsgs(sock, cb);
 	if (ret < 0) {
-		xlog(L_ERROR, "Error: %s\n", strerror(-ret));
+		xlog(L_ERROR, "Error: %s", strerror(-ret));
 		ret = 1;
 	}
 out_cb:
@@ -1568,7 +1568,7 @@ static int get_service(const char *svc)
 
 	ret = getaddrinfo(NULL, svc, &hints, &res);
 	if (ret) {
-		xlog(L_ERROR, "getaddrinfo of \"%s\" failed: %s\n",
+		xlog(L_ERROR, "getaddrinfo of \"%s\" failed: %s",
 			svc, gai_strerror(ret));
 		return -1;
 	}
@@ -1589,7 +1589,7 @@ static int get_service(const char *svc)
 		}
 		break;
 	default:
-		xlog(L_ERROR, "Bad address family: %d\n", res->ai_family);
+		xlog(L_ERROR, "Bad address family: %d", res->ai_family);
 		port = -1;
 	}
 	freeaddrinfo(res);

-- 
2.52.0


