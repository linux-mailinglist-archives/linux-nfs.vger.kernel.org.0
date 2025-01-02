Return-Path: <linux-nfs+bounces-8885-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFC6A0013D
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 23:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36EC160FE8
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 22:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D5E19CC0A;
	Thu,  2 Jan 2025 22:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Asy1Xw4W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E9B1957FF
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jan 2025 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735857676; cv=none; b=IoT6ofauo2SXtLK5AD6Y8hrIMajHAPV2MrAWlEOBvPpqbnWWLZulAOAHGZMCsl83CbBySHURSpdIghkM++558N6fSSjDZnWvvlQyb1+TB9XuPuvpTxvUgmUWRkYLWwkI96gz6x9Oa24C9H8RuQFhCMeXk4JoNO0THkqOvBd35V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735857676; c=relaxed/simple;
	bh=Fuzi2OciZrSNsNSQ08UYUJdh93KN5h4C4nLvFXcXx18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AoFQivVAFAQV9MNFGJ3KnXNN3TUSBfQoZo1BNR28cAXtrF2LeXwKKUZSlQ0HyJT7B/VFOOKVCLx5ZwHhRd7lj9Qk252aKorG7ng7Y61I8csNoDC22EmsldXSZZ9I7DuKA/aeBvwdCyP5SkYHK4/cKWCKGFNdRI9ofNMMOMc8rZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Asy1Xw4W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735857673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0pTRbGywa5WzHoiyB0mz8z/JEsavG6nP8Dp0JqkYJdU=;
	b=Asy1Xw4WY2f3tFrIt20pMIRnzBq3nyxvW8I2fdT5knQ5HwD3A+vjnGAvmzUVaEAqJonuup
	o48Zci2Nk6mg61Jn1QP9x7zOgIbWJnrnZ+o8kPI69/w5DQ9YeIaal/ZgWv/GQKP6G4n4UZ
	aoN9/4aqkxJr4lcx66wT/Wqy12bxCNw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-2xUnushSMDuN72em0w16jg-1; Thu,
 02 Jan 2025 17:41:12 -0500
X-MC-Unique: 2xUnushSMDuN72em0w16jg-1
X-Mimecast-MFC-AGG-ID: 2xUnushSMDuN72em0w16jg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 571AF19560A2
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jan 2025 22:41:11 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.80.211])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0547B1956052;
	Thu,  2 Jan 2025 22:41:11 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 842D52E9164;
	Thu, 02 Jan 2025 17:41:09 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH] conffile: add 'arg' argument to conf_remove_now()
Date: Thu,  2 Jan 2025 17:41:09 -0500
Message-ID: <20250102224109.634190-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Commit 9350a97a added an optional 'arg' to section names, but the logic
to remove configurations wasn't updated to check the 'arg' argument.
This wasn't really a problem until commit 15e17993 updated
conf_parse_line() to call conf_set() with override=1, the end result
being that we'll only remember the last value seen for any given
section/tag combination.

Fixes: 9350a97a ("Added an conditional argument to the Section names")
Fixes: 15e17993 ("conffile: process config.d directory config files.")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 support/nfs/conffile.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/support/nfs/conffile.c b/support/nfs/conffile.c
index 1e9c22b5..137fac8d 100644
--- a/support/nfs/conffile.c
+++ b/support/nfs/conffile.c
@@ -169,13 +169,15 @@ static void free_conftrans(struct conf_trans *ct)
  * Insert a tag-value combination from LINE (the equal sign is at POS)
  */
 static int
-conf_remove_now(const char *section, const char *tag)
+conf_remove_now(const char *section, const char *arg, const char *tag)
 {
 	struct conf_binding *cb, *next;
 
 	cb = LIST_FIRST(&conf_bindings[conf_hash (section)]);
 	for (; cb; cb = next) {
 		next = LIST_NEXT(cb, link);
+		if (arg && (cb->arg == NULL || strcasecmp(arg, cb->arg) != 0))
+			continue;
 		if (strcasecmp(cb->section, section) == 0
 				&& strcasecmp(cb->tag, tag) == 0) {
 			LIST_REMOVE(cb, link);
@@ -217,7 +219,7 @@ conf_set_now(const char *section, const char *arg, const char *tag,
 	struct conf_binding *node = 0;
 
 	if (override)
-		conf_remove_now(section, tag);
+		conf_remove_now(section, arg, tag);
 	else if (conf_get_section(section, arg, tag)) {
 		if (!is_default) {
 			xlog(LOG_INFO, "conf_set: duplicate tag [%s]:%s, ignoring...",
@@ -1254,7 +1256,7 @@ conf_end(int transaction, int commit)
 						node->is_default);
 					break;
 				case CONF_REMOVE:
-					conf_remove_now(node->section, node->tag);
+					conf_remove_now(node->section, node->arg, node->tag);
 					break;
 				case CONF_REMOVE_SECTION:
 					conf_remove_section_now(node->section);
-- 
2.45.2


