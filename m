Return-Path: <linux-nfs+bounces-22446-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ikJqGY8FKmqBhQMAu9opvQ
	(envelope-from <linux-nfs+bounces-22446-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 02:47:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6A166D8B9
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 02:47:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jshs50JG;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22446-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22446-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16D61317B65D
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 00:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27981C84CB;
	Thu, 11 Jun 2026 00:45:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39893A1CD;
	Thu, 11 Jun 2026 00:45:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781138740; cv=none; b=DPSArAI/K+i4fBrMtx2tt8hdiHqLPwr+GUYBI6ubzEsDqpOzQVS72OHPCxtBcD9FBPJOVZj7CPN9NuRKuICShfT1pirjJrOdfLZv8qAc5YQVznrDjrsbnw6JVfDxJJXGw4OBOooWiN7tDR6YE0b/UFFXxuJyZA887TNDzEjNKlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781138740; c=relaxed/simple;
	bh=rrrVqWgIxqpDSRFS2Jkv6kbnlvfZzuAdRDXsUMGaDVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eo6de/MKgAbhERNcqVBCUYAFA/V9/tfq6tCJVFDkQCtwDiYuoV78GZGbNAzLPob5NsTy8EfgapOkkfAXHgFgCcujmZ779+tFpl2dgvPTOmHeWLDczpEVVIz7MBIETvEqKTuCFQhdZ6y/1AsL15W18p2Wa7CxFokZ9zdqabx+DCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jshs50JG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226D31F00898;
	Thu, 11 Jun 2026 00:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781138739;
	bh=rrrVqWgIxqpDSRFS2Jkv6kbnlvfZzuAdRDXsUMGaDVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jshs50JGnp6olQs/l+eLpLrBTaA+hj7YzaxsHUHJx2eSaK3tFHUy2Z9PMatEYDCAr
	 F3B+kyq60UlepPJgZAwDfO2A6lWvhHAVjKo6tG23y50ikrA3RK2U0CY6MFvcznEdlL
	 zA7v1a6ptsxZ9ldU6KCMwgygW2OhtDTkmAYIuQBG9OoZCqco9Z5e3EYtHXaX+XJiWw
	 9upMbQcaX9/Wvnug3RvMfz71GBp9QcEZ7nwjnJ8KE9+i2HozZpF43pPj0E3UlXZyzd
	 273pIKUug1/UCcNUINNQAKzXiekGJYUkCxug+qJpx9jVX82Wv8uZMs+YdgVyeoDebp
	 24KfydKOLN6CQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Vladislav Nikolaev <vlad102nikolaev@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	lvc-project@linuxtesting.org,
	syzbot+e34ad04f27991521104c@syzkaller.appspotmail.com
Subject: Re: [PATCH 5.10/5.15] nfsd: don't ignore the return code of svc_proc_register()
Date: Wed, 10 Jun 2026 20:45:22 -0400
Message-ID: <20260610-stable-reply-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609172356.1887-1-vlad102nikolaev@gmail.com>
References: <20260609172356.1887-1-vlad102nikolaev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:vlad102nikolaev@gmail.com,m:bfields@fieldses.org,m:chuck.lever@oracle.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:lvc-project@linuxtesting.org,m:syzbot+e34ad04f27991521104c@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22446-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,linux-nfs@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,fieldses.org,oracle.com,vger.kernel.org,brown.name,redhat.com,talpey.com,linuxtesting.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs,e34ad04f27991521104c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB6A166D8B9

On Mon, Jun 09, 2026 at 08:23:54PM +0300, Vladislav Nikolaev wrote:
> [PATCH 5.10/5.15] nfsd: don't ignore the return code of svc_proc_register()

Queued for 5.15 and 5.10, thanks.

--
Thanks,
Sasha

