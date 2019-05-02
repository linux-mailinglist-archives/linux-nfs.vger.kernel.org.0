Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32E8D11320
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2019 08:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfEBGIq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 May 2019 02:08:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43410 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfEBGIp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 May 2019 02:08:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4264cwP036575;
        Thu, 2 May 2019 06:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=8E/Xlfqhfo0vf1+GOu+GJdon4fjnIK8RWeWcR7c5CxQ=;
 b=nR8WtxOm+plPvZHMSK561p3KEYr+W5P6dt5wv8Wdyq6G6c4sXKsJ27dNGyglUgYLlvQw
 TiwiQ/8ArXmSJ9Q7w4ZZqnOHmUKWrMN27w4kkS53VuPtYwVISOfzQg8cxC83uMEFA0AY
 ptwm+dRcbI2QNQ2sKnrVBJjEfy5X3NGrEgla0ZjGVVtT7DkKeko/waa8V/JrixHuQk56
 atmQcJgoSXiGDQebmXLhT1JEYypI7ONEyIAva38jMv4vOxLlwbvrWeL2xYOzmBI9We+P
 Y5PyHQUo4Q4VPRHo3QiEAr7J7oq9mMKN/9QfJgBAmoTHtmy586V2N2g2r6kmRLxrYyyd Xg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2s6xhyecfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 May 2019 06:08:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4266meq072708;
        Thu, 2 May 2019 06:08:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2s6xhgmfew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 May 2019 06:08:31 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4268UcT005438;
        Thu, 2 May 2019 06:08:30 GMT
Received: from [192.168.0.100] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 01 May 2019 23:08:30 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 5/4] 9p: pass the correct prototype to read_cache_page
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190501173443.GA19969@lst.de>
Date:   Thu, 2 May 2019 00:08:29 -0600
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AEBFD2FC-F94A-4E5B-8E1C-76380DDEB46E@oracle.com>
References: <20190501160636.30841-1-hch@lst.de>
 <20190501173443.GA19969@lst.de>
To:     Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9244 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905020048
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9244 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905020048
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

1) You need to pass "filp" rather than "filp->private_data" to =
read_cache_pages()
in v9fs_fid_readpage().

The patched code passes "filp->private_data" as the "data" parameter to
read_cache_pages(), which would generate a call to:

    filler(data, page)

which would become a call to:

static int v9fs_vfs_readpage(struct file *filp, struct page *page)
{=09
        return v9fs_fid_readpage(filp->private_data, page);
}

which would then effectively become:

    v9fs_fid_readpage(filp->private_data->private_data, page)

Which isn't correct; because data is a void *, no error is thrown when
v9fs_vfs_readpages treats filp->private_data as if it is filp.


2) I'd also like to see an explicit comment in do_read_cache_page() =
along
the lines of:

/*
 * If a custom page filler was passed in use it, otherwise use the
 * standard readpage() routine defined for the address_space.
 *
 */

3) Patch 5/4?

Otherwise it looks good.

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

> On May 1, 2019, at 11:34 AM, Christoph Hellwig <hch@lst.de> wrote:
>=20
> Fix the callback 9p passes to read_cache_page to actually have the
> proper type expected.  Casting around function pointers can easily
> hide typing bugs, and defeats control flow protection.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> fs/9p/vfs_addr.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
> index 0bcbcc20f769..02e0fc51401e 100644
> --- a/fs/9p/vfs_addr.c
> +++ b/fs/9p/vfs_addr.c
> @@ -50,8 +50,9 @@
>  * @page: structure to page
>  *
>  */
> -static int v9fs_fid_readpage(struct p9_fid *fid, struct page *page)
> +static int v9fs_fid_readpage(void *data, struct page *page)
> {
> +	struct p9_fid *fid =3D data;
> 	struct inode *inode =3D page->mapping->host;
> 	struct bio_vec bvec =3D {.bv_page =3D page, .bv_len =3D =
PAGE_SIZE};
> 	struct iov_iter to;
> @@ -122,7 +123,8 @@ static int v9fs_vfs_readpages(struct file *filp, =
struct address_space *mapping,
> 	if (ret =3D=3D 0)
> 		return ret;
>=20
> -	ret =3D read_cache_pages(mapping, pages, (void =
*)v9fs_vfs_readpage, filp);
> +	ret =3D read_cache_pages(mapping, pages, v9fs_fid_readpage,
> +			filp->private_data);
> 	p9_debug(P9_DEBUG_VFS, "  =3D %d\n", ret);
> 	return ret;
> }

