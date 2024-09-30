Return-Path: <linux-nfs+bounces-6723-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DB798AA41
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 18:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EFCD1F22F27
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 16:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DED194A63;
	Mon, 30 Sep 2024 16:46:50 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501681946AA
	for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2024 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714810; cv=none; b=Ht0lWWRmrc98nVb/DP03s/LcYHfwjg/n4AUmTIHr8OX9CmjfvwnSOKs0sFHNQWipiPbQwXw4Y29FhPS8oiG8oPuELMzdxr9YGWkmlOISlWnqmXNhtzH3WrhPdKekzDM9pnSIsOAb+Y8w6PxLabrHMs8f1KgbMV9w6fEKjZxcSew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714810; c=relaxed/simple;
	bh=Zb7197YfQ1LtCHlCEuSs83CLgWL9vDqTe3kpj30t1aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0iMxhNmTPlgD+e8aKn0qJX1oJ9tmhovrXxYZmpyzJORHBsxm/r5zUF4imcywiSVLGxanIT73iH7BcSpQINdHk1b79sVrFqayuuzv79yQpfP/wh3KhK7Qc6zWTPOOZ1ZQinh7Fi/h8BPyvXn/0HRii7EXTiyAm9cs9cm9YM9GwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7ae491dacaeso216966785a.0
        for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2024 09:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727714805; x=1728319605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Jaa8pTMl+D82RaEzEBQKGKge5rXQ6ce3oiw9nF6IRA=;
        b=DgizOqStw+XxW18Jh527W1Ue6xS8SVbL0YNek8vIZ0dplfmkSAqFDcRpqAmLqqFac2
         Woz0ADKEiXK3G2O8J9eHeBJ48rm/HjM+H/suhcO9amPhCCeUAR6apW3hhycJGCmQlnME
         oozwVGvfO0eC6wU3JCWp7847TMMQu1Vf+sSockB86kAwTp5BwjpEhp5dhnf8w4aVgYik
         CKwDcD15gbfutrJIy+A5GTaS07fii+249SeGRoNhCHZ2VGsgLjLQ00pZzUbgofl95zM9
         Bfm+YBBIb4snBuF378HUzcofOaMZ6vGDGTKvjwmsQ51d/imBAykfAkLp/cqOKrIYCO2o
         TRnQ==
X-Gm-Message-State: AOJu0Ywj4TJAO5aILzDfRi5/aNZLCI0F1L1KRxTQLlm+4d60HZgsLeoH
	jkDvd11iG1F+IqZWfPDqYx4fx7UQPR8AF8gjQfUHGDRrZS3d2sOkwtlk+HR3M18cgBgaY23HFyh
	9WIrnrzk7Am973e42VKpq3AEv+AVOphGNiz8uclkks67t9kWYx9u918cWBdYQnAQ9Q6Ad1bI57z
	CEwPd7so30NOKWlodQt0f0pcHmibNg8hnmv2iJs+w=
X-Google-Smtp-Source: AGHT+IGB18ynqGISsGgKTtC35akWh+vg6ooGj5uOLlF18K2l4OEdE7rKdeDCXOKznZpSSONKzO4P/w==
X-Received: by 2002:a05:620a:2544:b0:7a9:ac2d:597d with SMTP id af79cd13be357-7ae378dd8fbmr1875268185a.56.1727714805146;
        Mon, 30 Sep 2024 09:46:45 -0700 (PDT)
Received: from localhost (pool-68-160-145-92.bstnma.fios.verizon.net. [68.160.145.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae377f0a29sm427096385a.63.2024.09.30.09.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 09:46:42 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	Matthew Wilcox <willy@infradead.org>
Subject: [6.12-rc2 PATCH 1/5] nfs_common: fix race in NFS calls to nfsd_file_put_local() and nfsd_serv_put()
Date: Mon, 30 Sep 2024 12:46:33 -0400
Message-ID: <20240930164637.8300-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240930164637.8300-1-snitzer@kernel.org>
References: <20240930164637.8300-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add nfs_to_nfsd_file_put_local() interface to fix race with nfsd
module unload.  Similarly, use RCU around nfs_open_local_fh()'s error
path call to nfs_to->nfsd_serv_put().  Holding RCU ensures that NFS
will safely _call and return_ from its nfs_to calls into the NFSD
functions nfsd_file_put_local() and nfsd_serv_put().

Otherwise, if RCU isn't used then there is a narrow window when NFS's
reference for the nfsd_file and nfsd_serv are dropped and the NFSD
module could be unloaded, which could result in a crash from the
return instruction for either nfs_to->nfsd_file_put_local() or
nfs_to->nfsd_serv_put().

Reported-by: NeilBrown <neilb@suse.de>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c           |  6 +++---
 fs/nfs_common/nfslocalio.c |  5 ++++-
 fs/nfsd/filecache.c        |  2 +-
 fs/nfsd/localio.c          |  2 +-
 fs/nfsd/nfssvc.c           |  4 ++--
 include/linux/nfslocalio.h | 15 +++++++++++++++
 6 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index c29cdf51c458..d124c265b8fd 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -341,7 +341,7 @@ nfs_local_pgio_release(struct nfs_local_kiocb *iocb)
 {
 	struct nfs_pgio_header *hdr = iocb->hdr;
 
-	nfs_to->nfsd_file_put_local(iocb->localio);
+	nfs_to_nfsd_file_put_local(iocb->localio);
 	nfs_local_iocb_free(iocb);
 	nfs_local_hdr_release(hdr, hdr->task.tk_ops);
 }
@@ -622,7 +622,7 @@ int nfs_local_doio(struct nfs_client *clp, struct nfsd_file *localio,
 	}
 out:
 	if (status != 0) {
-		nfs_to->nfsd_file_put_local(localio);
+		nfs_to_nfsd_file_put_local(localio);
 		hdr->task.tk_status = status;
 		nfs_local_hdr_release(hdr, call_ops);
 	}
@@ -673,7 +673,7 @@ nfs_local_release_commit_data(struct nfsd_file *localio,
 		struct nfs_commit_data *data,
 		const struct rpc_call_ops *call_ops)
 {
-	nfs_to->nfsd_file_put_local(localio);
+	nfs_to_nfsd_file_put_local(localio);
 	call_ops->rpc_call_done(&data->task, data);
 	call_ops->rpc_release(data);
 }
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 42b479b9191f..5c8ce5066c16 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -142,8 +142,11 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
 	/* We have an implied reference to net thanks to nfsd_serv_try_get */
 	localio = nfs_to->nfsd_open_local_fh(net, uuid->dom, rpc_clnt,
 					     cred, nfs_fh, fmode);
-	if (IS_ERR(localio))
+	if (IS_ERR(localio)) {
+		rcu_read_lock();
 		nfs_to->nfsd_serv_put(net);
+		rcu_read_unlock();
+	}
 	return localio;
 }
 EXPORT_SYMBOL_GPL(nfs_open_local_fh);
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 19bb88c7eebd..53070e1de3d9 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -398,7 +398,7 @@ nfsd_file_put(struct nfsd_file *nf)
  * reference to the associated nn->nfsd_serv.
  */
 void
-nfsd_file_put_local(struct nfsd_file *nf)
+nfsd_file_put_local(struct nfsd_file *nf) __must_hold(rcu)
 {
 	struct net *net = nf->nf_net;
 
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 291e9c69cae4..f441cb9f74d5 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -53,7 +53,7 @@ void nfsd_localio_ops_init(void)
  *
  * On successful return, returned nfsd_file will have its nf_net member
  * set. Caller (NFS client) is responsible for calling nfsd_serv_put and
- * nfsd_file_put (via nfs_to->nfsd_file_put_local).
+ * nfsd_file_put (via nfs_to_nfsd_file_put_local).
  */
 struct nfsd_file *
 nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index e236135ddc63..47172b407be8 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -214,14 +214,14 @@ int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change
 	return 0;
 }
 
-bool nfsd_serv_try_get(struct net *net)
+bool nfsd_serv_try_get(struct net *net) __must_hold(rcu)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	return (nn && percpu_ref_tryget_live(&nn->nfsd_serv_ref));
 }
 
-void nfsd_serv_put(struct net *net)
+void nfsd_serv_put(struct net *net) __must_hold(rcu)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index b353abe00357..b0dd9b1eef4f 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -65,10 +65,25 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *,
 		   struct rpc_clnt *, const struct cred *,
 		   const struct nfs_fh *, const fmode_t);
 
+static inline void nfs_to_nfsd_file_put_local(struct nfsd_file *localio)
+{
+	/*
+	 * Once reference to nfsd_serv is dropped, NFSD could be
+	 * unloaded, so ensure safe return from nfsd_file_put_local()
+	 * by always taking RCU.
+	 */
+	rcu_read_lock();
+	nfs_to->nfsd_file_put_local(localio);
+	rcu_read_unlock();
+}
+
 #else   /* CONFIG_NFS_LOCALIO */
 static inline void nfsd_localio_ops_init(void)
 {
 }
+static inline void nfs_to_nfsd_file_put_local(struct nfsd_file *localio)
+{
+}
 #endif  /* CONFIG_NFS_LOCALIO */
 
 #endif  /* __LINUX_NFSLOCALIO_H */
-- 
2.44.0


