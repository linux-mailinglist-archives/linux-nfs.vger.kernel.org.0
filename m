Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0275401FE7
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Sep 2021 20:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhIFSvq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Sep 2021 14:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhIFSvq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Sep 2021 14:51:46 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DBDC061575
        for <linux-nfs@vger.kernel.org>; Mon,  6 Sep 2021 11:50:40 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id x6so11008668wrv.13
        for <linux-nfs@vger.kernel.org>; Mon, 06 Sep 2021 11:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KfIILoRNTKdE2jiXTQNaB/hL5BK+q1ChIb60zRm/Jzc=;
        b=bB62f5tEtkpiPC6yHoZzauBBasVjK6sY6ocV89vOxLSA5OF90pCYrm0V6iNo3Epazn
         B4UV1f921soAGwG1EBPW3OH1YfwqzXaFe2gf/syolwhq/ZLcOpiMTyX6tWlZ7V9vX+uC
         2Z4JhFwwslCMEcceeLPgRptRTCJZgnxyw61Em0ygE/nRFO2zXXG+F7TC40BAQ/0DzOJj
         eQkRJJIn5Y9v0PjQvd3p8EYaJhZzyj+kIk1Nje3YkrZG885ub4Xh7Ld7indEpqmaygE4
         6aSCyhTPrYGBK/QGqNe9h9BLq/S7egDLRfnFk9BmH7041GmH2WXZr4HDYWBXzfrKwYsr
         0IIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=KfIILoRNTKdE2jiXTQNaB/hL5BK+q1ChIb60zRm/Jzc=;
        b=jN3ZP11BVSCZAypT7ycrhkGKlbsrPK7mU3/c626aHj5LUVtmI/3X53OAT3eejXXfLX
         Xk6WzK4TojoHLOU5YNAOdJt8gSnsraLCFCOJKOAnu1EI5jEtdtqCYfdOqa88xUTGIBQb
         WldHSF4y8XH8kiousvsCJED9+WVMMCkxHGg7QCssyuMT9NxiNxXe/Aeu+Ja5iaUjjSB1
         Ka9laLLpIKSlT/BslMqmaSgeHpgwrzQbT5zIxWOLtjH4dkM7mtNYb6MMZMzfdZMlVGtB
         kixvfrySxpN2/TlWJYZ8ArbzbrTBbTkf08tGI+ERfs3g5/E/G8rQxOQtBf49TqLWBa+b
         WpQw==
X-Gm-Message-State: AOAM531rPO7bzHQokU1ifSsm7ONzInIbKYdtsmEjeBDlFuFkMkpBgdb1
        XghQ6a1EakuqT4LKtKzhXjU=
X-Google-Smtp-Source: ABdhPJzMuyAGZljRayTcjBLbaUXq+P7e9ha3FMrVWgvO/jkEuyNCceVYsCaeosiGFHXy0Pe1s3nY2g==
X-Received: by 2002:a05:6000:344:: with SMTP id e4mr15415802wre.423.1630954239403;
        Mon, 06 Sep 2021 11:50:39 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id f3sm272803wmj.28.2021.09.06.11.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:50:38 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Mon, 6 Sep 2021 20:50:37 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     linux-nfs@vger.kernel.org
Cc:     NeilBrown <neilb@suse.de>, Scott Mayhew <smayhew@redhat.com>,
        Steve Dickson <steved@redhat.com>
Subject: Re: [PATCH 0/2] Allow to to install systemd generators dependend on
 --with-systemd unit-dir-path location
Message-ID: <YTZi/Wm3+Bcpk6rp@eldamar.lan>
References: <20200628191002.136918-1-carnil@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628191002.136918-1-carnil@debian.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

On Sun, Jun 28, 2020 at 09:10:00PM +0200, Salvatore Bonaccorso wrote:
> Currently --with-systemd=unit-dir-path would be ignored to install the
> systemd generators and they are unconditionally installed in
> /usr/lib/systemd/system-generators . Distributions installing systemd
> unit files in /lib/systemd/system would though install the
> systemd-generators in /lib/systemd/system-generators.
> 
> Make the installation of the systemd unit generators relative depending
> on the unit-dir-path passed for --with-systemd.
> 
> Salvatore Bonaccorso (2):
>   systemd/Makefile: Drop exlicit setting of unit_dir
>   systemd generators: Install depending on location for systemd unit
>     files
> 
>  systemd/Makefile.am | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

is this something we could have applied or is there something wrong
with the patches which I should fix first?

Regards,
Salvatore
