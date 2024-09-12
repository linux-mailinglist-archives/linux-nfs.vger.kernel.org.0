Return-Path: <linux-nfs+bounces-6422-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8742D97741B
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 00:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC811C24158
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 22:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4E11BDA94;
	Thu, 12 Sep 2024 22:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="The2V6he"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81FA192B96;
	Thu, 12 Sep 2024 22:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726179047; cv=none; b=GayvuQZF4LYXRxOcglianceN1DGBg5T9IE3uSxYy9B+vs20/mBz+RsEzz4tZCVl4vyr/y/1diiPcCKWIcuTuGecmYa20x6kKLf7Lrf5GER70uWDDyHVZXdzGtmrOD+zlaL4OMSQ91FScn5+xP5MpufUxBzo1yc89yGYX7IT6UEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726179047; c=relaxed/simple;
	bh=mEDHQ5nWdcgdLUwd9qLHksx71AmMq8JsmHTzNaVTjjM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TlnvNHDPFlekPP4WtYf4RjYck/msXjiR/7ellQ4e9O7NhLwNicWn9b0RfCgbNbbla2EWeTWZi2Oe62JAvuHyvkc/x7hLmjrkMm8XwTZqrOyEgvUp/nynP3Wy6M76wyqt3RCe6ZkhqHXJ1Kexq0VVXFc4GaghQVwR5UN2Ayra7S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=The2V6he; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EA5C4CEC3;
	Thu, 12 Sep 2024 22:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726179046;
	bh=mEDHQ5nWdcgdLUwd9qLHksx71AmMq8JsmHTzNaVTjjM=;
	h=From:To:Cc:Subject:Date:From;
	b=The2V6he5yYQCB7bVDPRImCupIklcLBCAK+RStsUpOFQb0KBzYLBNZ3vqtOlerWk9
	 RIxBwKoJNmg9j8mIg376Wpf46FU+t9vZrisPdJ2Y70x5RLpnsthk/Qib0N618KB4M4
	 EEf4JYV+TARUDXfe8dCgAsoh/4AUyCoPDJmbNAFpWSbpFVVGHYvzAfuy0IcfvY75Xa
	 j4DLGmX28Pck6dS5G+0xcK80oYCvogsrmKC4CiNt/tnQef2WOa1mf+HZ0EEcEt81bM
	 qwyNNB/QfMOZKlExEw3vGVE8F1KT967yFVdBwBXbDRTwWU3Etkep7fZR9uY+HBT21B
	 rwesOjNvXAqXw==
Received: by pali.im (Postfix)
	id BC4425E9; Fri, 13 Sep 2024 00:10:41 +0200 (CEST)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd: Fill NFSv4.1 server implementation fields in OP_EXCHANGE_ID response
Date: Fri, 13 Sep 2024 00:09:19 +0200
Message-Id: <20240912220919.23449-1-pali@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

NFSv4.1 OP_EXCHANGE_ID response from server may contain server
implementation details (domain, name and build time) in optional
nfs_impl_id4 field. Currently nfsd does not fill this field.

NFSv4.1 OP_EXCHANGE_ID call request from client may contain client
implementation details and Linux NFSv4.1 client is already filling these
information based on runtime module param "nfs.send_implementation_id" and
build time Kconfig option "NFS_V4_1_IMPLEMENTATION_ID_DOMAIN". Module param
send_implementation_id specify whether to fill implementation fields and
Kconfig option "NFS_V4_1_IMPLEMENTATION_ID_DOMAIN" specify the domain
string.

Do same in nfsd, introduce new runtime param "nfsd.send_implementation_id"
and build time Kconfig option "NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN" and
based on them fill NFSv4.1 server implementation details in OP_EXCHANGE_ID
response. Logic in nfsd is exactly same as in nfs.

This aligns Linux NFSv4.1 server logic with Linux NFSv4.1 client logic.

NFSv4.1 client and server implementation fields are useful for statistic
purposes or for identifying type of clients and servers.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/nfsd/Kconfig   | 12 +++++++++++
 fs/nfsd/nfs4xdr.c | 55 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index ec2ab6429e00..70067c29316e 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -136,6 +136,18 @@ config NFSD_FLEXFILELAYOUT
 
 	  If unsure, say N.
 
+config NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN
+	string "NFSv4.1 Implementation ID Domain"
+	depends on NFSD_V4
+	default "kernel.org"
+	help
+	  This option defines the domain portion of the implementation ID that
+	  may be sent in the NFS exchange_id operation.  The value must be in
+	  the format of a DNS domain name and should be set to the DNS domain
+	  name of the distribution.
+	  If the NFS server is unchanged from the upstream kernel, this
+	  option should be set to the default "kernel.org".
+
 config NFSD_V4_2_INTER_SSC
 	bool "NFSv4.2 inter server to server COPY"
 	depends on NFSD_V4 && NFS_V4_2
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index b45ea5757652..5e89f999d4c7 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -62,6 +62,9 @@
 #include <linux/security.h>
 #endif
 
+static bool send_implementation_id = true;
+module_param(send_implementation_id, bool, 0644);
+MODULE_PARM_DESC(send_implementation_id, "Send implementation ID with NFSv4.1 exchange_id");
 
 #define NFSDDBG_FACILITY		NFSDDBG_XDR
 
@@ -4833,6 +4836,53 @@ nfsd4_encode_server_owner4(struct xdr_stream *xdr, struct svc_rqst *rqstp)
 	return nfsd4_encode_opaque(xdr, nn->nfsd_name, strlen(nn->nfsd_name));
 }
 
+#define IMPL_NAME_LIMIT (sizeof(utsname()->sysname) + sizeof(utsname()->release) + \
+			 sizeof(utsname()->version) + sizeof(utsname()->machine) + 8)
+
+static __be32
+nfsd4_encode_server_impl_id(struct xdr_stream *xdr)
+{
+	char impl_name[IMPL_NAME_LIMIT];
+	int impl_name_len;
+	__be32 *p;
+
+	impl_name_len = 0;
+	if (send_implementation_id &&
+	    sizeof(CONFIG_NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN) > 1 &&
+	    sizeof(CONFIG_NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN) <= NFS4_OPAQUE_LIMIT)
+		impl_name_len = snprintf(impl_name, sizeof(impl_name), "%s %s %s %s",
+			       utsname()->sysname, utsname()->release,
+			       utsname()->version, utsname()->machine);
+
+	if (impl_name_len <= 0) {
+		if (xdr_stream_encode_u32(xdr, 0) != XDR_UNIT)
+			return nfserr_resource;
+		return nfs_ok;
+	}
+
+	if (xdr_stream_encode_u32(xdr, 1) != XDR_UNIT)
+		return nfserr_resource;
+
+	p = xdr_reserve_space(xdr,
+		4 /* nii_domain.len */ +
+		(XDR_QUADLEN(sizeof(CONFIG_NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN) - 1) * 4) +
+		4 /* nii_name.len */ +
+		(XDR_QUADLEN(impl_name_len) * 4) +
+		8 /* nii_time.tv_sec */ +
+		4 /* nii_time.tv_nsec */);
+	if (!p)
+		return nfserr_resource;
+
+	p = xdr_encode_opaque(p, CONFIG_NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN,
+				sizeof(CONFIG_NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN) - 1);
+	p = xdr_encode_opaque(p, impl_name, impl_name_len);
+	/* just send zeros for nii_date - the date is in nii_name */
+	p = xdr_encode_hyper(p, 0); /* tv_sec */
+	*p++ = cpu_to_be32(0); /* tv_nsec */
+
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_encode_exchange_id(struct nfsd4_compoundres *resp, __be32 nfserr,
 			 union nfsd4_op_u *u)
@@ -4867,8 +4917,9 @@ nfsd4_encode_exchange_id(struct nfsd4_compoundres *resp, __be32 nfserr,
 	if (nfserr != nfs_ok)
 		return nfserr;
 	/* eir_server_impl_id<1> */
-	if (xdr_stream_encode_u32(xdr, 0) != XDR_UNIT)
-		return nfserr_resource;
+	nfserr = nfsd4_encode_server_impl_id(xdr);
+	if (nfserr != nfs_ok)
+		return nfserr;
 
 	return nfs_ok;
 }
-- 
2.20.1


