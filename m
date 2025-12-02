Return-Path: <linux-nfs+bounces-16857-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B83A6C9D55F
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Dec 2025 00:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F8324E0288
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Dec 2025 23:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6DC2E7166;
	Tue,  2 Dec 2025 23:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="eYkbI+Ii";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kX5meQdZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2B11427A
	for <linux-nfs@vger.kernel.org>; Tue,  2 Dec 2025 23:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764718123; cv=none; b=J6XFdzLKBskS3M1Dci0KOJBfufv9T5ZYo8HskmXiuwCq8XLSoPIt0NN6tYrS7pYBINj9745zzvjdUaq7olMuTKePf4JdR6P2NDCO+IZFdCao4y9v+QwIis8D4TMYl+gLzl+YjWOI8TzsoCcuwttIRbUOxGogw/IuemtX1DS0aIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764718123; c=relaxed/simple;
	bh=/zmHAgBpkxEFK3/Vy8Dq91e7Q64/3Dhh5GT8wEmObuc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=bUSQAOGa/JVoaByJXD11FVkdm9nSztl6zIC97Rmk9UgzqbCpwYMfDWtKFHvFw6e+ZGhd+B43vy+vMyjR4HhwfuFq3oQCZNtkO4hOn/hp6k0HlmrPWTu64jyafv1R6gGMgQOeKd8ZtwwyDeRCRhg1CuL4+86wgSsW9tEiJnYKRMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=eYkbI+Ii; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kX5meQdZ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7D04A1400188;
	Tue,  2 Dec 2025 18:28:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 02 Dec 2025 18:28:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1764718120; x=1764804520; bh=4tVyNdy+bg4TicsNSSLYAM4dS0X4x92KQFT
	Q37UXWGg=; b=eYkbI+Iir2AOpX9t+xRq1IcGzMdoK2CrwaY4bKIop2HMtMm5eI4
	Dl41JwMF8RKZb8+gfiLt5zhu7ouXeeP9Wuz/MWlq05yj57Y9YzzPqP7I6MENCWfs
	h9mKCSneUHX7s5dVpyL/Z5AGSbCYLKg0I3RH4pEyaQm5r5njqbX3sYIeD95dQocD
	v/dXy+whnUU8HyUmL6kzjVnpXEJUvBSLqajuN1YIjxmN+G2ZJ1rBDzGj9Ye/e9GT
	4k+ioTJXLWZxxlE7bUw6oMqg5WXqXnVyFWvp8yX6MgzR/w8+Z3c7RJR5i9TyFdQ7
	iXoMU0LwRFdumQF1RGidXIVV6LZV1EISeiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764718120; x=
	1764804520; bh=4tVyNdy+bg4TicsNSSLYAM4dS0X4x92KQFTQ37UXWGg=; b=k
	X5meQdZownNmxQtYWp+KBFs6kt75YA1ahkUYGTMeCEYiZ3jSMksQfjUVKJwW9i0F
	TmaX5elQ1L85ogJNwdoig2xcp+oQBoE1jvM0cuOAQy68vTG2qzlCprAajmpPiaXV
	I/1f3mZFQg+i/ve0HWNNaML8H9qG4d78or8Z9nxnEll7DbHG1ElZ6WDcqhP3TYv2
	QVRozJ1oUhJTN16cSPpy2ZKtONZFounsa7PPEht2hvBkU4m24mNtIVARg2cKwcTe
	sw2FYqB3GPzX/izOaA8tNRpy8ly0cj/8oxT8cBxFCxu+mAjZbqvSEVjHD2y0PBQV
	QmTo+9QVlrcQScEMdGn8g==
X-ME-Sender: <xms:KHYvafa86Bq2Eu5tTJRds7h3qRs0Oh-KimFe84VRJGLZpfVRQaLFuA>
    <xme:KHYvaQp9cxTj2capT50mgmYZGeo9N5fSpo481-iV-wbqmJEKgrXehAJHQ-2sZQ0mQ
    GaqRDbFqoi0_n4k6n9DdH08q-Vryrtau4akSZOct5ffmE5ggjU>
X-ME-Received: <xmr:KHYvaUMV_1NSMdOG5oQm0LTLnUbmyR_ODMiyrFFdvtBzBlqs-BxMbSFZ2CedMCYSLUuc22fREwnTSVj86MkQYmOAnljlFlL7p2gHFtKLdDEm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    eptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheurhho
    fihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepud
    etfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesoh
    ifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhnihgv
    vhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrd
    gtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhr
    tghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggvlh
    eskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KHYvabqtKTOqlcnJKisJkDTB2oRUkrATcu8vnnO2R9sq2czMmJxqzw>
    <xmx:KHYvaZfoAPbj5WaVsCrB98ZFaWxySQAhpBz9gsjQ8WRobTJGqOiQtg>
    <xmx:KHYvaRQS3D6WihyxuPClsGC3RKcJ504OGZYoa6UcbZa8QrT25X6hXA>
    <xmx:KHYvaSYGPPJR6OQjHbAxETuHmpRuihM-KlFFT84RBoduOoT5gRRIWQ>
    <xmx:KHYvaUXTEap2z7zGTUvIbUVcKbMBuwKhhueHeE0BMCGJR7SiFQ7O1Dm9>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 18:28:37 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 1/2] nfsd: prevent write delegations when client has
 existing opens
In-reply-to: <20251202224208.4449-1-cel@kernel.org>
References: <20251202224208.4449-1-cel@kernel.org>
Date: Wed, 03 Dec 2025 10:28:33 +1100
Message-id: <176471811359.16766.18131279195615642514@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 03 Dec 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> When a client holds an existing OPEN stateid for a file and then
> requests a new OPEN that could receive a write delegation, the
> server must not grant that delegation. A write delegation promises
> the client it can handle "all opens" locally, but this promise is
> violated when the server is already tracking open state for that
> same client.

Can you please spell out how the promise is violated?
Where RFC 8881, section 10.4 says

   An OPEN_DELEGATE_WRITE delegation allows the client to handle, on its
   own, all opens. 

I interpret that to mean that all open *requests* from the application can
now be handled without reference to the server.
I don't think that "all opens" can reasonably refer to "all existing or
future open state for the file".  Is that how you interpret it?

Thanks,
NeilBrown

