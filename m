Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5906285CA
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Nov 2022 17:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237925AbiKNQpc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Nov 2022 11:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237916AbiKNQpb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Nov 2022 11:45:31 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09ECB2F014
        for <linux-nfs@vger.kernel.org>; Mon, 14 Nov 2022 08:45:30 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id f5so29799915ejc.5
        for <linux-nfs@vger.kernel.org>; Mon, 14 Nov 2022 08:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gUtp54e/i/II0/FPwtiYeNxfg5dd11oGODd60vKnP9M=;
        b=TFYxaM24ougdCUEd2iPb4FjagUVhoONbw49WO9uNtaPvT16B5ie6m+AnZI2x0OirWP
         XWjp8nKPnTAEUcPdXWRkXDU0qNwPQJAHciSsaxD3Kw3v8lkyNJmLimNGffOhyUw9wbXe
         HTMouhGiYL/U0Erf1N0VUgRXxE0MgsJZe7gXHZ4Jt6r0YeZe7l564nuItTCJ1xjpGaE1
         o5zoVyhLLyhVHEaEpNG8W4Hhm6Yc47a16EqygbbnnRbuBlu7DyoZ5zc4abECMBRGv802
         tkEwJtCF8yzOdZRSA+Bk9XJxnzGh/NjvHnwB++Gtl3CBhSm8q6kPjFRUdaF9UeSL4L3U
         KEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUtp54e/i/II0/FPwtiYeNxfg5dd11oGODd60vKnP9M=;
        b=iqbRIxNrhb8fzFtoofFWzq+/AmrPtVgtT+EkUUYqGpBk/1TG9LnqTnE3QmfZ1Wt8bC
         S6A9Kyvglym8E2ad0rIx6eIBfZKb7J+Bfai0HKHrbMulyG8ye2jK1v6/qkJEZElpvvSg
         MQHXb3dPd9tXTP865yzccr+LRA8hHXOQFMahv1QhcTLOS0JLlj04sBU/wA3crYyLCQcO
         EbtG40ARa4fn1L4F/lwqGd+ZKRXjH12g6sGlpF08icHdCN2muAcfTs1MR1eJj6touJA9
         WpUZUFspdYE3m6phvIxu4DCtMyzacOFf7QAyx2TCFEeEXRIp8NERpYIwYyyr7M/4z8Pq
         n7lg==
X-Gm-Message-State: ANoB5pmaZzrbLC8D8TshehvE7Ejt0G6vdhiqdNGlvB0zhgtWztHSX4pb
        tgiRkItsWcpTpmJxP/idDD6VpLzdbsbn4A==
X-Google-Smtp-Source: AA0mqf4mW8vwV0kOFeB1wppT0rSqAG7NIRfjRlJ436QStAN4B2OGUZ/yeknoCJZPT4IzZNjz/Jy7QA==
X-Received: by 2002:a17:906:cc85:b0:7ad:ac42:f5e8 with SMTP id oq5-20020a170906cc8500b007adac42f5e8mr10982161ejb.288.1668444328427;
        Mon, 14 Nov 2022 08:45:28 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id c12-20020a0564021f8c00b0045b910b0542sm5014007edc.15.2022.11.14.08.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 08:45:27 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id E8004BE2DE0; Mon, 14 Nov 2022 17:45:26 +0100 (CET)
Date:   Mon, 14 Nov 2022 17:45:26 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: systemd/50-nfs.conf and interoperability issue with
 intramfs-tools not including sunrpc into initrd
Message-ID: <Y3Jwpr3394H2zwOp@eldamar.lan>
References: <Y1KoKwu88PulcokW@eldamar.lan>
 <166656275785.12462.14027406790454668194@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166656275785.12462.14027406790454668194@noble.neil.brown.name>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

Thank you for this positive answer! Yes, I have asked affected persons
if they can help contribute to this and submit it upstream.

The specfic bug in Debian for nfs-utils in Debian is now
https://bugs.debian.org/1024082

Regards,
Salvatore
