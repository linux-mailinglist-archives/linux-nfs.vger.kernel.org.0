Return-Path: <linux-nfs+bounces-16217-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F72C44379
	for <lists+linux-nfs@lfdr.de>; Sun, 09 Nov 2025 18:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F883A5EAB
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Nov 2025 17:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E12F3019C0;
	Sun,  9 Nov 2025 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VLrx7IJK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE961E0083
	for <linux-nfs@vger.kernel.org>; Sun,  9 Nov 2025 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762708232; cv=none; b=mSbOdjLcKA7YOAmJWoNsC5MoPNAyvBMS8biln05trTFVfB94L3dwS9XZ3cz/eWdV86vO5bpF5nufz9Ttt666SwQtOUhmiQTjhTdFdrnDc7NI0yq+IsXJ6iYtobuKJEtKpn1HNRC6SByS8PL3iTD2oNUOaHD4GiwvpyppqmQUQhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762708232; c=relaxed/simple;
	bh=L2TEEkoCgu6y0av2g3O8h9FI8CG25KGvc2xukF29Pro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u4M4mx7MLU+x5S/mJgrmFZQ2zzJLJrsKJ3VcLB590IV+hHzUwUTWPWYKryPKiWzVSvPkmudBMlFtMGWYfxz5R3fXYXaN8qAb/AmUBq5zEDaA7cP6m0eavGAkQcQGAVVwmQJN6bkaCYgtGr2AL+A5zzi9y86lpNaFasSaFpbnkQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VLrx7IJK; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A9GHRC9021721;
	Sun, 9 Nov 2025 17:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=dWte5/eGknXv3pMKJHff9Xd8KD0ri
	CRncZbeIL9d0UI=; b=VLrx7IJK2mdW8Rx0K0eJfiftubLjyPW+MrdbqfYrkKd8/
	vcUjvonrtXChmWPTmttdMKpQFPjlLscFY9lyg7bhcrMB5Hw6BqKGhAXap9MASTml
	hmaOc4zE7SbFmXYtZ2OW5AChC06tn52HRJAjzeYI89z3MdteolDv/tmbjhitvWwt
	S0SkHIh+HKT1FqjgFWozjKGFU+rlF6YQQnqJN/nAfcLDHqhHM06hUjHF7VnP+kSf
	y5608+M1zVXYa6t9Mq5spFjCBfcE1N4qjTTjEPTI0eD+70vdYtBN6WGPpctw6SfC
	tbC43mp+9ppnlqfLXYEpZpBAN9YC9k7rdveRp3rlw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aarydg9ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 09 Nov 2025 17:10:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A9BJ2Ie007383;
	Sun, 9 Nov 2025 17:05:21 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9va7tsk1-1;
	Sun, 09 Nov 2025 17:05:21 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: trondmy@kernel.org, anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFS: Fix LTP test failures when timestamps are delegated
Date: Sun,  9 Nov 2025 09:05:08 -0800
Message-ID: <20251109170517.2730183-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_07,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511090150
X-Proofpoint-ORIG-GUID: nkv7ncH24IZIdF6w1B8X0zrBhhPFtr1Y
X-Proofpoint-GUID: nkv7ncH24IZIdF6w1B8X0zrBhhPFtr1Y
X-Authority-Analysis: v=2.4 cv=AtjjHe9P c=1 sm=1 tr=0 ts=6910cafe cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=JDWldgB-vNn1QpYc8cAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDA4OSBTYWx0ZWRfX7woReGAU/sUc
 x+aCJXuQXM1VCgBPq045yB/s2t5XqFKUg5YkisuhuYjyeCVKqPKAGllT+1czY9ffhFVgz4XxQuG
 uylbVQ/12KA0E7HHRNJsxD4suMrBcsZvdj6cR2s97EsOXFQ6Z8/tNSFlWc6Q2/RCp8zm2xjsDqW
 Yv4n2j//RfuUMcwT73baFn9ZuupC7HU7qbSWMy3Jv5BAz44RAYS8LdHR+JjLAEaHzbn56E2nobA
 gblYzRiQT5DfbPK/XMLtN5EAPoHdnEggyXnsMJnyQ5L7W91plRjZ3BjSJQikaeGLQ7UwghsCClh
 5Z4KsjEg++k7VVEdZSzs74x+W2ZsiZy2W6LUWl8JfT1pNkb7z6Bxkm/F1q7b6Lhj2faO78ntQv/
 GUyXMz/M9u2WPSTKPOF4/NgEd6U7hQ==

The utimes01 and utime06 tests fail when delegated timestamps are
enabled, specifically in subtests that modify the atime and mtime
fields using the 'nobody' user ID.

The problem can be reproduced as follow:

# echo "/media *(rw,no_root_squash,sync)" >> /etc/exports
# export -ra
# mount -o rw,nfsvers=4.2 127.0.0.1:/media /tmpdir
# cd /opt/ltp
# ./runltp -d /tmpdir -s utimes01
# ./runltp -d /tmpdir -s utime06

This issue occurs because nfs_setattr does not verify the inode's
UID against the caller's fsuid when delegated timestamps are
permitted for the inode.

This patch adds the UID check and if it does not match then the
request is sent to the server for permission checking.

Fixes: e12912d94137 ("NFSv4: Add support for delegated atime and mtime attributes")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfs/inode.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 18b57c7c2f97..13ad70fc00d8 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -718,6 +718,8 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct nfs_fattr *fattr;
 	loff_t oldsize = i_size_read(inode);
 	int error = 0;
+	kuid_t task_uid = current_fsuid();
+	kuid_t owner_uid = inode->i_uid;
 
 	nfs_inc_stats(inode, NFSIOS_VFSSETATTR);
 
@@ -739,9 +741,11 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (nfs_have_delegated_mtime(inode) && attr->ia_valid & ATTR_MTIME) {
 		spin_lock(&inode->i_lock);
 		if (attr->ia_valid & ATTR_MTIME_SET) {
-			nfs_set_timestamps_to_ts(inode, attr);
-			attr->ia_valid &= ~(ATTR_MTIME|ATTR_MTIME_SET|
+			if (uid_eq(task_uid, owner_uid)) {
+				nfs_set_timestamps_to_ts(inode, attr);
+				attr->ia_valid &= ~(ATTR_MTIME|ATTR_MTIME_SET|
 						ATTR_ATIME|ATTR_ATIME_SET);
+			}
 		} else {
 			nfs_update_timestamps(inode, attr->ia_valid);
 			attr->ia_valid &= ~(ATTR_MTIME|ATTR_ATIME);
@@ -751,10 +755,12 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		   attr->ia_valid & ATTR_ATIME &&
 		   !(attr->ia_valid & ATTR_MTIME)) {
 		if (attr->ia_valid & ATTR_ATIME_SET) {
-			spin_lock(&inode->i_lock);
-			nfs_set_timestamps_to_ts(inode, attr);
-			spin_unlock(&inode->i_lock);
-			attr->ia_valid &= ~(ATTR_ATIME|ATTR_ATIME_SET);
+			if (uid_eq(task_uid, owner_uid)) {
+				spin_lock(&inode->i_lock);
+				nfs_set_timestamps_to_ts(inode, attr);
+				spin_unlock(&inode->i_lock);
+				attr->ia_valid &= ~(ATTR_ATIME|ATTR_ATIME_SET);
+			}
 		} else {
 			nfs_update_delegated_atime(inode);
 			attr->ia_valid &= ~ATTR_ATIME;
-- 
2.47.3


