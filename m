Return-Path: <linux-nfs+bounces-21838-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKGFC6+zEGrRcgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21838-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:51:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B65D5B9AA1
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CD053005E9B
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 19:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53D537BE62;
	Fri, 22 May 2026 19:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nurr6JX3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60843090C4;
	Fri, 22 May 2026 19:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779479239; cv=none; b=bbZm1UxY7eCklI4OgHUe5m4VVw3RHQPFmS5xQhqa0AXcCbpLk3E7IrCYN9n3ySSInWCt83BYb8Jwn5upvQ6wBSA+h0PGtSbCqr0yQGV+EVF2Lo8gZvlF7OcrWzjVjEL8t3+SNibF0wix0N69i4z7riCqopChmnxuCLfPhl/1OTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779479239; c=relaxed/simple;
	bh=ZSSRAB6P2/+NlBRCNknOkJKSb2YiXn8wUXKWybsZfxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fDS4G74SiN7O+Jzx8AehfzB/2vZFZ/JKYi/NRPX4KpTiAGjBLNE3+WsBBgj9bVdKQsGp7dXsrDeSr+aP1zQC2IK4sLaQSh6MK0Z5wW4/oaPoE3jmLd5sRgIeenqYpdhsGrfmUVJ6JqTvBDaaFnjLifAW7Sq8PxmhUIIsh/wMZ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nurr6JX3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A0C1F000E9;
	Fri, 22 May 2026 19:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779479238;
	bh=P4KfoTqGFUkkp2bEQ5L0qg90xqVtvgyZZcJfQC49tOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nurr6JX3ljNpzx4BFxI71jiak90TDbF3LHoLLM9HGIFgQDr0tPGjsxa/pUSzIMK+g
	 c4Hv4u/2KJ8KGG72bWtX3xUTEOBe8cjKPYaUdk2sNzqbxTZGh7vU4PAFLBWMJ8CXd3
	 ZPltf5MNQPO/iEB2Q2jrvN9usFFyldFzbYbhV/HzhNYxmou3uTfEEJ+YiDn1ulHel1
	 b44GO4Zu67UsDwdDpBckayRBZo5sKKaNm1eSC1785PxM1v5EjJqKw3r6BWv1g5PgQO
	 G1ssnJNi+5jdhK5OWJd61tJv/hzu8sYia2s2Wt9uVwN/Glqi7Q4aFE3uhqUdSNf46k
	 qpmgvFyeI7msg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Mason <clm@meta.com>
Subject: Re: [PATCH] nfsd: reset write verifier on deferred writeback errors
Date: Fri, 22 May 2026 15:47:14 -0400
Message-ID: <177947922768.436725.2281666345201020597.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522-missing_verifier_reset_on_wb_err-v1-1-bf9f427f9b26@kernel.org>
References: <20260522-missing_verifier_reset_on_wb_err-v1-1-bf9f427f9b26@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21838-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9B65D5B9AA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

On Fri, 22 May 2026 12:44:19 -0400, Jeff Layton wrote:
> nfsd_vfs_write() and nfsd_commit() both call filemap_check_wb_err() to
> detect deferred writeback errors, but neither rotates the server's write
> verifier (nn->writeverf) when this check fails. Every other
> durable-storage-failure path in these functions calls
> commit_reset_write_verifier() before returning an error.
> 
> The missing rotation means clients holding UNSTABLE write data under the
> current verifier will COMMIT, receive the unchanged verifier back, and
> conclude their data is durable — silently dropping data that failed
> writeback. This violates the UNSTABLE+COMMIT durability contract
> (RFC 1813 §3.3.7, RFC 8881 §18.32).
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: reset write verifier on deferred writeback errors
      commit: f8cf3c1c418ef04947bc16e4a2ef8074452de593

--
Chuck Lever <chuck.lever@oracle.com>

