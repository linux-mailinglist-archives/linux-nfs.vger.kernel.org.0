Return-Path: <linux-nfs+bounces-14799-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CD7BACB51
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 13:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484453A41B6
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 11:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D063025CC69;
	Tue, 30 Sep 2025 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXNiUeh1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC69024467A
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759232264; cv=none; b=O+i67fjdz3gZV1YYA/bB0hVXtI14TSC1azRRDDc3JBbqIZ+TxvgiGdlW8SFQia8qBEaoMlmSjkDfm8sdv7GNQ6zbvOaAYgR7TXity1t+RuPv73KS+tHv/m8G3xNkilTWpYDpEXsf7xSEnBBrAHIOdGuiZ9fHqQD+MMb09dnCHCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759232264; c=relaxed/simple;
	bh=1twYoCBHBDJCCQGEOyiuzDkj1FbB6XFTwxx7t6UYQ2M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dTfXCEg1pY1DgPr/J57FsobEpPLqJIhUSQ7FeYgZHuAyNqV7ZQgkPV7tiYESd3GLvMP6loRMSlPQ6NvOyoNDnH/RCFD9iij+sVkcyZF2uAkX2+LEpefAFMdrRKBH+PZNd9RgGy37yb3bFxKf9iEGi1zcM3gasM0tC1GFxTurA0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXNiUeh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF47C113CF;
	Tue, 30 Sep 2025 11:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759232264;
	bh=1twYoCBHBDJCCQGEOyiuzDkj1FbB6XFTwxx7t6UYQ2M=;
	h=From:Subject:Date:To:Cc:From;
	b=QXNiUeh1KHjFNVT6/93d3n7dAAAn0I2lhHoMdxwxmVZeF3m17xXHWTxOQ0ZaPJD35
	 veXedIVWSY+uJMW0B1iIa5CHwBNLOmCGJcSUy3ZtLqb39n6IXBG/Yf31hN/5otcIWD
	 BUwXciakXiZNmvbSwWO6UodGHp6wBjMx79Le137A37mZR5trBDRzanI9Y9sWVO7rN3
	 M6j4lGrxvbncLogEuYdnejwkbn8Qt+4I+JDR/T1JIkT7ER5CBWBKUYT9YNcn9f9vE0
	 AmvYGoa+upslkViPDOWcGboZoDeoO+gT9fThhz0/vkOqawHpAx+z9ojIdxNNf4l01J
	 YWqbq9KLcVFLg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH pynfs 0/7] nfs4.1: add some basic directory delegation
 tests
Date: Tue, 30 Sep 2025 07:37:34 -0400
Message-Id: <20250930-dir-deleg-v1-0-7057260cd0c6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP7A22gC/x3MTQqAIBBA4avIrBMs7ceuEi0sxxoICweiiO6et
 Pzg8R5gTIQMvXgg4UlMe8woCwHz6uKCknw2VKqqldVKekrS44aLNA5b3ZgwadtB7o+Ega7/NcB
 xx8Awvu8Hc0kFi2IAAAA=
X-Change-ID: 20250930-dir-deleg-4ae7364fb398
To: Calum Mackay <calum.mackay@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=1twYoCBHBDJCCQGEOyiuzDkj1FbB6XFTwxx7t6UYQ2M=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo28EGphQy4zQkWEHa1A/WV54RLasKtfJovsAib
 /yVSfRA+vOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNvBBgAKCRAADmhBGVaC
 Fa9BD/9k2TrNL6L3fbSrSgkJIwmXI4Dn3o5CEgKMPgzSWKGa62AvYAEL6M+ncUWCVBp703kORbJ
 HXCYywnYkvJ7df7B4H0k1tVmoLu0kDM4fsRs4vqvAfAhsalwYbkJ1c6wnQumxCqyAycH526EEqM
 45ZrYQlc3pGyqrYRPPlDfJrzkb9EqkRJ8xP33nOTUHPx4QsuBldVRSFr/VlnkxxSqICWZCdZwvu
 FyToAUxNAqCwfFZrBybkn507R6aneGtsWZ9oE928u25Uq8MYSTa6PKc57TgrIi+qEkggrtRIRcu
 IhD+TUg2f30nTaXTo2lpaNsAaPzZqG3NmumIsYUht3pegQMF73d/QhgYOrbb4VYY38IjeUTmIJl
 CdmuPeR0XLd4uRDfxoCCUBwbhlFv5ikN3YwgA8XBS+8F+gKFdNURkleY6DvL43YJWcYIuz5n+Xo
 aD+Bvg1Ccb7yiCHoPx5W+l7Rdl+HzO5uRuyIYPgqOPpcnxWo608SfJNtUoxqdhBmizNk3uXCFZi
 Kj873QIpcMZcwF9OG1YPqUcv+jltA4nmNkXLybqHbU4OQYvPUIkwu+pjnQkY8cxgK1iHR4y3brY
 RG6XUdNSoOZhRLZbeIaIlJcbAwadeq3zm+ZQK5H5h29fttS4EKkGvggGQw2F3DLi2q4FGIjwYBc
 nyffraZeedqt1bQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add basic support for testing both GET_DIR_DELEGATION operations and
CB_NOTIFY.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (7):
      nfs4.1: add proposed NOTIFY4_GFLAG_EXTEND flag
      pynfs: add a getfh() to the end of create_obj() compound
      server41tests: add a basic GET_DIR_DELEGATION test
      server41tests: add a test for duplicate GET_DIR_DELEGATION requests
      server41tests: add a test for removal from dir with dir delegation
      server41tests: add a test for diretory add notifications
      server41tests: add test for rename event notifications

 nfs4.1/nfs4client.py                 |   6 +
 nfs4.1/server41tests/__init__.py     |   1 +
 nfs4.1/server41tests/environment.py  |   2 +-
 nfs4.1/server41tests/st_dir_deleg.py | 221 +++++++++++++++++++++++++++++++++++
 nfs4.1/xdrdef/nfs4.x                 |   3 +-
 5 files changed, 231 insertions(+), 2 deletions(-)
---
base-commit: 3c14d9e3ad12272ab2f6092c85bb28ab03951484
change-id: 20250930-dir-deleg-4ae7364fb398

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


