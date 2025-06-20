Return-Path: <linux-nfs+bounces-12591-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39449AE1ACD
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 14:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C712C1BC7C26
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 12:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B2028D839;
	Fri, 20 Jun 2025 12:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJZ652e/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF29F28CF6D;
	Fri, 20 Jun 2025 12:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750421789; cv=none; b=d3celHEaglLjqAQaKDPxKM5bT8huKZiVQNiCzNiHUgsm/zbJoCG0GsQ3O2tKYlJhuNJQ9wbnEtysisqKnnPq6a3PrrAF4g4CZI4PY1h+mRGigLimoV9q88oXQVXZqjHT8VopkU4CEmoK532/MbAQE3CZc0X4/Jzh7vv43BAtTc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750421789; c=relaxed/simple;
	bh=cf+8nzovA1CjEL6DUkxai/zqOEpw1mZXQ4r1c3QpvAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WdVUsz5b8rpZyJYmDOU8BMP+03FPOks1wUejPNXnIAG4CyvZGRPJQVm59iTr9m8wWnIAqt5RRP5+hybrbYTyT5CnDp/gYIMZK9Pk7gtqaSvIsK1QmZwx8MjeB4I/DbFNZOj9OyRdUybGJrAFqNDakAWcbEmDnYax7NQYNnhMppU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJZ652e/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A215C4CEFC;
	Fri, 20 Jun 2025 12:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750421788;
	bh=cf+8nzovA1CjEL6DUkxai/zqOEpw1mZXQ4r1c3QpvAA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vJZ652e/ss4SDtoM7qFAyAcv40H5MlKPUk3gk+iRDf8L5MGwjsk2UrL8kxq0e+mnS
	 CxdROLggxLhGzN3Ntzz/tCJFwvlxxXvzsqU50RlDhbNwUPDTGcnBhP6nNXbWssh1au
	 Xq8yUZ4eHufQKjq4mvuSLOEgX8FLkFhSeqpBnCbGCamuvTFmrD2ise6kPRur0XlSXO
	 z/Tlz+Tit0u0+GLbs+JYjaLmabWn9OUKpj/90wcQTVhnyam2fsSCjQWAuJf5oQ7nqO
	 CUl95k0aseKeoT+Q4LIukeV9j9exa8h4M+qtIjiQRHn8j14Q2pvu8qOb/Vn7xnezyt
	 +5DBlY/EIoaAg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 20 Jun 2025 08:16:05 -0400
Subject: [PATCH 5/6] sunrpc: rearrange struct svc_rqst for fewer cachelines
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-rpc-6-17-v1-5-a309177d713b@kernel.org>
References: <20250620-rpc-6-17-v1-0-a309177d713b@kernel.org>
In-Reply-To: <20250620-rpc-6-17-v1-0-a309177d713b@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=943; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=cf+8nzovA1CjEL6DUkxai/zqOEpw1mZXQ4r1c3QpvAA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoVVEWnMmJexRGAg+wqJl1mPnsUqjPM8mZIbv2m
 hyZQJKoTZGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaFVRFgAKCRAADmhBGVaC
 FUwsD/90dg48flxlQLUiI/W2g3M/butAWG6HH7O0P5ctSDkMw90+2D1rqj4KH7Zu9xWADr7fpB7
 ZQ6n+rks6iNDU+ane0IDYs6CSNeQjDfsBaPa8qZ2N9m6hI2a5xXDt9pu8X6HLcX7SjJsYZgXasX
 VwQI+s+wseA74+rcfb3a8alpGriDBjVKaniHswFz/ebyba6K7J+bnTDy/QayU4CLz1zL601vCMs
 bxnv0E/rEIP9SNwdCd8cNPpf6nEpUu0XcD2sM8auQHYv42Stk7bsEbUSmHeeNlTKBvF6JagGpBu
 2hcMFtj5HSlSke42k6cLWXqzDl7PtIXOhz4ieX65SrLPOALf3KEA1AfnIBDPsgiPcr0SIJfFvxt
 11TOk1nAWG2uZZ3ssXGYhpYCN+TYSfg4ch8UgyIjCugISCc+yXIICdOPKxChzhdrP/QGPAv6nEH
 O/hjx8MgITlVTEZTJhOGQAjJk3fa/UK8b7l2sGkZNhhsJeb6Y42e9vbLUfN/uABOUqkt6w3VtyD
 HH+twD8dCd1DP5IGuIK5VNyV8B3M8M1EyfaWz9vuOE3JU+1im/Sx/7asznkwuh3WFv63OeSh/kg
 4abn8a1lSrJzM73zzCY12s62c15AuH65wLdI5VR8uYclq5wTofEh5boj0VNXKNv2LIaH8ctcFqb
 e/TA0g/SMavVxrA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This shrinks the struct by 4 bytes, but also takes it from 19 to 18
cachelines on x86_64.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/sunrpc/svc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 48666b83fe681aa57075bef4a46e66bc0f0fe3b9..40cbe81360ed493bc16e64b55818b21372e305f9 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -245,10 +245,10 @@ struct svc_rqst {
 						 * initialisation success.
 						 */
 
-	unsigned long	bc_to_initval;
-	unsigned int	bc_to_retries;
-	void **			rq_lease_breaker; /* The v4 client breaking a lease */
+	unsigned long		bc_to_initval;
+	unsigned int		bc_to_retries;
 	unsigned int		rq_status_counter; /* RPC processing counter */
+	void			**rq_lease_breaker; /* The v4 client breaking a lease */
 };
 
 /* bits for rq_flags */

-- 
2.49.0


