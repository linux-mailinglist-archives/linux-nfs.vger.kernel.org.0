Return-Path: <linux-nfs+bounces-10733-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1EEA6AF49
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Mar 2025 21:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502E9482514
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Mar 2025 20:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3332E229B37;
	Thu, 20 Mar 2025 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qA67mF5E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2B01DDA39
	for <linux-nfs@vger.kernel.org>; Thu, 20 Mar 2025 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742503226; cv=none; b=NuNpw00pLLSaWGylGs8iJdVR7iq4VuxLQRxxh9bn44v7VIOYQ8X0s631gosy47TaOrTr6FoGcsDlUU41NJ2696ylTEY30gGlnUGef1KMsFBHE4+LnSCwukYFkwOQ1pi4T0vI3BCaXM9f7uf9hB5Q/UCAuwJ/3mfifX1MVjaTTvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742503226; c=relaxed/simple;
	bh=jnTPJqa6Izobe6HDXFtsTWdev0EwPrgei021SBLB+S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANK/V5219hveAzqlOJfFGXnl8QxjETahtDDx0VonDlm2XaOGakLc/hfaly0lI9bYUResxGk5AO1Jsia+PozodWPtRfQJsdlRPUH+lUWz3OSFo92frWRNie/nesteS1OT5GoKa+MEaEDA9vyd4zPlAkQWManIpEyzQSe4TT/5tAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qA67mF5E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332D0C4CEEA;
	Thu, 20 Mar 2025 20:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742503225;
	bh=jnTPJqa6Izobe6HDXFtsTWdev0EwPrgei021SBLB+S4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qA67mF5ERbwy3yk0zUlwj8njAq4thfSVjOYvrrTld4ZqBkqr9iKjZZtNpYNYDrTrT
	 GXweRkis72x/bJkgsBekkuXrS9dpRFNqwAuYe6MYEMO7R+JrsmdcQJFm9uSdCPbWe9
	 by+BuAjuIGOF+T2bzeRqKS/MFoZmryPmYd63R9t4umkn0gcGNcYNEWgOEVOVqbT5RM
	 YwxVTHcEKDPQyU/mhGlHj8y/uaUsO7jSxu/BkmYOEUhuoLeOO/GtAqR43VR/PQLrtL
	 EoVfYb2cKPncibaYZELzURN51AXWtshPes/KLmrfXtprPtgl+FUgOY6yEEdjS+uekZ
	 OFVTR3gqqKs0g==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC v2 4/4] pNFS/flexfiles: Report ENETDOWN as a connection error
Date: Thu, 20 Mar 2025 16:40:21 -0400
Message-ID: <726a3617addbab14b3c2b9a1c573b2438f4e14cc.1742502819.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742502819.git.trond.myklebust@hammerspace.com>
References: <cover.1742502819.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the client should see an ENETDOWN when trying to connect to the data
server, it might still be able to talk to the metadata server through
another NIC. If so, report the error.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index f89fdba7289d..61ad269c825f 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1274,6 +1274,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 		case -ECONNRESET:
 		case -EHOSTDOWN:
 		case -EHOSTUNREACH:
+		case -ENETDOWN:
 		case -ENETUNREACH:
 		case -EADDRINUSE:
 		case -ENOBUFS:
-- 
2.48.1


