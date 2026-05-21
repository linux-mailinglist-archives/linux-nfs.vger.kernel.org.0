Return-Path: <linux-nfs+bounces-21772-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AM6sKodfD2qXJgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21772-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 21:39:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A5A5AB830
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 21:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3930A302979F
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 19:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA13B3EC2EB;
	Thu, 21 May 2026 19:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfG4sAhf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8371A349CD8;
	Thu, 21 May 2026 19:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779392341; cv=none; b=g62ZrCd8YHAb8MvKyO+BYuO5mcynedFoKUtVbS0Qu2fhOc3naFffg3fqnONu3crmL/tvYfxhmjHJSUn4GHlZxFDyi99KgENKAsnWsSSc4YGONsZBeXiF2lBApC76BQzqpoKRKEKuRcjEBNCeWy+z0biNdNEQBV5gHdjmOnhyp6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779392341; c=relaxed/simple;
	bh=eVWYw6FAG7NuwVLVgELEC4i+QoCqq+GCfJrgPZwDUo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdcGKjC2tUft+HHstSVDkgjV7EFX+0Feh/XJ3ztmCPpqjP+sFBxVQTALOBVzUHiRRDrYZ2Lhoweu0/N2muIR+aE+piLHyRw4ORtm+yMtMWV5iZgJap7C39eigyyOcBKW4LeQ3ik+W0fHiw3GEMESl8jyPcvD+4T7SWaLYtAxrWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfG4sAhf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4281F000E9;
	Thu, 21 May 2026 19:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779392340;
	bh=ytKLbgl1A5gYP/hI37UtiSopO17/MtM3Ek+KNsUhXLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dfG4sAhffp5Y2eFpSzcNRKGjIEYwjiCS1IMHtpzbc+pP6YlgrFjMQP0jOFVsaHsRi
	 U2sdetIUGtl+V4jvtQsK+mpUFDl0lsT5c9KAS4xIDdsIXd6BjE53Z3lVhAuuNhf2Fm
	 uGG1qltcUXoXnWFux50ZCcUeP/vO1fKe6+qPlIHlrLfgpY+XPfybUBOkAXyxi4558C
	 iSm7wU0gXM+udSvQ67VYJiNtDuKPukg9b/N0zcInROZ0ie1JsdOvFgO46BSemLgamA
	 44r/cLeT6/VfulRUwRS0fGAUG4MJVBo71H85McSYUmPk0kYZsfqs/gvYlPJjB5GN4T
	 IcZZJ9RIg0Q+Q==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: fix posix_acl leak on SETACL decode failure
Date: Thu, 21 May 2026 15:38:56 -0400
Message-ID: <177939228457.181423.3822888386168533752.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521-nfsd3_setacl_decode_failure_acl_leak-v1-1-8165ee755b48@kernel.org>
References: <20260521-nfsd3_setacl_decode_failure_acl_leak-v1-1-8165ee755b48@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21772-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Queue-Id: 22A5A5AB830
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 21 May 2026 13:51:43 -0400, Jeff Layton wrote:
> nfsaclsvc_decode_setaclargs() and nfs3svc_decode_setaclargs() each
> call nfs_stream_decode_acl() twice, first for NFS_ACL and then for
> NFS_DFACL.  Each successful call transfers ownership of a freshly
> allocated posix_acl into argp->acl_access or argp->acl_default.  If
> the first call succeeds but the second fails, the decoder returns
> false and argp->acl_access is left dangling.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: fix posix_acl leak on SETACL decode failure
      commit: c5d94697918a13dd9cd5a288f5b3b8dbecd4a783

--
Chuck Lever <chuck.lever@oracle.com>

