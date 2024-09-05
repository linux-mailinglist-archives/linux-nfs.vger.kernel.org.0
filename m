Return-Path: <linux-nfs+bounces-6256-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7103A96E1BD
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 20:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 243CC28400A
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 18:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7A11803D;
	Thu,  5 Sep 2024 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqmbpcOb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A1517BA5
	for <linux-nfs@vger.kernel.org>; Thu,  5 Sep 2024 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725560223; cv=none; b=U+MVoJy/RtAzlO0scDX+By3PLleIgdp5ncxVdl1/j3vng/JFjgXE2TpvjOOzA6X8I75xzyLCFFfAKdLu06+hoSizJIT43JdVtxdAewuvITu71JW3wcvDYuQaSYtVCxJ6/L+stSPcsBZgheLZULsIdCPEelsxxbqzXR0SwS6RHRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725560223; c=relaxed/simple;
	bh=PDxwStz2B6l2FgK+uI8VljfYUciXVxsKnsNywRmRrwk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qIxI1VtZE8j3lVm2UvFUt+bMaFtwJVzydxBwtZ43uw6qJCTDUiYky/h/DWgbtMKPr+Er7mm+we4FW8ICqQlFs8lonAmq3Mnvb5iCsE652rlS7D1g12bcQL0nA1V4AIvbNe0CRpzCa/X8H5WyhbNpdvty7aZgTowzg8I+VhBUKKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqmbpcOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC67C4CEC3;
	Thu,  5 Sep 2024 18:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725560223;
	bh=PDxwStz2B6l2FgK+uI8VljfYUciXVxsKnsNywRmRrwk=;
	h=From:Subject:Date:To:Cc:From;
	b=rqmbpcObhgdXZjODjVIcMjguo2h03u8wOaDZdM0Y1OaO6iZokiYtuADkbC3rBG39A
	 taUyhzAzqNIiRahSgH1fpLkkivvltSUmrWxAkWV/PqDGUN8nzLGQnfTh3jmxLbgiPr
	 nekpGJ4sbEmCUbppFX7UA95ESFQrdn23JhNIV1c6PCrOg1fw69ER+SgGTE+ddQTLKl
	 NPG0BTQrFOddyNBRRiWeiEa0ucsTNUrSm6CpXLP9slTnb8Jta7aHbENIKzjYwAmMq5
	 IzfjpJCjNgf2YT0fsOYR3f1W0zUUPWbz7xjfOiK17nWvkI2OAn0YN0fYD/0WOfvuWI
	 OJulQZAwHnLrA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH pynfs 0/2] pynfs: add CB_GETATTR tests
Date: Thu, 05 Sep 2024 14:16:56 -0400
Message-Id: <20240905-cb_getattr-v1-0-0af05c68234f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJj12WYC/x3MQQqAIBBA0avErBM0DKyrRITWaLMxUYlCvHvS8
 i3+L5AwEiaYuwIRb0p0+QbRd7Cf2jtkdDTDwAfJJz6y3WwOs845MnUYoaQejTQWWhAiWnr+2QL
 h9TbBWusH0Hzhz2MAAAA=
To: Calum Mackay <calum.mackay@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=839; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=PDxwStz2B6l2FgK+uI8VljfYUciXVxsKnsNywRmRrwk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm2fWe34X9P6FzqO23v52X1GmpEHy4mou2JknYH
 px75gQNgPWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZtn1ngAKCRAADmhBGVaC
 FcFAEADESUJGAJmFQpO85VXw4O00mNt8mTrVc+Me2ls2gxFxgNTnXnetXCR0Ij8htKuehsodx5t
 5IZOMVIYqE+nd27qOSWyICMIEqZp5t0AV3QftKrlyZ4knQZhnTqe3mFhWW53f9GYZT331i3lPh+
 dlCpbuVKKBnzF1QajSJrk5FfdgA2gdWr3Yfe6FaA7xdd1APmE5tLpv/Lva9s+LmC10+EIia6GnX
 RHul7RgSdbUk9Halz+rEKT8hk7ia+UBMj/iLKy7+BnRP0AenGcWOs+hyPIdrXNIphxllnQJmbSU
 xdLNb7EFtN7zuwOSDzKRhXgccAXldKLoZ+rj2g1dA0jg3E3c9zbJGB1Qv+giLDSxWi/ASCY7jzw
 NEk5/dkcenlxQqDGvd0zAFQPOFhsaYG+YMEp4j0wo6liL2Ewf7oAmujfp4UeheEN7ytdWIOpUUA
 BHDtcPtTBY/kpzepGaCkq8PDSQGO23H/eDX7eDzQl17JjtUheuxEvaVo1L/kO1MqrfOPYWzXG/z
 5l58lBiuLoN5Grrhu0s9uKGeF9Iu+1AqSMzx2tA5i2cl5h06kWzKfKGxbSg4q5usdtrknyuvsHB
 6Y+1BGQdf4T8VwGPLS2iL1S4q+68mee+kunxyjEPEnhNV7gfbktc+cH85LLtrDDwUxBP42+iEiq
 WBoDLF+xXKcSU2Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Just a patch to add a couple of tests for CB_GETATTR support, and
another to update the CONTRIBUTING document. I've also taken a stab at
adding support for the delstid draft to pynfs, but I'm having trouble
getting the xdr changes to build properly. I'll send a separate email
about that.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (2):
      pynfs: update maintainer info
      nfs4.1: add two CB_GETATTR tests

 CONTRIBUTING                          |  6 +--
 nfs4.1/nfs4client.py                  |  6 +++
 nfs4.1/server41tests/st_delegation.py | 72 ++++++++++++++++++++++++++++++++++-
 3 files changed, 80 insertions(+), 4 deletions(-)
---
base-commit: 08ffc1747800760c57f8db4eb02e62ece267591f
change-id: 20240905-cb_getattr-8db184a5b4bf

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


