Return-Path: <linux-nfs+bounces-5670-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0939995D93D
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 00:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A6351C21DB2
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 22:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622FC1C825E;
	Fri, 23 Aug 2024 22:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fk26q8Md"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D7D189B89;
	Fri, 23 Aug 2024 22:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724452069; cv=none; b=YjgbRIQcClxkZSoXhQafo2K8xruCl3fQwu1bCt1k5lYR1wrUMjm61AtdfX02WUOZQ2F5BJz5L7It9ln4Rnbmuo3edKEFU0C6KQjwhnRP/RG52tx+WsmzVl3Ka0RpTD1JQW1az+C00toOghL9tysGdJP5jxop2yLTx/9SbQ5EyGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724452069; c=relaxed/simple;
	bh=yCaQkLSd54Cn3tWTs40GhBWcbEurvIrKIHGs6WCnZXE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D1LlBPLl2WT6NuF06Wtt+RWY6xy47Lhwjak8UlSwxom6wAoLbdwrUuFfaAVduYEQM0IHejZALc1uniIxuqhONPoUOEiAAauS3GOEhimIe4eJ6IjIBmNWTDxpX8nEiX2noiI3iToUafTg2dG/9bZYtfCWJIo+kqpMabLLUKG1whI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fk26q8Md; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3ACC32786;
	Fri, 23 Aug 2024 22:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724452068;
	bh=yCaQkLSd54Cn3tWTs40GhBWcbEurvIrKIHGs6WCnZXE=;
	h=From:Subject:Date:To:Cc:From;
	b=Fk26q8MdOVY1S0z9Bs+7J+1qiYWKooT7uUJJ3YxMEmnx/FWV+CMJrbW+oCakQdKOr
	 avEGQnYvyEmPqG1O8Ve4+mwJPL2XUOmia4uZ7noROEh+Vr1IasulFbgNdg8OyDDQ4G
	 tbw+Udqx/3zrcZE4zYMzNoY0WIjqrl0fpmMk7+K7bxsoZQSXAceW9RMsR3OQs+13s9
	 m+cnc95Q+mAkTZJuIL+jcbAK2snK0vePze18PjYhmeesgZAnLAw08GfZ9r/AHXDLJj
	 9Lf6zUdffb3cBlZc7Yo+NXJ7+OyGeXURSVNMjr6qBjZvD62x9P87YZCmUUWi1xhNcM
	 9SuBKUNn3E4hg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/2] nfsd: CB_GETATTR fixes
Date: Fri, 23 Aug 2024 18:27:37 -0400
Message-Id: <20240823-nfsd-fixes-v1-0-fc99aa16f6a0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANkMyWYC/x2LQQqAIBAAvxJ7bkEtS/pKdAhday8WLkQg/j3pO
 MxMAaHMJLB0BTI9LHylBrrvwJ97Ogg5NAajzKicGTBFCRj5JcFJR+VnZ4M2FtpwZ/pF69et1g+
 hUpS2XAAAAA==
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=633; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=yCaQkLSd54Cn3tWTs40GhBWcbEurvIrKIHGs6WCnZXE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmyQzdrrYKGSAN0SDxNqBzk8NSTUzh1VnLLu+3/
 RGg9AQaNSuJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZskM3QAKCRAADmhBGVaC
 FcYOD/4lsP1bnNfeJqTC8oi4RkwTqJYimd9JVdaBoh9sCRcFRrv73zfSm5ot5DOA5tpCv0FO7QF
 xGMSrJVf4JaOPsecZ3QSNTE6XRZG7SZL8urMRRf9HnpgHo25SNCY1cZwI0c94sIiXEuYugKwiH/
 LyVAqpcR4Rq32Ok/hGKJ+DJWGBkTjK2Vy2r4tDNxzBwIQBbOl1bPThheD4JNc45gNDmDiSRhPOz
 AFxQ1KQFpmbPu8FZJ4OZTzpKDWu4ov+n4xA5CDcv8dRNZALmNw+VCCOjRzG+Dm/kdaNhbLgxDoy
 fpvnmc8XPPTH9aV8rf1jyGag5byswNdiWPxheyYfSngOzVJnEzyCd1IOmWLcD2kX5vjGmuiLDRV
 taRaUJztO/w8v4IYtzQd6yc2l/MFJMMKXaLInlBiyN/K/NRfwuV02CCHCwNNWT1RJlEUElJuMPn
 j3xTpttREPD7wWV8D7/7+XVh+xCLlmMAcE9OM9oywvdfOcz5ymZDkrYsA91qbAd8q6khYAmbwF7
 Neqc0MMeE3GIjXx7QxOATZ/hec/qd0aBXtdWIPWPialBILa4hIJxC53/yixRAGNwQPXcfMZOzz7
 Dz0RQBqwviJfs3txdiBnok3DUuNGikm3oTSZAmaf6MlZUMM9uEXpnUNKxU3BSugZPt3qlFDmFaC
 5v+HeqfoWRsZ6Ow==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Fixes for a couple of CB_GETATTR bugs I found while working on the
delstid set. Mostly this just ensures that we hold references to the
delegation while working with it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (2):
      nfsd: hold reference to delegation when updating it for cb_getattr
      nfsd: fix potential UAF in nfsd4_cb_getattr_release

 fs/nfsd/nfs4state.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)
---
base-commit: a204501e1743d695ca2930ed25a2be9f8ced96d3
change-id: 20240823-nfsd-fixes-61f0c785d125

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


