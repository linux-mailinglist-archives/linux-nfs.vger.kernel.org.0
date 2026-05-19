Return-Path: <linux-nfs+bounces-21708-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLxKDoylDGq8jwUAu9opvQ
	(envelope-from <linux-nfs+bounces-21708-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 20:01:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC012583643
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 20:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D8CE304D9F4
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 18:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AB22848A0;
	Tue, 19 May 2026 18:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="fmVQ5Hxq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AA33438BA;
	Tue, 19 May 2026 18:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779213705; cv=none; b=HchgU0gwAHjffut+QgaZUOEm9tG1xCLTmG+KtLWD0wU6zhlPGjWsDPRHAbWRzoG67A72KkXJDSWwDdguq9Fdjj1Pjteciex0M5r8mv840oFOxBRh6Yj5qvHil3Pmd8FUuhysw/rr0HtXLf1p3v/gUpPKl0ZRD8dAszKOZT3GK48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779213705; c=relaxed/simple;
	bh=DvCcxEMfljx0Moile2QWoAeMSvurqlzW6j+wzjUwdmA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E9xd3/+lc8CjwbPEH6daQitOUDRQuyKT6MFrcMa9mfcarkxtIwjH0Jot1Vyc1S9p5zjclmTeOdkhQYyrYxZdBfvMYpdbz8UJkaBjdID1Gqo+h84PtuYwdRi1fbF/ppMRBeSKasYd64u6C8kJAd5DmTCdVrPRpyJPr3craSDfbnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=fmVQ5Hxq; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J46HRS837486;
	Tue, 19 May 2026 11:01:39 -0700
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
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e7ab5eaum-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 19 May 2026 11:01:39 -0700 (PDT)
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
X-Authority-Analysis: v=2.4 cv=XNQAjwhE c=1 sm=1 tr=0 ts=6a0ca583 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=U_y8lYiYyhHBU5rMqhb2:22 a=VabnemYjAAAA:8 a=-0hxeGBmMInBsXaKhxMA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE3OSBTYWx0ZWRfXy5Yma67Z9AFp
 +6xYI3vid/3H5bUoE8OAfOrRZdY4O23Eg7lMqIoOJx5vWLyTnZeKOaXk7gH+MBCjq5FH0L2YRH/
 vftSJdbhuXYxTqQOEDI6FAoS7CrrWhmy9pfvWuY475w6IMQHaWMMrYqWYp6+9buGPnHZ/IbZY2Q
 zsJuUO7VrqtBaPOvMDZJ3EhzEYfLytUK9Tnc6RzVJFGg7nbR8EkVj5d2AoIDHef7gLQzlYDwjm5
 yQ9t4c8Ro74TulP6vpEZg5FVnqn0kWkJqdZXU72PXkEU6G0EprOnwjl/Pc/rOlzy6W1MlMx4wha
 xiznAg1xCC7+ekdFIE33IgF9WWoQetes4mBlO9lpXuTpSj7dSloOy3sOTt1TlgQJmIKmwhfkY9v
 G7+NKyNyocrIRVKlSby3r4aGxF8kP/5TX3sZXTI19iqUMGE7yUFyFF5Zxbm4VKtKsOlwt6m3PMr
 F7c0OQk9tKbJSEUn6wQ==
X-Proofpoint-ORIG-GUID: iRfZGVroGzAegL-RzzXU3F0czknGYqBy
X-Proofpoint-GUID: iRfZGVroGzAegL-RzzXU3F0czknGYqBy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21708-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CC012583643
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DESTROY_SESSION can free an nfsd4_session while a backchannel callback
for the same client is still live on rpciod, leaving clp->cl_cb_session
as a dangling pointer.

The first patch waits on cl_cb_inflight, and the second hopes to make
things harder to regress in the future by dropping a NULL in there.

Signed-off-by: Chris Mason <clm@meta.com>

