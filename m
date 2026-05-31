Return-Path: <linux-nfs+bounces-22136-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GXSIsxZHGq7NAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22136-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 17:54:52 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 080B5617093
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 17:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06903300B841
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 15:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E67390985;
	Sun, 31 May 2026 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7FL3y1I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B96390CAA
	for <linux-nfs@vger.kernel.org>; Sun, 31 May 2026 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780242890; cv=none; b=FRSirCcZMXaaUlv4Ax5MzudDKtMTp3NM84gn4boBOUVWtiuG8+fVWps2qobDd5qKrEHc0kq3qWy2eiG6EK5SOpTiMlAR15yA0UwpZEZru6iPAr4sYTsA2PAdiwTdDrtXH+/FccRjDp/t/AippxX9fXtkIzuekfwwXjbPTe6OUd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780242890; c=relaxed/simple;
	bh=3i77uw0APEAMrftupDxLB6Ho0ELBcxUOB/DsANNtQ7g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=r3WwnKeogKYnDvldTGmkTjAcsOUyDbLK9lj2e0rkHUwWhBw+5nLbM6E7XG5fvZZHZGB/Y/r2J6W755fBYdAuYOoauxPNXVW6JsMRC7pav5zPUl72tlaeTZzdANzYqyDVTdA7JyRnfm3hOR31jtKWhHbHKibkgr8JFoLgleTki/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7FL3y1I; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900771F00893;
	Sun, 31 May 2026 15:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780242888;
	bh=Tml65+TtYuBcIk7PFLN7B44qInGbVoSdDpEo3PWbrtY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=n7FL3y1IFtkObqJGJkTLft8041aGHEorbwCzgONcF2lrpVypAwcjCQ7NL24BGgTUw
	 si/j5IZ34g8SIH0uBpp7YuoMy9HxF8jFIN1Cc2iMtWWqrduWS6BDrdeDRJVjLbSRYl
	 P3Jgbh/BPp30pmPtZTq7a4Uvoysg0pIZ2WiJeCfjBtDizlNpDmrdZ9CcVL1Mv6y5zx
	 uJqmQCGcst3InEKjvLKSM2HvYFdHyvFdXJpvDIxIAJ2XR7PSMl1slrmTFfjBXBkc3c
	 ytJEZA6o5QnwbVsGr7evqBRbBFNXiWAn/EaQMJYRhHHAeenrLYAyGRG9bpittmDaXQ
	 B7p8aihSSjIfw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 94FB7F40078;
	Sun, 31 May 2026 11:54:47 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sun, 31 May 2026 11:54:47 -0400
X-ME-Sender: <xms:x1kcagRP8pHs8_El4LzoYa0KhpcjLv0cuhBOl58k81cAeduhfWDmvQ>
    <xme:x1kcaokQaAKCYIwKjsoynfwFAOTCPEb87_ZS3DK9JF6gSQ4j5FGPMCsETTjlKmVa3
    ZHFRZCoYiZ26wHQjOHCQxSx8w_ynhhV-OkZP7jXDhifNCHDLi0nbWc>
X-ME-Proxy-Cause: dmFkZTFlhM5QdPgHincvFecyt9e49MnJ8qywG4rnJ9Lb61qIA98dwnSxYPS/AzgcRYySon
    C6c9onvVJ2efkHvx91b5rO9buH8Hn2tdElIBuyKj5Z29CL0PckJSZ28nto6NV47lrcR0cw
    JEryGlQE/oiD9N1bULUaGyrFjK2Txo8YA2TZJCf5hZU5e76x/9OOZh3vU5QknURL/TFJtG
    LPOqCMbo/vhsd0AcR8eZxLg9ZFHuKXOvfZ3v15QQvqPHwBDuV/A+d0YuI78oYOw8YIgoqM
    GLroDkZ49pVqubyKCPT2Ny7s4kBhgFIi8oOISN+J1SS5kyGCk630fqkeflEiuqPbN6p+BO
    SIeNoyUvyU1XfoZDyJfKvbkUsPK3LuvjUQKzj3jSvFivk46GryJtz1j6pPIM3CYlq49m18
    sPLpsISu1GsLSzd4KlEauKjQYUdWpfW1jn8T5/aiTM0jnPxPkupKJT1MOG+AV8yonnGBr1
    A9haNaKWZ4DLUwlQK+bSwZYVd13yixkydFG+TyKF/Do1lwpyPY192M7wOJOwxyR8mTQVVd
    iZUchieITiW2EehV2qAKRdWvM3OiPs2f9zU5I7OSdHnaTEMtcymwSwVSZFxE9JXGiNmZou
    jejjQyq+gWteEtPSamJ3TPPHW1t4g3Gn4rXYXa89i0JAq5xsoRaDfLJOXgJw
X-ME-Proxy: <xmx:x1kcaqhwf_vRrllHn0PCL-CRlSGhD8pA6VCgKWyeVczHWpQKIXm-Bg>
    <xmx:x1kcalHyQ7iDqkzyNDNm522ys-wgwum8gT23xNDRWB-P3D17PEVvuA>
    <xmx:x1kcanA--S6u2ZVIxfrrSNqwGJAyAUqhyYUAoiMsFs-lOxQk816zmQ>
    <xmx:x1kcarAYZhc3DSMttmW_i534AJEnIKBY5HL8h25_clCwihnfJfg0ng>
    <xmx:x1kcalOWrLD9WCHPUPoMI7plQL-Mk8zhdQCkXhjnJfJBhWcrgFMFjmwZ>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6E6D2780075; Sun, 31 May 2026 11:54:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AML-SSCfR-qs
Date: Sun, 31 May 2026 11:54:26 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "David Howells" <dhowells@redhat.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Rick Macklem" <rmacklem@uoguelph.ca>, "Chris Mason" <clm@meta.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <c2b22954-9f78-4ce0-abfd-e86a5bfac0b4@app.fastmail.com>
In-Reply-To: <20260531-nfsd-testing-v1-5-7bfa481b0540@kernel.org>
References: <20260531-nfsd-testing-v1-0-7bfa481b0540@kernel.org>
 <20260531-nfsd-testing-v1-5-7bfa481b0540@kernel.org>
Subject: Re: [PATCH 5/6] nfsd: release OPEN-decoded posix ACLs via op_release
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22136-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 080B5617093
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Sun, May 31, 2026, at 8:07 AM, Jeff Layton wrote:
> From: Chris Mason <clm@meta.com>

> Remove the matching posix_acl_release() pair from nfsd4_open()'s
> out_err: label: the compound dispatcher calls op_release
> unconditionally after every op, [...]

The double-free fix is right, but op_release is not called
unconditionally after every op, and that gap leaks the ACLs on the
v4.0 replay path.

op_release runs only at the release: label inside
nfsd4_encode_operation().  The compound loop skips that encoder on
a replay:

        if (op->status == nfserr_replay_me) {
                nfsd4_encode_replay(resp->xdr, op);     /* no op_release */
                ...
        } else {
                nfsd4_encode_operation(resp, op);       /* op_release here */
        }

So every ACL-bearing v4.0 OPEN retransmit leaks two posix_acl refs.

Please release op->u on the replay branch too:

        if (op->status == nfserr_replay_me) {
                op->replay = &cstate->replay_owner->so_replay;
                nfsd4_encode_replay(resp->xdr, op);
                status = op->status = op->replay->rp_status;
                if (op->opdesc->op_release)
                        op->opdesc->op_release(&op->u);
        }

Let's fix the "unconditionally after every op" wording too.

I've applied the other 5 in this series, so you can just resend
this one.


-- 
Chuck Lever

