Return-Path: <linux-nfs+bounces-2255-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE056877999
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Mar 2024 02:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6463B280E35
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Mar 2024 01:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D9AECC;
	Mon, 11 Mar 2024 01:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KpidfEZt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MB5r/lUm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KpidfEZt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MB5r/lUm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574C5EBE
	for <linux-nfs@vger.kernel.org>; Mon, 11 Mar 2024 01:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710121432; cv=none; b=ABMZbF43km40NZn2X/4NPF36KxWX0n1Pz57BWZzv8ejlc9HoQCX0kV3HBymhbyweP13FYETaPmjzpsYEuAo83e7OH9pd14ZKhO1uTDRPC5FqzdQ5XcE3wEtABTIL8PFnucEEubToeYw7bCFqmsNwSv9IDSIvMuz3FJfRzzQON44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710121432; c=relaxed/simple;
	bh=zMYVPkJ6fKe23n3DnO9szLDPCDjQYXFFwXcfjXrKu0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyHbHrCREIjdMkbytxSpJmqSqC+D7fpYdlPGUbGttq+MvL9aPabudpXYa7ZVNPoG2AtOkfF+0QOKvoXw8FT4/ORkwGp0EEHtKtulQTv70+i2HJ+2NHavcU5AhQ3AoFywBz/3QA3C47MIoFvfi/qyitBoY+XMzLv5HKRvD4uWO7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KpidfEZt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MB5r/lUm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KpidfEZt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MB5r/lUm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 96FB3346B3;
	Mon, 11 Mar 2024 01:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710121428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lk5231PrOoELxfmUgA7KpAl8ElTh4tkKIFDGD0inmHI=;
	b=KpidfEZt4NWRjvjoXR/ntyYf5rssMjtEdKvfB1qQvF73el9kLRU9jR+xM+1HkUwiNaI2zB
	8Q2F+8rmDecrq09nfsNtgggHHlInrKpnZ6JYy97r0lvO6p+up0NGFz9IHtnTYHb82HKSFk
	WcmGM+4v6wlm6qumRsshL1n8DVxAsac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710121428;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lk5231PrOoELxfmUgA7KpAl8ElTh4tkKIFDGD0inmHI=;
	b=MB5r/lUmmwe4bWangNGSSP/emmoNR7+njDzRF2nNuZJgW8UuSSaKIznzHo829if2ej/Usq
	1i5nsdfIPgRLoSAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710121428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lk5231PrOoELxfmUgA7KpAl8ElTh4tkKIFDGD0inmHI=;
	b=KpidfEZt4NWRjvjoXR/ntyYf5rssMjtEdKvfB1qQvF73el9kLRU9jR+xM+1HkUwiNaI2zB
	8Q2F+8rmDecrq09nfsNtgggHHlInrKpnZ6JYy97r0lvO6p+up0NGFz9IHtnTYHb82HKSFk
	WcmGM+4v6wlm6qumRsshL1n8DVxAsac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710121428;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lk5231PrOoELxfmUgA7KpAl8ElTh4tkKIFDGD0inmHI=;
	b=MB5r/lUmmwe4bWangNGSSP/emmoNR7+njDzRF2nNuZJgW8UuSSaKIznzHo829if2ej/Usq
	1i5nsdfIPgRLoSAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 782E9134AB;
	Mon, 11 Mar 2024 01:43:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jhNnB9Nh7mX2fgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 11 Mar 2024 01:43:47 +0000
From: NeilBrown <neilb@suse.de>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] Change local_rpcb() to take a targaddr pointer.
Date: Mon, 11 Mar 2024 12:41:17 +1100
Message-ID: <20240311014327.19692-3-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311014327.19692-1-neilb@suse.de>
References: <20240311014327.19692-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KpidfEZt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="MB5r/lUm"
X-Spamd-Result: default: False [4.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[38.48%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: 4.69
X-Spam-Level: ****
X-Rspamd-Queue-Id: 96FB3346B3
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

One caller of local_rpcb() wants the target-addr, and local_rcpb() has
easy access to it.  So accept a pointer and fill it in if not NULL.

This will simplify a future patch in which local_rpcb() makes a choice
between different possible socket paths.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 src/rpcb_clnt.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/src/rpcb_clnt.c b/src/rpcb_clnt.c
index 68fe69a320ff..2ed6ee65f8d6 100644
--- a/src/rpcb_clnt.c
+++ b/src/rpcb_clnt.c
@@ -89,7 +89,7 @@ static struct address_cache *copy_of_cached(const char *, char *);
 static void delete_cache(struct netbuf *);
 static void add_cache(const char *, const char *, struct netbuf *, char *);
 static CLIENT *getclnthandle(const char *, const struct netconfig *, char **);
-static CLIENT *local_rpcb(void);
+static CLIENT *local_rpcb(char **targaddr);
 #ifdef NOTUSED
 static struct netbuf *got_entry(rpcb_entry_list_ptr, const struct netconfig *);
 #endif
@@ -430,19 +430,12 @@ getclnthandle(host, nconf, targaddr)
 	    nconf->nc_netid, si.si_af, si.si_proto, si.si_socktype));
 
 	if (nconf->nc_protofmly != NULL && strcmp(nconf->nc_protofmly, NC_LOOPBACK) == 0) {
-		client = local_rpcb();
+		client = local_rpcb(targaddr);
 		if (! client) {
 			LIBTIRPC_DEBUG(1, ("getclnthandle: %s", 
 				clnt_spcreateerror("local_rpcb failed")));
 			goto out_err;
 		} else {
-			struct sockaddr_un sun;
-
-			if (targaddr) {
-				*targaddr = malloc(sizeof(sun.sun_path));
-				strncpy(*targaddr, _PATH_RPCBINDSOCK,
-				    sizeof(sun.sun_path));
-			}
 			return (client);
 		}
 	} else {
@@ -492,6 +485,8 @@ getclnthandle(host, nconf, targaddr)
 	if (res)
 		freeaddrinfo(res);
 out_err:
+	if (client && targaddr &&!*targaddr)
+		fprintf(stderr, "No targaddr provided\n");
 	if (!client && targaddr)
 		free(*targaddr);
 	return (client);
@@ -541,7 +536,8 @@ getpmaphandle(nconf, hostname, tgtaddr)
  * rpcbind. Returns NULL on error and free's everything.
  */
 static CLIENT *
-local_rpcb()
+local_rpcb(targaddr)
+	char **targaddr;
 {
 	CLIENT *client;
 	static struct netconfig *loopnconf;
@@ -574,6 +570,8 @@ local_rpcb()
 	if (client != NULL) {
 		/* Mark the socket to be closed in destructor */
 		(void) CLNT_CONTROL(client, CLSET_FD_CLOSE, NULL);
+		if (targaddr)
+			*targaddr = strdup(sun.sun_path);
 		return client;
 	}
 
@@ -632,7 +630,7 @@ try_nconf:
 		endnetconfig(nc_handle);
 	}
 	mutex_unlock(&loopnconf_lock);
-	client = getclnthandle(hostname, loopnconf, NULL);
+	client = getclnthandle(hostname, loopnconf, targaddr);
 	return (client);
 }
 
@@ -661,7 +659,7 @@ rpcb_set(program, version, nconf, address)
 		rpc_createerr.cf_stat = RPC_UNKNOWNADDR;
 		return (FALSE);
 	}
-	client = local_rpcb();
+	client = local_rpcb(NULL);
 	if (! client) {
 		return (FALSE);
 	}
@@ -712,7 +710,7 @@ rpcb_unset(program, version, nconf)
 	RPCB parms;
 	char uidbuf[32];
 
-	client = local_rpcb();
+	client = local_rpcb(NULL);
 	if (! client) {
 		return (FALSE);
 	}
@@ -1342,7 +1340,7 @@ rpcb_taddr2uaddr(nconf, taddr)
 		rpc_createerr.cf_stat = RPC_UNKNOWNADDR;
 		return (NULL);
 	}
-	client = local_rpcb();
+	client = local_rpcb(NULL);
 	if (! client) {
 		return (NULL);
 	}
@@ -1376,7 +1374,7 @@ rpcb_uaddr2taddr(nconf, uaddr)
 		rpc_createerr.cf_stat = RPC_UNKNOWNADDR;
 		return (NULL);
 	}
-	client = local_rpcb();
+	client = local_rpcb(NULL);
 	if (! client) {
 		return (NULL);
 	}
-- 
2.43.0


