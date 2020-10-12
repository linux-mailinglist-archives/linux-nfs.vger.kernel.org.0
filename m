Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEF728BC99
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Oct 2020 17:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390173AbgJLPmN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Oct 2020 11:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390706AbgJLPmE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Oct 2020 11:42:04 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4252C0613D0
        for <linux-nfs@vger.kernel.org>; Mon, 12 Oct 2020 08:42:04 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k18so17985790wmj.5
        for <linux-nfs@vger.kernel.org>; Mon, 12 Oct 2020 08:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aToOWHUs0J4uG0c//TkJEJf1HhYv3SCoqpzhCNPirQM=;
        b=eOA07KUSKQ2izgPIV6W0Yz9YDD4EHWJOIoIoRDTboXJdTgNMDkEK2q2m1CFcsWFRRT
         TF5kgHsm31a4hatclpgE9Kun4SlW/rNaikVjFnGuS1ys2yyjKjSX4tqdyRUxQutg7JvU
         SlA/AR6AuD8IGZrZec6f2lZ1DL3xhUIxschJhJVXY//VQwUD7Ke2Hs+MnciNWeW913gq
         RLOneW7iLOvU8mQQ9CWWJGwHA3eQWi6/9QJUryhZqtZ4cUUbHFivvhf7jOh+bjPONCBZ
         RwkvIEcEejPp1Pk2VtrFqkfWy+2sYODnsaPIRKdxe/B5U2QnJ5GuP+xD/Keir+EzVhDj
         rZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=aToOWHUs0J4uG0c//TkJEJf1HhYv3SCoqpzhCNPirQM=;
        b=WiLSJH+IBBPsAHuvSiSEoPoEc3w1flmk0MS5B9YD8gMoX2KNuI9NcbPznF6xzXte7G
         xoQgKyqq7B53pDU/32WWn3fb3MErzGMSVUj8b4pS7BD70/p9Y1kRzDGT8rPEMzoaFRAz
         saLvUaJnSN7Eiyy4/2RMdk2dk09Q4T5G0K4on7ipvpRfPT5H5bbKrMBzFvKHSpncF3H5
         u5JpESm3ArNIhwaQlFJvlmHkW83lozhQP68/v1R67QX7/651yM3h2ZFAjauk+8i9c2nU
         alVAeORJX3U+/mrHILsDnhlX/iKQdBoKT+qr0bVI//w7vjwAMCoZnaLyUH3oUZ+dswPB
         msOw==
X-Gm-Message-State: AOAM533Lt54KpULabkHaL17x4D8WRFEE9v4qKVtjugDuEzf0hlNzXvfh
        cLh4zaHxmYZ8ZTmfjMyAgTc=
X-Google-Smtp-Source: ABdhPJxLE1VGTAiK/VH/FxZAzFhrGmAiXDHSCRCzpzjf0TKfMRUfU+sIdvtjsNlC/a5HfdU0uc9dyQ==
X-Received: by 2002:a1c:e256:: with SMTP id z83mr10935833wmg.37.1602517323232;
        Mon, 12 Oct 2020 08:42:03 -0700 (PDT)
Received: from eldamar (host-95-235-240-65.retail.telecomitalia.it. [95.235.240.65])
        by smtp.gmail.com with ESMTPSA id a127sm28847002wmh.13.2020.10.12.08.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 08:42:01 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Mon, 12 Oct 2020 17:41:59 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: Kernel panic / list_add corruption when in nfsd4_run_cb_work
Message-ID: <20201012154159.GA49819@eldamar.lan>
References: <20201011075913.GA8065@eldamar.lan>
 <20201012142602.GD26571@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012142602.GD26571@fieldses.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

Thanks a lot for your reply, much appreciated.

On Mon, Oct 12, 2020 at 10:26:02AM -0400, J. Bruce Fields wrote:
> On Sun, Oct 11, 2020 at 09:59:13AM +0200, Salvatore Bonaccorso wrote:
> > Hi
> > 
> > On a system running 4.19.146-1 in Debian buster an issue got hit,
> > while the server was under some slight load, but it does not seem
> > easily reproducible, so asking if some more information can be
> > provided to track/narrow this down. On the console the following was
> > caught:
> 
> Worth checking git logs of fs/nfsd/nfs4state.c and
> fs/nfsd/nfs4callback.c.  It might be
> 2bbfed98a4d82ac4e7abfcd4eba40bddfc670b1d "nfsd: Fix races between
> nfsd4_cb_release() and nfsd4_shutdown_callback()" ?

That might be possible. As it was not possible to simply trigger the
issue, do you know if it is possible to simply reproduce the issue
fixed in the above?

2bbfed98a4d8 ("nfsd: Fix races between nfsd4_cb_release() and
nfsd4_shutdown_callback()") would be missing in the v4.19.y stable
series (as it was in 5.5-rc1 but not backported to other stable
versions).

Regards,
Salvatore
