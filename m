Return-Path: <linux-nfs+bounces-7168-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0EA99D87B
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 22:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3CF1C20EFC
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 20:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01391A0716;
	Mon, 14 Oct 2024 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ub91Dt6z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7A114D439
	for <linux-nfs@vger.kernel.org>; Mon, 14 Oct 2024 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939037; cv=none; b=BYzkAbs0fWavpbRObUt7MrPYWkjpUgPyqVlHiR7qfViJGheTnHHXf0tPQ4M9ED1mrkBzZqQkc0iY2YegBfmBsOw9PE130/8cw94/3XvQ6F85JfbgmD36VcfFocvQrWXxM4dutLVC7dbUFtyGcxrV/FVEdFnlV84iu4eEzS0r/ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939037; c=relaxed/simple;
	bh=LQZhsdtsCSL2CA5FHbzccR4LCOzWLZrI0587xpNopU4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OoGKvM7ry/b/kx2TbjCi/a0R9FRDqmcd8w2VdQjXCHNI23R+6EOppo2KlJkcPRDjcaWnMXxGZ1DhYsLSh9fO0nQ104+91SPb6RdgJz8tEZA8abj0+nDRxmw2jO58SBPWKKJ3Ke6AMZlSTebm13jntz7l6wvWussZ3XaX8N41bSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ub91Dt6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C3DC4CEC3;
	Mon, 14 Oct 2024 20:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728939037;
	bh=LQZhsdtsCSL2CA5FHbzccR4LCOzWLZrI0587xpNopU4=;
	h=From:Subject:Date:To:Cc:From;
	b=Ub91Dt6zTQ/FY3oBwZnF23LnM4ifDcxeZBcB2nMSnIC6Sry+YIgsaILQHFgelcJU/
	 wgivoroRexh2GEyXT27GR2Hg6M62u13SHj6q9iwl22Fe24Mr4eCMvXpEHtuYpNpkfY
	 98/DfwqdUdq2ZCxmYLeh0w+e/kZPS4O2yx0mk02iGf0HrhNPJcGaVIbT/ZeloFYxiS
	 cukoOyiECviBDzHTiVrxMmm4xkVX0Mdxr2csGJTFInCNqwZ4GuCzOqRAPbPYLsdfuh
	 JsA9ouVufm4WYdTIHDYYCjlIQYnh3Izmj1AqNWX/hTLckIEwy8bfRX9XkBIMzKtWcO
	 7Yk/K8K2VRR1w==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH pynfs v2 0/7] pynfs: add CB_GETATTR tests and tests for
 delegated timestamps
Date: Mon, 14 Oct 2024 16:50:20 -0400
Message-Id: <20241014-cb_getattr-v2-0-3782e0d7c598@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA2EDWcC/22NQQrDIBRErxL+uha1ptiueo8SippvIi0avhIaQ
 u5ecd3lm2He7JCRAma4dzsQriGHFCvIUwduNnFCFsbKILlU/MZ75uxrwmJKIaZHK7QyvVXWQx0
 shD58m+wJyxZ9hqHGc8gl0dYuVtHKf7ZVMM648bx3Vy0vyj/eSBE/50QTDMdx/ACQJxNArAAAA
 A==
X-Change-ID: 20240905-cb_getattr-8db184a5b4bf
To: Calum Mackay <calum.mackay@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1731; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=LQZhsdtsCSL2CA5FHbzccR4LCOzWLZrI0587xpNopU4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnDYQXMo2IVGLtUJ7pwAmaJXvVK7n8BCErdM/PC
 E7gRq/nq9uJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZw2EFwAKCRAADmhBGVaC
 FRQsEADOUOi8OzqIJCKpQXRjco2dTC5BQDX/Uw5nOVlPTqcPb8Qm+B09XY744RabpptE61ACJA1
 72m7eNM37hwIIJ3oWgiqQ2jm4doIdW9oXUo+J1V6c873uKEkdP006apViMaHVpVCfEZRILiwbWJ
 oonlau7DkWxd3vDTND97FZoNUUz9Zy5X7+aGW2fkWIv8vnwHFcjeXqudQOJqeOlSudFRdZHtclb
 bT6xOmWTb1jd6pw0rARaZyqNdgOYsxKiiR2FlYuYyuJAlOyLnsn9A8VipzonbehKmNS2gV3eyiS
 robgIWFkd+kOx4Tgwy7Y8ZZa9egTo1OCFO1o8fln8YpwvMPXCrP7cUzlnb34ng9NB6CuU3SzcD1
 MD4yt9DqAJQ+Zqj2q2dTNkTnEJHQV7sv46P8DQnhD86Lb0Wt/Jjo6kEkRqw8mILrE4+ZDg+Ldyr
 0/jvkRnXz0IoJJMNYSexe0q1w/hOgTagwxy1NYClmYBnU7KrFK5rEuNBuWwWKYb/sV5AjlvzevM
 EQ6CuFIgUOz/exukJPrctS+U64fSZkZpqJOk0caxJwGLQnj43apIxWZV5acZJ7uDRESueQ7zmsY
 aDXLG7L+EI9yWYRiS7TEqiTikNatDL+V2m3Qp7ol3dsMjiBmd0b57CHaQymy/EDaZ9xlMzAwED1
 G9xX6yi+jT4UeOg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

I sent these a month or so ago, but Calum was on PTO. Sending again,
with some additions.

This patchset adds a couple of CB_GETATTR tests, and then updates them
to also test delegated mtime support. There is also a patch to make
the nfsv4.1 tests default to minorversion 2

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- check timestamps in WRT18, and pass_warn if they don't change
- have v4.1 tests default to minorversion 2
- have DELEG2 open the file r/w
- add support for the "delstid" draft symbols
- test delegated timestamps in new CB_GETATTR tests
- Link to v1: https://lore.kernel.org/r/20240905-cb_getattr-v1-0-0af05c68234f@kernel.org

---
Jeff Layton (7):
      WRT18: have it also check the ctime between writes
      DELEG2: fix write delegation test to open the file RW
      pynfs: update maintainer info
      nfs4.1: add two CB_GETATTR tests
      nfs4.1: default to minorversion 2
      nfs4.1: add support for the "delstid" draft
      st_deleg: test delegated timestamps in CB_GETATTR

 CONTRIBUTING                          |   6 +-
 nfs4.0/servertests/st_write.py        |  28 ++++++---
 nfs4.1/nfs4client.py                  |   8 ++-
 nfs4.1/nfs4lib.py                     |   3 +
 nfs4.1/server41tests/environment.py   |   3 +
 nfs4.1/server41tests/st_delegation.py | 102 ++++++++++++++++++++++++++++++-
 nfs4.1/testserver.py                  |   2 +-
 nfs4.1/xdrdef/nfs4.x                  | 111 ++++++++++++++++++++++++++++++++--
 8 files changed, 242 insertions(+), 21 deletions(-)
---
base-commit: c75f65983498a3254e3970da86eb6954415cac01
change-id: 20240905-cb_getattr-8db184a5b4bf

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


