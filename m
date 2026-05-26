Return-Path: <linux-nfs+bounces-21976-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENkWKLm/FWrYZgcAu9opvQ
	(envelope-from <linux-nfs+bounces-21976-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 17:43:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 439C95D8F76
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 17:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E7E632E9C1D
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 15:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D087A3CFF5F;
	Tue, 26 May 2026 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="qiOyQfLL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA7B38B14F
	for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807633; cv=pass; b=Q9vFTBwCWGZmsW4FB5E1kLMm4vVnOGW3q9tYBZUPSGDNHuCx1N50eRRxrWG7cCrkyTqp/jOsu/SO2kVDB6850VejQvO4KphKeABGI2OR8Lr2Ik59ZCs9wOQWEi9X5y8okjL2NfhZ9H5gj6FsSdXZKndOHSStiCEv9mBZ7+Xtmck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807633; c=relaxed/simple;
	bh=EvbsFrM1aOZoE9rzekiebiw0GdV7XyQJiZp1BOpUdEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvQ750ZUPh5Caen21KyVtINCVao0RiFVK6Pn55VX9fwPtIjJXZEe3RBknTdb/Er4UhaF9RjwFFYx4QwiO4nCUkUrZmiTz35vH339aAGxsiI4ABjXkaXYudFXnL00u8/V5yrSXOaluRVtiTtrSdNx1/ugsijuNry/ckJPCm/tii4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=qiOyQfLL; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-90fbf21d9d3so1638709985a.1
        for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 08:00:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779807630; cv=none;
        d=google.com; s=arc-20240605;
        b=HfBBQpV7zRxnHp5LX7iUZHDQeNXmNlLVRiybMTsGipYwIywKP6kN86+QiDLOx9kEqv
         0jiqy62uhXM754lhEpSYEt5jjug3KRv5JefM8dRarEpFxQ/3giNEO1dPg6qbVAvevpS6
         A4D8wCs7uK5vQo1GtMFAWXGXg2pbLE0IU9FFrZHLtVxoV/+YBNhloTfGgHyqasO/X0Nd
         XhulsWkWb/RmiBmIoB57DWFp1PVNblnG/NAhfk1nwk/nmaHbm5RmfIO2XD1zbZS0tIbP
         ZmGypqF9CiVqYwyNPn9e+usdLjBskv7AZvuMpulB0nHCXl/M6RaJfkfovmw14RGOe34M
         oJrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EvbsFrM1aOZoE9rzekiebiw0GdV7XyQJiZp1BOpUdEc=;
        fh=mrNVVE6MK02t21AyPhkQ0gEPGi9JwfnWmqr6ac//Ggo=;
        b=AfsmxX9kQblrpxasoxWNn5Mba5i5fvXdb3MHz0vg/TZVCdSo1s9DhbS5uTxmqr1Opq
         Cr8jaW6LVDAL82dO4oAthJTctf9gqGY8mFmCFNdldCdbVlFXVf7m2L1StZbqvGIatTlZ
         BRmEC9P657ehVJD9hBHnde9u6MAm1uH2yqsp0pLaCB7LV/OMIH96smx65w50AlTkObO6
         knkTOQjnG+lvJb0DlBPQVBucZQ0ggliSffSrbsCwd6wNqJ3pZj9BTzpVe6VWF8BY9+8p
         3fiC7YGH5GjnUTsPBPoxJbKRHmuLPwbr/SGRTh+mJNAk6Is/dICcXzeKrWf2zSbNcOWz
         07ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1779807630; x=1780412430; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EvbsFrM1aOZoE9rzekiebiw0GdV7XyQJiZp1BOpUdEc=;
        b=qiOyQfLLvQKJQFdrg3X39/qFxhQHanjRG5XN5rjdJEvvjA020GwKXMmdrbnlt+srAm
         UBvtGirlVxglxkarVFuxih4HyPPjLQOuRQUGmCiEzbu8g/MnqNor84FZTx8p3RvwT3jY
         jRMhAi6WnwmIQlszTYbGFpmfuSBdcQyEyt8Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779807630; x=1780412430;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvbsFrM1aOZoE9rzekiebiw0GdV7XyQJiZp1BOpUdEc=;
        b=ApmQ6BaQGdGhkM2TCtmNvCJYdr6An0clBfbhL2ciFImsbCVjKoCld9HVq7lfeGncN2
         sCWeeoNZnqgNY4TfPQilhrjQ7UvyM0Xal7rtEWNOHO9caHoPEO359fEiEpnCbYk2X+1c
         OFQJ4lFVayZmugHUrlp+U7X251KXQn6I5C5vAHnAAlz5/69xvG1w4vs+DTeCWc3EapUB
         68b3NImfMP6BYPcTr7Ax68SxRhuIYkhDXY72bZuQC8f+X0tYIUKk/Jh93lMMUNFz1kig
         4vx0pHlXe8CXllLwf4gIliKaGNXWeR2LzdEpcewfItOwJABm80dGCWQ+ZKX+c/IHO/x9
         0Wfg==
X-Forwarded-Encrypted: i=1; AFNElJ86sbpRKdFaJgUm6xMDCMGCMDnvtFJf5n1eq3yM0w0anp889v7Xmmv/i7mUO7cU+5yPjCyVUb8p+S4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj95oVD9Px1K5AwuXDsYktuKREz56DDH6c9oXXFp7E2RhsxC3F
	EBTNFwA6ftJXte5ERSqJSr2t9mQMNww9YmgrGH+l6S/zl30agGiGx2GWxWo4VhCzhD439XHb5Qk
	4qgw/N4RIUiWKHlCJB6JBT+gOiFGiTGyYZHofpPoNvw==
X-Gm-Gg: Acq92OEDmAlgasNvywNjLWn67YmiBnodnuhfteOff4+CjWI2pv927IN2VFrdpc2ayLU
	1rWPS+GaZqsffVNa+NurShiQDEDwcdN0n5fiHdAqaqpuSKBZ8MYp4pvL7OlHXZBeJ0Xbi/TsCPZ
	qO21xQfqLakvDbw+5RDwXxBquqyFpshtsn0A2VCQogBxW8qcodQ0ExZbq93++phBycNepk9JQTa
	qOpYwayo2l5483hH5Te7eNP6pUiYYXxDiaUTIbdjwsfKydPMBGV8O8BxYmMJhlSRyV4xLASeLOe
	Opk/9BK+Ck9NdAPa5Daa77KOXd9fKKBdXfUeDCOzegZdi4sLqA==
X-Received: by 2002:a05:620a:2a14:b0:90c:e5b5:65f4 with SMTP id
 af79cd13be357-914b48b5d36mr2776455585a.2.1779807620596; Tue, 26 May 2026
 08:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org> <20260523-b4-fs-v1-12-275e36a83f0e@kernel.org>
In-Reply-To: <20260523-b4-fs-v1-12-275e36a83f0e@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 26 May 2026 17:00:09 +0200
X-Gm-Features: AVHnY4KilITCIvGtFxS6FTciw1vCUm1AhcuYlYRxf5FBmn1jF7w4ka-Ynpxrnvc
Message-ID: <CAJfpeguR8uzC+GdyYfby1LS+HyB=p7=ri3J4aAmUFfZ2V06+1Q@mail.gmail.com>
Subject: Re: [PATCH 12/17] fuse: replace __get_free_page() with kmalloc()
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Dave Kleikamp <shaggy@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, Kees Cook <kees@kernel.org>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	linux-nilfs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	jfs-discussion@lists.sourceforge.net, linux-ext4@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21976-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[suse.com,fasheh.com,evilplan.org,linux.alibaba.com,gmail.com,dubeyko.com,kernel.org,oracle.com,brown.name,redhat.com,talpey.com,zeniv.linux.org.uk,suse.cz,mit.edu,debian.org,vger.kernel.org,lists.linux.dev,lists.sourceforge.net,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,szeredi.hu:dkim]
X-Rspamd-Queue-Id: 439C95D8F76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 23 May 2026 at 19:56, Mike Rapoport (Microsoft) <rppt@kernel.org> wrote:
>
> fuse_do_ioctl allocates memory for struct iov array using
> __get_free_page().
>
> kmalloc() is a better API for such use and it also provides better
> scalability and more debugging possibilities.
>
> Replace use of __get_free_page() with kmalloc().
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

Thanks,
Miklos

