Return-Path: <linux-nfs+bounces-5055-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1417993CCB2
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 04:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357DB1C21798
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 02:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844AD18E11;
	Fri, 26 Jul 2024 02:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qnZp6g7F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7fwOKSVW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EspUoORz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ACHjHff8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0370320B
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 02:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721960759; cv=none; b=GMKNSNDOuOeDpOqwfSK/snIO/CeChl8CbDsRCHdg8KuWqZwEvDhfhVsOrHKLLUiJfa4AXqy2upB4h50P7nEi8Si9bAh1WgAdukvaFsj0/ZIBKKWuuA0lPtZLkEWHlE6cug3ChB4M1xvUgWXllT+Bw7d7sg36Jm9IkQ94U6WZeQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721960759; c=relaxed/simple;
	bh=KCF4czo+yUS88OAbBFiA+0GhX37hBNhElGgr/6wDIYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=frfvpGcAtOnNVbRqBbP8GnlgRzW1vBTYjIIUaJ6AC+fT5++WmC6GTI+gSQ5YEJMQ/335hWWTXyKWbvG6KKnYvADdHan6HnWpyVyk2SYLppngO83ITzLuV4ghhYaeVHX4u1WEARem79mbGWwJLAyar/E0so0ExJ/7OCSBL/gXsV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qnZp6g7F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7fwOKSVW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EspUoORz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ACHjHff8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D0717218BB;
	Fri, 26 Jul 2024 02:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721960756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXwqUNstSgtv7WxZQUaa53ufR4iWjPEjwaND782BzUA=;
	b=qnZp6g7FUU7JjACjom3W2+v21zQYgRrMHZ33xfKbHLOxIpw7VL8SYXg5S4eC0wucj3l9QQ
	f+BnQGv7Afjs0LyRCxTvHrTU/Hp8oh68acvcRztM+RtP11c1Z7hWhhaCJc/ChUWwUk60pw
	aw2ldlv1x7EMib+5BCJ4JJeGCaHnLfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721960756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXwqUNstSgtv7WxZQUaa53ufR4iWjPEjwaND782BzUA=;
	b=7fwOKSVWBtYLb24KzNaxArTKtzLKEkfe7iNdIPr3OyytKAtW30E38SU+A5nMCSFL5elsBC
	VdJ6VJMbqqYeYpBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EspUoORz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ACHjHff8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721960755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXwqUNstSgtv7WxZQUaa53ufR4iWjPEjwaND782BzUA=;
	b=EspUoORzzaRQzaSLeruTZMK0lzv53JqCMxnWDY7JILaWOUkyDP+vs9DgqTFHHK4j3eHicw
	Lpd2oe9SUX9NYPLBQz2HXWNAZuNYsTLbm6Ccx11W/TNDS88oOxI8mEmvnhNayDljxM1OhE
	xPLCcDHU2j2VGSgTtb15aNfRDCRt6WU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721960755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXwqUNstSgtv7WxZQUaa53ufR4iWjPEjwaND782BzUA=;
	b=ACHjHff8C3wYGUYI0Wq9bhMcjfH58eb6XI7CQl+AfbB9V5WjIXC44el9WViO0J1xp/lCXQ
	BU6jzE/ird5IRqAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B45F2138A7;
	Fri, 26 Jul 2024 02:25:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qxtDGjEJo2acWAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 26 Jul 2024 02:25:53 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 1/6] nfsd: Don't pass all of rqst into rqst_exp_find()
Date: Fri, 26 Jul 2024 12:21:30 +1000
Message-ID: <20240726022538.32076-2-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240726022538.32076-1-neilb@suse.de>
References: <20240726022538.32076-1-neilb@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
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
X-Rspamd-Queue-Id: D0717218BB

Rather than passing the whole rqst, pass the pieces that are actually
needed.  This makes the inputs to rqst_exp_find() more obvious.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/export.c   | 35 ++++++++++++++++++++++++++---------
 fs/nfsd/export.h   |  4 +++-
 fs/nfsd/nfs4proc.c |  4 +++-
 fs/nfsd/nfsfh.c    |  4 +++-
 4 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 50b3135d07ac..9aa5f95f18a8 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1164,19 +1164,35 @@ rqst_exp_get_by_name(struct svc_rqst *rqstp, struct path *path)
 	return gssexp;
 }
 
+/**
+ * rqst_exp_find - Find an svc_export in the context of a rqst or similar
+ * @reqp:	The handle to be used to suspend the request if a cache-upcall is needed
+ *		If NULL, missing in-cache information will result in failure.
+ * @net:	The network namespace in which the request exists
+ * @cl:		default auth_domain to use for looking up the export
+ * @gsscl:	an alternate auth_domain defined using deprecated gss/krb5 format.
+ * @fsid_type:	The type of fsid to look for
+ * @fsidv:	The actual fsid to look up in the context of either client.
+ *
+ * Perform a lookup for @cl/@fsidv in the given @net for an export.  If
+ * none found and @gsscl specified, repeat the lookup.
+ *
+ * Returns an export, or an error pointer.
+ */
 struct svc_export *
-rqst_exp_find(struct svc_rqst *rqstp, int fsid_type, u32 *fsidv)
+rqst_exp_find(struct cache_req *reqp, struct net *net,
+	      struct auth_domain *cl, struct auth_domain *gsscl,
+	      int fsid_type, u32 *fsidv)
 {
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_export *gssexp, *exp = ERR_PTR(-ENOENT);
-	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct cache_detail *cd = nn->svc_export_cache;
 
-	if (rqstp->rq_client == NULL)
+	if (!cl)
 		goto gss;
 
 	/* First try the auth_unix client: */
-	exp = exp_find(cd, rqstp->rq_client, fsid_type,
-		       fsidv, &rqstp->rq_chandle);
+	exp = exp_find(cd, cl, fsid_type, fsidv, reqp);
 	if (PTR_ERR(exp) == -ENOENT)
 		goto gss;
 	if (IS_ERR(exp))
@@ -1186,10 +1202,9 @@ rqst_exp_find(struct svc_rqst *rqstp, int fsid_type, u32 *fsidv)
 		return exp;
 gss:
 	/* Otherwise, try falling back on gss client */
-	if (rqstp->rq_gssclient == NULL)
+	if (!gsscl)
 		return exp;
-	gssexp = exp_find(cd, rqstp->rq_gssclient, fsid_type, fsidv,
-						&rqstp->rq_chandle);
+	gssexp = exp_find(cd, gsscl, fsid_type, fsidv, reqp);
 	if (PTR_ERR(gssexp) == -ENOENT)
 		return exp;
 	if (!IS_ERR(exp))
@@ -1220,7 +1235,9 @@ struct svc_export *rqst_find_fsidzero_export(struct svc_rqst *rqstp)
 
 	mk_fsid(FSID_NUM, fsidv, 0, 0, 0, NULL);
 
-	return rqst_exp_find(rqstp, FSID_NUM, fsidv);
+	return rqst_exp_find(&rqstp->rq_chandle, SVC_NET(rqstp),
+			     rqstp->rq_client, rqstp->rq_gssclient,
+			     FSID_NUM, fsidv);
 }
 
 /*
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index ca9dc230ae3d..cb17f05e3329 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -127,6 +127,8 @@ static inline struct svc_export *exp_get(struct svc_export *exp)
 	cache_get(&exp->h);
 	return exp;
 }
-struct svc_export * rqst_exp_find(struct svc_rqst *, int, u32 *);
+struct svc_export *rqst_exp_find(struct cache_req *reqp, struct net *net,
+				 struct auth_domain *cl, struct auth_domain *gsscl,
+				 int fsid_type, u32 *fsidv);
 
 #endif /* NFSD_EXPORT_H */
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 46bd20fe5c0f..d5ed01c72910 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2231,7 +2231,9 @@ nfsd4_getdeviceinfo(struct svc_rqst *rqstp,
 		return nfserr_noent;
 	}
 
-	exp = rqst_exp_find(rqstp, map->fsid_type, map->fsid);
+	exp = rqst_exp_find(&rqstp->rq_chandle, SVC_NET(rqstp),
+			    rqstp->rq_client, rqstp->rq_gssclient,
+			    map->fsid_type, map->fsid);
 	if (IS_ERR(exp)) {
 		dprintk("%s: could not find device id\n", __func__);
 		return nfserr_noent;
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 0b75305fb5f5..4ebb3c334cc2 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -195,7 +195,9 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 	data_left -= len;
 	if (data_left < 0)
 		return error;
-	exp = rqst_exp_find(rqstp, fh->fh_fsid_type, fh->fh_fsid);
+	exp = rqst_exp_find(&rqstp->rq_chandle, SVC_NET(rqstp),
+			    rqstp->rq_client, rqstp->rq_gssclient,
+			    fh->fh_fsid_type, fh->fh_fsid);
 	fid = (struct fid *)(fh->fh_fsid + len);
 
 	error = nfserr_stale;
-- 
2.44.0


