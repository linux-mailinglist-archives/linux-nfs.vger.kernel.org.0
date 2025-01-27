Return-Path: <linux-nfs+bounces-9693-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6225A1DBDA
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 19:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1F1164D95
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 18:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA2118E37D;
	Mon, 27 Jan 2025 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="DjcEO86d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD39318A93C
	for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2025 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738001137; cv=none; b=uvF88Z4DS+vYil8fyb64MoD2N3pOxftYdsvKKj5+VpT+FSPIc+1cK6aq7km4yF2XGx8Ll65QzuJ+dGhdyM9IbH6iOCe2w55TspfNFbj3zCgsWstyZzcK8r9dhiyczFaWIiFrwOYCvDtqxz1aPlf0iTPnpCm2qqkrhaK2N4slqWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738001137; c=relaxed/simple;
	bh=BEsb6n9siTaP4x7qFV/R66om8n+Tzywea90SydC5C44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6R0wF4gUauK13IuTOnuxhv7s+gNI2n1jezY67ICjJyyzhGihT5jW9R6UChmpUt/Ryv9rCXfz7kB3wHNdWn857xMUgo6Rny5aPhJI+RlVciR7L5ZvYKAcViRlKhkpCewG9X5rlP7zfMkEW7bMW+zv5qpGIGWI6KmAPSlYAKkReo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=DjcEO86d; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b6e9586b82so417849485a.1
        for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2025 10:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738001134; x=1738605934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMDn01SWIjmfdhQcwUIs75izjTf9Hnbhitqkx9MGjr8=;
        b=DjcEO86dDG+nK02pcFEjZRpNhTXqYRYWF0R0TQ/xldO+P9mKnndPEHX1lF4mM471Cr
         89gAabhK0KjKTQ0xTiekmEGyzVanbzJ9dlJp/gw3ihgSc7Gj79H/Xt1xdF/mHon29PYF
         OypBAZm2MH7hOXpHogXOIZS6oEm7YoA0j+iBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738001134; x=1738605934;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AMDn01SWIjmfdhQcwUIs75izjTf9Hnbhitqkx9MGjr8=;
        b=SN8Yet8mQ65as5XdNl7TOZO/G1VI4E7Pm7b9bQLrZXcx9+M+P/PmQfbq7rp57cdZT1
         GcQiNDdR0NdtkUcV2a2xt7gXuQdXDXN86ioeE24P7wHcasIzAQPtkB2lOvauS+Pk74fy
         qJCZu3XO3vX7di3V8ytFbVKZ5ppSllaAfqIMG7XGeT8JR5+0FoYx5WWMYc0rS+PRrlVt
         BM31ncDlvTPgJfdwGtbzKkt8PvhCpw/IQ6/BJ64I9uVrnuXXIWKJ+H0EeuFPl5HcZSRJ
         I/xxN7CIU1ajOfRQSQOjUOEdNMHoqtXWFRGfoUM0BHZkV+uUQ4YgVeRrp84ffwm28b7P
         r1sg==
X-Forwarded-Encrypted: i=1; AJvYcCW/LXzT028qYtzMb0yKX0jlBMOdu5Qmg+9kCGB/fguw24zWAFha0jNQo5yucl9B2RFXVJvnjFovPug=@vger.kernel.org
X-Gm-Message-State: AOJu0YytcShtGEMxQ9kaOEAQM3khatfgF7SHayOI5PIIZ897kLtdb5XU
	Z/XybqsVWoDGqKTLgWoT7j4hE3lX0gvF+HLUAGHz/+m1RHkfjA9KWsYPKHhlitc=
X-Gm-Gg: ASbGncsI7bAhDzyxr9V2vKjKd37dmbbkLzAcc96RkKHxDTFlkzTxt2LvOIWGV8NAf9e
	T4xYmpKltwZir1cc7vsFeuWzhuhddnSfvNcS/6NVMpQvGTIJl9f2HShn0zRkC787Yqzv7Yr0pvA
	u5T94xVYXbwrmxXuDE8mE415vK0hR2WpG6VzrBha5VowsZa62bQ57AcnPPmAwDzrqUtDONjpP8i
	hJj8/ORslQ16rz0mIF2sVEkgNIdyQv6bjAqY/jYAa9MCqXNhlSbzxmFp3zS+20fl75aB461RTkg
	kLQwQ3UjV+j0WACHcwSULtqPuE0kenGfVlmxsiETF06i6sJp
X-Google-Smtp-Source: AGHT+IGyYeeR4TsA+WdrCQYCr/8+qk1j+5VwubRGe5d2pC8iYUgJlAW0YwezLbYdTJ+RcwEWCyf2Yg==
X-Received: by 2002:a05:620a:14e:b0:7be:6eb1:f4dc with SMTP id af79cd13be357-7be6eb1f594mr4305704785a.51.1738001134568;
        Mon, 27 Jan 2025 10:05:34 -0800 (PST)
Received: from LQ3V64L9R2 (ip-185-104-139-70.ptr.icomera.net. [185.104.139.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9aeefd88sm414259285a.77.2025.01.27.10.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 10:05:34 -0800 (PST)
Date: Mon, 27 Jan 2025 13:05:30 -0500
From: Joe Damato <jdamato@fastly.com>
To: nicolas.bouchinet@clip-os.org
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-scsi@vger.kernel.org, codalist@coda.cs.cmu.edu,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Joel Granados <j.granados@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Leon Romanovsky <leon@kernel.org>,
	Zhu Yanjun <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v1 0/9] Fixes multiple sysctl bound checks
Message-ID: <Z5fK6jnrjMBDrDJg@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	nicolas.bouchinet@clip-os.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
	codalist@coda.cs.cmu.edu, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Joel Granados <j.granados@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Leon Romanovsky <leon@kernel.org>,
	Zhu Yanjun <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
References: <20250127142014.37834-1-nicolas.bouchinet@clip-os.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127142014.37834-1-nicolas.bouchinet@clip-os.org>

On Mon, Jan 27, 2025 at 03:19:57PM +0100, nicolas.bouchinet@clip-os.org wrote:
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> 
> Hi,
> 
> This patchset adds some bound checks to sysctls to avoid negative
> value writes.
> 
> The patched sysctls were storing the result of the proc_dointvec
> proc_handler into an unsigned int data. proc_dointvec being able to
> parse negative value, and it return value being a signed int, this could
> lead to undefined behaviors.
> This has led to kernel crash in the past as described in commit
> 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in vm_table")
> 
> Most of them are now bounded between SYSCTL_ZERO and SYSCTL_INT_MAX.
> nf_conntrack_expect_max is bounded between SYSCTL_ONE and SYSCTL_INT_MAX
> as defined by its documentation.

I noticed that none of the patches have a Fixes tags. Do any of
these fix existing crashes or is this just cleanup?

I am asking because if this is cleanup then it would be "net-next"
material instead of "net" and would need to be resubmit when then
merge window has passed [1].

FWIW, I submit a similar change some time ago and it was submit to
net-next as cleanup [2].

[1]: https://lore.kernel.org/netdev/20250117182059.7ce1196f@kernel.org/
[2]: https://lore.kernel.org/netdev/CANn89i+=HiffVo9iv2NKMC2LFT15xFLG16h7wN3MCrTiKT3zQQ@mail.gmail.com/T/

