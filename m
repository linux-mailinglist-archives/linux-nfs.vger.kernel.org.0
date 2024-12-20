Return-Path: <linux-nfs+bounces-8684-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1366A9F945F
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2024 15:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28BAC7A4456
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2024 14:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91745204567;
	Fri, 20 Dec 2024 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEt8m+xh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBE48632B
	for <linux-nfs@vger.kernel.org>; Fri, 20 Dec 2024 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734705128; cv=none; b=dYd3NSsNemaE/SraYlBmS+i/m1YKgfwKMSyxZrHaNK0vc2ufOAkajqrpbv+/nJalm2S7Xo9fW2w58T1D6QfjxolyLA3fGVXD3G14hq5IUBFS5YByk+ri4roRrBeN04E19nyy0RYYQKNSq4Agsv5ej60cu5d8YYBXT4A4tPyqVQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734705128; c=relaxed/simple;
	bh=FIzcA/NzCUMS4ALB0dVKj4BHn1kngqzm1nJWgEqTObU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rSBUb6lWVLtmhPbvjjCkyHs+Wz8ZfTV5QemvC0Zy3bUdrHOytubYO7wG3XIc0BcUBqIwJ2PBzxp3xWpXzSYv/t7Acv7BG3rrOfVCINQHZKEfMqNPt2mfrhPL+sCqbq0cRSVeu3Wb6aqcg3IO8i/tdPBYWAxnLzHG807EzzxNE68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEt8m+xh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F87DC4CECD;
	Fri, 20 Dec 2024 14:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734705128;
	bh=FIzcA/NzCUMS4ALB0dVKj4BHn1kngqzm1nJWgEqTObU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XEt8m+xhid1BySS4r+PJAZme+9i9Iahgn6fHph79XeYT6iKpNq/91VVC8/V0yGogP
	 u+/sdhdm//CFqHhQ7eb5CmmlOKANkxIxCTtiyHEchkjtd5Rp6a3VJHVpElHOSF2Ync
	 aNzy1mq/Q49mhTH3EH6tz77EOScbPYf1n9u5M8gz1O2QhzjaiERDl/ggfdsjDuQQWT
	 k0EbmkMnAF3hwtIZvrTufA7WzNvZ/5+bLEsexw1+CdWxoepFkFQe4QJYMLHOWO436q
	 fuQtZyZYGVhTeD5RdHVumFryPvkpGuZ+zduPA2U6a+pr8uMRA7XoNhiRPWuhvbLEY0
	 GsVv5CNt7CyLw==
From: cel@kernel.org
To: jlayton@kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSD: fix decoding in nfs4_xdr_dec_cb_getattr
Date: Fri, 20 Dec 2024 09:32:02 -0500
Message-ID: <173470507264.15853.16466315783871500115.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241219201204.10367-1-okorniev@redhat.com>
References: <20241219201204.10367-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 19 Dec 2024 15:12:04 -0500, Olga Kornievskaia wrote:
> If a client were to send an error to a CB_GETATTR call, the code
> erronously continues to try decode past the error code. It ends
> up returning BAD_XDR error to the rpc layer and then in turn
> trigger a WARN_ONCE in nfsd4_cb_done() function.
> 
> 

Applied to nfsd-testing for v6.14, thanks!

[1/1] NFSD: fix decoding in nfs4_xdr_dec_cb_getattr
      commit: 06f2bda29525f103e83cbb8a306774d508c7801d

--
Chuck Lever


