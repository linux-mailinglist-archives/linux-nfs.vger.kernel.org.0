Return-Path: <linux-nfs+bounces-16691-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0448DC7E32F
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 17:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B75A3A7267
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 16:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4DF20FA81;
	Sun, 23 Nov 2025 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXpiB/Pg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067AE1D5154
	for <linux-nfs@vger.kernel.org>; Sun, 23 Nov 2025 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763913852; cv=none; b=d1ozNY7gswFNKRb9r87n6mmDos+qAvy01kx5fZp4kpOxNhZv4cOyKrL2Yh7mZf2fogTfCZGitXXjHbWIBJSU+49/bed29vAN6t3wM2IVWNJmGCFfaMWgjbLegyddhqUhr2kDxGwg8DDoz1BfkFG04ndRGnRuA4+YYNkk4JIUi7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763913852; c=relaxed/simple;
	bh=hGPJOc+NM/Xq9V6SO0nazg2a5RV3Ns/sAQbotnHy1jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmlNUYwxj9N2hv9GJeka+RXWxaZzAejiGNa/m1Vt85sg82P+bhfPq/41+hYMVvTP5LwKGQ4lmrfOPLVGymEJcbwL7m3Es6pKdB1kiNQxn+PRXXOSXD2ODIkU8KEvWUjGzx9eO5FQZfUbYujR6Y3WgYW9SbC/epXpaDT1yBAp4Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXpiB/Pg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D8FC113D0
	for <linux-nfs@vger.kernel.org>; Sun, 23 Nov 2025 16:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763913851;
	bh=hGPJOc+NM/Xq9V6SO0nazg2a5RV3Ns/sAQbotnHy1jM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tXpiB/PgzAX4jhLJ3GlHMsYDs6eP89EwYay1X20eeqkLnk+ykwgMoLxeDyIGBcYz1
	 lbb5fhS2w6JWtnDgzOn0xdcs+0Pl4Ibq3oZdW/JBS8RcGQUYMO3BoUDx8+vM7FB8xo
	 X89WFBrpS0zlt6Gm5tbxR4PPM2K19lhxVHj4RvOFzJ52TSnjoENg7TtYFf8enLS+7J
	 ZHcnKgLvNpStrAwD7xcpgO3apaJGVBwAwwOfW84MZvyUyYJhhy0tZ4ZW9tBATohaiC
	 o0fSuQmFy53BJgSCiIoUTDY2mzWGw5GUXgUTUkrfKkmmxkZp/bdSZXiTk0TkP9uX0a
	 FatNa8BnZ85Rg==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 86227F40069;
	Sun, 23 Nov 2025 11:04:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 23 Nov 2025 11:04:10 -0500
X-ME-Sender: <xms:ejAjab8K6MZdGYVeEqCNXiztZ8n6Jlsrx70lgsqzxjwFpRmv8ROtNg>
    <xme:ejAjafIkWmb90RG1WNUFcLoy1Jrwjc_jXjd7Mowh6HINF99AsAXIuTeFwS1A9OgUA
    A1ieXEL6MtYifhEiM1teulKpzQWBCLlCrvWKcK-9882A5l6nLsuzZw>
X-ME-Received: <xmr:ejAjaWYvKbEhxnNo2SHfeJ9pm5Mbt6zFgAm_srka2NifU6Ue7s3xqXdSUYru5pcBGEiCNp79itL-Bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeiudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvehhuhgtkhcu
    nfgvvhgvrhcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhephf
    efveeuhfdtgedvheevuddtgeevfedvtedvkeegveeluefgkedvvddtudevuedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvg
    hvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleelheel
    qdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegtrghluhhmrdhmrggtkhgrhiesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplhhinh
    hugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhutghk
    rdhlvghvvghrsehorhgrtghlvgdrtghomh
X-ME-Proxy: <xmx:ejAjaRJW8X2E3sqTyF3hXR2sgmuljuKP8uTXF1YGBafDFKlztZckEg>
    <xmx:ejAjaUBND9I3mLjAhQIra0FPk5qcWVrtwK7KV8h5DMfSjXjU8by2SQ>
    <xmx:ejAjaWrlfPGr_0d_a-zHN7NCEJW5wVLGmhtltQGEuV3ZyDmR7dcZdg>
    <xmx:ejAjafjz1d9__cjTb3kg9TY9vWOB9dvq-oKqDCuc0SN2V07uU-6fyw>
    <xmx:ejAjaTBxGOP7kcxbZUYJRb7KRgV7qoR4Q0bZNuTs7r7gKqR1A0WmA61i>
Feedback-ID: ifa6e4810:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 11:04:09 -0500 (EST)
Date: Sun, 23 Nov 2025 11:04:08 -0500
From: Chuck Lever <cel@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 05/10] Add make_test_acl() helper to nfs4acl modules
Message-ID: <aSMweIhPcB9lSGv4@morisot.1015granger.net>
References: <20251123155623.514129-1-cel@kernel.org>
 <20251123155623.514129-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251123155623.514129-6-cel@kernel.org>

On Sun, Nov 23, 2025 at 10:56:13AM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>

Yes, clearly these need a little more clean-up: This patch
and a few following ones need real commit messages.


> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  nfs4.0/nfs4acl.py | 22 ++++++++++++++++++++++
>  nfs4.1/nfs4acl.py | 23 +++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/nfs4.0/nfs4acl.py b/nfs4.0/nfs4acl.py
> index ceb9ea6a198e..329be01f9fd6 100644
> --- a/nfs4.0/nfs4acl.py
> +++ b/nfs4.0/nfs4acl.py
> @@ -78,6 +78,28 @@ def mode2acl(mode, dir=False):
>               nfsace4(DENIED, 0, negate(other), "EVERYONE@")
>               ]
>  
> +def make_test_acl():
> +    """Create a test ACL that maps cleanly to POSIX ACLs
> +
> +    Uses OWNER@, GROUP@, and EVERYONE@ to match POSIX user/group/other
> +    structure, which helps servers that map NFSv4 ACLs to POSIX ACLs.
> +
> +    Includes both WRITE_DATA and APPEND_DATA for write permission, since
> +    Linux NFS server's conservative NFSv4-to-POSIX mapping requires both
> +    to grant POSIX write permission.
> +    """
> +    return [
> +        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
> +                ACE4_READ_DATA | ACE4_WRITE_DATA | ACE4_APPEND_DATA | ACE4_READ_ACL,
> +                b"OWNER@"),
> +        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
> +                ACE4_READ_DATA,
> +                b"GROUP@"),
> +        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
> +                ACE4_READ_DATA,
> +                b"EVERYONE@")
> +    ]
> +
>  def acl2mode(acl):
>      """Translate an acl into a 3-digit octal mode"""
>      names = ["OWNER@", "GROUP@", "EVERYONE@"]
> diff --git a/nfs4.1/nfs4acl.py b/nfs4.1/nfs4acl.py
> index 44f01de0d513..f4d4993b143b 100644
> --- a/nfs4.1/nfs4acl.py
> +++ b/nfs4.1/nfs4acl.py
> @@ -3,6 +3,29 @@
>  #
>  
>  from xdrdef.nfs4_const import *
> +from xdrdef.nfs4_type import nfsace4
> +
> +def make_test_acl():
> +    """Create a test ACL that maps cleanly to POSIX ACLs
> +
> +    Uses OWNER@, GROUP@, and EVERYONE@ to match POSIX user/group/other
> +    structure, which helps servers that map NFSv4 ACLs to POSIX ACLs.
> +
> +    Includes both WRITE_DATA and APPEND_DATA for write permission, since
> +    Linux NFS server's conservative NFSv4-to-POSIX mapping requires both
> +    to grant POSIX write permission.
> +    """
> +    return [
> +        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
> +                ACE4_READ_DATA | ACE4_WRITE_DATA | ACE4_APPEND_DATA | ACE4_READ_ACL,
> +                b"OWNER@"),
> +        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
> +                ACE4_READ_DATA,
> +                b"GROUP@"),
> +        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
> +                ACE4_READ_DATA,
> +                b"EVERYONE@")
> +    ]
>  
>  def acl2mode_rfc8881(acl):
>      """
> -- 
> 2.51.1
> 
> 

-- 
Chuck Lever

