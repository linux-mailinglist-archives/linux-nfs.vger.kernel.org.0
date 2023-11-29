Return-Path: <linux-nfs+bounces-167-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BC27FD7D1
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Nov 2023 14:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E6EBB20F1C
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Nov 2023 13:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD8F1C6B4;
	Wed, 29 Nov 2023 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="V4PnKbYe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DDF1A8
	for <linux-nfs@vger.kernel.org>; Wed, 29 Nov 2023 05:20:38 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-332e56363adso4199246f8f.3
        for <linux-nfs@vger.kernel.org>; Wed, 29 Nov 2023 05:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1701264037; x=1701868837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bI7/hNZ9e1tpW01zgQ49/HXuDNIAppbOEVGuA1GaKAo=;
        b=V4PnKbYeSQL5IfFKeOeJ7RhhPjxu6ItvDFNghvFpL3Tv39CEV5brgY3qoMEMc782Ik
         IJ60/hjyvJJhR1UGjspbyXEKesQvjYYUVRCbv8DuoTrQoweXA96iXjZ6jxIDoTxhbE34
         7SH2zOqE8JQ/WjCskxjWaeH4da8JY1LxwQeQNpK8+3EbwXjHCyJtSFKKFCyrjDg25W+e
         8YGFJUFZzRJBEIU0fBFL+8Udisu8nvppcsCoxvfzcnQGXomW/3H0kBTtiMITMcrS46gb
         p4+yLPHyiWaRU/ChO5G/Le0xI8d7YLwN9Ry47AewqG0usHLlczjCaj2A5kIuQUF51ARg
         j8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701264037; x=1701868837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bI7/hNZ9e1tpW01zgQ49/HXuDNIAppbOEVGuA1GaKAo=;
        b=GmmqFSI2lvDWPxIz8Rw3WMYHikG3ueOtHKQrdIzScDss2BCPQQ0YNpI0ngA7RDB34d
         6dN2SsGN10JwokfKZmdvxiULr/yvODLDRp1NITH1T3pgJLJKwfsRh0TR6fqZKAZXK2vU
         CMJDhRh+iUDu+F8azqvsifjJcvAmxqPAwAfD0MGE2ssh5vy0Fl1K7uDn/PjfoRitkBT9
         7KRUagXvjrXdt6p/N4Ov/ys92t4r0b2k0iU3NlyaIPO+x7pUjvFqdMj3QqkR1a3LqvCR
         9IxNA7tDZ0zuTw2we/fk2Hcm5ll3bxouPuPBeVRYyA/3W3pLRNzC9umgDQHFRi44r4va
         ejQg==
X-Gm-Message-State: AOJu0YznMB0wvCo4jt9niWJPO3XiQJmLaOTgSKyWJ8H107b3fgGe4EOb
	V2vBTcnAwNG3O54ljjnzEV67jGhrCqDo4mF96n0=
X-Google-Smtp-Source: AGHT+IGwxzmHgxCJa4tFCVNlHYiBQ1eWaN4Z4JJoDrCqROn8Y1id3a5o5lWECQQIaYnf11jsz3jHAw==
X-Received: by 2002:adf:e0cc:0:b0:333:f07:334e with SMTP id m12-20020adfe0cc000000b003330f07334emr3186977wri.25.1701264036700;
        Wed, 29 Nov 2023 05:20:36 -0800 (PST)
Received: from gmail.com ([2a0d:6fc2:6ab0:a900:32d9:b4ff:10c8:b4a5])
        by smtp.gmail.com with ESMTPSA id c9-20020adfef49000000b00331698cb263sm18027080wrp.103.2023.11.29.05.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 05:20:36 -0800 (PST)
Date: Wed, 29 Nov 2023 15:20:34 +0200
From: Dan Aloni <dan.aloni@vastdata.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: mount options not propagating to NFSACL and NSM RPC clients
Message-ID: <20231129132034.lz3hag5xy2oaojwq@gmail.com>
References: <20231105154857.ryakhmgaptq3hb6b@gmail.com>
 <80B8993C-645D-4748-93B3-88415E165B87@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80B8993C-645D-4748-93B3-88415E165B87@redhat.com>

On 2023-11-07 08:46:54, Benjamin Coddington wrote:
> Hi Dan,
> 
> On 5 Nov 2023, at 10:48, Dan Aloni wrote:
> 
> > Hi,
> >
> > On Linux v6.6-14500-g1c41041124bd, I added a sysfs file for debugging
> > `/sys/kernel/debug/sunrpc/rpc_clnt/*/info`, and noticed that when
> > passing the following mount options: `soft,timeo=50,retrans=16,vers=3`,
> > NFSACL and NSM seem to take the defaults from somewhere else (xprt).
> > Specifically, locking operation behave as if in a hard mount with
> > these mount options.
> >
> > Is it intentional?
> 
> Yes, it usually is intentional.  The various rpc clients that make parts of
> NFS work don't all inherit the mount flags due to reasons about how the
> system should behave as a whole.  I think that you can find usually find the
> reasoning the git logs around "struct rpc_create_args".
> 
> Are you getting a system hung up in a lock operation?

Actually my concern is the NFSACL prog. With `cl_softrtrt == 1` and
`to_initval == to_maxval`, does it mean retires will not happen
regardless of `to_retries` and `to_increment`?

I encountered a situation where the NFSACL program did not retry but
could have had, whereas NFS3 did successfully. Not sure regarding NSM,
but it seems to me that it would make sense at least for NFSACL to
behave the same as NFS3.

-- 
Dan Aloni

