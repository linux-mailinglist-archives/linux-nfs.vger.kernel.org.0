Return-Path: <linux-nfs+bounces-6063-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CE796683E
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 19:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FEE51F21E67
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 17:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB061B78E8;
	Fri, 30 Aug 2024 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sY5kazTe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eX3m9FGB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sY5kazTe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eX3m9FGB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7312B1C6A5
	for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2024 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725039837; cv=none; b=X+YUAJAIgyzctynRfQ0v4VfeZQOI3Q1xJt2FHw67PJHyFTI7AT34po0IwlgF57gI/64gkJQOcFAODl0DqmXDRh5V2ttdtbNa893lOXltNtTDtUBZNbgEfNx8urQUCwZrXWcEGMDfXK+xKud1pLqQbf0FD8fKv/BiCQFXZiGgwks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725039837; c=relaxed/simple;
	bh=9xP1E2e9Oy5jW847QH7ONfxuYm1lQq2FDk9LGduRG/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SI9IckuacmZ/PMMcXvob5JhSuewbeGOdBw27YI4L833EQJvMP4ybMcWbKuRLkMbrsbCZvtr95QTyh3m/hP3JvwoTP15KTp+JLDwgN82bBdTNPkkGxNtG++O9U6FythLTdKgzHT75WxFrzUIZlkl2Oqrd3k6bJOgMEutgU6/9+IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sY5kazTe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eX3m9FGB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sY5kazTe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eX3m9FGB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5E58C21A32;
	Fri, 30 Aug 2024 17:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725039833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8+WMN03hZfGW5WYlB4kFNIgfvfchV9MMIzgzWecs2js=;
	b=sY5kazTez3dX3jYxDlUfC3is+OjcdzPsTCpq78TZzNerC2jQP1eNLSGgjxGMhW1biHLeTA
	EMniCDmw0mhlQ0VgqCbRIeLkSsqcsrtsVVzwU6EM7ehjfHRbKBG1FaSa8qM6KLmHZvo38z
	yBZYLiPeMQZD5MdVRx39HRZJnccJy+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725039833;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8+WMN03hZfGW5WYlB4kFNIgfvfchV9MMIzgzWecs2js=;
	b=eX3m9FGBhswJBUwU9j0jfva/vHXgAR5h3e+MFeFOP/Ash9MhyMqG+dcKMtED/lidFvuTgn
	r2YV6rsnEhXMpOAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sY5kazTe;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eX3m9FGB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725039833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8+WMN03hZfGW5WYlB4kFNIgfvfchV9MMIzgzWecs2js=;
	b=sY5kazTez3dX3jYxDlUfC3is+OjcdzPsTCpq78TZzNerC2jQP1eNLSGgjxGMhW1biHLeTA
	EMniCDmw0mhlQ0VgqCbRIeLkSsqcsrtsVVzwU6EM7ehjfHRbKBG1FaSa8qM6KLmHZvo38z
	yBZYLiPeMQZD5MdVRx39HRZJnccJy+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725039833;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8+WMN03hZfGW5WYlB4kFNIgfvfchV9MMIzgzWecs2js=;
	b=eX3m9FGBhswJBUwU9j0jfva/vHXgAR5h3e+MFeFOP/Ash9MhyMqG+dcKMtED/lidFvuTgn
	r2YV6rsnEhXMpOAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F96513A3D;
	Fri, 30 Aug 2024 17:43:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d6VFBtkE0mb7IgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 30 Aug 2024 17:43:53 +0000
From: Petr Vorel <pvorel@suse.cz>
To: linux-nfs@vger.kernel.org
Cc: libtirpc-devel@lists.sourceforge.net,
	Petr Vorel <pvorel@suse.cz>,
	Steve Dickson <SteveD@RedHat.com>,
	Josue Ortega <josue@debian.org>,
	NeilBrown <neilb@suse.de>,
	Thomas Blume <Thomas.Blume@suse.com>,
	Yann Leprince <yann.leprince@ylep.fr>
Subject: [PATCH libtirpc 1/1] Move rpcbind.sock to /run
Date: Fri, 30 Aug 2024 19:43:35 +0200
Message-ID: <20240830174335.89678-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5E58C21A32
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Most of the distros have /var/run as symlink to /run.

Because /var may be a separate partition, and could even be mounted via
NFS, having to look directly to /run help to avoid issues rpcbind
startup early in boot when /var might not be available.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Follow up for rpcbind patch which touches rpcbind.lock location.

Kind regards,
Petr

 tirpc/rpc/rpcb_prot.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tirpc/rpc/rpcb_prot.h b/tirpc/rpc/rpcb_prot.h
index eb3a0c4..06138bc 100644
--- a/tirpc/rpc/rpcb_prot.h
+++ b/tirpc/rpc/rpcb_prot.h
@@ -476,8 +476,8 @@ extern bool_t xdr_netbuf(XDR *, struct netbuf *);
 #define RPCBVERS_3 RPCBVERS
 #define RPCBVERS_4 RPCBVERS4
 
-#define _PATH_RPCBINDSOCK "/var/run/rpcbind.sock"
-#define _PATH_RPCBINDSOCK_ABSTRACT "\0/run/rpcbind.sock"
+#define _PATH_RPCBINDSOCK "/run/rpcbind.sock"
+#define _PATH_RPCBINDSOCK_ABSTRACT "\0" _PATH_RPCBINDSOCK
 
 #else /* ndef _KERNEL */
 #ifdef __cplusplus
-- 
2.45.2


