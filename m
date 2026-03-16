Return-Path: <linux-nfs+bounces-20226-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIHdJ31vuGn5dgEAu9opvQ
	(envelope-from <linux-nfs+bounces-20226-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 22:00:45 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D3E2A07B4
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 22:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACCE131453A1
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 20:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB0435BDDB;
	Mon, 16 Mar 2026 20:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAF00WBf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE1F35B63C;
	Mon, 16 Mar 2026 20:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773694611; cv=none; b=Ehf4Nv3xcnnHo0Oj/yfzKCtLegzIqfDFQ06zLE0kOl5fpf/pDAcp5VLl7eOJDTptpYVa7UJOJJ4ty5pKvJL4l4XI5UjR49CrFHYTyQmxjniTYHIoSt322voM4wee2f5WhIrG6MD/nhDOWcm2E7txpY9BAb46ahutlHyDSOfYadM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773694611; c=relaxed/simple;
	bh=mPQLNrvJxby8OrRWRktusWjAD03p6yjC2aKDQRKM6U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qAnZEgk4LsQzgxS6Sp4Oa3IwQwKR7fV/vxyHBPqFg2AYJzIXEy4Wg1zmn/Qij6BWji07K9PHsln6vhvDMdZnUlogQTf5OlPUaxtjTDUvbLn3DllkIszxlzQzZSFGWRp11WkeiWUxsITmEN7i66JVct0kpzZISqRZs2hiAS1Cygc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAF00WBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7079FC2BCB0;
	Mon, 16 Mar 2026 20:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773694611;
	bh=mPQLNrvJxby8OrRWRktusWjAD03p6yjC2aKDQRKM6U0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MAF00WBfl7xHK6lfkaXTdSjQ44JTUncoWGJJaYdWS3W3Fa0ASHxC0xGclBN1lYG0y
	 /0GjN4QjNghf/qUE+sJQJhPIgaMQUOKjqnWPky0nUe7+0GNH4rLcIwd9L/KJPtXL+5
	 ogdjWuIcrHGZ+c8RuFLOVXZSrvOR50wnX7ByjavFL+jL6zoDw4xZYHcdBVLW7vwL51
	 MCbmrG/knUcKujz4SB7SZ6Crg/t4OXIsvD97u8SxCEjHTJa+jIrUFUOykJbQczYnoa
	 nxpu7GpcckozpYI+VvauLWHof8v7Z3yZG3j8zaW7M6OtRc0HhZVzX9B9/nNRNFUmT6
	 /Fjjjczrvdd9g==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Joseph Salisbury <joseph.salisbury@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: fix comment typo in nfsxdr
Date: Mon, 16 Mar 2026 16:56:44 -0400
Message-ID: <177369453347.774056.11637949607530609596.b4-ty@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316182845.155269-1-joseph.salisbury@oracle.com>
References: <20260316182845.155269-1-joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20226-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid]
X-Rspamd-Queue-Id: 48D3E2A07B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 16 Mar 2026 14:28:45 -0400, Joseph Salisbury wrote:
> The file contains a spelling error in a source comment (occured).
> 
> Typos in comments reduce readability and make text searches less reliable
> for developers and maintainers.
> 
> Replace 'occured' with 'occurred' in the affected comment. This is a
> comment-only cleanup and does not change behavior.
> 
> [...]

Applied to nfsd-testing, thanks!

Removed Fixes: and Cc: stable -- not appropriate for fixes to
misspellings in code comments.

[1/1] nfsd: fix comment typo in nfsxdr
      commit: f5d9cf47c90f38e1332436717fdb6683d378f32d

--
Chuck Lever


