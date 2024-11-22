Return-Path: <linux-nfs+bounces-8191-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2439D584A
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Nov 2024 03:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B5F1F236B5
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Nov 2024 02:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3A6230988;
	Fri, 22 Nov 2024 02:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="W5sOInbz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76BA70824
	for <linux-nfs@vger.kernel.org>; Fri, 22 Nov 2024 02:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732242570; cv=none; b=cfuATSBk70o0Qvr9QjCNFxfvO8LQ+r+5iihHfIZJDcMpNTZ6IG3a+0/btZMMFzzv9pHUZsSiclgvsx85DcMk2cjWWKM5JbUNtUlgH70jg+iUGtKoNJ/s7LNN05WDUTU/fIjgyw6zRL3QJdUpjiaiKLOtIb6WVS2kj+1nUWCUjuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732242570; c=relaxed/simple;
	bh=Z42BOPMfgLn3YaRVuI5+W3su+1N3CbDzREz5uYs+bnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i3QoEDPufvdAsvV30egKFWEkc1i6mfd4J6OxZxUGzfTPv42Y1ONyb0RpHU6bxkPBs99jckNHVO+Xl9H7kO+0UT+SkPR05PronjS6vzzl5KrMbrmB54OcDJWOL4LLk2gshreqNlWwWq/HsBxctasuaO6hi/IAdXwGAp4Vq8nK+z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=W5sOInbz; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1732242569; x=1763778569;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z42BOPMfgLn3YaRVuI5+W3su+1N3CbDzREz5uYs+bnQ=;
  b=W5sOInbzSx53LUSjQOJl/wYdv3VOMa0eciYWLSaKe2bkFBTz7xOJeBH2
   6R1MTdVT/vFGK6DpiJiAkRss5wcTkt7TG2tANDeJKdtQXbadBZaEwnuY2
   Mn8+BTyvHCYoi8IbU/h2dQBFUgWQck6gatZecthHpu85AAA4gI1/PaMTJ
   +A4vMq6fJ5NF+5BFd+AditJ6+I0ifPSC2+qjd8CGAkHD4NUK4872ObIIe
   sArJt2/98N4qVJb94bFR2quNcBs4gOYpugJ2Oi7/WgrpJQHIaKwEu/rJW
   flgoxJYschoomNhiq7/jpACav20GZDPoRSfQxGmVxr8E3g7fA8F2L8+G0
   A==;
X-CSE-ConnectionGUID: ERlbu88AQBiekAixF1oX5g==
X-CSE-MsgGUID: q36ooj6JSp2XspUNuFZdfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="160219568"
X-IronPort-AV: E=Sophos;i="6.12,174,1728918000"; 
   d="scan'208";a="160219568"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 11:28:16 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 2D5A2D6EA9
	for <linux-nfs@vger.kernel.org>; Fri, 22 Nov 2024 11:28:14 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id A9B7757285
	for <linux-nfs@vger.kernel.org>; Fri, 22 Nov 2024 11:28:13 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 2B7CD2007CA8E
	for <linux-nfs@vger.kernel.org>; Fri, 22 Nov 2024 11:28:13 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.135.89])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 1C8701A006C;
	Fri, 22 Nov 2024 10:28:12 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: trace: remove redundant stateid even deleg_recall
Date: Fri, 22 Nov 2024 10:18:25 +0800
Message-ID: <20241122022506.1536-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28812.002
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28812.002
X-TMASE-Result: 10--4.823500-10.000000
X-TMASE-MatchedRID: ORXmlZ8HLcXhtVvI3rIgyU7nLUqYrlslFIuBIWrdOeOjEIt+uIPPOPF4
	Vuj8zJsPwPjoyxtY8IDufX8sqKjiQa+/EguYor8cFEUknJ/kEl5jFT88f69nG/oLR4+zsDTtjoc
	zmuoPCq0IDUbtRj5ZqCUoTQs9q1QjsLjRnKIM8wtnCNAstS0FBb6EK1WxZ6qObzDbZD2kwh5hYV
	nM8Mg4vBtO4YFL1SwH+bTLPDkEk6cVwbf5lERMgI/2RRfVn5u4Tcu6aRtCI3BUKpNI+7y1VHsDE
	gQ63iHZ
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Since commit e56dc9e2949e ("nfsd: remove fault injection code") remove
all nfsd_recall_delegations codes,
we don't need trace_nfsd_deleg_recall any more.

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 fs/nfsd/trace.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index b8470d4cbe99..853f07868fbe 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -614,7 +614,6 @@ DEFINE_STATEID_EVENT(open);
 DEFINE_STATEID_EVENT(deleg_read);
 DEFINE_STATEID_EVENT(deleg_write);
 DEFINE_STATEID_EVENT(deleg_return);
-DEFINE_STATEID_EVENT(deleg_recall);
 
 DECLARE_EVENT_CLASS(nfsd_stateseqid_class,
 	TP_PROTO(u32 seqid, const stateid_t *stp),
-- 
2.39.1


