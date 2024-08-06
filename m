Return-Path: <linux-nfs+bounces-5248-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBF9949C7F
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Aug 2024 01:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B56F1F24232
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2024 23:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2C016EB63;
	Tue,  6 Aug 2024 23:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K5Q+G8aj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JXg1vP7L";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K5Q+G8aj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JXg1vP7L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0891F166F14
	for <linux-nfs@vger.kernel.org>; Tue,  6 Aug 2024 23:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722988417; cv=none; b=XV1r9XuxTCrlXylq5SYWZWRYgog49khzYEseSuUCxpH0CSwlvfS4xXiuHWuSItd0KTX8YMF+5LUdiaBIoZ/+5U2TpE2PGuV2HOKVkpl8QCUJ6x9KOmFtKJ2Tf1+uYCbAtwUvZRSZ0slKNEbUX0ewJAJixzDSB7b92VoFQ8L3yrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722988417; c=relaxed/simple;
	bh=BTJ6NDd0MiTKgCuE0A6ljrw9qX/ucjwWbZNnvbYEObw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=SJVNqAzfNtpcHmA2Ww+qyyrzrYTXIayfDNsP1nHhJC8chSvphQf+u39aDyV4fdIDsKGZIOI7nFGNrPweoy5pPv/vf3TAdT2jdoMH8TEnmOH3mOa2qSmjNw3BEI0lhMLjdiZs+mtmNIjcT+RIDhZiwny9E4JY+IUzVe34aC+e+0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K5Q+G8aj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JXg1vP7L; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K5Q+G8aj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JXg1vP7L; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1C9F921C1D;
	Tue,  6 Aug 2024 23:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722988414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HWflPNlcOseARn/6BAbOIUymGOecSj6ch122bvenNfM=;
	b=K5Q+G8ajKxLFdor45sSw2bqd+wmg2bwYQiaueYjNRsAAT8eqyf8sjy15SfpMp1kyUioFL4
	0U6T3ySHqL0EjW9Y6WFHJWdloj4pri/InNa6/81v5mi0xHhdslj6nqRJ7sQLO6i7rLW0N0
	e0KQrgwZ/47nv66zDT2nlLhwMSyU0P0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722988414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HWflPNlcOseARn/6BAbOIUymGOecSj6ch122bvenNfM=;
	b=JXg1vP7L7IMVKI1Jc2Y8pqKJEwKqGcoDC6JlWMoRgUc2fH/PI+WJplJ0pbsVg+NKiND9C6
	03tb5gvaB+inxABg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722988414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HWflPNlcOseARn/6BAbOIUymGOecSj6ch122bvenNfM=;
	b=K5Q+G8ajKxLFdor45sSw2bqd+wmg2bwYQiaueYjNRsAAT8eqyf8sjy15SfpMp1kyUioFL4
	0U6T3ySHqL0EjW9Y6WFHJWdloj4pri/InNa6/81v5mi0xHhdslj6nqRJ7sQLO6i7rLW0N0
	e0KQrgwZ/47nv66zDT2nlLhwMSyU0P0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722988414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HWflPNlcOseARn/6BAbOIUymGOecSj6ch122bvenNfM=;
	b=JXg1vP7L7IMVKI1Jc2Y8pqKJEwKqGcoDC6JlWMoRgUc2fH/PI+WJplJ0pbsVg+NKiND9C6
	03tb5gvaB+inxABg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D749513929;
	Tue,  6 Aug 2024 23:53:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5Qt/Iny3smb3cQAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 06 Aug 2024 23:53:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] SQUASH nfsd: don't allocate the versions array
Date: Wed, 07 Aug 2024 09:53:25 +1000
Message-id: <172298840561.6062.13050352142637689126@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO
X-Spam-Level: 



In "nfsd: don't allocate the versions array" I made the various arrays
of version information fixed-sized - except nfsd_version.
The size of nfsd_version was determined by  CONFIG settings and could be
smaller than the index used by nfsd_support_version().

This patch makes it fixed-size.  It should be squashed into the original.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfssvc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 1cef09a3c78e..defc430f912f 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -106,7 +106,7 @@ static struct svc_program	nfsd_acl_program = {
 
 #endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
 
-static const struct svc_version *nfsd_version[] = {
+static const struct svc_version *nfsd_version[NFSD_MAXVERS+1] = {
 #if defined(CONFIG_NFSD_V2)
 	[2] = &nfsd_version2,
 #endif
-- 
2.44.0


