Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7D840CC9A
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Sep 2021 20:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhIOSen (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Sep 2021 14:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhIOSem (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Sep 2021 14:34:42 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAF6C061574
        for <linux-nfs@vger.kernel.org>; Wed, 15 Sep 2021 11:33:23 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id CD36E702A; Wed, 15 Sep 2021 14:33:21 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org CD36E702A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1631730801;
        bh=/uGH5fxOasXwnY4crRvnCe5iHw3V+OqXeXKL8byfpe0=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=Jv3shyjSUaVd7b+13EVGCHJ6LcrUPungl+V99LvJUSzkZX1Gvg3xoEFaNy5PnJZN3
         /EGMbYxpimiL/Av87+++Ny5IYcauP3U/IUkyd+jr59rHMVEXy96IyVaaKjyzJ75Crq
         TGgU0k+xHVgxJfx/+qiLIptAKWqlG7kteSnjCSYM=
Date:   Wed, 15 Sep 2021 14:33:21 -0400
To:     Helge Kreutzmann <debian@helgefjell.de>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: Errors in NFS man pages
Message-ID: <20210915183321.GA10712@fieldses.org>
References: <20210912060745.GA26295@Debian-50-lenny-64-minimal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210912060745.GA26295@Debian-50-lenny-64-minimal>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Sep 12, 2021 at 08:07:46AM +0200, Helge Kreutzmann wrote:
> Dear NFS maintainer,
> the manpage-l10n project maintains a large number of translations of
> man pages both from a large variety of sources (including NFS) as
> well for a large variety of target languages.
> 
> During their work translators notice different possible issues in the
> original (english) man pages. Sometimes this is a straightforward
> typo, sometimes a hard to read sentence, sometimes this is a
> convention not held up and sometimes we simply do not understand the
> original.
> 
> We use several distributions as sources and update regularly (at
> least every 2 month). This means we are fairly recent (some
> distributions like archlinux also update frequently) but might miss
> the latest upstream version once in a while, so the error might be
> already fixed. We apologize and ask you to close the issue immediately
> if this should be the case, but given the huge volume of projects and
> the very limited number of volunteers we are not able to double check
> each and every issue.
> 
> Secondly we translators see the manpages in the neutral po format,
> i.e. converted and harmonized, but not the original source (be it man,
> groff, xml or other). So we cannot provide a true patch (where
> possible), but only an approximation which you need to convert into
> your source format.
> 
> Finally the issues I'm reporting have accumulated over time and are
> not always discovered by me, so sometimes my description of the
> problem my be a bit limited - do not hesitate to ask so we can clarify
> them.
> 
> I'm now reporting the errors for your project. I'm not repeating the
> errors reported 2020-05-16, 2021-05-29, if you would like a full
> report, please let me know. If future reports should use another
> channel, please let me know as well.

This is probably fine.

But if it's possible to make these into patches against nfs-utils
(http://git.linux-nfs.org/?p=steved/nfs-utils.git;a=summary), and send
them to steved@redhat.com, cc'd to this list--that would probably get
the fastest response.

--b.

> 
> 
> Man page: nfs.5
> Issue: B<nfsmount.conf(5)> → B<nfsmount.conf>(5)
> 
> "If the mount command is configured to do so, all of the mount options "
> "described in the previous section can also be configured in the I</etc/"
> "nfsmount.conf> file. See B<nfsmount.conf(5)> for details."
> msgstr ""
> "Falls der Befehl »mount« entsprechend konfiguriert ist, können alle in den "
> "vorhergehenden Kapiteln beschriebenen Einhängeoptionen auch in der Datei I</"
> --
> Man page: nfs.5
> Issue: Why is the word "option" in bold?
> 
> "The B<sloppy> option is an alternative to specifying B<mount.nfs> -s "
> "B<option.>"
> 
> -- 
>       Dr. Helge Kreutzmann                     debian@helgefjell.de
>            Dipl.-Phys.                   http://www.helgefjell.de/debian.php
>         64bit GNU powered                     gpg signed mail preferred
>            Help keep free software "libre": http://www.ffii.de/


