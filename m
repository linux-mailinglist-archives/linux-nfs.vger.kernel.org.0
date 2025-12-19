Return-Path: <linux-nfs+bounces-17229-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC357CD017F
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 14:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC5473021E4A
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 13:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D3431E11C;
	Fri, 19 Dec 2025 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wxrmyf/7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52E52FDC30
	for <linux-nfs@vger.kernel.org>; Fri, 19 Dec 2025 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766151675; cv=none; b=ARgopgaA9JnVe2zPzBE/jy0RuOnNKf6YWcRo3Tqb1MM6J14nAX3DUkNskiT4EUin2Zds92hFSavT3/CeLFX9ghwL2fSuqJZFCQozow0OKrrxwP7lemTJytZHbRHYpRXR8lR/78rxWhQvniLWlVkrULykCCr7dz6C0T8r54ddfV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766151675; c=relaxed/simple;
	bh=iH1shNsCKzmxAbvHQ18qMf2mh8y+wLdpJGrOMM6oRk4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Uf4nP9ZpGZKMFyNikQxxr4QlKZ/0DDX+fOGC7BEA1DgoG2LUq/SakcR2eux0LDT7Y5gJ7hIarFidwguLCE4lUGZeOxnmolSGI9g78IfxTOV57ZrAJDeectCywonSX8qIjdARr1NuRMMjlU0LhmgWkSqwR33i1lF49PlcKqAKZAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wxrmyf/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1BEC4CEF1;
	Fri, 19 Dec 2025 13:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766151673;
	bh=iH1shNsCKzmxAbvHQ18qMf2mh8y+wLdpJGrOMM6oRk4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Wxrmyf/71tKJ5s/L+T507IgUaqqDbcPiMm8keZDz4XMCkokfdCabTfJPDZRqnuO2/
	 5WYpmJn7N/gAqCZlxKT8FPLFwPLJWMXp9STWCxYZ/rktqNx3FplZTSak4fo//2icrV
	 eqGZzlqmAC9EjbzuPRK+HLPSw+QrQ9ZsvUptd/QhyUa1grAim6AvPd9RMacmvnh2So
	 WZHZJtvO6RQ0fh5F+jwSW+4MKitqEfrMwEYd95H8ZJ1PnJ3JFR0PhWeOVSIv0hu6KW
	 bD8NbgICfLoT8+HObGl8m41xs4cOTTGgqDxlukutup8pBkbSv+ptZjFRG0mMx8OXlB
	 6fLQb6T5O55aQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4E8AAF40069;
	Fri, 19 Dec 2025 08:41:12 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 19 Dec 2025 08:41:12 -0500
X-ME-Sender: <xms:-FVFaS5JDrvRFmOhQqGOhP9DV6f8v_nn2DpG7nZtkPJTOeOgmK9syA>
    <xme:-FVFaWtQy7DarK_JDIY1-Na-ctp09GX0h7PooGeJt6uxyxKZsvcwM_76XSP9tkBp4
    f6cE85s72wp94fPOJ7o_mwRCFYKaC3sawILFJWd0vLBAASErhGpQng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegkeeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhtghhsehlsh
    htrdguvgdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopehnvg
    hilhgssehofihnmhgrihhlrdhnvghtpdhrtghpthhtohepohhkohhrnhhivghvsehrvggu
    hhgrthdrtghomhdprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtth
    hopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-FVFabNewtP3PxRIS5HENWPgbkH8x3bhAD42MFKWHUdnubwJPtGU5A>
    <xmx:-FVFaf9BxMZxY_2TM25uySWWuOu0CvUJOIIIKyTBUC3EXl30EdtLaQ>
    <xmx:-FVFaQ7CLRZG5Y7sde6vzQXvw6I-5s41sAWl7AThkzY628sgVYdY1A>
    <xmx:-FVFad4xdHeBxHOLmJdZNWjoaeYZHMFSTSEYtfyv5p_8L2_oiIDbNg>
    <xmx:-FVFaRoAskAP3IiJTaxm2K4bUAoNjIVwffSkWWmgGPvIhWYjkyg5uDsb>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 28F82780054; Fri, 19 Dec 2025 08:41:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AZx1KAhAoobc
Date: Fri, 19 Dec 2025 08:40:41 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Christoph Hellwig" <hch@lst.de>, "Dai Ngo" <dai.ngo@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, neilb@ownmail.net,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <965a8b42-dc2f-44ac-800d-2a9331db2b6c@app.fastmail.com>
In-Reply-To: <20251219052435.GB29411@lst.de>
References: <20251215181418.2201035-1-dai.ngo@oracle.com>
 <20251215181418.2201035-3-dai.ngo@oracle.com> <20251218093434.GB9235@lst.de>
 <ecc09cc9-a0c9-499d-9d47-e90aa1f1815d@oracle.com>
 <20251219052435.GB29411@lst.de>
Subject: Re: [PATCH 2/3] NFSD: Add infrastructure for tracking persistent SCSI
 registration keys
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Dec 19, 2025, at 12:24 AM, Christoph Hellwig wrote:
> On Thu, Dec 18, 2025 at 11:00:52AM -0500, Chuck Lever wrote:
>> > But taking a step back:  why do we even need a new hash table here?
>> > Can't we jut hang off a list of block device for which a layout
>> > was granted off the nfs4_client structure given that we already
>> > have it available?
>> 
>> My question is: how many items will this table need to track,
>> on average? at maximum?
>
> A good question that I do not have an answer to.  In my experience most
> NFS deployments actually use exactly one export per client, and I don't
> think I've seen a production deployment with more than a dozen exports
> mounted on a single client.  Then again I'm usually pretty well shielded
> from the worst enterprise deployments, so who knows especially in the
> days of containers.  Multiply that by the number of clients.

In my head that's getting up into the hundreds, potentially. I'd
say a linked list is right out. NFSD has utilized rhashtables for
several other applications to great success, so there is existing
code that can easily be copied for this use case.

We might also consider an xarray, which has an ultra-simple API
for basic uses, is reasonably scalable, and has somewhat better
memory behavior than hash tables.

-- 
Chuck Lever

