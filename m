Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079E1323BA9
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Feb 2021 12:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbhBXL4D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Feb 2021 06:56:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55427 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235188AbhBXLzU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Feb 2021 06:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614167633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rL0rqJykzi+068H31HVXzImuu55OZFksWorJVNSie2w=;
        b=fR/yDIqRTkiFGb6NTOsVr1uAvTHpDhEa2l9JWuPh5aEhi9zZ7Zdf8iyVFvTfh2mBaI/KSe
        788/Su/JUOZ775XEmMexbTHJ2XwtEhHBtCOhcos1sug8GarKBvxhO580XZMRejwpfxo5Av
        uzmwbhxsSb/HBMlb7zJTPQwS8Y2Us8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-f_kFJMjjM8aoNLA5ErJwfQ-1; Wed, 24 Feb 2021 06:53:48 -0500
X-MC-Unique: f_kFJMjjM8aoNLA5ErJwfQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EB0A18B6142;
        Wed, 24 Feb 2021 11:53:42 +0000 (UTC)
Received: from localhost (ovpn-115-137.ams2.redhat.com [10.36.115.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A20EE10016F0;
        Wed, 24 Feb 2021 11:53:30 +0000 (UTC)
Date:   Wed, 24 Feb 2021 11:53:29 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-ide@vger.kernel.org, linux-mmc@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com, axboe@kernel.dk,
        fujita.tomonori@lab.ntt.co.jp, tim@cyberelk.net, mst@redhat.com,
        jasowang@redhat.com, pbonzini@redhat.com, davem@davemloft.net,
        bp@alien8.de, agk@redhat.com, snitzer@redhat.com,
        ulf.hansson@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, dgilbert@interlog.com,
        Kai.Makisara@kolumbus.fi, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bfields@fieldses.org, chuck.lever@oracle.com,
        baolin.wang@linaro.org, vbadigan@codeaurora.org, zliua@micron.com,
        richard.peng@oppo.com, guoqing.jiang@cloud.ionos.com,
        stanley.chu@mediatek.com, cang@codeaurora.org,
        asutoshd@codeaurora.org, beanhuo@micron.com, jaegeuk@kernel.org
Subject: Re: [RFC PATCH] blk-core: remove blk_put_request()
Message-ID: <YDY+ObNNiBMMuSEt@stefanha-x1.localdomain>
References: <20210222211115.30416-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nED3gpEEOc5iD8Dg"
Content-Disposition: inline
In-Reply-To: <20210222211115.30416-1-chaitanya.kulkarni@wdc.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--nED3gpEEOc5iD8Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 22, 2021 at 01:11:15PM -0800, Chaitanya Kulkarni wrote:
> The function blk_put_request() is just a wrapper to
> blk_mq_free_request(), remove the unnecessary wrapper.
>=20
> Any feedback is welcome on this RFC.
>=20
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  block/blk-core.c                   |  6 ------
>  block/blk-merge.c                  |  2 +-
>  block/bsg-lib.c                    |  4 ++--
>  block/bsg.c                        |  4 ++--
>  block/scsi_ioctl.c                 |  6 +++---
>  drivers/block/paride/pd.c          |  2 +-
>  drivers/block/pktcdvd.c            |  2 +-
>  drivers/block/virtio_blk.c         |  2 +-
>  drivers/cdrom/cdrom.c              |  4 ++--
>  drivers/ide/ide-atapi.c            |  2 +-
>  drivers/ide/ide-cd.c               |  4 ++--
>  drivers/ide/ide-cd_ioctl.c         |  2 +-
>  drivers/ide/ide-devsets.c          |  2 +-
>  drivers/ide/ide-disk.c             |  2 +-
>  drivers/ide/ide-ioctls.c           |  4 ++--
>  drivers/ide/ide-park.c             |  2 +-
>  drivers/ide/ide-pm.c               |  4 ++--
>  drivers/ide/ide-tape.c             |  2 +-
>  drivers/ide/ide-taskfile.c         |  2 +-
>  drivers/md/dm-mpath.c              |  2 +-
>  drivers/mmc/core/block.c           | 10 +++++-----
>  drivers/scsi/scsi_error.c          |  2 +-
>  drivers/scsi/scsi_lib.c            |  2 +-
>  drivers/scsi/sg.c                  |  6 +++---
>  drivers/scsi/st.c                  |  4 ++--
>  drivers/scsi/ufs/ufshcd.c          |  6 +++---
>  drivers/target/target_core_pscsi.c |  4 ++--
>  fs/nfsd/blocklayout.c              |  4 ++--
>  include/linux/blkdev.h             |  1 -
>  29 files changed, 46 insertions(+), 53 deletions(-)
>=20
> diff --git a/block/blk-core.c b/block/blk-core.c
> index fc60ff208497..1754f5e7cc80 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -642,12 +642,6 @@ struct request *blk_get_request(struct request_queue=
 *q, unsigned int op,
>  }
>  EXPORT_SYMBOL(blk_get_request);
> =20
> -void blk_put_request(struct request *req)
> -{
> -	blk_mq_free_request(req);
> -}
> -EXPORT_SYMBOL(blk_put_request);

blk_get_request() still exists after this patch. A "get" API usually has
a corresponding "put" API. I'm not sure this patch helps the consistency
and clarity of the code.

If you do go ahead, please update the blk_get_request() doc comment
explicitly mentioning that blk_mq_free_request() needs to be called.

Stefan

--nED3gpEEOc5iD8Dg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmA2PjkACgkQnKSrs4Gr
c8hCowf/apCHcJenx6DM1jzpYo1NNnpfJb2nifukyVLP2UVasntjvQM1WD7v1t84
WZMQu4BXSLlqhke4oxGQpx0/dNYaC3vi0/XB4yedtojqiAeLYqUgZf17ZDRybfvo
o0JmcTVjGtEm48hmt4kulUe9VTeIBaMh8c+IkEjxAEjFN45LgERG9YKRDdTVDCIg
ozqQR2DJJDN7ND80Mu397WnT32WJAJnpU5fLYIKrp8Y3ZINRly5h9F6rn87RmbHq
KdfZiGjiKMHIOnF1hP1oXi+a9xckj9US9MbvSBiMovQhs5zxuI0hBnpmsO1J6Pnl
6OYJzeRg/xtmqSUt8yY53YS9Hur9zg==
=4OR2
-----END PGP SIGNATURE-----

--nED3gpEEOc5iD8Dg--

