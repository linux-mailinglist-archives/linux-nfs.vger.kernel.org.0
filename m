Return-Path: <linux-nfs+bounces-2075-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152C0862DDE
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Feb 2024 00:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318BE1C211E5
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Feb 2024 23:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FCF1B96E;
	Sun, 25 Feb 2024 23:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VehsQx0m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Uq+zAZ6/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VehsQx0m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Uq+zAZ6/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83211B964
	for <linux-nfs@vger.kernel.org>; Sun, 25 Feb 2024 23:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708904663; cv=none; b=YY5aneXUeLSAVdNjxtf6cnXldAWENkwLb5L0S6lRxj82t+sH2JVwYLtSbUH1BjAukYHv4pJpG6TIvY3FeumQ/WnavZZxnZmfRlfkMBl6PSnQjpGv4Iv0bB5I/ecb4UgUai2adHCAjGnWX95GLC5zyE9Btx7cASVfPUNKH8XZTMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708904663; c=relaxed/simple;
	bh=jIm9e2Z4CJRnyQ6s5JXC1LoGAX2uUvV4wyUJz3CMaDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tvy8Z3dy2AZ6qYz/5LJszHsmScIKFoosRw+QoXwee9qg0X3+2Pk9+xvNvhPoWTHrm6YgcW/DfLLSpG2pEYmGdsifhkrOIQgqyzwLYYmVy6plYntRtbB8LXXjruygCyDkPpbhwPgj0QHIhFeS8yeZuY89GwWIxnEHBykcHMOpNoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VehsQx0m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Uq+zAZ6/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VehsQx0m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Uq+zAZ6/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 01DC822406;
	Sun, 25 Feb 2024 23:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708904660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9QByWSZcUJXekfTHMEDghYbLydTMCRINWjIKVVagI0=;
	b=VehsQx0m5WNj8xtH8zLJfTQNSxR8QzihI32K+23Rpbpd+kEAhIy0kRyZgyTkP4CLSHMvta
	TmcFJdP3f/iTc5RE1gCvYCW9JEt0gJ5I1swlux3o1IzNDh1t4leH3TRL7qFjBwoFCBuvTe
	Dh2FBQm97tLmdvg8akCHqJAuOTJuArc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708904660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9QByWSZcUJXekfTHMEDghYbLydTMCRINWjIKVVagI0=;
	b=Uq+zAZ6/5278pf9woh99zwhptFNt7mfTpzloAgtDu33P2Ru4WEMjycyL+D7OecPG8MRfdt
	q/sJOCERRNsBRPDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708904660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9QByWSZcUJXekfTHMEDghYbLydTMCRINWjIKVVagI0=;
	b=VehsQx0m5WNj8xtH8zLJfTQNSxR8QzihI32K+23Rpbpd+kEAhIy0kRyZgyTkP4CLSHMvta
	TmcFJdP3f/iTc5RE1gCvYCW9JEt0gJ5I1swlux3o1IzNDh1t4leH3TRL7qFjBwoFCBuvTe
	Dh2FBQm97tLmdvg8akCHqJAuOTJuArc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708904660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9QByWSZcUJXekfTHMEDghYbLydTMCRINWjIKVVagI0=;
	b=Uq+zAZ6/5278pf9woh99zwhptFNt7mfTpzloAgtDu33P2Ru4WEMjycyL+D7OecPG8MRfdt
	q/sJOCERRNsBRPDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7981B13A89;
	Sun, 25 Feb 2024 23:44:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vrmSB9LQ22VKJAAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 25 Feb 2024 23:44:18 +0000
From: NeilBrown <neilb@suse.de>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org,
	Petr Vorel <pvorel@suse.cz>
Subject: [PATCH 2/3] Change local_rpcb() to take a targaddr pointer.
Date: Mon, 26 Feb 2024 10:40:49 +1100
Message-ID: <20240225234337.19744-3-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240225234337.19744-1-neilb@suse.de>
References: <20240225234337.19744-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VehsQx0m;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Uq+zAZ6/"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.48 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[50.51%]
X-Spam-Score: 3.48
X-Rspamd-Queue-Id: 01DC822406
X-Spam-Flag: NO

Two callers of local_rpcb() want the target-addr, and local_rcpb() has
easy access to it.  So accept a pointer and fill it in if not NULL.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 src/rpcb_clnt.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/src/rpcb_clnt.c b/src/rpcb_clnt.c
index 68fe69a320ff..f587580228ab 100644
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
@@ -541,7 +534,8 @@ getpmaphandle(nconf, hostname, tgtaddr)
  * rpcbind. Returns NULL on error and free's everything.
  */
 static CLIENT *
-local_rpcb()
+local_rpcb(targaddr)
+	char **targaddr;
 {
 	CLIENT *client;
 	static struct netconfig *loopnconf;
@@ -574,6 +568,8 @@ local_rpcb()
 	if (client != NULL) {
 		/* Mark the socket to be closed in destructor */
 		(void) CLNT_CONTROL(client, CLSET_FD_CLOSE, NULL);
+		if (targaddr)
+			*targaddr = strdup(sun.sun_path);
 		return client;
 	}
 
@@ -632,7 +628,7 @@ try_nconf:
 		endnetconfig(nc_handle);
 	}
 	mutex_unlock(&loopnconf_lock);
-	client = getclnthandle(hostname, loopnconf, NULL);
+	client = getclnthandle(hostname, loopnconf, targaddr);
 	return (client);
 }
 
@@ -661,20 +657,11 @@ rpcb_set(program, version, nconf, address)
 		rpc_createerr.cf_stat = RPC_UNKNOWNADDR;
 		return (FALSE);
 	}
-	client = local_rpcb();
+	client = local_rpcb(&parms.r_addr);
 	if (! client) {
 		return (FALSE);
 	}
 
-	/* convert to universal */
-	/*LINTED const castaway*/
-	parms.r_addr = taddr2uaddr((struct netconfig *) nconf,
-				   (struct netbuf *)address);
-	if (!parms.r_addr) {
-		CLNT_DESTROY(client);
-		rpc_createerr.cf_stat = RPC_N2AXLATEFAILURE;
-		return (FALSE); /* no universal address */
-	}
 	parms.r_prog = program;
 	parms.r_vers = version;
 	parms.r_netid = nconf->nc_netid;
@@ -712,7 +699,7 @@ rpcb_unset(program, version, nconf)
 	RPCB parms;
 	char uidbuf[32];
 
-	client = local_rpcb();
+	client = local_rpcb(NULL);
 	if (! client) {
 		return (FALSE);
 	}
@@ -1342,7 +1329,7 @@ rpcb_taddr2uaddr(nconf, taddr)
 		rpc_createerr.cf_stat = RPC_UNKNOWNADDR;
 		return (NULL);
 	}
-	client = local_rpcb();
+	client = local_rpcb(NULL);
 	if (! client) {
 		return (NULL);
 	}
@@ -1376,7 +1363,7 @@ rpcb_uaddr2taddr(nconf, uaddr)
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


