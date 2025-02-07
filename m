Return-Path: <linux-nfs+bounces-9938-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B13EA2C4A5
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 15:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 002F27A1F6A
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 14:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B3A1FCF72;
	Fri,  7 Feb 2025 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fieldses.org header.i=@fieldses.org header.b="am9iFQxZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from poldevia.fieldses.org (poldevia.fieldses.org [172.234.196.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFB11F7914;
	Fri,  7 Feb 2025 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.234.196.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738937249; cv=none; b=jffh7vGq9Tgviza0rEnPq9iVgZzlHcIwTXRX2e+/O+Pnw3ZdDbyXISGz47Iv9+J+3W5YLIHSVjO0B1nJth3nWGv4fg8bnI33jrQc/g/LxGCbjJj7JMntifNbMMJRqRl5FS2XXtAZXMSas8C0Z7fMwsCaHOC42FI9ga8Uml2TWWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738937249; c=relaxed/simple;
	bh=+IAAGwClnERFLDactmwuM/xrTWIyOyX4Kev7UB83HsI=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=kPZvGiOjBVwghca4rnpINMfO4mlnV19TzfLwi83iFGWStKgFzWt+tQkoaDQ2MvXSdipA514FRIlY8Ylmq2R1RB+QMWSLguDk2G7ViwJM+vAQ8SzWsoPUYhWXn4B9hzXRG8KD6L+igxvrB6MP13VZ7a9irOrW3aeXKuUWktqVos4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fieldses.org; spf=pass smtp.mailfrom=fieldses.org; dkim=pass (1024-bit key) header.d=fieldses.org header.i=@fieldses.org header.b=am9iFQxZ; arc=none smtp.client-ip=172.234.196.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fieldses.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fieldses.org
Received: by poldevia.fieldses.org (Postfix, from userid 2815)
	id A409DFA10E; Fri, 07 Feb 2025 08:58:50 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 poldevia.fieldses.org A409DFA10E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
	s=default; t=1738936730;
	bh=TpGFHD+NJwxSsEEuezuighN82YN15D/friuYOSoEx3g=;
	h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
	b=am9iFQxZKKQwKjjOxJYpesovzG8lB5I8UTr25cTWDZ25z5Ygwn0sFfzwLzyXQV+mJ
	 /ym9ni/20U+xAW3eOWbjMiDORehI7e70+ir4Awt3zuOTLvWP3wpy5VSu48bP+6eZrD
	 ntDdfFRtTjAjCC8cvbteHf2MiNLxdFsOcaL2g3ik=
Date: Fri, 7 Feb 2025 08:58:50 -0500
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] nfsd: CB_SEQUENCE error handling fixes and
 cleanups
Message-ID: <Z6YRmqBSZLbfvowi@poldevia.fieldses.org>
References: <20250207-nfsd-6-14-v4-0-1aa42c407265@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-nfsd-6-14-v4-0-1aa42c407265@kernel.org>
From: "J. Bruce Fields" <bfields@fieldses.org>

On Fri, Feb 07, 2025 at 08:45:02AM -0500, Jeff Layton wrote:
> I think this rework makes sense, and I've run these against pynfs,
> fstests, and nfstest, but I'm not sure how well that stresses the
> backchannel error handling.

Very little to none at all, unfortunately, I'd guess.

pynfs/nfs4.1/server41tests/st_trunking.py had some ideas for some simple
tests, maybe that'd be one starting point.  Or maybe
server41tests/st_delegation.py

--b.

> I'd like to put this into linux-next for now
> and see if any problems arise.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Changes in v4:
> - Hold back on session refcounting changes for now and just send CB_SEQUENCE
>   error handling rework.
> - Link to v3: https://lore.kernel.org/r/20250129-nfsd-6-14-v3-0-506e71e39e6b@kernel.org
> 
> Changes in v3:
> - rename cb_session_changed to nfsd4_cb_session_changed
> - rename restart_callback to requeue_callback, and rename need_restart:
>   label to requeue:
> - don't increment seq_nr on -ESERVERFAULT
> - comment cleanups
> - drop client-side rpc patch (will send separately)
> - Link to v2: https://lore.kernel.org/r/20250129-nfsd-6-14-v2-0-2700c92f3e44@kernel.org
> 
> Changes in v2:
> - make nfsd4_session be RCU-freed
> - change code to keep reference to session over callback RPCs
> - rework error handling in nfsd4_cb_sequence_done()
> - move NFSv4.0 handling out of nfsd4_cb_sequence_done()
> - Link to v1: https://lore.kernel.org/r/20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org
> 
> ---
> Jeff Layton (2):
>       nfsd: overhaul CB_SEQUENCE error handling
>       nfsd: lift NFSv4.0 handling out of nfsd4_cb_sequence_done()
> 
>  fs/nfsd/nfs4callback.c | 107 ++++++++++++++++++++++++++++++-------------------
>  1 file changed, 66 insertions(+), 41 deletions(-)
> ---
> base-commit: 50934b1a613cabba2b917879c3e722882b72f628
> change-id: 20250123-nfsd-6-14-b0797e385dc0
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>

