Return-Path: <linux-nfs+bounces-10938-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0262FA74211
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 02:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940631729CC
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 01:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E16514A4E7;
	Fri, 28 Mar 2025 01:31:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EDA224CC;
	Fri, 28 Mar 2025 01:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743125517; cv=none; b=etxy46voQ0shWl92tKZPHcC9DIExwoeDXYOkq5C2knG4JKcbQOhLS5OLBK3OctqNP3FdUdbG2th8nrKCYo9QyY9D2pBqH3igLaxwZAK/tkidhO4Ap+0y8YYOnYvTc1XgMgjtSjCQcgNK/ho9GktCj7ZcQwdd6PeLZxn8tgwEimI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743125517; c=relaxed/simple;
	bh=OcZfFHonXfrQppLL27RR/4vZJVuDX6m1Xdbrs6eCGn4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=hXcM7lzBKTMTDOBdyEmLzbaqSPuv5XdZmwKtFm69jkctuV9YKlF1+FfL//+b0r68NkQ/+pD1XrC65QOz/XsbZDKwcBQFt/dK5ANyP/ZlpDF5PittXtRPgM9CUNJouCl0LriLtjxL8HeWQR+b2e/xcjDDZkVVKn70MlnhSSb+vOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1txyZa-001tGv-L9;
	Fri, 28 Mar 2025 01:31:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "David Howells" <dhowells@redhat.com>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/6] VFS: rename lookup_one_len family to lookup_noperm
 and remove permission check
In-reply-to: <20250322003403.GE2023217@ZenIV>
References: <>, <20250322003403.GE2023217@ZenIV>
Date: Fri, 28 Mar 2025 12:31:50 +1100
Message-id: <174312551036.9342.16822785547327803699@noble.neil.brown.name>

On Sat, 22 Mar 2025, Al Viro wrote:
> On Wed, Mar 19, 2025 at 02:01:35PM +1100, NeilBrown wrote:
> 
> Quite a few of those should be switched to a common helper,
> lifted out of debugfs/tracefs start_creating()...

The next batch of patches will add "lookup_and_lock" family of functions
and change various calls to use them, including the "start_creating"
functions. 

The goal there is to get all the code for lock/unlock around
create/remove/rename to be in namei.c so we can change it in one place.

Thanks,
NeilBrown


> 
> I can live with that, but it'll cause fuckloads of noise in
> persistency queue... ;-/
> 


