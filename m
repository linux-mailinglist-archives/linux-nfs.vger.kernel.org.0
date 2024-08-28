Return-Path: <linux-nfs+bounces-5871-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4014F962EAD
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 19:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1651283E78
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 17:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37891A7079;
	Wed, 28 Aug 2024 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QS2TcyMP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA341A4F15
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866818; cv=none; b=gNaqnlIWSYwPktD2PICH6ts96Kj6a5/CiICxe5UvBt/x9qOxXnAfW3tDjYKrfQhgtv8QrfoM48q1RcAmFvW2zm2TDjlWMosU9OmKm6c8hSVZlGMsMTXmPlgx9E33QxB+XHfAlJQphwfQBoJVx36TlODtaT3Wq1wbvTy9o8oCA5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866818; c=relaxed/simple;
	bh=jKobVgu0acTMnt1FZU3hAsGxqMKb/6PmK0FjU7wxFqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWslkbC9sLU/daVLgwuyCY8GAIRkJNti/kJ0Em0xdDvjuaBMaLS5TNLsiAevcy28hxeFOplfoCrylfrQJgUVtWfUqgO8BVTkzKNlpduTzfRf7i0WY0Kxyty7GLY5Z+33k+n7N53JmJXYFfLnXOI1IyzXFkngBGGCBDHXKlejTlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QS2TcyMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216A4C4CEC0;
	Wed, 28 Aug 2024 17:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724866818;
	bh=jKobVgu0acTMnt1FZU3hAsGxqMKb/6PmK0FjU7wxFqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QS2TcyMP/tCYZgNXbimqt3quommZypURPf3s0tn7u0Rc1mBbQlgKAtvbBEFsCG2v/
	 qCFs+ztI+IvoXys2YkySA6miuc1Y7h2VNDPU4K/bB3w9vf9d+8JAETBOUjC/3A3qsE
	 JhBv0HUqtFODkQWkV+7M/y8srQTjQRnAh6Tov7CHKu84WAFIdBtwCNWrWz0W16fYL+
	 007X0HbcyKb7vuyRiIeGg0UGZdgBMjzkAF4Cl50jpUu5WI+mRds+iyjaxYNxfZp/Eg
	 bbBFzE8VVrQQr6i/bjn07OK+Ia4c3tqEyIddwg/G1i+Q7W2pt4yiYmogM3QH2rQudP
	 HEkfnJ18sKTeg==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 5/7] NFSD: Clean up extra whitespace in trace_nfsd_copy_done
Date: Wed, 28 Aug 2024 13:40:07 -0400
Message-ID: <20240828174001.322745-14-cel@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240828174001.322745-9-cel@kernel.org>
References: <20240828174001.322745-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=623; i=chuck.lever@oracle.com; h=from:subject; bh=LqOGC9tY/vwoLZr9odBeBS3kZzrq7UqNKArbJPXDe5k=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmz2D6dOssd4dmn7pK4CcWNXQU/rA+XpmkCJ//0 JZZeNETXsSJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZs9g+gAKCRAzarMzb2Z/ l2Y2EAChhy1ivzTpvpXeSvrqWKoRnHsPaOeL+yKFz8GFa85MBdh8+zgy3tBkE75K6PYsIDxy51t 9GNun9ff34lgi7XctMFkI291K5qi1CZ/hA/NTyMRGnL+te6SqkuEl+zKdDH1QFQhgTtr59aYq3R cqIxnlGJ4LvOEheZqjkinecJEUYtAV82xHWFmihLkBsPKBE8xzE1NsJuQwvSUgSkJh38pGzgjDs 4Vu47qj43rPTR/2OH1Rpgm3fpJEsvJJAqu2FsQP++rrr0V97RdRRJCvkQl1sSIM+fxqK4cg2bBl Z4wlaG9FHFg/M41OMiBHHanG4XDPk8htBnjXTUJmc80Rz/kaB7ulR9gagAXQ7vgHm8B37BHd3ZI GkXCrPdozWzjwY6K9Nn/EI7yVFPZfiLp2yCl4Bj2mW7m/d4LwMHnh3vNrmkX0RlfLVbDAkfN51W EqKenMcxTUtd7OVJuBSB+3inp/0IfGBKI2pjzHB95c464LIox30id6F6Py2LeEWGXbsjKwvdCUx N7kdBtpe7eZehefdMXAZJp/8d4M0d8lg67eMr5x2IXmMC2aIC4djsPvv9knowxh9IswgfZk5wuK Nyyev5yh4iwI4H9mXOi/C8qbuIcz0uAgEEcFFuGnZik+4MaZtrjp0o4U9wiUeslktqmcQ1p9pkX HYA+aYm/04u7EWw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 61ca9632021d..d3bbd58b44de 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2205,7 +2205,7 @@ TRACE_EVENT(nfsd_copy_done,
 		__assign_sockaddr(addr, &copy->cp_clp->cl_addr,
 				sizeof(struct sockaddr_in6));
 	),
-	TP_printk("addr=%pISpc status=%d intra=%d async=%d ",
+	TP_printk("addr=%pISpc status=%d intra=%d async=%d",
 		__get_sockaddr(addr), __entry->status, __entry->intra, __entry->async
 	)
 );
-- 
2.46.0


