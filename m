Return-Path: <linux-nfs+bounces-15069-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D374BC68C5
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Oct 2025 22:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3228C3BE05E
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Oct 2025 20:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2603C27A12C;
	Wed,  8 Oct 2025 20:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTr3+FBj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B821E9915
	for <linux-nfs@vger.kernel.org>; Wed,  8 Oct 2025 20:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759954432; cv=none; b=f+aseCTVSeQd+LN6mzCcAhqpcs0tvBdGe5X5/JAIB9XJWwzRxeqhelIPGxjP1JGnBY6YmDOii/FuecBnvF5SABxUkQR/BtgJrd6qvZ4qGbG/d4fVHrr//Vd/LLJUda43hDLGLqcaXt9hfcsV9WvMuFunyiuX4SpkcUDZzSx6qSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759954432; c=relaxed/simple;
	bh=CAe5SoTVQLwgz/e9kgLCH6H1/5EKqTkmBBqg/070/Rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tm/OjXYnK/7h2uVqADfjS6F7tFZBXprEQy9grTKHo4ZjWBtZ8ZcMnuyI1ZCF4zAEorNtG8wwG4jKugQEwpZ0b0jue7+XdB8gjIhOs9OyUVgv6ha6W2VBSCd9tjsn6mcB5xkMkcEj7ijVfYoyK4TK34Bhvg2p4dtGNx0pdmYMWEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTr3+FBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2311AC4CEF4;
	Wed,  8 Oct 2025 20:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759954431;
	bh=CAe5SoTVQLwgz/e9kgLCH6H1/5EKqTkmBBqg/070/Rg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BTr3+FBjVO1jjiBW4AyjU7oORIc8oU5/uLGmn6qTpw93bhpINRs9sdrzuGkztyCpT
	 ODcjPSG24AGzuY8Zh7tUMuRzLmQ6kLOO/KaFZX1MfTlz3eYNvCbp+jV5t6Z633XRaX
	 di30DYT5pTPvsjOtmh/KmIx73oKKh1P3wd28NmYf776GZ2a4+S0QiT18+yPieEYXOY
	 OwhrdL9w8c+9QQaZHDNQAm0LThGxgAoImd2FGoc8RnoGuVp/y/vNy1iP0+dj2H62xF
	 9HT0Cb4o0sN/os5M+KwpUqwGSsRgnZcaHlLKqmI6u890cSPowMEPGEWerMV+rWs3Q1
	 7f5Lp3bS5qwpg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 08 Oct 2025 16:13:42 -0400
Subject: [PATCH 1/2] nfsd: disable v4.0 by default
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-master-v1-1-c879be4973c8@kernel.org>
References: <20251008-master-v1-0-c879be4973c8@kernel.org>
In-Reply-To: <20251008-master-v1-0-c879be4973c8@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=808; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=CAe5SoTVQLwgz/e9kgLCH6H1/5EKqTkmBBqg/070/Rg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo5sX9OlqZpsSO6EvXHViCVXv+r/E+xRTrJ2uEl
 vr/vP4+Hh6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaObF/QAKCRAADmhBGVaC
 FQBPD/4lbZMaxUOLrl8IQxQOK1cFf342R7bCjU5o2c5YBmhL98QB+89t0O0nNIR70ZqNyFNuKNy
 AVQACkgpjEF0wdW+ytBY36b4Vdmb/G5JLdtqhMDtLtf3OwlSjdiIh2wXhzhMymIAPHUfnz1nwo9
 sXBYRJO59fNfUQHknDqsNdHzE0JawjYovJrGlYyfP4eAInYRDEnyK1D6ro9tt03HFYEVst/nrvP
 I9vTa4ZgVpzZcbhpx70rO+jc7Ly4hhiMcJc/A6HvRWwewciXO/CuH3aQO6a2gfWmr2rGHmzot15
 pLt93RkjlhtnnQx7YN7y4uQxuEREWDJ9qb4P6NQAOlMWZy5yVh13jV7we6S3roizlFVzW839MAY
 r6xKHRLXwM8bVrk+2dcLFv3QA1z7pZAlAfaEoztAfeISge5oY/wnMNADm3x3Q88CM48BinEW/XG
 phh4Tnj5lc530qfcf01hJWQTXxUWWKDrkFl94wEySKw959LBemEZZYg48L24hDNg6qmA21cWck+
 /ULS5QPJA1cnwTUVl0Qi8pbpXHBno7ww3fP/5z5nTJu85Lhmnx401JeWV/kMHqg8WPdBcKkl3bH
 agn1rYJUYqOmIaofK7CgAZQJIEmZk0YDn/aUxSDja09qp/raUG4WrfpgPe0FYCRRw4f+CV5pqvu
 Strjw5Nn0tgMmZQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 utils/nfsd/nfsd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/utils/nfsd/nfsd.c b/utils/nfsd/nfsd.c
index a405649976c25474c032a8dc63eca6b63b789278..365e145d8860f54a168613ac15f3f1345b794b30 100644
--- a/utils/nfsd/nfsd.c
+++ b/utils/nfsd/nfsd.c
@@ -134,9 +134,10 @@ main(int argc, char **argv)
 		}
 	}
 
-	/* We assume the kernel will default all minor versions to 'on',
-	 * and allow the config file to disable some.
+	/* We assume the kernel will default all minor versions besides '0'
+	 * to 'on', and allow the config file to disable some.
 	 */
+	NFSCTL_MINORUNSET(minorvers, 0);
 	for (i = NFS4_MINMINOR; i <= NFS4_MAXMINOR; i++) {
 		char tag[20];
 		sprintf(tag, "vers4.%d", i);

-- 
2.51.0


