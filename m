Return-Path: <linux-nfs+bounces-14370-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E96E9B54FF3
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 15:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D56BAA425E
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 13:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43DC30EF66;
	Fri, 12 Sep 2025 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mydcm8A5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DBE30E853;
	Fri, 12 Sep 2025 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684777; cv=none; b=PcPcl2by++iZ8xNKoHOVNGQMlgwOG/5pJZvGtt+T7gLmOtf2n+1sqp94Cw5h3tuyGMJZmgrsC+AyTvWzzCOL2mlI9c/858i/VMmEb0KQnGi0tJlY0xYoxu8PQgdiCRTBaIA2YA6TY+EWETpFoxiI5qPN0MgV08oOSQ0KqO5Nwl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684777; c=relaxed/simple;
	bh=rTdvXJrWf1/sP0O0JGJx/3Yq05P0d8MUTVIMGaUepwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3W7lY7PwRRfb3qoBxvrmv++fOFMDj0f7G4aMlQJHLZTj495hSrvAJThAnvlJ8b/1m79jRwAt3BnRar2/HDUE8QM/7FxOM0ctUZcXZ+l03eVRe4W1stV0CH4x4j7DHvPfUfNFpNhYP5nn++0t8B+ZugqiP6rU2ebmHoViyle9YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mydcm8A5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DADC4CEF1;
	Fri, 12 Sep 2025 13:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757684777;
	bh=rTdvXJrWf1/sP0O0JGJx/3Yq05P0d8MUTVIMGaUepwA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Mydcm8A5pkOpw34pO6Kns6DY4twdOXIE+38U00xWGjgJTK0mBVWiSkCGyY9s8FlM/
	 xDmtU66VCo0ydJPhwMn3JgkHgQHYCUla2Rxi4kGDNXIibFbul+Gqjl8RIDhKVotcWS
	 d7rsGKzk547WdQ2YC0ylDh7IWQMAc91lqa2hkSKhra/SWBPbRIVlsE2iYAURMdYzmv
	 xPV8s093pckV7jasCCrN+GWtbabVSdA1KPVAV2qTyTFMZpnLXu11tZ1pHc8Irwlxzy
	 6GpJbmag+7hg4qzsxRxwGqyl6IMdtFdP1J4SJ7SvdXCwpoPRRNEYEHKs5jbYgyBrYK
	 OjzMPRO3XCAvw==
Message-ID: <52be6bdc-81cb-441d-8266-9fb5bb5b4b23@kernel.org>
Date: Fri, 12 Sep 2025 09:46:16 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3] svcrdma: Introduce Receive buffer arenas
To: Olga Kornievskaia <aglo@umich.edu>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20250821152254.8781-1-cel@kernel.org>
 <CAN-5tyHxtn=KjR-A3jDU-3Y2B8w2S2pqus7McerCZVpaEG4hcA@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <CAN-5tyHxtn=KjR-A3jDU-3Y2B8w2S2pqus7McerCZVpaEG4hcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/25 5:33 PM, Olga Kornievskaia wrote:
> When I have this patch it causes the following panic just from doing
> "systemctl start nfs-server" followed by
> "systemctl stop nfs-server"
> 
> [   69.705986] Unable to handle kernel paging request at virtual
> address dfff800000000001
> [   69.706706] KASAN: null-ptr-deref in range
> [0x0000000000000008-0x000000000000000f]
> [   69.707299] Mem abort info:
> [   69.707514]   ESR = 0x0000000096000005
> [   69.707787]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   69.708186]   SET = 0, FnV = 0
> [   69.708415]   EA = 0, S1PTW = 0
> [   69.708637]   FSC = 0x05: level 1 translation fault
> [   69.708986] Data abort info:
> [   69.709203]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
> [   69.709604]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [   69.709986]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [   69.710345] [dfff800000000001] address between user and kernel address ranges
> [   69.710842] Internal error: Oops: 0000000096000005 [#1]  SMP

Yep, I've hit this. I'm dropping the patch from nfsd-testing until
the issue is addressed. Thanks for the report.


-- 
Chuck Lever

