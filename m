Return-Path: <linux-nfs+bounces-18713-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIFGOQd6g2nyngMAu9opvQ
	(envelope-from <linux-nfs+bounces-18713-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 17:55:35 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EE0EA9B7
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 17:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C81BE30541D4
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 16:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD84E33B6CC;
	Wed,  4 Feb 2026 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEvmMtzs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB26C313531
	for <linux-nfs@vger.kernel.org>; Wed,  4 Feb 2026 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770223727; cv=none; b=hDZVIMnxoz2qh5TMbV+7prl9VH8lquNu9yqIwJ2W92Vytu0lIb1A2lGsV1ILIE1+hFPKElXuRDZCx7R9BIEgrkWNtis7Qs06IZQJQ7CU4eOy4pPqniSl8F7KUREU/yWBW6ouLIj9n2tM/lOJiqfhzj/Jth+PBv3aU5pghsAVZRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770223727; c=relaxed/simple;
	bh=GM33+VQ4KCtofNP2S3WEt4RBKBIqZKjoLejPwlIWouA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dO8mp8mwswiwKWAIRt1Z+UZhN4E1XY6fHKEgUZ6Z5ndrPBowhwl+HOBvXV2qzZzBsGljXyl1bqqZZzyRPKpkBQUrSEePF6ziRFLIQkuyDM9NINkJ8B9zpE86ovQZT9khLL/AqpeCVlqaKtr1hSodhCQ0Dkr3U53yXbIS0pdcyDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEvmMtzs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6E2C4CEF7;
	Wed,  4 Feb 2026 16:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770223727;
	bh=GM33+VQ4KCtofNP2S3WEt4RBKBIqZKjoLejPwlIWouA=;
	h=From:Subject:Date:To:Cc:From;
	b=SEvmMtzsDJOoeeBIf482uq5im9Db/eHOVhU7AG/55nyrIsvRPpkTvL7hsZaZ0MUcr
	 poxdwlKaBvn5wXkNxj40XkzD5j/iMGetD4w9zS7tkAZHsd8N7bRQtd9CmsVqwnntux
	 Zt6KiucPf2w2O5+F+RkguIIK7dZQmiIxY6TxE/KZRB7yvobvvjwVjInLPtO9IVYKVv
	 krkrMBLFgbsWTrOK4jMZLHgpugSiPA4V6uxOPwV4e4I3YcXHGp1rYk26xVR/fQmeXY
	 plFUmbk514NlUeD+C472xLD1YKUuqr+CSn+bB6rV20tKe5eAgxMdeJsKH0LknSC/xx
	 el82rePnPqxtw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH nfs-utils v2 0/4] nfsdctl: properly handle older kernels
 that don't support min-threads
Date: Wed, 04 Feb 2026 11:48:21 -0500
Message-Id: <20260204-minthreads-v2-0-a7eba34201e9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02NwQ6CMBBEf4Xs2ZqlNFg8+R+GA4EtbMRCdpFoC
 P9uQzx4fJmZNxsoCZPCNdtAaGXlKSawpwzaoYk9Ge4Sg0VbosXCPDkug1DTqXFoW/IXrEpCSIN
 ZKPD7kN0hBjWvhUeFOkUD6zLJ57hZ86PwM7p/45obNFUonC/RB+/d7UESaTxP0kO97/sXXnFVZ
 bAAAAA=
X-Change-ID: 20260203-minthreads-402ce87096e0
To: Steve Dickson <steved@redhat.com>
Cc: Ben Coddington <bcodding@hammerspace.com>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1453; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=GM33+VQ4KCtofNP2S3WEt4RBKBIqZKjoLejPwlIWouA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpg3hodZ2lns00nmPhzkT9lJGpQw0tk7uGWJ3Eo
 C3oPhaEfdWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaYN4aAAKCRAADmhBGVaC
 FWm/D/0YxXexGmQheqq2abCanDQ3ruGblDEqzoS3n8ak/JSOaCkblgV07cP79wz6qZT/dNBrst7
 7UWsS3c1AcsyyJ2s2QqvsB6bBDx+Z4SUdOYiE0EbN1kzAwf2ymgSTKjErZ+VjPuCASNDBecEw0W
 K2rUKsuD8TCl0MKNzZy+c0cFDQdQKwYi1Rf1dQOX7BJmMXrMtUVbbk2SXh213gEN0ANmNlDc6GO
 9mxIbDF9USB9oq8DiX+MNluqwQnUZOSt6hsPSJlqnPZtISTxinIiQrC6Wj+c1LbnWx+eieP2/Nq
 EVDo/OfWpTDcfjgWIQwl6swuRbn0onYCRE4trFz4G2EzdpUfnXLlFnG/jKu/XPDwvzoERv8o1a+
 ddzciHzevc+s60sU5Mo+1irVMxBSll7pG+IANhX3LDOZ0rCA4nSdi/AGTosc999oO2Ahrn9/PDT
 pkDASblWohVtZgxPVJf368HcyV72e8dx20n21rfzjirJ2lcWx/ni2HDSHIm8pUpPlgIW0Scf46n
 J43McSyYH4vCdqEAj3stQe4wIXI4DZ/xoMdm964ZrUHqqWgGBb1YkV1jdUBwIRQpASlqj1497oM
 rm9LZbjCpHovLIREg+9uySZcyrNiqQ9AS3U4A3NHMyHMbCU+CM24fkWf0r22C9C4M1AHPh4Vy50
 uuQK/6D0L+5Xb8Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18713-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48EE0EA9B7
X-Rspamd-Action: no action

Ben reported a problem with using new userland with old kernel. If he
tried to send down a setting that the kernel doesn't support, it returns
-EINVAL to the call.

This patch series adds a mechanism for nfsdctl to tell what attributes
are supported by the "threads" command. If can then use that to
determine whether to pass down the min-threads attribute or report an
error or warning.

This also removes the dependency on the UAPI headers by properly
maintaining the private nfsd_netlink.h file.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- Add patch to unconditionally compile in min-threads support
- Make getpolicy_handler() return NL_SKIP
- Link to v1: https://lore.kernel.org/r/20260204-minthreads-v1-0-9f348608f884@kernel.org

---
Jeff Layton (4):
      nfsdctl: unconditionally enable support for min-threads
      nfsdctl: only resolve netlink family names once
      nfsdctl: query netlink policy before sending the minthreads attribute to kernel
      nfsdctl: remove unneeded newlines from xlog() format strings

 configure.ac                 |   6 +-
 utils/nfsdctl/nfsd_netlink.h |   2 +
 utils/nfsdctl/nfsdctl.c      | 204 ++++++++++++++++++++++++++++++++++---------
 3 files changed, 168 insertions(+), 44 deletions(-)
---
base-commit: 8f54511aefe1455161a6c4406ed8c770139f61e3
change-id: 20260203-minthreads-402ce87096e0

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


