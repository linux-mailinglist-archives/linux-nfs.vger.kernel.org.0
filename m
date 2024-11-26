Return-Path: <linux-nfs+bounces-8220-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0DB9D9128
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Nov 2024 05:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05CF4B24384
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Nov 2024 04:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D555A3D6D;
	Tue, 26 Nov 2024 04:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rx092j7s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3CF14286
	for <linux-nfs@vger.kernel.org>; Tue, 26 Nov 2024 04:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732597048; cv=none; b=QYUFWcBlMa8V+U8HWg9OIb7pUkAZuFButl6GgeLtYHgQPHMPyp9NwW0Jwlo8Un1HY+lk2tSbdqlqIa/CgBcNmVCExL5wHHDUfAcxr2oT8M8QfVXQj9Y8psV8lJpfcsTiio1UF5HUd7wiCYv2bR1PfpXzK0iAmi29CwkDiI07evo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732597048; c=relaxed/simple;
	bh=ePQDDq0MdnwgpTY7vcqVfPVDCtJmVx6hW+jZNsR81TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4vq2MiBFLewS2AyWf389mIaCDeN4USWxT1cOuEZmx+LkdrYZS5mUFDSPbLss0AwT/8BDbXpvdnd4AeOs/JNXUWT663H8XbqpP/ty/yzCS7QRpkERdyfLRpjhKJ6teeFIdVPOHY7l7KVJ4WLdsQrgaIV+6A23L8K7cpGTpj9lsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rx092j7s; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53de852a287so716074e87.2
        for <linux-nfs@vger.kernel.org>; Mon, 25 Nov 2024 20:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732597045; x=1733201845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4t8/9Xf5pg8jrQxQXKV+ssdAhTwN8Sr/Eeel6na+y+s=;
        b=Rx092j7sLnodu3NvOHs/4mAKlpf75IlW0I22o2jjMlZdU7xLVkE/E1yZu+V84oVMnM
         bchEE17j02iJ+bNYwosq/T5/h87z7h5V6zS+76Oc+9jtiz/ECrYLZJscT60hArf+I3Dv
         sJTnq63+yG/gTK4U0PM3x/Tbu6l/slSHl1hYpVoPZe570T81E+KYzxHwLDWCiBKRD9vZ
         sFzz8NIoR6lJus/WzU0TUwD6f0JeGkmrwyjSDRhPDf0EDvCbp0VxyhtOsfJL96E3YQLI
         tkeMhCByT1iIVQPm0gA2moThRYu2wnPk7jqdUhamsADpi/BSstCZv/6Aq6spgz9JPFJ3
         P3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732597045; x=1733201845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4t8/9Xf5pg8jrQxQXKV+ssdAhTwN8Sr/Eeel6na+y+s=;
        b=LDMLAImP7HdqGnM7f9b6+cFGB2qCP4TC0MFI41v9444F+/T/ir6N9g2+5CW+RiDJSM
         cxAMX1qLk7/kVLOSqkV2v0ro3B/pAkDk2nS1FZQ/QFVUMpKZBnysLs9WMqwW+unsPUr/
         55O/cAuSz78m0UlMGjf2Lyuxchl/xueiRf+6nmI7BskPUsRhfYIUUGvxElJK9ix2E4xc
         Or+tms5vePY7GKSxXZVHypfznK0hj633fDCv1dgwszIy9D/O5+NqEm9CCGBBbgt55xQd
         6+9oFeHg8cao6cU/+OayBBB1jdANi9KFjjagClc08UmNEdCgxvK89q3zrgQP82+8KHT3
         DM3Q==
X-Gm-Message-State: AOJu0YzgXteM6s4RMoSgqLJUS0gbpQokZ7AffbX6Q0AXyJizeboIAnyz
	vI83ecWqXjsMhdYnniBv0QDRwbZOwdG7917BLFp8bw9NQgZNYThu
X-Gm-Gg: ASbGncsB+NekePSIxiF7SULeXfldvp7jFjuosPmGNlaFx/k3bT1fB24fMoYbTnfRaSh
	ZmRN834ampP5obuKYOsKS21/MJT8CYPCfV4ToJ9Gy/waNP6vuz6hQ0T65q8LiI9VNZgANOCrIEx
	c/p8v3Piofpd9Su//hcK2PXU+ScQywcpBALA+G9gJ0mS1UeJmIr/VUbPX3pR13viQ44WIhPIZrc
	rxC6hC/imHIAwlIrTez0VMc0w==
X-Google-Smtp-Source: AGHT+IHM9Ax1TlXbhuBpDd1wunrdrXeg6iOR0EqhNy1cHScgKo7QW0ZIsD3p3i2h4aSscAeBGpQYYQ==
X-Received: by 2002:a05:6512:224d:b0:53a:1a81:f006 with SMTP id 2adb3069b0e04-53dd389e4b5mr6965514e87.31.1732597044671;
        Mon, 25 Nov 2024 20:57:24 -0800 (PST)
Received: from elende (elende.valinor.li. [2a01:4f9:6a:1c47::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd9e4ec4fsm1545035e87.165.2024.11.25.20.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 20:57:20 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date: Tue, 26 Nov 2024 05:57:19 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: NFSv4 referrals broken when not enabling junction support
Message-ID: <Z0VVLw9htR7_C5Bc@elende.valinor.li>
References: <Zv7NRNXeUtzpfbJg@eldamar.lan>
 <e7341203-c53c-4005-9d70-239073352b2b@redhat.com>
 <ZxUVlpd0Ec5NaWF1@eldamar.lan>
 <Zxv8GLvNT2sjB2Pn@eldamar.lan>
 <1fc7de18-eaf0-4a1e-bd41-e6072b0f3d7f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fc7de18-eaf0-4a1e-bd41-e6072b0f3d7f@redhat.com>

Hi Steve,

On Sat, Oct 26, 2024 at 09:04:01AM -0400, Steve Dickson wrote:
> 
> 
> On 10/25/24 4:14 PM, Salvatore Bonaccorso wrote:
> > Hi Steve,
> > 
> > On Sun, Oct 20, 2024 at 04:37:10PM +0200, Salvatore Bonaccorso wrote:
> > > Hi Steve,
> > > 
> > > On Tue, Oct 08, 2024 at 06:12:58AM -0400, Steve Dickson wrote:
> > > > 
> > > > 
> > > > On 10/3/24 12:58 PM, Salvatore Bonaccorso wrote:
> > > > > Hi Steve, hi linux-nfs people,
> > > > > 
> > > > > it got reported twice in Debian that  NFSv4 referrals are broken when
> > > > > junction support is disabled. The two reports are at:
> > > > > 
> > > > > https://bugs.debian.org/1035908
> > > > > https://bugs.debian.org/1083098
> > > > > 
> > > > > While arguably having junction support seems to be the preferred
> > > > > option, the bug (or maybe unintended behaviour) arises when junction
> > > > > support is not enabled (this for instance is the case in the Debian
> > > > > stable/bookworm version, as we cannot simply do such changes in a
> > > > > stable release; note later relases will have it enabled).
> > > > > 
> > > > > The "breakage" seems to be introduced with 15dc0bead10d ("exportd:
> > > > > Moved cache upcalls routines  into libexport.a"), so
> > > > > nfs-utils-2-5-3-rc6 as this will mask behind the #ifdef
> > > > > HAVE_JUNCTION_SUPPORT's code which seems needed to support the refer=
> > > > > in /etc/exports.
> > > > > 
> > > > > I had a quick conversation with Cuck offliste about this, and I can
> > > > > hopefully state with his word, that yes, while nfsref is the direction
> > > > > we want to go, we do not want to actually disable refer= in
> > > > > /etc/exports.
> > > > +1
> > > > 
> > > > > 
> > > > > Steve, what do you think? I'm not sure on the best patch for this,
> > > > > maybe reverting the parts masking behind #ifdef HAVE_JUNCTION_SUPPORT
> > > > > which are touched in 15dc0bead10d would be enough?
> > > > Yeah there is a lot of change with 15dc0bead10d
> > > > 
> > > > Let me look into this... At the up coming Bake-a-ton [1]
> > > 
> > > Thanks a lot for that, looking forward then to a fix which we might
> > > backport in Debian to the older version as well.
> > 
> > Hope the Bake-a-ton was productive :)
> > 
> > Did you had a chance to look at this issue beeing there?
> Yes I did... and we did talk about the problem.... still looking into it.

Reviewing the open bugs in Debian I remembered of this one. If you
have already a POC implementation/bugfix available, would it help if I
prod at least the two reporters in Debian to test the changes?

Thanks a lot for your work, it is really appreciated!

Regards,
Salvatore

