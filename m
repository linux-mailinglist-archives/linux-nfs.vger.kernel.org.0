Return-Path: <linux-nfs+bounces-17615-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F18DD03690
	for <lists+linux-nfs@lfdr.de>; Thu, 08 Jan 2026 15:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90ACE30096AC
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jan 2026 14:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7DC50C7F4;
	Thu,  8 Jan 2026 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTPb9rS7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A98350C7D0
	for <linux-nfs@vger.kernel.org>; Thu,  8 Jan 2026 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767882908; cv=none; b=tYL2Kn/WVIbsoyBuNeunaC8Os1Sb+fFdqcr5PbwYOBr5f7ZDZ7W29cknj8yAo+8mRA61quLi32F0QFZ/772Ny/RIC5dMOUBqiMDy2JK0kyYLY8k9AZbEvRbaHEO8Vm5xGZP0L0r08vnblL6jG44wMBZZEjuuhwhBEWaQrsBKfEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767882908; c=relaxed/simple;
	bh=abMcm/dNxY5HihP3SZyeuqlFkuEFYlwrZH5/7C9RRwk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HlSki8KuNz+hXnU8taON3KBqCFYbpphUrynsmt6tCP+80azFR6JHmyvtcy3YD+JlSNmW6Yxb5uLJwyI7yJZD7Y+PkbuxEYGJu2d9sJaIhMlzE8hOLHkY03Q3u+70VIfIUAvY4OaSBLepMdfVIvjtcS89oBNalCaI71Ll8UqyuTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTPb9rS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41552C16AAE;
	Thu,  8 Jan 2026 14:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767882906;
	bh=abMcm/dNxY5HihP3SZyeuqlFkuEFYlwrZH5/7C9RRwk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=sTPb9rS7WBQpV46aXYpt81TtyOV2DpO7wRsysJ1q94a/hyqaxZcsFUTNqG5PFDmei
	 Kf5vrsoPz58FO8vMjFv9cXQBIYISeazy2RdK9HRvusgWGbRrB/plS+4QfeJAqv+876
	 NLt8NJw2Wgm6dM6V8FJ/02aUJfHd9+N+Gjo1qXA6QdIT5EWQxo/x76X3cT0PYebIfO
	 eW4vdUJ3lguuN9G0ueqc21P0FwSluook4o5M4X+NydJ0lgE6mpmuAIpwn8L+bo9FUG
	 jJj0fIDvm0M7C3RAXV3YV4Lakt/O3z2a4pNoeyZaeshVBJb3CiYsR7UoBWG6+IkoVK
	 MEeyJTyxlhzNQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3A617F40068;
	Thu,  8 Jan 2026 09:35:05 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 08 Jan 2026 09:35:05 -0500
X-ME-Sender: <xms:mcBfaVtonAwOehFq88I0Tfa2kraJuyzalhwBmoTemzSwWzy_1ZQvYg>
    <xme:mcBfaZQEzd1sytFtKlcO79RHaXMYRCASUk82PhiFEq84jZexRn7A-LFLMDDunaGF-
    w_z3jkNiOtxmz_kebhIqBEW68gj_SBgUW6zUnVF-65QmJrXSsS5VHE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeivddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepshgrghhisehgrhhimhgsvghrghdrmhgvpdhrtghpthhtoheprghnnhgrsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopehlihhnuhigqdhnfhhsse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mcBfaZRKeNamUTYw3vX-NtFQ1sRyOjbHlarEVA88XGg4EoKe8H2nVQ>
    <xmx:mcBfaf51vrHkvGxKxQuGi0nSOQWMHCRnLs02gBovubb3X4yJQG35Pg>
    <xmx:mcBfad3KPtpPHrDlbYsMXb69iMqGt5HtzDsLsaXAOhZJtyErcpGVgw>
    <xmx:mcBfaSA29FZd4reksmMwZ_3M127Tl0k3Bl9ynbubst2eIIh_zkQzGQ>
    <xmx:mcBfaQMNjQvuyZN-PQdKm_MHX3ANPLiNDs8tdDgS64Vjy4Db_SsL95re>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1C534780054; Thu,  8 Jan 2026 09:35:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ASCMS0S-oO03
Date: Thu, 08 Jan 2026 09:34:28 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Sagi Grimberg" <sagi@grimberg.me>, "Christoph Hellwig" <hch@lst.de>
Cc: "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, linux-nfs@vger.kernel.org
Message-Id: <45ba87f3-2322-424b-95b1-9129a2537545@app.fastmail.com>
In-Reply-To: <ea31c230-1ace-4721-872e-2313b497214f@grimberg.me>
References: <20260107072720.1744129-1-hch@lst.de>
 <0b0b21c1-0bfd-4e2e-9deb-f368a66f5e9c@app.fastmail.com>
 <20260107162202.GA23066@lst.de>
 <ea31c230-1ace-4721-872e-2313b497214f@grimberg.me>
Subject: Re: add a LRU for delegations
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Jan 7, 2026, at 2:22 PM, Sagi Grimberg wrote:
> And, in general, I think that the server is in a much better position 
> to solicit preemptive delegation recalls as opposed
> to the client voluntarily return delegations when crossing a somewhat 
> arbitrary delegation_watermark.

The server and client have orthogonal interests here, IMO.

The server is concerned with resource utilization -- memory consumed,
slots in tables, and so on -- that other active clients might benefit
from having freed. The server doesn't really care which delegations
are returned.

A client wants to keep delegation state that applications are using,
and it knows best which ones those are. It can identify specific
delegations that are not being actively used and return those.


-- 
Chuck Lever

