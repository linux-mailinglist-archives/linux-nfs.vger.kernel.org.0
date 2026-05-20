Return-Path: <linux-nfs+bounces-21721-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLUCMcQBDWrorwUAu9opvQ
	(envelope-from <linux-nfs+bounces-21721-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 02:35:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4837C5864C4
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 02:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4781A3022F43
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 00:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E971DF254;
	Wed, 20 May 2026 00:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tq8sJrEU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1572222301;
	Wed, 20 May 2026 00:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779237312; cv=none; b=GTeT/L/8DGNHkzBZUQ8lPmWz/L7hhWzupPYf0IU2q1Z1GWfr0TApFs/s1ghUHAyGqUGgpHBSXdKxk+T7jifmeZDcVSZVV2drXwLW+7VKXSNWaGmst0Oe7v4kB6DGxlozi7DRmrxTE5hKfj3OcHeZ0M3nvlnXpr1hQxpoqT6NmvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779237312; c=relaxed/simple;
	bh=gBBmIGIvvDcvzP/nykn4MU2HxGEz/zm2dRswjzzjfTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qZ79GM3/xBxqsnQsEEEzQQxpoYsGjUPSNPjhVh10Ye8G9S9EyxnioyQ2Jxv2OjMWjnpXefnuxVxRLX9PWZUr0i/83vX5uBFuBpMYyP4Fv/DhdzFhnGXHAvs7nRlY3I0Fwr+F97OZ2r0NWPFQjfdyFvQHnnGYbwIIgrXhoSawzmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tq8sJrEU; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JJcMko1518944;
	Wed, 20 May 2026 00:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=gBBmIGIvvDcvzP/nykn4MU2HxGEz/
	zm2dRswjzzjfTc=; b=Tq8sJrEUbO7bv9vxT62GnWsV+Kj95p2vdQhKIXStOb52Q
	U/Km2tKrV3YwOh2yqWwqL6q4uTjU8h53Pfayhrc56G/l8kZ84Y4iUoc0yIJeyDj0
	KQ3VRgt1zY6vbQOGd/5eOk2Q2/BEb2oMl8Zl+e5ii5ctsNozAite2QVD9weIKHGy
	AXwmVvR6oen1V+CjVIaJdDpbdReLRUphGdmSPblJmLlelPzL1kPdj0juO9f4Wd7L
	yoT5jLhlLa//k1QSo6skzIGcETpOidCB62zvTyNEZ4i8wWOsuLhbKfSJXohLyK9r
	6B31VWyz4wIb1TjpkhwHI825N/xUpp/NYg1h+7gqg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h2cp28m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 00:35:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64K0OsSw006236;
	Wed, 20 May 2026 00:35:07 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4e84ecyhhb-1;
	Wed, 20 May 2026 00:35:07 +0000 (GMT)
From: Dai Ngo <dai.ngo@oracle.com>
To: cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] xfs: correct pNFS layout mappings
Date: Tue, 19 May 2026 17:32:57 -0700
Message-ID: <20260520003503.2399326-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=616 mlxscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605200002
X-Proofpoint-ORIG-GUID: 8SCuozDJZWavvrd8KbW4aO2vyY2lGVz9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDAwMyBTYWx0ZWRfXwnUBZsbEL3se
 fgQDZ+ZKY/ElipXFXsZBvn/QlkwV3gZIemApvGZEYfD9pwYTmUmfnVTlvC9QGq7uG+tH/ohdXZI
 qgC3bfDjKYjXt7njOftYMqe7QiYXaLH6ngDxOg3JWSvuh18gjWCtTW/driFQIyvPyRS3uKhaYkC
 dyJL7BA1zvM2Mdgv4D9jSQoj+comvIwg7l51f/mDDVBqZGWC5nV3mD1Mt3kNIq1JdiQ2N9D3fsA
 Q5KEtC/Ykv9sXOlWcHY5+bKLfssj+JyWVdTCHe4XVrv7tbg5hDVhvEMcdvNNxb+2Nzr5JwliEA5
 xGpVLANDdQGeqxtzi1+Mm5dGFObVs9bq0G8d0h9qzCa5Mxr7jFt6CE/2EUNe91WeGH1z+n7GRat
 flDBoM8VvjmmyDTZd7FUSwUOL9WUebMYzWiHSrrsbGOFZb/+UqrgiJ0VWuGbEIyj0El2NuaxAab
 F7VclO94KrgG0p7CJZQ9WxiIIjCLZFqwS3Kv9eU0=
X-Authority-Analysis: v=2.4 cv=Ws4b99fv c=1 sm=1 tr=0 ts=6a0d01bc b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=NoKN66te_Ye6Xul4tnkA:9 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13839
X-Proofpoint-GUID: 8SCuozDJZWavvrd8KbW4aO2vyY2lGVz9
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21721-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4837C5864C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series fixes pNFS layout mapping issues exposed by running
xfstests generic/075 against an NFSv4.2 block layout export. The first
change stops xfs_fs_map_blocks() from propagating an uninitialized
mapping record after xfs_bmapi_read() fails.

The second change removes the XFS_BMAPI_ENTIRE flag so each request
only returns the range the client asked for, eliminating overlapping
in LAYOUTGET replies.

Dai Ngo (2):

xfs: fix use of uninitialized imap in xfs_fs_map_blocks error path
xfs: fix overlapping extents returned for pNFS LAYOUTGET

fs/xfs/xfs_pnfs.c | 11 +++++++----
1 file changed, 7 insertions(+), 4 deletions(-)

