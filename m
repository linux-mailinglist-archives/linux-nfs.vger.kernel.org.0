Return-Path: <linux-nfs+bounces-5121-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAF293EAC4
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 03:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082BB1C20D97
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 01:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E9C14293;
	Mon, 29 Jul 2024 01:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e9GQme+7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pvB0mENW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e9GQme+7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pvB0mENW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3AC2AD22
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 01:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722217815; cv=none; b=ijSqo2EIm8raaEoK3341hL5fMnY+vbcXhZ3V/rrxJAdv6Xv95SqTu/UP6b1RxUTZVJ6PqOObPoEHIUCXXXa9C0gU1B+9mkC6WlSqMsfiob03AanqpAQyl9hgYt3nfN4M+6rjKKNYITvUaaQU4ZJBWnsUukWx0v3LTT7EJ4zNQWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722217815; c=relaxed/simple;
	bh=zHxR4foRknKCdtNAwEi9wsOlDn+gU9hltHdDHEAsIZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aK9CBjyRbtUElNE8wgkt0DweAp4xxUc3GMlQRQd5TWsxoaVxLYA13WWXV+oCRKiqw/sFROZg4QS44sJ72d36zuBlY2SlHX5dTOhV4/fGJHUG1UWpav/H2s/LoMO4QUgV8DgBpCjV6NwcXPMdchNmwrB2S5Q4vo6EMiz64j+k+2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e9GQme+7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pvB0mENW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e9GQme+7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pvB0mENW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2501621BBE;
	Mon, 29 Jul 2024 01:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722217806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbu9AcsdknPfp2wG06/7TrtTdSaxybOE5PEpW3iGHss=;
	b=e9GQme+7Q87NpGZYN7R41jb+d3qNpbpjBut031xfCM+1vXtmk9PexApVC2js5nB9Mci8B4
	yP1xVCyzmtb6LpAS5jLeRfO0NpwSlEKtFFz18Y1HTSsAAh3fGEjScuS/of7s+u4FGO6t3e
	t0hRFy5KE5sQnXyH5QIk+x9e0HSv2Es=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722217806;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbu9AcsdknPfp2wG06/7TrtTdSaxybOE5PEpW3iGHss=;
	b=pvB0mENWfVQihSSbpf0AnrQ6jDuU115DXXSLLNbHVEvUiFzAuwiDCzKj5qW1ohMyUVRPJ6
	dunTNxoaLolz5pBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=e9GQme+7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pvB0mENW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722217806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbu9AcsdknPfp2wG06/7TrtTdSaxybOE5PEpW3iGHss=;
	b=e9GQme+7Q87NpGZYN7R41jb+d3qNpbpjBut031xfCM+1vXtmk9PexApVC2js5nB9Mci8B4
	yP1xVCyzmtb6LpAS5jLeRfO0NpwSlEKtFFz18Y1HTSsAAh3fGEjScuS/of7s+u4FGO6t3e
	t0hRFy5KE5sQnXyH5QIk+x9e0HSv2Es=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722217806;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbu9AcsdknPfp2wG06/7TrtTdSaxybOE5PEpW3iGHss=;
	b=pvB0mENWfVQihSSbpf0AnrQ6jDuU115DXXSLLNbHVEvUiFzAuwiDCzKj5qW1ohMyUVRPJ6
	dunTNxoaLolz5pBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D66913704;
	Mon, 29 Jul 2024 01:50:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZDw6LUv1pmYNFwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 29 Jul 2024 01:50:03 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 2/3] nfsd: be more systematic about selecting error codes for internal use.
Date: Mon, 29 Jul 2024 11:47:23 +1000
Message-ID: <20240729014940.23053-3-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729014940.23053-1-neilb@suse.de>
References: <20240729014940.23053-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.81 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -1.81
X-Rspamd-Queue-Id: 2501621BBE

Rather than using ad hoc values for internal errors (30000, 11000, ...)
use 'enum' to sequentially allocated numbers starting from the first
known available number - now visible as NFS4ERR_FIRST_FREE.

The goal is values that are distinct from all be32 error codes.  To get
those we must first select integers that are not already used, then
convert them with cpu_to_be32().

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfsd.h       | 23 ++++++++++++++++++-----
 include/linux/nfs4.h | 17 ++++++++++-------
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 8f4f239d9f8a..593c34fd325a 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -326,17 +326,30 @@ void		nfsd_lockd_shutdown(void);
 #define nfserr_xattr2big		cpu_to_be32(NFS4ERR_XATTR2BIG)
 #define nfserr_noxattr			cpu_to_be32(NFS4ERR_NOXATTR)
 
-/* error codes for internal use */
+/* Error codes for internal use.  We use enum to choose numbers that are
+ * not already assigned, then covert to be32 resulting in a number that
+ * cannot conflict with any existing be32 nfserr value.
+ */
+enum {
+	NFSERR_DROPIT = NFS4ERR_FIRST_FREE,
 /* if a request fails due to kmalloc failure, it gets dropped.
  *  Client should resend eventually
  */
-#define	nfserr_dropit		cpu_to_be32(30000)
+#define	nfserr_dropit		cpu_to_be32(NFSERR_DROPIT)
+
 /* end-of-file indicator in readdir */
-#define	nfserr_eof		cpu_to_be32(30001)
+	NFSERR_EOF,
+#define	nfserr_eof		cpu_to_be32(NFSERR_EOF)
+
 /* replay detected */
-#define	nfserr_replay_me	cpu_to_be32(11001)
+	NFSERR_REPLAY_ME,
+#define	nfserr_replay_me	cpu_to_be32(NFSERR_REPLAY_ME)
+
 /* nfs41 replay detected */
-#define	nfserr_replay_cache	cpu_to_be32(11002)
+	NFSERR_REPLAY_CACHE,
+#define	nfserr_replay_cache	cpu_to_be32(NFSERR_REPLAY_CACHE)
+
+};
 
 /* Check for dir entries '.' and '..' */
 #define isdotent(n, l)	(l < 3 && n[0] == '.' && (l == 1 || n[1] == '.'))
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 0d896ce296ce..1ad794f81747 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -281,15 +281,18 @@ enum nfsstat4 {
 	/* nfs42 */
 	NFS4ERR_PARTNER_NOTSUPP	= 10088,
 	NFS4ERR_PARTNER_NO_AUTH	= 10089,
-	NFS4ERR_UNION_NOTSUPP = 10090,
-	NFS4ERR_OFFLOAD_DENIED = 10091,
-	NFS4ERR_WRONG_LFS = 10092,
-	NFS4ERR_BADLABEL = 10093,
-	NFS4ERR_OFFLOAD_NO_REQS = 10094,
+	NFS4ERR_UNION_NOTSUPP	= 10090,
+	NFS4ERR_OFFLOAD_DENIED	= 10091,
+	NFS4ERR_WRONG_LFS	= 10092,
+	NFS4ERR_BADLABEL	= 10093,
+	NFS4ERR_OFFLOAD_NO_REQS	= 10094,
 
 	/* xattr (RFC8276) */
-	NFS4ERR_NOXATTR        = 10095,
-	NFS4ERR_XATTR2BIG      = 10096,
+	NFS4ERR_NOXATTR		= 10095,
+	NFS4ERR_XATTR2BIG	= 10096,
+
+	/* can be used for internal errors */
+	NFS4ERR_FIRST_FREE
 };
 
 /* error codes for internal client use */
-- 
2.44.0


