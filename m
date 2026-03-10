Return-Path: <linux-nfs+bounces-19949-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH3HFGwZsGlAfwIAu9opvQ
	(envelope-from <linux-nfs+bounces-19949-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 14:15:24 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C85924FD23
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 14:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A3743165D66
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 12:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4203DD508;
	Tue, 10 Mar 2026 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="PqCygKH8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D054C0404;
	Tue, 10 Mar 2026 11:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143765; cv=none; b=mqKqEgP9jtWFgkEpdi9aV2k/mZoGGEDUorQSKGj8k0H4m65eXKShP8rmFP3Pv9jQc9zNQwPagXcORds9zWG1a0mYKo6ADADoyul5eGe3o+KGP89mbE5rDagcSAqx3ysj7UBoPJWI7J+hBCKZyhsmiCI2sWUmH2Xl4GRlTeAdteg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143765; c=relaxed/simple;
	bh=ljsuTOpGREUyGER98xbD6/ci86SD8pohlonTQBpqGIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dQUXavUinhQ9B261+Ds3IfsU9YTM72bnxTJoyMocc62ebnEM9zNo7yu1tDtVOvLO+VjEI5rdCa09BHrn0U2Ec4N8AuO6m4kAOZnJJPlJrPot9TFR6tcZa3wQmMJBAU2ZDuUsJ+QmI09LxqPrHyb1fEnzxfCm4/tSEG274iQOkWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=PqCygKH8; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143728; bh=ljsuTOpGREUyGER98xbD6/ci86SD8pohlonTQBpqGIg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PqCygKH8TUTFzdsVoltpS6V+urh3nKuUaWPGyQ9+G5dBBIMLMlSqFUF2pQu2ztCks
	 nKjygDeUmN//qOptE9nqaXpkixC5XmuX8GEDJn5HpI8613PWAZldzQgtG5ilRHjEDe
	 PPv3OqXdqRSmvRO/4sRCoDxU/Kdn2GWugjDbKUbA=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006b0-b734-7f0000032729-7f0000019cb0-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:28 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:28 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:49:25 +0100
Subject: [PATCH 59/61] debugobjects: Drop likely() around !IS_ERR_OR_NULL()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-59-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
To: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-mm@kvack.org, 
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org, 
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, 
 Philipp Hahn <phahn-oss@avm.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Thomas Gleixner <tglx@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=ljsuTOpGREUyGER98xbD6/ci86SD8pohlonTQBpqGIg=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAafUF4Co3bKHEJh1nSPEbGPanpbmXqLGBVTE
 nsli8aGTIqJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGnwAKCRA0LQZT0ays
 2/eqCACfKEiwIm4grjaffCaqYK9UtMC/I42k93h5L5QQzw4cYMYd8FGhvLp+Ug9Jk9iQltpydL0
 M021kU+8e5LuC9HNGAP+FvXfKicTrLe4WOGLghTKJxJD0Qnwt87qFBwN4C5TgDS7lK8yPptqdRT
 xavsstUunap8iVxwbzeUWdgcTpG4nsY9KAjliWo7xLgVYhCSEWYrkYbks39zWe9p1rptJWM2IT/
 +/O3p9icHSV3twwgGTFQhBYPys+tvE7XNArxXHhB+XYW7AEdqLgSeLiL6ig5y++9xZFwEIcnWi0
 5dJklCZYTethhL0MgTuOAEkoSCl0Bk6MDrD8akTrSRkzdCkv
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143728-7AAFCA3D-1B7F7E41/0/0
X-purgate-type: clean
X-purgate-size: 1118
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: 5C85924FD23
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[avm.de,quarantine];
	R_DKIM_ALLOW(-0.20)[avm.de:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19949-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[avm.de:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[56];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,avm.de:dkim,avm.de:email,avm.de:mid,linux-foundation.org:email]
X-Rspamd-Action: no action

IS_ERR_OR_NULL() already uses likely(!ptr) internally. checkpatch does
not like nesting it:
> WARNING: nested (un)?likely() calls, IS_ERR_OR_NULL already uses
> unlikely() internally
Remove the explicit use of likely().

Change generated with coccinelle.

To: Andrew Morton <akpm@linux-foundation.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 lib/debugobjects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 12f50de85b621a743a5b6f2638a308f6162c6fcc..12e2e42e6a31aa8706e859aca41b81c03889cffe 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1024,7 +1024,7 @@ void debug_object_assert_init(void *addr, const struct debug_obj_descr *descr)
 	raw_spin_lock_irqsave(&db->lock, flags);
 	obj = lookup_object_or_alloc(addr, db, descr, false, true);
 	raw_spin_unlock_irqrestore(&db->lock, flags);
-	if (likely(!IS_ERR_OR_NULL(obj)))
+	if (!IS_ERR_OR_NULL(obj))
 		return;
 
 	/* If NULL the allocation has hit OOM */

-- 
2.43.0


