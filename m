Return-Path: <linux-nfs+bounces-6989-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82410997623
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 22:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B3411F22FB4
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 20:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D681C1A256B;
	Wed,  9 Oct 2024 20:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAyyZ0VV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E9D173336;
	Wed,  9 Oct 2024 20:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728504152; cv=none; b=PNn7JSkqnlLBWxprZn5801SDPqQH0v0fg1jBEErEvwXSqcKTi5nrb6iVyusQEtrURBlzp9S1XZiMo1pMTFYJTYXGGU7PEJIvWFcD/GvpJmP76Ea1pH/6C8Gj8IrGMnWcYJqb/k0TAIziqgjzQ/ME3U0UNNe9C2cLX4PvIGkj9+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728504152; c=relaxed/simple;
	bh=fgFWJ/oEjnladuvaBsVXpkihxJsAI1TGvExLtbgb5ts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VtZCrNIi0MpuSJmYWeR0T3KahPw/jo/SBdweD1oHHDVB7yl2dlbnrJFHeHKpKkDMlHDrcOvXgbZ5oA2H0RdKpp8VgOTZTnx40jlHQnmH4eTZF3afiB8FJiLP+uQL38sLco1W87b67ED1m2KJ6gd1ywDIaOQ3T1IFyslnVmgsdLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAyyZ0VV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1C2C4CEC3;
	Wed,  9 Oct 2024 20:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728504152;
	bh=fgFWJ/oEjnladuvaBsVXpkihxJsAI1TGvExLtbgb5ts=;
	h=From:Date:Subject:To:Cc:From;
	b=WAyyZ0VVAQNVFpEs0S0ZmBeAclishnvxjKFUe8JiVW0wDb/mzu7fATm1+uFfrjCrH
	 paXDunQcP0B4OEB9g4fzkX31JNSUf0QwJVTNPNVixN/r4O4WrvYGibrZKGM2o0dFrU
	 O7txuLEI6rEiYcrMnP6onyl/HQhYGgeqioF81qiBEc5XxFY1nkcd5i2uaNC4R0q+VB
	 8SeGzEFlNqmDq8hI0B9DNn+A2q7RKpm3RX9eaaymzGZ9Y0lhSPnGHu1ro35a4HaWTk
	 0u+AsT/KYP7csBiksyJ9g9znHzDwEPuN99NIg/N1za6zCRtPXnED+dYqbGTInalw2I
	 BN8hrnnW5lqVw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 09 Oct 2024 16:02:21 -0400
Subject: [PATCH RFC] sunrpc: always set RPC_TASK_SOFTCONN in
 rpcb_register_call()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-nfsd-next-v1-1-058496d8960f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEzhBmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAwNL3by04hTdvNSKEl0zw8TEJEMjI8MUU0sloPqCotS0zAqwWdFKQW7
 OSrG1tQCVw6LWYAAAAA==
X-Change-ID: 20241009-nfsd-next-61aab1221d59
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+e7baeb70aa00c22ed45e@syzkaller.appspotmail.com, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1811; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=fgFWJ/oEjnladuvaBsVXpkihxJsAI1TGvExLtbgb5ts=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnBuFWQiWFs+1ydwTEjkd2Zk0m33kf5jdPXA+A9
 tZjinl55p2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZwbhVgAKCRAADmhBGVaC
 Fb7rD/sHGYMlrrmpufdLkyBGnJGvGX+cc2SN8ax9hbzpauITPC4Br+y1aCWRi3LKGUNGCrMTL50
 unoKUCO3VkP5NyK5V508TEuojCl84wPAn+arbcaqgPayeUBOk8Pdze6Gw6gk9wyDKfQbNBNe0oX
 oDyE4RfGjbZGCWBRjjiqh6L1+eOxjT8abRaT0Aioj+lSLoxNVhLh4RkQU+nxEC30LP8rXwI9lN8
 3+RcyfNQUT5mWqPkNZ+Cr7zSqpj25iMR8xEYVlQszJSsHlqUSONTikWG6ZXGsJk8MUq1w1ngAT3
 K3Vrvswha+uqg+fdiHYdsHq1PTr19euHUgAFL9EXWuHu6gdMVpGA2aVQYi205EKH4f2ZkufMFEF
 XTp0vd36Hs2RnzW2nmoq/+hYekTDzxaoLfmUEnVXwv9q0Mj+uvu2vguOYQL5lchzKL5sub0BhxI
 WEYNZbxqArRFxiC5Vz/4vveNV/w5LIhfgzmYabXjIHss1C74FUml4kl2IQH+WbdRqpJTOFZ0k37
 acOkNhfqndXuv5hRd4mpowwFyXDKEheNtVYhfhfHW/BijF8HlOINtfuJKWjpiSxa4qQcJUTxmuc
 caVbI0KGUT3TfJAa1kGTyf5IYGVN1IGwUmido4kVdVGvtRJn8ZIIIOMR84PADaTFDSCkR2cc6lE
 crr00JVlow7hcfQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

We've had a few hung task reports from syzbot fuzzing the nfsd netlink
control interfaces. We don't have hard evidence of this, but one way
this could happen is for userland to send down a large number of
listening sockets and for them all to get stuck dealing with the
portmapper.

Set RPC_TASK_SOFTCONN unconditionally in rpcb_register_call, instead of
only doing that on set requests or when rpcbind isn't using an AF_LOCAL
socket.

Reported-by: syzbot+e7baeb70aa00c22ed45e@syzkaller.appspotmail.com
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
This is a bit of a Hail Mary play, as we don't have any firm evidence
that this is the problem. Still, the scenario seems plausible, and it
doesn't seem to make much sense using different RPC_TASK flags on
rpcbind set and unset operations.
---
 net/sunrpc/rpcb_clnt.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/sunrpc/rpcb_clnt.c b/net/sunrpc/rpcb_clnt.c
index 102c3818bc54d4f9a1fc5f854c3a841289974869..f0cad9bb0752d51f82733b2f7533f2269b4c69c4 100644
--- a/net/sunrpc/rpcb_clnt.c
+++ b/net/sunrpc/rpcb_clnt.c
@@ -402,14 +402,10 @@ static struct rpc_clnt *rpcb_create(struct net *net, const char *nodename,
 
 static int rpcb_register_call(struct sunrpc_net *sn, struct rpc_clnt *clnt, struct rpc_message *msg, bool is_set)
 {
-	int flags = RPC_TASK_NOCONNECT;
 	int error, result = 0;
 
-	if (is_set || !sn->rpcb_is_af_local)
-		flags = RPC_TASK_SOFTCONN;
 	msg->rpc_resp = &result;
-
-	error = rpc_call_sync(clnt, msg, flags);
+	error = rpc_call_sync(clnt, msg, RPC_TASK_SOFTCONN);
 	if (error < 0)
 		return error;
 

---
base-commit: 144cb1225cd863e1bd3ae3d577d86e1531afd932
change-id: 20241009-nfsd-next-61aab1221d59

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


