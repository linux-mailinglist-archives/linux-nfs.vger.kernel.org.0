Return-Path: <linux-nfs+bounces-12375-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10528AD766C
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 17:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2803C3A2CCD
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 15:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B809298991;
	Thu, 12 Jun 2025 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvNrHz+H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7411E2D1F61
	for <linux-nfs@vger.kernel.org>; Thu, 12 Jun 2025 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742343; cv=none; b=gypxiHWpQLB4iFXvVEwG/b4lho/l5FLaveWUBoTQMGZ2H8EUQFEPCkvJY7riFy3tDp14bGzMPGChhgJEWCpkJ+IfqP2iZr76UpyZlYsjCCiRYNVENPYEY9HtncDyMIYjcX4TpfUvy54xin/npK8AaecoS7wNd72TMbpQJxoTJ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742343; c=relaxed/simple;
	bh=DvbC/HmKCB3rVF9uBHrgwzj2bRCkgbMMkfG7+8Oh0W8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMAlVgdw6fCBmruYcUAK5loH+8KNcemM6RCm98WOpkLHIedIjmieKcxaR5fGkV1dvf3R/SxXwPK6hp+9pBpkYVzfX2lBF+VTpliKQ1GiM33up9CX0cqdAUzC9Apv81K3RgaRTzVqvQvvw7SysECiB6gHFre6FyXdGvCLN+zgaPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OvNrHz+H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749742340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y97mgHxBZzYRdJXWIwZcNAyfsDMuo7Wult/gI2Xd00g=;
	b=OvNrHz+HkSUkyXPtVlGaLut5FYME4GQbwhUZk8lTPXV0a8tXxFDIjGxdsyvJyqVlOpH1Dn
	wfuyIvX/w8uqwclC54Yb6qUCe95t2m9xgRrpDATa+2UIHtej+AO7JDNAzlAa1zddPa0bEM
	6x+OAbjQpHBdWBS70qUGGuEkJE3RHh8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-OZnLMs8kM961v57Ri5iDpA-1; Thu,
 12 Jun 2025 11:32:14 -0400
X-MC-Unique: OZnLMs8kM961v57Ri5iDpA-1
X-Mimecast-MFC-AGG-ID: OZnLMs8kM961v57Ri5iDpA_1749742330
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07D94195608C;
	Thu, 12 Jun 2025 15:32:10 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.9])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B95A718002B3;
	Thu, 12 Jun 2025 15:32:07 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
 Lance Shelton <lance.shelton@hammerspace.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>, linux-nfs@vger.kernel.org,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v3 2/3] nfs: Add timecreate to nfs inode
Date: Thu, 12 Jun 2025 11:32:05 -0400
Message-ID: <1877A633-7DCE-4598-BEE5-83E854F7DE61@redhat.com>
In-Reply-To: <202506121525.2eac47db-lkp@intel.com>
References: <202506121525.2eac47db-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 12 Jun 2025, at 3:22, kernel test robot wrote:

> Hello,
>
> kernel test robot noticed a 41.2% regression of stress-ng.msg.ops_per_sec on:

Wow, this is really unexpected here - best I can think is that we're mucking
up cachelines in a very problematic way, but then NFS would have to be
involved in the test somehow and I don't see evidence of that.

LKP folks, is there some NFS on the test system that could be in play?  I
see that you collect nfsstat output, but I don't see that output in the
details.  Is it possible this report could be an anomaly?

Ben


