Return-Path: <linux-nfs+bounces-6824-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3110098F4AC
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 18:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89BD1F226FF
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 16:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A1B19C542;
	Thu,  3 Oct 2024 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMiC9Gp2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C131527B4
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974729; cv=none; b=Tf01JgojCsk466OBuky6nOaXXfRGnDil2yNQGnP4L0uWRZBQlybVmmnYJVIqjinbF+to/CZLj1AZowTezXSfFFHuUzVU/Sg2csvCteH9HlJYnU0NFzIZW+6Uc4FlEVlfUWXcSLqWmRpHr+WYYeaPX4kyzfuQxxpo4RSzrojY5g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974729; c=relaxed/simple;
	bh=CMuiTC5H01hdnkbxmINifiZwbtiQhPpysX8ERFb5E+o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KbiFhWmv3lewkOq7k/DTwkC4m3mV4v+sshiTi4DTR0J/azp0r3UdSJ7MynYUVUdR18dSiK4O3OLab8qB9wBRdtJXFtCpgA2P0blvaa0WUjwdM0DU/dk8ulIwryURzQFeK/iRiAx/2Ax6hHlt2r5ldzBzIkDShv/5RIg9/BZPR9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMiC9Gp2; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8a789c4fc5so411190966b.0
        for <linux-nfs@vger.kernel.org>; Thu, 03 Oct 2024 09:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727974726; x=1728579526; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KK4CSzsRkcpYWmbpAdpBpm1byODyZ3VfHMHIsF4ny1g=;
        b=CMiC9Gp20+LEkohRrPQVGNXxpEtr06qQiEm2SoPBPjYOeNCcoMmdEOb7mo7PFz+xzx
         5WXfRyDvAkq6+ZWKHOTm4t/28ya/9ZdwWIoJ3cs/YfZmddSxqe5q+bddLKOJzOXkCbFE
         P4KD6jPAEH5FYalRdIE4sJRRG+jvbz8E8IYQMRwcTmhhqJe64aw2qPQfuJkrP/b+0Mn8
         5cuXIKIdoFZCPZOuG2V8FzsaylEH1LlHw0lDt7BiITgUvvkkoivk4H0wyi77QmKLCiu5
         TjYHNwtNRj9xMOBiWcpn6H84g8TUvm/06vR2HR5AtQxt5qGAFMNWsaL5IjClYgWg7gaI
         stug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727974726; x=1728579526;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KK4CSzsRkcpYWmbpAdpBpm1byODyZ3VfHMHIsF4ny1g=;
        b=oTqGp9tqY/uS6xhs4DOB/pMrUQO8sDzAK0AsjudOkbKjkrk4ref8/T3FM/kW7BKIIG
         BEUWi4X91FZNDWFxu4FQtYU7wHypxal36CurqQt8c/J6h4an0skajurqBKubKs1U0xLd
         Vl+Kx+EcXv9M751kM/GDCA5UiTmHtRgMGzRbq9wyhBIW6/P3pF2H5n7Q3HuLx8r7OkkP
         bHAPIw/rkfrYKRzze3TFdZzf1GzbfQgZThK4kEKQsgNsWLrdfuoYmY69PKrowdf3Vp79
         9dxVIJyh6gWeNvDU36Xs+4WMdT3kQ01zQMR2KRlPVvnJh4Xa4HNbpHw3GFPkFKPpE3Qp
         gdnQ==
X-Gm-Message-State: AOJu0YxHLgCFtawnrRGI7JFiw4uxD14vK6Z9nppw0baVY2hT1HRRGoz7
	V7uawPg6yUhLIzlW5l2iravrAPBv8yAzbiV1X3Na0l3KWHek0BEQX1EFaLl5
X-Google-Smtp-Source: AGHT+IEbOJ4HvSXAK9Vrj4JKxqBZg2PttqhhoQAhMArVC0uKleCJ4i6exW0SLjB3TzIIkWaAHrdqQg==
X-Received: by 2002:a17:907:960c:b0:a95:bf6d:9c17 with SMTP id a640c23a62f3a-a990a1da166mr370215366b.31.1727974725789;
        Thu, 03 Oct 2024 09:58:45 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99102a63casm108363266b.80.2024.10.03.09.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 09:58:45 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 410A8BE2DE0; Thu, 03 Oct 2024 18:58:44 +0200 (CEST)
Date: Thu, 3 Oct 2024 18:58:44 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever III <chuck.lever@oracle.com>
Subject: NFSv4 referrals broken when not enabling junction support
Message-ID: <Zv7NRNXeUtzpfbJg@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Steve, hi linux-nfs people,

it got reported twice in Debian that  NFSv4 referrals are broken when
junction support is disabled. The two reports are at:

https://bugs.debian.org/1035908
https://bugs.debian.org/1083098

While arguably having junction support seems to be the preferred
option, the bug (or maybe unintended behaviour) arises when junction
support is not enabled (this for instance is the case in the Debian
stable/bookworm version, as we cannot simply do such changes in a
stable release; note later relases will have it enabled).

The "breakage" seems to be introduced with 15dc0bead10d ("exportd:
Moved cache upcalls routines  into libexport.a"), so
nfs-utils-2-5-3-rc6 as this will mask behind the #ifdef
HAVE_JUNCTION_SUPPORT's code which seems needed to support the refer=
in /etc/exports.

I had a quick conversation with Cuck offliste about this, and I can
hopefully state with his word, that yes, while nfsref is the direction
we want to go, we do not want to actually disable refer= in
/etc/exports.

Steve, what do you think? I'm not sure on the best patch for this,
maybe reverting the parts masking behind #ifdef HAVE_JUNCTION_SUPPORT
which are touched in 15dc0bead10d would be enough?

Thanks a lot already in advance!

Regards,
Salvatore

