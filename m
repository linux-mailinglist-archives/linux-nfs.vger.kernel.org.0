Return-Path: <linux-nfs+bounces-2133-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFF886D827
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Mar 2024 01:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1890D1F23174
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Mar 2024 00:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA0C365;
	Fri,  1 Mar 2024 00:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Prjnlh8R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yrOlbXaj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eqqIioZV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="epNwi7KV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB825384
	for <linux-nfs@vger.kernel.org>; Fri,  1 Mar 2024 00:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709251824; cv=none; b=CwYXSf3QUAxD6XG+1lAnpdjtjcGyLkWlQfa4Gn05yXkPVtAGc0rcFj1H57WGJh/2jOELC9RNzi/VxcrmWpE7oex6e9fWcKVtexzLvPE8QV0hnDIAHC/+kj/ykluuO92mFaNnEG72mI834z2jwBDM/d8DciB+X6HbnmbUvVMHhuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709251824; c=relaxed/simple;
	bh=aLBNSdV6iVvF+w6WPD283bORe+Hh7tlShxRIvk54TZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAL9UUBBlf1dmVpRcJzbGtjgjgJO3FPu4N4u4k2mkUT0+1WjzwftXKwHIoiqxAPNDy5EW1QoRUjp3/XYzsbxzEH7MMhBO/w+ZaFfq3XUPgiGS/maYg/p6Cd0sDsBsmgH4oYK/fJBPa73wGJuqNL8aGsSx8W1Z/6Hthr/4d1U0EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Prjnlh8R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yrOlbXaj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eqqIioZV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=epNwi7KV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F30171F821;
	Fri,  1 Mar 2024 00:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709251821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmEqQd8n9zeincJNeY3kwPoL1y7+9v2BJ70vP/sqOow=;
	b=Prjnlh8R6J9yIi4OxOKgITqdK+T9GHz+bSV5/DNZSMY5hHeYYGuS5JtvQLOTmr/CGVEA7u
	nj9u94Ey3l5rsfvDnJrqeC/3O6Brpuv9hTl5QH1axa1HT4JuXCItaN7L5TgQ/U78kBXNlI
	xrMaOECBiDpps8LCgqaBCu1royCkCvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709251821;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmEqQd8n9zeincJNeY3kwPoL1y7+9v2BJ70vP/sqOow=;
	b=yrOlbXajpq19VilG4GJagdsxXfbKWbLvZ2v0RX6grvmCAk2lbSvyfPgS3/5JreGUVtQly/
	GA3Hh5EbHwu2yxBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709251820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmEqQd8n9zeincJNeY3kwPoL1y7+9v2BJ70vP/sqOow=;
	b=eqqIioZV+YeG3YLcBk6uLDEln8sbZDqMMUUEXaoHAVgXR6dl2JxTElelmcj81O4NRKu9Nn
	Xt56QN8z8fmVrT3Xw2MJiZ0yRE5iKC5ojeyl0t4swQ8adcqywqWO8i0gscuVcyIVT2cM5+
	4eGdYHvO4JVCQb+YmVzaHdvU9/0oNEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709251820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmEqQd8n9zeincJNeY3kwPoL1y7+9v2BJ70vP/sqOow=;
	b=epNwi7KV/myzhgGuUWHhN+axDnyL3c0R5wDw3zsFliW7x0HO5GqFyvYtlMhWqb9k2r8msM
	2PRcqrSZdBzlvRAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B42DF13AB0;
	Fri,  1 Mar 2024 00:10:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0i7rGOoc4WW8JwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 01 Mar 2024 00:10:18 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 3/3] nfsd: drop st_mutex_mutex before calling move_to_close_lru()
Date: Fri,  1 Mar 2024 11:07:39 +1100
Message-ID: <20240301000950.2306-4-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240301000950.2306-1-neilb@suse.de>
References: <20240301000950.2306-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

move_to_close_lru() is currently called with ->st_mutex held.
This can lead to a deadlock as move_to_close_lru() waits for sc_count to
drop to 2, and some threads holding a reference might be waiting for the
mutex.  These references will never be dropped so sc_count will never
reach 2.

There can be no harm in dropping ->st_mutex before
move_to_close_lru() because the only place that takes the mutex is
nfsd4_lock_ol_stateid(), and it quickly aborts if sc_type is
NFS4_CLOSED_STID, which it will be before move_to_close_lru() is called.

See also
 https://lore.kernel.org/lkml/4dd1fe21e11344e5969bb112e954affb@jd.com/T/
where this problem was raised but not successfully resolved.

Signed-off-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 5dab316932d3..bb0f563cb2d2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7015,7 +7015,7 @@ nfsd4_open_downgrade(struct svc_rqst *rqstp,
 	return status;
 }
 
-static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
+static bool nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
 {
 	struct nfs4_client *clp = s->st_stid.sc_client;
 	bool unhashed;
@@ -7032,11 +7032,11 @@ static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
 		list_for_each_entry(stp, &reaplist, st_locks)
 			nfs4_free_cpntf_statelist(clp->net, &stp->st_stid);
 		free_ol_stateid_reaplist(&reaplist);
+		return false;
 	} else {
 		spin_unlock(&clp->cl_lock);
 		free_ol_stateid_reaplist(&reaplist);
-		if (unhashed)
-			move_to_close_lru(s, clp->net);
+		return unhashed;
 	}
 }
 
@@ -7052,6 +7052,7 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfs4_ol_stateid *stp;
 	struct net *net = SVC_NET(rqstp);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	bool need_move_to_close_list;
 
 	dprintk("NFSD: nfsd4_close on file %pd\n", 
 			cstate->current_fh.fh_dentry);
@@ -7074,8 +7075,10 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 */
 	nfs4_inc_and_copy_stateid(&close->cl_stateid, &stp->st_stid);
 
-	nfsd4_close_open_stateid(stp);
+	need_move_to_close_list = nfsd4_close_open_stateid(stp);
 	mutex_unlock(&stp->st_mutex);
+	if (need_move_to_close_list)
+		move_to_close_lru(stp, net);
 
 	/* v4.1+ suggests that we send a special stateid in here, since the
 	 * clients should just ignore this anyway. Since this is not useful
-- 
2.43.0


