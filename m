Return-Path: <linux-nfs+bounces-9165-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 498A6A0BC12
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 16:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3300818844ED
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 15:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBBD1C5D58;
	Mon, 13 Jan 2025 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSmg812u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862751C5D6B
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782368; cv=none; b=nsf54bMlABF0h44MW95OinfM0tqng7QTlivWNxbw3IjqjJGturd+SeH1GMAovzefKlj8sR9GcQsZvoUK79qoC3X5aVNY24RMDl8CEd6v3gxqDPMM5dfC7g2JrwyMaeoQ2fSSumpp7JNls9v37aQDT9EDBJpxlPibXsjorSJqA6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782368; c=relaxed/simple;
	bh=rd2ZxqoDE8xaiQZHHzsxsiiqvZp3P/CginDdmiIT54k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eF4mjDaJsHPydXnFhc41onHd0gyicVwKRKErzZGkShTXuJstsf3GcsLYWwv48cDO438FcLJ4Msex1vTrjKrjcMZhI6GvIGAgtLb83ku7GFl0cSl/Y4qwg97bEmeEakCPnknwzCzFEuxJwJ1unmhLhI/DWfcyumt5fzXAKUmCJIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSmg812u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B253C4CEE5;
	Mon, 13 Jan 2025 15:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736782368;
	bh=rd2ZxqoDE8xaiQZHHzsxsiiqvZp3P/CginDdmiIT54k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qSmg812u+dMlnomVpEhfNJYgnEU5VsbcTbEuDzDraJv29l8Q1M6yv8FIF/S2szVU6
	 0U44gKbiRZ4OFxM/q672N6U1Hb8ROaTFUqTvIRb4T5KP6NlBDCWTUtYvL1wkvMol8E
	 g19LVCdwa0DWiAdHkm3kkOUdV7zLivXzOh17T/DRLZeNH5euguMaw3EBRgc7mGiGQC
	 UMv1ZRdXgGIiC5swy1h9AhWAG7WsaqfC13q8ZFi8wIRpJCEoujNuqi292kh5NFSP63
	 FUrHvBD9osOKZ5EwbcgSNTiJSk6m/QgHyN42gwc+9FrQMuPkzebpd8Qr1punTwT6qq
	 eW7MH5ubZ0rVQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 2/7] NFS: Fix typo in OFFLOAD_CANCEL comment
Date: Mon, 13 Jan 2025 10:32:37 -0500
Message-ID: <20250113153235.48706-11-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250113153235.48706-9-cel@kernel.org>
References: <20250113153235.48706-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=593; i=chuck.lever@oracle.com; h=from:subject; bh=mouARqxISM1482lXkswzcHqamIqKqvoBpq1nGC0q9JM=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnhTIagnQg9dBjNvtAL9LGkYTPANb0B6QbD1pgr 5bO9a78mR2JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ4UyGgAKCRAzarMzb2Z/ lwzSD/0QiClIOkddS+WQZvgPI4Ztijm/XSVucyy98aA18LFVFRCh4W9aHoa33Egn7Afevsq2cBj fb9CcYOb6BSvcmtBPnnou8TEy3dF/VH8pKPXYEqVAB28lJH2z5lozqqWnQWtZYLNdJqQTHT6Xmv NAkefOkVTGq3SenpRCjrL6xveB7yMTL5AH3BoCqwOx9h+Vp3kg/lk5RCtmJVD0USIgyOhz9A2gm ckYoeEBR0XGYOgIRA2B73KO9Q1TQpoNeVyVf2/qqCPOqjQKhCDsc4CFNUyQ1oSeNYc38IVgfIUV pdHsZTa6DR/LqoQRIVFSQQuuyRSVSiMy1QWFPkF7ca2i2G6s9XAMNPDExWsLSqea78ohy4AWUQb S7+mijK8TOiXPpoBnH4eaH7cv+Ac3j5Iy2xS7XCH8eDlRdfr7+kQwdQxCTkOFl8HkQaLaIhovQ+ shZTfnx0X0TFP21yZPQ/XZPsTSieGGfVuJqCHE8KJREPY7l9tMCfn7ecjKTn+rmge/2K7dhGYqU LPU71vKMUOpSh3VFtxZ3vf8KdO3c7VzZjsXcY8TYnX8oPbigLy08xcgONfGBsUaWVHFId3JbTKX 9m8XfHxURKIHLhEQNAR5VTNKQ4HX+63tEiD7/dWL8DG/T9Mpb1ZhNqS03fajNUiT9W62GOps+zh /iE/vv8qbsMtVLQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 9e3ae53e2205..ef5730c5e704 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -549,7 +549,7 @@ static void nfs4_xdr_enc_copy(struct rpc_rqst *req,
 }
 
 /*
- * Encode OFFLOAD_CANEL request
+ * Encode OFFLOAD_CANCEL request
  */
 static void nfs4_xdr_enc_offload_cancel(struct rpc_rqst *req,
 					struct xdr_stream *xdr,
-- 
2.47.0


