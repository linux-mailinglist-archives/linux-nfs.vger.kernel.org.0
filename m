Return-Path: <linux-nfs+bounces-21933-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGrMEDQLFWpPSQcAu9opvQ
	(envelope-from <linux-nfs+bounces-21933-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 04:53:40 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1C15D0267
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 04:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE6A3302AE11
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 02:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D56330647;
	Tue, 26 May 2026 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Mz6c+29R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB52F531F
	for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 02:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779763891; cv=none; b=RP2GVezVHOD5pPsdcZpA0Pf1vfY0kQFIKl+avRG+SPixIC5Y1bvhIf3Y9AQzybfCaT12RjDqYbdoTGK7y8S65u28dLBWsJAXpwYzEeaePb6Y2AF16marKJM+nnkwa1WAinhnHSyVmT7mHr29DkmFUaeDZ6ORY4EEV8OZBstyF24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779763891; c=relaxed/simple;
	bh=Ho+HlrPFBy8qa2a+HEGAE9MzY+aW+fop09yQ4/QZGjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JOMghj37/bRYTsCbK3mGNx1I8VX2XJm2k2k4pxZ5lFowNZzy3rT1MbKPkQSVy+Av3pJf/UTP6dQotIc2OvoXCL3U00UFyeDXAm+ToSs35lVxuR29ofofvrJGLQcOyTr/VOFJQEYBtocd5EsRG2bTj4a/SKtiOzR496R3tX/kGJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Mz6c+29R; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=YC
	BKbTJ9864MA2moZn+Bf1xWteHI9DdnUuHUvjRE89M=; b=Mz6c+29RQ1jNgMff4P
	zib8iVKR1YWP8z/+67b7BzI5ZeEhe5gXmTQaDv7JUoz8NNB5ueBECuXhKo2p85c2
	lMfNL8FdKtpeG8wysULa2zOHhCmrUqEF0Jn2JCV50mJq07rnSIS4IE+gwTb/edpj
	WiZ9x/NY6/gk4anOUxRJK9zeY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDHtjWdChVqVLStDQ--.45926S2;
	Tue, 26 May 2026 10:51:15 +0800 (CST)
From: xu18736995897@163.com
To: linux-nfs@vger.kernel.org
Cc: xuchenchen <xuchenchen@kylinos.cn>
Subject: [PATCH nfs-utils] libnfsidmap: avoid malloc(0) for empty Local-Realms
Date: Mon, 25 May 2026 19:51:03 -0700
Message-ID: <20260526025103.5461-1-xu18736995897@163.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHtjWdChVqVLStDQ--.45926S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Gw15Cw4kurWrJF1ruFWDCFg_yoW8Jr4rpF
	Zag3Wqkrs0gr18Z3s7JryDJayjv3ZrXr9rWr43W3s3Aw4YqFnrXw4IkFn0qryUZrWfKFW3
	Ar4jgFW5Ca15Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UnL0rUUUUU=
X-CM-SenderInfo: t0xrmlytwzmkqyzxqiywtou0bp/xtbC1AOKaGoVCqPr-wAA33
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21933-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xu18736995897@163.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4C1C15D0267
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: xuchenchen <xuchenchen@kylinos.cn>

conf_get_list() can return an empty list when Local-Realms is present
but contains only empty fields, such as ", ,". In that case the Realms
list logging path computes a buffer size of zero and then writes a NUL
byte to the result of malloc(0).

Reserve space for the terminating NUL byte and use calloc() so the log
buffer is valid even when the realm list is empty.

Signed-off-by: xuchenchen <xuchenchen@kylinos.cn>
---
 support/nfsidmap/libnfsidmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/support/nfsidmap/libnfsidmap.c b/support/nfsidmap/libnfsidmap.c
index 0a912e52..16a79f00 100644
--- a/support/nfsidmap/libnfsidmap.c
+++ b/support/nfsidmap/libnfsidmap.c
@@ -404,15 +404,14 @@ int nfs4_init_name_mapping(char *conffile)
 	if (idmap_verbosity >= 1) {
 		struct conf_list_node *r;
 		char *buf = NULL;
-		int siz=0;
+		size_t siz = 1;
 
 		if (local_realms) {
 			TAILQ_FOREACH(r, &local_realms->fields, link) {
 				siz += (strlen(r->field)+4);
 			}
-			buf = malloc(siz);
+			buf = calloc(1, siz);
 			if (buf) {
-				*buf = 0;
 				TAILQ_FOREACH(r, &local_realms->fields, link) {
 					sprintf(buf+strlen(buf), "'%s' ", r->field);
 				}
-- 
2.47.3


