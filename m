Return-Path: <linux-nfs+bounces-12086-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B454ACD6AF
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 05:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B09178124
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 03:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6DC2609F5;
	Wed,  4 Jun 2025 03:48:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id B818770838;
	Wed,  4 Jun 2025 03:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749008935; cv=none; b=sIWQlYcMoNQVA4RfvO52Q576zeZKfnfxSLD0P2yAMXz/gSE7xjFZXNioOCImal4gxYWUkjpenwrHF0XkODvVr+1ZWyflomQgRoKXgUwWJ6Mbjoeg5Age3fRgOP90HnpNc7DsyvdtK00njlb5wDbeen9MnaTc5eJTHZWiFvE4Du8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749008935; c=relaxed/simple;
	bh=p1azAzD1JQm81XfjGQoJVYO2dhg0xi6TF9uyuTGkfnw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ri1eeYXZbGXitgJ1RMhAJnS2b6vza8qGOqStRB8mfVS1c7Ue60PA+XU1Ghwdb6UMAho829CcmuXO50rCbkDgpE3Dk/3ZYh8XylZf3J4cfSXq+dQOposbV3diNQk3GpnQK6dSic5mHrsC95TPF065DPMKFN1vGaABZSWDX02kf/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from longsh.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id E26EB6018DA57;
	Wed,  4 Jun 2025 11:48:35 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Cc: Su Hui <suhui@nfschina.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2] nfsd: Change the type of ek_fsidtype from int to u8 and use kstrtou8
Date: Wed,  4 Jun 2025 11:47:26 +0800
Message-Id: <20250604034725.450911-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The valid values for ek_fsidtype are actually 0-7 so it's better to
change the type to u8. Also using kstrtou8() to relpace simple_strtoul(),
kstrtou8() is safer and more suitable for u8.

Signed-off-by: Su Hui <suhui@nfschina.com>
Suggested-by: NeilBrown <neil@brown.name>
---
v2:
 - change the type of ek_fsidtype to u8 and using kstrtou8.
v1:
 - https://lore.kernel.org/all/20250527092548.1931636-1-suhui@nfschina.com/

ps: I don't add the v1 patch's review tag because it's very different
between v1 and v2.

 fs/nfsd/export.c | 8 +++-----
 fs/nfsd/export.h | 2 +-
 fs/nfsd/trace.h  | 4 ++--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 88ae410b4113..cadfc2bae60e 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -82,8 +82,7 @@ static int expkey_parse(struct cache_detail *cd, char *mesg, int mlen)
 	int len;
 	struct auth_domain *dom = NULL;
 	int err;
-	int fsidtype;
-	char *ep;
+	u8 fsidtype;
 	struct svc_expkey key;
 	struct svc_expkey *ek = NULL;
 
@@ -109,10 +108,9 @@ static int expkey_parse(struct cache_detail *cd, char *mesg, int mlen)
 	err = -EINVAL;
 	if (qword_get(&mesg, buf, PAGE_SIZE) <= 0)
 		goto out;
-	fsidtype = simple_strtoul(buf, &ep, 10);
-	if (*ep)
+	if (kstrtou8(buf, 10, &fsidtype))
 		goto out;
-	dprintk("found fsidtype %d\n", fsidtype);
+	dprintk("found fsidtype %u\n", fsidtype);
 	if (key_len(fsidtype)==0) /* invalid type */
 		goto out;
 	if ((len=qword_get(&mesg, buf, PAGE_SIZE)) <= 0)
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index 4d92b99c1ffd..b9c0adb3ce09 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -88,7 +88,7 @@ struct svc_expkey {
 	struct cache_head	h;
 
 	struct auth_domain *	ek_client;
-	int			ek_fsidtype;
+	u8			ek_fsidtype;
 	u32			ek_fsid[6];
 
 	struct path		ek_path;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 3c5505ef5e3a..b244c6b3e905 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -344,7 +344,7 @@ TRACE_EVENT(nfsd_exp_find_key,
 		 int status),
 	TP_ARGS(key, status),
 	TP_STRUCT__entry(
-		__field(int, fsidtype)
+		__field(u8, fsidtype)
 		__array(u32, fsid, 6)
 		__string(auth_domain, key->ek_client->name)
 		__field(int, status)
@@ -367,7 +367,7 @@ TRACE_EVENT(nfsd_expkey_update,
 	TP_PROTO(const struct svc_expkey *key, const char *exp_path),
 	TP_ARGS(key, exp_path),
 	TP_STRUCT__entry(
-		__field(int, fsidtype)
+		__field(u8, fsidtype)
 		__array(u32, fsid, 6)
 		__string(auth_domain, key->ek_client->name)
 		__string(path, exp_path)
-- 
2.30.2


