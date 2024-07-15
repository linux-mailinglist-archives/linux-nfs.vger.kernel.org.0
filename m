Return-Path: <linux-nfs+bounces-4909-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75339931347
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 13:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7982845AC
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 11:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE5D18A92F;
	Mon, 15 Jul 2024 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1FFE2h8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CD418A93C
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721043790; cv=none; b=sBk2F6vRrsPja4Va3ea2IgsUTyC8d+jWIoPPLPLR7uKxV82ibYab7hHoN3GA4pni66Oc27m8nig5uKRKDzjetjda67I+MmqDcp6mGtTzv5v8v5PcfzcY0S4QgfURs+DJXntxjritQxWC28p0e6R5pLdD6rFWfPrqP5mSUEInb7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721043790; c=relaxed/simple;
	bh=lPkUo+qEJMOSNPoeEMKotjaCvLtf2qS4ZsO3ZdXOcy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ColuTu911beNMpXIh8Q1BjDtr3uLuG4aqmnQ+cghQmjlYBzuW/1qeYRLu6OKErMULySs6Ql0MYadEvXv5hEppusBmh+AKPBAeFGBqN1NFVx8DwqY9YWTNq8MmotKvD8NCvGJGKHpVlGxNhubMFscoieU04gfecUjEl5ygVzJVJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1FFE2h8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD4DC32782;
	Mon, 15 Jul 2024 11:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721043790;
	bh=lPkUo+qEJMOSNPoeEMKotjaCvLtf2qS4ZsO3ZdXOcy8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r1FFE2h80XfRFy88wGnI/DfxMmy8CPjrhBSDZK8UjofhuMGdyoAgVxFgLndnyFEQ5
	 z0Viwo6GVJAB6yuuxKlK7voJ6ku+odImK8I+njiTep8e0m/+qd7YBAAOuzLx9JH9mT
	 y1t8HMi2dlnbFc2jD3dkQ/6YFKaaeK6CYtpaVD7hGEw4OZoEqpwFHzjfUx+BXtLCUE
	 wow4whPuJoEMae2ACHFe9YlZxJp17SOWx/D9AxboZyOPHiHkuKzchU5XwOvxNbD93L
	 owv2AWTAKk8QF1M+6uiUGJE6q1CIoivjPbZxgjSaQ0NhK7TNjSHHXhonx63PPduPRz
	 kSWpqjRpV1qPA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 15 Jul 2024 07:43:02 -0400
Subject: [PATCH 2/2] nfsdctl: fix compiler warnings
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-nfsdctl-v1-2-c09c314f540d@kernel.org>
References: <20240715-nfsdctl-v1-0-c09c314f540d@kernel.org>
In-Reply-To: <20240715-nfsdctl-v1-0-c09c314f540d@kernel.org>
To: Steve Dickson <steved@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Neil Brown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4999; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=lPkUo+qEJMOSNPoeEMKotjaCvLtf2qS4ZsO3ZdXOcy8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmlQtL1D4O72BEdJ/ElwYMoKIJgN9XEkyCJ1938
 u479xHJMQSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZpULSwAKCRAADmhBGVaC
 FeUoD/4mmQM5V7GAMUuLzgafSgpWMeGyNdhnPUw0Ds9nUfrU68Cxm8QqniWd6HbNYNtL4vXhOGk
 D1IUWe1fD1jxNBINL0df9m5MfKkC7ViDbBgI3Lz/jg2gGvD90aBXf41LGyEPUhwFXfy8k24qD/N
 Rid6Uo+iktIX8iYRC1Hhwo9k7iABDeq5I0MCx/FoNROZfPWBB3P+3IqLl77KJMYc15aLggN9C/X
 f7oKoSz+X+R+BeWU3dyZ/OQbS6lKMQd6/T8VLXq4A4MZKKLO8B4MgFu4KTUDxbNdcMcgfM9h/w7
 fPjya7s2VDeZohS5Tfhvg/DKMMzgKfFDMt+olA+uVpAaCM4+wF2+D0QNnlf4gD14bXNsc6vWoRn
 Ru6LV9Pu+VtH7f+Btb5uVo9Cbey4jVhA+YHYlrcqPMzFut0ChWs1cFJWn5sDxT1rCpkCRhduFXi
 ZRwETBNt95WIM2YvXprvv0Xg/Y+DRofXkq7y3aoUWOFSJAUH2Pqizo8S5y4B6s+6rRVEC4GXF+T
 DqMFWp6osMU4lMsGIg77peXEhfKeOE9ffgJL4iUa2OeqTpIuo06uqnrGG5/Sn2wh8JavoOZ5JBc
 62CNRL5Ym49baGVJlyoLUOHViMeQB8HlhkvfcsyY94l7et/gr52lYvCxmSVoyFHxIpo8Qyb8tK5
 PP96+YDNblIAFkQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Fix a pile of compiler warnings.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 utils/nfsdctl/nfsdctl.c | 48 ++++++++++++++----------------------------------
 1 file changed, 14 insertions(+), 34 deletions(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index eb2c8cca4f42..f7c276320085 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -44,7 +44,6 @@
  */
 
 static int debug_level;
-static int nl_family_id;
 
 struct nfs_version {
 	uint8_t	major;
@@ -84,16 +83,6 @@ static const struct option help_only_options[] = {
 	{ },
 };
 
-static void debug(int level, const char *fmt, ...)
-{
-	va_list args;
-
-	va_start(args, fmt);
-	if (level <= debug_level)
-		vprintf(fmt, args);
-	va_end(args);
-}
-
 #define NFSD4_OPS_MAX_LEN	sizeof(nfsd4_ops) / sizeof(nfsd4_ops[0])
 static const char *nfsd4_ops[] = {
 	[OP_ACCESS]		= "OP_ACCESS",
@@ -317,8 +306,6 @@ static void parse_threads_get(struct genlmsghdr *gnlh)
 
 	nla_for_each_attr(attr, genlmsg_attrdata(gnlh, 0),
 			  genlmsg_attrlen(gnlh, 0), rem) {
-		struct nlattr *a;
-
 		switch (nla_type(attr)) {
 		case NFSD_A_SERVER_GRACETIME:
 			printf("gracetime: %u\n", nla_get_u32(attr));
@@ -327,7 +314,7 @@ static void parse_threads_get(struct genlmsghdr *gnlh)
 			printf("leasetime: %u\n", nla_get_u32(attr));
 			break;
 		case NFSD_A_SERVER_SCOPE:
-			printf("scope: %s\n", nla_data(attr));
+			printf("scope: %s\n", (const char *)nla_data(attr));
 			break;
 		case NFSD_A_SERVER_THREADS:
 			pool_threads[i++] = nla_get_u32(attr);
@@ -352,7 +339,7 @@ static void parse_pool_mode_get(struct genlmsghdr *gnlh)
 			  genlmsg_attrlen(gnlh, 0), rem) {
 		switch (nla_type(attr)) {
 		case NFSD_A_POOL_MODE_MODE:
-			printf("pool-mode: %s\n", nla_data(attr));
+			printf("pool-mode: %s\n", (const char *)nla_data(attr));
 			break;
 		case NFSD_A_POOL_MODE_NPOOLS:
 			printf("npools: %u\n", nla_get_u32(attr));
@@ -366,7 +353,6 @@ static void parse_pool_mode_get(struct genlmsghdr *gnlh)
 static int recv_handler(struct nl_msg *msg, void *arg)
 {
 	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
-	const struct nlattr *attr = genlmsg_attrdata(gnlh, 0);
 
 	switch (gnlh->cmd) {
 	case NFSD_CMD_RPC_STATUS_GET:
@@ -573,7 +559,7 @@ static void threads_usage(void)
 static int threads_func(struct nl_sock *sock, int argc, char **argv)
 {
 	uint8_t cmd = NFSD_CMD_THREADS_GET;
-	uint32_t *pool_threads = NULL;
+	int *pool_threads = NULL;
 	int opt, pools = 0;
 
 	optind = 1;
@@ -589,7 +575,7 @@ static int threads_func(struct nl_sock *sock, int argc, char **argv)
 		char **targv = &argv[optind];
 		int i;
 
-		pools = argc - optind, i;
+		pools = argc - optind;
 		pool_threads = alloca(pools * sizeof(*pool_threads));
 		cmd = NFSD_CMD_THREADS_SET;
 
@@ -785,8 +771,7 @@ static void version_usage(void)
 
 static int version_func(struct nl_sock *sock, int argc, char ** argv)
 {
-	char *endptr = NULL;
-	int opt, ret, threads, i;
+	int ret, i;
 
 	/* help is only valid as first argument after command */
 	if (argc > 1 &&
@@ -940,7 +925,7 @@ static int update_listeners(const char *str)
 	char buf[INET6_ADDRSTRLEN + 16];
 	char sign = *str;
 	char *netid, *addr, *port, *end;
-	struct addrinfo *res, *ai;
+	struct addrinfo *res;
 	int i, ret;
 	struct addrinfo hints = { .ai_flags = AI_PASSIVE,
 				  .ai_family = AF_INET,
@@ -1156,9 +1141,7 @@ static void listener_usage(void)
 
 static int listener_func(struct nl_sock *sock, int argc, char ** argv)
 {
-	char *endptr = NULL;
-	int ret, opt, threads, i;
-	int argidx;
+	int ret, i;
 
 	/* help is only valid as first argument after command */
 	if (argc > 1 &&
@@ -1255,16 +1238,14 @@ static int pool_mode_func(struct nl_sock *sock, int argc, char **argv)
 
 	if (optind < argc) {
 		char **targv = &argv[optind];
-		int i;
 
 		cmd = NFSD_CMD_POOL_MODE_SET;
 
 		/* empty string? */
-		if (targv[i][0] == '\0') {
-			fprintf(stderr, "Invalid threads value %s.\n", targv[i]);
+		if (*targv[0] == '\0') {
+			fprintf(stderr, "Invalid threads value %s.\n", targv[0]);
 			return 1;
 		}
-
 		pool_mode = targv[0];
 	}
 	return pool_mode_doit(sock, cmd, pool_mode);
@@ -1272,18 +1253,17 @@ static int pool_mode_func(struct nl_sock *sock, int argc, char **argv)
 
 #define MAX_LISTENER_LEN (64 * 2 + 16)
 
-static int
+static void
 add_listener(const char *netid, const char *addr, const char *port)
 {
 		char buf[MAX_LISTENER_LEN];
-		int ret;
 
 		if (strchr(addr, ':'))
-			ret = snprintf(buf, MAX_LISTENER_LEN, "+%s:[%s]:%s",
-					netid, addr, port);
+			snprintf(buf, MAX_LISTENER_LEN, "+%s:[%s]:%s",
+				 netid, addr, port);
 		else
-			ret = snprintf(buf, MAX_LISTENER_LEN, "+%s:%s:%s",
-					netid, addr, port);
+			snprintf(buf, MAX_LISTENER_LEN, "+%s:%s:%s",
+				 netid, addr, port);
 		buf[MAX_LISTENER_LEN - 1] = '\0';
 		update_listeners(buf);
 }

-- 
2.45.2


