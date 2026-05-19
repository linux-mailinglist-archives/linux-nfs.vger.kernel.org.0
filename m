Return-Path: <linux-nfs+bounces-21711-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aM1/IkaoDGoIkgUAu9opvQ
	(envelope-from <linux-nfs+bounces-21711-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 20:13:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F335837A4
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 20:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15E7C3056520
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 18:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE8033F583;
	Tue, 19 May 2026 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="fmVQ5Hxq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67DD33C183;
	Tue, 19 May 2026 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214312; cv=none; b=E9ch/Rgy5ypazUTA6o1nDSUxPHiZr9/QyfDNIFrWFIxheWfPKvOiW1/CdFhmxFD6PlEmkzvEVJKEYnw5anU3SrMX9GJWlD2J8Wr0CG8TBO1mlt/dta5rD3qam1KXXTxJaEXSfVbUki2exOLOA4OTQtMGDWq2alpSXLxBrrNe0t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214312; c=relaxed/simple;
	bh=DvCcxEMfljx0Moile2QWoAeMSvurqlzW6j+wzjUwdmA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PYSeKVsZPkCf6AGfESILcLP5892MenWyJXYp3lVid7ou2y/S6JGGxx6RSTbY7hmpkXpLLGvLsM+yngtVQHFCrr7FSsJe8p70MJ5XtX3YcTsbZ7BBTUw0CPUifSg/feC5Eh/l6iePBDCxxwTZNMGkrr/dYc9x1NCBDHKoECC/Lrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=fmVQ5Hxq; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 64JE3GCu1379680;
	Tue, 19 May 2026 11:11:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=DvCcxEMfljx0Moile2
	QWoAeMSvurqlzW6j+wzjUwdmA=; b=fmVQ5Hxqik08kivm5+/PxpU6iG0CTyyGvf
	1ezHnxVSSqBrug6O4FwBKpmLCJBBOogJ7QlTNAVAlUULppp5IwgsOEPGeS7p+aiB
	BkSEiwjJ5QtDhSCUcpfwp8SqVxMZXfV9UVwASx5Avw5qspWL8uouksnPNa5gKVO4
	d6MWKDmxWjV5YpSxhS1yGrcxy1JyqAYrp9xNR3BwEqu3VZ/LKOIPziHzwSF67/FN
	CZEUs3SIeY7mI7+umPRmBXjpqYDVCI68mO0FFWWlpq99gqPt61EsAZv7AhrcGTSc
	AS5JhmrriTBcLU7znQveZos7oBHll2YBMHj/SjP1m1PkEJPFfZ2Q==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4e8s9rhsff-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 19 May 2026 11:11:42 -0700 (PDT)
Received: from devbig003.atn7.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 19 May 2026 18:01:37 +0000
From: Chris Mason <clm@meta.com>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust
	<trondmy@gmail.com>, <linux-nfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] nfsd: drain backchannel callbacks before freeing a session
Date: Tue, 19 May 2026 10:49:13 -0700
Message-ID: <20260519180032.1852793-2-clm@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE4MCBTYWx0ZWRfX1sQfgWHkC7tW
 o4vjHMG+yEHmoWxDIrOc5w4+gL8RbYhOLGWBxRNOOtzsdLp+945UgrmPM0sU3xXzoWHvRi1AR7c
 +r0eJACc2pCNkiJqO+WzuTGZOPrJmujI4G8hHjMKj3NUzhTInTkG9PcOf0ZW/DczrAGjaP7CLBJ
 5sMd40w65gskbcSY7BSpVJKnYgtxQs68SJnjAvXGVBRdG/xmgkqIaEFulPLTaFmNDFlWL700Okm
 fHjYfKw4T+rbWod1LE1Y2WJzWSbOuhI5+g6ZuWVUoi+OiYntdHDpz9apAZRb4LTFGZseqxn60iw
 Cbo2m1hOuTIlmgYxQR5PGfSzm7rz8V/wiBFVfSDPQwXFDT1sy/NRRm3XTN6wwjWCTAZIoGeHteO
 jK+SgvNPITS4W48iXefSJiYeW3tr5sUiqjcnESDX4qV+lWAXXk8eSrYQVVA51DO1kcUmaEe4yXD
 SaEtsLQhSK34F7VKE7A==
X-Proofpoint-GUID: Gv9hCa7zamSoHVCzVmj7gRvSPiBMu057
X-Authority-Analysis: v=2.4 cv=NuzhtcdJ c=1 sm=1 tr=0 ts=6a0ca7de cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=VabnemYjAAAA:8 a=-0hxeGBmMInBsXaKhxMA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: Gv9hCa7zamSoHVCzVmj7gRvSPiBMu057
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21711-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,fieldses.org,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:mid,meta.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E6F335837A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DESTROY_SESSION can free an nfsd4_session while a backchannel callback
for the same client is still live on rpciod, leaving clp->cl_cb_session
as a dangling pointer.

The first patch waits on cl_cb_inflight, and the second hopes to make
things harder to regress in the future by dropping a NULL in there.

Signed-off-by: Chris Mason <clm@meta.com>

