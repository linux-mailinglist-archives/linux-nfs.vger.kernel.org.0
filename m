Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 222A0FFB7C
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Nov 2019 20:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfKQTdz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 17 Nov 2019 14:33:55 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50737 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726089AbfKQTdz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 17 Nov 2019 14:33:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574019233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0wV9syliaGhjm+v5v5X2Ua0YgFmXpBiUP3Mze8zna/U=;
        b=g9C5BFFlm+5jE3Cjy3Z99MW6IkcB+Keg/y04DeOL5cR2y2oD/CemxlrbTwgs3RRSCdduVV
        ye8vezowSRW3KP40AapxrTWP4NibTvkwzc5ZbMIBrTU9vYl4k/9qLDiAzcX+A9Ys7PqIQ7
        aO1pJ0Y/VfOeNgcFgMTVPbVoluytoYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-iBqv_diWO9S0g7U8xsM6Tw-1; Sun, 17 Nov 2019 14:33:51 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6EF0800EBA;
        Sun, 17 Nov 2019 19:33:50 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-206.phx2.redhat.com [10.3.116.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 856756016E;
        Sun, 17 Nov 2019 19:33:50 +0000 (UTC)
Subject: Re: [PATCH] Ensure consistent struct stat definition
To:     Doug Nazar <nazard@nazar.ca>, linux-nfs@vger.kernel.org
References: <20191031070355.26471-1-nazard@nazar.ca>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <fb4ee698-164c-df5c-5efe-fe59de1a0177@RedHat.com>
Date:   Sun, 17 Nov 2019 14:33:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191031070355.26471-1-nazard@nazar.ca>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: iBqv_diWO9S0g7U8xsM6Tw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 10/31/19 3:03 AM, Doug Nazar wrote:
> Although 2fbc62e2a13fc ("Fix include order between config.h and stat.h")
> reorganized those files that were already including config.h, not all
> files were including config.h.
>=20
> Fixes at least stack smashing crashes in mountd on 32-bit systems.
>=20
> Signed-off-by: Doug Nazar <nazard@nazar.ca>
> ---
>  support/junction/junction.c | 4 ++++
>  support/misc/file.c         | 4 ++++
>  support/misc/mountpoint.c   | 4 ++++
>  support/nfs/cacheio.c       | 4 ++++
>  utils/mount/fstab.c         | 4 ++++
>  utils/nfsdcld/legacy.c      | 4 ++++
>  6 files changed, 24 insertions(+)
Committed!=20

steved.
>=20
> diff --git a/support/junction/junction.c b/support/junction/junction.c
> index ab6caa61..41cce261 100644
> --- a/support/junction/junction.c
> +++ b/support/junction/junction.c
> @@ -23,6 +23,10 @@
>   *=09http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt
>   */
> =20
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
>  #include <sys/types.h>
>  #include <sys/stat.h>
> =20
> diff --git a/support/misc/file.c b/support/misc/file.c
> index e7c38190..06f6bb2b 100644
> --- a/support/misc/file.c
> +++ b/support/misc/file.c
> @@ -18,6 +18,10 @@
>   * along with nfs-utils.  If not, see <http://www.gnu.org/licenses/>.
>   */
> =20
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
>  #include <sys/stat.h>
> =20
>  #include <string.h>
> diff --git a/support/misc/mountpoint.c b/support/misc/mountpoint.c
> index c6217f24..14d6731d 100644
> --- a/support/misc/mountpoint.c
> +++ b/support/misc/mountpoint.c
> @@ -3,6 +3,10 @@
>   * check if a given path is a mountpoint=20
>   */
> =20
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
>  #include <string.h>
>  #include "xcommon.h"
>  #include <sys/stat.h>
> diff --git a/support/nfs/cacheio.c b/support/nfs/cacheio.c
> index 9dc4cf1c..7c4cf373 100644
> --- a/support/nfs/cacheio.c
> +++ b/support/nfs/cacheio.c
> @@ -15,6 +15,10 @@
>   *
>   */
> =20
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
>  #include <nfslib.h>
>  #include <stdio.h>
>  #include <stdio_ext.h>
> diff --git a/utils/mount/fstab.c b/utils/mount/fstab.c
> index eedbddab..8b0aaf1a 100644
> --- a/utils/mount/fstab.c
> +++ b/utils/mount/fstab.c
> @@ -7,6 +7,10 @@
>   * - Moved code to nfs-utils/support/nfs from util-linux/mount.
>   */
> =20
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
>  #include <errno.h>
>  #include <stdio.h>
>  #include <fcntl.h>
> diff --git a/utils/nfsdcld/legacy.c b/utils/nfsdcld/legacy.c
> index 07f477ab..3c6bea6c 100644
> --- a/utils/nfsdcld/legacy.c
> +++ b/utils/nfsdcld/legacy.c
> @@ -15,6 +15,10 @@
>   * Boston, MA 02110-1301, USA.
>   */
> =20
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
>  #include <stdio.h>
>  #include <dirent.h>
>  #include <string.h>
>=20

