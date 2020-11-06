Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43A02A979D
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Nov 2020 15:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgKFO3Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Nov 2020 09:29:25 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51586 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgKFO3Z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Nov 2020 09:29:25 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A6ENesH021034;
        Fri, 6 Nov 2020 14:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=rUuKUtCppy6N7dcPp/iTA5mbc0TMv6fJgcRziHZpC20=;
 b=Dd39j+/xwBKyq/0IMT/7HHrHUm0IxZv6vO6qJfaG8WUqc0NmWgaB8AjwXX+yjD/c/QYC
 0p+FbiPHjVdS4gpvymVPY1vP+IfLmsvr7l/4aO8JAHLnqIPikqQM7S2/JevA5RI0D79H
 Vc6XhEMMzaSkxw3SNYNTmUAfwkZOwUcyGGVR3V4tn8u8m5AsjJLjcaaa+T1Ap/5B3G5l
 52elooT9ZkmFeTtln+OgnQ75FYzgVq7iZ/m3gxIuztdTknd9OtSRdj8MQ3zOqQD89Ujh
 soipQ4rK7cKM+cOE/Ga68o3QPGqrCxX1S+p+lwjajTuM40I3SFDwi5HXbNalajsNG4i0 nA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34hhb2h5eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 06 Nov 2020 14:29:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A6EOxAE069445;
        Fri, 6 Nov 2020 14:29:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 34jf4e25jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Nov 2020 14:29:16 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A6ETE66006981;
        Fri, 6 Nov 2020 14:29:14 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Nov 2020 06:29:14 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] nfsd/nfs3: remove unused macro nfsd3_fhandleres
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1604641257-6159-1-git-send-email-alex.shi@linux.alibaba.com>
Date:   Fri, 6 Nov 2020 09:29:11 -0500
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <94040377-C2A4-47DF-BBA1-16573F69739D@oracle.com>
References: <1604641257-6159-1-git-send-email-alex.shi@linux.alibaba.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011060104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011060104
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 6, 2020, at 12:40 AM, Alex Shi <alex.shi@linux.alibaba.com> wrote:
> 
> The macro is unused, remove it to tame gcc warning:
> fs/nfsd/nfs3proc.c:702:0: warning: macro "nfsd3_fhandleres" is not used
> [-Wunused-macros]
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: "J. Bruce Fields" <bfields@fieldses.org> 
> Cc: Chuck Lever <chuck.lever@oracle.com> 
> Cc: linux-nfs@vger.kernel.org 
> Cc: linux-kernel@vger.kernel.org 
> ---
> fs/nfsd/nfs3proc.c | 1 -
> 1 file changed, 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index 781e265921aa..6e79bae0af4d 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -687,7 +687,6 @@
> #define nfsd3_mkdirargs			nfsd3_createargs
> #define nfsd3_readdirplusargs		nfsd3_readdirargs
> #define nfsd3_fhandleargs		nfsd_fhandle
> -#define nfsd3_fhandleres		nfsd3_attrstat
> #define nfsd3_attrstatres		nfsd3_attrstat
> #define nfsd3_wccstatres		nfsd3_attrstat
> #define nfsd3_createres			nfsd3_diropres
> -- 
> 1.8.3.1

Applied to cel-next, thanks Alex.

The topic branch that collects patches for nfsd-5.11 is here:

http://git.linux-nfs.org/?p=cel/cel-2.6.git;a=shortlog;h=refs/heads/cel-next


--
Chuck Lever



