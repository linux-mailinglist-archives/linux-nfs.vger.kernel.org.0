Return-Path: <linux-nfs+bounces-20518-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCnqIBZ9ymlo9QUAu9opvQ
	(envelope-from <linux-nfs+bounces-20518-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:39:34 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6400835C219
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB6C7300DEDC
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 13:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E413D5250;
	Mon, 30 Mar 2026 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrgF8wog"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7002B3D413D
	for <linux-nfs@vger.kernel.org>; Mon, 30 Mar 2026 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877926; cv=none; b=XFrVOllhcp7kDhfJhLxwLfPxQ0IhJmEuq1EzqzhQePQT1Z+yv5NaLonUl55ggQmwKdGV16vwTXbhpZYZfekMm3SmdpC/UY3LYIQNhKzA9eZn3y3wqDh3jurpJfePbUjD8ZaWTLs1o3ANQ1Fd/CxwTbLgc/9JMNaDWUCQ8qrlMi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877926; c=relaxed/simple;
	bh=pLs5uiAKMZOKuVfM70p1l3lCyTX4ZhVTT2WoG0Rn8fE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uZ/YE4eBuCT5+shd8eWol1KpckFBRvGxBR3Ye96eZ0EyoW/sNViKLvTmIUH6A8dFM5iRkctZ5iU4Sb8EBgnjhECIuXO3JHvaC/3mLfsiJx1niYi4CLwBAVieVDtWR17vzRcZRjRFNHm/nFut0BjXEkNduNxlTslFBMFHiwIiFP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrgF8wog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF99C2BCB2;
	Mon, 30 Mar 2026 13:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774877926;
	bh=pLs5uiAKMZOKuVfM70p1l3lCyTX4ZhVTT2WoG0Rn8fE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PrgF8wogA72UOvF5vSQnL7i+iYirQYHhBBqXw+e/6ydsvjz+iNW8bWh6tFck/Zrek
	 U8NyADva1lMSEhA1nIbse7mF86NRyspg8xzw1UWaVXA6nOkKD4ac6LBwBJiwcQF+ib
	 OT+iqQxpB4GtGKd2rEOqVRELNcwMGfSZrtSkZ2h06jhveWpWEFsPd3XDz4MsU8hjfr
	 4txeCUjEFFda8y/9jAszBgPE509gtuwk5Esxj2gQYHsyWxJBLorAK2fSjEj+ymV4bt
	 blSq3wjUN9xaAvf4zkG8jo+r5AiYGKgXtYZljRjsFQB7WuxjikXbBZOwffsLM9Fq1z
	 gE5ACdslCqp+A==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 30 Mar 2026 09:38:23 -0400
Subject: [PATCH nfs-utils v2 03/16] exportfs: remove obsolete legacy mode
 documentation from manpage
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-exportd-netlink-v2-3-cc9bd5db2408@kernel.org>
References: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
In-Reply-To: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1997; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=pLs5uiAKMZOKuVfM70p1l3lCyTX4ZhVTT2WoG0Rn8fE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpynzeFg+p+ilaHstH1XmAM922UuUw0nBnDYZrp
 7EhmVaPrDOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCacp83gAKCRAADmhBGVaC
 FU1yD/4vkqsZlE6IHT2coRq+w5peNjtiv5lYjH/c4vB4K2lpgevmVo7dJ0NrcUUrma8CW4vWbdR
 4KRsvTBTMPKrdYCxNm2OGxpYGYjR8OoYJdBxqqMuz/F6tyv8hIJJ+OGCF1NKmWxI/M81ausO1qD
 d3zs4G/EyG33XqTczp8rCnuNfQrH8b8FkJz5XLQ2tAtDTSe7AzZvPYqUQS6ihhu45dXeRUuwQTt
 hAhnPsayJXf7lIP7KJv/ly6Hfg71V+OT+TVWrmuasXUMVcn6JyqhLSoiThDRvDbJhKYKApSsOT+
 AnfSeHPrMqnCMenxwzXj/uo8cKCnhPlvzTXzW2+GMgLsqqLVUQ304EG9fr0K8e7azsMgDWcRcIO
 vIlCKIgbA4BuWlyufCr3pmQXLIEYr/frxKSvj6+Dda/lF5pmsM68GrrW/BNIwgcz9q8rUMGTtKr
 CtqIZwGyXPFN9bTP4/3vYjyxBjDfwhTO5kvqe6vS6I+jdAw+71x7W1lpRoqnGHoM09W6pMAsOIr
 sOshlsKCEx0bQCEf/ToVoq3mqY2zP0Kf1CfvhDCwgpzGU8/mgXKtf3Lv+wN/3hRyoiNVhJ0ylUg
 OSADAo8To/1h+jhU9ypu1aSQ2FpM9SMAgiGWDuWuax4pmvQ6kIc0YUp64AfH18ZbhVXPrMd4ugU
 ClqtABrOkzXmBPg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20518-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6400835C219
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The exportfs manpage described a "legacy mode" for 2.4 and earlier
kernels that used the nfsservctl() syscall to inject exports directly
into the kernel. This syscall was removed from the kernel in Linux 3.1
and the corresponding nfs-utils code was dropped long ago. Remove the
outdated text and simplify the description.
---
 utils/exportfs/exportfs.man | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/utils/exportfs/exportfs.man b/utils/exportfs/exportfs.man
index 6d417a700340f050c0af5c8af848ebe8403f8379..af0e5571cef83d4f3de6915608b4871690a8853a 100644
--- a/utils/exportfs/exportfs.man
+++ b/utils/exportfs/exportfs.man
@@ -53,39 +53,14 @@ by using the
 command.
 .PP
 .B exportfs
-and its partner program
-.B rpc.mountd
-work in one of two modes: a legacy mode which applies to 2.4 and
-earlier versions of the Linux kernel, and a new mode which applies to
-2.6 and later versions, providing the
-.B nfsd
-virtual filesystem has been mounted at
-.I /proc/fs/nfsd
-or
-.IR /proc/fs/nfs .
-On 2.6 kernels, if this filesystem is not mounted, the legacy mode is used.
-.PP
-In the new mode,
-.B exportfs
-does not give any information to the kernel, but provides it only to
+does not give any information to the kernel directly, but provides it
+only to
 .B rpc.mountd
 through the
 .I /var/lib/nfs/etab
 file.
 .B rpc.mountd
 then manages kernel requests for information about exports, as needed.
-.PP
-In the legacy mode,
-exports which identify a specific host, rather than a subnet or netgroup,
-are entered directly into the kernel's export table,
-as well as being written to
-.IR /var/lib/nfs/etab .
-Further, exports listed in
-.I /var/lib/nfs/rmtab
-which match a non host-specific export request will cause an
-appropriate export entry for the host given in
-.I rmtab
-to be added to the kernel's export table.
 .SH OPTIONS
 .TP
 .B \-d kind " or " \-\-debug kind

-- 
2.53.0


