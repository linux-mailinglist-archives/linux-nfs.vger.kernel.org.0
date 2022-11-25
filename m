Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421F3638E4A
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Nov 2022 17:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiKYQfB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Nov 2022 11:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKYQfA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Nov 2022 11:35:00 -0500
X-Greylist: delayed 783 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Nov 2022 08:34:59 PST
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38F5209AB
        for <linux-nfs@vger.kernel.org>; Fri, 25 Nov 2022 08:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SIgayctDiknOripeKawJYn/fHpd29IxwNZyTuVOn53I=; b=nzphFVD9PJuSVIpyEgzH6p6fFm
        +sHzLAEuYc+OXsWTXSm6zWRTK+DocNiVzR98TXKgYjcobWyR7tzvZZb3s5xlPSW/meeKy663BL9WK
        oHroVVkLowSyes+VorEcIBgElNe4RYJ5NC+Sg/VrPe1WTWvwSUaOH3mGfYkcSXC1Nye87CFMfft/d
        AQRkAC+wMuwEjUhOQ62QWE3H/cxhCQ2kkjOR/iS7BRKRXxYQ9LUmbZgOQnqPQiKu17lC/2A7A5ZRI
        AfLcbxoajVU4jb0S6JxO5j1zNli4ltpW10EeTJUxgx0WyJtTDc1htvSQxE1fORDfIkCEFVQT+oLB6
        4JpEjR8g==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <carnil@debian.org>)
        id 1oybSR-003nCM-Fx; Fri, 25 Nov 2022 16:21:43 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
        id ED63CBE2DE0; Fri, 25 Nov 2022 17:21:41 +0100 (CET)
Date:   Fri, 25 Nov 2022 17:21:41 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Michael Prokop <mika@debian.org>
Cc:     NeilBrown <neilb@suse.de>, Steve Dickson <steved@redhat.com>,
        linux-nfs@vger.kernel.org,
        Andras Korn <korn-debbugs@elan.rulez.org>,
        Marco d'Itri <md@linux.it>
Subject: Re: [PATCH 4/4] systemd: Apply all sysctl settings through udev rule
 when NFS-related modules are loaded
Message-ID: <Y4DrlX+oZyjYtrS8@eldamar.lan>
References: <20221125130725.1977606-1-carnil@debian.org>
 <20221125130725.1977606-5-carnil@debian.org>
 <2022-11-25T14-20-47@devnull.michael-prokop.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2022-11-25T14-20-47@devnull.michael-prokop.at>
X-Debian-User: carnil
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Michael,

On Fri, Nov 25, 2022 at 02:29:35PM +0100, Michael Prokop wrote:
> Hi,
> 
> * Salvatore Bonaccorso [Fri Nov 25, 2022 at 02:07:25PM +0100]:
> 
> > sysctl settings (e.g.  /etc/sysctl.conf and others) are normally loaded
> > once at boot.  If the module that implements some settings is no yet
> > loaded, those settings don't get applied.
> > 
> > Various NFS modules support various sysctl settings.  If they are loaded
> > after boot, they miss out.
> > 
> > Add a new udev rule configuration to udev/rules.d/60-nfs.rules to apply
> > the relevant settings when the module is loaded.
> > 
> > Placing it in the systemd directory similarly as the coice for the
> > original commit afc7132dfb21 ("systemd: Apply all sysctl settings when
> > NFS-related modules are loaded").
> [...]
> 
> > --- /dev/null
> > +++ b/systemd/60-nfs.rules
> > @@ -0,0 +1,21 @@
> > +# Ensure all NFS systctl settings get applied when modules load
> > +
> > +# sunrpc module supports "sunrpc.*" sysctls
> > +ACTION=="add", SUBSYSTEM=="module", KERNEL=="sunrpc", \
> > +  RUN+="/sbin/sysctl -q --pattern ^sunrpc --system"
> [...]
> 
> Thanks for taking care of this problem, Salvatore!

Thanks to you for prodding about it, hope to bring the issue bit
forward with the series proposal.

> AFAICT even latest busybox's sysctl does not support the `--pattern`
> option yet:
> 
> | sysctl: unrecognized option '--pattern'
> | BusyBox v1.35.0 (Debian 1:1.35.0-4) multi-call binary.
> | [....]
> 
> So any initramfs that uses busybox and its sysctl (like in Debian)
> and trying to apply above udev rules might fail?

But would this actually be a problem for us here? There is no hook
script which would copy the 60-nfs.rules (not relevant in initrd) to
the initrd. The rule only would apply on module load outside the
initrd.

There is only a subset of rules which would be copied into initrd,
like the ones in hook/udev. But 60-nfs.rules would be specific to
nfs-utils, which does not provide a initramfs-tools hook to include
the rules into initrd.

Now the question you raise, is, do they need to be handled actually
already as well in initrd? You are correct, when handled through the
previous mechanism with modrobe.d configuration, 50-nfs.conf was added
to initramfs:

usr/lib/modprobe.d/50-nfs.conf 

(and causing the issues seen).

Please correct me if I missed something from the picture.

Regards,
Salvatore
