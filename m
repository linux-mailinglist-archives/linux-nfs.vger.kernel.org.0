Return-Path: <linux-nfs+bounces-10201-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791EBA3DC70
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 15:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6AE165FDC
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 14:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184E01FF1CF;
	Thu, 20 Feb 2025 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h610QMXl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF721FECA6;
	Thu, 20 Feb 2025 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061028; cv=none; b=U3eGXqq+NohcqArAXqOevlXNV1uIgmKvH7n6om6Q7Zw1oSX6JviBRrWe9EF0qndt4fpHXIZreqIDqTTUnmmvJJe6Obn5dJ8FQ1MLcYjSVoj5vz63ZD6TZC2LKZmv6EF7ZAERk+a0enucyhCWB/wrQlAtP8RY8+kC8K3IhvTpa7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061028; c=relaxed/simple;
	bh=7GCxEoOqZGDJcRtZ3exZiIuelMlMHgN4diFE3dEprsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZoKzjxzXkakOKkxyGvYA+Hp52ruA4qb0Uzak59U6MLzsyOxLEm2J+09HevpB4RdU9lNs0Z48t0RSc0cG70X/faQg9lMSc12veihHNyKeUxqISO15l1Kh10ZkTnXRtXsjk9DK8Bka6nx94n2cTScw0BLwfZyLy8Ti5zQauXAwZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h610QMXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A5CC4CEE6;
	Thu, 20 Feb 2025 14:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740061027;
	bh=7GCxEoOqZGDJcRtZ3exZiIuelMlMHgN4diFE3dEprsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h610QMXlxM6aMq5YPOuT86uqfzZ6Glh7svzviC2mmPAephwWpEQMzc/T4f35tA+l4
	 OO0QSYtEe4h60ARlMWzsWjHgD/1KnPhds1mV9VbeZXkzcieXLpeEpxta7xLREcURnq
	 j95k0D8KlrCbktzO7nmh33642KD6T6SCPXyHHTaA=
Date: Thu, 20 Feb 2025 15:17:04 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: David Howells <dhowells@redhat.com>, netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] fs/netfs/read_collect: add to next->prev_donated
Message-ID: <2025022051-rockband-hydroxide-7471@gregkh>
References: <CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com>
 <20250210191118.3444416-1-max.kellermann@ionos.com>
 <3978045.1739537266@warthog.procyon.org.uk>
 <CAKPOu+8cD=HkoNYYknivDJnb6Pfxv+KF28SBUDEqha4NE5sxhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+8cD=HkoNYYknivDJnb6Pfxv+KF28SBUDEqha4NE5sxhg@mail.gmail.com>

On Thu, Feb 20, 2025 at 02:09:17PM +0100, Max Kellermann wrote:
> On Fri, Feb 14, 2025 at 1:47 PM David Howells <dhowells@redhat.com> wrote:
> > Signed-off-by: David Howells <dhowells@redhat.com>
> 
> Greg, you merged my other two netfs fixes into 6.13.3, but omitted
> this one. Did you miss it, or was there another reason?

It wasn't sent to me or to the stable list, so how could have I seen it?

confused,

greg k-h

