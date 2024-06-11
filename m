Return-Path: <linux-nfs+bounces-3650-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF5A9044F1
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2024 21:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC04E281411
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2024 19:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB693A27B;
	Tue, 11 Jun 2024 19:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPlkkl3L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FEB386
	for <linux-nfs@vger.kernel.org>; Tue, 11 Jun 2024 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718134631; cv=none; b=Gb8Jl/dKEpn+5XXN3FHjwm2mvXeN5XmpTY0fSXFHcL7A3JdmoTEaQ0ikTl1CvlW+urN65udImU5ELvg1Aq92j2q3Cd546eHsrgTy0o6pT9LIteYAlgOWlX6+x4aV0PjPa30FP5rjnCKUSCsLVvTrroP69UKMQLBifxdcgcp+u+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718134631; c=relaxed/simple;
	bh=NhV5OWsA+B/FCmhxwNBo5G6GCZHtSizjJW+3sBwxWnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T8KKQcI+zvJ8OZE36GNebnyrX3Rd+JKyE2gIY9FqrH5gJ0ogn5NKd0zH2gd2UQfC8i25JPRsu/iRqNVYqO2EufMf5Ed9MaSpUU3ROQf7wxdT8LjFZPxSC2rQbkBHu1a/I2tKUhvaqUp4l0y5dNOp6iIlgMBhz6ZESj2deTRdoe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPlkkl3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE36FC2BD10;
	Tue, 11 Jun 2024 19:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718134629;
	bh=NhV5OWsA+B/FCmhxwNBo5G6GCZHtSizjJW+3sBwxWnI=;
	h=From:To:Cc:Subject:Date:From;
	b=PPlkkl3L0W+pEQTlXnfbPXcucm7jUg1TQcJm9tdg1Qm2OLeHaMef6CvNNUR2ttnL3
	 mrcksXg7bY0UdXWZ+bmFlu2noNBiDmSXlet3TNqctOzXKiHkC7DptAIXbN6Uo/BH2T
	 BeibPdHTN4dI6JjwPLmyfC30OJv9M9DQ10PLUcVGSHKawRPzfNU2fR2NFRB6hrC2qS
	 RCfUDv8VgKYQQQtY+aHD4pUtRdS4dWCDb+DbUglCGDmxUQv7axu3Ty3ZEipcBBw/Ab
	 wtJs2bLci1aAOrsZS/LJMDtboY6EvZxGP2tII12kzVNgl7crCDWxep1ZL8e1FKg8ul
	 xk5bgCi5OcaYw==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Dai Ngo <dai.ngo@oracle.com>,
	Olga Kornievskaia <kolga@netapp.com>,
	Tom Talpey <tom@talpey.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] NFSD: Support write delegations in LAYOUTGET
Date: Tue, 11 Jun 2024 15:36:46 -0400
Message-ID: <20240611193645.65792-2-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1972; i=chuck.lever@oracle.com; h=from:subject; bh=KiSwkEQdxrnsz+ITmSH9nbey6dqXhCOQ4IYTeF0XB+Y=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmaKdOPeXASXuEPPhRckZnofX5xBjEUQiNDXU2b fQFM9g3FxWJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZminTgAKCRAzarMzb2Z/ l0iqD/wJ0EAMuruGKYzFFtwrquOIo87rreoJYzthzvBeEWorwE71Cmy7sV0o8lXl8OBfSsHzr7c Vm9dJRj8TxORH2WDUvWMOiGEbM35edQU6Bq+4Vr+WNiFdHwt/HBTRz5sLZp3TwsQpO+u0wxLnrt RIsn1uQgm+VsymFF6fUQQgn60cEGZENiy7O4nZnCuh+T9XMd1c1qvD4HlpkD4Cbl8T37BerPh0W 0Xwo6giJNs6q6IUWDOLCpAv7yfBMLfA1VIGJqZ+t7QMlnwl3jDwanshHpnOJ3xoJxTW9SrR/oWT FGnX7FBMeGwcyr4Wp99syKkFi4Z1VDMS9Mj0WSdrnEX/gUOLnrXokNWkVs3oQHg75+hXXiG/dQQ 0PN/lnaDu8jhIjJWYQyvuUeW4Bca5zRzGWU1JPyORPpmDYeYnG6a2MEiGBiHcv8ueYZvE3QKNwy DbrK3CGB20FWS+PcGxGbgEijbqa7o8kyHKFr6YM0o0cyuEA/kf/7weyIcor+mOpSNSmsiQZfU3h lLAAgIzYSvfDT6GQvBqbdSGSQkICF2ODtTFXhSE63d+IcuNG6us/E2yw4769/HAWBfzB1T7XC0L Yxpv55B+2H4eoHLhYw2TUhyTEvavF98NpRJMeH3ssoOwa3qi169ppUBXKz4lUr6A3K8l2Kdb0vy z3skmqQAKUQybAA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

I noticed LAYOUTGET(LAYOUTIOMODE4_RW) returning NFS4ERR_ACCESS
unexpectedly. The NFS client had created a file with mode 0444, and
the server had returned a write delegation on the OPEN(CREATE). The
client was requesting a RW layout using the write delegation stateid
so that it could flush file modifications.

Creating a read-only file does not seem to be problematic for
NFSv4.1 without pNFS, so I began looking at NFSD's implementation of
LAYOUTGET.

The failure was because fh_verify() was doing a permission check as
part of verifying the FH presented during the LAYOUTGET. It uses the
loga_iomode value to specify the @accmode argument to fh_verify().
fh_verify(MAY_WRITE) on a file whose mode is 0444 fails with -EACCES.

To permit LAYOUT* operations in this case, add OWNER_OVERRIDE when
checking the access permission of the incoming file handle for
LAYOUTGET and LAYOUTCOMMIT.

Cc: Christoph Hellwig <hch@lst.de>
X-Cc: stable@vger.kernel.org # v6.6+
Message-Id: 4E9C0D74-A06D-4DC3-A48A-73034DC40395@oracle.com
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 46bd20fe5c0f..2e39cf2e502a 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2269,7 +2269,7 @@ nfsd4_layoutget(struct svc_rqst *rqstp,
 	const struct nfsd4_layout_ops *ops;
 	struct nfs4_layout_stateid *ls;
 	__be32 nfserr;
-	int accmode = NFSD_MAY_READ_IF_EXEC;
+	int accmode = NFSD_MAY_READ_IF_EXEC | NFSD_MAY_OWNER_OVERRIDE;
 
 	switch (lgp->lg_seg.iomode) {
 	case IOMODE_READ:
@@ -2359,7 +2359,8 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 	struct nfs4_layout_stateid *ls;
 	__be32 nfserr;
 
-	nfserr = fh_verify(rqstp, current_fh, 0, NFSD_MAY_WRITE);
+	nfserr = fh_verify(rqstp, current_fh, 0,
+			   NFSD_MAY_WRITE | NFSD_MAY_OWNER_OVERRIDE);
 	if (nfserr)
 		goto out;
 
-- 
2.45.1


