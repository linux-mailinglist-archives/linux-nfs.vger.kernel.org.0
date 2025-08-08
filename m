Return-Path: <linux-nfs+bounces-13499-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB22DB1E785
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 13:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292323A36A3
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 11:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E085827585F;
	Fri,  8 Aug 2025 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDYcn1b/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B983727511A;
	Fri,  8 Aug 2025 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653272; cv=none; b=bWqRnlFAE1xtZU96gVr6610cxH45BAJbo6639Q0EyY+GiZ1/nyF4ekdWsrooiikb6205ShQ/jtLvHjaks+KOqLTtgJbOCvWB99sfvLbZ666pwlIT/qfza3XRIRsSfObHm1fSPmhgM30GhcCD5BOZmFRlE0dqhame3ClucsrMNW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653272; c=relaxed/simple;
	bh=3FE6A6O+RGeqoPSnfsF4wQVXuqBjW0BAzGehqeSXqP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aFI0IiVFRs0W8290xhRkuIzGuSFU7BxY3XAqt32od5TJYSKA9wEYGZ+rzpWaosUIgN61zcBpWi15icog7biALwciBlckXUp1/n5oRyt2T54MiBBb5F8tjk2lYplKx7c0owQF3k4IQyDdSVpZLtE4VUw1DXaIshyX12stdjkn+cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDYcn1b/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B24C4CEED;
	Fri,  8 Aug 2025 11:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754653272;
	bh=3FE6A6O+RGeqoPSnfsF4wQVXuqBjW0BAzGehqeSXqP0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZDYcn1b/CS0D2dgssauMijoQYVt2l58SD7RcDDFsLKj0+TwHponfIEyJHd4QVif3G
	 tZeLP8KFWSdIwVRC4dg8BvzA3ocpOWdTZAWJMUR1x6i919Q4+FLsXRzoruvitczDyn
	 mO/jaAf8ofFuPFv50CixiS79QShig6D7zvpdtXpMjDtn5DX1UxDn1LJbqtDSSGvPhr
	 d3xJcmQTQzjcJXURbiPS3rftWraTyfURkBcTZL5RKjJw1Skpc8pmTpzXEjyFVK/104
	 TGq5hr8PJSn8POZ+yvgaC87TX8JFLLzza8PYXEz99acjgCSoMHE09y8gyKoZ1wEG6f
	 25vpNMpBy6Q/Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 08 Aug 2025 07:40:34 -0400
Subject: [PATCH 5/5] nfs: add tracepoints to nfs_writepages()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-nfs-tracepoints-v1-5-f8fdebb195c9@kernel.org>
References: <20250808-nfs-tracepoints-v1-0-f8fdebb195c9@kernel.org>
In-Reply-To: <20250808-nfs-tracepoints-v1-0-f8fdebb195c9@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1880; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=3FE6A6O+RGeqoPSnfsF4wQVXuqBjW0BAzGehqeSXqP0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoleJUIZpG+m1lKvM4v7FOfvK1ClB+krZc1lLCh
 2Ji/XZdFQKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaJXiVAAKCRAADmhBGVaC
 FR7ZEACyxQMvvz+G6KY5nOOz9S81YOxkqiI13hncyeP2eb6EiU6J0JNMNAF6sIz/oMAj2lQRuFC
 DlpYHj7sIoIK7j42Ra1OwaxBSgQ9htMaB8Bk010v2Aiogmi/AvfixVxOsj+rBbdk9JyxBIzVwxi
 VOaGmJvhhYNx/7fkqUvGeaTexiPm0THsFvrHwtBuSFqzJggvPELSM86ITe4iSAnhAuU+R1EYwsZ
 iZG1Tl4gj0pn5znCm75tYvBspBnQt0l46D3wkZxUN2gBwjK9pCylP7qx5PBaWHooOfxLOSrOYBe
 cAaGFFPzsmF6CHyPTO3r4z9iBEKjsSFiXgyi57V9UXi7tDxLbCYJ/QsvBHNwAeIlyyqOPgd+4St
 4jliNlo2/utLrM545OkZ5gxvlOD3kS4ym+zl/dQq/wHZekLV7ALg0gDAWVuvhb+4hxev20CQD+B
 ystKepdHEpcD0MAwbHm0PdYySspgg7i5nvOyEZt3PH6x1gWTgFmmXIDeqZsRWczo13S6CPXi0xW
 vzqFMvOlGDPSTR8pn4Kl+K+es6D5Xox0hw5WWYGna85uiVNAlUU+e/uQQ8nLXbX19c8UXiEJtSI
 12kzabx/cTMHyYqk3HZzmxB3I3bYoAw3vARSCwD9gqA3OVQoUUEz0u3uVhT3ZSWnHC7Q1p5ICJX
 r9Pew+rp0mnGdlQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Show the inode info and requested range.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/nfstrace.h |  2 ++
 fs/nfs/write.c    | 10 ++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 63dec30226153a78dd9017fdb1104ba3301f7372..dcf339adcf5cb40a71eea4c9b5d4a500eb0223bb 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1074,6 +1074,8 @@ DEFINE_NFS_FOLIO_EVENT_DONE(nfs_write_begin_done);
 DEFINE_NFS_FOLIO_EVENT(nfs_write_end);
 DEFINE_NFS_FOLIO_EVENT_DONE(nfs_write_end_done);
 
+DEFINE_NFS_FOLIO_EVENT(nfs_writepages);
+DEFINE_NFS_FOLIO_EVENT_DONE(nfs_writepages_done);
 
 DECLARE_EVENT_CLASS(nfs_kiocb_event,
 		TP_PROTO(
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index b5632f18813bee4e6a45cae3651399c753631958..638c8334082086df2fe5ef143219ab2fe186ae1b 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -710,12 +710,14 @@ int nfs_writepages(struct address_space *mapping, struct writeback_control *wbc)
 	int priority = 0;
 	int err;
 
+	trace_nfs_writepages(inode, wbc->range_start, wbc->range_end - wbc->range_start);
+
 	/* Wait with writeback until write congestion eases */
 	if (wbc->sync_mode == WB_SYNC_NONE && nfss->write_congested) {
 		err = wait_event_killable(nfss->write_congestion_wait,
 					  nfss->write_congested == 0);
 		if (err)
-			return err;
+			goto out_err;
 	}
 
 	nfs_inc_stats(inode, NFSIOS_VFSWRITEPAGES);
@@ -746,10 +748,10 @@ int nfs_writepages(struct address_space *mapping, struct writeback_control *wbc)
 	} while (err < 0 && !nfs_error_is_fatal(err));
 	nfs_io_completion_put(ioc);
 
-	if (err < 0)
-		goto out_err;
-	return 0;
+	if (err > 0)
+		err = 0;
 out_err:
+	trace_nfs_writepages_done(inode, wbc->range_start, wbc->range_end - wbc->range_start, err);
 	return err;
 }
 

-- 
2.50.1


