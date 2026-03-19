Return-Path: <linux-nfs+bounces-20268-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qP8fLt/4u2llqwIAu9opvQ
	(envelope-from <linux-nfs+bounces-20268-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 14:23:43 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 626CC2CBE6D
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 14:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9B70302D18A
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 13:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24173375F7D;
	Thu, 19 Mar 2026 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHWFFRsG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0027F3CE4B6;
	Thu, 19 Mar 2026 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773926620; cv=none; b=BP7aMon+5vTYQbTRkiZD6n7glnSKqXHwlUutaZI92kTVWEMwXtlNpQy8g3/N0TrQMqUQEp1T1FPwwTUdehjyvapfYzUkbmx3QtAy+agPPsPIArl7Q0L5YQtESeKzAxsaNN8uhN6k1qe5MGWLj2N5ZMTCIX6zG9pe6e7zu12gS8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773926620; c=relaxed/simple;
	bh=F9QSgLm4eCZ9LBBJ4CAd/aJsUo4/reK+0URj2PC64ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2d3mzl9x++tehXo1jpSxO5bFdXASAy3WqA/V/eFGxMk/KtgiJo3Y80xy8eNERh41ulRUbGk8eWuQjkd86gVa9F8hwkBHFRO23gYm1yomrDV8vBUu1kcuVxZcMo4WMMZzNyQd+pjPc6gEcFxjKotPYCSc1AGvvrnTKwtb92usHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHWFFRsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251D4C19424;
	Thu, 19 Mar 2026 13:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773926619;
	bh=F9QSgLm4eCZ9LBBJ4CAd/aJsUo4/reK+0URj2PC64ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nHWFFRsGsHh9ArmykQHgd4MaVEksXvEc5uL1FktWB6T4q1zAVgNgqzUF536iLJJqg
	 4cZu7xSdutQu9IVmigX+BjhK82dtt7CLYjj2Ok3yTxfIHkDbgx03iQ34XtUzfuxHmZ
	 MXW1OKtLkzFMAFcdYegSJTh5N2bCtXsvzvZGoi79zv056lLvBgr6XaPXBegzv6rduE
	 YpvlJ8C3v9rCrKdqfZ7KprotUiXLbl+nxdMQduiE5J15dyolVDooInucnKj/2uJGJG
	 0nXqb+C9mnh5albkmC++HcAZq/YqSaIS9/IC4o9HERkQkXfUyIrMf5Ce2pgantVxn/
	 kp+k7Aww3WFlw==
From: Chuck Lever <cel@kernel.org>
To: linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] NFSD: Docs: clean up pnfs server timeout docs
Date: Thu, 19 Mar 2026 09:23:35 -0400
Message-ID: <177392660826.2548952.14857120018688840364.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318222105.3031225-1-rdunlap@infradead.org>
References: <20260318222105.3031225-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20268-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 626CC2CBE6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

On Wed, 18 Mar 2026 15:21:05 -0700, Randy Dunlap wrote:
> Make various changes to the documentation formatting to avoid docs
> build errors and otherwise improve the produced output format:
> 
> - use bullets for lists
> - don't use a '.' at the end of echo commands
> - fix indentation
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] NFSD: Docs: clean up pnfs server timeout docs
      commit: 4961fdf3193741f9b8004ba61238a99cdf396286

--
Chuck Lever


