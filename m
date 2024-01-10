Return-Path: <linux-nfs+bounces-1017-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0FB82A039
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jan 2024 19:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BCFB1C2235E
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jan 2024 18:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE2F4D582;
	Wed, 10 Jan 2024 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aC02Tc4X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1AA4D580;
	Wed, 10 Jan 2024 18:27:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AB7C433F1;
	Wed, 10 Jan 2024 18:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704911257;
	bh=RT8gwEMGkEbdBD3u3c940Wfj412hpDg/syc3E5ap9Cw=;
	h=From:Subject:Date:To:From;
	b=aC02Tc4X6Sr4j557GjnCEDP81iygULYVArELQlBfA3MHkBpV/NCmPVtW3ES9ofd4L
	 WajzF1PJFwHOcRb4pvENdcQmDy9sBpFH+esIva1wHlqj6gWto1kLr53MiAaU141/NL
	 OrHxuq36ZfGuvqEWF0iFIsEjqNKQgRNWuWAAuWIIUksfHFkHZzDzwuNuB2sQOTCyW4
	 DA7dI0XQmNYq24/fADQb9SalAz3vu14BrUHLCWSrbqGkmOpx4Ou+hqACenmaXcX0oM
	 9MTjKz8cuybLGcLmz+XQLl1ggG5+Rwx9y0oy5AOvo6ZevdU9HAouoGieYt9/1e5/ye
	 1i2a9CnUulubQ==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH fstests 0/2] generic: skip a couple more tests on NFS
Date: Wed, 10 Jan 2024 13:27:26 -0500
Message-Id: <20240110-fixes-v1-0-69f5ddd95656@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI7hnmUC/x3KQQqAIBBA0avErBMcE6KuEi3CxpqNhSMRiHdva
 Pn4v4JQZhKYuwqZHha+kgL7DsK5pYMM72pw1nmLaE3kl8SMFskPk3cYEPS9M/1B1wWiFJIisLb
 2AeKgF8RgAAAA
To: Anna Schumaker <anna@kernel.org>, 
 Trond Myklebust <trondmy@hammerspace.com>, 
 Chuck Lever <chuck.lever@oracle.com>, Yongcheng Yang <yoyang@redhat.com>, 
 linux-nfs@vger.kernel.org, fstests@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=532; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=RT8gwEMGkEbdBD3u3c940Wfj412hpDg/syc3E5ap9Cw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlnuGYWjncpqm8GwdGNRYwCWQ2tI6C0c16c9F2j
 tJ/Jtl9CKOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZZ7hmAAKCRAADmhBGVaC
 FQ0vD/wIcqG6QUFMp+Fzes4iOUTojiXh4NIwxBLvbBKuUJgQOc6TBuAWmNCVhszLAyGAUmdMLLK
 y9AmQ8J5yJP5Vw8lok1mQi26/2SxuDh3KYdlPCXGZQcm60VpSJXYVFq0gltSmjZLaT0JlA2QJGf
 GtahZx3LAdornUhI5hl+iA1boTadwKvVB4LS3BTe91KTer8NY7LRfk3jXV4aYUEtLpE4hNdCq1D
 OnezfNJTmSezppoXrNNTRSyg/4psIKkoRXh8TT4UzC3NTSVWl3RsRJVWUmCDwj6b91wp4+Ml81E
 jN+hwu68y1XXgMs1xp6IzFMHzFyMW8Q15mvCr0UzHMezyciehkv4Gom+exeuuhaUxVhJCEBbWWR
 8/kdz4djieM58x8daxQ+xE4oV3qGAilcrefqNhQFhloRMh1MDI4VYefX/NshF+ImxAqFiczm5zc
 xEhPxgjetMYpicshCGX3yVURAdKPmob65CmLohCrvnV7PVlMmR3df/kwhzj/c4NlXX989tTZEtu
 SF+qzPMkmBBj24eQotx0H8RP050eSfCRBkW6NDJ6DKK22GeWNQYaWe/TQX/Eikg6ySGEb2OSvTF
 ul7OtVLVkZM+RT/7bhYrHNAvBY3PeWfQ3PDOlxcDGmUUguAiZ4uIuMw6l20adXC3eGpNvx+8fU6
 2KMGMvhXRG3B63g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Both of these tests don't and aren't expected to ever pass on NFS.
Remove them from their _supported_fs lists.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (2):
      generic/465: don't run it on NFS
      generic/732: don't run it on NFS

 tests/generic/465 | 2 +-
 tests/generic/732 | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)
---
base-commit: f814a0d8b89c84055b4351f8b9655c5868db08ba
change-id: 20240110-fixes-701e439421c1

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


