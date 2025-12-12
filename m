Return-Path: <linux-nfs+bounces-17048-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 270A0CB78B2
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Dec 2025 02:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF42D300CA15
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Dec 2025 01:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9762BCF5;
	Fri, 12 Dec 2025 01:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtiWce6Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261BA10F1
	for <linux-nfs@vger.kernel.org>; Fri, 12 Dec 2025 01:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765503120; cv=none; b=lgubWhljwHPwDoiTChnwwlQQdY+qsNNXgqWua1u9lUcu2aSPCL+qoB8gds6PY0mqY8aqXL/SllRI48GDdmpf5cDTXTE36nMWwrLtch1AROyaC8amvPs1XBTG+LBQAPmQjcD28SYPmuVJXAO/UJgfopYXVou7121FaeOyM9mBZQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765503120; c=relaxed/simple;
	bh=rzoQvfRF+roMTLHPVJ7Mni8ScTALXXRVbUSYZlJNeEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ek1nnbrHIra586nDVr1FtFXYvQd/tzgd+/a0/P1XPtRnMsJPbIGbIy93hCRAUDfER5C4Gw//lMQucMLRUM+HWubBwy9njJRVhLAmjoqcnBpHkpsO0BL6HvQvpw+Rd6Jplv9i29N8K7m5X2OBqN6gy2aLPs72rdI6XgsmTB6o/UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtiWce6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF78C4CEF7;
	Fri, 12 Dec 2025 01:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765503119;
	bh=rzoQvfRF+roMTLHPVJ7Mni8ScTALXXRVbUSYZlJNeEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OtiWce6YOWupjktb5ovXHg00KUyNdEKnTBZgwdoo6SZgLFvrYkbFyE7PqpVeuKxYN
	 7mbqeNEh3D5FqelKWPmkHw8htkoXrBNO0adT5KB+2Su3fpRc4I+5BmcMUvvKyyKAke
	 p5gB/PnYq5SiBqWsjku1yXgq97COfh8oCNyf5ioqU6zvJ41sngcgnyehwnHOD1meG5
	 bnan4FDmCNrMF5xUmfvIHmhTTh2AM76ZxtyGkykMGJRvBBV/pElIjGVJiw4B9VY+mv
	 FGSO9wAsrDx81CjUsZXO8mljBje+7oA94x5EQTHZZSnG610/b4406bCZWBdfLtTzaf
	 c5mwx7Vi9T3HA==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Scott Mayhew <smayhew@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSD: Fix permission check for read access to executable-only files
Date: Thu, 11 Dec 2025 20:31:55 -0500
Message-ID: <176550310799.517876.17801339647981040619.b4-ty@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251211123434.3261028-1-smayhew@redhat.com>
References: <20251211123434.3261028-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 11 Dec 2025 07:34:34 -0500, Scott Mayhew wrote:
> Commit abc02e5602f7 added NFSD_MAY_OWNER_OVERRIDE to the access flags
> passed from nfsd4_layoutget() to fh_verify().  This causes LAYOUTGET
> to fail for executable-only files, and causes xfstests generic/126 to
> fail on pNFS SCSI.
> 
> To allow read access to executable-only files, what we really want is:
> 1. The "permissions" portion of the access flags (the lower 6 bits)
>    must be exactly NFSD_MAY_READ
> 2. The "hints" portion of the access flags (the upper 26 bits) can
>    contain any combination of NFSD_MAY_OWNER_OVERRIDE and
>    NFSD_MAY_READ_IF_EXEC
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] NFSD: Fix permission check for read access to executable-only files
      commit: 2341758268d9bdc099c48fde624fee6d3754bb84

--
Chuck Lever


