Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58A6214670
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jul 2020 16:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgGDOc2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 4 Jul 2020 10:32:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55042 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgGDOc2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 4 Jul 2020 10:32:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 064EVpVH051319;
        Sat, 4 Jul 2020 14:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=uwno+wI0n0oHr52wq1fTHU6+l8fUNz/w+1c9GngOtdk=;
 b=kY/j/x3yrywAnc7Z+wVTBjaRvHj+fzHAZML+GGtdtiHyicG83laFxwyqbh1e2p8cEICU
 C/LPPeqWFDkpAREQHeMrbMyUnnIyVF8STz3A6rQ5oOoxFEu1wAc7WlvI0IBNQMUUN5mQ
 Y7yQrrpOFccHSf/sO+RXxT7k6pFpE7ocWf4Ppeir62JO8IqA6kITlyoHnw6vmyvGyNEW
 rzTuYGOySeRRO0FYxg+WErBLGB/tVOa3HZDLGuMGWk9epOTDP5BgjMq42h4LoWI5Ru4X
 OJW9bhCxyN2HksRH1vTt5tBLkPVUba+Tk5MmRMjUnjX7aF5yBlVli349EXPBrkvhOxJ5 tA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 322h6r14ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 04 Jul 2020 14:31:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 064ET1Cw101644;
        Sat, 4 Jul 2020 14:31:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 322jj9r060-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 04 Jul 2020 14:31:50 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 064EVlo2022932;
        Sat, 4 Jul 2020 14:31:48 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 04 Jul 2020 07:31:47 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH] nfsd: Use seq_putc() in two functions
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200618015613.17806-1-vulab@iscas.ac.cn>
Date:   Sat, 4 Jul 2020 10:31:46 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E1D55112-90D0-4B1E-AB57-74F2C782F973@oracle.com>
References: <20200618015613.17806-1-vulab@iscas.ac.cn>
To:     Xu Wang <vulab@iscas.ac.cn>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9671 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=18 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007040104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9671 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=18 adultscore=0 mlxscore=0 spamscore=0 impostorscore=0
 cotscore=-2147483648 malwarescore=0 mlxlogscore=999 clxscore=1011
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007040105
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

> On Jun 17, 2020, at 9:56 PM, Xu Wang <vulab@iscas.ac.cn> wrote:
>=20
> A single character (line break) should be put into a sequence.
> Thus use the corresponding function "seq_putc()".
>=20
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Applied to nfsd-5.9. Thanks.


> ---
> fs/nfsd/nfs4idmap.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
> index 9460be8a8321..f92161ce1f97 100644
> --- a/fs/nfsd/nfs4idmap.c
> +++ b/fs/nfsd/nfs4idmap.c
> @@ -168,7 +168,7 @@ idtoname_show(struct seq_file *m, struct =
cache_detail *cd, struct cache_head *h)
> 			ent->id);
> 	if (test_bit(CACHE_VALID, &h->flags))
> 		seq_printf(m, " %s", ent->name);
> -	seq_printf(m, "\n");
> +	seq_putc(m, '\n');
> 	return 0;
> }
>=20
> @@ -346,7 +346,7 @@ nametoid_show(struct seq_file *m, struct =
cache_detail *cd, struct cache_head *h)
> 			ent->name);
> 	if (test_bit(CACHE_VALID, &h->flags))
> 		seq_printf(m, " %u", ent->id);
> -	seq_printf(m, "\n");
> +	seq_putc(m, '\n');
> 	return 0;
> }
>=20
> --=20
> 2.17.1
>=20

--
Chuck Lever



