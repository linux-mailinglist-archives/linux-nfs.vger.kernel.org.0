Return-Path: <linux-nfs+bounces-21076-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBunNXo362kfKAAAu9opvQ
	(envelope-from <linux-nfs+bounces-21076-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Apr 2026 11:27:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 146F245C2BE
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Apr 2026 11:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A208A30074D3
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Apr 2026 09:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7496338A711;
	Fri, 24 Apr 2026 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="vUjZjkxu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0806731E85E;
	Fri, 24 Apr 2026 09:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022826; cv=none; b=HDqcxQSzYLF+2gChvF/009IvEYEtP97UjE0YFyjfDmdLGVotcg8/Y1YwztoTW/gc605d/hEsZCsxhG3VMNkZ69zcqerv1yF9gK2Xp/ufBNcHiZj6CkIrNpjkm1oNw+LPnsA61I2z3ufdAnHv6Xv6v3JU3L0hHlK+bP0/qfeM/uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022826; c=relaxed/simple;
	bh=k1W/D9J2oKcl+3NjgtoQXcBOU+ZMEwG9lgsmMvpNWDI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=B+QNzL6z1/yhtGfsRPILy2Npi9CC/v+90q3GP2Wsy0SjNNHUraDwlRUqGt5z1+2IB/oMoPndIFIvpdR1lN6yea6w1/BrazKZaNlIvWUD4g1/W+j4fPJggzbqFNIkBMCT2eGd7LMvjSNuBgwZ0GfWkOlQMoyfGrfXasCXhImclos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=vUjZjkxu; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1777022806;
	bh=VmPLgv0cdrcwOfZp1gm29BiLnyAz2JvOKm96iEkgVyM=;
	h=From:To:Cc:Subject:Date;
	b=vUjZjkxum2h+FsDmgAsen8UjgME2j7y30zoSKF1axDLg7HmMgqCHugECKopYZm9TG
	 rGKhiQZhP0aCOKSMC6+4k9kQbNoMXQGydWmPn3xGeme3GY1iVjQBdcifYbf5WB2tWS
	 OibU/jdt5fzhHUT4KEr8woBfDp+U11kHqz1GLh7g=
Received: from ubuntu2404.. ([103.244.59.3])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 6AB9B806; Fri, 24 Apr 2026 17:26:43 +0800
X-QQ-mid: xmsmtpt1777022803t5dc0fapr
Message-ID: <tencent_BF5118C8B480E6BFEF401CC2B287682FC905@qq.com>
X-QQ-XMAILINFO: OKOirRU4nj6hCdTuvHQwWJvFFykVAoT60TYLU13cGKIKo8T/sWPqHASWB7Nlnv
	 oExDGYURyl11sDHbrJOQFCpLkOHivJwsWVw4nl/XbBsPyAyzQmobeLZpvo7U2+0px5jeEAXwK3PV
	 lDY4YwgrhXA2uM1uXWmJmIW8jnvEIUUi/OAHpD4imfuUXhgZskJLPABOlfB46dLNh5I1f7z+e0NN
	 n0X5A/H3cXsIfwZCJKvNKRX3qhsXNXFr7bRe0UnndnDCbCVSp4rQvHT55y9oZIW+bG8L/CQv8zRr
	 Abk2TvG5wRjfoswdloqn5IsD6EQM73d1VRBFwpS9qliXs66904KMEjIU1hjatB95NdhMb4VcgEG5
	 z/n1rE1vW9txezqISIDAJLZpK93x93NNfDgIdAKqTXoLy+DxBJtf3VSPsPwanq1ivVVGncnfGMC4
	 EHznSYWOMhwP2bydue15RCBuT8DzziUbDaNacGISovj/ekkIRyXRuZJQwSikWR7Rs5tpS495kUdR
	 jZy595oOtLqB7pzNXw/WM2/+3camOXl2J15LSfo9vir2PiE9Iunhouhfi/wZUsR4FmMuyyffR6x+
	 b+OHUHOAwKesIsvZ09st9nnWkLUxYQGoaobC6kZ9GOO6NaA9F2nwYAQHTbli8rbv3cOt/vrzSoaQ
	 ykbVJQxF6+RMw8E2DHS978V6JGWl3JwogSXxTqZce7R6VhWb6TxtPdBs8QsmsiWKeJpo4lEsnC8N
	 gyGVbmUuAkYSWVgb8e6jzMBe2QhBrZVI3TCDg/3XHOdVkhMOVPeGnEchwNyDi76AYdT03b3DWl+d
	 A1llRn68Tafmo0mFDcIwpuH6WN8b5M1Qe2vHnF3Tn63UBmb2uMDqNkvmBIL5Ez++s2iq2Xli6V0f
	 Km9IMYO4oqxM4S+e7dyDO4Qa0N1X5sgrcOHENjL8FOLLZzuzW2c25pl80bWGnf/cZq8og68QNFbF
	 aQ2IkRFFrBURtAFaf1zPohde4fzit9UV0eFcNDtiEjuupqTYAHHtpM7iy+GRqvG+FPjzATqjrb6B
	 juheGIX64jc0muljjWTQCUABw4qSU=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Lei Yin <cybeyond@foxmail.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yinlei2@lenovo.com
Subject: [PATCH v2] NFSv4.1/pNFS: fix LAYOUTCOMMIT retry loop on OLD_STATEID
Date: Fri, 24 Apr 2026 09:26:41 +0000
X-OQ-MSGID: <20260424092641.17753-1-cybeyond@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 146F245C2BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[foxmail.com];
	TAGGED_FROM(0.00)[bounces-21076-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[foxmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cybeyond@foxmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Lei Yin <yinlei2@lenovo.com>

Handle -NFS4ERR_OLD_STATEID in nfs4_layoutcommit_done().

This issue was reproduced on NFSv4.2.

Without refreshing data->args.stateid, LAYOUTCOMMIT can keep retrying
with the same stale stateid after OLD_STATEID, resulting in an
unbounded retry loop.

Refresh the layout stateid with nfs4_layout_refresh_old_stateid()
and restart the RPC only after a successful refresh.

Changes since v1: update refreshed stateid in inode layout header.

Signed-off-by: Lei Yin <yinlei2@lenovo.com>
---
 fs/nfs/nfs4proc.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 7225b4cfa6c2..575bf45a9209 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9989,6 +9989,38 @@ nfs4_layoutcommit_done(struct rpc_task *task, void *calldata)
 	case -NFS4ERR_GRACE:	    /* loca_recalim always false */
 		task->tk_status = 0;
 		break;
+	case -NFS4ERR_OLD_STATEID: {
+		u32 old_seqid = be32_to_cpu(data->args.stateid.seqid);
+		struct pnfs_layout_range range = {
+			.iomode = IOMODE_ANY,
+			.offset = 0,
+			.length = NFS4_MAX_UINT64,
+		};
+
+		if (nfs4_layout_refresh_old_stateid(&data->args.stateid,
+						    &range,
+						    data->args.inode)) {
+			struct pnfs_layout_hdr *lo;
+
+			spin_lock(&data->args.inode->i_lock);
+			lo = NFS_I(data->args.inode)->layout;
+			if (lo && pnfs_layout_is_valid(lo) &&
+			    nfs4_stateid_match_other(&data->args.stateid,
+						     &lo->plh_stateid))
+				pnfs_set_layout_stateid(lo, &data->args.stateid,
+							NULL, false);
+			spin_unlock(&data->args.inode->i_lock);
+
+			dprintk("%s: refreshed OLD_STATEID inode %lu seq %u->%u\n",
+				__func__, data->args.inode->i_ino,
+				old_seqid,
+				be32_to_cpu(data->args.stateid.seqid));
+
+			rpc_restart_call_prepare(task);
+			return;
+		}
+		fallthrough;
+	}
 	case 0:
 		break;
 	default:
-- 
2.43.0


