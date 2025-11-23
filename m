Return-Path: <linux-nfs+bounces-16679-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CD4C7E2CC
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 16:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F22C44E0370
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 15:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C3A1E8826;
	Sun, 23 Nov 2025 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqmnIwri"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53BF3597B
	for <linux-nfs@vger.kernel.org>; Sun, 23 Nov 2025 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763912820; cv=none; b=c/Jxjy+YvXzYsAWoD1Zy7Ybzjv14w9Wk+racA6Ei0S2jdQ/33PZXvuSQRKO3yNTwPOM9vGxx7td3QNzWOUKKDMSoRuINLowd/VRwQySXl+0hLn5YMcJEcor/8jR+W4Cbo2IrGvBHRjXnzZsMAnMycIzEnNHx544PRJBj/SudkmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763912820; c=relaxed/simple;
	bh=IPBMTIM1eZstskxJm+aRPOi4x5lPzxZo7AehKBe6tJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSmvYF2OzW3+4KMT9BHvdvKAFjTkwFnH1RTMMOUo6tzafT5w8iUlvQyPaxbf5XoajETiUA0d6Jm5wboYplPWrPlGqesbT3brqOG05V0Sl1DWVTKnKxysgt91/HAyUPg9/oL/2RW1LzJhlYbx6Mi/V5EKfeKUFZxEu7yns3WUUEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqmnIwri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E779C113D0;
	Sun, 23 Nov 2025 15:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763912818;
	bh=IPBMTIM1eZstskxJm+aRPOi4x5lPzxZo7AehKBe6tJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bqmnIwriCJW9zjkPNGZ3IyhThFNvHVNGOLRLqi9scoOUJFpJaZL7yJpOUam1H3pub
	 sd+7wGhkCudHOKFyV0vLIf9F/qIB8GMzIr7PyYCfXjlxhUqdx4Btj+PtLfZuYoKVHh
	 acovRIuwJsPIVuImCd9aVMPXieS3cA2rTmmA1Zx9okrVJGbSLoQqeKVjsjfpFj2nB5
	 LyNMwG4UxpXRIXr3reHYqdlWuoVOP3LDhDgKqr+t5GYgpsCr2zuK1WyMn/OqjTTU0m
	 X+//fBe0xk+J69vIWsscUW64MQ0PkS/wAGqU3IKiHnHifTWVosisUHf3ca9FzRrien
	 sUEx/n6usRBtQ==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0EBD5F40068;
	Sun, 23 Nov 2025 10:46:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 23 Nov 2025 10:46:57 -0500
X-ME-Sender: <xms:cCwjaXdDBqUznizXa5vpShZkSwfkY7N11iNAFvwuSH-uWgmQYDaShA>
    <xme:cCwjaTNDjyBIZnGQSoTk7NE_zcNA272dC_lefknnI-OAIwlmuJA_l2TZph5XoM3cp
    MqDHVEgxlzUiIKK0ktAQrKwh17ZpN0NUPboCSSxXTUV-swEHQktXUY>
X-ME-Received: <xmr:cCwjaeJkrPSfzLfB6o4a2XpHUONEe-CwHy6HjnmXigvWa9vHObdjWGEZeeUcfj2E4BXdwTceD-riuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeiuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeevhhhutghk
    ucfnvghvvghruceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    fhleehueejiedtjedtgeeivdehleduieetleekjeegiedvffefheevgfejgefhjeenucff
    ohhmrghinheplhhinhhugidqnhhfshdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutghklhgvvhgvrhdomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqudeifeegleelleehledqfedvleekgeegvdefqdgtvg
    hlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthht
    ohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghurhgvlhhivghnrdgtoh
    huuggvrhgtvddttddvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhf
    shesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cCwjaUFJPDTcPmd4blE0Oft-PWhznrEpJiX5LvrMOBJACDD-Hp_9rQ>
    <xmx:cCwjaWQULjewLJbv1x4qMNt6jFlgmeEvxcZ5w1k00v7vLGKbiDLwgA>
    <xmx:cCwjaQFyuAYWD-2PWe6RkTbMPtzhrIU6VMVbJPP_9l6oyeYF8kiPwg>
    <xmx:cCwjaS8jdmULmPds2NkoC7Ki1fu5nn1kyKNYvTzDlQscTWZ9iFNdBA>
    <xmx:cSwjaaIsDzrnzD2Wgib8ofJayNXINStEljKxy3SfB6jIdkHJECwudnbf>
Feedback-ID: ifa6e4810:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 10:46:56 -0500 (EST)
Date: Sun, 23 Nov 2025 10:46:55 -0500
From: Chuck Lever <cel@kernel.org>
To: =?iso-8859-1?Q?Aur=E9lien?= Couderc <aurelien.couderc2002@gmail.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1] NFSD: NFSv4 file creation neglects setting ACL
Message-ID: <aSMsb350kJgqysbz@morisot.1015granger.net>
References: <20251119005119.5147-1-cel@kernel.org>
 <CA+1jF5pF+K3s9N4p5mc4cxyzg=r5ow5R_T31Eab=DOW5AjBG-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+1jF5pF+K3s9N4p5mc4cxyzg=r5ow5R_T31Eab=DOW5AjBG-g@mail.gmail.com>

On Sun, Nov 23, 2025 at 03:54:48PM +0100, Aurélien Couderc wrote:
> On Wed, Nov 19, 2025 at 1:51 AM Chuck Lever <cel@kernel.org> wrote:
> >
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > An NFSv4 client that sets an ACL with a named principal during file
> > creation retrieves the ACL afterwards, and finds that it is only a
> > default ACL (based on the mode bits) and not the ACL that was
> > requested during file creation. This violates RFC 8881 section
> > 6.4.1.3: "the ACL attribute is set as given".
> >
> > The issue occurs in nfsd_create_setattr(), which calls
> > nfsd_attrs_valid() to determine whether to call nfsd_setattr().
> > However, nfsd_attrs_valid() checks only for iattr changes and
> > security labels, but not POSIX ACLs. When only an ACL is present,
> > the function returns false, nfsd_setattr() is skipped, and the
> > POSIX ACL is never applied to the inode.
> >
> > Subsequently, when the client retrieves the ACL, the server finds
> > no POSIX ACL on the inode and returns one generated from the file's
> > mode bits rather than returning the originally-specified ACL.
> >
> > Reported-by: Aurélien Couderc <aurelien.couderc2002@gmail.com>
> > Fixes: c0cbe70742f4 ("NFSD: add posix ACLs to struct nfsd_attrs")
> > Cc: Roland Mainz <roland.mainz@nrubsig.org>
> > X-Cc: stable@vger.kernel.org
> > Signed-off-by: Chuck Lever <cel@kernel.org>
> 
> As said the patch works, but are there any tests in the Linux NFS
> testsuite which cover ACLs with multiple users and groups, at OPEN and
> SETATTR time?

I developed several new pynfs [1] tests while troubleshooting this
issue. I'll post them soon.

-- 
Chuck Lever

[1] git://git.linux-nfs.org/projects/cdmackay/pynfs.git

