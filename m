Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83733833F7
	for <lists+linux-nfs@lfdr.de>; Mon, 17 May 2021 17:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241082AbhEQPEE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 May 2021 11:04:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:50058 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242278AbhEQPCD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 17 May 2021 11:02:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D180AAEBB;
        Mon, 17 May 2021 15:00:45 +0000 (UTC)
Date:   Mon, 17 May 2021 17:00:43 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     NeilBrown <neilb@suse.de>
Cc:     "J . Bruce Fields" <bfields@fieldses.org>,
        linux-nfs@vger.kernel.org, Steve Dickson <steved@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexey Kodanev <alexey.kodanev@oracle.com>
Subject: Re: [PATCH/RFC v2 nfs-utils] Fix NFSv4 export of tmpfs filesystems.
Message-ID: <YKKFG6Osa0BmT6JB@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210422191803.31511-1-pvorel@suse.cz>
 <20210422202334.GB25415@fieldses.org>
 <YILQip3nAxhpXP9+@pevik>
 <162035212343.24322.12361160756597283121@noble.neil.brown.name>
 <162122673178.19062.96081788305923933@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162122673178.19062.96081788305923933@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil,


> Some filesystems cannot be exported without an fsid or uuid.
> tmpfs is the main example.

> When mountd (or exportd) creates nfsv4 pseudo-root exports for the path
> leading down to an export point it exports each directory without any
> fsid or uuid.  If one of these directories is on tmp, that will fail.

> The net result is that exporting a subdirectory of a tmpfs filesystem
> will not work over NFSv4 as the parents within the filesystem cannot be
> exported.  It will either fail, or fall-back to NFSv3 (depending on the
> version of the mount.nfs program).

> To fix this we need to provide an fsid or uuid for these pseudo-root
> exports.  This patch does that by creating an RFC-4122 V5 compatible
> UUID based on an arbitrary seed and the path to the export.

> To check if an export needs a uuid, text_export() is moved from exportfs
> to libexport.a, modified slightly and renamed to export_test().

> Signed-off-by: NeilBrown <neilb@suse.de>
Tested-by: Petr Vorel <pvorel@suse.cz>

tmpfs and btrfs via LTP test nfs01 on openSUSE.

Kind regards,
Petr
