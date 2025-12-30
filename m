Return-Path: <linux-nfs+bounces-17359-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2861CCEAD9C
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 00:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1EC3300F31E
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Dec 2025 23:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B430242D9D;
	Tue, 30 Dec 2025 23:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="MCgpFzpu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AH6bGM6+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8402165EA
	for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 23:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767136698; cv=none; b=bK++ieODvLbPQ3arSO22tlZbcsa8qLxQVpqYUAxJbwccXhjcPqhYtyszVNXf6C+7yxMYPGX8qDMSZZfMtJad+nHXtmQW5g8+H2vzHEmqh3rPKzPpGracp1jF2KI7Imp5RNgZg8V8E4tRAUmQ5e3vSZdh5+QqoucoPdxnOhwlVLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767136698; c=relaxed/simple;
	bh=lPbuU02gPK5K1UhVIYkNwsDvsLvsb26SK/vsFjYAUEk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=TeX3PHvhmvm5H8CUMYT1lGF6vt9IGCBcvthnSrg0jkzg9pESB5sTdjdSW8Yf7JH2ai8RH7Ss0BFEqIbQUPwtz0FNFzcocrPfvJWOxbSKVYkxAPtSNRSryn8xMfDikyVq9EOkJfQDbZWh4AZchOGY+K728oYv38ickD25IQyrIMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=MCgpFzpu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AH6bGM6+; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2F3047A00AF;
	Tue, 30 Dec 2025 18:18:16 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 30 Dec 2025 18:18:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1767136696; x=1767223096; bh=54I3nXFiuB4cXceXzghWoDzWSj64JEv/QcX
	S3/PCQAQ=; b=MCgpFzpuH1pgvHIFl4iSIbPWP7WZXGQtrC1t87ZvFLxmjpl9sQ3
	WTG4lDLF+7iDHzmuaE3dH+yYfIMdAxEMQqMpxPfHeey9Q6sPvAClP5yW2WxiA6DO
	/H2HvrEqFrbd7Clnq3NaVS/atyNj/2URb6bQfcBovoGUZMtxJ6COQO4t9FzSCrSw
	3TUhg+kQ+r1rtoV3FMhjuTYtgqAtcE4iwkkJ5fu1dalxPAUkTNk58XQkmobDNF8C
	Qv6mKvQGL6FAFsXKw+NUOxixTqGxIvRv8BE0fPUAiDy2MZ/cPVEjzd0U3lpl48b2
	ABfq1sy1H6AfLFIvdqjlzm9XAOO7z5LOnDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767136696; x=
	1767223096; bh=54I3nXFiuB4cXceXzghWoDzWSj64JEv/QcXS3/PCQAQ=; b=A
	H6bGM6++8r+uk21xNe+K7gouG8BRTa9KIYXI12Ka6yt2oP/Z3ChSxA6Hdws50kCi
	oKpQf2WNmjfWTkcgr/2muHr6B4dKFcixgc6XRPs76pv2fYy5n7WTqOWN0d6Vw3Bk
	mqNQxTgf6wZJJxROozOlaDUU/SAsbyGZoD6fJYCLHQr5/yS1BXxzlrwEWdIg+mbB
	wfFUnqLQW1/hTdQrIuJeEHu82V0BEY57+spWoDN9JnQt5F2PiQtzWxVn07XoG/VO
	Od0g03feKDPlD0uQVRruB9Eys6hcIcXUgtt7ZR4Q3wegmayK2ZaqWcRSRUQyBp5f
	hA7k3Mi1rmLH9C0Tr0ThA==
X-ME-Sender: <xms:t11UafVNCtvA-25Li4BB8m9QrmV48HGqiKH638FxRPJccP4DbLbYmA>
    <xme:t11UaVIrjcTY0r43fr1g6J6c4vM8ODTfhD6fnXc6__TRC8K3QomVMLkNzTZa98hBg
    nhS4UWAD5n7cSV9QM4C1DAP6QbNJRVgE8yg_fqXl4uqpjjpqg>
X-ME-Received: <xmr:t11UaR2MTh_MMoMK7PSxxKkZ2A9KJt49Qf8i-ieUe54O-VRdQTcHZTkfKseuVq5AY5YDEzcKORGs8jQE4GUgKDJ56Oja3922678QpOmCoX4o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthejredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    duteefhfduveehvdefueefvdffkeevkefgtdefgffgkeehjeeghfetiefhgffgleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhi
    vghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvg
    drtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvg
    hlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:t11Uab6KxH4-6jAhf_JtQGvjMeQMjGtgL7n62jJ8kWJWlMPpBXcoHw>
    <xmx:t11Uaa8my4suy7Fp_v1Sd4IW1daLq0XWK6PcfgZxum6rTbhssu3f3A>
    <xmx:t11UaSUOb-mR4r_lIxmRADOuy9IDfrGju1yw5zSaJIgSbEWAZUL40A>
    <xmx:t11Uado-g9lEVw-BTZ9rNl7kv78xF4JzLLYBE21BDOJutLtU52pj9g>
    <xmx:uF1UaaqFs-qlnreYbHvPxCPCZnq3QsmfKNtqQ_mMnQxDu2tm2r78_UuX>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Dec 2025 18:18:13 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 2/5] fs: export pin_insert and pin_remove for modular
 filesystems
In-reply-to: <20251230141838.2547848-3-cel@kernel.org>
References: <20251230141838.2547848-1-cel@kernel.org>,
 <20251230141838.2547848-3-cel@kernel.org>
Date: Wed, 31 Dec 2025 10:18:11 +1100
Message-id: <176713669193.16766.11542285794353517327@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 31 Dec 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Modular filesystems currently have no notification mechanism for
> mount teardown. When an NFS export is unexported then unmounted,
> NFSD cannot detect this event to revoke associated state, state
> which holds open file references that pin the mount.
> 
> The existing fs_pin infrastructure provides unmount callbacks, but
> pin_insert() and pin_remove() lack EXPORT_SYMBOL_GPL(), restricting
> this facility to built-in subsystems. This restriction appears
> historical rather than intentional; fs_pin.h is already a public
> header, and the mechanism's purpose (coordinating mount lifetimes
> with filesystem state) applies equally to modular subsystems.
> 
> Export both symbols with EXPORT_SYMBOL_GPL() to permit modular
> filesystems to register fs_pin callbacks. NFSD requires this to
> revoke NFSv4 delegations, layouts, and open state when the
> underlying filesystem is unmounted, preventing use-after-free
> conditions in the state tracking layer.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Seems reasonable.
Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown


> ---
>  fs/fs_pin.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/fs/fs_pin.c b/fs/fs_pin.c
> index 47ef3c71ce90..972f34558b97 100644
> --- a/fs/fs_pin.c
> +++ b/fs/fs_pin.c
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <linux/export.h>
>  #include <linux/fs.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
> @@ -7,6 +8,15 @@
>  
>  static DEFINE_SPINLOCK(pin_lock);
>  
> +/**
> + * pin_remove - detach an fs_pin from its mount and superblock
> + * @pin: the pin to remove
> + *
> + * Removes @pin from the mount and superblock pin lists and marks it
> + * done. Must be called from the pin's kill callback before returning.
> + * The caller must keep @pin valid until this function returns; after
> + * that, VFS will not reference @pin again.
> + */
>  void pin_remove(struct fs_pin *pin)
>  {
>  	spin_lock(&pin_lock);
> @@ -18,7 +28,17 @@ void pin_remove(struct fs_pin *pin)
>  	wake_up_locked(&pin->wait);
>  	spin_unlock_irq(&pin->wait.lock);
>  }
> +EXPORT_SYMBOL_GPL(pin_remove);
>  
> +/**
> + * pin_insert - register an fs_pin for unmount notification
> + * @pin: the pin to register (must be initialized with init_fs_pin())
> + * @m: the vfsmount to monitor
> + *
> + * Registers @pin to receive notification when @m is unmounted. When
> + * unmount occurs, the pin's kill callback is invoked with the RCU
> + * read lock held. The callback must call pin_remove() before returning.
> + */
>  void pin_insert(struct fs_pin *pin, struct vfsmount *m)
>  {
>  	spin_lock(&pin_lock);
> @@ -26,6 +46,7 @@ void pin_insert(struct fs_pin *pin, struct vfsmount *m)
>  	hlist_add_head(&pin->m_list, &real_mount(m)->mnt_pins);
>  	spin_unlock(&pin_lock);
>  }
> +EXPORT_SYMBOL_GPL(pin_insert);
>  
>  void pin_kill(struct fs_pin *p)
>  {
> -- 
> 2.52.0
> 
> 
> 


