Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDE627DEEA
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Sep 2020 05:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgI3DVF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Sep 2020 23:21:05 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40812 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgI3DVF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Sep 2020 23:21:05 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08U3A5r4122597;
        Wed, 30 Sep 2020 03:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : cc : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=/6GxIS+p+XvN2S+2JJd5NFKeOTfk94TaNrSLKju43Vw=;
 b=ITblcg+ukTjeQMYOwSBIhRoLYmwGbg/akVXhXes3X12owMLE7k/EUIl2cp4YKeJYFX4L
 SNloVm1FgdRwk9IbcCWBQ2GHyTvku0bPw82aSnYI1e1qBtv3w5uf+v4mfdY/7E6MXrgY
 FG5ELrZ2aE7lDIrCFfQB81nNQ1ES4sbwCw7GDu7ATgs4ryTg7t79HRIOE3MFAnPc7keX
 3vTnOcvMyVyxQX55E9efkIBiNwR79LJz7PNiIwS58TlEnbOCO/dCqIf2mgzHYsnUV3GT
 U9qK14CZhR8tos8BSxign6o6iJmJc+CRppT90WMuJ/0gzj9+OxWzCkjFJ7H7h2Bph8+q Fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 33su5axb9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 03:20:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08U34rBO182689;
        Wed, 30 Sep 2020 03:18:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 33uv2eqtww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 03:18:59 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08U3IthL007933;
        Wed, 30 Sep 2020 03:18:58 GMT
Received: from dhcp-10-154-184-178.vpn.oracle.com (/10.154.184.178)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Sep 2020 20:18:55 -0700
Subject: Re: [PATCH 0/1] NFSv4.2: Fix NFS4ERR_STALE with inter server copy
From:   Dai Ngo <dai.ngo@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
References: <20200923230606.63904-1-dai.ngo@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Message-ID: <e7e738c6-f6e7-0d04-07fa-8017da469b8a@oracle.com>
Date:   Tue, 29 Sep 2020 20:18:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200923230606.63904-1-dai.ngo@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=3 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300022
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=3
 lowpriorityscore=0 spamscore=0 clxscore=1011 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300022
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

Have you had chance to review this patch and if it's ok would it be 
possible to include it in the 5.10 pull?

Thanks,

-Dai

On 9/23/20 4:06 PM, Dai Ngo wrote:
> This patch provides a temporarily relief for inter copy to work with
> some common configs.  For long term solution, I think Trond's suggestion
> of using fs/nfs/nfs_common to store an op table that server can use to
> access the client code is the way to go.
>
>   fs/nfsd/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
>
> Below are the results of my testing of upstream mainline without and with the fix.
>
> Upstream version used for testing:  5.9-rc5
>
> 1. Upstream mainline (existing code: NFS_FS=y)
>
>
> |----------------------------------------------------------------------------------------|
> |  NFSD  |  NFS_FS  |  NFS_V4  |               RESULTS                                   |
> |----------------------------------------------------------------------------------------|
> |   y    |    y     |    m     | Build errors: nfs42_ssc_open/close                      |
> |----------------------------------------------------------------------------------------|
> |   y    |    m     |    m     | Build OK, inter server copy failed with NFS4ERR_STALE   |
> |        |          |          | See NOTE1.                                              |
> |----------------------------------------------------------------------------------------|
> |   y    |    m     |   y (m)  | Build OK, inter server copy failed with NFS4ERR_STALE   |
> |        |          |          | See NOTE2.                                              |
> |----------------------------------------------------------------------------------------|
> |   y    |    y     |    y     | Build OK, inter server copy OK                          |
> |----------------------------------------------------------------------------------------|
>
>
> |----------------------------------------------------------------------------------------|
> |  NFSD  |  NFS_FS  |  NFS_V4  |               RESULTS                                   |
> |----------------------------------------------------------------------------------------|
> |   m    |    y     |    m     | Build OK, inter server copy OK                          |
> |----------------------------------------------------------------------------------------|
> |   m    |    m     |    m     | Build OK, inter server copy failed with NFS4ERR_STALE   |
> |----------------------------------------------------------------------------------------|
> |   m    |    m     |   y (m)  | Build OK, inter server copy failed with NFS4ERR_STALE   |
> |----------------------------------------------------------------------------------------|
> |   m    |    y     |    y     | Build OK, inter server copy OK                          |
> |----------------------------------------------------------------------------------------|
>
> 2. Upstream mainline (with the fix:  !(NFSD=y && (NFS_FS=m || NFS_V4=m))
>
>
> |----------------------------------------------------------------------------------------|
> |  NFSD  |  NFS_FS  |  NFS_V4  |               RESULTS                                   |
> |----------------------------------------------------------------------------------------|
> |   m    |    y     |    m     | Build OK, inter server copy OK                          |
> |----------------------------------------------------------------------------------------|
> |   m    |    m     |    m     | Build OK, inter server copy OK                          |
> |----------------------------------------------------------------------------------------|
> |   m    |    m     |   y (m)  | Build OK, inter server copy OK                          |
> |----------------------------------------------------------------------------------------|
> |   m    |    y     |    y     | Build OK, inter server copy OK                          |
> |----------------------------------------------------------------------------------------|
>
>
> |----------------------------------------------------------------------------------------|
> |  NFSD  |  NFS_FS  |  NFS_V4  |               RESULTS                                   |
> |----------------------------------------------------------------------------------------|
> |   y    |    y     |    m     | Build OK, inter server copy failed with NFS4ERR_STALE   |
> |----------------------------------------------------------------------------------------|
> |   y    |    m     |    m     | Build OK, inter server copy failed with NFS4ERR_STALE   |
> |----------------------------------------------------------------------------------------|
> |   y    |    m     |   y (m)  | Build OK, inter server copy failed with NFS4ERR_STALE   |
> |----------------------------------------------------------------------------------------|
> |   y    |    y     |    y     | Build OK, inter server copy OK                          |
> |----------------------------------------------------------------------------------------|
>
> NOTE1:
> BUG:  When inter server copy fails with NFS4ERR_STALE, it left the file
> created with size of 0!
>
> NOTE2:
> When NFS_V4=y and NFS_FS=m, the build process automatically builds with NFS_V4=m
> and ignores the setting NFS_V4=y in the config file.
>
> This probably due to NFS_V4 in fs/nfs/Kconfig is configured to depend on NFS_FS.
>
