Return-Path: <linux-nfs+bounces-12069-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2DEACC5A3
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jun 2025 13:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB84F162F6B
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jun 2025 11:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6AD22F14C;
	Tue,  3 Jun 2025 11:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLYlcrel"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BC122DFE8;
	Tue,  3 Jun 2025 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748950952; cv=none; b=SGtQjn7Z4NSoIh7vNuji3nZCxxBfcjSZ46GZwT3Vsq+A5rWF8B+8lVByIQ/FNs+wUCxE1Blzf89bl+UegSVbfOs8ZvICvnw5/Y7MMFUF79PsRTrghlWXt6NIdAZMooIyIB3hzYBIGEvnyD+7sf5ekPyB7QiXQvnuUFOwgwEPvvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748950952; c=relaxed/simple;
	bh=aL8exLSZ0wjjQOCcHJtsFTsyNLK7umIQsd72p0QwE3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vr7O/qSeEcVacq3lJz0sR/TJsPAOqjTVDWRE8k4cxASpl5OANMXXHlvgYuFF/6kJX7ULlMoKuKOg0IXTcvaXvyjp/vI7+1n/8shbc+dps3YMnauy+xELjDMqZpeNcdaxY9Tf6cLh+s4UCQR9qk94lGfSO/lRGkIFkcUtE7QkZWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLYlcrel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB51C4CEF0;
	Tue,  3 Jun 2025 11:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748950952;
	bh=aL8exLSZ0wjjQOCcHJtsFTsyNLK7umIQsd72p0QwE3o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MLYlcrelY03pyYWf3zHh+ipFDnZLgciQlKMdJRr3IkWyAfOpzwGWNNgZuLgKbK/iH
	 rRpE/RAO51LUJx26Nb/e2xgdqaE97uWRLS9B2xNJrcY7wWwzHZY6N+WGDt44dbAj2g
	 0NtHNs5O1C1aV6wAvh8rHyYuG1dZcIg12Hn6ZaQNCdYgc8c2Tio+TH2Ct0tpKzQGpt
	 z90k9A5xPTvnSN7KbfazsvDCCUCK+UHAP23GFBQgWKrWs/qjXZLlhIZlTBbTYdyxpL
	 zWYBwdlfSFq541bFXs8mAAqSniOnYpdkWSV3EkXZE7r/IftTrJnS235EhuYD0Y4KYc
	 Rsma9MgzGAB3g==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 03 Jun 2025 07:42:23 -0400
Subject: [PATCH 1/4] nfs: add cache_validity to the nfs_inode_event
 tracepoints
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-nfs-tracepoints-v1-1-d2615f3bbe6c@kernel.org>
References: <20250603-nfs-tracepoints-v1-0-d2615f3bbe6c@kernel.org>
In-Reply-To: <20250603-nfs-tracepoints-v1-0-d2615f3bbe6c@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1455; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=aL8exLSZ0wjjQOCcHJtsFTsyNLK7umIQsd72p0QwE3o=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPt+mkQj3sVi7bVQwaNN25YIrmtX6SrHY4uRvo
 gGwNzDRUhWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD7fpgAKCRAADmhBGVaC
 FbfwD/9p/DuLSwMTPqlLVYq0IPv6DkcjlcVTCT+7pUtFDHxVa52x+B+TevdEdu7ozx29M1ZnMET
 JrnrKNUtkc5wgKjkoQHzjnpw9lZ8+1XNNdGyCVzU1P0JtlwbGePmo7WJmvmYxCaz/XJdl7VZhRJ
 jtC/FiADHfRUdnf7OeFguXcI9uEBlDWhxf583Jnp9hChGTaAC/dsGvFj8rCEWmPVV1IbEWlP1dk
 UFR9pFrmGd9vs22ZN3JSK4Cpl+Xbnb8ZmWqcZnffKIjkdDvovAs4ILNa8zfub7O+YD7iV/mybtQ
 QdBuTrb9cqWEFD1NqcYRijzxl8Ayobthp92B65EBeaFab2nEfq/oSpjP7uzFrKTEBpWOctpnUwR
 s5gfs/J+lsTdkCXYiGkHLoHtkx/h9JN6/2TVB0mjHWWQxXSxBxZLPMMf67ycBUGdo8Anq8xHhC+
 fdpQsY9jGCWzGJC8afm9RhHPlNft/e5bG8LTbiv7XuLx5tFAeQKW+XK4x0WFqDv+Nh7JgLcrgCo
 XObth18eBkL+xBSOKgpxxuuzHA9/ABHYSWl27WRClHV1HTksecxFzdZ59AO20BENhiv8w9zawbt
 fAl+xCBx1JODDeCAXuq3sYc3+2ngMEyraVTqA8Nd/wB0W69UU+KJX07gkkZyWdS7hdiu8X22e5P
 AT854pdJFzSK1jA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Managing the cache_validity flags is the deep voodoo of NFS cache
coherency. Let's have a little extra visibility into that value via the
nfs_inode_event tracepoints.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/nfstrace.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 7a058bd8c566e2976e24136e2901fbaa7070daac..55170cbf2ff115c85f56cbafb4fc0e06313918cf 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -56,6 +56,7 @@ DECLARE_EVENT_CLASS(nfs_inode_event,
 			__field(u32, fhandle)
 			__field(u64, fileid)
 			__field(u64, version)
+			__field(unsigned long, cache_validity)
 		),
 
 		TP_fast_assign(
@@ -64,14 +65,17 @@ DECLARE_EVENT_CLASS(nfs_inode_event,
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->version = inode_peek_iversion_raw(inode);
+			__entry->cache_validity = nfsi->cache_validity;
 		),
 
 		TP_printk(
-			"fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu ",
+			"fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu cache_validity=0x%lx (%s)",
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
-			(unsigned long long)__entry->version
+			(unsigned long long)__entry->version,
+			__entry->cache_validity,
+			nfs_show_cache_validity(__entry->cache_validity)
 		)
 );
 

-- 
2.49.0


