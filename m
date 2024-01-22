Return-Path: <linux-nfs+bounces-1281-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC2D8377BD
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 00:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 086B2B23E62
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 23:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6E34D59A;
	Mon, 22 Jan 2024 23:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="yhj/qgfD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kh2EAe8i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79304B5A6;
	Mon, 22 Jan 2024 23:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705966276; cv=none; b=gc0grkz9ZBBaLeic/TzbG4YwXpjt8M0y4UN0ouVm/Fy9dg8RdAcIiQSHjg+x0yWWAcgLkO9cR5V/D3jNWaUaMuTBrspv9NWvuUnyOl+Oo26lpLqKqXeir2RC6cfnUOcYxtAH4C+Ghwws/jbeP4wwMeYzIj2sTFh9cZsXyQx5MZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705966276; c=relaxed/simple;
	bh=UVgaqNAleCMh4pz11mvPeKLmeEBJunt0x9jqrycOGGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tdv/no7tMATm6WBzib+eyJ32tgVJGiLjtVFii3tJOJTVNe2uDMmVT0e9OrFdkSmeLehTs6arKva3XWzSaIDfh0Ggli4DyEA/ZHSpnoKfGJSdhc5JtCFKPpB69Gbq9g6vMYf1YS0gXD59id2VbNcNv6NzdeQhUh6ZCqbsGR2J1Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=yhj/qgfD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kh2EAe8i; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 6EB285C010D;
	Mon, 22 Jan 2024 18:31:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 22 Jan 2024 18:31:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705966273; x=1706052673; bh=QY+0kxBa45
	0WcfgRMk0z0mHgovAmPelM5cmZQpZZdoM=; b=yhj/qgfDKjwua4lLodqTiL+9RJ
	dmpUMxFKOwedzDLdybSoMQhjhw/ZQjJzXVivyIT8TTYWnWgyFM4iUVlt96X6SCHB
	NkVq7TNpQVz3My5tCe+h72bpbb/kg1vj4F3e4VFfdPbtbAHfNh8qcIswvJcapAX8
	ZvcDvn5cS84FcR61MtKLETlzbss/wJzJXustyZGVoQAKFTQhkT+Va1CJSvAlxAaO
	I+T44cWvTDXaqXsKW99+W0dWe7dn9cwygwMfURFJXsMjVDHxpVsVE4REt7ZKAkbz
	I+uCLCcN7Km1drPZwZI0Vhx9Gq8VNHVHo2up5lmHxjetXBWlNAKpJdC9+wAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705966273; x=1706052673; bh=QY+0kxBa450WcfgRMk0z0mHgovAm
	PelM5cmZQpZZdoM=; b=kh2EAe8iO6r0ms/eEDDg4jVRA2E4IWcT9v3hTu4dfAL3
	68I9vDJy41YxUYzh/fjMkKSYhD9+tg6IUCSGbuvawqk94EkapDeRFVWqzZOiNiVd
	QHb7o9U6ooED3BwcTSTiyno81WhjqlnD97N8lHhyJbfASeG7nz0P2o97H+WCg96f
	0r0EHBYeq2ZKz3k55RzU9LrhBBxM/3pW6sgllrnmBdsV2d6OLuGXC8BDISnL8wgN
	pWbNwQbrsQev+yNgnFiNogpQZ85RPskf2lv6IP6N+dtIOWm2VcJqhCSpk4JFEhAR
	qjG0m/T/O69dRNpDgebCR/AwC4V8w851mJ6BKYM/UA==
X-ME-Sender: <xms:wfquZR8OpuDEKXbcHeAtw9tuabXa3ftslwSGABeQ4vjSjRnM5P72hA>
    <xme:wfquZVv57QXdNIiTNj3fl0PAk8KCvK2JNyu9hEJhMYgVDoyoIc54sycsGWTSLBbRo
    EihlXV390U0Mw>
X-ME-Received: <xmr:wfquZfBFnxVslWVqVRt7PrPEroAJyf34G486tfjLJOGz3JpLqVOmJd_HP61LPcjlCtgpVfEGpJYtQ6Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekjedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:wfquZVfTySuXfCTH-Qt6kIuR98SfRSVShied1sgN5pT8V5yVWm00yg>
    <xmx:wfquZWPqRntEQ4YNoNrYKWOjZnvMWyDbQ3xiBrYsCBDl4jq8A9wWSw>
    <xmx:wfquZXla8aGxjuGHYr5_DtJZBrjJe4wtEULVppSkg1gGTxlBDss4NA>
    <xmx:wfquZXiKa6RHPBwdgc17H9np0vIODZLC9o-QlNWVwgarvtpxUYVPOg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 18:31:12 -0500 (EST)
Date: Mon, 22 Jan 2024 15:31:05 -0800
From: Greg KH <greg@kroah.com>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: linux-stable <stable@vger.kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>
Subject: Re: Revert ef481b262bba
Message-ID: <2024012200-stratus-curdle-fa92@gregkh>
References: <6EE7E263-F099-4E6E-99B6-C531D33C26CF@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6EE7E263-F099-4E6E-99B6-C531D33C26CF@oracle.com>

On Mon, Jan 22, 2024 at 11:20:46PM +0000, Chuck Lever III wrote:
> Hello -
> 
> Neil Brown has asked that
> 
> ef481b262bba ("NFSD: Fix possible sleep during nfsd4_release_lockowner()")
> 
> be reverted from origin/linux-4.19.y
> 
> See: https://lore.kernel.org/linux-nfs/3162C5BC-8E7C-4A9A-815C-09297B56FA17@oracle.com/T/#t

Now reverted, thanks.

greg k-h

