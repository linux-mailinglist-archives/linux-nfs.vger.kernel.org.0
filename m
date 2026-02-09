Return-Path: <linux-nfs+bounces-18808-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJPDA49piWks8gQAu9opvQ
	(envelope-from <linux-nfs+bounces-18808-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Feb 2026 05:58:55 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DE710BAE9
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Feb 2026 05:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DFE830071D3
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Feb 2026 04:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A40274B48;
	Mon,  9 Feb 2026 04:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2Ou/SDb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28A91A9FB0
	for <linux-nfs@vger.kernel.org>; Mon,  9 Feb 2026 04:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770613109; cv=none; b=oafMZMlwH0c123UgVZelFODiXwQ2SnnuocJxC07qL6qcqLGcAvJhcCLuPU7KZPXRtwhupDGSY1UzI6m3KsAo7nzGGkcnHAap1YRunjghGNBm9vZjkA98iOUoeroeUoDnlOrMyEwFzAnM1SFmZmA7hwY/ZlNrVGe2YNDhWT43dpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770613109; c=relaxed/simple;
	bh=kBBRCIEGOxP71duR9Pdkyw6icI+O41FhThI+xmeNQyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DebXjtJclLFPzfhjq/q4zLmwTToQPaSoOVCQIq5XXild2k5Cj8u9bsxFDTCTVzKNce5vx0jOItpirBBEXIIw8qMQebPfS2RrWpTjb8d1auAbugKC7UZqo0lWOgDnS9VaZg29lXYv+Z3/K2A/FRj5Y+IxGjst9PJXmX8ZRBD1ao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2Ou/SDb; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43767807da6so649399f8f.2
        for <linux-nfs@vger.kernel.org>; Sun, 08 Feb 2026 20:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770613107; x=1771217907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4peVNB+5ELYTcHmDpzvkLXgbTr9tYPUTjyVW9rxozv8=;
        b=M2Ou/SDb3JlBres7u+FI08FLc+5RxjpFScUBVas3Z156Gh+M9lam72UDYdTT64k1PC
         xj86hp28oMUOZbX4PAZwQJEUYvTVklybKdQkBRH87EvJDb9WZULF9o2jD3+KZ3Rtam4F
         1LR4475fCwXkLXu2nkzjwMj/kPKFSzIssS3GMqR1EIuM2WBgrEoRnI5iBtbBlvU/dkMJ
         As6zESs4jsjBLWTjSy+A2FwEi/dNINqf3gnYZtvTqW4pRwJJH4fF/e8E932IzGxjklgP
         5g/l2EUZcDXqUBIq6TxmqwPmIfpSauOQriCn7L5syZgD3/jWVyfPv5R9YU4d9PMIS/Jk
         T3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770613107; x=1771217907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4peVNB+5ELYTcHmDpzvkLXgbTr9tYPUTjyVW9rxozv8=;
        b=Q2jFRnID7pZqG/gnP7u0NuaC7U6na9WkQVA4V90yucFsS6PquL8UWNCd1cOONM8Ob0
         bT5/lhT4imNTeIN2nn8T93VkkRTnEO7VZhkEMhWAJKu/ObgG8pdLPqQxTU7IM30HsFsB
         HLHOi1ND0gnDyzbnMoerEbMJdPSBhJpNT5AnPCwKie18tWG46bOdtBapPiBFjyIHLjnd
         6eo6272gP+23J0Mj9vDJ4pVf2y6aD9ZDA9GUiWysCah/6JgyODSMtg1zXwNHHJK6ddeA
         wdE+rRAA5+WStyZQjHvZ/lH9us4Mc1tFqDZAHUpvqGMUiOU05XWg6xgF3SyH/XPnuGAE
         5PVw==
X-Gm-Message-State: AOJu0YyYvo2iHw5rP9kXNEyZzCIA7vxmAY1zFtgM7EFURIgmXphaPRnf
	teEGutaMCCuwLsVkx3z+XnzDub8vqz8JvoNzTL4CCjVeHFS9Z/0+gvBaazaNvM1c
X-Gm-Gg: AZuq6aI2Zi4Ydf1ckCh3Eg1ij24Zwvntj7evqBtVuhvlmXyxxg0XRlG/0tJHs2xoPee
	WTr5vVCgwi9JrT4uuWK8nMjm4RwG1cAzj4EsmC6tSoN9AwGc2NVnfmi+PIazykJDtRUsdz1EvPH
	+rlef7gxN9ZPOme1TwztpmEp8sprg85MATr7gY7kifqIF9o44dAbw5JSoKT0ymu29AFQKKtUuAm
	Kd6AAlZe5ydvVBgAIH24P/giZeHEPn1+9lwyAUSLx3HR3VQs5wOvxjuG+zopm3/P/qCENii5fAG
	JjCiYPb1i3/g7u8xHsyxAFa6Xc+OuWilx7DLE+OB4cXodRKnVcnXqCB/AIWuyzr48ZpUMaSR6t/
	YM9fa2pDWXwEfaJnPo8YpjjKv64kuz9ZM/gCFlVzpOWCKOy3H1DMxOcXP1EOrhqJ3YPS6IVMgls
	hWpEucWH4L16CkZzgZMXpn+zy7qB6RRYx1/dFgc5mxQk7mRuwi3jQ9XGM=
X-Received: by 2002:a05:6000:2889:b0:436:1a24:df81 with SMTP id ffacd0b85a97d-4362904b702mr13678811f8f.2.1770613106865;
        Sun, 08 Feb 2026 20:58:26 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376a78d796sm8070092f8f.20.2026.02.08.20.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 20:58:25 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 587D7BE2DE0; Mon, 09 Feb 2026 05:58:24 +0100 (CET)
Date: Mon, 9 Feb 2026 05:58:24 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Steve Dickson <steved@redhat.com>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: ANNOUNCE: nfs-utils-2.8.5 released.
Message-ID: <aYlpcPkq_glykQvJ@eldamar.lan>
References: <fdf3631f-e924-4e4c-bd9f-db5b40a90bfe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdf3631f-e924-4e4c-bd9f-db5b40a90bfe@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18808-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[debian.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carnil@debian.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[eldamar.lan:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86DE710BAE9
X-Rspamd-Action: no action

Hi Steve,

On Mon, Feb 02, 2026 at 06:45:30AM -0500, Steve Dickson wrote:
> Hello,
> 
> This release contains the following:
> 
>     * Man page corrections
>     * min-threads parameter added to nfsdctl.
>     * systemd updates to rpc-statd-notify.
>     * blkmapd not built by default (--enable-blkmapd to re-enable)
>     * A number of other bug fixes.
> 
> The tarballs can be found in
>   https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.5/
> or
>   http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.5
> 
> The change log is in
>    https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.5/2.8.5-Changelog
> or
>  http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.4/2.8.5-Changelog
> 
> 
> The git tree is at:
>    git://linux-nfs.org/~steved/nfs-utils

While 2.8.5 was released, I do not see yet a release commit and tag in
the git repository, is this correct?

Regards,
Salvatore

