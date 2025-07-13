Return-Path: <linux-nfs+bounces-13006-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 313A1B02E44
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Jul 2025 02:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CDA0189D3EE
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Jul 2025 00:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3AE5680;
	Sun, 13 Jul 2025 00:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AX4YgkOo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60704690;
	Sun, 13 Jul 2025 00:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752366595; cv=none; b=ZN578TrEsT01pSEg5yeDV3mrsnMd0TnpwKTuCv7KmserrAS5v4k3c2RjC52W1j1xoLtYjTx+ubiUzccd+aTB5cUO5JaM6l+nZH9XZfcL5VW91fRHjEg0ey6PxtSc8LbBA/AtocI/1HhRJ3LqGZBWG8PuLKphdGTQTN18qmarPTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752366595; c=relaxed/simple;
	bh=locYf12dkmHCspnljLTujhaUmBn3PwvSWAqOEs5zZzU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F9HmWydZsoreQwxA2zycbI/6URAIyReaAAIUNb7x+12IiVg3tWJsOxuU3ksGTQVD4bYarPM7BaZ1oC+bU65KVq6YySHIOReA5OgvJQrEcetvFW30iZGuwy8jDcGSlpmywzLY5o1wxlO4XLaAgKNYg6gDXiPfM/EllDFOG2bzm2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AX4YgkOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BB5C4CEF0;
	Sun, 13 Jul 2025 00:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752366595;
	bh=locYf12dkmHCspnljLTujhaUmBn3PwvSWAqOEs5zZzU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=AX4YgkOos8V5XbTXBNnYyTpqtqvS8phNcY6ek4kPrREeoNporfryiR+UcKxNTJN1H
	 HnIExDSbG0FVy3CKiWCNhRGNUvguXtT6ccruIGtRS/O9Q2S7eTe4M07ytBd5jEKTAz
	 R4dbN1VA1AsTxYysIEy2FAvRnPovQtdZWZoaAS7CFbtkvE4APoWAKnoURBMfKpEWvE
	 iz3WqYU+oxdgyN0afUh0qNankGTmONEzpiv2n897veWrrXLz3nWGP1k6+VB7BAsIZy
	 xEOaffcN37vmU038A1gsUVJwVu5Eqppv6XiAYET3V3nEXE/fdhX4AYhyeGcIRLDTQw
	 WaQScekS7PGhw==
Message-ID: <0211091956f168aa2c26ffa9da83e220b91479b5.camel@kernel.org>
Subject: Re: [PATCH] SUNRPC: Remove unused xdr functions
From: Trond Myklebust <trondmy@kernel.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: chuck.lever@oracle.com, anna@kernel.org, jlayton@kernel.org,
 neil@brown.name, 	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
 linux-nfs@vger.kernel.org, 	netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sat, 12 Jul 2025 17:29:51 -0700
In-Reply-To: <aHL9HY5V95hV_Qau@gallifrey>
References: <20250712233006.403226-1-linux@treblig.org>
	 <1ae3c2fa194bb7708ad5a98b1fb7156b9efcb8e7.camel@kernel.org>
	 <aHL9HY5V95hV_Qau@gallifrey>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-07-13 at 00:26 +0000, Dr. David Alan Gilbert wrote:
>=20
> Any chance you could also look at this old one:
> =C2=A0
> https://nam10.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
kernel.org%2Fall%2F20250218215250.263709-1-linux%40treblig.org%2F&data=3D05=
%7C02%7Ctrondmy%40hammerspace.com%7C9bda97d0c5c34041647e08ddc1a3e7c6%7C0d4f=
ed5c3a7046fe9430ece41741f59e%7C0%7C0%7C638879631926208245%7CUnknown%7CTWFpb=
GZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoi=
TWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DuQu4kGGvj5UPPwy%2FwdWL7gLQRah=
h6DucDGunIOwkvg0%3D&reserved=3D0

Ack...

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

