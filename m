Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABB847D885
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Dec 2021 22:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhLVVHP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Dec 2021 16:07:15 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27590 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231337AbhLVVHP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Dec 2021 16:07:15 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BMHx4g8010970
        for <linux-nfs@vger.kernel.org>; Wed, 22 Dec 2021 13:07:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=8OOc50qxKmAs5IiU6fBFOWB0HolbDTkGHMYiopQUJeI=;
 b=Niag5htqEPRBNAUr/n408y4UQvEunteAoNQhfeSTRfiKdxS3BlRrYeUU3i+sAj6/2rRu
 Gy3yYTnHCVXlzg3pXtzoadn52R6/z4+A6uGOMOekcCuDCE0CQcYq1kBB1l+AWFXgZGAs
 e8kjKNmpvv/HchZQmQYryD16TORPpNLVuVM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d40wrmh68-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-nfs@vger.kernel.org>; Wed, 22 Dec 2021 13:07:14 -0800
Received: from twshared21922.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 13:07:12 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id A8C6F86F0393; Wed, 22 Dec 2021 13:07:10 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <linux-nfs@vger.kernel.org>
CC:     <shr@fb.com>, Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v7 3/3] io_uring: add support for getdents64
Date:   Wed, 22 Dec 2021 13:07:08 -0800
Message-ID: <20211222210708.983429-4-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211222210708.983429-1-shr@fb.com>
References: <20211222210708.983429-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: bqmBnATL7-j1F2OgCDwJCMBFrBtntgMF
X-Proofpoint-ORIG-GUID: bqmBnATL7-j1F2OgCDwJCMBFrBtntgMF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-22_09,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 mlxlogscore=892 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112220111
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This adds support for getdents64 to io_uring.

Signed-off-by: Stefan Roesch <shr@fb.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c                 | 52 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/io_uring.h |  1 +
 2 files changed, 53 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5092dfe56da6..c8258c784116 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -693,6 +693,13 @@ struct io_hardlink {
 	int				flags;
 };
=20
+struct io_getdents {
+	struct file			*file;
+	struct linux_dirent64 __user	*dirent;
+	unsigned int			count;
+	loff_t				pos;
+};
+
 struct io_async_connect {
 	struct sockaddr_storage		address;
 };
@@ -858,6 +865,7 @@ struct io_kiocb {
 		struct io_mkdir		mkdir;
 		struct io_symlink	symlink;
 		struct io_hardlink	hardlink;
+		struct io_getdents	getdents;
 	};
=20
 	u8				opcode;
@@ -1107,6 +1115,9 @@ static const struct io_op_def io_op_defs[] =3D {
 	[IORING_OP_MKDIRAT] =3D {},
 	[IORING_OP_SYMLINKAT] =3D {},
 	[IORING_OP_LINKAT] =3D {},
+	[IORING_OP_GETDENTS] =3D {
+		.needs_file		=3D 1,
+	},
 };
=20
 /* requests with any of those set should undergo io_disarm_next() */
@@ -4068,6 +4079,42 @@ static int io_linkat(struct io_kiocb *req, unsigne=
d int issue_flags)
 	return 0;
 }
=20
+static int io_getdents_prep(struct io_kiocb *req, const struct io_uring_=
sqe *sqe)
+{
+	struct io_getdents *getdents =3D &req->getdents;
+
+	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
+		return -EINVAL;
+	if (sqe->ioprio || sqe->rw_flags || sqe->buf_index)
+		return -EINVAL;
+
+	getdents->pos =3D READ_ONCE(sqe->off);
+	getdents->dirent =3D u64_to_user_ptr(READ_ONCE(sqe->addr));
+	getdents->count =3D READ_ONCE(sqe->len);
+
+	return 0;
+}
+
+static int io_getdents(struct io_kiocb *req, unsigned int issue_flags)
+{
+	struct io_getdents *getdents =3D &req->getdents;
+	int ret;
+
+	if (issue_flags & IO_URING_F_NONBLOCK)
+		return -EAGAIN;
+
+	ret =3D vfs_getdents(req->file, getdents->dirent, getdents->count, &get=
dents->pos);
+	if (ret < 0) {
+		if (ret =3D=3D -ERESTARTSYS)
+			ret =3D -EINTR;
+
+		req_set_fail(req);
+	}
+
+	io_req_complete(req, ret);
+	return 0;
+}
+
 static int io_shutdown_prep(struct io_kiocb *req,
 			    const struct io_uring_sqe *sqe)
 {
@@ -6574,6 +6621,8 @@ static int io_req_prep(struct io_kiocb *req, const =
struct io_uring_sqe *sqe)
 		return io_symlinkat_prep(req, sqe);
 	case IORING_OP_LINKAT:
 		return io_linkat_prep(req, sqe);
+	case IORING_OP_GETDENTS:
+		return io_getdents_prep(req, sqe);
 	}
=20
 	printk_once(KERN_WARNING "io_uring: unhandled opcode %d\n",
@@ -6857,6 +6906,9 @@ static int io_issue_sqe(struct io_kiocb *req, unsig=
ned int issue_flags)
 	case IORING_OP_LINKAT:
 		ret =3D io_linkat(req, issue_flags);
 		break;
+	case IORING_OP_GETDENTS:
+		ret =3D io_getdents(req, issue_flags);
+		break;
 	default:
 		ret =3D -EINVAL;
 		break;
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.=
h
index 787f491f0d2a..57dc88db5793 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -143,6 +143,7 @@ enum {
 	IORING_OP_MKDIRAT,
 	IORING_OP_SYMLINKAT,
 	IORING_OP_LINKAT,
+	IORING_OP_GETDENTS,
=20
 	/* this goes last, obviously */
 	IORING_OP_LAST,
--=20
2.30.2

