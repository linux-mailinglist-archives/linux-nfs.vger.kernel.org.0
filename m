Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1AF638AEA
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Nov 2022 14:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiKYNLG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Nov 2022 08:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKYNLF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Nov 2022 08:11:05 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CA413DC7
        for <linux-nfs@vger.kernel.org>; Fri, 25 Nov 2022 05:11:03 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id v8so6348585edi.3
        for <linux-nfs@vger.kernel.org>; Fri, 25 Nov 2022 05:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPWgLcVoW7mSmV79kxVMbn6ns7ZiQMRB1KAzmPwnXIc=;
        b=MVOTD6zETFFRE6EFn57sruPEo5gQAXicRVrqF0Aa5MaKhxRPtROAq3rg+Ck8Ds0Iwb
         pUh2zQzN0gDFgyHrehuaSzyWKwx2UOWamwvPA0t7lajIfsGtRSc801bvKVS4LRu+zQ/g
         e569cVkr5c4tohp272HVhqGVCYNWQR8xDM/fLpqIl13fHlEFPcXuhzLiABRNMtvR8ZgY
         SqtiTy9yENSuYF0Gl4+weMGBJaRK5y0l0jwUkujxRAo4b2AQU5mFcgjWjBsoZ6uRalEy
         QMG3RbYcvzsihH5G+xQiNc4x1CPNG32CQ8ol9TLaikdcuKYajZNAegZkyNLhADS7TpRR
         uaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPWgLcVoW7mSmV79kxVMbn6ns7ZiQMRB1KAzmPwnXIc=;
        b=wjj82hIrxZGxOnGTy7T8UO4t1H+oJRGIda02d5ILmXmnlVi0QkcDU+GbdMCrWaPd0C
         FbB4M86yqBCwHD+rBXIb5wd8X4o3HDwZxHAB/hViVYpg6MA2zYLbGFMTT7VnfZ8/5bSB
         Avrk7ibqmuCRgkjJCyoPCHaSm3o4RZo/JGBx+ZKtN9qeSVts4J2p9ofDHmBbwy+m06ax
         BvrmGbZt3S1sAC4Z+zBuFaWJ038nl0p1gEaBs1JGiSQowOQk7CLZQOLbHUNy5ZMlBYSb
         Wo/dC6h5Ht9uxIpnqNibjQwADPDT6/1SevvQ7Oci1MkECkHy0MbUjVDItC/0I6YreOjL
         Mmag==
X-Gm-Message-State: ANoB5pmgX6oHiq4niT2caPJWDab6kHWuMOksCkhiP/nwPGkoXhUQp1pO
        MaOkQr5CCmYk1gn03/HFZ9E=
X-Google-Smtp-Source: AA0mqf6YM+RtlPJmMCoRLmIdWm95JjGT3w7wwze9MeG0Sbz48vr15nvXZTrJ+uVbbAP9iHpVdREXmg==
X-Received: by 2002:a50:bb08:0:b0:469:1684:217d with SMTP id y8-20020a50bb08000000b004691684217dmr24565709ede.270.1669381862233;
        Fri, 25 Nov 2022 05:11:02 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id q25-20020aa7da99000000b0046182b3ad46sm1757205eds.20.2022.11.25.05.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 05:11:01 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id A2865BE2DE0; Fri, 25 Nov 2022 14:11:00 +0100 (CET)
Date:   Fri, 25 Nov 2022 14:11:00 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: systemd/50-nfs.conf and interoperability issue with
 intramfs-tools not including sunrpc into initrd
Message-ID: <Y4C+5DkBXM8+ab2o@eldamar.lan>
References: <Y1KoKwu88PulcokW@eldamar.lan>
 <166656275785.12462.14027406790454668194@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166656275785.12462.14027406790454668194@noble.neil.brown.name>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil,

On Mon, Oct 24, 2022 at 09:05:57AM +1100, NeilBrown wrote:
> On Sat, 22 Oct 2022, Salvatore Bonaccorso wrote:
> > Hi Neil, hi Steve,
> > 
> > In Debian for the update including the systemd/50-nfs.conf there was a
> > report that sunrpc is not included anymore in the initrd through the
> > initramfs-tools hooks. 
> > 
> > The report is at https://bugs.debian.org/1022172
> > 
> > As we would not start to diverge again from nfs-utils upstream and
> > keep in sync with upstream as much as possible I would like to retain
> > whatever is from nfs-utils upstream downstream as well.
> > 
> > Marco d'Intri suggested there three possible solutions, of which one
> > could be done in nfs-utils (whereas the other two are either in kmod
> > upstream or initramfs-tools upstream). The nfs-utils one would be to
> > replace the modprobe configuration with a set of udev rules instead.
> > 
> > What do you think?
> 
> I don't object to nfs-utils being changed to install an appropriate udev
> rules file instead of the modprobe.d file.  Would you be willing to
> develop, test, and post a patch?

I finally managed to work on it, and have posted the series at
https://lore.kernel.org/linux-nfs/20221125130725.1977606-1-carnil@debian.org/T/

Regards,
Salvatore
