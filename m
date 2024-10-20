Return-Path: <linux-nfs+bounces-7313-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 636279A5487
	for <lists+linux-nfs@lfdr.de>; Sun, 20 Oct 2024 16:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B18E2821B1
	for <lists+linux-nfs@lfdr.de>; Sun, 20 Oct 2024 14:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9279A192B62;
	Sun, 20 Oct 2024 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YK7a2R3Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEC0191F6F
	for <linux-nfs@vger.kernel.org>; Sun, 20 Oct 2024 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729435037; cv=none; b=nopPGo5N5Jlnd2/w0UjHLtpEbf97Qh9jzji7TE/80kQ2NAKyzx/6gBDtzzWRBjHOlfEkc0C9Imr6rAOy89Z7ZyGiaxe2Z4g2Kpv2HUYNbw4nE1W9iTAoW9Jw4A+2S6TiXHGU+iS5F1XVWAu5Ac9KJatC6mSNIoEwg4EAXmsbUfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729435037; c=relaxed/simple;
	bh=ySSzI7QCVcvU/R839ZYvwTIcKsazaRzDO64Xv9Z0wug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joivuNHuNBFNtiT/iH4ti9FMZwWoo2RlftJN/4kfmD/yUI/RoaxUlWmynymyXFkcNG/JS2DYfj97+N1KpOFrFjH01befxdzTFQL0f3/x4u8CzOakFL6TXUqHWaAJwmgNSlN3NbhvOeahmw65sshskE8gr3Xjx5b2UtB78pxDPSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YK7a2R3Y; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso541076666b.3
        for <linux-nfs@vger.kernel.org>; Sun, 20 Oct 2024 07:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729435033; x=1730039833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iu88pPuFWYWtQzm6D1/LR4u0smMSQF42C+nFgTHjjHo=;
        b=YK7a2R3YU2TbR1wb3ywuwiUYOTB93ydolf+6D7sGsfdTav+EZzJpGIm6wQCtUafhqL
         xh20QYFNEbSdK267eje0QPckJz2KZzJ0t8scAJGS2iYcWtDhIhQzMo1C6pIVNTALLPp6
         3iEUVbJ0ucmGvHR7CcyteaMuehKnX2wilr9MjcAENGMQj1HZENCkRM3rlD2pZn2s+aiO
         tHdGy62PUrKpa+FPAFBdwKDf/VEo15CGx3vHHoBjB6ADAfBPfMi54lJAmLj7gAm7k26o
         i6U8BEMcLEYbTv8ezfcSYkOCNYv/soyNmQR+yLugUF1lTDGF/nQ547KFsxrgKm9ezX9w
         puOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729435033; x=1730039833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iu88pPuFWYWtQzm6D1/LR4u0smMSQF42C+nFgTHjjHo=;
        b=SrY8YF0FlCrHiUztxyN40FlCKPk99dLBKfxV6uuvlvOWHw7QfE/wSPK2g14FBs2iw0
         Y5wVH3QzAY7P5ynxHPGCDpCxdYhY9MBzOrz2BlLo5LKgJnXo4kiWhnFFcdJSxVCoskPT
         mDD8xOPdPDAPmpGfpdGO6eopz6c3oN+mNMqmVaYCCDHpG6z6bDBgydpFk6+gWsSI+KhY
         pv+JzhHZW8cHvf1umC3cO+bFFu9ZjW6iIe/16ntq0xf9G4P6F+EGyPc1AkD4Siq+wXzv
         6XV+QieVDee+tW5Jxuyqtb9ZaQgkbU8DqpAIN9P3R30UVvTgh3m1lvhcUoioVVz1g+bj
         vy0w==
X-Gm-Message-State: AOJu0YwE6XD4euOnUEIg2cUMPcpLZRd5575mNOVMur+3n5hu+1C62kVQ
	FL1AQev4Xh5Cps10+fjm4v2Wo2wmJXl5/8tWgU9QVeERWPjpTE5K
X-Google-Smtp-Source: AGHT+IFL/BBl+DzMUYLFQovB76dX71sq97aSBNpiVfh4CLDGcYMOusGD+jitQo5tCNkZEOd25wTqPw==
X-Received: by 2002:a17:907:7e90:b0:a9a:4a1f:c97d with SMTP id a640c23a62f3a-a9a69a635b8mr923881366b.7.1729435033162;
        Sun, 20 Oct 2024 07:37:13 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a9159a27bsm95728366b.211.2024.10.20.07.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 07:37:11 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 6A751BE2DE0; Sun, 20 Oct 2024 16:37:10 +0200 (CEST)
Date: Sun, 20 Oct 2024 16:37:10 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: NFSv4 referrals broken when not enabling junction support
Message-ID: <ZxUVlpd0Ec5NaWF1@eldamar.lan>
References: <Zv7NRNXeUtzpfbJg@eldamar.lan>
 <e7341203-c53c-4005-9d70-239073352b2b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7341203-c53c-4005-9d70-239073352b2b@redhat.com>

Hi Steve,

On Tue, Oct 08, 2024 at 06:12:58AM -0400, Steve Dickson wrote:
> 
> 
> On 10/3/24 12:58 PM, Salvatore Bonaccorso wrote:
> > Hi Steve, hi linux-nfs people,
> > 
> > it got reported twice in Debian that  NFSv4 referrals are broken when
> > junction support is disabled. The two reports are at:
> > 
> > https://bugs.debian.org/1035908
> > https://bugs.debian.org/1083098
> > 
> > While arguably having junction support seems to be the preferred
> > option, the bug (or maybe unintended behaviour) arises when junction
> > support is not enabled (this for instance is the case in the Debian
> > stable/bookworm version, as we cannot simply do such changes in a
> > stable release; note later relases will have it enabled).
> > 
> > The "breakage" seems to be introduced with 15dc0bead10d ("exportd:
> > Moved cache upcalls routines  into libexport.a"), so
> > nfs-utils-2-5-3-rc6 as this will mask behind the #ifdef
> > HAVE_JUNCTION_SUPPORT's code which seems needed to support the refer=
> > in /etc/exports.
> > 
> > I had a quick conversation with Cuck offliste about this, and I can
> > hopefully state with his word, that yes, while nfsref is the direction
> > we want to go, we do not want to actually disable refer= in
> > /etc/exports.
> +1
> 
> > 
> > Steve, what do you think? I'm not sure on the best patch for this,
> > maybe reverting the parts masking behind #ifdef HAVE_JUNCTION_SUPPORT
> > which are touched in 15dc0bead10d would be enough?
> Yeah there is a lot of change with 15dc0bead10d
> 
> Let me look into this... At the up coming Bake-a-ton [1]

Thanks a lot for that, looking forward then to a fix which we might
backport in Debian to the older version as well.

Regards,
Salvatore

