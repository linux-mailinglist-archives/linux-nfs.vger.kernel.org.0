Return-Path: <linux-nfs+bounces-9736-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7243EA21CDB
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 12:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06A63A0473
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 11:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680651B85E4;
	Wed, 29 Jan 2025 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErGUYESZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9461ABEC1;
	Wed, 29 Jan 2025 11:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738151890; cv=none; b=W6ycqxHGoJqMuN3PWqmbwFvFUve7fJUFA+22qGyiv1DtPqIFSUf2lUaWCF/Phe0vPwiYo4dare/rQXacKXVq8eStQMtkomLRpRjP1Wz5/UVZe8ubLf/GHy3HhwWeWBWpehCTTwUBvn5iL055Eqw+XU6UTjhqEMbLiy8NYf6Qa9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738151890; c=relaxed/simple;
	bh=Ilw00a6G6Ql4ZXBudTfDh5BnWnO+zfJts05SApMQlBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kubt20DRsTrzRmTol+yUIj6G0ZdLfm9ng+LzAS9EC9lV6dxdiElYhirk36vBJEyl4N5bLkuQVtUu5EBiSXrxTrgA6Roy5hl0SHfTDL+NABdcjZKffdSC9tSeV69ss0jZN4V3GtaUl1GsHKLj6DXETiptX9W1izR/RQAqgxF20xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErGUYESZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E07C4CED3;
	Wed, 29 Jan 2025 11:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738151889;
	bh=Ilw00a6G6Ql4ZXBudTfDh5BnWnO+zfJts05SApMQlBY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ErGUYESZj8bTEcD470vW1TI/mTSAbqRkC9zF2daVYS4APguAgSWX8kF4SGSBFc/fd
	 A6be956ADPhHxz8aN9PTR/C7FtcY/coFKk1m0PIN9Vb8euAChPFzgJ+AHvYjRergtu
	 JY+mkqbGjHzLfiBnIxNHXNcHQuRt4y7HCafDuKygdP57MMopJEayFV82eNvBqxn22G
	 SpOaiVeXjGYvUtHEAF6PE9Ij8YocTiLwlkuijxb82bwWLsBlYF+UPMChxZeTRImoOB
	 bXs0R32GozH0i8vb+qSpamc6kN70EmBqHJzISACxT+OapTWzP7iUGtKPKxdRo+m1Af
	 PnzHVcYOhN/lg==
Message-ID: <69612036-8223-4f13-adf4-e247f9dd1f23@kernel.org>
Date: Wed, 29 Jan 2025 12:57:54 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v2 1/8] landlock: Fix non-TCP sockets restriction
Content-Language: en-GB
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: gnoack@google.com, willemdebruijn.kernel@gmail.com, matthieu@buffet.re,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, yusongping@huawei.com,
 artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com,
 MPTCP Linux <mptcp@lists.linux.dev>, linux-nfs@vger.kernel.org,
 Paul Moore <paul@paul-moore.com>
References: <20241017110454.265818-1-ivanov.mikhail1@huawei-partners.com>
 <20241017110454.265818-2-ivanov.mikhail1@huawei-partners.com>
 <49bc2227-d8e1-4233-8bc4-4c2f0a191b7c@kernel.org>
 <20241018.Kahdeik0aaCh@digikod.net>
 <62336067-18c2-3493-d0ec-6dd6a6d3a1b5@huawei-partners.com>
 <20241212.qua0Os3sheev@digikod.net>
 <f480bbea-989d-378a-9493-c2bee412db00@huawei-partners.com>
 <20250124.gaegoo0Ayahn@digikod.net>
 <2f970b00-7648-1865-858a-214c5c6af0c4@huawei-partners.com>
 <20250127.Uph4aiph9jae@digikod.net>
 <d3d589c3-a70b-fc6e-e1bb-d221833dfef5@huawei-partners.com>
 <594263fc-f4e7-43ce-a613-d3f8ebb7f874@kernel.org>
 <f6e72e71-c5ed-8a9c-f33e-f190a47b8c27@huawei-partners.com>
 <2e727df0-c981-4e0c-8d0d-09109cf27d6f@kernel.org>
 <103de503-be0e-2eb2-b6f0-88567d765148@huawei-partners.com>
 <1d1d58b3-2516-4fc8-9f9a-b10604bbe05b@kernel.org>
 <b9823ff1-2f66-3992-b389-b8e631ec03ba@huawei-partners.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <b9823ff1-2f66-3992-b389-b8e631ec03ba@huawei-partners.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/01/2025 12:47, Mikhail Ivanov wrote:
> On 1/29/2025 2:33 PM, Matthieu Baerts wrote:
>> So if TCP is blocked, MPTCP should be blocked as well. (And eventually
>> having the possibility to block only TCP but not MPTCP and the opposite,
>> but that's a different topic: a possible new feature, but not a bug-fix)
>
> What do you mean by the "bug fix"?

I mean that to me, adding the possibility to block one but not the other
might be seen as a new feature. But at the end, that's up to the
Landlocks maintainers to decide! So feel free to ignore this previous
comment :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


