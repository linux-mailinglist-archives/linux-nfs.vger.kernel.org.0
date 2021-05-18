Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3323387F09
	for <lists+linux-nfs@lfdr.de>; Tue, 18 May 2021 19:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351188AbhERRzY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 May 2021 13:55:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:39038 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345673AbhERRzY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 18 May 2021 13:55:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 80E4DAD8D;
        Tue, 18 May 2021 17:54:04 +0000 (UTC)
Date:   Tue, 18 May 2021 19:54:02 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     NeilBrown <neilb@suse.de>
Cc:     "J . Bruce Fields" <bfields@fieldses.org>,
        linux-nfs@vger.kernel.org, Steve Dickson <steved@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexey Kodanev <alexey.kodanev@oracle.com>
Subject: Re: [PATCH/RFC v2 nfs-utils] Fix NFSv4 export of tmpfs filesystems.
Message-ID: <YKP/OmXJkh9NJ50E@pevik>
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
                                                   ^ nit: you probably 
												   mean tmpfs

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

Reported-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

LGTM, thanks for fixing it.

...
> --- a/support/include/exportfs.h
> +++ b/support/include/exportfs.h
> @@ -173,5 +173,6 @@ struct export_features {
>  struct export_features *get_export_features(void);
>  void fix_pseudoflavor_flags(struct exportent *ep);
>  char *exportent_realpath(struct exportent *eep);
> +int export_test(struct exportent *eep, int with_fsid);

>  #endif /* EXPORTFS_H */
> diff --git a/utils/exportd/Makefile.am b/utils/exportd/Makefile.am
> index eb521f15032d..c95bdee76d3f 100644
> --- a/utils/exportd/Makefile.am
> +++ b/utils/exportd/Makefile.am
> @@ -16,7 +16,7 @@ exportd_SOURCES = exportd.c
>  exportd_LDADD = ../../support/export/libexport.a \
>  			../../support/nfs/libnfs.la \
>  			../../support/misc/libmisc.a \
> -			$(OPTLIBS) $(LIBBLKID) $(LIBPTHREAD) 
> +			$(OPTLIBS) $(LIBBLKID) $(LIBPTHREAD) -luuid
I wonder if configure.ac should have libuuid check as it's now mandatory, e.g.:

AC_CHECK_LIB[uuid], uuid_parse, [LIBUUID="-luuid"], AC_MSG_ERROR([libuuid needed]))

Kind regards,
Petr
