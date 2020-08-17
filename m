Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32DE246EAF
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Aug 2020 19:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgHQRfA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Aug 2020 13:35:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40876 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbgHQRe4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Aug 2020 13:34:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07HHWAc0010080;
        Mon, 17 Aug 2020 17:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=uRZfGyNcH1mRTBQ0EADaPl9oEsia1jJQyhRFSspY/NI=;
 b=in2NhKQu1wjrx0cKgzZdj7MOzwJJYqKBPT2po1Tb3fYSpV4PPqjEUTz62y/aBhNRoYK8
 8qGQR07RKOPBJoAzzNfNrnrIxK339DuHWT+rOlpn4iVR5BnbsKYg86NRMv4PCAucltcG
 8ULF0Od8jVP/DN0XG1TuwX3SIcRn9J5RUw4f3vu4cOxp3h/4CcK3Ybqsgd+k6gtko+5h
 KGGpmrlx+atd0FoUHwDqlXbRriTP6+jZDm4HZQ7CCIWbdAPjTSbPm/cU3/CFl453Zyaa
 lB/pP9i63+KNLPcxOHGX+GWl8cezdDAP5J4EURib6AfAKugMVRA8sHzON7iG7sACMgsL vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 32x74r09d8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Aug 2020 17:34:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07HHY81H081318;
        Mon, 17 Aug 2020 17:34:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 32xs9m0g4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Aug 2020 17:34:53 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07HHYqmB010999;
        Mon, 17 Aug 2020 17:34:52 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Aug 2020 10:34:52 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH RFC] xprtrdma: Release in-flight MRs on disconnect
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <159767751439.190071.13659900216337230912.stgit@manet.1015granger.net>
Date:   Mon, 17 Aug 2020 13:34:51 -0400
Cc:     dan@kernelim.com,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <8836EE99-C971-434A-B4A4-C1C4241073BC@oracle.com>
References: <159767751439.190071.13659900216337230912.stgit@manet.1015granger.net>
To:     Anna Schumaker <anna.schumaker@netapp.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008170127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008170127
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Aug 17, 2020, at 11:19 AM, Chuck Lever <chuck.lever@oracle.com> wrote:
> 
> Dan Aloni reports that when a server disconnects abruptly, a few
> memory regions are left DMA mapped. Over time this leak could pin
> enough I/O resources to slow or even deadlock an NFS/RDMA client.
> 
> I found that if a transport disconnects before pending Send and
> FastReg WRs can be posted, the to-be-registered MRs are stranded on
> the req's rl_registered list and never released -- since they
> weren't posted, there's no Send completion to DMA unmap them.
> 
> Reported-by: Dan Aloni <dan@kernelim.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> net/sunrpc/xprtrdma/verbs.c |    2 ++
> 1 file changed, 2 insertions(+)
> 
> Hi Dan, does this help?

Hi Anna, can you grab this for v5.9-rc ?


> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index 95c66a339e34..53962e41896d 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -936,6 +936,8 @@ static void rpcrdma_req_reset(struct rpcrdma_req *req)
> 
> 	rpcrdma_regbuf_dma_unmap(req->rl_sendbuf);
> 	rpcrdma_regbuf_dma_unmap(req->rl_recvbuf);
> +
> +	frwr_reset(req);
> }
> 
> /* ASSUMPTION: the rb_allreqs list is stable for the duration,
> 
> 

--
Chuck Lever



