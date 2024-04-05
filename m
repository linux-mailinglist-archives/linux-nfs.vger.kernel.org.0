Return-Path: <linux-nfs+bounces-2680-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 900F589A44D
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 20:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443D31F25ABE
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 18:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A54917279A;
	Fri,  5 Apr 2024 18:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pb4Uix5Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420E7172797;
	Fri,  5 Apr 2024 18:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712342462; cv=none; b=YEJOFJMlJ31GK6ex9NwAynR/HexvBh41OG83m4o1v/eXjMknIHcHrM8M2l1rryV+7flELEh4SoiGhYBVBIpJqwO0vRpap9kbdrGUPxsaGqDE/pXZQIlw2JTxx61hIfWT+KUnkb33HvN+vHn/Mn2L0Sc4Wq5xayfgMeEl9o1SeWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712342462; c=relaxed/simple;
	bh=HF5bdhmfNax8fSTda8C+ZW8NUjHRSdiQ478T8ES3kGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uDUuPS3WjvENvWaR/XaqgXfrFuvcfRIdt2hYa5xz3WIT5bjyQYxNmvrXk+1onx58aDFP/D2z9JaSPnx4Cdfz705Ahx9utB/KVUTP4NQMj3opIIHlZu6kt6O2hPFo32+aqYx3ibkB9MgUHHz/qeu8tuVe2MtchLSmr7q1XyCwoY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pb4Uix5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E270C433C7;
	Fri,  5 Apr 2024 18:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712342461;
	bh=HF5bdhmfNax8fSTda8C+ZW8NUjHRSdiQ478T8ES3kGo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pb4Uix5Y5Zg55BEe3Mw+PcKtJOYs7lfOlp7CKr9KNTnDdh/yvpZXMNB2rj7Q6YBIu
	 H7oDRGEfBiKjoIb2KJjanBUUE+DqXro9C+5rHaOAa1uOiejEiCBd2VlonFPMBh0rbY
	 zpNp6tPvomHZ5zBQX1uPO0ipi32OUf1X+EiwQhKrSiHaAr/pFHkXXi9mDtlQ9e0qiX
	 tLBy4Mse9b4joKZn2NBI0H89yCW0JCbBjERepEfaO2ZE221TaIdI10+WK8kF5xveiO
	 CNnm/QD8Sww6/e9xpHjlxq5HVxP2mW7jM7dBhQNVAcxxTDE3/DvoEWzApaPFr/Pr+c
	 dAdS1ZabTmuvQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 05 Apr 2024 14:40:49 -0400
Subject: [PATCH 1/3] nfsd: drop extraneous newline from nfsd tracepoints
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-nfsd-fixes-v1-1-e017bfe9a783@kernel.org>
References: <20240405-nfsd-fixes-v1-0-e017bfe9a783@kernel.org>
In-Reply-To: <20240405-nfsd-fixes-v1-0-e017bfe9a783@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1351; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=HF5bdhmfNax8fSTda8C+ZW8NUjHRSdiQ478T8ES3kGo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmEEW7Leu3f4qXrkadpej2z8m7xpWp8OFoetsdY
 qYaPwuu+YyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZhBFuwAKCRAADmhBGVaC
 FaRXD/4yfcIphXyP9uyfMr5iMUh6n5GUSqwMP4uOB7GYGDxK8eoGVqzY8kTFhi/mL4QuogG4lRN
 TD1YvlTFVL6grj/bYfUNsL6+4sMSr9vAD/qsnXBgaCaCq86qr4KSpqPeH+61vDBZU647dRCOQ4G
 LkejjX2BeE9SxhP4q9MNYkR9lBTIB2DQJ6coalsK2gg4EWCXOeVJK7+S7yvr65C+iY9Ckhxc/U8
 PiLrPDwmT46DL0CmVD8kX+20bwLRITQzKsa05lnVwaBkiJxua5VLrzjmeF4hIZBtNuMNM2dZdR3
 ZFWfDLtTlEjfn7tiktPANfgQiQGLj2AoK5yL3KYLwgLhGHZHsRVAmRtkXTXAhPf6sp+FWpJb1cK
 /LybaHRpG5JBcyGajmXu/yrdcvKLkx7Mw2JoZ5oEpAsSCxI0dp+d7gA2N3sdFRAbjOhngnUP99c
 ja6mZ/FFQAlbwGdAMDR04xhzAzahOOcpgLZiR73ewELQ/TdcW+QPyX2R2PLTbPlMMUpVIt0ZEQE
 0ufe0cULL+hHOzIQ7PPB4f7/JLlF8FHfebb5M8Bgw6FmL3zsHlwHdu70PajiSRbj4VVudTmoZDJ
 BctKPM48Ba59ELkiLJ90kpVldLHQqOUUxqPjCKbMLWVCURfNY/h4wKoKDPaJp7IACya6ce1v0Dz
 zEfyMOA9nbC+QZw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

We never want a newline in tracepoint output.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index e545e92c4408..7f1a6d568bdb 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1534,7 +1534,7 @@ TRACE_EVENT(nfsd_cb_seq_status,
 		__entry->seq_status = cb->cb_seq_status;
 	),
 	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
-		" sessionid=%08x:%08x:%08x:%08x tk_status=%d seq_status=%d\n",
+		" sessionid=%08x:%08x:%08x:%08x tk_status=%d seq_status=%d",
 		__entry->task_id, __entry->client_id,
 		__entry->cl_boot, __entry->cl_id,
 		__entry->seqno, __entry->reserved,
@@ -1573,7 +1573,7 @@ TRACE_EVENT(nfsd_cb_free_slot,
 		__entry->slot_seqno = session->se_cb_seq_nr;
 	),
 	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
-		" sessionid=%08x:%08x:%08x:%08x new slot seqno=%u\n",
+		" sessionid=%08x:%08x:%08x:%08x new slot seqno=%u",
 		__entry->task_id, __entry->client_id,
 		__entry->cl_boot, __entry->cl_id,
 		__entry->seqno, __entry->reserved,
@@ -1978,7 +1978,7 @@ TRACE_EVENT(nfsd_ctl_time,
 		__entry->time = time;
 		__assign_str_len(name, name, namelen);
 	),
-	TP_printk("file=%s time=%d\n",
+	TP_printk("file=%s time=%d",
 		__get_str(name), __entry->time
 	)
 );

-- 
2.44.0


