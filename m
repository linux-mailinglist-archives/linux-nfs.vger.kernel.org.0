Return-Path: <linux-nfs+bounces-10494-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB35FA54627
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 10:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8003B0658
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 09:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B55D20967D;
	Thu,  6 Mar 2025 09:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Yr5hOScH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E986191F75
	for <linux-nfs@vger.kernel.org>; Thu,  6 Mar 2025 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741252906; cv=none; b=VFDBpluvp6AqZdQSwBFoJhFIXvG8W5U2RoaGvrskqxzoetcst3lYoKi7JQRO4GvUwKdbn91BxGycgaFIszsCRI+Xbk4+c039KX/rzrPisAZrNS+Y761NmxtN6mK+bfFbSgPnDKB1E/r1G43j8rQvWOAudqmVJd/DMLf2qzdknAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741252906; c=relaxed/simple;
	bh=igiWiALYXwjEteRk6UoxxKnhoarx91n3W2Cd8shQTfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=rvBD39FwOzHZJGwsV4FWE1OgZw8NEdFO8H42EJ4Jrs0VtkbpCDA1abkqawBtnrQNBkXTaDHe/P29cPL5hD391+btUjRBWBTEQTqCMk8vFqwxwVJceMgQwAj0STp5QVGa3WztNVdirZ2nlaev1R6GO3osjUbM9zEWwHACzwsO/9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Yr5hOScH; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250306092141epoutp02df77400ea10334b41f631c5e56e83483~qLEm8STQb2948629486epoutp02A
	for <linux-nfs@vger.kernel.org>; Thu,  6 Mar 2025 09:21:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250306092141epoutp02df77400ea10334b41f631c5e56e83483~qLEm8STQb2948629486epoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741252901;
	bh=IOfj8ymR5McL3adj486jINgYZ9PZWay98r+rIJbAXhQ=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Yr5hOScHx0JV1K/R+Mffc688E3y/7/E+nSx0pL3SCUtLCAx0S3I6PbEPZmJbNHvKJ
	 zzWt7cSc6r+SIvTbHG/cNJP6V/WmYLpNFQ74Cnv0UF/EER0PSWORQXUCOd/w1UpEAu
	 fLx5fupy+AHaje2x/Y2RUje1WduXVrlwwjSVi+Fk=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250306092140epcas5p35290680200699fb2fbe7bdb6cacf0a1d~qLEmSAy_B2441724417epcas5p3l;
	Thu,  6 Mar 2025 09:21:40 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D3.45.19933.42969C76; Thu,  6 Mar 2025 18:21:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250306092017epcas5p30812b135b484fdea1f96739635df1d79~qLDYt3ClV0847608476epcas5p3W;
	Thu,  6 Mar 2025 09:20:17 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250306092017epsmtrp15786e7b236d2ed5f734c3133e6024de5~qLDYtEM_42217522175epsmtrp1H;
	Thu,  6 Mar 2025 09:20:17 +0000 (GMT)
X-AuditID: b6c32a4a-b87c770000004ddd-bb-67c969241e14
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D5.1E.18949.0D869C76; Thu,  6 Mar 2025 18:20:17 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250306092015epsmtip1d7d24c04edaa40d14ee7ae45a2367066~qLDWykwQG1436514365epsmtip18;
	Thu,  6 Mar 2025 09:20:14 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, lorenzo@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	chungki0201.woo@samsung.com, Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 1/2] NFSD: unregister filesystem in case
 genl_register_family() fails
Date: Thu,  6 Mar 2025 14:50:06 +0530
Message-Id: <20250306092007.1419237-1-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7bCmlq5K5sl0g+aLIhb/7z5nsjj9/Qq7
	xfxFm9ksfi5bxW5xedccNosLB06zWvStnsVocXh+G4vF3vkNLBaTnn1itzj16xSTA7fHplWd
	bB4fn95i8Xi/7yqbR9+WVYwem09Xe1x+coXR4/MmuQD2KC6blNSczLLUIn27BK6Muet/MRU0
	clScXNzP2sB4na2LkZNDQsBE4lPbfSCbi0NIYDejxMr9/awgCSGBT4wSp3YkQ9jfGCUW//CE
	aXix5CEzRMNeRompr+YwQThfGCWO3nzFBFLFJqAnsWrXHhaQhIhAD6PEtjl7wKqYBVoYJfae
	f8oIUiUsEC4xdcE1FhCbRUBV4sL/b0A2BwevgJ3E1l2hEOvkJWZe+s4OYvMKCEqcnPkErJwZ
	KN68dTbYGRICf9klXv7vYYVocJF4NfE+M4QtLPHq+BZ2CFtK4mV/GzvIfAmBcomtE+oheoHu
	2T9nCjQw7CWeXFzIClLDLKApsX6XPkRYVmLqqXVMEHv5JHp/P2GCiPNK7JgHY6tKtNzcAHWC
	tMTnjx9ZIGwPiSNXHrBDgjFWov3qQbYJjPKzkLwzC8k7sxA2L2BkXsUomVpQnJueWmxaYJSX
	Wq5XnJhbXJqXrpecn7uJEZyStLx2MD588EHvECMTB+MhRgkOZiUR3ot+J9OFeFMSK6tSi/Lj
	i0pzUosPMUpzsCiJ8zbvbEkXEkhPLEnNTk0tSC2CyTJxcEo1MDkF/e8qkvu6/U7S0+5zqs/M
	vluzlR2658ITdyXVyc/R2lDh7dzMYGdJh8MXfq5Yu6mrNLR76TKjxL02188JN3woyAyI/rzH
	QUXpmYHynB6fY6wn1Qt/7HxZHOTMsby+NZzr2F0/kcXNT8R9OqQW1z3IKeqac2jOCW/XkviT
	cg/fP8kUyFZ3dWqMO+n7ICpr8h3Vgi/NTM8YnSba6HrO3hZseIG9oix+6kTeD93t+3T3BHB9
	v1khXnNhWsn666uX6VxbOuWX6aHgDtbjbrrTfxRz76quOCqkaMj3f+Ki+R+6C5ncP689eeR8
	27HXDU6bxdYvUV7/dmJSou7KW3PmzmzkENm8fLParjc/pmber1RiKc5INNRiLipOBABtESiX
	uAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWy7bCSnO7FjJPpBhdWMlv8v/ucyeL09yvs
	FvMXbWaz+LlsFbvF5V1z2CwuHDjNatG3ehajxeH5bSwWe+c3sFhMevaJ3eLUr1NMDtwem1Z1
	snl8fHqLxeP9vqtsHn1bVjF6bD5d7XH5yRVGj8+b5ALYo7hsUlJzMstSi/TtErgy5q7/xVTQ
	yFFxcnE/awPjdbYuRk4OCQETiRdLHjJ3MXJxCAnsZpRofP6SCSIhLfHz33sWCFtYYuW/5+wQ
	RZ8YJZZ/2A2WYBPQk1i1aw8LSEJEYBqjxKKuOWBVzAIdjBLv/jaxglQJC4RKdK/5DtbBIqAq
	ceH/NyCbg4NXwE5i665QiA3yEjMvfWcHsXkFBCVOznwCVs4MFG/eOpt5AiPfLCSpWUhSCxiZ
	VjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBIe4ltYOxj2rPugdYmTiYDzEKMHBrCTC
	e9HvZLoQb0piZVVqUX58UWlOavEhRmkOFiVx3m+ve1OEBNITS1KzU1MLUotgskwcnFINTMny
	J9gb1uZrqMy78WHr40OGkQE777fdmLoo+6u0WqvGFEs/blvJdZkfVffPmMHiotuTfeVWqrJY
	7+enE7WeT2+pkJu2Q/5X9LrE8pwJfBuTd12LlzW+/5L9mdY/Addfeff6Puh73o2PvJA9I0yF
	YbEcu7Hhph8h5qrd8dEizGnqpj/4lrGy6ugcvmU0bydD8vdb9047r/J8Xv923rF9cyQObZ2j
	9Zvf6MqDqDcN7THzeGOWBN19EnzmlgDD3DVX90xonprMzFHDHHikLTr6U9TClW2VX9h2ZwQ+
	cspf61UYv2az4pqpGjkTlT5zJ9ySSnyy5L6Y3tqGivgLhR/6c35f4ohMM4zg/zf5+V+Be0os
	xRmJhlrMRcWJAEMUS5LgAgAA
X-CMS-MailID: 20250306092017epcas5p30812b135b484fdea1f96739635df1d79
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20250306092017epcas5p30812b135b484fdea1f96739635df1d79
References: <CGME20250306092017epcas5p30812b135b484fdea1f96739635df1d79@epcas5p3.samsung.com>

With rpc_status netlink support, unregister of register_filesystem()
was missed in case of genl_register_family() fails.

Correcting it by making new label.

Fixes: bd9d6a3efa97 ("NFSD: add rpc_status netlink support")
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 fs/nfsd/nfsctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index ac265d6fde35..d773481bcf10 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2305,7 +2305,7 @@ static int __init init_nfsd(void)
 		goto out_free_cld;
 	retval = register_filesystem(&nfsd_fs_type);
 	if (retval)
-		goto out_free_all;
+		goto out_free_nfsd4;
 	retval = genl_register_family(&nfsd_nl_family);
 	if (retval)
 		goto out_free_all;
@@ -2313,6 +2313,8 @@ static int __init init_nfsd(void)
 
 	return 0;
 out_free_all:
+	unregister_filesystem(&nfsd_fs_type);
+out_free_nfsd4:
 	nfsd4_destroy_laundry_wq();
 out_free_cld:
 	unregister_cld_notifier();
-- 
2.25.1


