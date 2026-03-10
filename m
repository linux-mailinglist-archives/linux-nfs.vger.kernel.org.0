Return-Path: <linux-nfs+bounces-19939-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFP/EowPsGkpfAIAu9opvQ
	(envelope-from <linux-nfs+bounces-19939-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 13:33:16 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B56A624DFF2
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 13:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40982333CCF8
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 12:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5196A3BC66B;
	Tue, 10 Mar 2026 11:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="ITpeZZvC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0575E48BD43;
	Tue, 10 Mar 2026 11:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143761; cv=none; b=Xt3hf45Kim9xt71KKhe5gH9NUXSSGmZiaE1bKtaSk/jy4ku3M9jP9oekZFBSQcbjIYjGi3o/5iWt+d5FlDlyt+chT5wjpozw/GluzEhIGOrz5PnZ0a+kSe05EHNYT54EuZba43FDeN68uYjDf9lIjuFZDv+64j7HvBL6eJnc/X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143761; c=relaxed/simple;
	bh=K9CWTyYKGB0w6Tk2xrcCabYj/9tltesZ0HvDiXE6CGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IKhlN0sVw6CLK61j6Kkt6bCwndjPLBw3QFm7xNFHm/r14Kc1MvsOaz+mkoAqK5oUSvKSAoyglZI9bRs3G8xUGA3tKtpvvxwTFlXJXOnrS8FFqNyo79GrOPFWCDK1wcsNcM7N502yWhhxYo1+T/r821LRcoRUXwWV8LI20txewo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=ITpeZZvC; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143726; bh=K9CWTyYKGB0w6Tk2xrcCabYj/9tltesZ0HvDiXE6CGA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ITpeZZvCuurO6PtLvdRtRS5nd/bZCx1ndt94VbmepmWY6QteCwWswdiO1VbAljY8r
	 fKxVkij1nMq0v9Gab/FV6dxJIQZxwXhWwA5TgvQnG1MilGO8jeOzxFRlzhEz0vggaA
	 hWfQSJYU7rq79j74Br0/ZAepDgNZ+brN6WE4sbn0=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006ac-b734-7f0000032729-7f000001c05e-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:24 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:24 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:54 +0100
Subject: [PATCH 28/61] net/sched: Prefer IS_ERR_OR_NULL over manual NULL
 check
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-28-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
To: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-mm@kvack.org, 
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org, 
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, 
 Philipp Hahn <phahn-oss@avm.de>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1649; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=K9CWTyYKGB0w6Tk2xrcCabYj/9tltesZ0HvDiXE6CGA=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAY0Ab3VO2a9CLyi58wXwo/lqSwdB2G61GV4k
 bTbJSvyEGOJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGNAAKCRA0LQZT0ays
 24mRB/9btDfW+RDwuaye8LPDtf1ZUJwDncM7Zgyp6SHFDbDBBUCY5jMLThJncFGvw3pVn6MHlrR
 e+vSLwaJsDAVLn6K23Z4PPrutM/glgm9IAew2t89ZwRwFxQzfV+39rXZfBmOC/J16tW6tO1iy8k
 2C61WhK0hJtogp/FtZ3yHRbCwt8dKoLmF2qlw1QSQLKl8LOMWf3xw4Hzsu7PORnm8NiE+tP0SiT
 14xuZtoKpdLMjWGJyLVgKFIFQUVZBRep4Y+ogBPonV7uWFQl+T8Y21kTTXl++qp7tP7BH5AxDRw
 qjRRlFGTUp8rPbK2m+WUcf3WaJPpbUCWbYm05Bbm4z30Dms3
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143724-025C1A3D-E80041E6/0/0
X-purgate-type: clean
X-purgate-size: 1651
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: B56A624DFF2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[avm.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[avm.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[avm.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19939-lists,linux-nfs=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[61];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,davemloft.net:email,avm.de:dkim,avm.de:email,avm.de:mid,resnulli.us:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Jamal Hadi Salim <jhs@mojatatu.com>
To: Jiri Pirko <jiri@resnulli.us>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 net/sched/cls_api.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 4829c27446e3369ad2ae9b3fcb285eca47d59933..4208225e7a4acaf0c331096ebf941f68cc2ed992 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2444,7 +2444,7 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 		tcf_chain_tp_delete_empty(chain, tp, rtnl_held, NULL);
 errout_tp:
 	if (chain) {
-		if (tp && !IS_ERR(tp))
+		if (!IS_ERR_OR_NULL(tp))
 			tcf_proto_put(tp, rtnl_held, NULL);
 		if (!tp_created)
 			tcf_chain_put(chain);
@@ -2612,7 +2612,7 @@ static int tc_del_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 
 errout:
 	if (chain) {
-		if (tp && !IS_ERR(tp))
+		if (!IS_ERR_OR_NULL(tp))
 			tcf_proto_put(tp, rtnl_held, NULL);
 		tcf_chain_put(chain);
 	}
@@ -2741,7 +2741,7 @@ static int tc_get_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 	tfilter_put(tp, fh);
 errout:
 	if (chain) {
-		if (tp && !IS_ERR(tp))
+		if (!IS_ERR_OR_NULL(tp))
 			tcf_proto_put(tp, rtnl_held, NULL);
 		tcf_chain_put(chain);
 	}

-- 
2.43.0


