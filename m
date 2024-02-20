Return-Path: <linux-nfs+bounces-2039-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 894E085CC02
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Feb 2024 00:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1161A1F23088
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Feb 2024 23:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB03135416;
	Tue, 20 Feb 2024 23:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJHDeypq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F8978688
	for <linux-nfs@vger.kernel.org>; Tue, 20 Feb 2024 23:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708471539; cv=none; b=iIoXxlbLyp0o4T/vuhJx1PY3VG8MIVLdckLZN9ELSNfRFYZpE8JAFYrVyS7yfwQVnXGy6kiI/IMUtN2F3GLQ6Wucdanlvleufuv9A/Az0IorH+nrXEx3cLgJJq4HpItYIpEoOI0ezN+Bw4HbAZoli2rJ6MNi99N9hdOHEfkCmv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708471539; c=relaxed/simple;
	bh=ZHOUx3a+xiISeIHQXLSKD2vltzWzdRThAUb1N+zySv8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=heaN9eIo7Z3KLdyufEjeIBLGpFbxVqytFL78TIWaEmuVoVPxF2Wf9pkyTmL/PmT+SW1PlJXDcykJTVGYXLDM8swd0U0gMv9RX1MXs4bZDyxqY9vFDa5nauFHbpQ4H8iJg+UPku9UXXflbykxtdFOoM+ufs4MTW+0VVeium9NqR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJHDeypq; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7c00a2cbcf6so44620839f.1
        for <linux-nfs@vger.kernel.org>; Tue, 20 Feb 2024 15:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708471536; x=1709076336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sug0vNImuAWSG+GmF2B83FWtkE0MNqm+tH7c/TrsCnI=;
        b=GJHDeypqUjqYYpiwkoiZQDx8NvmGeX0l5Wzhvn2QUvUrSEfIskOieebTvgKRs414Sr
         AlpZ7ZXi8TxRE7DsQPRe6bPhgCdmbaeKLdEU2I7QQVyKxv0E84Xb893juYVl++oqHUNw
         hjWGuOTZJzRMpPy07UgSgMroXWp9vPkXUYko+kdSBiLu73stggC9ckd53KUt4H1MwkAP
         CXKFTkxCh556j0kE16PSGqLCWIZvB+FS3FeRRro57qoNUXBPTg+Oh+syajJMgiHzZvn3
         uzWStTTZDmrWbu3IkUS2WkUeaaixk3l4tpX/wbVtyy0czc44NMfB/+BG/kwfVEcaTunC
         9Iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708471536; x=1709076336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sug0vNImuAWSG+GmF2B83FWtkE0MNqm+tH7c/TrsCnI=;
        b=OjCKxMzVj2zPxQ0ALataodcuU61rLQNzdp+ismhYZkBo5k1Xdk932i7huY6IiXlqJW
         NSvxZ+ZeyfcDS6qnyJ38vqZzhfINjUBu7YqZdsxyi7sU0JM0duW0WIJwfwxqhLixcFyU
         83VW3nob15bpwoA4nCFWNHYmSKMeh4cR98Ma73QTIOb/90tfiuFMiZ4+20DoxiRV6I8j
         gUtfCbS/DZOD+/SBKmWk3fPO8/Ro2cjoRDEQLutqJ8hYw89YbSpyZJSQXI5cPfU+OaXj
         zBf7DOVoa0aAsAVoqBsTI6p7cnqijBNaplWA4xitY8DefR7D78AUOaL4gZAHh8v90R2Y
         MmZw==
X-Gm-Message-State: AOJu0Yzzy/aWO1ypB2tYFL26qqtJn4um3bNQ++77RH3ZyR68SdFeY84L
	ArtHCy6BT/8wWN3cjfx+ZkU7EE0lxSs8ylX62Bu/1INzVasEHMTeZqH78G4a
X-Google-Smtp-Source: AGHT+IGVpLIuXCLlEG7jA3LNUrur4py46lTEjXR8rb79shy5QY7Egde0BOuOGu55g0RqHEU9KkT39Q==
X-Received: by 2002:a05:6e02:1c42:b0:365:88b:3fc7 with SMTP id d2-20020a056e021c4200b00365088b3fc7mr14720423ilg.1.1708471536521;
        Tue, 20 Feb 2024 15:25:36 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:4074:22da:be59:defa])
        by smtp.gmail.com with ESMTPSA id bf18-20020a056e02309200b0036524b8c632sm1916517ilb.0.2024.02.20.15.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 15:25:35 -0800 (PST)
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
To: trond.myklebust@hammerspace.com,
	anna.schumaker@netapp.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFSv4.1/pnfs: fix NFS with TLS in pnfs
Date: Tue, 20 Feb 2024 18:25:34 -0500
Message-Id: <20240220232534.15724-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Olga Kornievskaia <kolga@netapp.com>

Currently, even though xprtsec=tls is specified and used for operations
to MDS, any operations that go to DS travel over unencrypted connection.
Or additionally, if more than 1 DS can serve the data, then trunked
connections are also done unencrypted.

IN GETDEVINCEINFO, we get an entry for the DS which carries a protocol
type (which is TCP), then nfs4_set_ds_client() gets called with TCP
instead of TCP with TLS.

Currently, each trunked connection is created and uses clp->cl_hostname
value which if TLS is used would get passed up in the handshake upcall,
but instead we need to pass in the appropriate trunked address value.

Fixes: c8407f2e560c ("NFS: Add an "xprtsec=" NFS mount option")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/pnfs_nfs.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index afd23910f3bf..88e061bd711b 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -919,6 +919,8 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 	dprintk("--> %s DS %s\n", __func__, ds->ds_remotestr);
 
 	list_for_each_entry(da, &ds->ds_addrs, da_node) {
+		char servername[48];
+
 		dprintk("%s: DS %s: trying address %s\n",
 			__func__, ds->ds_remotestr, da->da_remotestr);
 
@@ -929,6 +931,7 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 				.dstaddr = (struct sockaddr *)&da->da_addr,
 				.addrlen = da->da_addrlen,
 				.servername = clp->cl_hostname,
+				.xprtsec = clp->cl_xprtsec,
 			};
 			struct nfs4_add_xprt_data xprtdata = {
 				.clp = clp,
@@ -938,10 +941,45 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 				.data = &xprtdata,
 			};
 
-			if (da->da_transport != clp->cl_proto)
+			if (da->da_transport != clp->cl_proto &&
+					clp->cl_proto != XPRT_TRANSPORT_TCP_TLS)
 				continue;
+			if (da->da_transport == XPRT_TRANSPORT_TCP &&
+				mds_srv->nfs_client->cl_proto ==
+					XPRT_TRANSPORT_TCP_TLS) {
+				struct sockaddr *addr =
+					(struct sockaddr *)&da->da_addr;
+				struct sockaddr_in *sin =
+					(struct sockaddr_in *)&da->da_addr;
+				struct sockaddr_in6 *sin6 =
+					(struct sockaddr_in6 *)&da->da_addr;
+
+				/* for NFS with TLS we need to supply a correct
+				 * servername of the trunked transport, not the
+				 * servername of the main transport stored in
+				 * clp->cl_hostname. And set the protocol to
+				 * indicate to use TLS
+				 */
+				servername[0] = '\0';
+				switch(addr->sa_family) {
+				case AF_INET:
+					snprintf(servername, sizeof(servername),
+						"%pI4", &sin->sin_addr.s_addr);
+					break;
+				case AF_INET6:
+					snprintf(servername, sizeof(servername),
+						"%pI6", &sin6->sin6_addr);
+					break;
+				default:
+					/* do not consider this address */
+					continue;
+				}
+				xprt_args.ident = XPRT_TRANSPORT_TCP_TLS;
+				xprt_args.servername = servername;
+			}
 			if (da->da_addr.ss_family != clp->cl_addr.ss_family)
 				continue;
+
 			/**
 			* Test this address for session trunking and
 			* add as an alias
@@ -953,6 +991,10 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 			if (xprtdata.cred)
 				put_cred(xprtdata.cred);
 		} else {
+			if (da->da_transport == XPRT_TRANSPORT_TCP &&
+				mds_srv->nfs_client->cl_proto ==
+					XPRT_TRANSPORT_TCP_TLS)
+				da->da_transport = XPRT_TRANSPORT_TCP_TLS;
 			clp = nfs4_set_ds_client(mds_srv,
 						&da->da_addr,
 						da->da_addrlen,
-- 
2.43.0


