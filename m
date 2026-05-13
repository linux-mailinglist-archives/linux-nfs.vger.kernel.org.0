Return-Path: <linux-nfs+bounces-21601-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEPTI0mJBGoxLQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21601-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 16:23:05 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 93347534F46
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 16:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 72DFA301903A
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 14:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1412BE630;
	Wed, 13 May 2026 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ld8yWLnq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4760E2BD58A
	for <linux-nfs@vger.kernel.org>; Wed, 13 May 2026 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778681382; cv=none; b=bdqdTfuXKkC5NX/o+8hR50mHwr1LYiCM/V8IgQdQcWeMrT0WA6fK06P0xwTRD00H/7/Ff/k3XuGtQKRVRFKkJrIcQGfmGlt4yI/iOWDk90Z54BN/JNnvpyOm4O9CqUdqS5RTedWXXqfHYoCxyeK+Ml28eMunA1z/EzsH79DIz04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778681382; c=relaxed/simple;
	bh=Af9a4+zMPcLBbsnN07O2fIHi/79TKP7oS29Fe6gyf5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VSlUkKQgYyEJLyKaGTVkPkoq39WbkX5/JrCHQZ0xxgWiQWKyD7DZqgFdRf0GIqmNUg55tiGDJL3ncg96fkdbzuJFPZxbnMKfTWUaldldzW5F7Jrayw7TJ7UkW4wiaoM+x63iVvvWJDnAHSu9uswUbjIUvNo+ftmqXKQhYc9Hdr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld8yWLnq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA22C19425;
	Wed, 13 May 2026 14:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778681381;
	bh=Af9a4+zMPcLBbsnN07O2fIHi/79TKP7oS29Fe6gyf5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ld8yWLnqi5qyitBTW3MD6eun2vMCPf84/omohR9SOMbX8HV+UDIF8mZdPSoiZlQjU
	 47KmgqcAtOdY1LC/jsKP4k4OATBtH7yjJFL43eXQ2O8oRxfilxNeiKKVRNCoHgljj8
	 AQF60onT3Jq/j6RixgnHlHu9g5GgcHaXFSPSmqH6kxci9qXNOAsoJUumnQucoV3ZcL
	 uBImwPI/+q9Od46fJMnzwQL/KyevYd855OfsZp8HYeFaCTMLoYIdc9V4nAVmzKPD3C
	 Yx+aAGxfpvxB5YU3LibozsrwjcVcKiRPz9tQDYF+RtB/452C2ZNQOGyqPT6bFkkTdt
	 86rLfESHsOOOw==
From: Chuck Lever <cel@kernel.org>
To: misanjum@linux.ibm.com,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	Yang Erkun <yangerkun@huawei.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	yi.zhang@huawei.com,
	chengzhihao1@huawei.com,
	lilingfeng3@huawei.com,
	yangerkun@huaweicloud.com
Subject: Re: [PATCH v2] Revert "NFSD: Defer sub-object cleanup in export put callbacks"
Date: Wed, 13 May 2026 10:09:37 -0400
Message-ID: <177868131676.213195.3678046994150964706.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513024252.3681597-1-yangerkun@huawei.com>
References: <20260513024252.3681597-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 93347534F46
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21601-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

On Wed, 13 May 2026 10:42:52 +0800, Yang Erkun wrote:
> This reverts commit 48db892356d6cb80f6942885545de4a6dd8d2a29.
> 
> Commit 48db892356d6 ("NFSD: Defer sub-object cleanup in export put
> callbacks") describes an issue where calling svc_export_put, path_put,
> and auth_domain_put directly can cause use-after-free (UAF) errors when
> accessing ex_path or ex_client->name. But after discussion in [1], it
> seems cannot happen and either will introduce a gression that was
> already fixed by commit 69d803c40ede ("nfsd: Revert "nfsd: release
> svc_expkey/svc_export with rcu_work""). Therefore, reverting commit
> 48db892356d6 ("NFSD: Defer sub-object cleanup in export put callbacks")
> is necessary to fix this regression.
> 
> [...]

Applied to nfsd-testing with an expanded commit message to preserve
the context of our discussions.

[1/1] Revert "NFSD: Defer sub-object cleanup in export put callbacks"
      commit: ef4e34669aa1a15d2f5ba86fd433fcac9aee81c9

--
Chuck Lever <chuck.lever@oracle.com>

