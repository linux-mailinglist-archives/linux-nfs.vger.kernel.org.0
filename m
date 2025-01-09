Return-Path: <linux-nfs+bounces-9036-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75467A080A6
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 20:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A63253A8EF1
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 19:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276CD1B4239;
	Thu,  9 Jan 2025 19:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxkodShc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F2F1ACEC6
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jan 2025 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736451612; cv=none; b=Q28RTsOArDd8GrRVal4OOnD56439qyCsX3+isyeRCr0RMQe79vV8mRfyrn7n/hIoS35dXgvZS5Nr0JnmNYXKcmH5HzW6XCL9bqsCOU4sdMXoPFl7B/AayK20kRjGJugc4PbtvxcSt44EgiTKEAXgekNDq5lq2st1K4DxD8iVA2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736451612; c=relaxed/simple;
	bh=NJfJrZF4OCROewo1ZZL0EIoQaoVob3RVRjK7s8z/umQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PAMPQ+ZAc/ntTZDtQLMiQ6GKxijM2v92lJeljnX66iAfE1r9LAMDj0xNfa+jcy42XsyBMyU9WikSYdR16q7T22BcNUd7GVTnBesjBwwtki5j6pI9R0BNk3SuAwVV7L8/xNi8Fp1VV/TtfQXczQwpe6urM0WdOGJiR3H6HD22RKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxkodShc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249E2C4CED2;
	Thu,  9 Jan 2025 19:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736451611;
	bh=NJfJrZF4OCROewo1ZZL0EIoQaoVob3RVRjK7s8z/umQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UxkodShcS4jhrnGaenGdt+mZP4nAM9pk9rI9VFO5vsm1QYSsUuVQ3hDMEsYIzxawU
	 gBX15Vja+Lr41pXIA8hwlkJhpiEv3dYjv8u9C+MB4SL0Cu8EmJdRyZaROZT2pVgGwi
	 kpPHGgahsvNms06NK8IWyntj5s9KRuRfKZ8Aov1S7H/zp80v5rdqsML5Bz8ACJsIWK
	 mcGJm6D1jpdFfSpMRtVI5Ir3wnSuvTnMzr6FqWtdl4oNZssN7WYTMSmHYjdHAr1Li3
	 X3k4ZRbk+A3Ngp5mfmfTncPHB3A+VHOfN1mO/ah7HfQxtNJRafkflsAGXxLuGO/gOQ
	 rvj2wZG5tKp+Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 09 Jan 2025 14:40:05 -0500
Subject: [PATCH 2/3] nfsdctl: fix the --version option
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-lockd-nl-v1-2-108548ab0b6b@kernel.org>
References: <20250109-lockd-nl-v1-0-108548ab0b6b@kernel.org>
In-Reply-To: <20250109-lockd-nl-v1-0-108548ab0b6b@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Scott Mayhew <smayhew@redhat.com>, Yongcheng Yang <yoyang@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=583; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=NJfJrZF4OCROewo1ZZL0EIoQaoVob3RVRjK7s8z/umQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBngCYZ/gt9Unb/i8ZGKmXU+5u62JMF2OR+l+aB8
 XrT15SUpTyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ4AmGQAKCRAADmhBGVaC
 FWogEACSdsG41CUq2++IPPowQ+8OJQiKa5HFGhngv+XcXXcZdMpU2MdsZ9caoxosIbHl8aV524B
 LRLTsoPI6pKS7LZJA9RAx8NdTN0fqGsvYUc+97tIKLPM5htpRTFB+ImjhiVBcIgRhYQBp3HE8Gd
 xMJoi+vnUV/CYztxZdGHIhAyFmXYDwUrofcZcCYe0W0RfmE2MxcW7kn8LpovbmId5O4/tIXipAD
 4t8f2HZJ+fIrFGwUOOfe+bvekJJhdXSPS/yi/vPpj/YZcW/tEeP3pupGmhZoiGulSc0m2XAWxZU
 yHXMxsXqXNufwuMMV4GULb9dyxiwvzipdPoWVdo+/8uzL/YCaYy4NVDb+fZBbpvUotdhX+hgvWH
 2aNkxl0qreqqjXjw4MTdjd845+u8xA0iNiuXQU0IYoeJYL/MbVMVE1QFabV7YSqbdqAzmrg/ZmP
 ZacHLCO1qgobSOn023SeSwSC9C7umUMMQlcLMnwbfCrCKEOgURA4InW7Ow8miZyDCv4raTwAIQo
 ScsMgBYYXlOPYxh+BgxLrooejYcepqKzJMZsZsMZicsP4oheXY6YoVSPvyv0cN8zNfS6B3h5CQ1
 cw/T9aHJ27Pn9zk8Kzm5N0s9wY2m+uMyiXxnuGFhixsz417X5Gt9UJx8Txz3mvB7QRJlVMRj1MI
 UhGZsWOg6JOK7qw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 utils/nfsdctl/nfsdctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 11fa4363907a0897ddf79f21916f9e25b9e88dbb..2cd58fef079aec74000bb68a81a05eb7bd876d7f 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -1553,7 +1553,7 @@ int main(int argc, char **argv)
 			xlog_stderr(0);
 			break;
 		case 'V':
-			// FIXME: print_version();
+			fprintf(stdout, "nfsdctl: " VERSION "\n");
 			return 0;
 		}
 	}

-- 
2.47.1


