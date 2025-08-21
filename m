Return-Path: <linux-nfs+bounces-13832-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E07EB2FD60
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 16:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D0427A6D65
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 14:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B752423A9A8;
	Thu, 21 Aug 2025 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHTM+5uI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939BC469D
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788004; cv=none; b=q8gLkl4SLah0tzGWVdmiU/RH66sY6Oe+dlNv7QK3/YiZ8d4BQ7pidcW6OSpUxObI1jYamUD+oFs1CqfuStp8sY3K42Qmu/1EYRaOQ+pFvJdhPRIj6CGNy+vNeO/qkdXO0pXs4l8JFty+3M31jLvmSfio7YeAoNi5JBYqt4zAWL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788004; c=relaxed/simple;
	bh=zirqVg1WyP7sxCTMSDUtPIgJJM82vDltIXE+hvfT9eU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nTpO6YAyIMhHkoDwgsDpSZEvFhgvFvISD1cIsAV2Jdap28ivaol99tQBRxn8Ggl3LY4q+igBgxCGWWQM7Br/hgvojWckLAbnTqtKnnrCVu0gJy6bCtsky2/GOLXYTmbCrgcDRGGyt+eJUAhAaJxByblAZbEoAAm0FUIVWRt6blg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHTM+5uI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708FEC4CEEB;
	Thu, 21 Aug 2025 14:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755788004;
	bh=zirqVg1WyP7sxCTMSDUtPIgJJM82vDltIXE+hvfT9eU=;
	h=From:To:Cc:Subject:Date:From;
	b=kHTM+5uIIpD5ooyc1KK3Il6d9WzSbsMrcRE4t+cArphsnjsAG5iWsknpW8ZMjEhUB
	 SzJWKGWw/QDgSzDNPnTYwR2umN2O5het3QAAeqG3hwhNJ9GnhGNwV1kLJF4zXpUFpB
	 EYKHc0hyd9C8nGKcHYwcQlsKlg++5auHXTwTekvDY57lmflaFzbF8GyhtcMqaIE0MY
	 HK2UcpEsnyb7RcH+c/mkTdlrI0UluRlTjdz5ItXTgDsDRV+q843NhdmbZj/sYhGan+
	 cIJoSufSDiBOxww1EF2mAqFy647Am+HP9rDhj3oAhPpMSxbnvsNyx/tqaW8mWYDe2J
	 Cz2ql2uNEmyXQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 0/2] NFSD duplicate reply cache optimizations
Date: Thu, 21 Aug 2025 10:53:19 -0400
Message-ID: <20250821145321.7662-1-cel@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Two minor optimizations for the NFSD duplicate reply cache. These
showed slight improvement in WRITE throughput on exported fast
file systems.

Changes since v1:
- Remove RC_INPROG check from nfsd_prune_bucket_locked()

Chuck Lever (2):
  NFSD: Delay adding new entries to LRU
  NFSD: Reduce DRC bucket size

 fs/nfsd/nfscache.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

-- 
2.50.0


