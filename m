Return-Path: <linux-nfs+bounces-14639-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE37B98F85
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 10:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68431885B2A
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 08:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F3C26D4DD;
	Wed, 24 Sep 2025 08:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="r61IzjpF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YK+TGtyz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2D729B8E5
	for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758703743; cv=none; b=HN1YXTpAHrlE+7fL3E1OAbABAgYbSWSzXiDuM6t/QrUjEpucBg6G9V2eOHiy6yAwyhVPnrUr+EZoRsosKGGHVbbjz0sF1loLiNrCDYqgxWcJZ7TcBKbLGc/RdZpWWc+WLuoPOJwz1QPw5/z2MAfXv2AR1rpEZWwXQfL6Xv9BdM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758703743; c=relaxed/simple;
	bh=Xtf7zEswxCj1BZQPatDlNNOoo+eyfypEhMl9K3COAu4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=HV2B48zWsHfnZ9+vvlNPcipbC/tAj2IpuNG3eOW8RGEVQ4O8u6c/mfThl8GWdWNhocGq1nxyG6eD6qGyxaYgUK89bG2HPcrfCcHNlAd8rUh4KF2nLfLNC4c9/KZznyR65tHPpPgvXIQBJamx3POCc5UtTlwd3xjr3iJOHMfZbmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=r61IzjpF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YK+TGtyz; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 392A514000FD;
	Wed, 24 Sep 2025 04:49:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 24 Sep 2025 04:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1758703740; x=1758790140; bh=wckB9kesPcthpjKPIu5cJIv/KKF1uGsbeb6
	yoPGP4Oc=; b=r61IzjpFikAMqKtellGK4Q0uh6BTPm7UbwW/RiZfjYQU5cb2HwB
	eLT5knAAtZd2QDBq9vaEYwPSaV+uSbvFuOz42Dbm/coFfaSXR6EDbjW5dBAcXh97
	9bWds6BAhpdncUcAQohjgBzjsKN9Cj5JcX5XP1bGZbfUsh7Q1yTUidY/2jqmIFcM
	CGgGYZxYlMX0ZNvZGgJFI0dbWcv6psSQJV0/hMeNUePAr+WUgCe0Eq2rDCxS6o4s
	X4UiUSjv8vrLuljYALB5zlh3zenpVPTcR8bjGBYcSosSBjbayYY5s91ke694HFmo
	ahN+/MYpoUIzyLHtBNrQZS5QhMBR/os/dMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758703740; x=
	1758790140; bh=wckB9kesPcthpjKPIu5cJIv/KKF1uGsbeb6yoPGP4Oc=; b=Y
	K+TGtyzAqZrz8dH0EludhyY+sZMs76NuW+PL1omWNSk0xdu91laxTOSHQhc6cm56
	g3Wol10m7js0Tk9pW1Ju5Mo8Sg60d74AC+SV1+20FkDOjIY3tfPuHwRMm8jpPtxx
	vd4pv7cMVg3baPTpN45wnItS7Bdr8TaAmgkt0d+QktwPz4wCPTONCi2RAx30llQc
	RvAvt4AEfSmS6+Ulx6SYwLGmlXat61+CAIubeBR4PJlywX8Wg21vpbUVzTZev8yK
	1hRhBRtPUz0b1R+jYO5DVMQAb2ZIi6K9G1isNo03x4Pgz1cPrD/0Ho1ChpzavWC4
	nC9lUDmIaRZoISZJZS8VQ==
X-ME-Sender: <xms:e7DTaAutY9UU9GUuGBzM0257fNngJCnKIX7cZ6VA92BjxfyoPPNELQ>
    <xme:e7DTaKVkKgCcatJvdQE5hTUyPCfQGLC4Mch0aE9UORg6atV3NeRzty5IUah56kTRK
    3nx0i0pylnrd0xinWBwY4yfZFkGSaOnvL1evj_qMfQkxnsIEA>
X-ME-Received: <xmr:e7DTaLjNIRRjD_quC-dEq0KxLGsWw8O4DInRUwtu5AgAzdnarKctzJ_BM647pOUKtyp8F_47kCxxBzJpru2sSa_A4rXh9a-vh2wrLaLSYNaf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthejredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    duteefhfduveehvdefueefvdffkeevkefgtdefgffgkeehjeeghfetiefhgffgleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhi
    vghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvg
    drtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehmtghgrhhofheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrg
    ihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughjfihonhhgsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegtvghlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:e7DTaCoXWKjyDN7vrpGRHKN7qYBXoNiwO8cYEzWm8muAI46851EeLw>
    <xmx:e7DTaBFPq6qrVafMKOCKoQr_vNyNTQncGi9Xq3mUZjVT1sxfq0m_kA>
    <xmx:e7DTaH7srP6K9OF8AfpqirvnGu4Ms00v61FXXTuISgZCo3LGh3lPKA>
    <xmx:e7DTaJfMDYzZK8qc8DlprOoZegxFeco-gOWiq-l28oXKICs_wbKZ0g>
    <xmx:fLDTaBLFUNeJX127p_Drkf3bpBRlH8NqGanxqtLr_lOcZW47gXWqm9AS>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 04:48:57 -0400 (EDT)
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
 "Chuck Lever" <chuck.lever@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>,
 "Luis Chamberlain" <mcgrof@kernel.org>
Subject: Re: [RFC PATCH] NFSD: Add a subsystem policy document
In-reply-to: <0fbaef6f-80ad-4885-ba2b-6a9567f01042@kernel.org>
References: <20250921194353.66095-1-cel@kernel.org>,
 <175851511014.1696783.3027085648108996983@noble.neil.brown.name>,
 <0fbaef6f-80ad-4885-ba2b-6a9567f01042@kernel.org>
Date: Wed, 24 Sep 2025 18:48:53 +1000
Message-id: <175870373332.1696783.10824173167180857471@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 23 Sep 2025, Chuck Lever wrote:
> Hi Neil -
> 
> On 9/21/25 9:25 PM, NeilBrown wrote:
> >> +Patch preparation
> >> +~~~~~~~~~~~~~~~~~
> >> +Like all kernel submissions, please use tagging to identify all
> >> +patch authors. Reviewers and testers can be added by replying to
> >> +the email patch submission. Email is extensively used in order to
> >> +publicly archive review and testing attributions, and will be
> >> +automatically inserted into your patches when they are applied.
> >> +
> >> +The patch description must contain information that does not appear
> >> +in the body of the diff. The code should be good enough to tell a
> >> +story -- self-documenting -- but the patch description needs to
> >> +provide rationale ("why does NFSD benefit from this change?") or
> >> +a clear problem statement ("what is this patch trying to fix?").
> 
> > These paras look to be completely generic - not at all nfsd-specific.
> > Do they belong here?
> 
> Can you clarify which paragraphs you mean, exactly? Maybe the whole
> section?

I specifically meant the previous two paragraphs.

The "Describe your changes" section of submitting-patches.rst seems to
cover the same ground.  It even says:

> Once the problem is established, describe what you are actually doing
> about it in technical detail.  It's important to describe the change
> in plain English for the reviewer to verify that the code is behaving
> as you intend it to.

which is close enough to the addition that I suggested.


> 
> For context:
> 
> IMHO these comments aren't necessarily generic because I haven't seen
> them in other documents, and we seem to get a lot of patches where the
> description is just "Make this change".
> 
> The comments about tagging: I think other subsystems might not mind
> seeing Cc: stable in the initial submission. NFS maintainers (even on
> the client side) like to add those themselves.

If you don't want "cc: stable" then certainly include that.
submitting-patches.rst encourages it to be included - for "a severe
bug"....  but it has been a long time since stable was for "severe" bugs
only.

> 
> I'd like to encourage contributors to get the Fixes: tag right before
> submitting, too. It saves me a little incremental time per patch.

submitting-patches.rst encourages a Fixes: tag.

> 
> And, some of this text was cribbed from netdev's policy document, not
> from a generic document, suggesting these are subsystem addendums.
> 
> 
> > I expect more of a patch description than is given here.  I agree that
> > "code should be good enough to tell a store" but I don't think that a
> > patch can by itself be good enough.
> > So I think that a patch description should describe the patch -
> > particularly how the various changes in the patch relate.
> > 
> > With a good patch description, I should be able to then read the patch
> > and every change will make sense in the context provided by the
> > description.  It isn't just "Why", it is also "how".
> 
> I can add these remarks.
> 
> 
> -- 
> Chuck Lever
> 

Thanks,
NeilBrown

