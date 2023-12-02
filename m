Return-Path: <linux-nfs+bounces-256-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DE2801E8F
	for <lists+linux-nfs@lfdr.de>; Sat,  2 Dec 2023 22:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFDD5280FBC
	for <lists+linux-nfs@lfdr.de>; Sat,  2 Dec 2023 21:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A3321112;
	Sat,  2 Dec 2023 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="eTNUBpMi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8C0107;
	Sat,  2 Dec 2023 13:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1701551252;
	bh=VWfb+Oof5K+/qAsblEllhoGVJptKMJhsPx5j7DgelbA=;
	h=From:To:Cc:Subject:Date;
	b=eTNUBpMirTPOzb168hbFitzXTV0rCuYP3RNp7TQ699xf/TP0G149xq/fh+TzEhw2W
	 ttoSB1Wu/Voo1l05NZAU4hLpE2r9S5maaUD3aRE5V1/nue6H9Jv9SO/Yl/b5tGlj7f
	 FmpG1Gn9nyPAss5b7GFryhRqSwcj2RuVW8XZBrF4=
Received: from rm-workspace.. ([116.128.244.171])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 1DBA2603; Sun, 03 Dec 2023 05:07:27 +0800
X-QQ-mid: xmsmtpt1701551247thbhr8aak
Message-ID: <tencent_03EDD0CAFBF93A9667CFCA1B68EDB4C4A109@qq.com>
X-QQ-XMAILINFO: MmPNY57tR1XnAJhBNiCUAVr9YIJBvy1yMV2dHgPMD1aC0rNbkcD/tg5g7ycdRu
	 0mHJ7BGScmA71+pO1OwAngMhGWsaOXnWSxo+r4wg71Zgy8KUwOp/rwr8ty/ACUvltuOBciBk0PKy
	 nXhP5DcExj+LrbechxpBcb1T+8+ZgQnFeE+TkZt92z43sZD5a5DCS8OrjMdpAzWmfPjZVQQ4tyfG
	 VuHwz2QO3zoTUipwD6YVud2a9rXkleFS1hHCm7U2/jUgdZFVpAX4h8MyhfTdKQkr+V5i+mTYPZ3D
	 tPOKDnjGt/huw9eGT8FPYKXJNYHu8tRaZXNbFpbPb8aDHMloxOojPaasdi8moPTGTYj3r/iR0f32
	 VJBbtCenwpGwtxngQGZ+q8Is5DOrWTFCz+eWl36wR3/LHisef6LhIn3/4Tqi0Be/xLp/IJVi1h7i
	 ZjejXM7M/QXvl77i721HncndbuIyIUYWMxfgFv99BnXnBdi9suHIE+R6xWLcPgWYjuYExvKVj5fO
	 sF5a8ePLTV5KpczPzTsfrF1Sug+79Ba6n6DKiyBUzAfdL2eV0FLhkWdFXnIBtsFOsJFLKGhQxmCw
	 tGduW+ME3Eg/lEOW1jYQrhHG9+USxxiFkmsUsK64F2qQuRiHVX9/He4sxm1j4YQQuqdZN8yFmlGA
	 n7heHIrj/gf/xPR7XdcH+WV0iwVv4a46Z01tPWElvxZU2sQpwurZhqb1cBDa5vfOoGPiZyhjWLbj
	 DodoSyTJtiBnqu7Sa8Ko4aXeToHOLsOTFUUOcNddYdgx/u6h1/EgPEvL8OQKnOZnMkZWNsMvbqru
	 csVo/mKA670PsRZVQwxfEmHerPHWL2gkJAYLW+0lE34bd1cOAIvM90l9KQQQq4P8QcOkp/+Futd+
	 J3MY6Kfh64dyVjuEWgLYb3cpBUjiiHhzvrnzVdVx8DK3pTEZkP7mG9DawYTBKYBkLGNONyYTWCpX
	 rr+yFjaqCdcvTo9iuekP3KTNtGqD9lUIqg8DizK6ZndwSh0ZRnAeobrvaA+NW8
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: chenxiaosongemail@foxmail.com
To: trond.myklebust@hammerspace.com,
	anna@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	kolga@netapp.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenxiaosongemail@foxmail.com,
	chenxiaosong@kylinos.cn,
	liuzhengyuan@kylinos.cn,
	huhai@kylinos.cn,
	liuyun01@kylinos.cn
Subject: [PATCH] NFSv4, NFSD: move enum nfs_cb_opnum4 to include/linux/nfs4.h
Date: Sat,  2 Dec 2023 21:07:25 +0000
X-OQ-MSGID: <20231202210725.706925-1-chenxiaosongemail@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

Callback operations enum is defined in client and server, move it to
common header file.

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 fs/nfs/callback.h      | 19 -------------------
 fs/nfsd/nfs4callback.c | 26 +-------------------------
 include/linux/nfs4.h   | 22 ++++++++++++++++++++++
 3 files changed, 23 insertions(+), 44 deletions(-)

diff --git a/fs/nfs/callback.h b/fs/nfs/callback.h
index ccd4f245cae2..0279b78b5fc9 100644
--- a/fs/nfs/callback.h
+++ b/fs/nfs/callback.h
@@ -19,25 +19,6 @@ enum nfs4_callback_procnum {
 	CB_COMPOUND = 1,
 };
 
-enum nfs4_callback_opnum {
-	OP_CB_GETATTR = 3,
-	OP_CB_RECALL  = 4,
-/* Callback operations new to NFSv4.1 */
-	OP_CB_LAYOUTRECALL  = 5,
-	OP_CB_NOTIFY        = 6,
-	OP_CB_PUSH_DELEG    = 7,
-	OP_CB_RECALL_ANY    = 8,
-	OP_CB_RECALLABLE_OBJ_AVAIL = 9,
-	OP_CB_RECALL_SLOT   = 10,
-	OP_CB_SEQUENCE      = 11,
-	OP_CB_WANTS_CANCELLED = 12,
-	OP_CB_NOTIFY_LOCK   = 13,
-	OP_CB_NOTIFY_DEVICEID = 14,
-/* Callback operations new to NFSv4.2 */
-	OP_CB_OFFLOAD = 15,
-	OP_CB_ILLEGAL = 10044,
-};
-
 struct nfs4_slot;
 struct cb_process_state {
 	__be32			drc_status;
diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 92bc109dabe6..30aa241038eb 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -31,6 +31,7 @@
  *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+#include <linux/nfs4.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/xprt.h>
 #include <linux/sunrpc/svc_xprt.h>
@@ -101,31 +102,6 @@ static int decode_cb_fattr4(struct xdr_stream *xdr, uint32_t *bitmap,
 	return 0;
 }
 
-/*
- *	nfs_cb_opnum4
- *
- *	enum nfs_cb_opnum4 {
- *		OP_CB_GETATTR		= 3,
- *		  ...
- *	};
- */
-enum nfs_cb_opnum4 {
-	OP_CB_GETATTR			= 3,
-	OP_CB_RECALL			= 4,
-	OP_CB_LAYOUTRECALL		= 5,
-	OP_CB_NOTIFY			= 6,
-	OP_CB_PUSH_DELEG		= 7,
-	OP_CB_RECALL_ANY		= 8,
-	OP_CB_RECALLABLE_OBJ_AVAIL	= 9,
-	OP_CB_RECALL_SLOT		= 10,
-	OP_CB_SEQUENCE			= 11,
-	OP_CB_WANTS_CANCELLED		= 12,
-	OP_CB_NOTIFY_LOCK		= 13,
-	OP_CB_NOTIFY_DEVICEID		= 14,
-	OP_CB_OFFLOAD			= 15,
-	OP_CB_ILLEGAL			= 10044
-};
-
 static void encode_nfs_cb_opnum4(struct xdr_stream *xdr, enum nfs_cb_opnum4 op)
 {
 	__be32 *p;
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index c11c4db34639..ef8d2d618d5b 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -869,4 +869,26 @@ enum {
 	RCA4_TYPE_MASK_OTHER_LAYOUT_MAX	= 15,
 };
 
+enum nfs_cb_opnum4 {
+	OP_CB_GETATTR = 3,
+	OP_CB_RECALL  = 4,
+
+	/* Callback operations new to NFSv4.1 */
+	OP_CB_LAYOUTRECALL  = 5,
+	OP_CB_NOTIFY        = 6,
+	OP_CB_PUSH_DELEG    = 7,
+	OP_CB_RECALL_ANY    = 8,
+	OP_CB_RECALLABLE_OBJ_AVAIL = 9,
+	OP_CB_RECALL_SLOT   = 10,
+	OP_CB_SEQUENCE      = 11,
+	OP_CB_WANTS_CANCELLED = 12,
+	OP_CB_NOTIFY_LOCK   = 13,
+	OP_CB_NOTIFY_DEVICEID = 14,
+
+	/* Callback operations new to NFSv4.2 */
+	OP_CB_OFFLOAD = 15,
+
+	OP_CB_ILLEGAL = 10044,
+};
+
 #endif
-- 
2.34.1


