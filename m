Return-Path: <linux-nfs+bounces-13075-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5351FB058E7
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 13:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1763A5297
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 11:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D0419DF6A;
	Tue, 15 Jul 2025 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3lgC5x4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E31D2FB;
	Tue, 15 Jul 2025 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752579253; cv=none; b=fZ8YSDaB/84qRahZ7yV3H6X8lxAybRCyiKWr4fJHPciyabimWmC6Z/TT5EiJppb9bDV5fdsgkEjrjG+Zk62Dm6qvcsYmqaWMsbWIVv52nE6Tmdy+KGb70eeLVsZRjMt8WSkxqPQuC32UeHxW/2Gni4n4wQOWjZmAhMZ6iUY5IIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752579253; c=relaxed/simple;
	bh=VoCKJg3aglPoXGmYCQF7UL2bstbcwOkJVWtLwxYKV0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iupihh3ZJ27spAuW0L/D5zcYUcbzIv61cYfetxzG6Ti/Kks597sh0fh4HW0TzgUeVuMWr+WhskS+BoiPo+MeINlNyAAjQ1knIML0RMN/40bbpN3Rg4SH0xVMo2w9Sq8klspW4iPsPh1Nqz//iOKldrV01GMmp6O/fCeypVDJFuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3lgC5x4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D79C4CEE3;
	Tue, 15 Jul 2025 11:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752579253;
	bh=VoCKJg3aglPoXGmYCQF7UL2bstbcwOkJVWtLwxYKV0c=;
	h=From:Date:Subject:To:Cc:From;
	b=I3lgC5x4mPnfAQ0c3rbpkWDSqPod8sD26yfu/CYb2guG0bYKjCTQYsRBSspapHLAS
	 SpXSsKoL1/g0xrTRMRI2C8Z/2vz6d9Fxkp58bmbFoDKbu92uA3JcRG03y3jMUzL+8S
	 dRPd90RhTcDJP0Ejs37r++nn/El6oWFqL2S/djzk22UbKWDGLfTKkZilCGP/k449nv
	 Ei4k5jGPfxlIbMYyGEA6b8WPowNF0efhncU7QSppkjD5n/5GY25SNsbz9V4C/ny2vm
	 d2t/cbF2vc7NYzwW82c80ew09w6L8yHiVrIsyO1LdTyFdY0/Fqwa7MQH1VVHYldCf5
	 dMfd2I/veDxZQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 15 Jul 2025 07:34:10 -0400
Subject: [PATCH] nfsd: don't set the ctime on delegated atime updates
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-tsfix-v1-1-da21665d4626@kernel.org>
X-B4-Tracking: v=1; b=H4sIALI8dmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0NT3ZLitMwKXXMLAyMTM0sDk0QDQyWg2oKiVKAw2Jzo2NpaAFAgewZ
 XAAAA
X-Change-ID: 20250715-tsfix-780246904a01
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5986; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=VoCKJg3aglPoXGmYCQF7UL2bstbcwOkJVWtLwxYKV0c=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBodjy0qIcFlPaUFRGlYK9bRl83a+rpITi4FQzWt
 jVksrJhIlaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaHY8tAAKCRAADmhBGVaC
 FQKJEADSH7zGxPYXcitdceOD52SBKZqXW6slRxvfFJeFaFgMgm/N02wau2Dro9MzrCCwec4mdHO
 FMHn+PnZE2W3ILpErLDlC0XD3Bj0gvVOcylyO79RAyZno4zPJF5W57H6MdQey/7yFbvf66Am/7h
 bTPIzXKr4RAfF3sH+ASCcl2mDfrSlcXND9UJ/BUH3zPBU/KNN09xSjD5QE7UIIVCkkSeu+J7VnI
 9y53I2/umT3pFh3rMMsmdmh5oHBaX4wgycHGnr4D+MqkkvJJJx6Gf3XwUn/PVC6lkyN27pU6262
 ZxZ5h5lQvFlhsbf59PAsmfQ29deOaLD/883aGSRJC36Kc4dRr6Un/2b4iKAodo2ehvkKKKuICEw
 GdUSKFl1rksjBOl9BJv0QeANKLoKhWAQQdsL+4aqko6DPXGTen7pLhBErLqOtaYmBxJUb10bQRC
 stTKgcejhmRihZBPfin56OiYyrq4HlnlYf7gAClhiBC7iI0SheVZtV78G7wJcr8jANrR9KskWmW
 rwTmLQ5t230849Dn4zVk/GZHagALVPW+56NMyHcFZlu18LZVSDtrtvA1UDkB/+brHbX40tCl95U
 W6ODpeCrOJ4dbcHru1Gye1xMbwNxI85CTgQ3+wnbPJ0+51gVVes2cdyxqBmkQDZOgEJ7hmnGTfd
 cH2g1mDU8g8bDAg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Clients will typically precede a DELEGRETURN for a delegation with
delegated timestamp with a SETATTR to set the timestamps on the server
to match what the client has.

knfsd implements this by using the nfsd_setattr() infrastructure, which
will set ATTR_CTIME on any update that goes to notify_change(). This is
problematic as it means that the client will get a spurious ctime
updates when updating the atime.

Fix this by pushing the handling of ATTR_CTIME down into the decoder
functions so that they are set earlier and more deliberately, and stop
nfsd_setattr() from implicitly adding it to every notify_change() call.

Fixes: 7e13f4f8d27d ("nfsd: handle delegated timestamps in SETATTR")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
I finally was able to spend some time on the gitr failures with
delegated timestamps and found this. With this patch I was able to run
the gitr suite in the "stress" configuration under kdevops and it
passed.
---
 fs/nfsd/nfs3xdr.c   |  3 +++
 fs/nfsd/nfs4state.c |  2 +-
 fs/nfsd/nfs4xdr.c   | 18 +++++++++---------
 fs/nfsd/nfsxdr.c    |  3 +++
 fs/nfsd/vfs.c       |  1 -
 5 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index ef4971d71ac4bfee5171537eda80dec6e367060d..3058c73fe2d204131c33e31e76f7ca15c2545d36 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -289,6 +289,9 @@ svcxdr_decode_sattr3(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		return false;
 	}
 
+	if (iap->ia_valid)
+		iap->ia_valid |= ATTR_CTIME;
+
 	return true;
 }
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d5694987f86fadab985e55cce6261ad680e83b69..3aa430c8d941570840fc482efc750daa5df3ae84 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5690,7 +5690,7 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
 		struct nfsd4_open *open)
 {
 	struct iattr iattr = {
-		.ia_valid = ATTR_SIZE,
+		.ia_valid = ATTR_SIZE | ATTR_CTIME,
 		.ia_size = 0,
 	};
 	struct nfsd_attrs attrs = {
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 3afcdbed6e1465929ec7da67593243a8bf97b3f4..568b30619c79a857429113015b2ff7081557681f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -409,7 +409,7 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 		if (xdr_stream_decode_u64(argp->xdr, &size) < 0)
 			return nfserr_bad_xdr;
 		iattr->ia_size = size;
-		iattr->ia_valid |= ATTR_SIZE;
+		iattr->ia_valid |= ATTR_SIZE | ATTR_CTIME;
 	}
 	if (bmval[0] & FATTR4_WORD0_ACL) {
 		status = nfsd4_decode_acl(argp, acl);
@@ -424,7 +424,7 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 			return nfserr_bad_xdr;
 		iattr->ia_mode = mode;
 		iattr->ia_mode &= (S_IFMT | S_IALLUGO);
-		iattr->ia_valid |= ATTR_MODE;
+		iattr->ia_valid |= ATTR_MODE | ATTR_CTIME;
 	}
 	if (bmval[1] & FATTR4_WORD1_OWNER) {
 		u32 length;
@@ -438,7 +438,7 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 					      &iattr->ia_uid);
 		if (status)
 			return status;
-		iattr->ia_valid |= ATTR_UID;
+		iattr->ia_valid |= ATTR_UID | ATTR_CTIME;
 	}
 	if (bmval[1] & FATTR4_WORD1_OWNER_GROUP) {
 		u32 length;
@@ -452,7 +452,7 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 					      &iattr->ia_gid);
 		if (status)
 			return status;
-		iattr->ia_valid |= ATTR_GID;
+		iattr->ia_valid |= ATTR_GID | ATTR_CTIME;
 	}
 	if (bmval[1] & FATTR4_WORD1_TIME_ACCESS_SET) {
 		u32 set_it;
@@ -464,10 +464,10 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 			status = nfsd4_decode_nfstime4(argp, &iattr->ia_atime);
 			if (status)
 				return status;
-			iattr->ia_valid |= (ATTR_ATIME | ATTR_ATIME_SET);
+			iattr->ia_valid |= ATTR_ATIME | ATTR_ATIME_SET | ATTR_CTIME;
 			break;
 		case NFS4_SET_TO_SERVER_TIME:
-			iattr->ia_valid |= ATTR_ATIME;
+			iattr->ia_valid |= ATTR_ATIME | ATTR_CTIME;
 			break;
 		default:
 			return nfserr_bad_xdr;
@@ -492,10 +492,10 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 			status = nfsd4_decode_nfstime4(argp, &iattr->ia_mtime);
 			if (status)
 				return status;
-			iattr->ia_valid |= (ATTR_MTIME | ATTR_MTIME_SET);
+			iattr->ia_valid |= ATTR_MTIME | ATTR_MTIME_SET | ATTR_CTIME;
 			break;
 		case NFS4_SET_TO_SERVER_TIME:
-			iattr->ia_valid |= ATTR_MTIME;
+			iattr->ia_valid |= ATTR_MTIME | ATTR_CTIME;
 			break;
 		default:
 			return nfserr_bad_xdr;
@@ -519,7 +519,7 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 		if (xdr_stream_decode_u32(argp->xdr, &mask) < 0)
 			return nfserr_bad_xdr;
 		*umask = mask & S_IRWXUGO;
-		iattr->ia_valid |= ATTR_MODE;
+		iattr->ia_valid |= ATTR_MODE | ATTR_CTIME;
 	}
 	if (bmval[2] & FATTR4_WORD2_TIME_DELEG_ACCESS) {
 		fattr4_time_deleg_access access;
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index fc262ceafca972df353a389eea2d7e99fd6bc1d2..8372a374623a5d98fff7c0227a73a9b562da407d 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -196,6 +196,9 @@ svcxdr_decode_sattr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 			iap->ia_valid &= ~(ATTR_ATIME_SET|ATTR_MTIME_SET);
 	}
 
+	if (iap->ia_valid)
+		iap->ia_valid |= ATTR_CTIME;
+
 	return true;
 }
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index cd689df2ca5d7396cffb5ed9dc14f774a8f3881c..383a724e9aa20a4c6a71a563281fc8a618dd36d3 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -470,7 +470,6 @@ static int __nfsd_setattr(struct dentry *dentry, struct iattr *iap)
 	if (!iap->ia_valid)
 		return 0;
 
-	iap->ia_valid |= ATTR_CTIME;
 	return notify_change(&nop_mnt_idmap, dentry, iap, NULL);
 }
 

---
base-commit: 347e9f5043c89695b01e66b3ed111755afcf1911
change-id: 20250715-tsfix-780246904a01

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


