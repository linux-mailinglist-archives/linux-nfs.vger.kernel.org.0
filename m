Return-Path: <linux-nfs+bounces-20871-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IE0ZKWAY4WmmpAAAu9opvQ
	(envelope-from <linux-nfs+bounces-20871-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:12:00 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3310412685
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBAA43071C4E
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346902E06E4;
	Thu, 16 Apr 2026 17:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrnAIRHn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113CE246766;
	Thu, 16 Apr 2026 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776359381; cv=none; b=Y0DvnhDTOAfZIDUarLYX84mqlqoRtJpQEXXD2BQ7Wp9jtLzEaCMQrxbKgyvcIgMMrb5nQVwUILnzI3HPyfZ0yUoOBMekxHqulVQHyC7xH2qPAeN8C4pNtP+HDHKVgmRi2qbHpQ9Qu7SnXtGqJpKbpxwlSeRHDLG9pSIh7ONiFHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776359381; c=relaxed/simple;
	bh=KAiERxxymUZpTj+6Dq8+1Qx+Mxf7DJP+uiI9pcwBTAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDWIUfEnv+ba14xATq8so3L+U4ejudGAj50YAnJ9LTJydRmleRFdx5v/8njrvnH85A4wLR8MDatRhi0oNeJEzIXob0U2E301PyzJz+t00Xgw9uVdOi4spxn4/NB9qGgyhf+JXX0tb2SKaQbiUqcRmTR3bcdX72xaxZCugSreglw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrnAIRHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1D8C2BCAF;
	Thu, 16 Apr 2026 17:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776359380;
	bh=KAiERxxymUZpTj+6Dq8+1Qx+Mxf7DJP+uiI9pcwBTAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VrnAIRHngsP5l6EAmhIcERhAOe18S2Hs0LRqntV+xTKqozCUT8OsmQmffb053F1FN
	 zyKARiD12meyvOqNCrW/VqA5cRONe96bFF+IInym+SKGIhGKGZ53yhSDcAQUl7rVE6
	 dR55xaQRLauCUSp7g0/XJSUI9mzfyyeC7pUt6udtPzh2IHPaU3chsLLu6oEFhN0O1I
	 SBEl6jgybcBXEouL5YZpas4c20cqzFt+q+TX4v9svEUcJ+1yZkq7zUn3eJFh/1Jato
	 Jv9rKQgBDEbfobSAWq97I2HDNL3TmoY7t9DHh+6VPD2z8WKbqZX2fyJmd3vDnulEFW
	 uEz15RSiChxbQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Anna Schumaker <anna@kernel.org>
Subject: Re: [PATCH] nfsd: add missing function name to kerneldoc comment for nfsd_nl_parse_one_export
Date: Thu, 16 Apr 2026 13:09:36 -0400
Message-ID: <177635936245.12505.1422177037243680976.b4-ty@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416-nfsd-doc-v1-1-313ee1b29ff6@kernel.org>
References: <20260416-nfsd-doc-v1-1-313ee1b29ff6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20871-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[brown.name,redhat.com,oracle.com,talpey.com,kernel.org,gmail.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs,lkml];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3310412685
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 16 Apr 2026 09:10:00 -0700, Jeff Layton wrote:
> Anna was seeing these warnings with a clang W=1 build:
> 
> Warning: fs/nfsd/export.c:845 Cannot find identifier on line:
> 
> @cd: cache_detail for the svc_export cache,
> Warning: fs/nfsd/export.c:846 Cannot find identifier on line:
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: add missing function name to kerneldoc comment for nfsd_nl_parse_one_export
      (no commit info)

--
Chuck Lever <chuck.lever@oracle.com>

