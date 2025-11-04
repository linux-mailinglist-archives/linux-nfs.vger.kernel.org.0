Return-Path: <linux-nfs+bounces-15993-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3353FC2F66A
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 06:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25E03BFC7D
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 05:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CD52D24A1;
	Tue,  4 Nov 2025 05:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8CeKwjY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CAE285C85
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 05:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762235319; cv=none; b=UG23zB0cdBNY16ws++UlhJ85CcBfpE9PBQWeYLhzt3cK6saTUJiRhX1Iqkh/GPkCrfjnuJxqcNOhOwWHK+o4WRBWNYf9B50Gekqr3fX+56fqxp2VV51UMFvQpH17TQYOrBWWyzw24CWAB2A4ydCqC3COwql/tLaUiZL12icKT4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762235319; c=relaxed/simple;
	bh=3vzY+wIaFc1j3VMUhWuguSg+P+gvqSRpIeuLV55E5jU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=NHuJgjLxmE6meZYyuRFnOzF+YmXPggWnbPPkGgQpXzX8OXekwDZzw1m2WakRJLgCTgOR3Ar4Je0Brl9kfMXlAwE9O7/kVC8WqCPoQgaQVrA9vVy1dweLiUORM2P007q5+Zhjj2obO1beI4F0mMkj0mYzZsax7B5iV20Z04LDlPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8CeKwjY; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64034284521so8875828a12.1
        for <linux-nfs@vger.kernel.org>; Mon, 03 Nov 2025 21:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762235316; x=1762840116; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KieIj+hbKDwxME8Dz4DyoaDfYpGeaMwf55ca0PyHRKM=;
        b=N8CeKwjYxl/MAGacXvUnRUdLMR0qAOWXeD4mUuvSIBxI2fPYEGQvPDsSMGdbmYBKoz
         QhGWyP12gJ0N1LkZnyP3sRr7vp0pAdrRvBHQSevq+Wsi8rgR0lAg4mqZ2PtQ0mHwzqJO
         8pp7ZH9OyeLFeS0SNuIGgShyGPoBVVfDvDWo1ySPm7xLDsw0R4gxrk0cQoZdIe6Vwitf
         tKDk4xoVoutUp+8uyq7Rb0GR3S6hcVjQH4OORj1WRVxaj5Ekz5FJxgQuAwy6XNGnjcHb
         Kw5V808SsePjdRHNf0VOXwXvyGPQrt9D+M3Exu4WL5OkKBxWI+ChkLUCCxSHVH1B6FqL
         uqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762235316; x=1762840116;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KieIj+hbKDwxME8Dz4DyoaDfYpGeaMwf55ca0PyHRKM=;
        b=RW4tMFx3ipmowEVdRasPKVd3bXKLOYTwmHBJkYB0j+6bJvYF0L7LefWl4SqTNyGhVv
         RIaha/I8BhfjWdo3/671v47nTZG5P77ULNd102fTFAxXwtcj2hTHb8PEWyHinUIP+L9Y
         o75+k+ChsXGBPLbmJUoV13cNlPEXpx9ObbNm7kUiii/b2RLmOu+d8uuv6GiSPfUHHUuI
         cDthEyiG3MHN5nZJCQHkC3uuv5vOI9FVncNaQpszTXjnFTIdGJCfsCJpqsaB3AgiPpWl
         OPSBCUwRcqABgq4g2A6zRIxYov+j15Y+Yg6/OhTuJ1lJrcy6XFrV6GlHPcaqhVcO4+qg
         JLpw==
X-Gm-Message-State: AOJu0Yy2Lafu19vvUngutWBZjsF0+LU86IislbjlRzgy8TsrKdpQyN0d
	zKuGZ7im5laAx+dar8g0cPnCI1o7C/msplkWrJuogWHS4JCtMGWPQ48EvEdUUeW6NoEstOvGxmb
	BjEIv6aMOqwHRP4jnUuxmYGxCg9XegGZlxQZ1
X-Gm-Gg: ASbGnctfp5op9iB64I7fgtEQhGvRoHoshMApMjUJg9+QKseps+ByXl7RM7KF36Ygu0i
	PatJBcpRORrUlr7BHbjsxKDD8K6v/q8BlC8Uw48Ku5X0UzllAPjKEPEIE5VEIg++N3MC1XmjHGF
	ULUYRF+SwwVtMgnBYO4OJFlOrTg0oScCMuwhKZB5pWQCr8Ixv80dJyBmfxx1VqGMHEBHYyv7IWc
	Cx3Jlsx6wBMTzAuYAKYNjqHd5qeF9naThMs4a3uUNYDpr5852lpJOoK9Is=
X-Google-Smtp-Source: AGHT+IE6xsD9A7Wgxb+W0kzxM2hOcqTdA+WxMBqHI6wjrX0QKEc69fY7oqrRUS6jvH12z8jloAsYjIi89z3lz2Eny+k=
X-Received: by 2002:a17:906:ef08:b0:b6d:5363:88a9 with SMTP id
 a640c23a62f3a-b70700b362bmr1449620066b.9.1762235315247; Mon, 03 Nov 2025
 21:48:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Tue, 4 Nov 2025 11:18:19 +0530
X-Gm-Features: AWmQ_bm7-Hh2iNJsqnVefFaFwqKHEdFUh3Afd9837Y7i2ZSpxAgNiprwvu-Yw2Q
Message-ID: <CANT5p=rmuH59F9dpvrop0f+8XfVnK6fZHyqLhb10UsYfa6XJgw@mail.gmail.com>
Subject: Requesting a client side feature to enable/disable serialization of
 open/close in NFSv4 clients
To: linux-nfs@vger.kernel.org, neilb@suse.com, 
	Bharath SM <bharathsm.hsk@gmail.com>, Trond Myklebust <trondmy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Trond,

Several months ago, Neil from SUSE provided this workaround for their
customer to allow the NFS clients to work around a bug on the server:
https://code.opensuse.org/kernel/kernel-source/c/d543ea1660582777ca7f8a8f91afd048de09b7b6?branch=377837fd53dbd7a6c35cff41d5c42ab1224512b0
However, I see that this change is not present in the mainline kernel.

I would like to request this feature on the NFSv4.1 clients in the
mainline kernel too, so that we can have this support in all distros
in the future.
This is a useful low-risk change that will provide a fallback in case
of servers that don't implement this scenario properly.
Let me know what you think.

-- 
Regards,
Shyam

