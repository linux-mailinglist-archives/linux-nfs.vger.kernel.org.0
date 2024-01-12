Return-Path: <linux-nfs+bounces-1056-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8113482BC7B
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jan 2024 09:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 209E2B226D4
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jan 2024 08:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F1B524BC;
	Fri, 12 Jan 2024 08:47:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.231.56.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C220255776;
	Fri, 12 Jan 2024 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from luzhipeng.223.5.5.5 (unknown [39.174.92.167])
	by mail-app4 (Coremail) with SMTP id cS_KCgD3Wd1M_KBlIPG4AA--.22411S2;
	Fri, 12 Jan 2024 16:46:05 +0800 (CST)
From: Zhipeng Lu <alexious@zju.edu.cn>
To: alexious@zju.edu.cn
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simo Sorce <simo@redhat.com>,
	Steve Dickson <steved@redhat.com>,
	Kevin Coffman <kwc@citi.umich.edu>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] SUNRPC: fix a memleak in gss_import_v2_context
Date: Fri, 12 Jan 2024 16:45:38 +0800
Message-Id: <20240112084540.3729001-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cS_KCgD3Wd1M_KBlIPG4AA--.22411S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWkGFWxKrW7tr17uFW3KFg_yoW8XryUpF
	Z8Z347trZ8WFWIyF9akFyUZ3W3Aw4kJryUWanFqw43ZrnaqFyUKF1qkryj9FWrZr4rXF1U
	CF1UGF98Z3WDuwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjfUYv38UUUUU
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/

The ctx->mech_used.data allocated by kmemdup is not freed in neither
gss_import_v2_context nor it only caller radeon_driver_open_kms.
Thus, this patch reform the last call of gss_import_v2_context to the
gss_krb5_import_ctx_v2, preventing the memleak while keepping the return
formation.

Fixes: 47d848077629 ("gss_krb5: handle new context format from gssd")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---
Changelog:

v2: add non-error case
---
 net/sunrpc/auth_gss/gss_krb5_mech.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index e31cfdf7eadc..5e6f90d73858 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -398,6 +398,7 @@ gss_import_v2_context(const void *p, const void *end, struct krb5_ctx *ctx,
 	u64 seq_send64;
 	int keylen;
 	u32 time32;
+	int ret;
 
 	p = simple_get_bytes(p, end, &ctx->flags, sizeof(ctx->flags));
 	if (IS_ERR(p))
@@ -450,8 +451,16 @@ gss_import_v2_context(const void *p, const void *end, struct krb5_ctx *ctx,
 	}
 	ctx->mech_used.len = gss_kerberos_mech.gm_oid.len;
 
-	return gss_krb5_import_ctx_v2(ctx, gfp_mask);
+	ret = gss_krb5_import_ctx_v2(ctx, gfp_mask);
+	if (ret) {
+		p = ERR_PTR(ret);
+		goto out_free;
+	};
 
+	return 0;
+
+out_free:
+	kfree(ctx->mech_used.data);
 out_err:
 	return PTR_ERR(p);
 }
-- 
2.34.1


