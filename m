Return-Path: <linux-nfs+bounces-20983-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKrAOoBn52ld7wEAu9opvQ
	(envelope-from <linux-nfs+bounces-20983-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 14:03:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 687B243A689
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 14:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6526030555C6
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 12:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB478382F19;
	Tue, 21 Apr 2026 12:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkFY9759"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893A13451C8;
	Tue, 21 Apr 2026 12:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776772816; cv=none; b=qSa6ulipueEp2CWcQVzW9JWTZSF9Mac1e3P5Gp6lgbht+W8NF+UvY3m41uD/Fj3TdHEkcJhyXcAljBfQ3iKia2v22IriDHlih3seF9cNnLdTltO0L6VSynt/hBScfkgEFE2aEsNlfNPDQCtz31W8Q/Kg4+Hzo3GJ0+k9GrBLXE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776772816; c=relaxed/simple;
	bh=rvTZOGrgOnJwvVLFR1SKkX8PAeXFBe3lTVdvMYttPWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxeKjiDN7o/E2tLf4I2gKfxWS81CEXN4cUUCVFruGIQRVY+iZ8CfhoKFSZCow/EeSr7QaLuITCnnqHaGwm77F9CkvY8ZRoIKsBU6K8aaiGX47mzq06QDy6Gfd0LKjvcjpkT+29sBO5r1NrpXv//+RTPEEvWbB5/J19kvgefswTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkFY9759; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FC3C2BCB0;
	Tue, 21 Apr 2026 12:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776772816;
	bh=rvTZOGrgOnJwvVLFR1SKkX8PAeXFBe3lTVdvMYttPWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KkFY9759Ha/ehKq3RQrycGG/vz1fmypzVZHSrSssD4pb2YRUnTLm4cS8H4IVRZe2h
	 RA4mTkygPaFaCJvGV0rqnFSH4WBrH6BJdfQehxWj8sSp+eamF+Ra3O8V9eEY4Nvs5o
	 ntIGiJ/rnAku+wORCq5eRFEQxmQIfjG3vKdU7wVtRsQJEjSX+w8FzwRs02Gihu6ngb
	 g1/ELhjtV9dfP1ZmEJ1xS9obT3YCTsZDCPTZbsQ/CRS4cBAB00ClcRfQJ6+zLeAx2Q
	 Vepy8wtY8Imgx82wi8XaraosQh0L6DK9tOqb1/8N1b9O323LDYAvb5ubKmNRXdGDwx
	 Hogrh9qvNa8ow==
Date: Tue, 21 Apr 2026 14:00:11 +0200
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v9 0/9] Automatic NFSv4 state revocation on filesystem
 unmount
Message-ID: <20260421-aufpassen-erfuhren-93a4238cb71b@brauner>
References: <20260419-umount-kills-nfsv4-state-v9-0-0660bd06d2b6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260419-umount-kills-nfsv4-state-v9-0-0660bd06d2b6@oracle.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20983-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 687B243A689
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 19, 2026 at 02:52:58PM -0400, Chuck Lever wrote:
> When an NFS server exports a filesystem and clients hold NFSv4
> state (opens, locks, delegations), unmounting the underlying
> filesystem fails with EBUSY. The /proc/fs/nfsd/unlock_ip and
> /proc/fs/nfsd/unlock_fs procfs interfaces handle this, but have
> no netlink equivalents, and unlock_fs operates at whole-superblock
> granularity.
> 
> This series adds three new NFSD netlink commands, each with its own
> attribute set:
> 
>  - NFSD_CMD_UNLOCK_IP releases NLM locks held by a client IP
>    address. Netlink equivalent of write_unlock_ip.
> 
>  - NFSD_CMD_UNLOCK_FILESYSTEM revokes all NFS state on a
>    superblock. Netlink equivalent of write_unlock_fs.
> 
>  - NFSD_CMD_UNLOCK_EXPORT revokes NFSv4 state acquired through
>    exports of a specific path, regardless of client.
> 
> UNLOCK_FILESYSTEM and UNLOCK_EXPORT serve different intents.
> UNLOCK_FILESYSTEM means "unmounting /data, release everything
> on this superblock." UNLOCK_EXPORT means "no clients remain for
> /data/projectA, release only the state acquired through exports
> of that path." Userspace (exportfs -u) sends UNLOCK_EXPORT after
> removing the last client for a given path, enabling the underlying
> filesystem to be unmounted.
> 
> The path-only design for UNLOCK_EXPORT avoids the auth_domain
> naming complexity (use_ipaddr vs hostname-based domains) by not
> requiring the caller to identify a specific client. Since this
> mechanism is to be used to enable umount, this seemed like a
> reasonable compromise.

Thanks for moving this into nfsd itself. That's great to see.

