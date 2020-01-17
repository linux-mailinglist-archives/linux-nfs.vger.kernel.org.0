Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0264140CD2
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2020 15:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgAQOlA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jan 2020 09:41:00 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:35617 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgAQOlA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jan 2020 09:41:00 -0500
Received: by mail-ed1-f53.google.com with SMTP id f8so22471359edv.2;
        Fri, 17 Jan 2020 06:40:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zZZmY0NZ3nanY6CGdzdqm2nKvibS1y2WTEksvVBINsU=;
        b=ORPYWl4Alpo0D3rQ+zllFO3XnYzaYYFfHAhWYm7s8aCQBnPD/dtFJgFatljIhc0Rd8
         HxaSZxMm1SChJsu9DbaRuggA396n2mRW6FFABh23rfJkegvYbb/tr+xROxI7JASeogqn
         f7nCYCv3FmJxzVk8D736OAx7OiAN1w+6/b0FuoLmVM6lg2lDtzQtlgsj8nH9D5AqNz6f
         3JXFCZwtiZXILDH7cYqKk7XaiahzQJgtUy4oL+4Mk2bQAVPtdV3qHrVl8WUNFhEKb17h
         dM40XP2DHxUb8UI0KtSpTDyeqqUtEv/LfauUYby1btl9cP4e46zJ35NwZYxjdbc/JDOM
         XtqQ==
X-Gm-Message-State: APjAAAWxZcuS5GaQO7cODWokEd54TYVkYFmmNQLnl/kZE4UUhlkAJggE
        9a7k3ZssK0j76gpBnspISJw=
X-Google-Smtp-Source: APXvYqzZN50BtBL4RQAnyEs0TAHFK7BksaR7zBONsz127LnEq/RN5u+Qb6ureyTb1eyfPaJsg1y4SQ==
X-Received: by 2002:a17:906:4d46:: with SMTP id b6mr8091781ejv.79.1579272058266;
        Fri, 17 Jan 2020 06:40:58 -0800 (PST)
Received: from pi3 ([194.230.155.229])
        by smtp.googlemail.com with ESMTPSA id qh19sm901583ejb.55.2020.01.17.06.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 06:40:57 -0800 (PST)
Date:   Fri, 17 Jan 2020 15:40:55 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Scott Mayhew <smayhew@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [BISECT BUG] NFS v4 root not working after 6d972518b821 ("NFS:
 Add fs_context support.")
Message-ID: <20200117144055.GB3215@pi3>
References: <CAJKOXPeCVwZfBsCVbc9RQUGi0UfWQw0uFamPiQasiO8fSthFsQ@mail.gmail.com>
 <433863.1579270803@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <433863.1579270803@warthog.procyon.org.uk>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 17, 2020 at 02:20:03PM +0000, David Howells wrote:
> You seem to be running afoul of the check here:
> 
> 	case Opt_minorversion:
> 		if (result.uint_32 > NFS4_MAX_MINOR_VERSION)
> 			goto out_of_bounds;
> 		ctx->minorversion = result.uint_32;
> 		break;
> 
> which would seem to indicate that the mount process is supplying
> minorversion=X as an option.  Can you modify your kernel to print param->key
> and param->string at the top of nfs_fs_context_parse_param()?  Adding
> something like:
> 
> 	pr_notice("NFSOP '%s=%s'\n", param->key, param->string);
> 
> will likely suffice unless you're directly driving the new mount API - in
> which case param->string might be things other than a string, but that's
> unlikely.  It might also be NULL, but printk should handle that.

The output:

NFS-Mount: 192.168.1.10:/srv/nfs/odroidhc1
Waiting 10 seconds for device /dev/nfs ...
[   14.652366] random: crng init done
Mount cmd:
mount.nfs4 -o vers=4,nolock 192.168.1.10:/srv/nfs/odroidhc1 /new_root
[   22.938314] NFSOP 'source=192.168.1.10:/srv/nfs/odroidhc1'
[   22.942638] NFSOP 'nolock=(null)'
[   22.945772] NFSOP 'vers=4.2'
[   22.948660] NFSOP 'addr=192.168.1.10'
[   22.952350] NFSOP 'clientaddr=192.168.1.12'
[   22.956831] NFS4: Couldn't follow remote path
[   22.971001] NFSOP 'source=192.168.1.10:/srv/nfs/odroidhc1'
[   22.975217] NFSOP 'nolock=(null)'
[   22.978444] NFSOP 'vers=4'
[   22.981265] NFSOP 'minorversion=1'
[   22.984513] NFS: Value for 'minorversion' out of range
mount.nfs4: Numerical result out of range
:: running cleanup hook [udev]
ERROR: Failed to mount the real root device.
Bailing out, you are on your own. Good luck.

sh: can't access tty; job control turned off

Best regards,
Krzysztof

