Return-Path: <linux-nfs+bounces-7224-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5F49A240C
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 15:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70795B26A2B
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 13:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A041DE3A4;
	Thu, 17 Oct 2024 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPnRRjCP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC931DD864
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172198; cv=none; b=dBd8BjJgxOvlxz0eD6FNkj1Mwkobh5/eS2QEg7EDzhE/qfPHwuQrWi0tw28nE4VM17N/AYfoUS2PrxebUxkvnLw6x+a6Bq0vHT6x/Gnz+qsQyg+0cYCSx7l1zu8FAa519TNDaiFBhc3MNK2NimQt3D0VKG6TJ3ZK6siBRM053Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172198; c=relaxed/simple;
	bh=RGErqXw6Y0xa7GsEkwfdHf8++QF1/f1750VF1aJl5xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPY9otsPiQQ1R3edRsZjcoAviJRRPrTv139aCXVqfotcLDa277K2wqEkVowB6V4T65ydMcHta3V7KKhWLWqcCe2lLNcFz8FjG91RwszLPPj0AZPp4ZTk7QzjdhAVA8u7Ue3sZEqoQm4ku7QtNLTfvmVPcXapA1VORFE74yvyeb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPnRRjCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1826C4CED0;
	Thu, 17 Oct 2024 13:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729172197;
	bh=RGErqXw6Y0xa7GsEkwfdHf8++QF1/f1750VF1aJl5xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nPnRRjCPCmMSrtnrW51Z6TEz70klBTQKD/1sWW4Cmb+QgsKGKSpe0ByUMtKR3Ikg0
	 /aoa4RC2ZWn7Ghmocvn5zZd82wDBzVy6DWtUbv9bkKlNW0HJy/FLlsd0A0fXk/izM0
	 ybBuoyTix66WCHytEQERZ4n94mkQBmt2Jc+bl76V7U67ZEERSSO2/s5oScZyNzpesz
	 7BWPt1iAN6ccUzG78F6uF48x8gml/GLJNKLwXxSGPRTp00juDYKFiixErEtyg3YECf
	 lRATBSDOVZbNL8j1BATsnIRRwdgkddhCGu2WAn1ydt80VWyUK9IwCZ3UXxOstUZ6Rz
	 0ALtHcAGJLa5w==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 1/5] lockd: Remove unused typedef
Date: Thu, 17 Oct 2024 09:36:27 -0400
Message-ID: <20241017133631.213274-2-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241017133631.213274-1-cel@kernel.org>
References: <20241017133631.213274-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Clean up: Looks like the last usage of this typedef was removed by
commit 026fec7e7c47 ("sunrpc: properly type pc_decode callbacks") in
2017.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/lockd/xdr.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/lockd/xdr.h b/include/linux/lockd/xdr.h
index 80cca9426761..17d53165d9f2 100644
--- a/include/linux/lockd/xdr.h
+++ b/include/linux/lockd/xdr.h
@@ -73,8 +73,6 @@ struct nlm_args {
 	u32			fsm_mode;
 };
 
-typedef struct nlm_args nlm_args;
-
 /*
  * Generic lockd result
  */
-- 
2.46.2


