Return-Path: <linux-nfs+bounces-22986-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v1ANEJZqSGozqAAAu9opvQ
	(envelope-from <linux-nfs+bounces-22986-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Jul 2026 04:06:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 221C17066DE
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Jul 2026 04:06:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Hgr6AmoO;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22986-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22986-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF4CA303129D
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jul 2026 02:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAB02309AA;
	Sat,  4 Jul 2026 02:05:38 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A289821638D;
	Sat,  4 Jul 2026 02:05:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130738; cv=none; b=cFd49S3bHVjH44D20TVFSVnfa2evVF6pQskcEsoRFZheRWXUQi8XY9NZ1fjztPlKJ9rsuY2rlY6RmiHtfMJbzgO8SHk26Os7o/4BVzRT+dAXzXD3GY2UtqLyyxpwGb8PW+4y8XTTz6t9F7F1EjEf9hfYFljjwO+g6vXRXLIL43o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130738; c=relaxed/simple;
	bh=eVwCiDmm0QNuYdJ4EzNxatk3RFYODNw6UYrKYpCp3rI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3IXp5qalK/Y1nh2AHSc/TqmMbOKJTnd5XKXQI+ODa5uOr3UnjiF10K85rwrGx9nhYQhbdvNVdx7y+oa4DgGXKthP3PwO0KAqLuYKBFse1TfkPldB+vw3X/I4SrmJNNn54r+y6My0LocA93C2F3jt1Pi0e5G8Fw09Chi+LhXSXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hgr6AmoO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2861F00A3E;
	Sat,  4 Jul 2026 02:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130737;
	bh=b/n4QgxCsY3Bqjn4pzbOkn4S5xXzV/ohkZrUI7Awwvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hgr6AmoOcf8zPhKaYwwO8QA9WmMU5WHU0UqTLqARA0PxHYEC6UWwd0ZbVrg4410Qj
	 jpyV+Gq3FFY8oBpj0TEC7Itz53VdqFMYGXe73KLGYCLZ6KgfzhsQQiooYpBSJfhWrP
	 00q6fhnslY7RAowLwOe36i+Db14j8x7+kg3MCfxq1127KY1BoxVQlY8+Fly4Nh/5Cd
	 QDZBxazuCQ/1GEgo+sH6pMp/a6yyiAKUW9BiQQz+lj3LQS8UA+9kz/DGivTEYz+d2k
	 bX7bgjZVhmd+TCDD2YVmMFjdrpCMteQIAMFytSCgXo8+ovohIy34iFXaeXbvMRZZ1d
	 RYPaAizApYndQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-nfs@vger.kernel.org,
	Chris Mason <clm@meta.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>
Subject: Re: [PATCH 5.15.y] nfsd: release layout stid on setlease failure
Date: Fri,  3 Jul 2026 22:05:04 -0400
Message-ID: <2026070315-stable-reply-0010@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703033815.1573400-1-cel@kernel.org>
References: <20260703033815.1573400-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:linux-nfs@vger.kernel.org,m:clm@meta.com,m:jlayton@kernel.org,m:cel@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22986-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,meta.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 221C17066DE

On Thu, Jul 02, 2026 at 11:38:15PM -0400, Chuck Lever wrote:
> From: Chris Mason <clm@meta.com>
>
> commit 30d55c8aabb261bc3f427d6b9aae7ef6206063f9 upstream.

Queued for 5.15.y, thanks!

-- 
Thanks,
Sasha

