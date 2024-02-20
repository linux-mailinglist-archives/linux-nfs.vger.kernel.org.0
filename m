Return-Path: <linux-nfs+bounces-2035-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E1785BFB3
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Feb 2024 16:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 036281C20D14
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Feb 2024 15:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DE3745F1;
	Tue, 20 Feb 2024 15:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zP4l6T+d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C5E71B57;
	Tue, 20 Feb 2024 15:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708442375; cv=none; b=f5XJULQI5+Ydz9PerseQ0yjK6ar1u/aC/dh/PbCyJLXhpEaEv/sbQLPzt/z7/XeJX0nxPPvb3uUP6s5k9iK3xfuv8cVNAOJseRJ4DPjeg51Ov7+GQe9GXopWSkK2Til9NOvIHbme5xbJ/Vw9Zw93N3dbNT8M/ZeIPQtJCn9d4gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708442375; c=relaxed/simple;
	bh=ig380aOceuD2bzO6Xmk3XhQKEI2qQoctP69u2/rrHRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRGz7QrUSgr3My1JVnPqgVc3Bds5OxJe4nYY2l7Gpeqnsj/t7L/5lTCb7yFw0vJ4ERso0bCJiHu+gwKW6RIpiwOUWU6IyOc1EchhYmukEkvZRqiaRerzmkeCEqH1bbTH9mOE8tj9B/prQIEWQhsUXKcDIosIcGEUUsc54KO75+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zP4l6T+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C345C433C7;
	Tue, 20 Feb 2024 15:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708442375;
	bh=ig380aOceuD2bzO6Xmk3XhQKEI2qQoctP69u2/rrHRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zP4l6T+d62EjvRf+JOj6FwBT10PWFre1ro1d4a6CUl8vsGevddOPQYW4LsmHVBrhX
	 EhG2mkioHOg9wzd66OoO7QUMb/PzDzv+oIAzzU4LeHbjtmZuyf9C2kjpUAupcL3q90
	 9VIp/C9wWp8CyB7fZUdMiURr504Xb9Ncfgir31is=
Date: Tue, 20 Feb 2024 16:19:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: linux-stable <stable@vger.kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@redhat.com>
Subject: Re: [GIT PULL] NFSD fixes for v6.1.y
Message-ID: <2024022054-cause-suffering-eae8@gregkh>
References: <ZdS8TXWl3QKf0qdk@manet.1015granger.net>
 <2024022007-atypical-postnasal-37d3@gregkh>
 <4F521AD4-665D-45E2-925A-10E276F29F7E@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4F521AD4-665D-45E2-925A-10E276F29F7E@oracle.com>

On Tue, Feb 20, 2024 at 02:59:40PM +0000, Chuck Lever III wrote:
> 
> 
> > On Feb 20, 2024, at 9:57 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > On Tue, Feb 20, 2024 at 09:50:53AM -0500, Chuck Lever wrote:
> >> The following changes since commit 8b4118fabd6eb75fed19483b04dab3a036886489:
> >> 
> >>  Linux 6.1.78 (2024-02-16 19:06:32 +0100)
> >> 
> >> are available in the Git repository at:
> >> 
> >>  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git nfsd-6.1.y
> >> 
> >> for you to fetch changes up to d432d1006b60bd6b5c38974727bdce78f449eeea:
> >> 
> >>  nfsd: don't take fi_lock in nfsd_break_deleg_cb() (2024-02-16 13:58:29 -0500)
> >> 
> >> ----------------------------------------------------------------
> >> NeilBrown (2):
> >>      nfsd: fix RELEASE_LOCKOWNER
> >>      nfsd: don't take fi_lock in nfsd_break_deleg_cb()
> > 
> > A pull request for just 2 patches?  Ok, I'll go dig them out of here,
> > but next time, a mbox or just sending them as patches works too, no need
> > to go through the trouble of this.
> 
> Understood. These were already in the repo for our test infrastructure.

Not a problem, if they are easier for you to send this way, that's fine,
they were trivial for me to import in the end, I shouldn't have
complained, I just don't want you to have to do any extra work.

thanks,

greg k-h

