Return-Path: <linux-nfs+bounces-21946-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPudJ096FWp8VgcAu9opvQ
	(envelope-from <linux-nfs+bounces-21946-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 12:47:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8695D45D6
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 12:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11E8E302A04E
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 10:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914CF31ED93;
	Tue, 26 May 2026 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSiM6mSP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E10E2D8399
	for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792362; cv=none; b=QCosX2EMPd4sCrrqy456TQR5+dBIjwdSyL23SMJUNhHZqJZE8EXuSA6rcNgObSsjD3Rrai5xMsDY88mRRQbCXKIJlFbX5NJSfZVs9/fPfeSDOvA7tDo6orvh0wd8YrzKIEpze3if1AufJcUIwL4CoynKS726m12v0dQrjfw/71U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792362; c=relaxed/simple;
	bh=/j6jIf6tfQTExqkuosO5rEGQfFVHOjNEPx751S0PfyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oytqYwZ5rzu2XMN2JEEJZz684og/l8cdXuLXUT7gg5UGUJJ9qD1JYVskILc5yosLajaFO4WhEjJ34lAHbTNriGX4T9p5ZzoAONuXh7bIeIk0U6E28Mz7bnhpymSYr09yScbAVCjdup5yemREKK9GJRvmkRrJSa7NOlGWbG5wQc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oSiM6mSP; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-367c2a39fcfso4779798a91.3
        for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 03:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779792361; x=1780397161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nacu7PMt2c+Y+omPIW4rycmeu94Ha5NCEkYzpWfn5Vg=;
        b=oSiM6mSPVd3Z8TB8voKaeQemhO2+EoEVmVJ7/eXqq5HphrwxBS1Ip67H2pPUqzdd5n
         KlwZrjBou2Ein41YWsHHyYBPwEUlUcH5pf5i6R+FZSYnpwngp75RE7gQxlLCeIZ5RZu3
         U/EscxF2FO7KspAQG/8zhy6KHn4IlEd4DbAw4RN0DAaHUtla738NXjIbCYaLLXggV7+e
         4b54QT/kzloOriGWo6bNvdXHvkGfKrDip8sJgE49yAeYQiC/1fpMbfcKMbpkocBOiNBe
         SmX9RvyjxzXSvzvUB7SeyYkb6jpBvwWBR38sZbHioRvNikTgBY0dkWgD2zWkz4lr/WGW
         rq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779792361; x=1780397161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nacu7PMt2c+Y+omPIW4rycmeu94Ha5NCEkYzpWfn5Vg=;
        b=coHovl2Z0qX4vtFrTrppaF5F54/M6Lk2YIcFXZnvcKN83WvLXxlB3+6CA9kojK2Egb
         xFYyUeWd+mMbNbzrOh9fP2P4G9A6g+FLmWcVFD82tfSguphKGcgbuYz3UwmVq5kE6k0z
         eupo6T+JZq9ZtPzGFJw+SnPOBh8Yvg3fQWfdioltSZKmZydVbhtL7btV2nQzWptpWgZA
         oc4TjRhTYBKywD1EyMKWxlnK+VeIl1KRjpfgAIVH8a3B7deGZ8E5jTaanH/3K7G+MVkO
         m9DLDKcG24P0Aq5607LKIi+G8nQ1uVPpp4lutF0nykF3LvMRLSn29xRh086+2gSV3/AN
         5/YA==
X-Gm-Message-State: AOJu0YwqE66Iwd4nRVWFEaA5kxnc3nQR4MSTcO87HpBaj+NffYovfERz
	rdHo1u0oWohTXCC0SRlYkxJeDXv4uWmymhH1Tk65RIuiWRPLgaCjlAwM
X-Gm-Gg: Acq92OHlpEZK2QK//X3rHfrWQqj66GYwyBonfngA0uUe72cUpqMboqnzMkJLjr1GSud
	9xBSm9xa3LS0jaYqeGDpWjI9KK0CxiIt6nWGWLXFxt2ynPqz40hgntqtDcOCp7JdSeyC2JUoAa8
	xRD8g/ttKv091XIGyxL5uL7Q59lnAJ6xhgJMrmvBtWpvQXY0EkQYEhMq8CwJdwIlonqd9TiRl8d
	2eYX/xtroHP64j+TOf6Ymv8mb5aknLm1XqWQUjQspeWt6DsE52sIRjdT8VTdT3lXGJ6mEtRWLcl
	jq24w4IQWjncP3G50lmwXxTEVFGFWdb65TjOnB5/dNPz3GwBP8eLlA9k5Ts/cpmrdCGHFJQDuUL
	5TrSz3kLJ5KTNOGhtsTDKVE/1EdNLC2d9p4O74qBVbvlp1TEvFZky60UysQcazaLGzUQihDAEcD
	B+noVbNLSFrlgotgIgMMbOdDy233bkXAiRxxn5vRHsKihH5JRBn87LCAPEii9S
X-Received: by 2002:a17:90a:e70c:b0:365:f8fc:3846 with SMTP id 98e67ed59e1d1-36a67627cf0mr18027701a91.22.1779792360690;
        Tue, 26 May 2026 03:46:00 -0700 (PDT)
Received: from KIPREYXIAO-MC2.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36ac1fe6df3sm6660727a91.2.2026.05.26.03.45.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 03:45:59 -0700 (PDT)
From: Zhenghang Xiao <kipreyyy@gmail.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	Zhenghang Xiao <kipreyyy@gmail.com>
Subject: [PATCH nfsd] nfsd: set SC_STATUS_FREED in nfsd4_drop_revoked_stid for delegations
Date: Tue, 26 May 2026 18:45:54 +0800
Message-ID: <20260526104554.46262-1-kipreyyy@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-21946-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kipreyyy@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EC8695D45D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfsd4_drop_revoked_stid() handles FREE_STATEID for admin-revoked
delegations but does not set SC_STATUS_FREED before releasing cl_lock.
revoke_delegation() uses this flag to detect whether FREE_STATEID has
already processed the delegation — without it, the freed delegation is
added to cl_revoked via list_add(), producing a use-after-free when
cl_revoked is later traversed in __release_client().

The SC_STATUS_REVOKED path in nfsd4_free_stateid() (line 7590) already
sets SC_STATUS_FREED correctly. Apply the same pattern to the
SC_STATUS_ADMIN_REVOKED path in nfsd4_drop_revoked_stid().

Fixes: 8be12e0cf211 ("nfsd: convert global state_lock to per-net deleg_lock")
Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
---
 fs/nfsd/nfs4state.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6837b63d9864..e1ef88bc9793 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5071,6 +5071,7 @@ static void nfsd4_drop_revoked_stid(struct nfs4_stid *s)
 	case SC_TYPE_DELEG:
 		dp = delegstateid(s);
 		list_del_init(&dp->dl_recall_lru);
+		s->sc_status |= SC_STATUS_FREED;
 		spin_unlock(&cl->cl_lock);
 		nfs4_put_stid(s);
 		break;
-- 
2.50.1 (Apple Git-155)


