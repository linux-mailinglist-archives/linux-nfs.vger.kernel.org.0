Return-Path: <linux-nfs+bounces-20060-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EckBo64smmYOwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20060-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 13:58:54 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 840FE2721F1
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 13:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C6E4314CDAF
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 12:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA483C4546;
	Thu, 12 Mar 2026 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fHqxjqGD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB37D3C344F
	for <linux-nfs@vger.kernel.org>; Thu, 12 Mar 2026 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320257; cv=none; b=JON+Pb7i33p9m8oY00kNGKx6ZAxqATDt10bY5Dw/foK0h++3DuQDHxtze5f1D5UPabRF7GWP48OAT+++JwOLnH6FcLEaXWcJdml2C6/+vuZm5ttyzwCNAs0/3Ia8TLBJ/7n319Vfj4sgAhgrLXpHhCq6O5T3Ovncy97iaTDG1cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320257; c=relaxed/simple;
	bh=Rr1jkAP22lZkLvo3o90a9fRSWh9+kilNKtAarSScWFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJI5n+aVpjQyl0zTECMn/uIU6ubbfYsRMb82XyHZsooEhpwafpnPgxIkxdDVA5Y8wssuQTaS9lpwWvtgNNREuhlLr2mTtySVQdr6OHf4VFR5yeCIb683M56l7DxJ4QyFKaJ4cKA1Oa3gMX1QB9uHkZEp6YHulz7rUS+0ja6lkTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fHqxjqGD; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5094b54a250so5475741cf.2
        for <linux-nfs@vger.kernel.org>; Thu, 12 Mar 2026 05:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773320252; x=1773925052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J1SF1XBHkHR0j7NZVucv0LxpGoGXl67PUefLsfwpAbo=;
        b=fHqxjqGD7mReR8MT2yBowt9MuNKPAKQc++mWcb4ZOttX6YldICO+OnnxWIQjO0C8L5
         wjOw0Gg7MqV4U+G9pES+s6h1NtZIjaKrBXMW81hrLyc8SxWYHtvQK3FlTjqiyroZskXE
         jYj0kUENL7Yhu5zg+0UQ91XYlYYlozX9U8uAqBEFaih0fSnDo8kprjTDRYJ58gzKRExo
         MSUW+Q+e0P2WpZGotx0DuVRaUqq4vGsUUSX1YbPnOxmRUKlXFY/aNRmXMXDbAEfx0Lnn
         e41FpuPSZjTSuTkWfTMW8e1MvewVXC2p6zLd4GrSZjvSKS4Q06nDQYaSimUW3qR5RhoY
         JV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773320252; x=1773925052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1SF1XBHkHR0j7NZVucv0LxpGoGXl67PUefLsfwpAbo=;
        b=urDB+2OylFcUl3XQUHoLITQsJDg2hyLHPYg31A3gsDgQbgoh0hkw+yYl1NLUFMToHD
         IZyy46Tn2cpZhuxNN9gMPBlR5rmobMVsIVx6J6ELFKpgMIBnF7P7RUw7fFzfuAJuj5Aa
         lpxA1xJb1dKYUuv3D7m2XB5sOIUgmobKNM/Qt5i3aevJn1QPTBkW4veXttDhhokecKAh
         woJeVT0dj0wIxUxGtDJuufssGRXv+xnU+w3ofjZSryZPrC/0KSxRciOsa+GMclpoRaZb
         13qJczFktJ3cw/+BNCsrzNJxxrrZi2SLTZjVDvHYLZwXOoJXVSumGFWEr3b1QiQ8GQWT
         JJJg==
X-Forwarded-Encrypted: i=1; AJvYcCVZpCLEjliPun4onZVrqCI7EZS8yqHyLNCuNQA3up4ErD/QxXqL8iNldikZ8KeYR2YMrAXIEY+pBJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjhQApEj0RYvKzcZTYkC1n5wbqCaC2IJsVjmWN8ffSqhwp7Anw
	mZyhHErbnKK4klFxW+9Je+i+f4EKSrms6OrUnokb/vrRvRx/lqSmsw8n6bNOLn0XVFk=
X-Gm-Gg: ATEYQzwi2mUYKudUFssmdv7FPkVBBlXVv83qZJ5EEzigLfuQ+aS2t81uNX7csZ36WXH
	SNkDEG9KCctJ7RAjd89dmAHVH/9Qr2n0VhIjPTDm9MKeIfFHq82CGKXJ9Xks4LZ2YI6/FzAMSjI
	5LiHb8iL/P0RZNotPMDvcXE3K8Q4I4ff5N8tqbeRGbGFhJZCkjvDrkod6+WYvb/LrsaMovDvRMO
	TxAMHeCYBMj0nyLs08zEkaipcJjpNhxLyXYRFf7clvYk7IZX080NaeauZPyTqkYi8vvcjEXUaVJ
	wMtZB+dkLQvxjMUk4srNI9yozP8w3EKTTmY2DSkwZLt30FL/7yG6//KNDnERdsHpp+bnHgZM7bB
	7TeAlGoWqK90b6hLb9FFeel/WjRSde/h0MpytdnNtJQu6NvQlbk1hm1TY4vhHWv2P9rPPNMsaMq
	Xk1GS7TOCsNd2A9C9/ZEbktkAvrg0dl2IoO/Pc2PPWdH8sKF1jBh2nH8kJyce5sTCzNYkElkRZG
	sVuvQR4
X-Received: by 2002:ac8:5d4d:0:b0:509:cbc:127b with SMTP id d75a77b69052e-5093a1bd58fmr77950521cf.60.1773320251710;
        Thu, 12 Mar 2026 05:57:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65bd318fsm33341196d6.8.2026.03.12.05.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:57:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0fbW-00000006fKD-1POa;
	Thu, 12 Mar 2026 09:57:30 -0300
Date: Thu, 12 Mar 2026 09:57:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org,
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org,
	ceph-devel@vger.kernel.org, cocci@inria.fr,
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev
Subject: Re: [PATCH 00/61] treewide: Use IS_ERR_OR_NULL over manual NULL
 check - refactor
Message-ID: <20260312125730.GI1469476@ziepe.ca>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <abBlpGKO842B3yl9@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abBlpGKO842B3yl9@google.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	TAGGED_FROM(0.00)[bounces-20060-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[55];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:dkim,ziepe.ca:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 840FE2721F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 02:40:36AM +0800, Kuan-Wei Chiu wrote:

> IMHO, the necessity of IS_ERR_OR_NULL() often highlights a confusing or
> flawed API design. It usually implies that the caller is unsure whether
> a failure results in an error pointer or a NULL pointer. 

+1

IS_ERR_OR_NULL() should always be looked on with suspicion. Very
little should be returning some tri-state 'ERR' 'NULL' 'SUCCESS'
pointer. What does the middle condition even mean? IS_ERR_OR_NULL()
implies ERR and NULL are semanticly the same, so fix the things to
always use ERR.

If you want to improve things work to get rid of the NULL checks this
script identifies. Remove ERR or NULL because only one can ever
happen, or fix the source to consistently return ERR.

Jason

