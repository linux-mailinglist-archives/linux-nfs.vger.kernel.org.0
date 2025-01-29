Return-Path: <linux-nfs+bounces-9761-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D913A2249B
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 20:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C807818881D1
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 19:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740EC1E2312;
	Wed, 29 Jan 2025 19:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTc1AWNe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7341E0E11
	for <linux-nfs@vger.kernel.org>; Wed, 29 Jan 2025 19:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738179582; cv=none; b=AoThlJ84UdcYfjvdWiXn9eC8W7sg0LwZUFwf2C7P28RTY+RSk5WKghzv1/ok9dZ+YC9QZwT9fNokCAhlFlJFNwrhcygQEmhy38mdVG1jSRdFEgL8SXGhvmkw60kQJF30gQkGnHpGD3PlvDg3QJE4lS+0VhsS10QHb8YCgbm+7/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738179582; c=relaxed/simple;
	bh=M4Xchd9/yVAlsmibSuM3hxJASedep+TGo0GofqZfmYA=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=TWJAd486/eDhUnwAtT3yUNIZEHp0nMYegLp1LDEpgtxvg8NsesJ6CFSeZm+vqAf/9iRDGPQ3euS2wFyyJA3xFoLIjTMF21fhDWTBZQii7jZC8oD5G2NwfNTopv8oOe9nXp+Ss+88zr0Vep/Br6QGDHQECdtmwT3DbH+IttU3qOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTc1AWNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC05C4CED1;
	Wed, 29 Jan 2025 19:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738179581;
	bh=M4Xchd9/yVAlsmibSuM3hxJASedep+TGo0GofqZfmYA=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=eTc1AWNeEpQuIIKttaHc+Yp5ssnw8cfqGQPtSwK298nH6oR63nUjCiqY+69xI/UDN
	 he1hGciU4wCUiOdX5umxVuBAsyJuPd/5C3v4QnspjdBm21WaZs6y1IzkF5ECyBYfD0
	 XUuc/oNyKQX+B/+SV/f4jB0tYytwjKR8k9Z3368RGp8LmWZBGO5B7W8z1j029fnHF7
	 raLb1bgnKkKS1XQYvwHElxWFLUqMLoHTQeNQHfo1W1U9h5ofVlsWU3Vwlfww2ZKceZ
	 GBTHKst3qytlnVLWtQIu9FULVbCq4q5dHk1aX7+338Lf/icF1DNUYIkBJqutw0P8Mq
	 XeNV1u6lLS/sA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5326380AA66;
	Wed, 29 Jan 2025 19:40:08 +0000 (UTC)
From: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 29 Jan 2025 19:40:29 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: herzog@phys.ethz.ch, trondmy@kernel.org, linux-nfs@vger.kernel.org, 
 jlayton@kernel.org, tom@talpey.com, baptiste.pellegrin@ac-grenoble.fr, 
 chuck.lever@oracle.com, anna@kernel.org, benoit.gschwind@minesparis.psl.eu, 
 carnil@debian.org, harald.dunkel@aixigo.com, cel@kernel.org
Message-ID: <20250129-b219710c25-59fffd877fe9@bugzilla.kernel.org>
In-Reply-To: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
References: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
Subject: Re: NFSD threads hang when destroying a session or client ID
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chuck Lever writes via Kernel.org Bugzilla:

> [Wed Jan 29 10:11:17 2025] cb_status=-521 tk_status=-10036

-521 = -EBADHANDLE (NFS4ERR_BADHANDLE)

-10036 = -NFS4ERR_BAD_XDR

I see several similar events in the trace.dat report. My guess is the client is generating BADHANDLE (nfs4_callback_getattr) but the server is having some trouble decoding that result.

My first impression is that XDR result decoders are supposed to return -EIO in this case. NFS4ERR_BAD_XDR is supposed to mean the /remote side/ was not able to decode a Call, not the local side couldn't decode the Reply.

RFC 8881 Section 20.1.3 states:

"If the filehandle specified is not one for which the client holds an OPEN_DELEGATE_WRITE delegation, an NFS4ERR_BADHANDLE error is returned."

This appears to be a bug in the new CB_GETATTR implementation. It might or might not cause the callback workqueue to stall, but it should probably be filed as a separate bug.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219710#c25
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


